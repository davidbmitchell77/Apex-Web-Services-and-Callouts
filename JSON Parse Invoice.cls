public class JSONParseInvoice {
    
    public class Invoice {
        public Double totalPrice {get; set;}
        public DateTime statementDate {get; set;}
        public Long invoiceNumber {get; set;}
        public List<LineItem> lineItems {get; set;}

        public Invoice(Double price, DateTime dt, Long invNumber, List<LineItem> liList) {
            totalPrice = price;
            statementDate = dt;
            invoiceNumber = invNumber;
            lineItems = liList.clone();
        }
    }

    public class LineItem {
        public Double unitPrice {get; set;}
        public Double quantity {get; set;}
        public String productName {get; set;}
    }
    
    public static void parseJSONString() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String endpoint = 'https://docsample.herokuapp.com/jsonSample';
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        
        // Parse the entire JSON response
        JSONParser parser = JSON.createParser(response.getBody());
        while (parser.nextToken() != null) {
            if (parser.getCurrentToken() == JSONToken.START_ARRAY) {  // '[' symbol
                while (parser.nextToken() != null) {
                    if (parser.getCurrentToken() == JSONToken.START_OBJECT) {  // '{' symbol
                        Invoice inv = (Invoice)parser.readValueAs(Invoice.class);  // read entire invoice obj (incl. line items)
                        System.debug('Invoice No.: ' + inv.invoiceNumber);
                        System.debug('Line Items: ' + inv.lineItems.size());
                        // skip child line items (as we have already read them) and go to next invoice
                        parser.skipChildren();
                    }
                }
            }
        }
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
      "statementDate": "2016-10-04T16:58:54.858Z",
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
      "statementDate": "2016-10-04T16:58:54.858Z",
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
