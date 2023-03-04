import 'package:todo_api/todo_api.dart';

class PageData {
  final int totalPages;
  final int pageSize;
  final int pageNo;
  final int totalElements;

  const PageData({
    this.totalPages = 0,
    this.pageSize = 0,
    this.pageNo = 0,
    this.totalElements = 0,
  });

  factory PageData.fromPage(PageTaskDTO? pages) {
    if (pages == null) return PageData();

    return PageData(
      totalPages: pages.totalPages!,
      pageNo: pages.number!,
      pageSize: pages.size!,
      totalElements: pages.totalElements!,
    );
  }

  @override
  String toString() =>
      'PageData[totalPages=$totalPages, pageSize=$pageSize, pageNo=$pageNo, totalElements=$totalElements]';
}
