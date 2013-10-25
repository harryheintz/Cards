# @alerts
# Feature: Retrieving System Alerts
#   As a Public API user
#   In order to display general system messages in the app
#   I want to retrieve all current system alerts
#   
#   Background:
#     Given I am a valid API user
#     And I send and accept JSON
#     And there are five system alerts
#   
#   Scenario: Retrieving a resource list of alerts
#     Given I send a GET request to "/api/v1/alerts"
#     Then the JSON response headers should set appropriately
#     Then the response code should be "200"
#     And the JSON response should be an array with 5 "resource_uri" elements
#     
#   Scenario: Retrieving a specific alert
#     Given I send a GET request to "/api/v1/alerts/1"
#     Then the JSON response headers should set appropriately
#     Then the response code should be "200"
#     And the JSON response body should have the following elements:
#       | message             | 
#       | published_datetime  | 
#       | expired_datetime    |
#     And the JSON response body should have the following rel and href values:
#       | rel    | href             |
#       | self   | /api/v1/alerts/1 |
#       | index  | /api/v1/alerts   |