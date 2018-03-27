require_relative '../credit_card'
require_relative '../substitution_cipher'
require_relative '../double_trans_cipher'
require_relative '../sk_cipher'
require 'minitest/autorun'

describe 'Test card info encryption' do
  before do
    @cc = CreditCard.new('4916603231464963',
                         'Mar-30-2020',
                         'Soumya Ray',
                         'Visa')
    @key = 3
  end

  ['SubstitutionCipher::Caesar',
   'SubstitutionCipher::Permutation',
   'DoubleTranspositionCipher',
   'ModernSymmetricCipher'].each do |method|
    describe "Using #{method} " do
      it 'should encrypt/decrypt card information' do
        clazz = method.split('::').inject(Object) { |o, c| o.const_get c }
        key = method == 'ModernSymmetricCipher' ? clazz.generate_new_key : @key
        enc = clazz.encrypt(@cc, key)
        enc.wont_equal @cc.to_s
        enc.wont_be_nil
        dec = clazz.decrypt(enc, key)
        dec.must_equal @cc.to_s
      end
    end
  end
end

describe 'generate ModernSymmetricCipher key' do
  it 'should return a valid key' do
    key = ModernSymmetricCipher.generate_new_key
    key.wont_be_nil
    key.length.must_equal(32)
  end
end
