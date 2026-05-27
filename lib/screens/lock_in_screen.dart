
import 'package:action_slider/action_slider.dart';
import 'package:easy_localization/easy_localization.dart' as ez;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lockin_native_2/components/toggle_whitelist_blacklist.dart';
import 'package:lockin_native_2/core/app_size.dart';
import 'package:lockin_native_2/core/app_spacing.dart';
import 'package:lockin_native_2/core/theme.dart';
import 'package:lockin_native_2/domain/blocked.dart';
import 'package:lockin_native_2/domain/device_basket.dart';
import 'package:lockin_native_2/domain/task_basket.dart';
import 'package:lockin_native_2/providers/blocked_provider.dart';
import 'package:lockin_native_2/providers/device_basket_provider.dart';
import 'package:lockin_native_2/providers/lock_in_provider.dart';
import 'package:lockin_native_2/providers/task_basket_provider.dart';

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
                  buildBlocked(context, ref),
                  buildDeviceBasket(context, ref),
                  buildTaskBasket(context, ref)
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
            context.tr("focus_now"),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppSize.l,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5
            )
          ),
          Text(context.tr("focus_now_subtitle"), textAlign: TextAlign.center,),
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
    rolling: true,
    direction: sliderDirection,
    icon: Center(
      child: Icon(
        Icons.cyclone_rounded,
        size: AppSize.l,
        semanticLabel: context.tr("lock_in_slider_tip"),
      ),
    ),
    child: Text(context.tr("lock_in_slider_tip")),
    action: (controller) async {
      controller.loading();

      if (lockedIn){
        await ref.read(lockInProvider.notifier).delockIn();
      }
      else{
        await ref.read(lockInProvider.notifier).lockIn();
      }

      controller.success();
      controller.reset();
    },
  );
}

Widget buildBlocked(BuildContext context, WidgetRef ref){
  final state = ref.watch(blockedProvider);

  return Card(
    child: Padding(
      padding: EdgeInsets.all(AppSpacing.s),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.tr("blocked_card_title"),
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

          if (state.isLoading)
            const Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            )
          else if (state.hasError)
             Text(context.tr("loading_error"))
          else ...[
            ...state.value!.blockedRessources.map((ressource) {
              return _buildBlockedItem(ressource, ref);
            }),
            SizedBox(height: AppSpacing.s),
            _buildBlockedAddButtom(context)
          ]
        ],
      ),
    )
  );
}

Widget _buildBlockedItem(BlockedRessource resource, WidgetRef ref) {
  return ListTile(
    leading: Container(
      width: AppSize.l,
      height: AppSize.l,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppTheme.limeSoft,
        borderRadius: BorderRadius.circular(AppSize.s)
      ),
      child: Text(
        resource.label.substring(0, 2).toUpperCase(),
        style: TextStyle(
          fontWeight: FontWeight.bold
        ),
      ),
    ),
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

Widget _buildBlockedAddButtom(BuildContext context){
  return ListTile(
    contentPadding: EdgeInsets.all(AppSpacing.s),
    leading: Container(
      width: AppSize.l,
      height: AppSize.l,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppTheme.softGray,
        borderRadius: BorderRadius.circular(AppSize.s)
      ),
      child: Icon(Icons.add),
    ),
    title: Text(context.tr("create_blocker_button")),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSize.s),
      side: BorderSide(
        color: AppTheme.softGray,
        width: 0.5
      )
    ),
    onTap: () {
      showMyAddBlockedModal(context);
    },
  );
}

void showMyAddBlockedModal(BuildContext context){
  showModalBottomSheet(
    context: context, 
    builder: (context){
      return Padding(
        padding: const EdgeInsets.all(AppSpacing.s),
        child: Column(
          children: [
            
            SizedBox(height: AppSize.m,),

            ListTile(
              contentPadding: EdgeInsets.all(AppSpacing.s),
              leading: Container(
                width: AppSize.l,
                height: AppSize.l,
                decoration: BoxDecoration(
                  color: AppTheme.olive,
                  borderRadius: BorderRadius.circular(AppSize.s)
                ),
              ),
              title: Text(context.tr("create_web_blocker")),
            ),

            ListTile(
              contentPadding: EdgeInsets.all(AppSpacing.s),
              leading: Container(
                width: AppSize.l,
                height: AppSize.l,
                decoration: BoxDecoration(
                  color: AppTheme.limeSoft,
                  borderRadius: BorderRadius.circular(AppSize.s)
                ),
              ),
              title: Text(context.tr("create_app_blocker")),
            ),
          ]
        ),
      );
    }
    
  );
}


Widget buildDeviceBasket(BuildContext context, WidgetRef ref){

  final state = ref.watch(deviceBasketProvider);

  return Card(
    child: Padding(
      padding: EdgeInsets.all(AppSpacing.s),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                context.tr("devices_card_title"),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  fontSize: AppSize.m
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.m),

          if (state.isLoading)
            const Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            )
          else if (state.hasError)
            Text(context.tr("loading_error"))
          else ...[
            ...state.value!.devices.map((device) {
              return _buildDeviceBasketItem(context, device, ref);
            }),
          ]
        ],
      ),
    ),
  );
}

Widget _buildDeviceBasketItem(BuildContext context, Device device, WidgetRef ref){
return ListTile(
    leading: Container(
      width: AppSize.l,
      height: AppSize.l,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppTheme.olive,
        borderRadius: BorderRadius.circular(AppSize.s)
      ),
      child: Icon(device.icon)
    ),
    title: Text(device.name, style: TextStyle(fontWeight: FontWeight.bold),),
    subtitle: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if(device.isOnline)
          ...[
            Icon(Icons.circle, color: Colors.lightGreenAccent, size: AppSize.s,),
            SizedBox(width: AppSpacing.s,),
            Text(context.tr("connected_device")),
          ]
        else
          ...[
            Icon(Icons.circle, color: Theme.of(context).disabledColor, size: AppSize.s),
            SizedBox(width: AppSpacing.s,),
            Text(context.tr("not_connected_device"), style: TextStyle(fontWeight: FontWeight.w100),),
          ]
      ],
    ),
    
    trailing: Container(
      width: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          sliderToggleDevice(context, ref, device),
          SizedBox(width: AppSpacing.s),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
    )
  );
}

Widget sliderToggleDevice(BuildContext context, WidgetRef ref, Device device){

  final lockedIn = ref.watch(lockInProvider).value?.isLockedIn ?? false;

  TextDirection sliderDirection = TextDirection.ltr;

  if (device.isLockInActivated && Directionality.of(context) == TextDirection.ltr){
    sliderDirection = TextDirection.rtl;
  }
  else if(!device.isLockInActivated && Directionality.of(context) == TextDirection.ltr){
    sliderDirection = TextDirection.ltr;
  }
  else if(device.isLockInActivated && Directionality.of(context) == TextDirection.rtl){
    sliderDirection = TextDirection.ltr;
  }
  else if(!device.isLockInActivated && Directionality.of(context) == TextDirection.rtl){
    sliderDirection = TextDirection.rtl;
  }

  Widget? label;

  Color backgroundColor = AppTheme.paper;
  if (device.isLockInActivated){
    backgroundColor = AppTheme.sage;
  }

  return IgnorePointer(
    ignoring: !lockedIn,
    child: ActionSlider.standard(
      height: 40,
      width: 100,    
      direction: sliderDirection,
      toggleColor: lockedIn? AppTheme.emerald : AppTheme.softGray,
      backgroundColor: lockedIn? backgroundColor : Theme.of(context).disabledColor,
      sliderBehavior: SliderBehavior.stretch,
      action: (controller) async {
        controller.loading();
    
        if (device.isLockInActivated){
          await ref.read(deviceBasketProvider.notifier).deactivateLockIn(device);
        }
        else{
          await ref.read(deviceBasketProvider.notifier).activateLockIn(device);
        }
    
        controller.success();
        controller.reset();
      },
      child: label,
    ),
  );
}

Widget buildTaskBasket(BuildContext context, WidgetRef ref){
  final state = ref.watch(taskBasketProvider);

  return Card(
    child: Padding(
      padding: EdgeInsets.all(AppSpacing.s),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                context.tr("tasks_card_title"),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  fontSize: AppSize.m
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.m),

          if (state.isLoading)
            const Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            )
          else if (state.hasError)
            Text(context.tr("loading_error"))
          else ...[
            ...state.value!.tasks.map((task) {
              return _buildTaskItem(context, task, ref);
            }),
          ]
        ],
      ),
    ),
  );
}

Widget _buildTaskItem(BuildContext context, Task task, WidgetRef ref){
  return ListTile(
    leading: task.isCompleted ? Icon(Icons.check_circle) : Icon(Icons.check_circle_outline),
    title: Text(task.name, style: TextStyle(fontWeight: FontWeight.bold),),
    trailing: IconButton(
      icon: Icon(Icons.more_vert),
      onPressed: () {},
    ),
    onTap: () => {
      ref.read(taskBasketProvider.notifier).updateTask(
        task.copyWith(isCompleted: !task.isCompleted)
      )
    },
  );
}