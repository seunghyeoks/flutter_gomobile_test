# Flutter Gomobile test

This is a sample project to test running golang code in a Flutter app, using `gomobile`.

gomobile builds golang project into native library for mobile platforms. This sample project imports that library and runs it in `.dart` code.  

## Project structure

This project mainly consists of the following parts:

* `go_sample`: Contains go code with simple functions defined.

* `ios/Runner`: contains Swift code that runs on iOS and communicates with the Dart code.

* `lib`: Contains the Dart code for mobile app

## How to Build for iOS

### 1. Prepare Go Project
- Prepare your own project, or use the sample code in this sample project.
- In this sample project, the go project is `go_sample`.

### 2. Build with gomobile
- In your Go project, run the command below to build the library for iOS:
  ```sh
  gomobile bind -target=ios
  ```
### 3. Copy Generated .xcframework
- Copy the generated `.xcframework` to the iOS folder in your project.
	- In this sample project, copy it is `ios/Samplefunc.xcframework`.

### 4. Write Swift Bridge Code
- Write Swift code to create a bridge for calling the native library.
	- This is typically done by specifying the types for each function argument.
	- In this sample project, the file is located at `ios/Runner/SamplefuncBridge.swift`.

### 5. Edit AppDelegate.swift
- Edit `ios/Runner/AppDelegate.swift`. I add a single line to register the plugin for the Go library.

### 6. Configure Xcode Project
- Open `ios/Runner.xcworkspace` with Xcode.
	- Add the Swift bridge code and the .xcframework to your project in Xcode, like the picture below.
	- Once you add them to Xcode, replacing an existing framework with a new version should work fine, as long as the files are not renamed. 
	- If the filename has changed, run Xcode again and repeat the steps below. ![](./docs/xcode_setup1.png)


### 7. Write Flutter Code
- Write the flutter app you intended
- Use `MethodChannel` to communicate with Swift from Dart.
	- Refer to the comments in `main.dart` for more details.
	- It is recommended to keep the code for the MethodChannel in a separate file

### 8. Run flutter app to test
- After setting up the project in Xcode, you can run the app by simply executing:
	```sh
	flutter run
	```
- Note: You can run it in the terminal, but the terminal doesn't print information like `log.info` in the go code. If you used log in the go code, run the flutter app via Xcode

## How to build for Android
I got an app build error and stopped working on it for now.

## References
* [Go wiki: Mobile](https://go.dev/wiki/Mobile)
* [Flutter docs for MethodChannel](https://docs.flutter.dev/platform-integration/platform-channels)