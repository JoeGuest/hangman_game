class SlackResultError < StandardError; end

class SlackResult
  def initialize(payload, flag = nil)
    @payload = payload

    unless flag == :skip_authentication
      raise_error_if_not_valid
    end
  end

  def command
    command? ? text.sub(";", "") : false
  end

  def guess
    !command? ? text : false
  end

  private

  def command?
    text.include? ";"
  end

  def raise_error_if_not_valid
    if !token
      raise SlackResultError, "token is required"
    elsif !authenticated?
      raise SlackResultError, "token is invalid"
    end
  end

  def authenticated?
    # hardcoded tokens are very bad!! Don't do this.
    token == "ajflXZhEaHFDwWa0oucaZ0L7"
  end

  def method_missing(name, *args, &block)
    @payload.fetch(name.to_s, false)
  end
end