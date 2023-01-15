class QueryAndMutation {
  static final String login = """
        mutation(\$userInfo: CreateUserInput!){
          login(userInfo:\$userInfo){
            email
            nickname
          }
        }
""";

  static final String setNickname = """
        mutation(\$userInfo: UpdateUserInput!){
          setNickname(userInfo:\$userInfo){
            email
            nickname
          }
        }
""";

  static final String getUser = """
        query(\$email: String!) {
          getUser(email: \$email) {
            email
            nickname
          }
        }
""";
  static final String getAllUser = """
        query {
          getAllUser {
						_id
            nickname
          }
        }
""";

  static final String deleteUser = """
        mutation(\$email: String) {
          deleteUser(email: \$email) {
						success
          }
        }
""";

  static final String createSchedulePage = """
				query createSchedulePage {
					getAllUser{
						_id
						nickname
					}
					getAllGroup{
						_id
						gname
					}
				}
""";

  static final String getMainPageData = """
				query getMainPageData (\$email: String){
					getMySchedule(email: \$email){
						_id
			      category
			      spot
			      when
			      group
					}
					getGroupSchedule(email: \$email){
						_id
			      category
			      spot
			      when
			      group
					}
				}
""";

  static final String getMySchedule = """
			  query (\$email: String){
			    getMySchedule(email: \$email){
			      _id
			      category
			      spot
			      when
			      group{
							groupName
						}
			    }
			  }
""";

  static final String getGroupSchedule = """
			  query (\$email: String){
			    getGroupSchedule(email: \$email){
			      _id
			      category
			      spot
			      when
			      group
			    }
			  }
""";

  static final String getScheduleDetail = """
  query (\$_id: String){
    getScheduleDetail(_id: \$_id){
			_id
      category
      when
			spot
	    host{
				nickname
			}
      guest{
        user{
					nickname
				}
        records{
          level
					nameOrColor
					count
        }
      }
      memo
      group{
				groupName
			}
    }
  }
""";

  static final String getAllSpot = """
        query {
          getAllSpot {
            _id
						spotName
						spotBranch
						address
						category
          }
        }
""";

  static final String getSpotDetail = """
		query (\$_id: String){
			getSpotDetail(_id: \$spotId) {
				_id
				spotName
				spotBranch
				address
				phase {
					level
					nameOrColor
				}
				category
			}
		}
""";
  static final String createSchedule = """
  mutation (\$schedule: CreateScheduleInput){
    createSchedule(schedule: \$schedule){
      _id
      category
      when
			spot
	    host{
				nickname
			}
      guest{
        user{
					nickname
				}
        records{
          level
					nameOrColor
					count
        }
      }
      memo
      group{
				groupName
			}
    }
  }
""";

  static final String editSchedule = """
  mutation (\$schedule: EditScheduleInput){
    editSchedule(schedule: \$schedule){
      _id
      category
      when
			spot
	    host
      guest{
        nickname
        record{
          level
					nameOrColor
					count
        }
      }
      memo
      group
    }
  }
""";

  static final String deleteSchedule = """
  mutation (\$_id: String, \$email: String){
    deleteSchedule(_id: \$_id, email: \$email){
			success
    }
  }
""";

  static final String joinSchedule = """
  mutation (\$_id: String, \$email: String){
    joinSchedule(_id: \$_id, email: \$email){
      _id
      category
      when
			spot
	    host
      guest{
        nickname
        record{
          level
					nameOrColor
					count
        }
      }
      memo
      group
    }
  }
""";

  static final String comeoutSchedule = """
  mutation (\$_id: String, \$email: String){
    comeoutSchedule(_id: \$_id, email: \$email){
      _id
      category
      when
			spot
	    host
      guest{
        nickname
        record{
          level
					nameOrColor
					count
        }
      }
      memo
      group
    }
  }
""";

  static final String inviteSchedule = """
  mutation (\$_id: String, \$email: String, \$guest: String){
    joinSchedule(_id: \$_id, email: \$email, guest: \$guest){
      _id
      category
      when
			spot
	    host
      guest{
        nickname
        record{
          level
					nameOrColor
					count
        }
      }
      memo
      group
    }
  }
""";

  static final String editRecord = """
  mutation (\$records: RecordInput){
    editRecord(records: \$records){
      _id
      category
      when
			spot
	    host
      guest{
        nickname
        record{
          level
					nameOrColor
					count
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
      mainCategory
			age
      secret
    }
  }
""";

  static final String getMyGroup = """
  query (\$email: String){
    getMyGroup(email: \$email){
      _id
      gname
      mainCategory
			age
      secret
    }
  }
""";

  static final String getGroupDetail = """
  query (\$_id: String){
    getGroupDetail(_id: \$_id){
      _id
      gname
      leader
      createdAt
      description
      memberList
      mainCategory
			age
      secret
			schedules {
				_id
			  category
			  spot
			  when
			}
			join
    }
  }
""";

  static final String openSecretGroup = """
  query (\$_id: String, \$password: String){
    openSecretGroup(_id: \$_id, password: \$password){
      _id
      gname
      leader
      createdAt
      description
      memberList
      mainCategory
			age
      secret
			schedules {
				_id
			  category
			  spot
			  when
			}
			join
    }
  }
""";

  static final String createGroup = """
  mutation (\$group: CreateGroupInput){
    createGroup(group: \$group){
      _id
      groupName
      leader{
				nickname
			}
      createdAt
      description
      memberList{
				nickname
			}
      mainCategory
			age
      secret
			scheduleList {
				_id
			  category
			  spot
			  when
			}
			join
    }
  }
""";

  static final String editGroup = """
  mutation (\$group: EditGroupInput){
    editGroup(group: \$group){
      _id
      gname
      leader
      createdAt
      description
      memberList
      mainCategory
			age
      secret
			schedules {
				_id
			  category
			  spot
			  when
			}
			join
    }
  }
""";

  static final String joinGroup = """
  mutation (\$_id: String, \$email: String){
    joinGroup(_id: \$_id, email: \$email){
      _id
      gname
      leader
      createdAt
      description
      memberList
      mainCategory
			age
      secret
			schedules {
				_id
			  category
			  spot
			  when
			}
			join
    }
  }
""";

  static final String leaveGroup = """
  mutation (\$_id: String, \$email: String){
    leaveGroup(_id: \$_id, email: \$email){
      _id
      gname
      leader
      createdAt
      description
      memberList
      mainCategory
			age
      secret
			schedules {
				_id
			  category
			  spot
			  when
			}
			join
    }
  }
""";

  static final String deleteGroup = """
  mutation (\$_id: String, \$email: String){
    deleteGroup(_id: \$_id, email: \$email){
      success
    }
  }
""";

  static final String changeLeader = """
  mutation (\$_id: String, \$email: String, \$newLeader: String){
    changeLeader(_id: \$_id, email: \$email, newLeader: \$newLeader){
      _id
      gname
      leader
      createdAt
      description
      memberList
      mainCategory
			age
      secret
			schedules {
				_id
			  category
			  spot
			  when
			}
			join
    }
  }
""";
}
