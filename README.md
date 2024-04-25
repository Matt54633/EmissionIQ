
#  EmissionIQ

Artefact produced for final year project titled "Engineering a Gamified Mobile Application for Climate Change Awareness".

  ## Source Code
To execute EmissionIQ's source code, Xcode 15 is required. To run the project, open the EmissionIQ folder and then open the `EmissionIQ.xcodeproj` file. 

### Project Structure

The folder structure for the artefact is as follows:

 - Configuration - Config files required for API keys
 - View Modifiers - Modifiers that can be applied to a view to apply a specific style
 - Extensions - Extensions of types to add additional functionality
 - Structs - Custom structs to create custom types
 - TipKit - Tips used to highlight functionality throughout the application
 - Environment - Manager files required for private & public data and permissions 
 - Modules - Folders for each individual piece of app functionality, containing the MVVM structure for each
 - Resources - JSON files for data sources along with project assets
 - Supporting Files - Wrapper Views required for the application
 - Preview Content - Assets required for Xcode previews

## Installation Guide

The EmissionIQ Artefact cannot be run locally due to the iCloud data container being linked to my own Apple Developer Account. Therefore, to run the application please follow the instructions below. 

### Installation using TestFlight

 To run EmissionIQ, download Apple's Testflight application from the App Store: [TestFlight](https://testflight.apple.com). Then, once installed, follow this link: [EmissionIQ TestFlight Install](https://testflight.apple.com/join/SCHGVdfU). This link will redeem EmissionIQ and ask you to install the application through TestFlight. Once EmissionIQ is installed, you can run the app by tapping the icon on your Home Screen or by entering the TestFlight app and tapping `Open` next to EmissionIQ. 
 
## Other Information
EmissionIQ is a multi-platform, single-codebase application that can run on iPhones, iPads and Mac (Apple Silicon) devices. At least either iOS 17, iPadOS 17 or macOS Sonoma is required on a device to run the application.

Users' data is synced to their iCloud account so that their data persists across all of their devices. SwiftData models persist data on a user's device, and this is synced across devices using CloudKit. CloudKit is also employed to store each user's User and Level models in their own CloudKit private database. Each user has a `PublicUser` model stored in the CloudKit public database with the app being able to read from this database to provide public leaderboards. 
