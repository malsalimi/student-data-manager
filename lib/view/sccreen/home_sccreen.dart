import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_levevl_3/controller/home_controller.dart';
import 'package:project_levevl_3/view/widgts/my_button_widgts.dart';

class HomeSccreen extends StatelessWidget {
  const HomeSccreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    print(":::::::::::::::::::::::::::::::::::::::::::::::::: ");
    return Scaffold(
      appBar: AppBar(),
          body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyButton(
              text: "+",
              onPress: controller.increment,
            ),
            GetBuilder<HomeController>(builder: (controller)=>  Text(controller.count.toString()),),
            MyButton(
              text: "-",
              onPress: controller.dncrement,
            )
          ],
        ),
          )
    );
  }
}
