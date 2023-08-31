import '../../domain/domain_index.dart';
import '../auth/user_provider.dart';
import 'profile_infrustructure.dart';

class ProfileRepository {
  AuthenticatedUser? loggedInUser = UserDataProvider.authenticatedUser;

  final RemoteProfileProvider profileDataProvider;

  ProfileRepository(this.profileDataProvider);

  Future<User> getUserProfile(String token, int id) =>
      profileDataProvider.getUserProfile(token, id);

  Future<List<User>> getAllUsersProfile(String token, int id) async {
    List<User> result = [];
    List<User> users = await profileDataProvider.getAllUsersProfile(token, id);
    for (User user in users) {
      if (user.id != id && user.role != "owner") {
        result.add(user);
      }
    }
    return result;
  }

  Future<bool> deleteUserProfile(String token, int id) async {
    return profileDataProvider.deleteUserProfile(token, id);
  }

  Future<bool> revokeUserRole(String token, int id, String role) async {
    bool res = await profileDataProvider.revokeUserRole(token, id, role);
    return res;
  }

  Future updateUserProfile(User user, String token) async {
    return profileDataProvider.updateUserProfile(user, token);
  }
}
