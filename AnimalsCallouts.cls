public class AnimalsCallouts {
    public static HttpResponse makeGETCallout() {
        /*------------------------------------------------------------*/
        /* Get data from a service:                                   */
        /* Send a GET request to web service to get list of animals.  */
        /*------------------------------------------------------------*/
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        request.setMethod('GET');
        httpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) {
            //Deserialize the JSON string into collectons of primitive data types
            Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
            // Cast the values in the "Animals" key as a list
            List<Object> animals = (List<Object>)results.get('animals');
            for (Object animal : animals) {
              System.debug(animal);
            }
        }
        return response;
    }

    public static HttpResponse makePOSTCallout() {
        /*------------------------------------------------------------*/
        /* Send data to a service:                                    */
        /* Send a POST request to web service to add an animal name.  */
        /*------------------------------------------------------------*/
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        // Set the body as a JSON object
        request.setBody('{"name" : "mighty moose"}');
        HttpResponse response = http.send(request);
        // Parse the JSON response
        if (response.getStatusCode() == 201) {
            System.debug(response.getBody());
        } else {
            String errMsg = 'The status code returned was not expected (';
            errMsg += response.getStatusCode() + ':  ';
            errMsg += response.getStatus() + ')';
            System.debug(errMsg);
        }
        return response;
    }
}
