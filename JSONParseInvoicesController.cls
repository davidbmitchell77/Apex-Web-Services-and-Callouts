public class JSONParseInvoicesController {

    public JSONInvoiceWrapper wrapper {get; set;}
    public String endpoint {get; set;}
    
    public void parseJSONString() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        endpoint = 'https://docsample.herokuapp.com/jsonSample';
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        request.setTimeout(10000);
        HttpResponse response = http.send(request);
        wrapper = (JSONInvoiceWrapper)JSON.deserialize(response.getBody(), JSONInvoiceWrapper.class);
    }   
}