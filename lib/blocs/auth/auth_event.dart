part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthStateChangedEvent extends AuthEvent{ // when auth changes

  final fbAuth.User? user;
  AuthStateChangedEvent({
    this.user
});
  @override
  List<Object?> get props => [user];

}
class SignoutRequestedEvent extends AuthEvent{

}