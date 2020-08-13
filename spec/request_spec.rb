require_relative './spec_helper'

describe Request do
  
  before 'generate a master' do
    generate_example_master
    generate_example_user
    generate_example_space
    generate_more_spaces
  end
  
  it '#add creates a new request' do
    request = Request.add(space_id: '1', guest_id: '2', start_date: '13/08/2020', end_date: '14/08/2020')
    expect(request.guest_id).to eq '2'
    expect(request.host_id).to eq '1'
    expect(request.host_name).to eq 'master'
    expect(request.status).to eq 'UNCONFIRMED'
  end

  it '#get_requests : Host viewing their own requests' do
    Request.add(space_id: '4', guest_id: '1', start_date: '13/08/2020', end_date: '14/08/2020')
    Request.add(space_id: '5', guest_id: '1', start_date: '13/08/2020', end_date: '14/08/2020')
    requests = Request.get_requests(host_id: 2)
    expect(requests.size).to eq 2
    expect(requests.first.host_name).to eq 'test'
    expect(requests.first.space.price).to eq '550.00'
  end

end