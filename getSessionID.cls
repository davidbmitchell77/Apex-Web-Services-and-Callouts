@RestResource(urlMapping='/sessionID/*')
global with sharing class sessionID {

  @HttpGet
  global static AuthorizationToken get() {
    AuthorizationToken jsonResponse = new AuthorizationToken();
    jsonResponse.sessionID = UserInfo.getSessionID();
    return(jsonResponse);
  }

  global class AuthorizationToken {
    global String sessionID;
  }
}
