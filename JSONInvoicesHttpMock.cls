@isTest
global class JSONInvoicesHttpMock implements HttpCalloutMock {

    private final Boolean pretty = true;
    private final Boolean plain = false;

    global HttpResponse respond(HttpRequest request) {
        // Generate the JSON object
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
        JSONGenerator jsonGen = JSON.createGenerator(pretty);
        jsonGen.writeObject(invoiceList);
        jsonGen.close();

        // Create the fake HTTP response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{\n"invoiceList": ' + jsonGen.getAsString() + '\n}');
        response.setStatusCode(200);

        return response;
    }
}
