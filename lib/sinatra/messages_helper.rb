#=Overview
#A neat Sinatra Helper for including terse Sinatra::Messages magic in your app
#
#Author::    Jen Oslislo  (mailto:jennifer@stepchangegroup.com)
#
#=Setup
#
#In your vendor/mast/env.rb include:
#  Sinatra::Base.register Sinatra::MessagesHelper
#
#In your app/views/layout.erb include:
#  <%= get_messages %>
#
#=Usage
#
#Use it like zis:
#   info("Here is an info message", title)
#   success("Here is a success message", title)
#   error("Here is an error message", title)
#
#Or, if you're lazy, without the title, like zis:
#   info "Here is an info message"
#   success "Here is a success message"
#   error "Here is an error message"
#
module Sinatra
  module MessagesHelper
    
    
    #Adds MessagesHelper to your Sinatra app helpers
    #
    def self.registered(app)
      app.helpers Sinatra::MessagesHelper
    end
        
    #Clear messages that might persist across requests
    #
    def clear
      Sinatra::Messages.clear
    end
    
    #Print a yellow message to STDOUT and console.log
    #You get:
    #   |TITLE|This message has a title
    #
    def info(message, title=nil)
      Sinatra::Messages.info("#{get_env}#{message}", title)
    end

    #Print a red message to STDOUT and console.log
    #You get:
    #   |TITLE|This message has a title
    #
    def err(message, title=nil)
      Sinatra::Messages.error("#{get_env}#{message}", title)
    end
    
    #Print a green message to STDOUT and console.log
    #You get:
    #   |TITLE|This message has a title
    #
    def success(message, title=nil)
      Sinatra::Messages.success("#{get_env}#{message}", title)
    end
    
    #Formats a string for including all your queued messages
    #in js's console.log. Include it in your layout.erb thusly:
    # <%= get_messages %>
    #
    #Returns [String] Javascript console.log messages for your view
    def get_messages
      %{
        <script>
        if (navigator.appName!="Microsoft Internet Explorer") {
          #{Sinatra::Messages.get}
          #{@console}
         }
        </script>
      }
    end

    #Experimental method to "prettily" print a variable to STDOUT
    #Throw it a hash: 
    #  params = {:title => "Sula", :author => "Toni Morrison", :url => "http://www.amazon.com/Sula-Toni-Morrison/dp/1400033438/ref=sr_1_1?ie=UTF8&qid=1287829692&sr=8-1"}
    #And you get:
    #   DEBUG|url
    #            http://www.amazon.com/Sula-Toni-Morrison/dp/1400033438/ref=sr_1_1?ie=UTF8&qid=1287829692&sr=8-1
    #   DEBUG|title
    #             Sula
    #   DEBUG|author
    #            Toni Morrison
    #
    def pretty(*args)
      
      puts ""
      
      if args[0].class == Hash
        return self.process_hash(args[0])
      end
      
      args.each do |arg|

        title = "DEBUG|#{arg.class}"
        if arg.respond_to?('inspect')
          value = arg.inspect
        else
          value = arg
        end

        puts "#{Time.now}::#{self.format_message(value, title)}"
        self.add_to_console(self.format_for_console(value, title))
        
      end
    
      puts ""
      
    end

    protected
    
    def get_env
      if request and request.env.is_a?(Hash)
        @user_agent = request.env['HTTP_USER_AGENT']
        @ip_addr = request.env['REMOTE_ADDR']
        @user_string = "#{@ip_addr}::#{@user_agent}::"
      else
        @user_string = "Unknown::"
      end
    rescue NameError => e
      @user_string = "Unknown::"
    end
    
    def add_to_console(message)
      @console.nil? ? (@console = message) : (@console += message)
    end

    def format_for_console(message, title)
      "\nconsole.log(\"#{title}|#{message.to_s.gsub!(/[\{\}\"\'#<>\n\r]/, '')}\");"
    end
    
    # Needs some work here
    def process_hash(args)
      
      args.each do |key, val|
        title = "DEBUG|#{key}"
        if val.respond_to?('inspect')
          value = val.inspect
        else
          value = val
        end
        value = val
        puts "#{Time.now}::#{self.format_message(value, title)}"
        self.add_to_console(self.format_for_console(value, title))
      end

    end
    
    def format_message(message, title)
      %{#{title.underline}
            #{message.yellow}}
    end
    
  end
end
