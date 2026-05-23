
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lockin_native_2/components/toggle_whitelist_blacklist.dart';
import 'package:lockin_native_2/core/app_size.dart';
import 'package:lockin_native_2/core/app_spacing.dart';
import 'package:lockin_native_2/core/theme.dart';
import 'package:slider_button/slider_button.dart';

class LockInScreen extends ConsumerWidget{
  const LockInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    return Scaffold(
      appBar: AppBar(
        title: Text("Lock In"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.popupBackground
        ),
        width: double.infinity,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical:AppSize.s, horizontal: AppSize.s),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildLockInCallToAction(),
                  buildBlocked(),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}

Widget buildLockInCallToAction(){
  return Card(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSize.s, horizontal: AppSize.l),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Focus Now",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppSize.l,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5
            )
          ),
          Text("Lock In now and focus, this will lock your distractions away", textAlign: TextAlign.center,),
          SizedBox(height: AppSpacing.m),
          sliderCallToAction()
        ],
      ),
    ),
  );
}

Widget sliderCallToAction(){
  return SliderButton(
    action: () async{return false;},
    label: Text(
      "Slide to focus"
    ),
    vibrationFlag: true,
    icon: Center(
      child: Icon(
        Icons.cyclone_rounded,
        size: AppSize.l,
        semanticLabel: "Slider to start the focus mode",
      ),
    ),
  );
}

Widget buildBlocked(){
  return Card(
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: AppSize.s, horizontal: AppSize.l),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Blocked",
                style: TextStyle(
                  fontSize: AppSize.m,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold
                ),
              ),

              ToggleWhitelistBlacklist()
            ],
          ),
          SizedBox(height: AppSpacing.m)
        ],
      ),
    )
  );
}