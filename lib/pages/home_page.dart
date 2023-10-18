import 'package:flutter/material.dart';
import 'package:flutter_one/model/category_model.dart';
import 'package:flutter_one/model/deit_model.dart';
import 'package:flutter_one/model/popular_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = [];
  List<DietModel> diets = [];
  List<PopularDietsModel> popularDiets = PopularDietsModel.getPopularDiets();

  void _getCategoris() {
    categories = CategoryModel.getCategories();
  }

  void _getDiets() {
    diets = DietModel.getDiets();
  }

  void _getPopularDiets() {
    popularDiets = PopularDietsModel.getPopularDiets();
  }

  @override
  void initState() {
    super.initState();
    _getCategoris();
    _getDiets();
    _getPopularDiets();
  }

  @override
  Widget build(BuildContext context) {
    _getCategoris();
    _getDiets();
    _getPopularDiets();
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.white,
      body: ListView(children: [
        _search_Feild(),
        const SizedBox(
          height: 40,
        ),
        _category_section(),
        const SizedBox(
          height: 40,
        ),
        _deit_Section(),
        const SizedBox(
          height: 40,
        ),

        // Popualr Diets Section
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  "Popular Diets",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                )),
            const SizedBox(
              height: 15,
            ),
            ListView.separated(
                itemCount: popularDiets.length,
                shrinkWrap: true,
                separatorBuilder: (context, index) => const SizedBox(
                      height: 20,
                    ),
                padding: const EdgeInsets.only(left: 20, right: 20),
                itemBuilder: (context, index) {
                  return Container(
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.1),
                              offset: const Offset(0, 10),
                              blurRadius: 40,
                              spreadRadius: 0)
                        ]),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset(popularDiets[index].iconPath),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                popularDiets[index].name,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "${popularDiets[index].level} | ${popularDiets[index].duration} | ${popularDiets[index].calorie}",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(.4)),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: (){},
                            child: SvgPicture.asset("assets/icons/button.svg"),
                          )
                          
                        ]),
                  );
                })
          ],
        ),
        const SizedBox(
          height: 40,
        ),
      ]),
    );
  }

  // ignore: non_constant_identifier_names
  Column _deit_Section() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Text(
              "Recommendation\nfor Diet",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            )),
        const SizedBox(
          height: 40,
        ),
        Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            // ignore: sized_box_for_whitespace
            child: Container(
              height: 240,
              // color: Colors.green,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 210,
                      decoration: BoxDecoration(
                        color: diets[index].boxColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(diets[index].iconPath),
                            Column(
                              children: [
                                Text(
                                  diets[index].name,
                                  style: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                    "${diets[index].level} | ${diets[index].duration} | ${diets[index].calorie}",
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff7B6F72))),
                              ],
                            ),
                            Container(
                                height: 35,
                                width: 130,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(65),
                                  gradient: LinearGradient(colors: [
                                    diets[index].viewIsSelected
                                        ? const Color(0xff9DCEFF)
                                        : Colors.transparent,
                                    diets[index].viewIsSelected
                                        ? const Color(0xff92A3FD)
                                        : Colors.transparent,
                                  ]),
                                ),
                                child: Center(
                                    child: Text(
                                  "View",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: diets[index].viewIsSelected
                                          ? Colors.white
                                          : Colors.black),
                                )))
                          ]),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 25),
                  itemCount: diets.length),
            ))
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Padding _category_section() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Category",
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 18, color: Colors.black),
          ),
          const SizedBox(
            height: 40,
          ),
          // ignore: sized_box_for_whitespace
          Container(
            height: 120,
            child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                      width: 25,
                    ),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 100,
                    decoration: BoxDecoration(
                        color: categories[index].boxColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  SvgPicture.asset(categories[index].iconpath),
                            ),
                          ),
                          Text(
                            categories[index].name,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          )
                        ]),
                  );
                }),
          )
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Container _search_Feild() {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: const Color(0xff1D1617).withOpacity(0.11),
            blurRadius: 40,
            spreadRadius: 0.0)
      ]),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
      child: TextField(
        decoration: InputDecoration(
            hintText: "Search",
            hintStyle: const TextStyle(color: Color(0xffDDDADA), fontSize: 14),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset("assets/icons/Search.svg"),
            ),
            // ignore: sized_box_for_whitespace
            suffixIcon: Container(
              width: 80,
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const VerticalDivider(
                      color: Colors.black,
                      indent: 10,
                      endIndent: 10,
                      thickness: 0.1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: SvgPicture.asset("assets/icons/Filter.svg"),
                    ),
                  ],
                ),
              ),
            ),
            contentPadding: const EdgeInsets.all(15),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none)),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      title: const Text(
        "Breakfast",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 239, 240, 240),
              borderRadius: BorderRadius.circular(10)),
          child: SvgPicture.asset(
            "assets/icons/Arrow - Left 2.svg",
            height: 20,
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(10),
            width: 37,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 239, 240, 240),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.asset(
              "assets/icons/dots.svg",
              height: 5,
              width: 5,
            ),
          ),
        ),
      ],
    );
  }
}
