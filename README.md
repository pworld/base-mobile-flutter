# Flutter Project

A Flutter project demonstrating a modular architecture for authentication. This project uses a feature-first folder structure, separating configuration, core logic, and features.

## Table of Contents

- [Overview](#overview)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Available Scripts](#available-scripts)
- [Notes](#notes)

## Overview

This project implements a modular architecture where each feature is isolated into its own folder. In this example, the `auth` feature is divided into:
- **data:** Contains models, data sources, and repositories.
- **domain:** Contains business logic, use cases, and domain entities.
- **presentation:** Contains UI components:
  - **provider:** State management logic (e.g., using Provider, Riverpod, etc.)
  - **screen:** Widgets and screen layouts.
  - **state:** Contains state definitions or related utilities.


## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (version 3.0.0 or later recommended)
- An IDE with Flutter support (Android Studio, VS Code, etc.)
- [Android SDK](https://developer.android.com/studio) / [Xcode](https://developer.apple.com/xcode/) for platform-specific builds

### Installation

1. **Clone the Repository**


2. **Install Dependencies**

Run the following command in your project root:

   ```bash
    flutter pub get
    flutter run

    ```