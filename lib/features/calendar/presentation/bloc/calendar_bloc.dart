import 'dart:async';

import 'package:base_project/core/bloc/bloc_usecase_helper.dart';
import 'package:base_project/core/usecase.dart';
import 'package:base_project/core/utils/loading.dart';
import 'package:base_project/features/calendar/domain/entities/product_list_entity.dart';
import 'package:base_project/features/calendar/domain/usecases/get_products_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error.dart';
part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final GetProductsUseCase getProductsUseCase;
  CalendarBloc(this.getProductsUseCase) : super(CalendarInitial()) {
    on<CalendarPageInitialized>(_onTabChangeEvent);
    on<AllProductsReceived>(_onGetAllProducts);
  }

  FutureOr<void> _onTabChangeEvent(
      CalendarPageInitialized event, Emitter<CalendarState> emit) async {
    try {
      emit(CalendarLoading());
      add(AllProductsReceived());
    } catch (e) {
      emit(CalendarFailure(message: e.toString()));
    }
  }

  FutureOr<void> _onGetAllProducts(
      AllProductsReceived event, Emitter<CalendarState> emit) async {
    try {
      getProductsUseCase(NoParams()).foldAndEmit(
        bloc: this,
        emit: emit,
        onSuccess: (productList) =>
            CalendarSuccess(productListEntity: productList),
        onFailure: (message) => CalendarFailure(message: message),
      );
    } catch (e) {
      emit(CalendarFailure(message: e.toString()));
    }
  }
}
