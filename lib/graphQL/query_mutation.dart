class QueryAndMutation {
  static final String login = """
        mutation(\$user: LoginInput){
          login(user:\$user){
            email
            nickname
          }
        }
""";

  static final String setNickname = """
        mutation(\$user: NicknameInput){
          setNickname(user:\$user){
            email
            nickname
          }
        }
""";

  static final String getMyPage = """
        query(\$user : UserEmail) {
          getMyPage(user: \$user) {
            email
            nickname
            myGroupList {
      gname
    }
          }
        }
""";
}
