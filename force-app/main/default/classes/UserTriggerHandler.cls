public with sharing class UserTriggerHandler {
    public static void addProfileToQueue(List<User> userList) {
        Profile profile = [Select Id, Name From Profile Where Name='Inside Sales' limit 1];
        Group queue = [select Id from Group where Name='Marketing Hot Leads' AND Type = 'Queue' limit 1];   
        List<GroupMember> groupMemberList = new List<GroupMember>();
        for(User user : userList){
            if(user.ProfileId == profile.Id){
                groupMemberList.add(new GroupMember(
                    GroupId = queue.Id,
                    UserOrGroupId = user.Id
                ));
            }
        }
        insert groupMemberList;
    }
}