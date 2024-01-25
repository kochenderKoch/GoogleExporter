import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_exporter/features/dashboard/presentation/provider/dashboard_state_provider.dart';
import 'package:google_exporter/features/dashboard/presentation/widgets/notice_entry.dart';
import 'package:google_exporter/shared/domain/models/notice/notice_model.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  final scrollController = ScrollController();
  TextEditingController noticeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    noticeController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dashboardNotifierProvider);
    return Column(
      children: [
        Expanded(
          child: Scrollbar(
            controller: scrollController,
            child: ListView.separated(
              separatorBuilder: (_, __) => const Divider(),
              controller: scrollController,
              itemCount: state.noticeList.length,
              itemBuilder: (context, index) {
                final product = state.noticeList[index];
                return SingleNoticeEntry(
                  product: product,
                );
              },
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: noticeController,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () {
                  ref
                      .read(dashboardNotifierProvider.notifier)
                      .addNotice(Notice(noticeController.text));
                  noticeController.clear();
                },
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
