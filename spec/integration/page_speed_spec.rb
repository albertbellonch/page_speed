require 'spec_helper'

API_KEY = "AIzaSyCT0PgAW-FjLF0Nfx81DqU6laCSiXkIHFs"
TMP_FILE = "/tmp/.page_speed"

describe PageSpeed do
  before do
    ENV["TESTING"] = "TRUE"
    File.open(TMP_FILE, 'w') {|f| f.write(API_KEY) } # Use a correct API KEY
  end

  it "should point to help when no parameter is provided" do
    result = `bin/page_speed`
    result.should include("Please check your syntax")
    result.should include("usage: page_speed")
  end

  context "version" do
    it "should be shown with -v" do
      result = `bin/page_speed -v`
      result.should include(PageSpeed::VERSION)
    end

    it "should be shown with --version" do
      result = `bin/page_speed --version`
      result.should include(PageSpeed::VERSION)
    end
  end

  context "help" do
    it "should be shown with -h" do
      result = `bin/page_speed -h`
      result.should include("usage: page_speed")
    end

    it "should be shown with --help" do
      result = `bin/page_speed --help`
      result.should include("usage: page_speed")
    end
  end

  context "analyzer" do
    it "should fail with a number as a parameter" do
      result = `bin/page_speed 42`
      result.should include("Please check your URL and try again")
    end

    it "should fail with a bad string as a parameter" do
      result = `bin/page_speed do_the_cuca`
      result.should include("Please check your URL and try again")
    end

    it "should success with a URL without www" do
      result = `bin/page_speed google.com`
      result.should include("Google Page Speed for http://google.com: 98 (Desktop) / 97 (Mobile)")
    end

    it "should success with a URL with www" do
      result = `bin/page_speed www.facebook.com`
      result.should include("Google Page Speed for http://www.facebook.com: 99 (Desktop) / 99 (Mobile)")
    end
  end

  context "API key control" do
    it "should prompt the API key when is not found" do
      File.delete(TMP_FILE)
      result = `bin/page_speed google.com`
      result.should include("PI key not set. Use the -k option to set the key.")
    end

    context "when API key is corrupted" do
      before do
        File.open(TMP_FILE, 'w') {|f| f.write(API_KEY.chop) } # Use a corrupt API KEY
        @result = `bin/page_speed google.com`
      end

      it "should prompt about it" do
        @result.should include("The API you used is not correct.")
      end

      it "should have deleted the file where the API key is and ask for a new one" do
        @result = `bin/page_speed google.com`
        @result.should include("API key not set. Use the -k option to set the key.")
      end

      it "should have indeed deleted the file" do
        @result = `bin/page_speed google.com`
        File.exists?(TMP_FILE).should == false
      end
    end
  end

  context "key" do
    before do
      @result = `bin/page_speed -k DO_THE_CUCA`
    end

    it "should be set and the user should get feedback" do
      @result.should include("API key set.")
    end

    it "should be correctly set" do
      PageSpeed::get_api_key.should == "DO_THE_CUCA"
    end
  end

  after do
    File.delete(TMP_FILE) if File.exists?(TMP_FILE)
  end
end
