/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-15-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
trigger UserTrigger on User (after insert) {
    if (Trigger.isInsert && Trigger.isAfter) {
       Set<Id> userIds = new Set<Id>();
       //Get profile
       Profile saleProfile = [SELECT Id, Name FROM Profile WHERE Name = 'Custom: Sales Profile' LIMIT 1];
       // add user to set if user profile is sale profile
       for(User user : Trigger.new){
            if (user.ProfileId == saleProfile.Id) {
                userIds.add(user.Id);
            }
       }
       if (userIds != null) {
            UserTriggerHandler.assignSalesPermissionSet(userIds);
       }

    //    practice2
        UserTriggerHandler user = new UserTriggerHandler();
       // add user to public group
       user.assignToPublicGroup(Trigger.new);
       //Post about joining of the new users in the chatter 
       //UserTriggerHandler.postToChatterGroup(Trigger.newMap.keySet());
       // datlv check git update
       //compare code

    }
}