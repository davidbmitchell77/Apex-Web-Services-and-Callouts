@isTest
    private class CaseManagerTest {

         static TestMethod void getCaseById() {
         Id caseId = createTestRecord();
         RestRequest request = new RestRequest();
         request.requestURI = getURI() + caseId;
         request.httpMethod = 'GET';
         RestContext.request = request;
         Case thisCase = CaseManager.caseById();
         System.assert(thisCase != null);
         System.assertEquals('Test Record', thisCase.Subject);
        }

        static TestMethod void createCase() {
            Id newCaseId = CaseManager.createCase('Ferocious chipmunk',
                                                  'New',
                                                  'Phone',
                                                  'Low');
            System.assert(newCaseId != null);
            Case newCase = [Select Subject FROM Case WHERE Id = :newCaseId];
            System.assertEquals('Ferocious chipmunk', newCase.Subject);
        }

        static TestMethod void deleteCase() {
            Id caseId = createTestRecord();
            RestRequest request = new RestRequest();
            request.requestURI = getURI() + caseId;
            request.httpMethod = 'DELETE';
            RestContext.request = request;
            CaseManager.deleteCase();
            List<Case> cases = [SELECT Id FROM Case WHERE Id = :caseId];
            System.assertEquals(0, cases.size());
        }

        static TestMethod void upsertCase() {
            //1. Insert new record
            Id case1Id = CaseManager.upsertCase('Ferocious Beagle',
                                                'New',
                                                'Web',
                                                'Low',
                                                null);
            System.assert(case1Id != null);
            Case case1 = [SELECT Id, Subject FROM Case WHERE Id = :case1Id];
            System.assert(Case1Id != null);

            //2. Update status of existing record to 'Working'
            Id case2Id = CaseManager.upsertCase('Ferocious Beagle',
                                                'Working',
                                                'Web',
                                                'Low',
                                                case1Id);
            System.assertEquals(case1Id, case2Id);
            Case case2 = [SELECT Id, Status FROM Case WHERE Id = :case2Id];
            System.assert(case2 != null);
            System.assertEquals(case2.Status, 'Working');
        }

        static TestMethod void updateCaseFields() {
            Id caseId = createTestRecord();
            RestRequest request = new RestRequest();
            request.requestURI = getURI() + caseId;
            request.httpMethod = 'PATCH';
            request.addHeader('Content-Type', 'application/json');
            request.requestBody = Blob.valueOf('{"status" : "Working"}');
            RestContext.request = request;
            Id thisCaseId = CaseManager.updateCaseFields();
            System.assert(thisCaseId != null);
            Case thisCase = [SELECT Id, Status FROM Case WHERE Id = :thisCaseId];
            System.assert(thisCase != null);
            System.assertEquals('Working', thisCase.Status);
        }

        static Id createTestRecord() {
            Case caseTestRecord = new Case(Subject = 'Test Record',
                                     Status = 'New',
                                     Origin = 'Phone',
                                     Priority = 'Medium');
            insert caseTestRecord;
            return caseTestRecord.Id;
        }

        static String getURI() {
        	String result = '';
        	result += '';
        	result += '';
        	return result;
        }
}