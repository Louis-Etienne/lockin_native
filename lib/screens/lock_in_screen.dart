
import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lockin_native_2/components/toggle_whitelist_blacklist.dart';
import 'package:lockin_native_2/core/app_size.dart';
import 'package:lockin_native_2/core/app_spacing.dart';
import 'package:lockin_native_2/core/theme.dart';
import 'package:lockin_native_2/domain/blocked.dart';
import 'package:lockin_native_2/providers/blocked_provider.dart';
import 'package:lockin_native_2/providers/lock_in_provider.dart';

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
                  buildLockInCallToAction(context, ref),
                  buildBlocked(ref),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}

Widget buildLockInCallToAction(BuildContext context, WidgetRef ref){
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
          sliderCallToAction(context, ref)
        ],
      ),
    ),
  );
}


Widget sliderCallToAction(BuildContext context, WidgetRef ref){

  final lockedIn = ref.watch(lockInProvider).value?.isLockedIn ?? false;

  TextDirection sliderDirection = TextDirection.ltr;

  if (lockedIn && Directionality.of(context) == TextDirection.ltr){
    sliderDirection = TextDirection.rtl;
  }
  else if(!lockedIn && Directionality.of(context) == TextDirection.ltr){
    sliderDirection = TextDirection.ltr;
  }
  else if(lockedIn && Directionality.of(context) == TextDirection.rtl){
    sliderDirection = TextDirection.ltr;
  }
  else if(!lockedIn && Directionality.of(context) == TextDirection.rtl){
    sliderDirection = TextDirection.rtl;
  }

  return ActionSlider.standard(
    direction: sliderDirection,
    icon: Center(
      child: Icon(
        Icons.cyclone_rounded,
        size: AppSize.l,
        semanticLabel: "Slider to start the focus mode",
      ),
    ),
    child: Text("Slide to focus"),
    action: (controller) async {
      controller.loading();
      await Future.delayed(const Duration(seconds: 3));

      if (lockedIn){
        ref.read(lockInProvider.notifier).delockIn();
      }
      else{
        ref.read(lockInProvider.notifier).lockIn();
      }

      controller.success();
      await Future.delayed(const Duration(seconds: 1));
      controller.reset();
    },
  );
}

Widget buildBlocked(WidgetRef ref){
  final state = ref.watch(blockedProvider);

  if (state.isLoading) {
    return CircularProgressIndicator();
  }

  if (state.hasError){
    return Text("Error loading blocked ressources");
  }

  final blocked = state.value!.blockedRessources;

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
          SizedBox(height: AppSpacing.m),

          ...blocked.map((ressource){
            return _buildBlockedItem(ressource, ref);
          }),
        ],
      ),
    )
  );
}

Widget _buildBlockedItem(BlockedRessource resource, WidgetRef ref) {
  return ListTile(
    title: Text(resource.label),
    subtitle: Text(resource.runtimeType.toString()),

    trailing: IconButton(
      icon: Icon(Icons.delete),
      onPressed: () {
        ref
            .read(blockedProvider.notifier)
            .remove(resource);
      },
    ),
  );
}