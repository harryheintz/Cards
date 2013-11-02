module Implementation
  class Web < Sinatra::Base
    module Views
      class Layout < Mustache
        def title
          @title || "Blackjack Party Time(s)."
        end
      end
      class Home < Layout
        def content
          "Welcome to Blackjack game."
        end
      end
      class About < Layout
        def content
          "This is some content."
        end
      end
      class Account < Layout
        def name
          "Bob Franks"
        end
      end
      class Test < Layout
        def test
          attributes = { "number_of_players"=> 3,"user_id"=> 1 }
          test = BlackjackGame.start(attributes)
        end
      end
    end
  end
end