import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../core/core.dart';
import '../../domain/signup/model/sign_up_model.dart';
import '../../domain/signup/usecase/sign_up_usecase.dart';
import '../../i18n/i18n_const.dart';
import 'sign_up_state.dart';
part 'sign_up_controller.g.dart';

class SignUpController extends _SignUpControllerBase with _$SignUpController {
  SignUpController({ISignUpUseCase? signUpUseCase}) {
    _signUpUseCase = signUpUseCase ?? SignUpUseCase();
  }
}

abstract class _SignUpControllerBase with Store {
  late ISignUpUseCase _signUpUseCase;

  late ReactionDisposer disposer;

  @observable
  SignUpState state = SignUpStateEmpty();

  @action
  Future<void> _modifySignUpState(SignUpState state) async =>
      this.state = state;

  @action
  Future<void> signUp({required SignUpModel signUpModel}) async {
    try {
      await _modifySignUpState(SignUpStateLoading());
      await Future.delayed(Duration(seconds: 4));
      String email = await _signUpUseCase.signUp(signUpModel);
      await _modifySignUpState(SignUpStateSuccess(email: email));
    } catch (e) {
      await _modifySignUpState(SignUpStateFailure(message: e.toString()));
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

  // FUNÇÃO PARA EXECUTAR SEMPRE QUE TIVER UMA ALTERAÇÃO NO SignUpState
  void autoRun(BuildContext context) {
    disposer = autorun((_) {
      if (state is SignUpStateFailure) {
        String message = (state as SignUpStateFailure).message;
        _modifySignUpState(SignUpStateEmpty());
        showSnackBar(context, message, Colors.red);
      } else if (state is SignUpStateSuccess) {
        String email = (state as SignUpStateSuccess).email;
        _modifySignUpState(SignUpStateEmpty());
        showSnackBar(context, "Conta criada com sucesso!!!", Colors.green);
        Navigator.pushNamed(
          context,
          RouterClass.signUpSuccess,
          arguments: {"email": email},
        );
      }
    });
  }

  void dispose() {
    _signUpUseCase.dispose();
    disposer.reaction.dispose();
  }
}
