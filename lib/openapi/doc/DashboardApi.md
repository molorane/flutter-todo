# todo_api.api.DashboardApi

## Load the API package

```dart
import 'package:todo_api/api.dart';
```

All URIs are relative to *http://localhost:2023/todo*

Method | HTTP request | Description
------------- | ------------- | -------------
[**countDeletedTodosByAccountId**](DashboardApi.md#countdeletedtodosbyaccountid) | **
GET** /v1/task/dashboard/deleted-todo/{userId} | Count all deleted todos

# **countDeletedTodosByAccountId**

> int countDeletedTodosByAccountId(userId)

Count all deleted todos

Count all deleted todos

### Example

```dart
import 'package:todo_api/api.dart';

final api_instance = DashboardApi();
final userId = 789; // int | 

try {
    final result = api_instance.countDeletedTodosByAccountId(userId);
    print(result);
} catch (e) {
    print('Exception when calling DashboardApi->countDeletedTodosByAccountId: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
**userId** | **int**|  | [default to 2014098616]

### Return type

**int**

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json, */*

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

