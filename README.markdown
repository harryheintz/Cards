#Cards App

A simple card game application.


DATABASE SETUP
----

Make sure you have Postgres installed. The easiest way to do this these days is to download the Heroku Postgres app for OSX:

    http://postgresapp.com/
  
  
Unzip and move it to your Applications folder. Then add the following line to your ~/.bash_profile

    PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH"
  
In the terminal, then do:

    source ~/.bash_profile
  
to reload your profile in each currently open terminal window (or just open new ones)

You should now see the following results from these commands in terminal:

    which postgres
    yourusername$ /Applications/Postgres.app/Contents/MacOS/bin/postgres
  
    which psql
    yourusername$ /Applications/Postgres.app/Contents/MacOS/bin/psql
  
    which createdb
    yourusername$ /Applications/Postgres.app/Contents/MacOS/bin/createdb
  
Now create your development and test databases. From the Postgres.app elephant icon in your menubar, select "Open psql", then do:

    CREATE DATABASE cards_dev;
    CREATE DATABASE cards_test;

In the app, copy config/database.example to config/database.yml and enter your username, password (if needed locally) and database name for both development and testing.

Be sure to also do:

    bundle update

To see if it's all working properly, open the app in pry, finalize and auto migrate your db, create and save a user:

    pry -r ./init.rb
    pry(main)> DataMapper.finalize.auto_migrate!
    pry(main)> u = User.new
    => #<User @id=nil>
    pry(main)> u.save
    => true
    pry(main)> u.id
    => 1

You should now be able to correctly run all specs as well.

USAGE
-----
Here's an example of how you can play with this in Pry.

    $ pry -r ./init
    [1] pry(main)> DataMapper.finalize.auto_migrate!
    => DataMapper
    [2] pry(main)> @user = User.create
    => #<User @id=1 @hidden_cards=nil @visible_cards=nil>
    [3] pry(main)> game = BlackjackGame.start({number_of_players: 4, user: @user})
    => #<BlackjackGame @id=1 @number_of_players=4 @user_id=1>
    [4] pry(main)> game.user.hidden_cards
    => ["3Diamonds"]
    [5] pry(main)> game.user.visible_cards
    => ["ADiamonds"]
    [6] pry(main)> u = User.get(1)
    => #<User @id=1 @hidden_cards=<not loaded> @visible_cards=<not loaded>>
    [7] pry(main)> u.blackjack_games
    => [#<BlackjackGame @id=1 @number_of_players=4 @user_id=1>]
    [8] pry(main)> u.blackjack_games.first
    => #<BlackjackGame @id=1 @number_of_players=4 @user_id=1>

