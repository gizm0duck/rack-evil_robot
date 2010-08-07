module Rack
  class EvilRobot
    def initialize(app, options = {})
      @app = app
      @redirect_path = options[:redirect_path] || 'http://www.example.com/'
    end

    def call(env)
      if evil_robot?(env)
        goodbye
      else
        if env['PATH_INFO'] =~ /honey_pot/
          [200, {'Content-Type' => 'text/html'}, ['Mmmm Honey...']]
        else
          @app.call(env)
        end
      end
    end

    private
    def evil_robot?(env)
      env['HTTP_USER_AGENT'] && env['HTTP_USER_AGENT'] =~ evil_robots
    end

    def goodbye
      [301, {'Location' => @redirect_path}, ['No thank you.']]
    end
    
    def evil_robots
      # add your evil-bots here... these are just for examples sake
      /badBot|reallyBadBot/i
    end
  end
end