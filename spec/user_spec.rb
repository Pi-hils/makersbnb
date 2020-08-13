require_relative './spec_helper'

describe User do
  it 'can create create a new user' do
    user = User.add(name: 'Ralph', email: 'me@example.com', password: 'passw0rd')
    expect(user.name).to eq('Ralph')
    expect(user.email).to eq('me@example.com')
  end

  it 'can find and return a user' do
     User.add(name: 'Hilda', email: 'me@example.com', password: 'passw0rd')
     user = User.find(id: 1)
     expect(user.name).to eq('Hilda')
  end

  it '#authentication returns a user' do
    User.add(name: 'Hilda', email: 'me@example.com', password: 'passw0rd') 
    user = User.authenticate(email: 'me@example.com', password: 'passw0rd')
    expect(user.name).to eq 'Hilda'
  end

end
