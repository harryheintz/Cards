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
    controller.set('title', "Blackjack Part Time(s)!");
	controller.set('header', "This is the header");
	controller.set('footer', "This is the footer, yo!");
  }
});



// Assign the model

App.HomeRoute = Ember.Route.extend({
  setupController: function(controller, home) {
    controller.set('model', home);
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
