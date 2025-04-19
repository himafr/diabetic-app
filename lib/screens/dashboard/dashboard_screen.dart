// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:diabetic/screens/dashboard/components/my_fields.dart';
import 'package:diabetic/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


import 'components/recent_files.dart';
import 'components/storage_details.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(kDefaultPadding),
        child: Column(
          children: [
            // Header(),
            // SizedBox(height: kDefaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      MyFiles(),
                      SizedBox(height: kDefaultPadding),
                      RecentFiles(),
                      if (true)
                        SizedBox(height: kDefaultPadding),
                      if (true) StorageDetails(),
                    ],
                  ),
                ),
                // if (!Responsive.isMobile(context))
                //   SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we don't want to show it
                // if (!Responsive.isMobile(context))
                //   Expanded(
                //     flex: 2,
                //     child: StorageDetails(),
                //   ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
