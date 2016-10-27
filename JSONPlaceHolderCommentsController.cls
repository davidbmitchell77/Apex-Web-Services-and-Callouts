public class JSONPlaceHolderCommentsController {

    public JSONPlaceHolderWrapper wrapper {get; set;}
    public String endpoint {get; set;}
    public String requestLabel;

    public Continuation submitRequest() {
        Continuation contObj = new Continuation(30);
        contObj.continuationMethod = 'processResponse';
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        endpoint = 'https://jsonplaceholder.typicode.com/comments';
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        requestLabel = contObj.addHttpRequest(request);
        return contObj;
    }

    public Object processResponse() {
        HttpResponse response = Continuation.getResponse(requestLabel);
        wrapper = (JSONPlaceHolderWrapper)JSON.deserializeUntyped(response.getBody());
        return null;
    }
}