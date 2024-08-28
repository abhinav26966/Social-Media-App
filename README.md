# Social-Media-App

## Overview
This is a SwiftUI-based iOS application for a social media platform. The app provides user authentication functionality, including login and registration features, utilizing Firebase for backend services.

## Features
- User Authentication (Login and Registration)
- Profile Picture Upload
- Password Reset Functionality
- User Profile Creation

## Technologies Used
- SwiftUI
- Firebase
  - Firebase Authentication
  - Firebase Firestore
  - Firebase Storage
- PhotosUI


## Demo of the Project: 

https://github.com/user-attachments/assets/0a8ea606-ab17-4b4e-b9a9-c23a01001574

In the near future, I'll be implementing additional features and refining the user interface to enhance the overall user experience.

## Project Structure
The project consists of the following main components:

1. `ContentView.swift`: The entry point of the application, currently set to display the LoginView.

2. `LoginView.swift`: Handles user login and provides navigation to the registration view.

3. `RegisterView.swift`: Manages new user registration, including profile picture upload.

4. `User.swift`: Defines the User model structure used for Firestore database storage.

## Setup and Installation
1. Clone the repository
2. Install the necessary dependencies (Firebase SDK)
3. Set up a Firebase project and add your `GoogleService-Info.plist` file to the project
4. Build and run the project in Xcode

## Usage
Upon launching the app, users are presented with a login screen. New users can navigate to the registration screen to create an account. The registration process includes:
- Uploading a profile picture
- Setting a username
- Providing an email and password
- Adding a bio and an optional bio link

## Firebase Integration
The app uses Firebase for:
- User Authentication
- Storing user data in Firestore
- Storing profile images in Firebase Storage

## UI Components
The app uses custom SwiftUI view modifiers for consistent styling across the application, including:
- Custom text field styling
- Button styling
- Layout helpers (horizontal and vertical alignment)

## Future Enhancements
- Implement main feed functionality
- Add post creation and sharing features
- Develop user interaction capabilities (likes, comments, etc.)
- Implement user search and follow/unfollow functionality

## Contributors
- Abhinav Nagar
