require 'spec_helper'
require 'unicode'

describe UnicodeCaseConverter do
  it 'has a version number' do
    expect(UnicodeCaseConverter::VERSION).not_to be nil
  end

  describe '#initialize' do
    it 'raises an error if the text argument is nil' do
      -> { expect(UnicodeCaseConverter::Converter.new(nil).upcase).to raise_error }
    end

    it 'raises an error if the text is not a String' do
      -> { expect(UnicodeCaseConverter::Converter.new(5).downcase).to raise_error }
    end
  end

  it "upcases a string (example)" do
    ucc = UnicodeCaseConverter::Converter.new("αβγδεζηθικλμνξοπρστυφχψωάέήίόύώϊϋ")
    expect(ucc.upcase).to eq("ΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡΣΤΥΦΧΨΩΆΈΉΊΌΎΏΪΫ")
  end

  it "downcases a string (example)" do
    ucc = UnicodeCaseConverter::Converter.new("ΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡΣΤΥΦΧΨΩΆΈΉΊΌΎΏΪΫ")
    expect(ucc.downcase).to eq("αβγδεζηθικλμνξοπρστυφχψωάέήίόύώϊϋ")
  end

  (0..3).each do |first_digit|
    [*'0'..'9', *'A'..'F'].sample(16).sort.each do |second_digit|
      [*'0'..'9', *'A'..'F'].sample(16).sort.each do |third_digit|
        [*'0'..'9', *'A'..'F'].sample(16).sort.each do |forth_digit|
          string = "\\u" + first_digit.to_s + second_digit.to_s + third_digit.to_s + forth_digit.to_s
          text = string.gsub(/\\u([\da-fA-F]{4})/) {|m| [$1].pack("H*").unpack("n*").pack("U*")}.freeze
          it "upcases a string: #{text}" do
            unicode_result = Unicode.upcase(text.dup)
            ucc = UnicodeCaseConverter::Converter.new(text.dup)
            expect(ucc.upcase).to eq(unicode_result)
          end
        end
      end
    end
  end

  (0..3).each do |first_digit|
    [*'0'..'9', *'A'..'F'].sample(16).sort.each do |second_digit|
      [*'0'..'9', *'A'..'F'].sample(16).sort.each do |third_digit|
        [*'0'..'9', *'A'..'F'].sample(16).sort.each do |forth_digit|
          string = "\\u" + first_digit.to_s + second_digit.to_s + third_digit.to_s + forth_digit.to_s
          text = string.gsub(/\\u([\da-fA-F]{4})/) {|m| [$1].pack("H*").unpack("n*").pack("U*")}
          it "downcases a string: #{text}" do
            unicode_result = Unicode.downcase(text)
            ucc = UnicodeCaseConverter::Converter.new(text)
            expect(ucc.downcase).to eq(unicode_result)
          end
        end
      end
    end
  end
end
