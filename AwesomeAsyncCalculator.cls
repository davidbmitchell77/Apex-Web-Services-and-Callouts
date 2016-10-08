public class AwesomeAsyncCalculator {

    public Double x {get; set;}
    public Double y {get; set;}
    public Double response {get; set;}
    
    public String requestLabel;
    private AsyncCalculatorServices.doAddResponseFuture futureCalc;
    private Integer timeoutSecs = 30;

    public Continuation startRequest() {
        Continuation contObj = new Continuation(timeoutSecs);
        contObj.continuationMethod = 'processResponse';
        AsyncCalculatorServices.AsyncCalculatorImplPort asyncCalculator = new AsyncCalculatorServices.AsyncCalculatorImplPort();
        futureCalc = asyncCalculator.beginDoAdd(contObj, x, y);
        return contObj;
    }

    public Object processResponse() {
        response = futureCalc.getValue();
        return null;
    }

    public PageReference clear() {
        x = null;
        y = null;
        response = null;
        return null;
    }
}