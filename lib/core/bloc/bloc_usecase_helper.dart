// lib/core/bloc/bloc_usecase_helper.dartimport 'package:dartz/dartz.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:base_project/core/error.dart';

import '../utils/loading.dart';

/// An extension on UseCase results to simplify handling in BLoC.
extension BlocUseCaseRunner<T> on Future<Either<Failure, T>> {
  /// Awaits the UseCase, folds the result, emits the appropriate state,
  /// and can trigger subsequent events on success.
  ///
  /// - [bloc]: The BLoC instance to which new events will be added.
  /// - [emit]: The BLoC's emitter function.
  /// - [onSuccess]: A function that takes the successful data [T] and returns the success state.
  /// - [onFailure]: A function that takes the error message and returns the failure state.
  /// - [onSuccessThenAdd]: An optional function that takes the successful data [T]
  ///   and returns a list of events to be added to the BLoC.
  Future<void> foldAndEmit<E, S>({
    required Bloc<E, S> bloc,
    required Emitter<S> emit,
    required S Function(T data) onSuccess,
    required S Function(String message) onFailure,
    List<E> Function(T data)? onSuccessThenAdd,
  }) async {
    AppLoading.loading(() async {
      then((result) {
        result.fold(
          (failure) {
            if (failure is ServerFailure) {
              emit(onFailure(failure.message));
            } else {
              // Handle other potential failure types here if needed
              emit(onFailure('An unexpected error occurred.'));
            }
          },
          (data) {
            // First, emit the success state.
            emit(onSuccess(data));
            // Then, if provided, create and add subsequent events.
            if (onSuccessThenAdd != null) {
              final eventsToAdd = onSuccessThenAdd(data);
              for (final event in eventsToAdd) {
                bloc.add(event);
              }
            }
          },
        );
      });
    });
  }
}
