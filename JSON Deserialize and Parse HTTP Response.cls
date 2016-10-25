Map<Integer, String> responses = new Map<Integer, String>{
    200=>'OK',
    300=>'Multiple Choices',
    301=>'Moved Permanently',
    302=>'Found',
    304=>'Not Modified',
    307=>'Temporary Redirect',
    400=>'Bad Request',
    401=>'Unauthorized',
    403=>'Forbidden',
    404=>'Not Found',
    410=>'Gone',
    500=>'Internal Server Error',
    501=>'Not Implemented',
    503=>'Service Unavailable',
    550=>'Permission denied'
};

Http http = new Http();
HttpRequest request = new HttpRequest();
request.setEndPoint('https://th-apex-http-callout.herokuapp.com/animals');
//request.setEndPoint('https://docsample.herokuapp.com/jsonSample');
request.setMethod('GET');
HttpResponse response = http.send(request);
Integer responseCode = response.getStatusCode();
System.debug(responseCode + ': ' + responses.get(responseCode));
if (responses.get(response.getStatusCode()) == 'OK') {
    Map<String, Object> restResponse= (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
    List<Object> animalList = restResponse.values();
    for (Object a : animalList) {
      System.debug(a);
    }
}