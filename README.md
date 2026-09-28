# TouchBar Runner 🏃‍♂️

A lightweight, native macOS application built with SwiftUI that brings the MacBook Touch Bar to life. This project demonstrates how to override the default system controls to render a continuous, looping sprite animation directly on the keyboard.

## Features

* **Native SwiftUI Implementation**: Utilizes the modern `.touchBar` modifier and Combine's `Timer` publisher for smooth rendering without heavy AppKit boilerplate.
* **Frame-by-Frame Animation**: Cycles through a sprite sequence (60fps logic scaled to 10fps for pixel-art clarity) to create a fluid running cycle.
* **Infinite Scrolling**: Uses horizontal offsets and coordinate resetting on a `ZStack` canvas to make the character seamlessly traverse the entire physical width of the Touch Bar (~700 points).
* **Power Efficient**: The animation relies on native iOS/macOS frameworks, ensuring minimal CPU overhead while the app is in focus.

## Getting Started

### Prerequisites
* A Mac with a physical Touch Bar (or the Touch Bar Simulator enabled in Xcode via `Window > Show Touch Bar`).
* macOS 11.0+ 
* Xcode 13.0+ (Swift 5.0+)

### Usage
1. Open the `.xcodeproj` file in Xcode.
2. Ensure the active scheme targets your local Mac.
3. Build and run the project (`Cmd + R`). 
4. Click on the app's main window to bring it into focus and watch the animation on your Touch Bar!

## How it Works

The core logic bypasses standard button placements by creating a transparent "runway" that stretches across the entire Touch Bar hardware. 

```swift
ZStack(alignment: .leading) {
    // 1. Create an invisible track taking full hardware width
    Color.clear
        .frame(width: 700, height: 30)
    
    // 2. Render and offset the current sprite frame
    Image("frame\(currentFrame)")
        .resizable()
        .scaledToFit()
        .frame(height: 30)
        .offset(x: positionX) 
}
```

A Combine Timer triggers every 0.1 seconds, simultaneously iterating the sprite image index to animate the legs and incrementing the positionX coordinate to move the character forward. Once positionX exceeds the screen width, it teleports back to a negative offset to restart the loop.

## Customizing the Sprite

You can easily replace the default character with your own assets and add as many sprites as you want:

1. Open `Assets.xcassets` in Xcode.
2. Drag and drop your own PNG sequences (ensure they are named sequentially: `frame1`, `frame2`, `frame3`, etc.).
3. **Manage the number of sprites in the code:** Open `ContentView.swift` and find this specific line at the top of the file to set your maximum number of frames (from 1 up to your custom limit):

```swift
let maxFrames = 9 // Change this number to match your exact total of sprites
```

## 📄 License

This project is open-source and available under the [MIT License](LICENSE).
