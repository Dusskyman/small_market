import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:small_market/pages/main_page/bloc/main_event.dart';
import 'package:small_market/pages/main_page/bloc/main_state.dart';
import 'package:small_market/repo/main_repo.dart';
import 'package:small_market/repo/main_repo_impl.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(const MainLoadingState()) {
    on<MainAddItemEvent>(_addItem);
    on<MainRemoveItemEvent>(_removeItem);
  }

  final MainRepo mainRepo = MainRepoImpl();

  Future<void> _addItem(
    MainAddItemEvent event,
    Emitter<MainState> emit,
  ) async {
    emit(const MainLoadingState());
    final response = await mainRepo.addItem(name: event.item);
    emit(const MainLoadCompleteState());
    emit(MainSuccessfullyAddedState(response));
  }

  Future<void> _removeItem(
    MainRemoveItemEvent event,
    Emitter<MainState> emit,
  ) async {
    emit(const MainLoadingState());
    await mainRepo.removeItem();
    emit(const MainLoadCompleteState());
    emit(const MainSuccessfullyRemovedState());
  }
}
