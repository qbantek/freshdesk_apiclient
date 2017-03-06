# FreshdeskApiclient
====

[![Gem Version](https://badge.fury.io/rb/freshdesk_apiclient.svg)](https://badge.fury.io/rb/freshdesk_apiclient)
[![Build Status](https://travis-ci.org/qbantek/freshdesk_apiclient.svg?branch=master)](https://travis-ci.org/qbantek/freshdesk_apiclient)
[![Code Climate](https://codeclimate.com/github/qbantek/freshdesk_apiclient/badges/gpa.svg)](https://codeclimate.com/github/qbantek/freshdesk_apiclient)
[![Test Coverage](https://codeclimate.com/github/qbantek/freshdesk_apiclient/badges/coverage.svg)](https://codeclimate.com/github/qbantek/freshdesk_apiclient/coverage)
[![Dependency Status](https://gemnasium.com/badges/github.com/qbantek/freshdesk_apiclient.svg)](https://gemnasium.com/github.com/qbantek/freshdesk_apiclient)
[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://freshdesk_apiclient.mit-license.org)

A ruby client for [freshdesk](https://developer.freshdesk.com/api/) API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'freshdesk_apiclient'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install freshdesk_apiclient
    
#### Setup your authentication credentials    
    
You'll need to create your account and get the credentials at [freshdesk](https://freshdesk.com/). 
See [Authentication](https://developers.freshdesk.com/api/#authentication) for more information.

Username and password:

```ruby
# config/intializers/freshdesk_apiclient.rb
FreshdeskApiclient.username_or_api_key = ENV["FRESHDESK_USERNAME"]
FreshdeskApiclient.password = ENV["FRESHDESK_PASWWORD"]
```

Or API key:

```ruby
# config/intializers/freshdesk_apiclient.rb
FreshdeskApiclient.username_or_api_key = ENV["FRESHDESK_API_KEY"]
```
(If you use the API key, there is no need for a password.)    

## Usage

Currently, only the following requests are supported:

#### Tickets

- Create a ticket

```ruby
client = FreshdeskApiclient::Client.new
client.tickets.create payload   # payload is a hash, 
```
See [Create a ticket](https://developers.freshdesk.com/api/#create_ticket) for allowed attributes on the payload.

- List all tickets

```ruby
client = FreshdeskApiclient::Client.new
client.tickets.list
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bundle exec spec` to run the tests. 
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. 
To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, 
which will create a git tag for the version, push git commits and tags, 
and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/qbantek/freshdesk_apiclient. 
This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere 
to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

