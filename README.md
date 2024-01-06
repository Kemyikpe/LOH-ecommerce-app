# loh_ecommerce_app

A new Flutter project.

## Project Setup Documentation


## INTRODUCTION
This document serves as a guide for setting up and maintaining the Ecommerce App Flutter project. 
The project is designed to be a mobile application for ecommerce purposes, with product listing page.
The  application  allows users to browse through products, and sort products based on different criteria.


### Devices Used
1. Samsung A71, <br>
   Android Version: 11, <br>
   Device Resolution: 1440x3120<br>
   Internal memory: 6GB

2. Pixel A4 (Emulator) <br>
   Android Version: 12, <br>
   Device Resolution: 1080 x 2340<br>
   Internal memory: 1.5GB

## METHODOLOGY
 *IDE (Android Studio)
 *Dart/Flutter: Application programming language and framework.
 *Project Initialization
[ Clone the project repository:(https://github.com/Kemyikpe/LOH-ecommerce-app.git)]

### Project Objective
The primary purpose is to create a user-friendly e-commerce product listing page.
It is intended to allow users browse through products and sort products based on different criteria.

## PREREQUISITES
To set up the project, ensure that you have the following installed:
 * Flutter SDK
 * Dart SDK
 * Android Studio installed
 * Git

## DEPENDENCIES
These are the project dependencies added in the pubspec.yaml file. 
 * provider: ^6.1.1
 * get_it: ^7.6.4
 * google_fonts: ^6.1.0

 ## State Management
 I used Provider for state management. <br> I added the `provider: ^6.1.1` dependency in the `pubspec.yaml` file, synced the project with `pub get`. then created the `BaseViewModel` and `BaseView` class to handle the state and the `ChangeNotifierProvider` respectfully. The `BaseViewModel` can be extended in any viewmodel class to manage state.

## PROJECT STRUCTURE
lib/ <br>
|-- main.dart <br>
|-- enum/ <br>
|   |-- filter_criteria.dart <br>
|   |-- view_state.dart <br>
|-- models/ <br>
|   |-- list_item.dart <br>
|   |-- list_item.dart <br>
|-- routes/ <br>
|   |-- locator.dart <br>
|   |-- routes.dart <br>
|-- services/ <br>
|   |-- navigation.dart <br>
|-- utils/ <br>
|   |-- softKey_focus.dart <br>
|   |-- app_image.dart <br>
|-- views/components <br>
|   |-- route_error_page.dart <br>
|   |-- search_bar.dart <br>
|   |-- tab_chip_view.dart <br>
|   |-- tab_content_view.dart <br>
|   |-- text_field.dart <br>
|-- view_model/ <br>
|   |-- app_view_model.dart <br>
|   |-- base_view.dart <br>
|   |-- base_view_model.dart <br>
|-- chip_item.dart <br>
|-- filter_bottom_sheet.dart <br>
|-- filter_item.dart <br>
|-- main.dart 


## Screen Recording

https://github.com/Kemyikpe/LOH-ecommerce-app/assets/107570182/85246a6d-fba2-459f-9840-0410d4863247








