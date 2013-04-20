

module TT
  class TestMiddleware
    def initialize(app)
      @app = app
    end
    
    def call(env)
      status, headers, body  = @app.call(env)
#      puts '------------------------- test middileware ------------------'
      print  env,status, headers, body, "\n"
#      puts '---------------------------------------------------------------'
#      [status, headers, body]
      [status, headers, body]
    end
  end
end
