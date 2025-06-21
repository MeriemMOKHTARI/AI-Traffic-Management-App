import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../cache/cachehelper.dart';
import '../../core/api/api_consumer.dart';
import '../../core/api/end_ponits.dart';
import '../../core/errors/exceptions.dart';
import '../../data/models/get_user_model.dart';
import '../../data/models/user_signin_model.dart';
import 'user_state.dart';

class SignInCubit extends Cubit<UserState> {
  SignInCubit(this.api) : super(UserInitial());
  final ApiConsumer api;

  GlobalKey<FormState> signInFormKey = GlobalKey();
  TextEditingController signInPhone = TextEditingController();
  TextEditingController signInPassword = TextEditingController();

  UserSignin? user;

  signIn() async {
    emit(SignInLoading());
    try {
      final response = await api.post(EndPoint.signIn, data: {
        // ApiKey.email: signInEmail.text,
        ApiKey.phone: signInPhone.text,
        ApiKey.password: signInPassword.text,
      });
      user = UserSignin.fromJson(response);


      try {
        final decodedToken = JwtDecoder.decode(user!.token);
        CacheHelper().saveData(key: ApiKey.token, value: user!.token);
        CacheHelper().saveData(key: ApiKey.id, value: decodedToken["user_id"]);
        print(decodedToken["user_id"]);
        emit(SignInSuccess());
      } catch (e) {
        emit(SignInFailure(errMessage: 'Invalid JWT token format'));
      }
    } on ServerException catch (e) {
      print("===============================");
      print(e.errModel.errorMessage);
      print("===============================");

      emit(SignInFailure(errMessage: e.errModel.errorMessage));
    }
  }

  getUserData() async {
    emit(GetprofileLoading());
    try {
      final response = await api.get(
        EndPoint.getUser(CacheHelper().getData(key: ApiKey.id)),
      );
      final user = GetUserModel.fromJson(response);
      print(  "===============================");
      print(user  );  
      print(  "===============================");
      emit(GetProfilesuccess(user: user));
    } on ServerException catch (e) {
      emit(GetprofileFailed(errMessage: e.errModel.errorMessage));
    } catch (e) {
      emit(GetprofileFailed(errMessage: e.toString()));
    }
  }
}
