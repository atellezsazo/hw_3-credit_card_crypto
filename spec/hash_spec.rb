require_relative '../credit_card'
require 'minitest/autorun'

# Feel free to replace the contents of cards with data from your own yaml file
card_details = [
  { num: '4916603231464963',
    exp: 'Mar-30-2020',
    name: 'Soumya Ray',
    net: 'Visa' },
  { num: '6011580789725897',
    exp: 'Sep-30-2020',
    name: 'Nick Danks',
    net: 'Visa' },
  { num: '5423661657234057',
    exp: 'Feb-30-2020',
    name: 'Lee Chen',
    net: 'Mastercard' }
]

cards = card_details.map do |c|
  CreditCard.new(c[:num], c[:exp], c[:name], c[:net])
end

describe 'Test hashing requirements' do
  describe 'Test regular hashing' do
    describe 'Check hashes are consistently produced' do
      it 'it should check if the hash is the same every time for a card' do
        cards.map do |cc|
          hash1 = cc.hash
          hash2 = cc.hash
          hash1.wont_be_nil
          hash2.wont_be_nil
          hash1.must_equal hash2
        end
      end
    end

    describe 'Check for unique hashes' do
      it 'it should be unique for every card' do
        cards.map(&:hash).uniq.length.must_equal(0)
      end
    end
  end
end

describe 'Test cryptographic hashing' do
  describe 'Check hashes are consistently produced' do
    it 'it should check if hashes are produced consostently' do
      cards.map do |cc|
        hash1 = cc.hash_secure
        hash2 = cc.hash_secure
        hash1.must_equal hash2
      end
    end
  end

  describe 'Check for unique hashes' do
    it 'it should be unique for every card' do
      cards.map(&:hash_secure).uniq.length.must_equal(0)
    end
  end

  describe 'Check regular hash not same as cryptographic hash' do
    it 'it should check if those two hashes are not equal' do
      cards.map do |cc|
        hash1 = cc.hash
        hash2 = cc.hash_secure
        hash1.wont_be_same_as hash2
      end
    end
  end
end
