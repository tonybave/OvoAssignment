global class OurFriendsSync implements Schedulable {

    global void execute(SchedulableContext ctx) {
        OurFriendsService.runOurFriendsService();
    }
    
}