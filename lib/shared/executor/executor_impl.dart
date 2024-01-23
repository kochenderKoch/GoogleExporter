part of 'executor.dart';

/// The `_Executor` class manages the execution of tasks with concurrency control.
/// It allows tasks to be scheduled, run, and controlled with pause and resume capabilities.
/// It also handles rate limiting if a rate is provided.
class _Executor implements Executor {
  /// Constructs an `_Executor` with the given concurrency limit and optional rate limit.
  _Executor(this._concurrency, this._rate) {
    assert(_concurrency > 0, 'Concurrency must be greater than zero.');
  }

  /// The maximum number of concurrent tasks that can be running.
  int _concurrency;

  /// The rate limiting configuration, if any.
  /// This controls how many tasks can be started within a given period.
  Rate? _rate;

  /// The current status of the executor, such as idle or paused.
  @override
  ExecutorStatus status = ExecutorStatus.idle;

  /// A queue of tasks that are waiting to be executed.
  final ListQueue<_Item<Object?>> _waiting = ListQueue<_Item<Object?>>();

  /// A queue of tasks that are currently being executed.
  final ListQueue<_Item<Object?>> _running = ListQueue<_Item<Object?>>();

  /// A queue tracking the start times of the executed tasks for rate limiting.
  final ListQueue<DateTime> _started = ListQueue<DateTime>();

  /// A controller for broadcasting the change events to the listeners.
  final StreamController<dynamic> _onChangeController = StreamController.broadcast();

  /// A flag indicating whether the executor is in the process of closing.
  bool _closing = false;

  /// A timer used for triggering the execution of tasks at a rate-limited pace.
  Timer? _triggerTimer;

  /// Gets the number of currently running tasks.
  @override
  int get runningCount => _running.length;

  /// Gets the number of tasks waiting to be executed.
  @override
  int get waitingCount => _waiting.length;

  /// Gets the total number of tasks that are either running or waiting to be executed.
  @override
  int get scheduledCount => runningCount + waitingCount;

  /// Checks if the executor is in the process of closing.
  bool get isClosing => _closing;

  /// Gets the current concurrency limit.
  @override
  int get concurrency => _concurrency;

  /// Sets a new concurrency limit and triggers task execution if necessary.
  @override
  set concurrency(int value) {
    if (_concurrency == value) return;
    assert(value > 0, 'Concurrency must be greater than zero.');
    _concurrency = value;
    _trigger();
  }

  /// Retrieves the current rate at which tasks are being executed by the `_Executor`.
  ///
  /// This getter method provides access to the executor's current task execution rate setting.
  /// If the rate has been set, it returns the `Rate` object representing the current rate.
  /// If the rate has not been set or was cleared, it returns `null`.
  ///
  /// Accessing this property is useful for checking the current throughput configuration of
  /// the executor, which can influence the performance and resource utilization during task execution.
  ///
  /// The getter overrides a base class property to provide the actual rate value from the
  /// internal state of the `_Executor` class.
  ///
  /// @return The current `Rate` setting, or `null` if no rate has been set.
  @override
  Rate? get rate => _rate;

  /// Updates the rate at which tasks are executed by the `_Executor`.
  ///
  /// This setter method allows the executor's task execution rate to be adjusted dynamically.
  /// If the new rate is different from the current rate, it updates the internal rate setting
  /// and triggers the executor to reevaluate its task scheduling based on the new rate.
  ///
  /// This can be useful for controlling the throughput of the executor in real-time, such as
  /// throttling down during high-load periods or scaling up when resources are available.
  ///
  /// The setter overrides a base class property to provide custom behavior when the rate is changed.
  ///
  /// @param value The new `Rate` value to set, or `null` to clear the current rate setting.
  @override
  set rate(Rate? value) {
    // Check if the new rate is the same as the current rate; if so, do nothing
    if (_rate == value) return;
    // Update the internal rate setting
    _rate = value;
    // Trigger the executor to apply the new rate to its task scheduling
    _trigger();
  }

  /// Schedules a new task to be executed by the `_Executor`.
  /// If the executor is not at its concurrency limit or rate limit, the task starts immediately.
  /// Otherwise, it's placed in the waiting queue.
  ///
  /// The task is represented by a Future which will be completed once the task is run.
  @override
  Future<R> scheduleTask<R>(AsyncTask<R> task) async {
    if (isClosing) throw Exception("Executor doesn't accept  tasks.");
    final item = _Item<R?>();
    _waiting.add(item);
    _trigger();
    await item.trigger.future;
    if (isClosing) {
      item.result.completeError(
        TimeoutException('Executor is closing'),
        Trace.current(1),
      );
    } else {
      try {
        final r = await task();
        item.result.complete(r);
      } catch (e, st) {
        final chain = Chain([Trace.from(st), Trace.current(1)]);
        item.result.completeError(e, chain);
      }
    }
    _running.remove(item);
    _trigger();
    item.done.complete();
    return item.result.future
        // Nullable R is used to allow using catchError with null output, so
        // we must convert R? into R for the caller
        .then((v) => v as R);
  }

  /// Waits for all currently running and optionally waiting tasks to complete.
  ///
  /// This method collects all the futures of running tasks, and if `withWaiting` is set to true,
  /// it also includes the futures of tasks that are waiting to be executed. Each future is
  /// individually wrapped with `catchError` to ensure that even if a task results in an error,
  /// it will not prevent the `join` method from completing. Instead, errors are handled and
  /// result in a `null` value in the resulting list.
  ///
  /// If there are no running or waiting tasks, the method returns immediately with an empty list.
  /// Otherwise, it returns a `Future` that completes with a list of results from all tracked
  /// tasks once they have all completed.
  ///
  /// The `withWaiting` parameter:
  /// - Defaults to `false`, which means only running tasks are waited on.
  /// - When set to `true`, both running and waiting tasks are waited on.
  ///
  /// The method overrides a base class implementation to provide custom joining logic
  /// specific to the `_Executor` class.
  ///
  /// @param withWaiting A boolean indicating whether to wait for tasks that are currently
  ///                    in the waiting queue in addition to the running tasks.
  ///
  /// @return A future that completes with a list of results from the tasks. The list contains
  ///         `null` for any task that encountered an error during execution.
  @override
  Future<List<Object?>> join({bool withWaiting = false}) {
    final futures = <Future<Object?>>[];
    // Collect futures from running tasks
    for (final item in _running) {
      futures.add(item.result.future.catchError((_) async => null));
    }
    // If withWaiting is true, also collect futures from waiting tasks
    if (withWaiting) {
      for (final item in _waiting) {
        futures.add(item.result.future.catchError((_) async => null));
      }
    }
    // If no tasks are running or waiting, return an empty list immediately
    if (futures.isEmpty) return Future.value([]);
    // Wait for all collected futures to complete
    return Future.wait(futures);
  }

  /// Provides a stream of events that indicate changes in the `_Executor`.
  ///
  /// This stream emits events whenever there is a change in the state of tasks within
  /// the executor. Subscribers can listen to this stream to receive notifications about
  /// task lifecycle events such as when a task is scheduled, started, or finished.
  ///
  /// Use this stream to observe the executor's operation and react to its changes in
  /// real-time.
  ///
  /// The getter overrides a base class implementation to provide custom stream logic
  /// specific to the `_Executor` class.
  @override
  Stream<dynamic> get onChange => _onChangeController.stream;

  /// Initiates the shutdown process of the `_Executor`.
  ///
  /// This method sets the executor's internal flag to indicate that it's closing.
  /// It then triggers any remaining tasks to complete if they are not already running.
  /// The method waits for all active and waiting tasks to finish by calling `join`
  /// with `withWaiting: true`, ensuring a graceful shutdown.
  ///
  /// After ensuring all tasks are complete, it cancels any scheduled triggers
  /// and closes the stream controller responsible for task change events.
  ///
  /// This method should be called when the executor is no longer needed and should
  /// clean up its resources. It's an asynchronous operation and returns a Future
  /// that completes once the executor has fully shut down.
  @override
  Future<void> close() async {
    _closing = true;
    _trigger();
    await join(withWaiting: true);
    _triggerTimer?.cancel();
    await _onChangeController.close();
  }

  /// Attempts to execute the next task if the concurrency and rate limits allow.
  /// This method checks the waiting queue for available tasks and moves them to the running queue.
  /// If rate limiting is in place, it schedules the next check according to the rate limit.
  void _trigger() {
    if (status == ExecutorStatus.paused) return;

    _triggerTimer?.cancel();
    _triggerTimer = null;

    while (_running.length < _concurrency && _waiting.isNotEmpty) {
      final rate = _rate;
      if (rate != null) {
        final now = DateTime.now();
        final limitStart = now.subtract(rate.period);
        while (_started.isNotEmpty && _started.first.isBefore(limitStart)) {
          _started.removeFirst();
        }
        if (_started.isNotEmpty) {
          final gap = rate.period ~/ rate.maximum;
          final last = now.difference(_started.last);
          if (gap > last) {
            final diff = gap - last;
            _triggerTimer ??= Timer(diff, _trigger);
            return;
          }
        }
        _started.add(now);
      }

      final item = _waiting.removeFirst();
      _running.add(item);
      item.done.future.whenComplete(() {
        _trigger();
        if (!_closing && _onChangeController.hasListener && !_onChangeController.isClosed) {
          _onChangeController.add(null);
        }
      });
      item.trigger.complete();
    }
  }

  /// Pauses the execution of tasks in the `_Executor`.
  ///
  /// When called, this method sets the executor's status to `ExecutorStatus.paused`,
  /// which prevents any new tasks from starting. Tasks that are currently running
  /// will continue to run until completed.
  ///
  /// To resume task execution, the `resume` method should be called.
  @override
  void pause() {
    status = ExecutorStatus.paused;
  }

  /// Resumes the execution of tasks in the `_Executor`.
  ///
  /// This method changes the executor's status to `ExecutorStatus.running`,
  /// which allows the executor to start processing tasks again. If there are any
  /// tasks waiting to be executed, this method will attempt to trigger their execution.
  ///
  /// This method should be called after the `pause` method has been used to pause the executor,
  /// and when task execution should continue.
  @override
  void resume() {
    status = ExecutorStatus.running;
    _trigger();
  }
}

/// Represents a single task item within the `_Executor`.
///
/// This class encapsulates the lifecycle of a task through three `Completer` objects
/// which represent different stages of the task execution: trigger, result, and completion.
///
/// - `trigger`: Used to initiate the task execution.
/// - `result`: Holds the result of the task once it's completed. It's nullable to handle
///   the cases where the task encounters an error and a result can't be provided.
/// - `done`: Indicates the task has finished its execution, regardless of success or error.
class _Item<R> {
  /// Completer to initiate the execution of the task.
  final trigger = Completer<void>();

  /// Completer to hold the result of the task. It's nullable to account for the possibility
  /// of the task completing with an error, in which case no result would be returned.
  final result = Completer<R?>();

  /// Completer to indicate that the task has finished executing, used to signal completion.
  final done = Completer<void>();
}
