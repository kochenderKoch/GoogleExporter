import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_exporter/features/dashboard/domain/providers/dashboard_providers.dart';
import 'package:google_exporter/features/dashboard/presentation/provider/state/dashboard_notifier.dart';
import 'package:google_exporter/features/dashboard/presentation/provider/state/dashboard_state.dart';

final dashboardNotifierProvider =
    StateNotifierProvider<DashboardNotifier, DashboardState>((ref) {
  final repository = ref.watch(dashboardRepositoryProvider);
  return DashboardNotifier(repository)..fetchNotices();
});
