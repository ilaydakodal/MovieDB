# MovieDB 

[![Swift Version](https://img.shields.io/badge/Swift-5-orange.svg)](https://swift.org) [![Xcode Version](https://img.shields.io/badge/Xcode-14.3-blue.svg)](https://developer.apple.com/xcode) [![iOS Deployment Target](https://img.shields.io/badge/iOS-16-green.svg)](https://developer.apple.com/ios)

 MovieDB is an iOS app that allows users to search for movies and view movie details. It follows the MVVM-C (Model-View-ViewModel-Coordinator) architecture pattern and utilizes the [TMDB API](https://developers.themoviedb.org/) API as the data source.
 
- **Developers Note:** Please note that this project is not completed a %100 due to time constraints. The detail view isn't complete, and there are still to-do marks and unresolved issues, such as some error handling.

## Screenshots

<img width="200" alt="screenShot2" src="https://github.com/ilaydakodal/MovieDB/assets/45633668/527d27f8-0d71-4ba6-8b75-078c559a6044">
<img width="200" alt="screenShot3" src="https://github.com/ilaydakodal/MovieDB/assets/45633668/077ca71c-ee3f-4da1-81a9-622b8d7185e7">
<img width="200" alt="screenShot3" src="https://github.com/ilaydakodal/MovieDB/assets/45633668/55ccc2dd-f850-4e75-833f-41e01ad7627e">


## Requirements

- Xcode 14.3 or later
- Swift 5
- iOS 16 or later

## Installation


1. Clone the repository:
```shell
git clone https://git@github.com:ilaydakodal/MovieDB.git
```

2. Open the project in Xcode:
cd MovieDB 
open MovieDB.xcodeproj

3. Build and run the app using the Xcode simulator or by connecting a physical device.

## API Integration

MovieDB uses the themoviedb.org API to search for movies and retrieve movie details. It makes use of the following endpoints:

- Search Movies: `developers.themoviedb.org/3/search/search-movies`
  - This endpoint is used to search for movies based on user input.

- Get Movie Details: `developers.themoviedb.org/3/movies/get-movie-details`
  - This endpoint is used to fetch detailed information about a specific movie.

To integrate the API into the app, you will need to obtain an API key from themoviedb.org and configure it in the app's code.

## Architecture

MovieDB follows the MVVM-C (Model-View-ViewModel-Coordinator) architecture pattern. It separates the concerns of data, UI, and navigation into distinct components:

- Model: Represents the data structure and business logic of the app.
- View: Handles the UI and user interactions.
- ViewModel: Mediates the communication between the Model and View, providing data for the UI and handling user actions.
- Coordinator: Manages the navigation flow between different screens or modules.

The app's codebase is organized into corresponding folders for each component, following a modular structure.
