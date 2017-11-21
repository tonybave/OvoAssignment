public with sharing class ContactListController {

    @AuraEnabled
    public static Integer getPageCount( Decimal pageSize ) {
        Integer recordCount = Database.countQuery('SELECT COUNT() FROM Contact');
        system.debug('####>>record count = '+recordCount);
        Integer pageCount = Integer.valueOf((recordCount-1) / (Integer)pageSize) + 1;
        system.debug('####>>page count = '+pageCount);
        return pageCount;
    }
    
    @AuraEnabled
    public static List<Contact> getPagedContacts( Decimal pageNumber, Decimal pageSize ) {
        system.debug('####>>getPagedContacts()');
        system.debug('####>>page number = '+pageNumber);
        system.debug('####>>page size = '+pageSize);
        Integer soqlOffset = ((Integer)pageNumber - 1) * (Integer)pageSize;
        Integer soqlLimit = (Integer)pageSize;
        system.debug('####>>offset = '+soqlOffset);
        return [SELECT Id, Name, Gender__c, Loyalty_Status__c FROM Contact
               LIMIT :soqlLimit OFFSET :soqlOffset];
    }
    
    @AuraEnabled
    public static String setAsUnfriendly( String contactId ) {
        system.debug('####>>setAsUnfriendly()');
        system.debug('####>>contactId = '+contactId);
        try {
            List<Contact> contacts = [SELECT Id, Loyalty_Status__c FROM Contact WHERE Id = :contactId];
            if (!contacts.isEmpty()) {
                contacts[0].Loyalty_Status__c = 'Unfriendly';
                update contacts[0];
                return 'OK';
            }
            else
                return 'ERROR: no record found';
        }
        catch (Exception e) {
            return 'ERROR: '+e.getMessage();
        }
    }
    
}