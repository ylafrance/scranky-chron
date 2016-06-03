class MyRackMiddleware
  def initialize(appl)
    @appl = appl
  end
  def call(env)
    status, headers, body = @appl.call(env) # we now call the inner application
    append_s = "... greetings from RubyLearning !!!"
    new_body = ""
    body.each { |string| new_body << " " << string }
    new_body << " " << append_s
    [status, headers, [new_body]]
  end
end

