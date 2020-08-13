require_relative './spec_helper'

describe User do
  it 'can create create a new user' do
    user = User.add(name: 'Ralph', email: 'me@example.com', password: 'passw0rd')
    expect(user.name).to eq('Ralph')
    expect(user.email).to eq('me@example.com')
  end

  it 'can find and return a user' do
    user = User.add(name: 'Ralph', email: 'me@example.com', password: 'passw0rd')
    expect(user.find('Ralph')).to eq(name: 'Ralph', email: 'me@example.com')
  end
end
