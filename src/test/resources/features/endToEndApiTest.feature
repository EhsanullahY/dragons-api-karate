@Regression
Feature: End to End Automate Account Creatoin.
Background: 

* def theResult = callonce read('GeneratedToken.feature')
And print theResult
* def theToken = theResult.response.token
Given url "https://tek-insurance-api.azurewebsites.net" 


Scenario: Automate Account Creation
# Creation of the account
* def dataFromGenerator = Java.type('api.dataprovider.DataProvider')
* def autoEmail = dataFromGenerator.getApiEmail()
Given path "/api/accounts/add-primary-account"
And header Authorization = "Bearer " + theToken
And request

"""
{
  "email": "#(autoEmail)",
  "firstName": "Ehsanullah",
  "lastName": "Ehsan",
  "title": "Mr",
  "gender": "MALE",
  "maritalStatus": "MARRIED",
  "employmentStatus": "Self",
  "dateOfBirth": "1989-03-03"

}
"""
When method post
And status 201
And print response
And assert response.email == autoEmail
*  def thePrimId = response.id

# Add an Adress

Given path "/api/accounts/add-account-address" 
And param primaryPersonId = thePrimId
And header Authorization = "Bearer " + theToken
And request
"""
{
  "addressType": "Home",
  "addressLine1": "1900 Sherman",
  "city": "LA",
  "state": "CA",
  "postalCode": "89123",
  "countryCode": "",
  "current": true

}
"""
When method post
And status 201
And print response
Then assert response.addressType == "Home"

# Add a phone
Given path "/api/accounts/add-account-phone" 
And param primaryPersonId = thePrimId
And header Authorization = "Bearer " + theToken
* def randmPhone = dataFromGenerator.getPhoneNo
And request 
"""
{
 
  "phoneNumber": "#(randmPhone)",
  "phoneExtension": "",
  "phoneTime": "Morning",
  "phoneType": "Mobile"
}
"""
When method post 
And status 201
Then print response 
And assert response.phoneNumber == randmPhone


# Add a Car
Given path "/api/accounts/add-account-car" 
And param primaryPersonId = thePrimId
And header Authorization = "Bearer " + theToken
And request
"""
{
  "make": "Mercedes",
  "model": "Gw",
  "year": "2000",
  "licensePlate": "AC30349"
}
"""
When method post
And status 201
Then print response
Then assert response.make == "Mercedes"



# Get the account
Given path "/api/accounts/get-account"
And param primaryPersonId = thePrimId
And header Authorization = "Bearer " + theToken

When method get
And status 200
Then print response 

# Delete the account
#Given path "/api/accounts/delete-account" 
#And param primaryPersonId = thePrimId
#And header Authorization = "Bearer " + theToken
#And method delete
#Then print response
