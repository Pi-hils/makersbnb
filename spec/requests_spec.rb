require_relative './spec_helper'
require_relative '../models/requests.rb'

describe 'requests' do
  it 'creates a request that is not yet accepted' do
    request = Requests.new
    expect(request.accepted).to eq false
  end

  it 'accepts a request' do
    request = Requests.new
    request.accept
    expect(request.accepted).to eq true
  end

  it 'declines a request' do
    request = Requests.new
    request.decline
    expect(request.accepted).to eq false
  end
  
end
