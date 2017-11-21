({
	doInit : function(component, event, helper) {
        var pageSize = component.get("v.pageSize");
        helper.callGetPageCount(component, pageSize);
        var pageNo = component.get("v.pageNumber");
        helper.callGetPagedContacts(component, pageNo, pageSize);
	},
    nextPage : function(component, event, helper) {
        var pageNo = component.get("v.pageNumber");
        var pageCount = component.get("v.pageCount");
        var pageSize = component.get("v.pageSize");
        if (pageNo < pageCount) {
            pageNo++
            component.set("v.pageNumber", pageNo);
	        helper.callGetPagedContacts(component, pageNo, pageSize);
        }
    },
    prevPage : function(component, event, helper) {
        var pageNo = component.get("v.pageNumber");
        var pageSize = component.get("v.pageSize");
        if (pageNo > 1) {
            pageNo--;
            component.set("v.pageNumber", pageNo);
	        helper.callGetPagedContacts(component, pageNo, pageSize);
        }
    },
    setUnfriendly : function(component, event, helper) {
        var contactId = event.getSource().get("v.name");
        console.log('unfriendly = '+contactId);
        helper.callSetUnfriendly(component, helper, contactId);
    }
})