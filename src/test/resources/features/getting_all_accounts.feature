
@Smoke
Feature: Getting All accounts

Background: Get the token 
* def theResult = callonce read('GeneratedToken.feature')
And print theResult
* def theToken = theResult.response.token
Given url "https://tek-insurance-api.azurewebsites.net" 

# Getting the acount -endpoint: /api/accounts/all-accounts

Scenario: Getting All Accounts

Given path "/api/accounts/all-accounts"
And header Authorization = "Bearer " + theToken
When method get
Then status 200