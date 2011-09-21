require "page_speed/version"

require 'json'
require 'open-uri'

API_KEY = "AIzaSyB-WW7oKAfD0T9cLGMufjiWA1mtLwDd4hg"
API_URL = "https://www.googleapis.com/pagespeedonline/v1/runPagespeed"

module PageSpeed
  class << self
    def analyze(url)
      begin
        # Parse URL
        uri = get_uri(url)

        # Get scores
        desktop, mobile = scores_for(uri)

        # Show results
        show_results(uri, desktop, mobile)
      rescue Exception
        puts "There has been an error. Please check your URL."
      end
    end

    private

    def get_uri(url)
      unless url.match("https?:\/\/*")
        url = "http://#{url}"
      end
      uri = URI.parse(url)
      uri.open
      uri
    end

    def scores_for(uri, opts = {})
      desktop = score_for(uri, true)
      mobile = score_for(uri, false)
      [desktop, mobile]
    end

    def score_for(uri, is_desktop)
      json = api_request(uri, is_desktop)
      parse_score(json)
    end

    def api_request(uri, is_desktop)
      # Get options
      strategy =

      # Get URL for API
      params = {}
      params["url"] = uri
      params["key"] = API_KEY
      params["strategy"] = is_desktop ? "desktop" : "mobile"
      params_str = params.map{|k,v| "#{k}=#{v}" }.join("&")

      # Send request and return JSON
      api_uri = URI.parse(URI.escape(API_URL + "?" + params_str))
      api_uri.open.read
    end

    def parse_score(json)
      h = JSON.parse(json)
      h["score"]
    end

    def show_results(url, desktop, mobile)
      puts "Google Page Speed for #{url}: #{desktop} (Desktop) / #{mobile} (Mobile)"
    end
  end
end
