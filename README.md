Overview
--------

A little class for printing colored messages to STDOUT and js info
to console.log.

##Author##

Jen Oslislo  (mailto:jennifer@stepchangegroup.com)

Setup
-----

In your vendor/mast/env.rb include:
		Sinatra::Base.register Sinatra::MessagesHelper

In your app/views/layout.erb include:
		<%= get_messages %>

Usage
-----

Use it like zis:

		info("Here is an info message", title)
		success("Here is a success message", title)
		err("Here is an error message", title)

Or, if you're lazy, without the title, like zis:

		info "Here is an info message"
		success "Here is a success message"
		err "Here is an error message"
