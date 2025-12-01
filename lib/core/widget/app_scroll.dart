import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Giả định: Events và States của bạn
abstract class ScrollEvent {}
class LoadMoreEvent extends ScrollEvent {}

abstract class ScrollState {}
class DataLoadedState extends ScrollState {
  final List<String> items;
  DataLoadedState({required this.items});
}
class ScrollInitial extends ScrollState {}


class ScrollBloc extends Bloc<ScrollEvent, ScrollState> {
  // ⭐️ 1. Khai báo ScrollController
  late final ScrollController _scrollController;

  // Các biến logic Loadmore
  bool _isLoading = false;

  // Hàm xử lý logic Loadmore/Scroll
  void _onScrollListener() {
    // Logic: Nếu cuộn gần cuối và không đang tải, bắn sự kiện LoadMore
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent * 0.9 && !_isLoading) {
      add(LoadMoreEvent());
    }
  }

  ScrollBloc() : super(ScrollInitial()) {
    // ⭐️ 2. Khởi tạo ScrollController và gắn Listener
    _scrollController = ScrollController()..addListener(_onScrollListener);

    // Xử lý sự kiện LoadMore
    on<LoadMoreEvent>((event, emit) async {
      if (_isLoading) return;
      _isLoading = true;

      // Giả lập tải dữ liệu
      await Future.delayed(const Duration(milliseconds: 500));
      final currentState = (state as DataLoadedState).items;
      final newItems = List.generate(5, (index) => 'New Item ${currentState.length + index}');

      emit(DataLoadedState(items: [...currentState, ...newItems]));
      _isLoading = false;
    });

    // Khởi tạo dữ liệu ban đầu
    emit(DataLoadedState(items: ['Item 1', 'Item 2', 'Item 3']));
  }

  // =======================================================
  // 🚨 3. CƠ CHẾ DISPOSE CỦA BLOC: OVERRIDE close()
  // =======================================================
  @override
  Future<void> close() {
    // ⭐️ A. Ngắt Listener trước khi Dispose
    _scrollController.removeListener(_onScrollListener);

    // ⭐️ B. Gọi dispose() để giải phóng tài nguyên hệ thống
    _scrollController.dispose();

    // ⭐️ C. Gọi close() của lớp cha để hoàn tất việc dọn dẹp BLoC
    return super.close();
  }

  // Getter để UI có thể truy cập Controller
  ScrollController get scrollController => _scrollController;
}