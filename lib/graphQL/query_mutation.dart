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

  static final String getAllSchedule = r"""
  query ($schedule: UserEmail){
    getAllSchedule(schedule: $schedule){
      _id
      category
      where{
        place1
        place2
      }
      when{
        year
        month
        date
        startTime
      }
      who{
        host
        guest{
          nickname
          record{
            level
            count
          }
        }
      }
      memo
      group{
        gname
      }
    }
  }
""";

  static final String getScheduleDetail = r"""
  query ($schedule: ScheduleId){
    getScheduleDetail(schedule: $schedule){
      category
      where{
        place1
        place2
      }
      when{
        year
        month
        date
        startTime
      }
      who{
        host
        guest{
          nickname
          record{
            level
            count
          }
        }
      }
      memo
      group{
        gname
      }
    }
  }
""";

  static final String createSchedule = r"""
  mutation ($schedule: CreateScheduleInput){
    createSchedule(schedule: $schedule){
      _id
      category
      where{
        place1
        place2
      }
      when{
        year
        month
        date
        startTime
      }
      who{
        host
        guest{
          nickname
          record{
            level
            count
          }
        }
      }
      memo
      group{
        gname
      }
    }
  }
""";

  static final String deleteSchedule = r"""
  mutation ($schedule: DeleteScheduleInput){
    deleteSchedule(schedule: $schedule){
      value
    }
  }
""";

  static final String editSchedule = r"""
  mutation ($schedule: EditScheduleInput){
    editSchedule(schedule: $schedule){
      _id
      category
      where{
        place1
        place2
      }
      when{
        year
        month
        date
        startTime
      }
      who{
        host
        guest{
          nickname
          record{
            level
            count
          }
        }
      }
      memo
      group{
        gname
      }
    }
  }
""";

  static final String inviteSchedule = r"""
  mutation ($schedule: InviteScheduleInput){
    inviteSchedule(schedule: $schedule){
      _id
      category
      where{
        place1
        place2
      }
      when{
        year
        month
        date
        startTime
      }
      who{
        host
        guest{
          nickname
          record{
            level
            count
          }
        }
      }
      memo
      group{
        gname
      }
    }
  }
""";

  static final String joinSchedule = r"""
  mutation ($schedule: JoinScheduleInput){
    joinSchedule(schedule: $schedule){
      _id
      category
      where{
        place1
        place2
      }
      when{
        year
        month
        date
        startTime
      }
      who{
        host
        guest{
          nickname
          record{
            level
            count
          }
        }
      }
      memo
      group{
        gname
      }
    }
  }
""";

  static final String editRecord = r"""
  mutation ($schedule: EditRecordInput){
    editRecord(schedule: $schedule){
      _id
      category
      where{
        place1
        place2
      }
      when{
        year
        month
        date
        startTime
      }
      who{
        host
        guest{
          nickname
          record{
            level
            count
          }
        }
      }
      memo
      group{
        gname
      }
    }
  }
""";

  static final String getAllGroup = r"""
  query {
    getAllGroup{
      _id
      gname
      leader
      createdAt
      description
      memberList
      mainCategory
      secret
    }
  }
""";

  static final String getGroupDetail = r"""
  query ($group: GroupId){
    getGroupDetail(group: $group){
      _id
      gname
      leader
      createdAt
      description
      memberList
      mainCategory
      secret
    }
  }
""";

  static final String openSecretGroup = r"""
  query ($group: GroupPassword){
    openSecretGroup(group: $group){
      _id
      gname
      leader
      createdAt
      description
      memberList
      mainCategory
      secret
    }
  }
""";

  static final String createGroup = r"""
  mutation ($group: CreateGroupInput){
    createGroup(group: $group){
      _id
      gname
      leader
      createdAt
      description
      memberList
      mainCategory
      secret
    }
  }
""";

  static final String joinGroup = r"""
  mutation ($group: JoinGroupInput){
    joinGroup(group: $group){
      _id
      gname
      leader
      createdAt
      description
      memberList
      mainCategory
      secret
    }
  }
""";

  static final String leaveGroup = r"""
  mutation ($group: LeaveGroupInput){
    leaveGroup(group: $group){
      _id
      gname
      leader
      createdAt
      description
      memberList
      mainCategory
      secret
    }
  }
""";

  static final String deleteGroup = r"""
  mutation ($group: DeleteGroupInput){
    deleteGroup(group: $group){
      value
    }
  } 
""";
}
