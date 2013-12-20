// Create the app

App = Ember.Application.create();

// Assign the URLs

App.Router.map(function() {
  this.route("home");
  this.route("start");
  this.route("play");
 
});

// Instantiates the data to be used throught the app on the layout template.

App.ApplicationRoute = Ember.Route.extend({
  setupController: function(controller) {
    controller.set('title', "Blackjack Party Time(s)!");
	controller.set('header', "This is the header");
	controller.set('footer', "This is the footer, yo!");
  }
});



// Assign the model

App.StartRoute = Ember.Route.extend({
  model: function() {
    return start_message;
  }
});

// App.StartRoute = Ember.Route.extend({
//   setupController: function(controller, start) {
//     controller.set('model', start);
//   }
// });

// App.PlayRoute = Ember.Route.extend({
//   setupController: function(controller, play) {
//     controller.set('model', play);
//   }
// });


// Assign the controller to be instantiated
App.HomeController = Ember.Controller.extend({
	
	cardFace:  "Ace of spades",
	cardValue: "11"
  
});


// These are Models for the data

// App.Start = DS.Model.extend({
// 	Json data by key
//  example: game_id: DS.attr('integer'),
// });

// App.Start.FIXTURES = JSON DATA from API;

// App.Play = DS.Model.extend({
// 	JSON data by key
//  example: game_id: DS.attr('integer'),
// });

// App.Play.FIXTURES = JSON DATA from API;

var start_message = {
    "game_id": 12,
    "game_status": "continue",
    "game_message": "Next play...",
    "user": {
        "user_id": 1,
        "cards": [
            {
                "image_key": "4Spades",
                "value": 4,
                "hidden": true
            },
            {
                "image_key": "7Diamonds",
                "value": 7,
                "hidden": false
            }
        ],
        "message": "Play on!",
        "status": "continue"
    },
    "house": {
        "house_id": 27,
        "cards": [
            {
                "image_key": "7Hearts",
                "value": 7,
                "hidden": true
            },
            {
                "image_key": "6Hearts",
                "value": 6,
                "hidden": false
            }
        ],
        "message": "Play on!",
        "status": "continue"
    },
    "artificial_players": {
        "ap_id": 26,
        "cards": [
            {
                "image_key": "5Clubs",
                "value": 5,
                "hidden": true
            },
            {
                "image_key": "9Hearts",
                "value": 9,
                "hidden": false
            }
        ],
        "message": "Play on!",
        "status": "continue"
    }
};

var play_message = {
    "game_id": 12,
    "game_status": "game over",
    "game_message": "And that's a wrap!",
    "user": {
        "user_id": 1,
        "cards": [
            {
                "image_key": "4Spades",
                "value": 4,
                "hidden": true
            },
            {
                "image_key": "7Diamonds",
                "value": 7,
                "hidden": false
            },
            {
                "image_key": "10Clubs",
                "value": 10,
                "hidden": false
            }
        ],
        "message": "WINNER!",
        "status": "twentyone"
    },
    "house": {
        "house_id": 27,
        "cards": [
            {
                "image_key": "7Hearts",
                "value": 7,
                "hidden": true
            },
            {
                "image_key": "6Hearts",
                "value": 6,
                "hidden": false
            },
            {
                "image_key": "7Spades",
                "value": 7,
                "hidden": false
            }
        ],
        "message": "Stand!",
        "status": "standng"
    },
    "artificial_players": {
        "ap_id": 26,
        "cards": [
            {
                "image_key": "5Clubs",
                "value": 5,
                "hidden": true
            },
            {
                "image_key": "9Hearts",
                "value": 9,
                "hidden": false
            },
            {
                "image_key": "9Diamonds",
                "value": 9,
                "hidden": false
            }
        ],
        "message": "BUSTED!",
        "status": "busted"
    }
};
