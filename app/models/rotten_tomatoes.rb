
module RottenTomatoes

  class Client
    include HTTParty

    base_uri "http://api.rottentomatoes.com/api/public/v1.0"

    def initialize

    end

    def search_movies(data)
      # require 'pry'; binding.pry
      data.gsub!(/ /, "+")
      response = self.class.get("/movies.json?apikey=#{API_KEY}&q=#{data}&page_limit=1")
      parse_movies_response(response)
    end

    def parse_movies_response(response)
      response = JSON.parse(response)
      @movie = response["movies"][0]
    end

  end

end