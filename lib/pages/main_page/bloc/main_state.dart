abstract class MainState {}

class MainSuccessfullyAddedState implements MainState {
  final String item;

  const MainSuccessfullyAddedState(this.item);
}

class MainSuccessfullyRemovedState implements MainState {
  const MainSuccessfullyRemovedState();
}

class MainErrorState implements MainState {
  final String? error;

  const MainErrorState(this.error);
}

class MainLoadingState implements MainState {
  const MainLoadingState();
}

class MainLoadCompleteState implements MainState {
  const MainLoadCompleteState();
}

class MainIdleState implements MainState {
  const MainIdleState();
}
