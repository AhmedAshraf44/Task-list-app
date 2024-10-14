import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/feature/task/presentation/manger/change_button_cubit/change_button_state.dart';

class ChangeButtonCubit extends Cubit<ChangeButtonState> {
  ChangeButtonCubit() : super(InitialState());

  static ChangeButtonCubit get(context) => BlocProvider.of(context);

  int isActive = 0;

  changeButtonColor(int index) {
    isActive = index;
    emit(ChangeButton());
  }
}
