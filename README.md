# ParkIt Project

A smart parking application Demo project created in flutter using firebase and firebase realtime DB. 
## Getting Started

The Project contains the minimal implementation required to create a smart parking application. The repository code is preloaded with some basic components like basic app architecture, app theme, constants and required dependencies to create a new project.

## How to Use 

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/UNKLD/ParkIt-demo.git
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies: 

```
flutter pub get 
```

## ParkIt Features:

* Welcome
* Login
* Home
* Routing
* Theme
* Database
* Validation
* Logging


### Folder Structure
Here is the core folder structure which flutter provides.

```
flutter-app/
|- android
|- build
|- ios
|- lib
|- test
```

Here is the folder structure we have been using in this project

```
lib/
|- constants/
|- screens/
|- main.dart
```

Now, lets dive into the lib folder which has the main code for the application.

```
1- constants - All the application level constants are defined in this directory with-in their respective files. This directory contains the constants for `theme`, `dimentions`, `api endpoints`, `preferences` and `strings`.
4- screens — Contains all the ui of this project for each screen.
6- constants — Contains the common widgets for your applications. For example, Button, TextField etc.
8- main.dart - This is the starting point of the application. Which contains the routes and all the application level configurations are defined in this file i.e, theme, routes, title, orientation etc.
```

### Constants

This directory contains all the application level constants. A separate file is created for each type as shown in example below:

```
constants/
|- constants.dart
```



### UI

This directory contains all the ui of your application. Each screen is located in a single folder.

```
lib/
|- screens
   |- welcomeScreen.dart
   |- loginScreen.dart
   |- registerScreen.dart
   |- reserveScreen.dart
   |- ...
```


### Widgets

Contains the common widgets that are shared across multiple screens. For example, Button, TextField etc.

```
components/
|- dynamicDialog.dart
|- progressDialog.dart
|- roundedButton.dart
```


### Main

This is the starting point of the application. All the application level configurations are defined in this file i.e, theme, routes, title, orientation etc.

```dart
import 'package:flutter/material.dart';
import 'package:untitled/screens/About.dart';
import 'package:untitled/screens/FeedBack.dart';
import 'package:untitled/screens/NearBy.dart';
import 'package:untitled/screens/Profile.dart';
import 'package:untitled/screens/loginScreen.dart';
import 'package:untitled/screens/mainScreen.dart';
import 'package:untitled/screens/parkCarScreen.dart';
import 'package:untitled/screens/registerScreen.dart';
import 'package:untitled/screens/scanPage.dart';
import 'package:untitled/screens/unParkCarScreen.dart';
import 'package:untitled/screens/verifyScreen.dart';
import 'package:untitled/screens/welcomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ParkIT',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        MainScreen.id: (context) => MainScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        VerifyScreen.id: (context) => VerifyScreen(),
        ScanPage.id: (context) => ScanPage(),
        FeedBack.id: (context) => FeedBack(),
        ParkCarScreen.id: (context) => ParkCarScreen(),
        UnParkCarScreen.id: (context) => UnParkCarScreen(),
        About.id: (context) => About(),
        NearBy.id: (context) => NearBy(),
        Profile.id: (context) => Profile(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
```

## Conclusion

I will be happy to answer any questions that you may have on this approach, and if you want to lend a hand with the boilerplate then please feel free to submit an issue and/or pull request 🙂

Again to note, this is example can appear as over-architectured for what it is - but it is an example only. If you liked my work, don’t forget to ⭐ star the repo to show your support.
