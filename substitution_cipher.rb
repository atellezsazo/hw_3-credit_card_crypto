
# Implementation of Substitution Cipher
module SubstitutionCipher
  # Caesar Cipher
  module Caesar
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using caesar cipher
      document.to_s.chars.collect { |e| (e.ord + key).chr }.join
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using caesar cipher
      document.to_s.chars.collect { |e| (e.ord - key).chr }.join
    end
  end

  # Permutation Cipher
  module Permutation
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using a permutation cipher
      document = document.to_s.chars
      rnd = (0..127).to_a.shuffle(random: Random.new(key))
      document.collect { |e| rnd.at(e.ord).chr }.join
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using a permutation cipher
      document = document.to_s.chars
      rnd = (0..127).to_a.shuffle(random: Random.new(key))
      document.collect { |e| rnd.index(e.ord).chr }.join
    end
  end
end
