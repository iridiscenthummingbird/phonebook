part of '../daos/user_dao.dart';

User mapToUser(UserTableData dbUser) {
  return User(
    id: dbUser.id,
    avatar: dbUser.avatar,
    name: dbUser.name,
    createdAt: dbUser.createdAt,
  );
}

UserTableData userToMap(User user) {
  return UserTableData(
    id: user.id,
    name: user.name,
    avatar: user.avatar,
    createdAt: user.createdAt,
  );
}

List<User> mapToUserList(List<UserTableData> dbList) {
  return dbList.map((e) => mapToUser(e)).toList();
}

List<UserTableData> userListToMap(List<User> list) {
  return list.map((e) => userToMap(e)).toList();
}
