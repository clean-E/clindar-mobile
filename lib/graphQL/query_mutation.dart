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
						success
          }
        }
""";

  static final String getMyPage = """
        query(\$user: UserEmail) {
          getMyPage(user: \$user) {
            email
            nickname
            myGroupList
          }
        }
""";

  static final String getAllSchedule = """
  query (\$schedule: UserEmail){
    getAllSchedule(schedule: \$schedule){
      _id
      category
      where
      when
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
      group
    }
  }
""";

  static final String getGroupSchedule = """
  query (\$schedule: UserEmail){
    getGroupSchedule(schedule: \$schedule){
      _id
      category
      where
      when
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
      group
    }
  }
""";

  static final String getScheduleDetail = """
  query (\$schedule: ScheduleId){
    getScheduleDetail(schedule: \$schedule){
      _id
      category
      where
      when
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
      group
    }
  }
""";

  static final String createSchedule = """
  mutation (\$schedule: CreateScheduleInput){
    createSchedule(schedule: \$schedule){
      _id
      category
      where
      when
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
      group
    }
  }
""";

  static final String deleteSchedule = """
  mutation (\$schedule: DeleteScheduleInput){
    deleteSchedule(schedule: \$schedule){
      message
			success
    }
  }
""";

  static final String comeoutSchedule = """
  mutation (\$schedule: comeoutScheduleInput){
    comeoutSchedule(schedule: \$schedule){
      message
			success
    }
  }
""";

  static final String editSchedule = """
  mutation (\$schedule: EditScheduleInput){
    editSchedule(schedule: \$schedule){
      _id
      category
      where
      when
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
      group
    }
  }
""";

  static final String inviteSchedule = """
  mutation (\$schedule: InviteScheduleInput){
    inviteSchedule(schedule: \$schedule){
      _id
      category
      where
      when
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
      group
    }
  }
""";

  static final String joinSchedule = """
  mutation (\$schedule: JoinScheduleInput){
    joinSchedule(schedule: \$schedule){
      _id
      category
      where
      when
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
      group
    }
  }
""";

  static final String editRecord = """
  mutation (\$schedule: EditRecordInput){
    editRecord(schedule: \$schedule){
      _id
      category
      where
      when
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
      group                                                                                  
    }
  }
""";

  static final String getAllGroup = """
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
			image
    }
  }
""";

  static final String getMyGroup = """
  query (\$group: UserEmail){
    getMyGroup(group: \$group){
      _id
      gname
      leader
      createdAt
      description
      memberList
      mainCategory
      secret
			image
    }
  }
""";

  static final String getGroupDetail = """
  query (\$group: GroupId){
    getGroupDetail(group: \$group){
      _id
      gname
      leader
      createdAt
      description
      memberList
      mainCategory
      secret
			image
    }
  }
""";

  static final String openSecretGroup = """
  query (\$group: GroupPassword){
    openSecretGroup(group: \$group){
      _id
      gname
      leader
      createdAt
      description
      memberList
      mainCategory
      secret
			image
    }
  }
""";

  static final String createGroup = """
  mutation (\$group: CreateGroupInput){
    createGroup(group: \$group){
      _id
      gname
      leader
      createdAt
      description
      memberList
      mainCategory
      secret
			image
    }
  }
""";

  static final String joinGroup = """
  mutation (\$group: JoinGroupInput){
    joinGroup(group: \$group){
      _id
      gname
      leader
      createdAt
      description
      memberList
      mainCategory
      secret
			image
    }
  }
""";

  static final String leaveGroup = """
  mutation (\$group: LeaveGroupInput){
    leaveGroup(group: \$group){
      _id
      gname
      leader
      createdAt
      description
      memberList
      mainCategory
      secret
			image
    }
  }
""";

  static final String deleteGroup = """
  mutation (\$group: DeleteGroupInput){
    deleteGroup(group: \$group){
      message
			success
    }
  } 
""";

  static final String changeLeader = """
  mutation (\$group: ChangeLeaderInput){
    changeLeader(group: \$group){
      _id
      gname
      leader
      createdAt
      description
      memberList
      mainCategory
      secret
			image
    }
  }
""";

  static final String changeGroupImage = """
	mutation (\$group: Upload){
		changeGroupImage(group: \$group){
			_id
      gname
      leader
      createdAt
      description
      memberList
      mainCategory
      secret
			image
    }
	}
""";
}
