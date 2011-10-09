require "page_speed/version"

require 'open-uri'
unless defined?(::JSON::JSON_LOADED) and ::JSON::JSON_LOADED
  require 'json'
end

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

      rescue URI::InvalidURIError
        puts "Please check your URL and try again."

      rescue OpenURI::HTTPError
        puts "The API you used is not correct. Use the -k option to replace it."
        reset_api_key
        help

      rescue Exception => e
        puts "There has been an unexpected error:"
        puts e.message
        puts e.backtrace.inspect
      end
    end

    def help
      version
      usage
    end

    def version
      puts "page_speed gem, version #{PageSpeed::VERSION}\n"
    end

    def usage
      puts "usage: page_speed url | [ -k key | --key key ] | [ -v | --version ] | [ -h | --help ]"
      puts "You can get your key at http://code.google.com/intl/en-EN/apis/pagespeedonline/v1/getting_started.html"
    end

    def set_api_key(key)
      File.open(api_key_path, "w") {|f| f.write(key) }
    end

    def get_api_key
      file = File.new(api_key_path, "r")
      api_key = file.gets
      file.close
      api_key
    end

    def api_key_exists?
      begin
        get_api_key
        true
      rescue Exception => e
        p e
        false
      end
    end

    private

    def get_uri(url)
      unless url.match("https?:\/\/*")
        url = "http://#{url}"
      end
      uri = URI.parse(url)
      uri.open # ping URL; will raise a URI::InvalidURIError when failing
      uri
    end

    def scores_for(uri)
      desktop = score_for(uri, :desktop => true)
      mobile = score_for(uri, :desktop => false)
      [desktop, mobile]
    end

    def score_for(uri, opts)
      json = api_request(uri, opts)
      parse_score(json)
    end

    def api_request(uri, opts = {})
      # Merge options
      opts = {:desktop => true}.merge(opts)

      # Get URL for API
      params = {}
      params["url"] = uri
      params["key"] = get_api_key
      params["strategy"] = opts[:desktop] ? "desktop" : "mobile"
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

    def reset_api_key
      File.delete(api_key_path)
    end

    def api_key_path
      folder = ENV["TESTING"] ? "/tmp" : "~"
      File.expand_path("#{folder}/.page_speed")
    end
  end
end
