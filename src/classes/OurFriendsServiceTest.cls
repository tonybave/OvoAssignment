@isTest
public class OurFriendsServiceTest {
    
    @isTest
    private static void test() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new OurFriendsServiceMock());
        
        // existing 'Friendly' should be reverted to 'Standard'
        Contact existingContact1 = new Contact(
            FirstName = 'Test',
            LastName = 'Existing',
            Salutation = 'Mr',
            Gender__c = 'Male',
            Loyalty_Status__c = 'Friendly'
        );
        insert existingContact1;
        
        // existing 'Standard' should be made 'Friendly', LastName should be fixed
        Contact existingContact2 = new Contact(
            FirstName = 'Test',
            LastName = 'OldName',
            Gender__c = 'Male',
            Loyalty_Status__c = 'Standard',
            Our_Friends_Id__c = 'test-one'
        );
        insert existingContact2;
		
		Test.startTest();
        // Will return two Contacts, test-one is existing and test-two is new.
        OurFriendsService.runOurFriendsService();
        Test.stopTest();
        
        List<Contact> testContact = [SELECT Id, Name, Salutation, Gender__c, Loyalty_Status__c FROM Contact ORDER BY LastName];
        System.assertEquals(3,testContact.size());
        
        // existing 'Friendly' should be reverted to 'Standard'
        System.assertEquals('Test Existing',testContact[0].Name);
        System.assertEquals('Standard',testContact[0].Loyalty_Status__c);
        System.assertEquals('Male',testContact[0].Gender__c);
        System.assertEquals('Mr',testContact[0].Salutation);

        // existing 'Standard' should be made 'Friendly', LastName should be fixed
        System.assertEquals('Test One',testContact[1].Name);
        System.assertEquals('Friendly',testContact[1].Loyalty_Status__c);
        System.assertEquals('Male',testContact[1].Gender__c);
        System.assertEquals('Mr',testContact[1].Salutation);

        // new Contact should be created
        System.assertEquals('Test Two',testContact[2].Name);
        System.assertEquals('Friendly',testContact[2].Loyalty_Status__c);
        System.assertEquals('Female',testContact[2].Gender__c);
        System.assertEquals('Mrs',testContact[2].Salutation);

    }

}