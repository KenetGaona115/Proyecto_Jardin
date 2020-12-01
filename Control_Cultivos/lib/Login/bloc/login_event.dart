part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class InitEvent extends LoginEvent {}

class CreateNewPlatEvent extends LoginEvent {}

class ChooseImageEvent extends LoginEvent {}

class UploadFileEvent extends LoginEvent {
  final File image;
  UploadFileEvent({@required this.image});
  @override
  List<Object> get props => [image];
}

class SaveDataEvent extends LoginEvent {
  var image;
  String name;
  String annotations;
  String family;
  SaveDataEvent({
    @required this.image,
    @required this.name,
    @required this.annotations,
    @required this.family,
  });

  @override
  List<Object> get props => [image, name, annotations, family];
}
