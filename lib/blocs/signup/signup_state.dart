part of 'signup_cubit.dart';

enum SignupStatus {
  initial,
  submitting,
  success,
  error,
}

class SignupState extends Equatable{
  final SignupStatus signupStatus;
  final CustomError error;

  factory SignupState.initial(){
    return SignupState(
      signupStatus: SignupStatus.initial,
      error: CustomError(),);
  }

  @override
  List<Object> get props => [signupStatus, error];

  @override
  String toString() {
    return 'SignupState{signupStatus: $signupStatus, error: $error}';
  }

  const SignupState({
    required this.signupStatus,
    required this.error,
  });

  SignupState copyWith({
    SignupStatus? signupStatus,
    CustomError? error,
  }) {
    return SignupState(
      signupStatus: signupStatus ?? this.signupStatus,
      error: error ?? this.error,
    );
  }
}


