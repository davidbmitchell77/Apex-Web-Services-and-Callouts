@isTest
private class JSONCalloutTest {

    static TestMethod void JSONParseInvoices() {
        // Set mock callout class
        Test.setMock(HttpCalloutMock.class, new JSONInvoicesHttpMock());

    	// Get a page reference to the VF page and its controller
        PageReference pageRef = Page.JSONParseInvoices;
        Test.setCurrentPageReference(pageRef);
        JSONParseInvoicesController theController = new JSONParseInvoicesController();
        theController.parseJSONString();

        // Ensure the correct number of records were returned to the controller
        System.assertEquals(500, theController.wrapper.invoiceList.size());
    }

    static TestMethod void JSONParseInvoicesAsync() {

    	// Get a page reference to the VF page and its controller
        PageReference pageRef = Page.JSONParseInvoicesAsync;
        Test.setCurrentPageReference(pageRef);
        JSONParseInvoicesControllerAsync theController = new JSONParseInvoicesControllerAsync();

        // Press the 'Submit' button on the page,
        // find the request name
        // and verify the continuation server received the request
        Continuation contObj = theController.submitRequest();
        Map<String, HttpRequest> requests = contObj.getRequests();
        String requestName = '';
        for (String s : requests.keySet()) {
        	requestName = s;
        }
        System.assertEquals(1, requests.size());
        System.assertNotEquals(null, requests.get(requestName));

        // Generate the JSON response
        List<JSONInvoiceWrapper.Invoice> invoiceList = new List<JSONInvoiceWrapper.Invoice>();
        for (Integer i=0; i<500; i++) {
            List<JSONInvoiceWrapper.LineItem> liList = new List<JSONInvoiceWrapper.LineItem>();
            JSONInvoiceWrapper.LineItem li = new JSONInvoiceWrapper.LineItem(
                Double.valueOf(i+1),
                Double.valueOf(i+1),
                'Product No. ' + String.valueOf(i+1)
            );
            Double extPrice = li.getExtendedPrice();  // ensure 100% code coverage
            liList.add(li);
            JSONInvoiceWrapper.Invoice inv = new JSONInvoiceWrapper.Invoice(
                Double.valueOf(i+1),
                System.Now(),
                (i+1),
                liList
            );
            invoiceList.add(inv);
        }
        final Boolean pretty = true;
        final Boolean plain = false;
        JSONGenerator jsonGen = JSON.createGenerator(pretty);
        jsonGen.writeObject(invoiceList);
        jsonGen.close();

        // Override the HTTP REST callout response
        // and run the continuation method in the custom controller
        HttpResponse response = new HttpResponse();
        response.setHeader('content-type', 'application/json');
        response.setBody('{\n"invoiceList": ' + jsonGen.getAsString() + '\n}');
        response.setStatusCode(200);
        Test.setContinuationResponse(requestName, response);
        Test.invokeContinuationMethod(theController, contObj);

        // Ensure the correct number of records were returned to the controller
        System.assertEquals(500, theController.wrapper.invoiceList.size());
    }

    static TestMethod void JSONPlaceHolderComments() {

    	// Get a page reference to the VF page and its controller
        PageReference pageRef = Page.JSONPlaceHolderComments;
        Test.setCurrentPageReference(pageRef);
        JSONPlaceHolderCommentsController theController = new JSONPlaceHolderCommentsController();

        // Press the 'Submit' button on the page,
        // find the request name
        // and verify the continuation server received the request
        Continuation contObj = theController.submitRequest();
        Map<String, HttpRequest> requests = contObj.getRequests();
        String requestName = '';
        for (String s : requests.keySet()) {
        	requestName = s;
        }
        System.assertEquals(1, requests.size());
        System.assertNotEquals(null, requests.get(requestName));

        // Generate the JSON response
        List<JSONPlaceHolderWrapper.Comment> commentList = new List<JSONPlaceHolderWrapper.Comment>();
        for (Integer i=0,j=0; i<500; i++) {
            JSONPlaceHolderWrapper.Comment c = new JSONPlaceHolderWrapper.Comment(
                1,
                ++j,
                'foobar ' + j,
                'foobar.' + j + '@apextest.com',
                'ut dolorum nostrum id quia aut est (' + j + ').'
            );
            commentList.add(c);
        }
        final Boolean pretty = true;
        final Boolean plain = false;
        JSONGenerator jsonGen = JSON.createGenerator(pretty);
        jsonGen.writeObject(commentList);
        jsonGen.close();

        // Override the HTTP REST callout response
        // and run the continuation method in the custom controller
        HttpResponse response = new HttpResponse();
        response.setHeader('content-type', 'application/json');
        response.setBody(jsonGen.getAsString());
        response.setStatusCode(200);
        Test.setContinuationResponse(requestName, response);
        Test.invokeContinuationMethod(theController, contObj);

        // Ensure the correct number of records were returned to the controller
        System.assertEquals(500, theController.wrapper.commentList.size());
    }
}
