abstract class TaskState {}

class InitialState extends TaskState {}

class ChangeButton extends TaskState {}

//class LoadingChangeButton extends ChangeButtonState {}

class ChangeStatus extends TaskState {}

class CreateDatabaseState extends TaskState {}

class InsertDatabaseState extends TaskState {}

//-----
class InsertLoadingState extends TaskState {}

class GetDatabaseState extends TaskState {}

class GetDatabaseLoadingState extends TaskState {}

class UpdateDatabaseState extends TaskState {}

class DeleteDatabaseState extends TaskState {}
