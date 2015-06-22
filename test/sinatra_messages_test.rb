require File.join(File.expand_path(File.join(File.dirname(__FILE__))), '..', 'lib', 'sinatra', 'terminal_colors')
require File.join(File.expand_path(File.join(File.dirname(__FILE__))), '..', 'lib', 'sinatra', 'messages_helper')
require File.join(File.expand_path(File.join(File.dirname(__FILE__))), '..', 'lib', 'sinatra', 'messages')

require 'test/unit'
require 'rubygems'
require 'original_gangster'

class SinatraMessagesTest < Test::Unit::TestCase
  
  def test_main_methods
    Sinatra::Messages.success "Love"
    Sinatra::Messages.info "Indifference"
    Sinatra::Messages.error "Hate"

    assert true
  end


  def test_suppress
    Sinatra::Messages.info "This should show"
    Sinatra::Messages.suppress = true
    Sinatra::Messages.info "This should be suppressed"
    assert_equal((Sinatra::Messages.info "This should be suppressed"), "")
    Sinatra::Messages.suppress = false
    Sinatra::Messages.success "This should show again"
  end
  
  def test_clear
    Sinatra::Messages.info "Messages has #{Sinatra::Messages.messages}"
    Sinatra::Messages.clear
    assert_equal(Sinatra::Messages.messages, "")
  end


  def test_with_title
    Sinatra::Messages.info("This message has a title", "title")
  end
  
  def test_stack_trace
    Sinatra::Messages.trace = true
    test_main_methods
    Sinatra::Messages.trace = false
  end
  
end

class SinatraMessagesHelperTest < Test::Unit::TestCase
  
  include Sinatra::MessagesHelper
  
  def test_main_methods
    success "(Helper) Love"
    info "(Helper) Indifference"
    error "(Helper) Hate"

    assert true
  end

  def test_err
    err "This should show an error message"
  end
  
  def test_get_messages
    info "Test!"
    puts get_messages
  end
  
  def test_pretty
    params = {:title => "Sula", :author => "Toni Morrison", :url => "http://www.amazon.com/Sula-Toni-Morrison/dp/1400033438/ref=sr_1_1?ie=UTF8&qid=1287829692&sr=8-1"}
    session = {:uid => 12345678}
    og = OriginalGangster::Session.new('fjdkslfsjdkl')
    
    pretty params
    pretty session
    pretty og
  end
  
end