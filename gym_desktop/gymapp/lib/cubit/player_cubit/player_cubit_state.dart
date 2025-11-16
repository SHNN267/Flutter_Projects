abstract class DataBaseState {}

class LogInState extends DataBaseState {}

class AddNewPlayerState extends DataBaseState {}

class RemovePlayerState extends DataBaseState {}

class GetAllPlayerState extends DataBaseState {}

class EditPlayerState extends DataBaseState {}

class ErrorDatabaseState extends DataBaseState {
  ErrorDatabaseState(String string);
}

class GetPlayerFromHisIDState extends DataBaseState {}

class ErrorWhenGetPlayerFromHisID extends DataBaseState {}

class ErrorWhenAddPlayer extends DataBaseState {}

class ErrorWhenEditPlayer extends DataBaseState {}
