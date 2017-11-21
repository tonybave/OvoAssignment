({
	callGetPageCount : function(component, setPageSize) {
		var action = component.get("c.getPageCount");
        action.setParams({ pageSize : setPageSize });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (component.isValid() && state == "SUCCESS") {
                component.set("v.pageCount", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
	},
    callGetPagedContacts : function(component, setPageNo, setPageSize) {
		var action = component.get("c.getPagedContacts");
        action.setParams({ pageNumber : setPageNo,
                           pageSize : setPageSize });
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('got Paged Contacts');
            if (component.isValid() && state == "SUCCESS") {
                component.set("v.contactList", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },
    callSetUnfriendly : function(component, helper, setContactId) {
        console.log('callSetUnfriendly: '+setContactId);
		var action = component.get("c.setAsUnfriendly");
        action.setParams({ contactId : setContactId });
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('response = '+response.getReturnValue());
            if (component.isValid() && state == "SUCCESS") {
		        var pageNo = component.get("v.pageNumber");
        		var pageSize = component.get("v.pageSize");
                helper.callGetPagedContacts(component, pageNo, pageSize);
            }
        });
        $A.enqueueAction(action);
    }
})