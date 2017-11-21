public class ScheduleManager {
    
    private static final String OUR_FRIENDS_SYNC = 'Our Friends Sync';
    private static final String SCHEDULE_HOURLY = '0 0 * * * ?';
    
    public static void scheduleOurFriendsSync() {
		String jobId = system.schedule(OUR_FRIENDS_SYNC, SCHEDULE_HOURLY, new OurFriendsSync());
        system.debug('####ScheduleManager:: '+OUR_FRIENDS_SYNC+': '+jobId);
    }

}