#=Overview
#A little class for printing colored messages to STDOUT and js info
#to console.log. It's more fun with MessagesHelper
#
#Author::    Jen Oslislo  (mailto:jennifer@stepchangegroup.com)
#
#=Usage
#
#Use it like zis:
#   Sinatra::Messages.info("Here is an info message", title)
#   Sinatra::Messages.success("Here is a success message", title)
#   Sinatra::Messages.error("Here is an error message", title)
#
#Or, if you're lazy, without the title, like zis:
#   Sinatra::Messages.info "Here is an info message"
#   Sinatra::Messages.success "Here is a success message"
#   Sinatra::Messages.error "Here is an error message"
#
#You can also specify whether or not to include stack trace information:
#  Sinatra::Messages.trace = true
#
module Sinatra
  module Messages
  
    @@color = :yellow
    @@default = :white
    @@level = 1
        
    attr_accessor :suppress
    
    def self.suppress
      @suppress
    end
    
    def self.suppress=(bool)
      @suppress = bool
    end
    
    def self.default_color
      @@default
    end
    
    #Turn Show Stack Trace on or off
    #
    def self.trace=(bool)
      @show_stack_trace = bool
    end
    
    def self.trace?
      @show_stack_trace ? true : false
    end
    
    #Clear messages that might persist across requests
    #
    def self.clear
      @messages = ""
    end

    def self.messages
      @messages
    end

    #Print a yellow message to STDOUT and console.log
    #You get:
    #   |TITLE|This message has a title
    #
    def self.info(message, title=nil)
      self.generic_message('puts_info', message, title)
    end
      
    #Print a red message to STDOUT and console.log
    #You get:
    #   |TITLE|This message has a title
    #
    def self.error(message, title=nil)
      self.generic_message('puts_error', message, title)
    end
    
    #Print a green message to STDOUT and console.log
    #You get:
    #   |TITLE|This message has a title
    #
    def self.success(message, title=nil)
      self.generic_message('puts_success', message, title)
    end
    
    #Gets all the stored messages for STDOUT and console.log
    #
    #Returns [String] All of the messages to print to STDOUT, include in console.log
    def self.get
      "#{@messages}"
    end

    private
    
    def self.generic_message(method, message, title=nil)
      @messages = "" if not @messages
      @messages += self.send(method, message, title)
      ""
    end
    
    def self.get_method(title)
      "|#{title.upcase}|"
    end
    
    def self.grep_caller
      if self.trace?
        caller_string = "\n\t#{Time.now}::Stack Trace: "
        caller(@@level).each do |call|
        
          if call =~ /(sinatra\/base|1.8\/gems|thin|sinatra\/messages)/
            next
          else
            caller_string += "#{call}\n"
          end
        
        end
      
        "#{caller_string}\tMessage: "
      end
      
    end
    
    def self.puts_info(message='Some generic info', title=nil)
      self.puts_generic_message(message, @@color, title)
    end
    
    def self.puts_error(message='Some generic error', title=nil)
      self.puts_generic_message(message, 'red', title)
    end
    
    def self.puts_success(message='Some generic success', title=nil)
      self.puts_generic_message(message, 'green', title)
    end
    
    def self.puts_generic_message(message, color, title=nil)
      titleect_string = title.nil? ? "" : self.get_method(title)
      puts "\n\t#{Time.now}::#{self.grep_caller}#{titleect_string}#{message}\n".__send__(color) unless @suppress
      
      message.to_s.gsub!(/[\{\}\"\'#<>\n\r]/, '')
      
      if @suppress
        ""
      else
        "console.log(\"#{message}\");"
      end
      
    end
    
  end

end
