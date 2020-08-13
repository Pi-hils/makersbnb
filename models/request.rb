require_relative './space'

class Request
  attr_reader :id, :space_id, :guest_id, :status, :start_date, :end_date, :host_id, :host_email, :host_name, :space, :response_date

  def initialize(id:, space_id:, guest_id:, accepted:, start_date:, end_date:, response_date:)
    @id = id; @space_id = space_id; @guest_id = guest_id;  @status = get_status(accepted)
    @response_date = response_date ? DateTime.parse(response_date).strftime('%d/%m/%Y %k:%M:%S') : nil
    @start_date = Date.parse(start_date).strftime('%d/%m/%Y'); @end_date = Date.parse(end_date).strftime('%d/%m/%Y')
    get_host_info(space_id)
    get_space_info(space_id)
  end

  def self.add(space_id:, guest_id:, start_date:, end_date:)
    request = DatabaseConnection.query("INSERT INTO requests (space_id, guest_id, start_date, end_date) VALUES('#{space_id}','#{guest_id}','#{start_date}','#{end_date}') RETURNING *")
    request_wrapper(request).first
  end

  # THE HOST VIEWING THEIR OWN REQUESTS || TODO: PORT TO USER CLASS
  def self.get_requests(host_id:)
    requests = DatabaseConnection.query("SELECT requests.id, requests.space_id, requests.guest_id, requests.accepted, requests.start_date, requests.end_date FROM requests INNER JOIN spaces sp ON requests.space_id = (SELECT sp.id WHERE sp.host_id = #{host_id})")
    request_wrapper(requests)
  end

  def get_status(accepted)
    return 'ACCEPTED' if accepted == 't' || accepted == true
    return 'DECLINED' if accepted == 'f' || accepted == false

    'UNCONFIRMED'
  end

  def get_space_info(space_id)
    space_data = DatabaseConnection.query("SELECT * FROM spaces WHERE id = #{space_id}")
    @space = Spaces.space_wrapper(space_data).first
  end


  def get_host_info(space_id)
    host_info = DatabaseConnection.query("SELECT id, name, email FROM users WHERE id =(SELECT host_id FROM spaces WHERE id=#{space_id});")
                                  .first
    @host_id = host_info['id']; @host_name = host_info['name']; @host_email = host_info['email']
  end

  def self.accept(id:)
    accepted_request = DatabaseConnection.query("UPDATE requests SET accepted = true, response_date = '#{Time.now}' WHERE id = #{id} RETURNING *")
    DatabaseConnection.query("UPDATE spaces SET bookable = false WHERE id = (SELECT space_id FROM requests WHERE id = #{id})")
    request_wrapper(accepted_request).first
  end

  def self.decline(id:)
    declined_request = DatabaseConnection.query("UPDATE requests SET accepted = false, response_date = '#{Time.now}' WHERE id = #{id} RETURNING *")
    request_wrapper(declined_request).first
  end

  def self.request_wrapper(query_result)
    query_result.map do |request|
      Request.new(id: request['id'],
                  space_id: request['space_id'],
                  guest_id: request['guest_id'],
                  accepted: request['accepted'],
                  start_date: request['start_date'],
                  end_date: request['end_date'],
                  response_date: request['response_date'])
    end
  end

end
