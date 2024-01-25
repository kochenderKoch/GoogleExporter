import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_exporter/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:google_exporter/features/dashboard/presentation/provider/state/dashboard_state.dart';
import 'package:google_exporter/shared/domain/models/notice/notice_model.dart';
import 'package:google_exporter/shared/exceptions/http_exception.dart';

class DashboardNotifier extends StateNotifier<DashboardState> {
  DashboardNotifier(
    this.dashboardRepository,
  ) : super(const DashboardState.initial());
  final DashboardRepository dashboardRepository;

  bool get isFetching => state.state != DashboardConcreteState.loading;

  Future<void> addNotice(Notice newNotice) async {
    final addResponse = await dashboardRepository.addNotice(newNotice);
    addResponse.fold(
      (l) => state = state.copyWith(
        state: DashboardConcreteState.failure,
        message: l.message,
        isLoading: false,
      ),
      (r) => state = state.copyWith(
        state: DashboardConcreteState.loaded,
        isLoading: false,
        hasData: true,
      ),
    );
    await fetchNotices();
  }

  Future<void> deleteNotice(Notice existingNotice) async {
    final deleteResponse =
        await dashboardRepository.deleteNotice(existingNotice);
    deleteResponse.fold(
      (l) => state = state.copyWith(
        state: DashboardConcreteState.failure,
        message: l.message,
        isLoading: false,
      ),
      (r) => state = state.copyWith(
        state: DashboardConcreteState.loaded,
        isLoading: false,
        hasData: true,
      ),
    );
    await fetchNotices();
  }

  Future<void> fetchNotices() async {
    if (isFetching && state.state != DashboardConcreteState.fetchedAllNotices) {
      state = state.copyWith(
        state: DashboardConcreteState.loading,
        isLoading: true,
      );

      final response = await dashboardRepository.fetchNotices();

      updateStateFromResponse(response);
    } else {
      state = state.copyWith(
        state: DashboardConcreteState.fetchedAllNotices,
        message: 'No more notices available',
        isLoading: false,
      );
    }
  }

  Future<void> updateNotice(Notice updatedNotice) async {
    state = state.copyWith(
      state: DashboardConcreteState.loading,
      isLoading: true,
    );

    final updateResponse =
        await dashboardRepository.updateNotice(updatedNotice);
    updateResponse.fold(
      (l) => state = state.copyWith(
        state: DashboardConcreteState.failure,
        message: l.message,
        isLoading: false,
      ),
      (r) => state = state.copyWith(
        state: DashboardConcreteState.loaded,
        isLoading: false,
        hasData: true,
      ),
    );
    await fetchNotices();
  }

  void updateStateFromResponse(Either<AppException, List<Notice>> response) {
    response.fold((failure) {
      state = state.copyWith(
        state: DashboardConcreteState.failure,
        message: failure.message,
        isLoading: false,
      );
    }, (data) {
      state = state.copyWith(
        noticeList: data,
        state: data.length == 100
            ? DashboardConcreteState.fetchedAllNotices
            : DashboardConcreteState.loaded,
        hasData: true,
        message: data.isEmpty ? 'No notices found' : '',
        isLoading: false,
      );
    });
  }

  void resetState() {
    state = const DashboardState.initial();
  }
}
