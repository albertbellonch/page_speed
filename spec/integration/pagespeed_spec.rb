require 'spec_helper'

describe PageSpeed do
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
      result.should include("Google Page Speed for http://google.com: 98 (Desktop) / 96 (Mobile)")
    end

    it "should success with a URL with www" do
      result = `bin/page_speed www.facebook.com`
      result.should include("Google Page Speed for http://www.facebook.com: 99 (Desktop) / 99 (Mobile)")
    end
  end
end
