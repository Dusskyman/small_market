class MainEvent {
  const MainEvent();
}

class MainAddItemEvent extends MainEvent {
  final String item;

  const MainAddItemEvent({required this.item});
}

class MainRemoveItemEvent extends MainEvent {
  const MainRemoveItemEvent();
}
