import 'package:employee_management_system/presentation/presentation_index.dart';

import 'auth_infrustructure.dart';

class UserRepository {
  final UserDataProvider dataProvider;

  UserRepository(this.dataProvider);

  Future<void> createAccount(User user) async {
    return dataProvider.createAccount(user);
  }

  Future<AuthenticatedUser> login(String email, String password) async {
    return dataProvider.login(email, password);
  }

  Future<AuthenticatedUser?> getCurrentUser() {
    return dataProvider.readUser();
  }

  Future<bool> logout() {
    return dataProvider.deleteUser();
  }

  Future<List<User>> getApplicants() async {
    return dataProvider.getApplicants();
  }

  Future approveApplicant(int id, User user) async {
    return dataProvider.approveApplicant(id, user);
  }

  Future rejectApplicant(int id, User user) async {
    return dataProvider.rejectApplicant(id, user);
  }

}
