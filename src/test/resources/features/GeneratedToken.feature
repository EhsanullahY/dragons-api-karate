

Feature: TokenGeneratedFile

Scenario: Create token with valid username and password.
 #prepare request 
 Given url "https://tek-insurance-api.azurewebsites.net" 
 And path "/api/token" 
 And request {"username": "supervisor","password": "tek_supervisor"} 
 #Send request 
 When method post  
 #Validating response 
 Then status 200
 And print response