require 'spec_helper'

describe Viagogo::Client do
  let(:consumer_key) {"some consumer key"}
  let(:consumer_secret) {"some consumer secret"}
  it '#initialize can fetch token and token secret when creation, if not supplied' do
    # c = Viagogo::Client.new(consumer_key, consumer_secret)
    c = Viagogo::Client.new('Xfu2mHZ9wkvy3gs', 'iSsBKQzW2h4TyHkvl5jZJp0ONe3LAq')
    c.token.length.should > 10
    c.token_secret.length.should > 10
  end
  
  it '#valid_token? can verify if token and token secret are valid' do
    c = Viagogo::Client.new(consumer_key, consumer_secret,'aaaaaaa','bbbbbbbb')
    result = c.valid_token?
    result.should be false
    
    c2 = Viagogo::Client.new('Xfu2mHZ9wkvy3gs', 'iSsBKQzW2h4TyHkvl5jZJp0ONe3LAq')
    result = c2.valid_token?
    result.should be true
    
    token = c2.token
    token_secret = c2.token_secret
    c3 = Viagogo::Client.new('Xfu2mHZ9wkvy3gs', 'iSsBKQzW2h4TyHkvl5jZJp0ONe3LAq',token, token_secret)
    result = c3.valid_token?
    result.should be true
  end
  
  it '#search_events can search for events by free text' do
    c = Viagogo::Client.new('Xfu2mHZ9wkvy3gs', 'iSsBKQzW2h4TyHkvl5jZJp0ONe3LAq')
    events = c.search_events 'Manchester United'
    events.should be_a(Array)
  end
  
  it '#search_events should throw error' do
    c = Viagogo::Client.new(consumer_key, consumer_secret,'aaaaaaa','bbbbbbbb')
    expect{c.search_events('Manchester United')}.to raise_error(OpenURI::HTTPError)
  end
end