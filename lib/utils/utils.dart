import 'package:in_app_update/in_app_update.dart';

class AppUtils{

  static String formatTime(int seconds) {
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }



  void checkForUpdates() {
    InAppUpdate.checkForUpdate().then((updateInfo) {
      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        if (updateInfo.immediateUpdateAllowed) {
          // Perform immediate update
          InAppUpdate.performImmediateUpdate().then((appUpdateResult) {
            if (appUpdateResult == AppUpdateResult.success) {
              // App Update successful
            }
          }).catchError((e) {
            // Handle any errors that occur during the immediate update
            print("Immediate update failed: $e");
          });
        } else if (updateInfo.flexibleUpdateAllowed) {
          // Perform flexible update
          InAppUpdate.startFlexibleUpdate().then((appUpdateResult) {
            if (appUpdateResult == AppUpdateResult.success) {
              // App Update successful
              InAppUpdate.completeFlexibleUpdate().then((result) {
                // Handle the result of the completion
              }).catchError((e) {
                // Handle any errors that occur during completion
                print("Flexible update completion failed: $e");
              });
            }
          }).catchError((e) {
            // Handle any errors that occur during the flexible update
            print("Flexible update failed: $e");
          });
        }
      }
    }).catchError((e) {
      // Handle any errors that occur during the update check
      print("Check for update failed: $e");
    });
  }

}