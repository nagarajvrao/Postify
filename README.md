# Postify iOS App

An iOS application built with SwiftUI to display a list of posts. The app fetches posts from a remote API and supports pagination as the user scrolls. Users can tap on a post to view its details on a separate screen.

## Features

- Fetches and displays a list of posts from a remote API
- Supports pagination to load more posts as the user scrolls
- Displays detailed information when a post is tapped
- Efficient data loading and rendering using Combine and SwiftUI
- Optimized for performance with memoization and background computation

## Requirements

- iOS 14.0+
- Swift 5.*+

## Installation

### Using Xcode

1. Clone the repository:
    ```sh
    git clone https://github.com/yourusername/Postify.git
    ```

2. Open the project in Xcode:
    ```sh
    cd Postify
    open Postify.xcodeproj
    ```

3. Build and run the project on the simulator (or a physical device).

## Usage

1. Launch the app.
2. The home screen displays a list of posts fetched from a remote API.
3. Scroll to the bottom of the list to load more posts.
4. Tap on any post to view its details on a new screen.

## Architecture

The app follows the MVVM (Model-View-ViewModel) architecture pattern. It uses Combine for reactive programming and SwiftUI for building the user interface.

### Components

- **APIClient**: Handles network requests and data fetching.
- **PostService**: Provides functions to fetch posts and handle pagination.
- **PostVM**: Manages the state and business logic for the post list and detail views.
- **PostListView**: The main view displaying the list of posts.
- **PostDetailView**: The view displaying detailed information about a selected post.
- **PostRow**: A custom view representing a single post in the list.


## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

- [JSONPlaceholder](https://jsonplaceholder.typicode.com/) for providing a free fake online REST API for testing and prototyping.

## Contact

- Author: [Nagaraj V Rao](https://github.com/nagarajvrao)
- Email: ahuthavrao@gmail.com
