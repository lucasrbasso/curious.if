import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:curious_if_mobile/modules/home/pages/posts_page/widgets/popup_report/create_report_widget.dart';

import '../../../../../../core/core.dart';

class PopupReport extends StatefulWidget {
  final Future<bool> Function(String) onSaved;
  const PopupReport({
    Key? key,
    required this.onSaved,
  }) : super(key: key);

  @override
  State<PopupReport> createState() => _PopupReportState();
}

class _PopupReportState extends State<PopupReport> {
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.only(bottom: 24),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(18.0))),
      contentPadding: EdgeInsets.zero,
      titlePadding: const EdgeInsets.only(right: 8, top: 8),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 8),
            child: Text("Digite abaixo a sua denuncia",
                style: AppTheme.textStyles.textHeadingFour),
          ),
          InkWell(
            onTap: () => Navigator.maybePop(context),
            borderRadius: BorderRadius.circular(20),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.cancel_outlined, color: Colors.red),
            ),
          ),
        ],
      ),
      content: Container(
        padding: EdgeInsets.only(bottom: 12, top: 2),
        child: Scrollbar(
          isAlwaysShown: true,
          controller: scrollController,
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                CreateReportWidget(onSaved: widget.onSaved),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: AppTheme.colors.background,
    );
  }
}
