import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../responsive.dart';
import '../../../../data/constrains.dart';
import '../../../../data/models/recent_files.dart';

class RecentFiles extends StatelessWidget {
  const RecentFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Files",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              columnSpacing: defaultPadding,
              // minWidth: 600,
              columns: [
                DataColumn(
                  label: Text("File Name"),
                ),
                if (!Responsive.isMobile(context))
                  DataColumn(
                    label: Text("Date"),
                  ),
                DataColumn(
                  label: Text("Size"),
                ),
              ],
              rows: List.generate(
                demoRecentFiles.length,
                (index) => recentFileDataRow(demoRecentFiles[index], context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentFileDataRow(RecentFile fileInfo, context) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            SvgPicture.asset(
              fileInfo.icon!,
              height: 30,
              width: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    fileInfo.title!,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (Responsive.isMobile(context))
                    Text(
                      fileInfo.date!,
                      style: Responsive.isMobile(context)
                          ? TextStyle(color: Colors.grey)
                          : null,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      if (!Responsive.isMobile(context)) DataCell(Text(fileInfo.date!)),
      DataCell(Text(fileInfo.size!)),
    ],
  );
}
