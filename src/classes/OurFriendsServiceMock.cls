global class OurFriendsServiceMock implements HttpCalloutMock {
    
	global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"customers":[' + 
                    '{"id":"test-one","firstName":"Test","lastName":"One","gender":"Male","title":"Mr"},' + 
                    '{"id":"test-two","firstName":"Test","lastName":"Two","gender":"Female","title":"Mrs"}]}');
        res.setStatusCode(200);
        return res;
    }
    
}