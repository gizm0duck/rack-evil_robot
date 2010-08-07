require 'spec_helper'

describe Rack::EvilRobot do
  
  describe "call" do
    attr_reader :app
    before do
      @app = lambda { |env| [200, {'Content-Type' => 'text/plain'}, ['This is my body']] }
    end
    
    context "when the user agent is in the evil robots list" do
      describe "when passing in custom redirect_path" do
        it "redirects to the custom path" do
          request = Rack::MockRequest.env_for('/real_path', {'HTTP_USER_AGENT' => 'badBot'})
          response = Rack::EvilRobot.new(app, {:redirect_path => "http://www.google.com"}).call(request)
          response[0].should == 301
          response[1]["Location"].should == "http://www.google.com"
          response[2].should == ["No thank you."]
        end
      end
      
      describe "when no custom options are passed in" do
        it "redirects the bot to example.com" do
          request = Rack::MockRequest.env_for('/real_path', {'HTTP_USER_AGENT' => 'badBot'})
          response = Rack::EvilRobot.new(app).call(request)
          response[0].should == 301
          response[1]["Location"].should == "http://www.example.com/"
          response[2].should == ["No thank you."]
        end
      end
    end

    context "when the user agent is not in the evil robots list" do
      context "when the request hits the honey pot" do
        it "tells the robot it's been busted" do
          request = Rack::MockRequest.env_for('/honey_pot/sticky.html', {'HTTP_USER_AGENT' => 'Mozilla/5.0'})
          response = Rack::EvilRobot.new(app).call(request)
          response.first.should == 200
          response.last.should == ["Mmmm Honey..."]
        end
      end
      
      context "when the request does not hit the honey pot" do
        it "does nothing" do
          request = Rack::MockRequest.env_for('/real_path', {'HTTP_USER_AGENT' => 'Mozilla/5.0'})
          body = Rack::EvilRobot.new(app).call(request).last
          body.should == ['This is my body']
        end
      end
    end
  end
end
