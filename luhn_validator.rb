# Validate Credit cards
module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)
    check_number = nums_a.pop
    check_sum = self.check_sum(nums_a)
    if check_number.zero?
      (check_sum % 10).zero?
    else
      (10 - check_sum % 10) == check_number
    end
  end

  def check_sum(nums_a)
    nums_a.reverse.each_slice(2).flat_map do |a, b|
      [(a * 2).divmod(10), b || 0]
    end.flatten.inject(:+)
  end
end
