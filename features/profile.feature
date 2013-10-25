# @profile
# Feature: Manage User Profile
#   As a API user
#   In order to manage my user profile
#   I want to send and receive data for my account
#   
#   Scenario: Show My User Profile
#     Given I am a valid API user
#     And I send and accept JSON
#     When I send a GET request to "/api/v1/profile.json"
#     Then the response code should be "200"
#     And the JSON response body should have the following elements:
#       | id              | 
#       | email           | 
#       | username        |
#       | first_name      |
#       | last_name       |
#       | bio             |
#       | api_key         |
#       | last_sign_in_at | 
#       | last_sign_in_ip |
#   
#   Scenario: Update My User Profile
#     Given I am a valid API user
#     And I send and accept JSON
#     When I send a PUT request to "/api/v1/profile.json" with the following:
#     """
#       {"user":{"email":"lukeduke@example.com","username":"lukeduke","first_name":"Luke","last_name":"Duke","bio":"I changed this here bio!"}}
#     """
#     Then the response code should be "200"
#     And the JSON response body should return "lukeduke@example.com" for "email"
#     And the JSON response body should return "lukeduke" for "username"
#     And the JSON response body should return "Luke" for "first_name"
#     And the JSON response body should return "Duke" for "last_name"
#     And the JSON response body should return "I changed this here bio!" for "bio"
