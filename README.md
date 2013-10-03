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

    client = Viagogo::Client.new('you consumer key', 'your consumer_secret')

Search for events by free text

    client.search_events('free text here')

## Feature
    search events by free text

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


