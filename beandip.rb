require 'beanstalk-client'
require 'json'
require 'uri'
require 'timeout'

module Beandip
  class Application < Sinatra::Base
    def beanstalk
      @@beanstalk ||= Beanstalk::Pool.new([ beanstalk_host_and_port ])
    end
  	def beanstalk_url
  		ENV['BEANSTALK_URL'] || 'beanstalk://localhost/'
  	end
  	def beanstalk_host_and_port
  		uri = URI.parse(beanstalk_url)
  		raise(BadURL, beanstalk_url) if uri.scheme != 'beanstalk'
  		return "#{uri.host}:#{uri.port || 11300}"
  	end
    
    get '/' do
      erb :index
    end
  end
end