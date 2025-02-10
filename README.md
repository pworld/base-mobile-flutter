# Flutter Project

A Flutter project demonstrating a modular architecture for authentication. This project uses a feature-first folder structure, separating configuration, core logic, and features.

## Table of Contents

- [Overview](#overview)
- [Getting Started](#getting-started)
- [Installation](#Installation)
- [Notes](#notes)

## Overview

This project implements a modular architecture where each feature is isolated into its own folder. In this example, the `auth` feature is divided into:
- **data:** Contains models, data sources, and repositories.
- **domain:** Contains business logic, use cases, and domain entities.
- **presentation:** Contains UI components:
  - **provider:** State management logic (e.g., using Provider, Riverbed, etc.)
  - **screen:** Widgets and screen layouts.
  - **state:** Contains state definitions or related utilities.


## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (version 3.0.0 or later recommended)
- An IDE with Flutter support (Android Studio, VS Code, etc.)
- [Android SDK](https://developer.android.com/studio) / [Xcode](https://developer.apple.com/xcode/) for platform-specific builds

### Installation

1. **Clone the Repository**
    ```bash
    git clone https://github.com/pworld/base-mobile-flutter
    ```

2. **Install Dependencies**

Run the following command in your project root:

   ```bash
    flutter pub get
    flutter run
  ```

### Notes

**Base Flutter coverage**:

- Login with Phone number or email
- OTP verification
- Base List
- Base use Maps in Flutter
- Simple Settings and Logout
  - Base Color can be change from root_app.dart:
       ```bash
        theme: FlexThemeData.light(scheme: FlexScheme.flutterDash, fontFamily: 'Poppins'),
        darkTheme: FlexThemeData.dark(scheme: FlexScheme.flutterDash, fontFamily: 'Poppins'),
        themeMode: ThemeMode.light, // Use dark or light theme based on system setting.
        ```

This base need API, but overall the structures is easy to duplicate and uses