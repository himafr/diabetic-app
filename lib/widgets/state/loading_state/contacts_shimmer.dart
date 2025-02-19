import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyContactsShimmer extends StatelessWidget {
  const MyContactsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
   
    var baseColor = Theme.of(context).colorScheme.secondary;
    var highlightColor = Theme.of(context).dialogBackgroundColor;
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 110,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Shimmer.fromColors(
                      baseColor: baseColor,
                      highlightColor: highlightColor,
                      enabled: true,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade900,
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                        ),
                      ),
                    )),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Shimmer.fromColors(
                          baseColor: baseColor,
                          highlightColor: highlightColor,
                          enabled: true,
                          child: Container(
                            width: 400,
                            height: 20,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Shimmer.fromColors(
                          baseColor: baseColor,
                          highlightColor: highlightColor,
                          enabled: true,
                          child: Container(
                            width: 200,
                            height: 12,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Shimmer.fromColors(
                          baseColor: baseColor,
                          highlightColor: highlightColor,
                          enabled: true,
                          child: Container(
                            width: 90,
                            height: 12,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Shimmer.fromColors(
                          baseColor: baseColor,
                          highlightColor: highlightColor,
                          enabled: true,
                          child: Container(
                            width: 120,
                            height: 12,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Shimmer.fromColors(
                                    baseColor: baseColor,
                                    highlightColor: highlightColor,
                                    enabled: true,
                                    child: Container(
                                      width: 60,
                                      height: 12,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Shimmer.fromColors(
                                    baseColor: baseColor,
                                    highlightColor: highlightColor,
                                    enabled: true,
                                    child: Container(
                                      width: 40,
                                      height: 12,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                  ),
                                ],
                              ),
                              Shimmer.fromColors(
                                baseColor: baseColor,
                                highlightColor: highlightColor,
                                enabled: true,
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}