# todo_api.api.TodoApi

## Load the API package

```dart
import 'package:todo_api/api.dart';
```

All URIs are relative to *http://localhost:2023/todo*

Method | HTTP request | Description
------------- | ------------- | -------------
[**addTodo**](TodoApi.md#addtodo) | **POST** /v1/task/{userId} | Add a todo
[**deleteTodoById**](TodoApi.md#deletetodobyid) | **DELETE** /v1/task/ | Delete a Todo By Id
[**findAllTodosByAccountId**](TodoApi.md#findalltodosbyaccountid) | **
GET** /v1/task/{userId}/user | Find todos by userId
[**findAllTodosByTitleContaining**](TodoApi.md#findalltodosbytitlecontaining) | **
GET** /v1/task/{title}/title | Get a Todo By title
[**findTodoById**](TodoApi.md#findtodobyid) | **GET** /v1/task/{todoId} | Get Todo By Id
[**findTodos**](TodoApi.md#findtodos) | **GET** /v1/task | Get Todos in pages
[**restoreDeletedTodo**](TodoApi.md#restoredeletedtodo) | **
PUT** /v1/task/restore-deleted-todo/ | Restore a deleted Todo
[**updateTodo**](TodoApi.md#updatetodo) | **PUT** /v1/task/{userId} | Update Todo
[**uploadFile**](TodoApi.md#uploadfile) | **
POST** /v1/task/{userId}/uploadProfile | uploads an image

# **addTodo**

> TodoDTO addTodo(userId, todoDTO)

Add a todo

Add a todo

### Example

```dart
import 'package:todo_api/api.dart';

final api_instance = TodoApi();
final userId = 789; // int | 
final todoDTO = TodoDTO(); // TodoDTO | 

try {
    final result = api_instance.addTodo(userId, todoDTO);
    print(result);
} catch (e) {
    print('Exception when calling TodoApi->addTodo: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
**userId** | **int**|  | [default to 2014098616]
**todoDTO** | [**TodoDTO**](TodoDTO.md)|  |

### Return type

[**TodoDTO**](TodoDTO.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json, */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteTodoById**

> DefaultResponse deleteTodoById(id, userId)

Delete a Todo By Id

Delete a Todo

### Example

```dart
import 'package:todo_api/api.dart';

final api_instance = TodoApi();
final id = 789; // int | 
final userId = 789; // int | 

try {
    final result = api_instance.deleteTodoById(id, userId);
    print(result);
} catch (e) {
    print('Exception when calling TodoApi->deleteTodoById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
**id** | **int**|  | [default to 1]
**userId** | **int**|  | [default to 2014098616]

### Return type

[**DefaultResponse**](DefaultResponse.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json, */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **findAllTodosByAccountId**

> List<TodoDTO> findAllTodosByAccountId(userId)

Find todos by userId

Find todos by userId

### Example

```dart
import 'package:todo_api/api.dart';

final api_instance = TodoApi();
final userId = 789; // int | 

try {
    final result = api_instance.findAllTodosByAccountId(userId);
    print(result);
} catch (e) {
    print('Exception when calling TodoApi->findAllTodosByAccountId: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
**userId** | **int**|  | [default to 2014098616]

### Return type

[**List<TodoDTO>**](TodoDTO.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json, */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **findAllTodosByTitleContaining**

> List<TodoDTO> findAllTodosByTitleContaining(title)

Get a Todo By title

Get a Todo

### Example

```dart
import 'package:todo_api/api.dart';

final api_instance = TodoApi();
final title = title_example; // String | 

try {
    final result = api_instance.findAllTodosByTitleContaining(title);
    print(result);
} catch (e) {
    print('Exception when calling TodoApi->findAllTodosByTitleContaining: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
**title** | **String**|  |

### Return type

[**List<TodoDTO>**](TodoDTO.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json, */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **findTodoById**

> TodoDTO findTodoById(todoId)

Get Todo By Id

Get Todo

### Example

```dart
import 'package:todo_api/api.dart';

final api_instance = TodoApi();
final todoId = 789; // int | 

try {
    final result = api_instance.findTodoById(todoId);
    print(result);
} catch (e) {
    print('Exception when calling TodoApi->findTodoById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
**todoId** | **int**|  | [default to 1]

### Return type

[**TodoDTO**](TodoDTO.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json, */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **findTodos**

> PageTodoDTO findTodos(pageNo, pageSize, sortBy, dir)

Get Todos in pages

Get Todos

### Example

```dart
import 'package:todo_api/api.dart';

final api_instance = TodoApi();
final pageNo = 56; // int | 
final pageSize = 56; // int | 
final sortBy = sortBy_example; // String | 
final dir = dir_example; // String | 

try {
    final result = api_instance.findTodos(pageNo, pageSize, sortBy, dir);
    print(result);
} catch (e) {
    print('Exception when calling TodoApi->findTodos: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
**pageNo** | **int**|  | [optional] [default to 0]
**pageSize** | **int**|  | [optional] [default to 10]
**sortBy** | **String**|  | [optional] [default to 'name']
**dir** | **String**|  | [optional] [default to 'asc']

### Return type

[**PageTodoDTO**](PageTodoDTO.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json, */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **restoreDeletedTodo**

> DefaultResponse restoreDeletedTodo(id, userId)

Restore a deleted Todo

Restore a deleted Todo

### Example

```dart
import 'package:todo_api/api.dart';

final api_instance = TodoApi();
final id = 789; // int | 
final userId = 789; // int | 

try {
    final result = api_instance.restoreDeletedTodo(id, userId);
    print(result);
} catch (e) {
    print('Exception when calling TodoApi->restoreDeletedTodo: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
**id** | **int**|  | [default to 1]
**userId** | **int**|  | [default to 2014098616]

### Return type

[**DefaultResponse**](DefaultResponse.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json, */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateTodo**

> updateTodo(userId, todoDTO)

Update Todo

Update a Todo

### Example

```dart
import 'package:todo_api/api.dart';

final api_instance = TodoApi();
final userId = 789; // int | 
final todoDTO = TodoDTO(); // TodoDTO | 

try {
    api_instance.updateTodo(userId, todoDTO);
} catch (e) {
    print('Exception when calling TodoApi->updateTodo: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
**userId** | **int**|  |
**todoDTO** | [**TodoDTO**](TodoDTO.md)|  |

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json, */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **uploadFile**

> DefaultResponse uploadFile(userId, profileImage)

uploads an image

### Example

```dart
import 'package:todo_api/api.dart';

final api_instance = TodoApi();
final userId = 789; // int | UserId of a user to update
final profileImage = BINARY_DATA_HERE; // MultipartFile | 

try {
    final result = api_instance.uploadFile(userId, profileImage);
    print(result);
} catch (e) {
    print('Exception when calling TodoApi->uploadFile: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
**userId** | **int**| UserId of a user to update | [default to 2014098616]
**profileImage** | **MultipartFile**|  | [optional]

### Return type

[**DefaultResponse**](DefaultResponse.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: multipart/form-data
- **Accept**: application/json, */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

