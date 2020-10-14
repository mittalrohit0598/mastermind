# frozen_string_literal: true

# module ValidCode
module ValidCode
  def valid_code?(code)
    code.split('').all? { |digit| digit.to_i <= 5 && digit.to_i >= 1 } && code.length == 4
  end
end
