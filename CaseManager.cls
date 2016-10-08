@RestResource(urlMapping='/Cases/*')
global with sharing class CaseManager {
    @HttpGet
    global static Case caseById() {
        RestRequest request = RestContext.request;
        String caseId = getCaseId(request.requestURI);
        Case result = [SELECT CaseNumber,
                              Subject,
                              Status,
                              Origin,
                              Priority
                         FROM Case
                        WHERE Id = :caseId];
        return result;
    }

    @HttpPost
    global static ID createCase(String subject,
                                String status,
                                String origin,
                                String priority) {

        Case newCase = new Case(Subject = subject,
                                Status = status,
                                Origin = origin,
                                Priority = priority);

        insert newCase;
        return newCase.Id;
    }

    @HttpDelete
    global static void deleteCase() {
        RestRequest request = RestContext.request;
        String caseID = getCaseId(request.requestURI);
        Case thisCase = [SELECT Id FROM Case where Id = :caseId];
        delete thisCase;
    }

    @HttpPut
    global static Id upsertCase(String subject,
                                String status,
                                String origin,
                                String priority,
                                String id) {

        Case thisCase = new Case(Id = id,
                                 Status = status,
                                 Origin = origin,
                                 priority = priority);

        upsert thisCase;
        return thisCase.Id;
    }

    @HttpPatch
    global static Id updateCaseFields() {
        RestRequest request = RestContext.request;
        String caseId = getCaseId(request.requestURI);
        Case thisCase = [SELECT Id FROM Case Where Id = :caseId];
        // Deserialize the JSON string into name-value pairs
        String requestBody = request.requestBody.toString();
        Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(requestBody);
        for (String fieldName : params.keySet()) {
            // Set the field and field value on the Case object
            thisCase.put(fieldName, params.get(fieldName));
        }
        update thisCase;
        return thisCase.Id;
    }

    private static String getCaseId(String uri) {
        String result = '';
        result = uri.substring(uri.lastIndexOf('/') + 1);
        return result;
    }
}