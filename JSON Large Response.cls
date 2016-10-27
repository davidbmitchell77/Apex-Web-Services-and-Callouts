Map<Integer, String> httpStatus = new Map<Integer, String>{
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
final String endpoint = 'https://jsonplaceholder.typicode.com/comments';
String s = '';

Http http = new Http();
HttpRequest request = new HttpRequest();
request.setEndpoint(endpoint);
request.setMethod('GET');
request.setTimeout(10 * 1000);  // 10 seconds
HttpResponse response = http.send(request);
Integer statusCode = response.GetStatusCode();

if (httpStatus.get(statusCode) == 'OK') {
  System.debug('HTTP Response Code: ' + statusCode + ' (' + httpStatus.get(StatusCode) + ')');
  Object[] objects = (Object[])JSON.deserializeUntyped(response.getBody());
  System.debug('Records returned: ' + objects.size());
  for (Object o : objects) {
    Map<String, Object> m = (Map<String, Object>)o;
    for (String attributeName : m.keySet()) {
      if (attributeName.toLowerCase() != 'body') {
        s += (attributeName + ': ' + m.get(attributeName));
        s += '\n';
      }
    }
    s += '====================================';
    System.debug(s);
    s = '';
  }
}
