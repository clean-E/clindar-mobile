class QueryAndMutation {
  static final String login = r"""
        mutation login($user: LoginInput){
          login(user:$user){
            email
            nickname
          }
        }
""";

  static final String setNickname = r"""
        mutation ($user: NicknameInput){
          setNickname(user:$user){
            email
            nickname
          }
        }
""";
}
