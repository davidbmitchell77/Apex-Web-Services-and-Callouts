public class JSONParseUtil {
    @future(callout=true)
    public static void parseJSONResponse() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String endpoint = 'https://docsample.herokuapp.com/jsonSample';
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        System.debug(response.getBody());
        // Parse JSON reponse and calculate sum(totalPrice).
        JSONParser parser = JSON.createParser(response.getBody());
        Double grandTotal = 0.0;
        while (parser.nextToken() != null) {
            if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                if (parser.getText() == 'totalPrice') {
                    parser.nextToken();
                    grandTotal += parser.getDoubleValue();
                }
            }
        }
        System.debug('Grand total = ' + grandTotal);
    }
}
/* ----------------------------------------------------------- */
/*       J S O N   D A T A                                     */
/* ----------------------------------------------------------- */
/*
{
  "invoiceList": [
    {
      "totalPrice": 5.5,
      "statementDate": "2011-10-04T16:58:54.858Z",
      "lineItems": [
        {
          "UnitPrice": 1,
          "Quantity": 5,
          "ProductName": "Pencil"
        },
        {
          "UnitPrice": 0.5,
          "Quantity": 1,
          "ProductName": "Eraser"
        }
      ],
      "invoiceNumber": 1
    },
    {
      "totalPrice": 11.5,
      "statementDate": "2011-10-04T16:58:54.858Z",
      "lineItems": [
        {
          "UnitPrice": 6,
          "Quantity": 1,
          "ProductName": "Notebook"
        },
        {
          "UnitPrice": 2.5,
          "Quantity": 1,
          "ProductName": "Ruler"
        },
        {
          "UnitPrice": 1.5,
          "Quantity": 2,
          "ProductName": "Pen"
        }
      ],
      "invoiceNumber": 2
    }
  ]
}
*/