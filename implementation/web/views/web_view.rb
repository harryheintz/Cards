module Implementation
  class Web < Sinatra::Base
    module Views
      class Layout < Mustache
        def title
          @title || "Eventually, I will be a number game."
        end
      end
      class Home < Layout
        def content
          "Welcome to the Number Game."
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
      class Game < Layout
        def game
         "Let's get freaky with some number guessing"
        end
           
      end
    end
  end
end