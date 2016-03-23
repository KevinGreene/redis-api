require 'sinatra'
require "redis"
require 'dotenv'

Dotenv.load

redis = Redis.new(:host => ENV["REDIS_HOST"])
required_token = ENV["REQUIRED_TOKEN"]

accepted_commands = ["get", "set", "incr", "decr"]

set :bind, '0.0.0.0'

post '/redis' do
  if params["token"] == required_token
    message = params["text"].split
    command = message.first.downcase

    if accepted_commands.include? command
      arity = Redis.instance_method(command).arity
      if arity == message.length - 1 or (message.length == 3 and command == "set")
        result = redis.send(*message)
        result
      else
        status 400
        body "That command takes " + arity.to_s + " arguments"
      end
    else
      status 400
      body "We only accept the following commands " + accepted_commands.join(",")
    end
  else
    status 501
    body "You need the right token"
  end
end
