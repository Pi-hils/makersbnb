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

  it '#accept' do
    Request.add(space_id: '4', guest_id: '1', start_date: '13/08/2020', end_date: '14/08/2020')
    request = Request.accept(id: 1)
    expect(request.space_id).to eq '4'
    expect(request.status).to eq 'ACCEPTED'
    expect(request.space.bookable).to eq false
  end

  it '#decline' do
    Request.add(space_id: '4', guest_id: '1', start_date: '13/08/2020', end_date: '14/08/2020')
    request = Request.decline(id: 1)
    expect(request.space_id).to eq '4'
    expect(request.status).to eq 'DECLINED'
  end

  it '#get_stays' do
    Request.add(space_id: '4', guest_id: '1', start_date: '13/08/2020', end_date: '14/08/2020')
    stays = Request.get_stays(guest_id: 1)
    expect(stays.first.space.id).to eq '4'
    Request.decline(id: 1)
    stays = Request.get_stays(guest_id: 1)
    expect(stays.first.status).to eq 'DECLINED'
  end

  it '#validate_dates' do
    Spaces.add(name: "Amazing Shatou", price: 500, description: "Spacious master", availability_start: "12/08/2020", availability_end: "18/08/2020", host_id: 1)
    request = Request.add(space_id: '6', guest_id: '1', start_date: '11/08/2020', end_date: '14/08/2020')
    expect(Request.validate_dates(space_id: 6, start_date: '16/08/2020', end_date: '18/08/2020')).to eq true
    expect(request).to eq nil
    request = Request.add(space_id: '6', guest_id: '1', start_date: '12/08/2020', end_date: '14/08/2020')
    expect(request).not_to eq nil
  end

end
