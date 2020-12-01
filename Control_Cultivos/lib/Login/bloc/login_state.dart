part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class AddImageState extends LoginState {}

class GetImageState extends LoginState {
  final File image;

  GetImageState({@required this.image});
}

class ErrorState extends LoginState {
  final String errmensage;
  ErrorState({@required this.errmensage});
}

class UploadedState extends LoginState {
  final dynamic image;
  UploadedState({@required this.image});
}

class CloudStoreSaved extends LoginState {
  @override
  List<Object> get props => [];
}
