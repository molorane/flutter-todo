# todo_api

This is an api-spec for `todo` service.

This Dart package is automatically generated by
the [OpenAPI Generator](https://openapi-generator.tech) project:

- API version: 0.0.1
- Build package: org.openapitools.codegen.languages.DartClientCodegen

## Requirements

Dart 2.12 or later

## Installation & Usage

### Github

If this Dart package is published to Github, add the following dependency to your pubspec.yaml

```
dependencies:
  todo_api:
    git: https://github.com/GIT_USER_ID/GIT_REPO_ID.git
```

### Local

To use the package in your local drive, add the following dependency to your pubspec.yaml

```
dependencies:
  todo_api:
    path: /path/to/todo_api
```

## Tests

TODO

## Getting Started

Please follow the [installation procedure](#installation--usage) and then run the following:

```dart
import 'package:todo_api/api.dart';


final api_instance = DashboardApi();
final userId = 789; // int | 

try {
    final result = api_instance.countDeletedTasksByAccountId(userId);
    print(result);
} catch (e) {
    print('Exception when calling DashboardApi->countDeletedTasksByAccountId: $e\n');
}

```

## Documentation for API Endpoints

All URIs are relative to *http://localhost:2023/todo*

Class | Method | HTTP request | Description
------------ | ------------- | ------------- | -------------
*DashboardApi* | [**
countDeletedTasksByAccountId**](doc//DashboardApi.md#countdeletedtodosbyaccountid) | **
GET** /v1/task/dashboard/deleted-todo/{userId} | Count all deleted todos
*TaskApi* | [**addTask**](doc//TaskApi.md#addtodo) | **POST** /v1/task/{userId} | Add a todo
*TaskApi* | [**deleteTaskById**](doc//TaskApi.md#deletetodobyid) | **
DELETE** /v1/task/ | Delete a Task By Id
*TaskApi* | [**findAllTasksByAccountId**](doc//TaskApi.md#findalltodosbyaccountid) | **
GET** /v1/task/{userId}/user | Find todos by userId
*TaskApi* | [**findAllTasksByTitleContaining**](doc//TaskApi.md#findalltodosbytitlecontaining) | **
GET** /v1/task/{title}/title | Get a Task By title
*TaskApi* | [**findTaskById**](doc//TaskApi.md#findtodobyid) | **
GET** /v1/task/{todoId} | Get Task By Id
*TaskApi* | [**findTasks**](doc//TaskApi.md#findtodos) | **GET** /v1/task | Get Tasks in pages
*TaskApi* | [**restoreDeletedTask**](doc//TaskApi.md#restoredeletedtodo) | **
PUT** /v1/task/restore-deleted-todo/ | Restore a deleted Task
*TaskApi* | [**updateTask**](doc//TaskApi.md#updatetodo) | **PUT** /v1/task/{userId} | Update Task
*TaskApi* | [**uploadFile**](doc//TaskApi.md#uploadfile) | **
POST** /v1/task/{userId}/uploadProfile | uploads an image

## Documentation For Models

- [DefaultResponse](doc//DefaultResponse.md)
- [PageTaskDTO](doc//PageTaskDTO.md)
- [PageableObject](doc//PageableObject.md)
- [SortObject](doc//SortObject.md)
- [TaskDTO](doc//TaskDTO.md)

## Documentation For Authorization

All endpoints do not require authorization.

## Author

molorane.mothusi@gmail.com

