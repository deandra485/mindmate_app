import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:application_belajar/bloc/auth/auth_event.dart';
import 'package:application_belajar/bloc/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<ToggleLoginObscure>(_onToggleLoginObscure);
    on<ToggleSignupObscure>(_onToggleSignupObscure);
    on<ToggleSignupConfirmObscure>(_onToggleSignupConfirmObscure);
    on<ToggleNewPasswordObscure>(_onToggleNewPasswordObscure);
    on<ToggleConfirmNewPasswordObscure>(_onToggleConfirmNewPasswordObscure);
    on<LoginSubmitted>(_onLoginSubmitted);
    on<SignupSubmitted>(_onSignupSubmitted);
    on<ForgotPasswordSubmitted>(_onForgotPasswordSubmitted);
    on<VerificationCodeSubmitted>(_onVerificationCodeSubmitted);
    on<ResendCodeRequested>(_onResendCodeRequested);
    on<SaveNewPasswordSubmitted>(_onSaveNewPasswordSubmitted);
    on<AuthReset>(_onAuthReset);
  }

  // ── Toggle handlers ──
  void _onToggleLoginObscure(ToggleLoginObscure event, Emitter<AuthState> emit) {
    emit(state.copyWith(loginObscure: !state.loginObscure, status: AuthStatus.initial));
  }

  void _onToggleSignupObscure(ToggleSignupObscure event, Emitter<AuthState> emit) {
    emit(state.copyWith(signupObscure: !state.signupObscure, status: AuthStatus.initial));
  }

  void _onToggleSignupConfirmObscure(ToggleSignupConfirmObscure event, Emitter<AuthState> emit) {
    emit(state.copyWith(signupConfirmObscure: !state.signupConfirmObscure, status: AuthStatus.initial));
  }

  void _onToggleNewPasswordObscure(ToggleNewPasswordObscure event, Emitter<AuthState> emit) {
    emit(state.copyWith(newPasswordObscure: !state.newPasswordObscure, status: AuthStatus.initial));
  }

  void _onToggleConfirmNewPasswordObscure(ToggleConfirmNewPasswordObscure event, Emitter<AuthState> emit) {
    emit(state.copyWith(confirmNewPasswordObscure: !state.confirmNewPasswordObscure, status: AuthStatus.initial));
  }

  // ── Form submission handlers ──
  void _onLoginSubmitted(LoginSubmitted event, Emitter<AuthState> emit) {
    if (event.email.trim().isEmpty || event.password.trim().isEmpty) {
      emit(state.copyWith(
        status: AuthStatus.failure,
        errorMessage: 'Silakan isi semua field',
      ));
      return;
    }
    emit(state.copyWith(status: AuthStatus.loginSuccess));
  }

  void _onSignupSubmitted(SignupSubmitted event, Emitter<AuthState> emit) {
    if (event.username.trim().isEmpty ||
        event.email.trim().isEmpty ||
        event.password.trim().isEmpty ||
        event.confirmPassword.trim().isEmpty) {
      emit(state.copyWith(
        status: AuthStatus.failure,
        errorMessage: 'Silakan isi semua field',
      ));
      return;
    }
    if (event.password != event.confirmPassword) {
      emit(state.copyWith(
        status: AuthStatus.failure,
        errorMessage: 'Password tidak cocok',
      ));
      return;
    }
    emit(state.copyWith(status: AuthStatus.signupSuccess));
  }

  void _onForgotPasswordSubmitted(ForgotPasswordSubmitted event, Emitter<AuthState> emit) {
    if (event.email.trim().isEmpty) {
      emit(state.copyWith(
        status: AuthStatus.failure,
        errorMessage: 'Silakan masukkan email',
      ));
      return;
    }
    emit(state.copyWith(status: AuthStatus.forgotPasswordSuccess));
  }

  void _onVerificationCodeSubmitted(VerificationCodeSubmitted event, Emitter<AuthState> emit) {
    if (event.code.length < 4) {
      emit(state.copyWith(
        status: AuthStatus.failure,
        errorMessage: 'Silakan masukkan 4 digit kode verifikasi',
      ));
      return;
    }
    emit(state.copyWith(status: AuthStatus.verificationSuccess));
  }

  void _onResendCodeRequested(ResendCodeRequested event, Emitter<AuthState> emit) {
    // In real app, trigger resend API. For now, just emit initial.
    emit(state.copyWith(status: AuthStatus.initial));
  }

  void _onSaveNewPasswordSubmitted(SaveNewPasswordSubmitted event, Emitter<AuthState> emit) {
    if (event.password.trim().isEmpty || event.confirmPassword.trim().isEmpty) {
      emit(state.copyWith(
        status: AuthStatus.failure,
        errorMessage: 'Silakan isi semua field',
      ));
      return;
    }
    if (event.password != event.confirmPassword) {
      emit(state.copyWith(
        status: AuthStatus.failure,
        errorMessage: 'Password tidak cocok',
      ));
      return;
    }
    emit(state.copyWith(status: AuthStatus.newPasswordSuccess));
  }

  void _onAuthReset(AuthReset event, Emitter<AuthState> emit) {
    emit(const AuthState());
  }
}
