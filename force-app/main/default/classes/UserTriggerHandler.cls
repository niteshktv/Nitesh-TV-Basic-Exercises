public with sharing class UserTriggerHandler {
    public static void UserTriggerHandler(List<User> userList) {
        Profile profile = [Select Id, Name From Profile Where Name='Inside Sales' limit 1];
        System.debug(profile);
        QueueSobject queue = [Select Id, QueueId, SobjectType from QueueSobject Where SobjectType = 'Lead' limit 1];
        System.debug(queue);

        List<GroupMember> memberList = new List<GroupMember>();
        for(User user : userList){
            if(user.ProfileId == profile.Id){
                memberList.add(new GroupMember(
                    GroupId = queue.Id,
                    UserOrGroupId = user.Id
                ));
            }
        }
    }
}