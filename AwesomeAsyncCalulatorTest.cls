@isTest
private class AwesomeAsyncCalulatorTest {

    static TestMethod void TestCallout() {
        AwesomeAsyncCalculator asyncCalculator = new AwesomeAsyncCalculator();
        asyncCalculator.x = 2;
        asyncCalculator.y = 3;
        asyncCalculator.response = 5;
        asyncCalculator.clear();
        Continuation continuationObj = asyncCalculator.startRequest();
        Map<String, HttpRequest> requests = continuationObj.getRequests();
        System.assertEquals(1, requests.size());
        System.assertNotEquals(null, requests.get('Continuation-1'));
        HttpResponse resp = new HttpResponse();
        resp.setBody('22');
        Test.setContinuationResponse('Continuation-1', resp);
        Test.invokeContinuationMethod(asyncCalculator, continuationObj);
    }
}
