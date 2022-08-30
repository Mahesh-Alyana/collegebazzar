import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../utils.dart/filters.dart';

class TopBar extends StatefulWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var textSize = height < width ? height : width;
    return Row(
      children: [
        SizedBox(
          width: width * 0.05,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 50,
            width: width * 0.6,
            child: ListView.builder(
                itemCount: Filter.filters.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: (() {
                        for (int i = 0; i < Filter.filters.length; i++) {
                          setState(() {
                            Filter.filters[i][1] = false;
                          });
                        }
                        setState(() {
                          Filter.filters[index][1] = true;
                          Filter.filterName = Filter.filters[index][0];
                          // print(Filter.filterName);
                        });
                      }),
                      child: Container(
                        height: 60,
                        decoration: Filter.filters[index][1]
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xff5d9cc6),
                                    Color(0xff4e5bb3)
                                  ],
                                ))
                            : BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x4d000000),
                                    blurRadius: 12,
                                    offset: Offset(4, 4),
                                  ),
                                ],
                                color: Color(0xff262626),
                              ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 6),
                            child: Text(
                              Filter.filters[index][0],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: textSize * 0.016,
                                fontFamily: "Barlow",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                })),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: width * 0.2,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xff5d9cc6), Color(0xff4e5bb3)],
                )),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: MaterialButton(
                onPressed: (() {}),
                child: Center(
                  child: Text(
                    "SELL AN ITEMS",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: textSize * 0.018,
                      fontFamily: "Barlow",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: width * 0.1,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xff5d9cc6), Color(0xff4e5bb3)],
                )),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: MaterialButton(
                onPressed: (() {}),
                child: Center(
                  child: Text(
                    "Stock",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: textSize * 0.018,
                      fontFamily: "Barlow",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
