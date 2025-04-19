// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names, prefer_interpolation_to_compose_strings
import 'package:diabetic/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          //physics: ScrollPhysics(),
          primary: true,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text("Home Page",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.white,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Row(children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.notifications_none_sharp,
                                  color: Colors.white)),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.access_time_sharp,
                                  color: Colors.white)),
                          Builder(
                            builder: (context) => IconButton(
                                icon: const Icon(Icons.settings_outlined,
                                    color: Colors.white),
                                onPressed: () =>
                                    Scaffold.of(context).openDrawer()),
                          )
                        ]),
                      )
                    ],
                  ),
                ),
                // Expanded(child:
                // Row(
                //   children: [
                // LineChartSample()

                //   ],
                // )
                // )
                const Row(
                  children: [
                    Expanded(
                      // It takes 5/6 part of the screen
                      flex: 5,
                      child: DashboardScreen(),
                    ),
                  ],
                ),
              ]),
        ),
      ],
    );
  }
}
