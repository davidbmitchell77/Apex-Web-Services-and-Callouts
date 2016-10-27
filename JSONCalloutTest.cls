@isTest
private class JSONCalloutTest {
    static TestMethod void JSONPlaceHolderComments() {
    	
    	// Get a page reference to the VF page and its controller
        PageReference myPageRef = Page.JSONPlaceHolderComments;
        Test.setCurrentPageReference(myPageRef);
        JSONPlaceHolderCommentsController theController = new JSONPlaceHolderCommentsController();
        
        // Press the 'Submit' button on the page
        // and verify the continuation server received the request
        Continuation contObj = theController.submitRequest();
        Map<String, HttpRequest> requests = contObj.getRequests();
        System.assertEquals(1, requests.size());
        System.assertNotEquals(null, requests.get('Continuation-1'));
        
        // Generate the JSON response
        final Boolean pretty = true;
        final Boolean plain = false;
        JSONGenerator jsonGen = JSON.createGenerator(pretty);
        jsonGen.writeStartArray();
        for (Integer i=0,j=0; i<500; i++) {
          jsonGen.writeStartObject();
          jsonGen.writeNumberField('postId', 1);
          jsonGen.writeNumberField('id', ++j);
          jsonGen.writeStringField('name', 'foobar ' + j);
          jsonGen.writeStringField('email', 'foobar.' + j + '@apextest.com');
          jsonGen.writeStringField('body', 'ut dolorum nostrum id quia aut est (' + j + ').');
          jsonGen.writeEndObject();
        }
        jsonGen.writeEndArray();
        jsonGen.close();
        
        // Override the HTTP REST callout response
        // and run the continuation method in the custom controller
        HttpResponse response = new HttpResponse();
        response.setHeader('content-type', 'application/json');
        response.setBody(jsonGen.getAsString());
        response.setStatusCode(200);
        Test.setContinuationResponse('Continuation-1', response);
        Test.invokeContinuationMethod(theController, contObj);
        
        // Ensure the correct number of records were returned to the controller
        System.assertEquals(500, theController.wrapper.commentList.size());
    }
}