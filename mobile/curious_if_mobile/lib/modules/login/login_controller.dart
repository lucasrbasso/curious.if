import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../core/core.dart';
import '../../domain/login/model/login_model.dart';
import '../../domain/login/model/user_model.dart';
import '../../domain/login/usecase/login_usecase.dart';
import 'login_state.dart';
part 'login_controller.g.dart';

class LoginController extends _LoginControllerBase with _$LoginController {
  LoginController({ILoginUseCase? loginUseCase}) {
    _loginUseCase = loginUseCase ?? LoginUseCase();
  }
}

abstract class _LoginControllerBase with Store {
  late ILoginUseCase _loginUseCase;

  late ReactionDisposer disposer;

  @observable
  LoginState state = LoginStateEmpty();

  @action
  Future<void> _modifyLoginState(LoginState state) async => this.state = state;

  @action
  Future<void> login({required LoginModel loginModel}) async {
    try {
      await _modifyLoginState(LoginStateLoading());
      await Future.delayed(Duration(seconds: 4));
      UserModel user = await _loginUseCase.login(loginModel);
      await _modifyLoginState(LoginStateSuccess(user: user));
    } catch (e) {
      await _modifyLoginState(LoginStateFailure(message: e.toString()));
      if (kDebugMode) print(e);
    }
  }

  // FUNÇÃO PARA ABRIR O SNACKBAR
  void showSnackBar(BuildContext context, String text, Color color) {
    SnackBar snackBar = SnackBar(
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: AppTheme.textStyles.textSnackBar,
      ),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  // FUNÇÃO PARA EXECUTAR SEMPRE QUE TIVER UMA ALTERAÇÃO NO LoginState
  void autoRun(BuildContext context) {
    disposer = autorun((_) {
      if (state is LoginStateFailure) {
        String message = (state as LoginStateFailure).message;
        _modifyLoginState(LoginStateEmpty());
        showSnackBar(context, message, Colors.red);
      } else if (state is LoginStateSuccess) {
        UserModel user = (state as LoginStateSuccess).user;
        _modifyLoginState(LoginStateEmpty());
        showSnackBar(context, "Logado com sucesso!!!", Colors.green);
        Navigator.pushNamedAndRemoveUntil(
          context,
          RouterClass.home,
          (Route<dynamic> route) => false,
          arguments: {"user": user},
        );
      }
    });
  }

  void dispose() {
    _loginUseCase.dispose();
    disposer.reaction.dispose();
  }
}
