import 'package:diabetic/models/recent_file.dart';
import 'package:diabetic/services/networking.dart';
import 'package:diabetic/utils/constants.dart';
import 'package:diabetic/utils/urls.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';


class RecentFiles extends StatefulWidget {
  const RecentFiles({
    super.key,
  });

  @override
  State<RecentFiles> createState() => _RecentFilesState();
}

class _RecentFilesState extends State<RecentFiles> {
  bool isLoading = true;
  dynamic _myMedicine;
  List<dynamic> _review = [];
  List<dynamic> _comments = [];
  @override
  void initState() {
    super.initState();
    loadBook();
  }

  void loadBook() async {
//  setLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    NetworkHelper networkHelper = NetworkHelper(
        url: '$medsUrl/',
        token: prefs.getString("token") ?? "");
    // print(networkHelper.url);
    try {
      dynamic data = await networkHelper.getData();
      print(data);
      // .postData({"username": username, "password": password});
      // print(data);
      if (data["status"] == "success") {
        setState(() {
          _myMedicine = data["data"]["med"];
          _comments = data["data"]["comments"];
          _review = data["data"]["review"];
          isLoading = false;
        });
        print(_myMedicine);
      }
    } catch (e) {
      //   setError(e.toString());
      // setLoading(false);
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kDefaultPadding),
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
              columnSpacing: kDefaultPadding,
              // minWidth: 600,
              columns: [
                DataColumn(
                  label: Text("File Name"),
                ),
                DataColumn(
                  label: Text("Date"),
                ),
                DataColumn(
                  label: Text("Size"),
                ),
              ],
              rows: List.generate(
                demoRecentFiles.length,
                (index) => recentFileDataRow(demoRecentFiles[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentFileDataRow(RecentFile fileInfo) {
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
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Text(fileInfo.title!),
            ),
          ],
        ),
      ),
      DataCell(Text(fileInfo.date!)),
      DataCell(Text(fileInfo.size!)),
    ],
  );
}
// RecentFile(
//     icon: "assets/icons/xd_file.svg",
//     title: "XD File",
//     date: "01-03-2021",
//     size: "3.5mb",
//   ),