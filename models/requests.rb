class Requests
  attr_reader :accepted

  def initialize
    @accepted = false
  end

  def self.add

  end

  def accept
    @accepted = true
    # Sends acceptance message to user
    # Changes space bookable status to false
  end

  def decline
    @accepted = false
    # Sends rejection message to user
  end

end
