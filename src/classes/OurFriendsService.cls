public with sharing class OurFriendsService {

    private static final String OURFRIENDS_URL = 'https://sheltered-depths-66346.herokuapp.com/customers';

    @future(callout=true)
    public static void runOurFriendsService(){
        // make the REST call to Our Friends service
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(OURFRIENDS_URL);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) {
            // Deserialize the JSON string into collections of customer data.
            Map<String,Object> results = (Map<String,Object>) JSON.deserializeUntyped(response.getBody());
            List<Object> friends = (List<Object>) results.get('customers');
            // update/insert Contact records for each friend
			List<Contact> friendlyContacts = new List<Contact>();
            for (Object row: friends) {
                System.debug('####Friendly: '+row);
                Map<String,Object> friend = (Map<String,Object>) row;
                Contact contactFriend = new Contact(
                	Our_Friends_Id__c = (String) friend.get('id'),
                    Salutation = (String) friend.get('title'),
                    FirstName = (String) friend.get('firstName'),
                    LastName = (String) friend.get('lastName'),
                    Gender__c = (String) friend.get('gender'),
                    Loyalty_Status__c = 'Friendly'
                );
                friendlyContacts.add( contactFriend );
            }
            // N.B. this will update/insert all records for which a response is received, even those that are already 'Friendly'.
            // This will ensure any changes to their other data, e.g. name, are updated in Salesforce.
            // The alternative would be to just upsert those records that either do not exist or which are not currently marked 'Friendly'.
            // The requirement would need to be clarified.
            upsert friendlyContacts Our_Friends_Id__c;
            // Revert all other existing Contacts to Loyalty Status = Standard
			List<Contact> standardContacts = new List<Contact>();
            for(Contact otherContact: [SELECT Id, Loyalty_Status__c 
                                       FROM Contact 
                                       WHERE Loyalty_Status__c <> 'Standard' AND (Id NOT IN :friendlyContacts)]) {
                otherContact.Loyalty_Status__c = 'Standard';
                standardContacts.add( otherContact );
            }
            system.debug('####Standard Contacts reverted: '+standardContacts.size());
            if (!standardContacts.isEmpty())
                update standardContacts;
        }
    }
}