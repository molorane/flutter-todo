//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TodoApi {
  TodoApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Add a todo
  ///
  /// Add a todo
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] userId (required):
  ///
  /// * [TodoDTO] todoDTO (required):
  Future<Response> addTodoWithHttpInfo(
    int userId,
    TodoDTO todoDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/task/{userId}'.replaceAll('{userId}', userId.toString());

    // ignore: prefer_final_locals
    Object? postBody = todoDTO;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Add a todo
  ///
  /// Add a todo
  ///
  /// Parameters:
  ///
  /// * [int] userId (required):
  ///
  /// * [TodoDTO] todoDTO (required):
  Future<TodoDTO?> addTodo(
    int userId,
    TodoDTO todoDTO,
  ) async {
    final response = await addTodoWithHttpInfo(
      userId,
      todoDTO,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'TodoDTO',
      ) as TodoDTO;
    }
    return null;
  }

  /// Delete a Todo By Id
  ///
  /// Delete a Todo
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] id (required):
  ///
  /// * [int] userId (required):
  Future<Response> deleteTodoByIdWithHttpInfo(
    int id,
    int userId,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/task/';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    queryParams.addAll(_queryParams('', 'id', id));
    queryParams.addAll(_queryParams('', 'userId', userId));

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Delete a Todo By Id
  ///
  /// Delete a Todo
  ///
  /// Parameters:
  ///
  /// * [int] id (required):
  ///
  /// * [int] userId (required):
  Future<DefaultResponse?> deleteTodoById(
    int id,
    int userId,
  ) async {
    final response = await deleteTodoByIdWithHttpInfo(
      id,
      userId,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'DefaultResponse',
      ) as DefaultResponse;
    }
    return null;
  }

  /// Find todos by userId
  ///
  /// Find todos by userId
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] userId (required):
  Future<Response> findAllTodosByAccountIdWithHttpInfo(
    int userId,
  ) async {
    // ignore: prefer_const_declarations
    final path =
        r'/v1/task/{userId}/user'.replaceAll('{userId}', userId.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Find todos by userId
  ///
  /// Find todos by userId
  ///
  /// Parameters:
  ///
  /// * [int] userId (required):
  Future<List<TodoDTO>?> findAllTodosByAccountId(
    int userId,
  ) async {
    final response = await findAllTodosByAccountIdWithHttpInfo(
      userId,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<TodoDTO>')
              as List)
          .cast<TodoDTO>()
          .toList();
    }
    return null;
  }

  /// Get a Todo By title
  ///
  /// Get a Todo
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] title (required):
  Future<Response> findAllTodosByTitleContainingWithHttpInfo(
    String title,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/task/{title}/title'.replaceAll('{title}', title);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get a Todo By title
  ///
  /// Get a Todo
  ///
  /// Parameters:
  ///
  /// * [String] title (required):
  Future<List<TodoDTO>?> findAllTodosByTitleContaining(
    String title,
  ) async {
    final response = await findAllTodosByTitleContainingWithHttpInfo(
      title,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<TodoDTO>')
              as List)
          .cast<TodoDTO>()
          .toList();
    }
    return null;
  }

  /// Get Todo By Id
  ///
  /// Get Todo
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] todoId (required):
  Future<Response> findTodoByIdWithHttpInfo(
    int todoId,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/task/{todoId}'.replaceAll('{todoId}', todoId.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get Todo By Id
  ///
  /// Get Todo
  ///
  /// Parameters:
  ///
  /// * [int] todoId (required):
  Future<TodoDTO?> findTodoById(
    int todoId,
  ) async {
    final response = await findTodoByIdWithHttpInfo(
      todoId,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'TodoDTO',
      ) as TodoDTO;
    }
    return null;
  }

  /// Get Todos in pages
  ///
  /// Get Todos
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] pageNo:
  ///
  /// * [int] pageSize:
  ///
  /// * [String] sortBy:
  ///
  /// * [String] dir:
  Future<Response> findTodosWithHttpInfo({
    int? pageNo,
    int? pageSize,
    String? sortBy,
    String? dir,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/task';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (pageNo != null) {
      queryParams.addAll(_queryParams('', 'pageNo', pageNo));
    }
    if (pageSize != null) {
      queryParams.addAll(_queryParams('', 'pageSize', pageSize));
    }
    if (sortBy != null) {
      queryParams.addAll(_queryParams('', 'sortBy', sortBy));
    }
    if (dir != null) {
      queryParams.addAll(_queryParams('', 'dir', dir));
    }

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get Todos in pages
  ///
  /// Get Todos
  ///
  /// Parameters:
  ///
  /// * [int] pageNo:
  ///
  /// * [int] pageSize:
  ///
  /// * [String] sortBy:
  ///
  /// * [String] dir:
  Future<PageTodoDTO?> findTodos({
    int? pageNo,
    int? pageSize,
    String? sortBy,
    String? dir,
  }) async {
    final response = await findTodosWithHttpInfo(
      pageNo: pageNo,
      pageSize: pageSize,
      sortBy: sortBy,
      dir: dir,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'PageTodoDTO',
      ) as PageTodoDTO;
    }
    return null;
  }

  /// Restore a deleted Todo
  ///
  /// Restore a deleted Todo
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] id (required):
  ///
  /// * [int] userId (required):
  Future<Response> restoreDeletedTodoWithHttpInfo(
    int id,
    int userId,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/task/restore-deleted-todo/';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    queryParams.addAll(_queryParams('', 'id', id));
    queryParams.addAll(_queryParams('', 'userId', userId));

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'PUT',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Restore a deleted Todo
  ///
  /// Restore a deleted Todo
  ///
  /// Parameters:
  ///
  /// * [int] id (required):
  ///
  /// * [int] userId (required):
  Future<DefaultResponse?> restoreDeletedTodo(
    int id,
    int userId,
  ) async {
    final response = await restoreDeletedTodoWithHttpInfo(
      id,
      userId,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'DefaultResponse',
      ) as DefaultResponse;
    }
    return null;
  }

  /// Update Todo
  ///
  /// Update a Todo
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] userId (required):
  ///
  /// * [TodoDTO] todoDTO (required):
  Future<Response> updateTodoWithHttpInfo(
    int userId,
    TodoDTO todoDTO,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/task/{userId}'.replaceAll('{userId}', userId.toString());

    // ignore: prefer_final_locals
    Object? postBody = todoDTO;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'PUT',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Update Todo
  ///
  /// Update a Todo
  ///
  /// Parameters:
  ///
  /// * [int] userId (required):
  ///
  /// * [TodoDTO] todoDTO (required):
  Future<void> updateTodo(
    int userId,
    TodoDTO todoDTO,
  ) async {
    final response = await updateTodoWithHttpInfo(
      userId,
      todoDTO,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// uploads an image
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] userId (required):
  ///   UserId of a user to update
  ///
  /// * [MultipartFile] profileImage:
  Future<Response> uploadFileWithHttpInfo(
    int userId, {
    MultipartFile? profileImage,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/task/{userId}/uploadProfile'
        .replaceAll('{userId}', userId.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['multipart/form-data'];

    bool hasFields = false;
    final mp = MultipartRequest('POST', Uri.parse(path));
    if (profileImage != null) {
      hasFields = true;
      mp.fields[r'profileImage'] = profileImage.field;
      mp.files.add(profileImage);
    }
    if (hasFields) {
      postBody = mp;
    }

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// uploads an image
  ///
  /// Parameters:
  ///
  /// * [int] userId (required):
  ///   UserId of a user to update
  ///
  /// * [MultipartFile] profileImage:
  Future<DefaultResponse?> uploadFile(
    int userId, {
    MultipartFile? profileImage,
  }) async {
    final response = await uploadFileWithHttpInfo(
      userId,
      profileImage: profileImage,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'DefaultResponse',
      ) as DefaultResponse;
    }
    return null;
  }
}
