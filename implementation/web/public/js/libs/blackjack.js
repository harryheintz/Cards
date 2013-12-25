var blackjackGame = (function () 
 {
	 $(document).ready(function (){
		 $("button").click(function(){
		    $.post("/api/v1/start",
		    {
		      user_id: 1,
		      number_of_players: 3
		    }),
		})
	 
 });
 
 (blackjackGame);