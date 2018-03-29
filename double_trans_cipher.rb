# Double Transition Cipher
module DoubleTranspositionCipher
  # Encrypts document using key
  # Arguments:
  #   document: String
  #   key: Fixnum (integer)
  # Returns: String
  def self.encrypt(document, key)
    row_col_size, matrix = create_matrix(document.to_s)
    sort_rows = matrix.shuffle(random: Random.new(key))
    sort_columns = sort_rows.map do |s|
      (row_col_size - s.length).times { s << '♢' }
      s.shuffle(random: Random.new(key))
    end
    sort_columns.join.to_s
  end

  # Decrypts document using key
  # Arguments:
  #   document: String
  #   key: Fixnum (integer)
  # Returns: String
  def self.decrypt(ciphertext, key)
    _row_col_size, matrix = create_matrix(ciphertext)
    sort_rows = matrix.unshuffle(random: Random.new(key))
    sort_columns = sort_rows.map do |s|
      s.unshuffle(random: Random.new(key))
    end
    sort_columns.map(&:join).join('').delete('♢')
  end

  def self.create_matrix(text)
    row_col_size = Math.sqrt(text.size).ceil
    matrix = text.chars.each_slice(row_col_size).to_a
    [row_col_size, matrix]
  end
end

# Adding unshuffle method to Array class
class Array
  # Shuffle reverse
  def unshuffle(random:)
    transformed_order = (0...length).to_a.shuffle!(random: random)
    sort_by.with_index { |_, i| transformed_order[i] }
  end
end
