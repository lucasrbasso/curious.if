import 'package:curious_if_mobile/domain/reports/model/get_report.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';

class ReportManageWidget extends StatelessWidget {
  final GetReport report;
  const ReportManageWidget({
    Key? key,
    required this.report,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String denuncia = report.comment == null
        ? "Denuncia da postagem"
        : "Denuncia do Comentário";
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: AppTheme.colors.backgroundTextForm,
          borderRadius: BorderRadius.circular(12),
        ),
        constraints: const BoxConstraints(minHeight: 78),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$denuncia",
              style: AppTheme.textStyles.titlePost,
            ),
            Text(
              "Spotted#${report.post.postNumber.toString().padLeft(4, '0')}",
              style: AppTheme.textStyles.subtitleTextPost,
            ),
            const SizedBox(height: 2),
            if (report.post.to.isNotEmpty) ...[
              Text.rich(TextSpan(
                  text: "Para: ",
                  style: AppTheme.textStyles.titleTextPost,
                  children: [
                    TextSpan(
                        text: report.post.to,
                        style: AppTheme.textStyles.subtitleTextPost)
                  ])),
            ],
            const SizedBox(height: 2),
            Text("Postagem: ${report.post.content}",
                style: AppTheme.textStyles.subtitleTextPost),
            if (report.comment != null) ...[
              const SizedBox(height: 4),
              Text(
                "Comentário: ${report.comment!.content}",
                style: AppTheme.textStyles.subtitleTextPost,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
