# OvoAssignment
Ovo Assignment
==============
- The Contact object contains 3 new custom fields: Gender, Loyalty Status, and Our Friends Id.
- The OurFriendsService class contains an @future method to make the REST call and update the list of Contacts accordingly. Governor limits will restrict the number of records updated to 10,000. If this is likely to be exceeded then this could be recoded as a queueable class that would perform the updates in batches.
- The OurFriendsSync class is a schedulable class to call the method in OurFriendsService class.
- The ScheduleManager class contains a method to schedule the OurFriendsSync job hourly.
- The ContactList lightning component shows a paginated list of Contact records, with a button to set Loyalty Status to Unfriendly. Given time, this could be enhanced to have a search/filter by name, and to customize the columns displayed based on a field set.
- The ContactListController apex class provides the methods to query the list of Contacts by page, and to set the Loyalty Status to Unfriendly.
- The OurFriendsServiceTest is a test class that provides 100% code coverage for the OurFriendsService class.
