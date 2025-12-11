import 'package:dio/dio.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/auth/register/bloc/register_state.dart';

import '../../../../api/auth_service.dart';
import '../../../../model/register_response.dart';
import 'register_event.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  RegisterBloc() : super(RegisterInitial()) {
    on<CreateAccountEvent>((event, emit) async {
      emit(RegisterLoading());
   
      try {
        await AuthService.register(
          email: event.email,
          password: event.password,
          name: event.name,
          phone: '+${event.phone}',
          confirmPassword: event.confirmPassword,
          avaterId: event.avaterId,
        );
        emit(RegisterSuccess());
      } on DioException catch (e) {
        if (e.response != null && e.response?.data != null) {
          final errorResponse = RegisterResponse.fromJson(e.response!.data);
          String message = "";
          if (errorResponse.message is List) {
            message = (errorResponse.message as List).join("\n");
          } else {
            message =
                errorResponse.message?.toString() ??
                errorResponse.error ??
                "Unknown error occurred";
          }
          emit(RegisterError(message));
        } else {
          emit(RegisterError('Unknown error: ${e.message}'));
        }
      } catch (e) {
        emit(RegisterError('Unexpected error: $e'));
      }
    });
  }
}
