# Strict MVVM Product Listing App (Swift UIKit)

This project demonstrates a clean and strict Model-View-ViewModel (MVVM) architecture for a basic product listing application built using Swift and UIKit. It focuses on clear separation of concerns, testability, and maintainability.

## Key Features

* Displays a list of products fetched from a remote API.
* Utilizes a custom `UITableViewCell` for presenting product information.
* Implements pull-to-refresh functionality to reload product data.
* Shows a loading indicator while fetching data.
* Displays an error message if product loading fails.
* Provides navigation to a detailed view of a selected product.
* Strict adherence to the MVVM architectural pattern.
* Dependency management using Cocoapods.
* Includes comprehensive Unit Tests using XCTest.

## Architecture

This project follows the **Model-View-ViewModel (MVVM)** architectural pattern:

* **Model:** Represents the application's data and business logic (`Product.swift`, `ProductResponse.swift`). It is responsible for fetching and managing data.
* **View:** The user interface layer (`ProductListViewController.swift`, `ProductDetailsViewController.swift`, custom `ProductTableViewCell`). Views are passive and observe changes in the ViewModel to update themselves. They send user actions to the ViewModel.
* **ViewModel:** Acts as a bridge between the Model and the View (`ProductListViewModel.swift`). It exposes data in a format that the View can easily consume and contains the presentation logic. It does not have any direct dependency on UIKit.
* **Service:** Handles external data sources, such as network requests (`ProductService.swift`, `IProductService.swift` protocol). The ViewModel interacts with the Service protocol for data fetching, promoting testability.
* **Output Protocol:** The `ProductListViewModelOutput` protocol defines a clear contract for how the ViewModel communicates updates (data updates, loading state, errors) to its observer (the View), further decoupling the layers.

## Dependencies

This project uses the following dependencies, managed by **Cocoapods**:

* **Alamofire:** For making HTTP network requests.
* **Kingfisher:** For asynchronous image loading and caching.

To install these dependencies, navigate to the project directory in your terminal and run:

```bash
pod install
```

## Unit Tests
The project includes a comprehensive set of Unit Tests written using XCTest. These tests focus on verifying the logic within the ProductListViewModel in isolation, ensuring its correctness and resilience.

You can run the unit tests within Xcode by:

Opening the project (.xcworkspace after running pod install).
Navigating to the Test navigator (the fourth icon in the left sidebar).
Selecting the ProductUIKitAppTests target.
Pressing Cmd + U or selecting "Product" -> "Test" from the Xcode menu.
The tests cover various scenarios, including successful data loading, failure cases, and verifying the ViewModel's state updates.

Getting Started
Clone the repository:
```
git clone <repository_url>
cd <repository_directory>
```

## Project Structure
```
ProductUIKitApp/
├── AppConstants.swift          # Defines UI constants (colors, typography, padding)
├── AppDelegate.swift
├── Model/
│   ├── Product.swift
│   └── ProductResponse.swift
├── Services/
│   ├── IProductService.swift    # Protocol for the product service
│   └── ProductService.swift     # Implementation of the product service
├── View/
│   ├── ProductDetailsViewController.swift
│   ├── ProductListViewController.swift
│   └── ProductTableViewCell.swift # Custom cell for product listing
├── ViewModel/
│   ├── ProductListViewModelOutput.swift # Protocol for ViewModel output
│   └── ProductListViewModel.swift
├── Assets.xcassets/
├── Info.plist
└── ...
ProductUIKitAppTests/
├── MockProductService.swift   # Mock implementation for testing
└── ProductListViewModelTests.swift # Unit tests for the ViewModel
Podfile
Podfile.lock
...
```

## Considerations for Potential Employers
This project demonstrates:

**Architectural Proficiency:** A strong understanding and implementation of the MVVM pattern for building scalable and maintainable iOS applications.
**Clean Code Practices:** Adherence to clean coding principles with well-structured and commented code.
**UI Development Skills:** Experience with UIKit, custom UITableViewCell creation, and basic UI styling.
**Asynchronous Operations:** Handling of network requests and image loading asynchronously for a smooth user experience.
**Dependency Management:** Familiarity with Cocoapods for managing project dependencies.
**Testing:** Commitment to writing unit tests to ensure code quality and reliability.
**Separation of Concerns:** Clear division of responsibilities between different components of the application.
**Protocol-Oriented Programming:** Use of protocols (IProductService, ProductListViewModelOutput) to promote decoupling and testability.
This project serves as a solid foundation and showcases my ability to develop well-structured and testable iOS applications following modern architectural patterns.

Author
[Zeeshan Shakeel]
[https://www.linkedin.com/in/zeeshakeel/]




