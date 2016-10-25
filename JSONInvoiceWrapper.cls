public class JSONInvoiceWrapper {

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

    public List<Invoice> invoiceList {get; set;}
}
