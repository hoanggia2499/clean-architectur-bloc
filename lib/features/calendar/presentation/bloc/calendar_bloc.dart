import 'dart:async';

import 'package:base_project/core/usecase.dart';
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
      final result = await getProductsUseCase.call(NoParams());
      result.fold(
        (failure) {
          if (failure is ServerFailure) {
            emit(CalendarFailure(message: failure.message));
          } else {
            emit(const CalendarFailure(
                message: 'An unexpected error occurred.'));
          }
        },
        (productListEntity) =>
            emit(CalendarSuccess(productListEntity: productListEntity)),
      );
    } catch (e) {
      emit(CalendarFailure(message: e.toString()));
    }
  }
}
