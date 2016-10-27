public class JSONParseInvoicesControllerAsync {
    public String requestLabel;
    public JSONInvoiceWrapper wrapper {get; set;}
    public String endpoint {get; set;}

    public Object submitRequest() {
        Continuation contObj = new Continuation(20);
        contObj.continuationMethod = 'processResponse';
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        endpoint = 'https://docsample.herokuapp.com/jsonSample';
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        this.requestLabel = contObj.addHttpRequest(request);
        return contObj;
    }

    public Object processResponse() {
        HttpResponse response = Continuation.getResponse(this.requestLabel);
        this.wrapper = (JSONInvoiceWrapper)JSON.deserialize(response.getBody(), JSONInvoiceWrapper.class);
        return null;
    }
}
