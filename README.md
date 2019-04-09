# Agora Android Prototype

This is a prototype of agora android as per the GSoC challenge.

## Getting Started

This protype has the following functionalities implemented:
1. Splash Screen with animation of Agora logo
2. Login, Signup, Logout using the agora rest API
3. Dashboard with user data such as name, email
4. Election list and details with dummy data(this data could be changed so as to reflect the changes in UI)
5. A view of how a user cast his/her vote on an election with a preferential ballot.
6. Saving the access token so that user doesn't have to login all the time

### Prerequisites

Since the app is made on flutter and thus it is recommended to install flutter.
```
Flutter
Latest Android SDK
```

### Installing

Clone this repository and then navigate to the directory containing this project
and run the following commands

```
flutter packages get
```

After getting packages successfully type 

```
flutter run
```

To run in release mode can use 
```
flutter run --release
```

## Link for the Application

App could be directly downloaded from this :
https://drive.google.com/open?id=1j1hEPMXI0LBCx7pEBAc_dFTaq0UnGNUd

### Small Video of app

A small videos demonstrating the app functionality:

https://drive.google.com/open?id=1TZCrPA3d8kuTH8S9OVSXWxjXMCV5KwBQ



### If App gets stuck

Since app is debug mode so there chances that there will be some errors.
So if app gets Struck somewhere just go to app settings and press force close


## Important Note

Since App is made with flutter so it can run on both IOS and Android.
To run on IOS repeat the same steps as followed for android.
Just add internet permission for IOS.
And make sure that this is done only on MacOS as building app for IOS
requires xcode.

## Built With

* Flutter
## I am the only contributer for this repo as jwick007 and ykataria both are my github IDs

