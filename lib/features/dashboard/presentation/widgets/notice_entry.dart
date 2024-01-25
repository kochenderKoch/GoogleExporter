import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_exporter/features/dashboard/presentation/provider/dashboard_state_provider.dart';
import 'package:google_exporter/shared/domain/models/notice/notice_model.dart';

class SingleNoticeEntry extends ConsumerStatefulWidget {
  SingleNoticeEntry({super.key, required this.product});

  final Notice product;

  @override
  _SingleNoticeEntryState createState() => _SingleNoticeEntryState();
}

class _SingleNoticeEntryState extends ConsumerState<SingleNoticeEntry> {
  bool isEditable = false;
  late TextEditingController noticeController;

  @override
  void initState() {
    noticeController = TextEditingController(text: widget.product.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        '${widget.product.id}',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      title: isEditable
          ? TextField(controller: noticeController)
          : Text(
              widget.product.text,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
      subtitle: Text(
        '${widget.product.isDone}',
        style: Theme.of(context).textTheme.bodyMedium,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: !isEditable
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isEditable = !isEditable;
                      });
                    },
                    icon: const Icon(Icons.update_disabled),
                  )
                : IconButton(
                    onPressed: () {
                      var newNotice = Notice(noticeController.text);
                      newNotice.setId(widget.product.id);
                      ref
                          .read(dashboardNotifierProvider.notifier)
                          .updateNotice(newNotice);
                      setState(() {
                        isEditable = !isEditable;
                      });
                    },
                    icon: Icon(Icons.update),
                  ),
          ),
          IconButton(
            onPressed: () {
              ref
                  .read(dashboardNotifierProvider.notifier)
                  .deleteNotice(widget.product);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
