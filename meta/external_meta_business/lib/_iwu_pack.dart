import 'package:_iwu_pack/setup/app_base.dart';
import 'package:_iwu_pack/setup/app_setup.dart';
import 'package:firebase_core/firebase_core.dart';

import 'src/constants/constants.dart';
import 'src/utils/utils.dart';

imagineeringwithusPackSetup() {
  AppSetup.initialized(
    value: AppSetup(
      env: AppEnv.preprod,
      appColors: AppColors.instance,
      appPrefs: AppPrefs.instance,
    ),
  );
}

const FirebaseOptions firebaseOptionsPREPROD = FirebaseOptions(
  apiKey: "AIzaSyDhgE5jvNDDruecltCPRyDx9sEs2S4hMA4",
  authDomain: "bussiness-8554b.firebaseapp.com",
  projectId: "bussiness-8554b",
  storageBucket: "bussiness-8554b.appspot.com",
  messagingSenderId: "846259463101",
  appId: "1:846259463101:web:97737527c261153bbae8d4",
  measurementId: "G-RT83DTPHKW",
);
