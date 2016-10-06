@isTest
public class AnimalsCalloutsTest {

    static TestMethod void testGETCallout() {
        // Create the mock response based on a static resource
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetAnimalResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        // Associate the callout with the mock response
        Test.setMock(HttpCalloutMock.class, mock);
        // Call the method to test
        HttpResponse result = AnimalsCallouts.makeGETCallout();
        // Verify mock response is not null
        System.assertNotEquals(result, null, 'The callout returned a null response.');
        // Verify the status code
        System.assertEquals(result.getStatusCode(), 200, 'The status code is not 200.');
        // Verify content type
        System.assertEquals(result.getHeader('Content-Type'), 'application/json;charset=UTF-8', 'Unexpected content type value.');
        // Verify the array contains 3 items
        Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(result.getBody());
        List<Object> animals = (List<Object>)results.get('animals');
        System.assertEquals(animals.size(), 3, 'The array should only contain 3 items.');
    }

    static TestMethod void testPOSTCallout() {
        // Set mock callout class
        Test.setMock(HttpCalloutMock.class, new AnimalsHttpCalloutMock());
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock
        HttpResponse response = AnimalsCallouts.makePostCallout();
        // Verify the the response received contains fake values
        String actualContentType = response.getHeader('Content-Type');
        String actualBody = response.getBody();
        Integer actualStatusCode = response.getStatusCode();
        String expectedContentType = 'application/json';
        String expectedBody = '{"animals" : ["majestic badger", "fluffy bunny", "scary bear", "chicken", "mighty moose"]}';
        Integer expectedStatusCode = 200;
        System.assertEquals(expectedContentType, actualContentType);
        System.assertEquals(expectedBody, actualBody);
        System.assertEquals(expectedStatusCode, actualStatusCode);
    }
}