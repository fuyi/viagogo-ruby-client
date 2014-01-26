[![Build Status](https://travis-ci.org/fuyi/viagogo-ruby-client.png?branch=master)](https://travis-ci.org/fuyi/viagogo-ruby-client)

[![Code Climate](https://codeclimate.com/repos/52e4e75ae30ba041b600c2ce/badges/5f80544b144931e780b9/gpa.png)](https://codeclimate.com/repos/52e4e75ae30ba041b600c2ce/feed)

# Viagogo

This is a ruby client  library for viagogo api

## Installation

Add this line to your application's Gemfile:

    gem 'viagogo'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install viagogo

## Usage

Create a viagogo ruby client by providing consumer_key and consumer_secret

    client = Viagogo::Client.new('you consumer key', 'your consumer secret')

Search for events by free text

    client.search_events('free text here')

To get venue info

    client.get_venue_by_id(venue_id)


Work with Rails3

### 1) create a config file  viagogo.rb under config/initializers folder

       Viagogo.setup do |config|
            config[:consumer_key] = 'you consumer key'
            config[:consumer_secret] = ''your consumer secret''
       end

### 2) create a viagogo client instance when needed

       client = Viagogo::Client.new

## Feature

    search events by free text
    get venue info

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


