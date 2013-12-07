@person
Feature: Login
  As a API user
  In order to log in to my account
  I want to send my credentials and recieve person data 
  
  Background:
  	Given my account exists
    Given I am a valid API user
    And I send and accept JSON
	
  Scenario: Login
    Given I send a POST request to "/api/v1/login" with the following:
    """
      {"email": "foo@foobar.com" ,"password": "password" }
	  
    """
    Then the response code should be "201"
    And the JSON response body should have the following elements:
		 | game_id              |
		 | user_cards           |
		 | house_cards          |
		 | ap_one_cards         |
		 | ap_two_cards         |
		 | user_split           |
		 | user_blackjack_win   |
		 | house_blackjack_win  |
		 | ap_one_blackjack_win |
		 | ap_two_blackjack_win |
		 | first_round_push     |
