import 'package:small_market/repo/main_repo.dart';

class MainRepoImpl implements MainRepo {
  @override
  Future<String> addItem({required String name}) async {
    await Future.delayed(const Duration(seconds: 1));
    return name;
  }

  @override
  Future<void> removeItem() async {
    await Future.delayed(const Duration(seconds: 1));
    return;
  }
}
