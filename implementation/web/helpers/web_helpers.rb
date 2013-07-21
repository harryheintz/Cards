module Implementation
  class Web < Sinatra::Base
    helpers do
      # All helpers defined here will be available across all the application.
      #
      # @example A helper method for date formatting.
      #
      #   def format_date(date, format = "%d/%m/%Y")
      #     date.strftime(format)
      #   end
    end
  end
end