abstract class MainRepo {
  Future<String> addItem({required String name});
  Future<void> removeItem();
}
