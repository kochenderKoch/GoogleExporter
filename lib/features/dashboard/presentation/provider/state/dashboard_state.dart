import 'package:equatable/equatable.dart';
import 'package:google_exporter/shared/domain/models/notice/notice_model.dart';

enum DashboardConcreteState {
  initial,
  loading,
  loaded,
  failure,
  fetchedAllNotices
}

class DashboardState extends Equatable {
  const DashboardState({
    this.noticeList = const [],
    this.title = '',
    this.hasData = false,
    this.isLoading = false,
    this.state = DashboardConcreteState.initial,
    this.message = '',
  });
  const DashboardState.initial({
    this.noticeList = const [],
    this.title = '',
    this.hasData = false,
    this.isLoading = false,
    this.state = DashboardConcreteState.initial,
    this.message = '',
  });
  final List<Notice> noticeList;
  final String title;
  final bool hasData;
  final bool isLoading;
  final DashboardConcreteState state;
  final String message;

  DashboardState copyWith({
    List<Notice>? noticeList,
    String? title,
    bool? hasData,
    DashboardConcreteState? state,
    bool? isLoading,
    String? message,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      noticeList: noticeList ?? this.noticeList,
      title: title ?? this.title,
      hasData: hasData ?? this.hasData,
      state: state ?? this.state,
      message: message ?? this.message,
    );
  }

  @override
  String toString() {
    return '''DashboardState(isLoading:$isLoading, noticeLength: ${noticeList.length},title:$title, hasData: $hasData, state: $state, message: $message)''';
  }

  @override
  List<Object?> get props => [title, noticeList, hasData, state, message];
}
