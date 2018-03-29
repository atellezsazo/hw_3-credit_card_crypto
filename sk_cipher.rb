require 'rbnacl'
require 'base64'

# Modern Symmetric Cipher
module ModernSymmetricCipher
  def self.generate_new_key
    key_bytes = RbNaCl::SecretBox.key_bytes
    RbNaCl::Random.random_bytes(key_bytes)
  end

  def self.encrypt(document, key)
    box = RbNaCl::SimpleBox.from_secret_key(key)
    ciphertext = box.encrypt(document.to_s)
    Base64.strict_encode64(ciphertext)
  end

  def self.decrypt(encrypted_cc, key)
    encrypted_cc = Base64.strict_decode64(encrypted_cc)
    box = RbNaCl::SimpleBox.from_secret_key(key)
    box.decrypt(encrypted_cc)
  rescue StandardError? => e
    puts e.message
    puts e.backtrace.inspect
  end
end
