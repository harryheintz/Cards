Given /^my user account exists$/ do
  User.create
end

Given /^my game has started$/ do
  attributes = {"number_of_players" => 3, "user_id" => 1}
  BlackjackGame.start(attributes)
  #game
end