import 'package:city_guide_firebase/app/pages/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:lottie/lottie.dart';

import '../../../data/repositories/data_city_repository.dart';
import '../../../domain/entities/city.dart';
import '../addCity/addCity_view.dart';
import '../cityDetail/cityDetail_view.dart';
import 'profile_controller.dart';

class ProfileView extends View {
  @override
  State<StatefulWidget> createState() {
    return _ProfileViewState(
      ProfileController(
        DataCityRepository(),
      ),
    );
  }
}

class _ProfileViewState extends ViewState<ProfileView, ProfileController> {
  _ProfileViewState(ProfileController controller) : super(controller);

  @override
  Widget get view {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        key: globalKey,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF6c63ff),
          onPressed: () {
            Navigator.push(
              (context),
              MaterialPageRoute(
                builder: (context) => AddCityView(),
              ),
            );
          },
          child: Icon(
            Icons.add,
          ),
        ),
        body: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: size.width,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Color(0xFF6c63ff),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 55),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeView()),
                                    );
                                  },
                                  child: Icon(
                                    Icons.home,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              Text(
                                "Firebase App",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      ControlledWidgetBuilder<ProfileController>(
                          builder: (context, controller) {
                        return controller.cities != null &&
                                controller.cities!.length != 0
                            ? Column(
                                children: [
                                  for (int i = 0;
                                      i < controller.cities!.length;
                                      i++)
                                    _ProfileCityCard(controller.cities![i]),
                                ],
                              )
                            : Lottie.asset('assets/animations/loading.json');
                      })
                    ],
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class _ProfileCityCard extends StatelessWidget {
  final City city;

  _ProfileCityCard(this.city);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Container(
            width: size.width - 36,
            height: 250,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(235, 221, 218, 218),
                  offset: Offset(5, 2),
                  blurRadius: 4.0,
                  spreadRadius: 1.0,
                ),
              ],
            ),
            child: Column(children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 18,
                  left: 19,
                  right: 15,
                ),
                child: Container(
                  width: 330,
                  height: 165,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          city.imageUrl,
                        )),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(235, 221, 218, 218),
                        offset: Offset(5, 2),
                        blurRadius: 4.0,
                        spreadRadius: 1.0,
                      ),
                    ],
                  ),
                  // child: Image(

                  //   image: NetworkImage(city.imageUrl,),
                  // ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 19),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 26),
                      child: Text(
                        city.cityName,
                        style: TextStyle(
                          color: Color(0xFF6c63ff),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 14),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CityDetailView(city)),
                          );
                        },
                        child: Icon(
                          Icons.chevron_right,
                          size: 25,
                          color: Color(0xFF6c63ff),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
