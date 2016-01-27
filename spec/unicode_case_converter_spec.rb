require 'spec_helper'
require 'unicode'
require 'benchmark'
require 'stackprof'
require 'active_support/all'

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

  it "capitalizes a string (example)" do
    text = "ΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡΣΤΥΦΧΨΩΆΈΉΊΌΎΏΪΫ".freeze
    ucc = UnicodeCaseConverter::Converter.new(text)
    unicode_result = Unicode.capitalize(text)
    expect(ucc.capitalize).to eq(unicode_result)
  end

  it "capitalizes a string 2" do
    text = "hello world".freeze
    ucc = UnicodeCaseConverter::Converter.new(text)
    unicode_result = Unicode.capitalize(text)
    expect(ucc.capitalize).to eq(unicode_result)
  end

  it "capitalizes a string 3" do
    text = "hello World".freeze
    ucc = UnicodeCaseConverter::Converter.new(text)
    unicode_result = Unicode.capitalize(text)
    expect(ucc.capitalize).to eq(unicode_result)
  end

  # (0..3).each do |first_digit|
  #   [*'0'..'9', *'A'..'F'].sample(16).sort.each do |second_digit|
  #     [*'0'..'9', *'A'..'F'].sample(16).sort.each do |third_digit|
  #       [*'0'..'9', *'A'..'F'].sample(16).sort.each do |forth_digit|
  #         string = "\\u" + first_digit.to_s + second_digit.to_s + third_digit.to_s + forth_digit.to_s
  #         text = string.gsub(/\\u([\da-fA-F]{4})/) {|m| [$1].pack("H*").unpack("n*").pack("U*")}.freeze
  #         it "upcases a string: #{text}" do
  #           unicode_result = Unicode.upcase(text.dup)
  #           ucc = text.dup.mb_chars.upcase.to_s
  #           expect(ucc).to eq(unicode_result)
  #         end
  #       end
  #     end
  #   end
  # end

  # (0..3).each do |first_digit|
  #   [*'0'..'9', *'A'..'F'].sample(16).sort.each do |second_digit|
  #     [*'0'..'9', *'A'..'F'].sample(16).sort.each do |third_digit|
  #       [*'0'..'9', *'A'..'F'].sample(16).sort.each do |forth_digit|
  #         string = "\\u" + first_digit.to_s + second_digit.to_s + third_digit.to_s + forth_digit.to_s
  #         text = string.gsub(/\\u([\da-fA-F]{4})/) {|m| [$1].pack("H*").unpack("n*").pack("U*")}
  #         it "downcases a string: #{text}" do
  #           unicode_result = Unicode.downcase(text)
  #           ucc = text.dup.mb_chars.downcase.to_s
  #           expect(ucc).to eq(unicode_result)
  #         end
  #       end
  #     end
  #   end
  # end

  (0..3).each do |first_digit|
    [*'0'..'9', *'A'..'F'].sample(16).sort.each do |second_digit|
      [*'0'..'9', *'A'..'F'].sample(16).sort.each do |third_digit|
        [*'0'..'9', *'A'..'F'].sample(16).sort.each do |forth_digit|
          string = "\\u" + first_digit.to_s + second_digit.to_s + third_digit.to_s + forth_digit.to_s
          text = string.gsub(/\\u([\da-fA-F]{4})/) {|m| [$1].pack("H*").unpack("n*").pack("U*")}.freeze
          it "upcases a string: #{text}" do
            unicode_result = Unicode.upcase(text.dup)
            ucc = UnicodeCaseConverter::Converter.new(text.dup).upcase
            expect(ucc).to eq(unicode_result)
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
            ucc = UnicodeCaseConverter::Converter.new(text).downcase
            expect(ucc).to eq(unicode_result)
          end
        end
      end
    end
  end

  # it 'is fast?' do
  #   string = "Hello World. My name is Jonas. What is your name? My name is Jonas. There it is! I found it. My name is Jonas E. Smith. Please turn to p. 55. Were Jane and co. at the party? They closed the deal with Pitt, Briggs & Co. at noon. Let's ask Jane and co. They should know. They closed the deal with Pitt, Briggs & Co. It closed yesterday. I can't see Mt. Fuji from here. St. Michael's Church is on 5th st. near the light. That is JFK Jr.'s book. I visited the U.S.A. last year. I live in the E.U. How about you? I live in the U.S. How about you? I work for the U.S. Government in Virginia. I have lived in the U.S. for 20 years. She has $100.00 in her bag. She has $100.00. It is in her bag. He teaches science (He previously worked for 5 years as an engineer.) at the local University. Her email is Jane.Doe@example.com. I sent her an email. The site is: https://www.example.50.com/new-site/awesome_content.html. Please check it out. She turned to him, 'This is great.' she said. She turned to him, \"This is great.\" she said. She turned to him, \"This is great.\" She held the book out to show him. Hello!! Long time no see. Hello?? Who is there? Hello!? Is that you? Hello?! Is that you? 1.) The first item 2.) The second item 1.) The first item. 2.) The second item. 1) The first item 2) The second item 1) The first item. 2) The second item. 1. The first item 2. The second item 1. The first item. 2. The second item. • 9. The first item • 10. The second item ⁃9. The first item ⁃10. The second item a. The first item b. The second item c. The third list item This is a sentence\ncut off in the middle because pdf. It was a cold \nnight in the city. features\ncontact manager\nevents, activities\n You can find it at N°. 1026.253.553. That is where the treasure is. She works at Yahoo! in the accounting department. We make a good team, you and I. Did you see Albert I. Jones yesterday? Thoreau argues that by simplifying one’s life, “the laws of the universe will appear less complex. . . .” \"Bohr [...] used the analogy of parallel stairways [...]\" (Smith 55). If words are left off at the end of a sentence, and that is all that is omitted, indicate the omission with ellipsis marks (preceded and followed by a space) and then indicate the end of the sentence with a period . . . . Next sentence. I never meant that.... She left the store. I wasn’t really ... well, what I mean...see . . . what I'm saying, the thing is . . . I didn’t mean it. One further habit which was somewhat weakened . . . was that of combining words into self-interpreting compounds. . . . The practice was not abandoned. . . ."
  #   benchmark do
  #     10.times do
  #       data = StackProf.run(mode: :cpu, interval: 1000) do
  #         UnicodeCaseConverter::Converter.new(string * 100).downcase
  #       end
  #       puts StackProf::Report.new(data).print_text
  #     end
  #   end
  # end

#   it 'is fast' do
#     puts 'activesupport'
#     string = "Hello World. My name is Jonas. What is your name? My name is Jonas. There it is! I found it. My name is Jonas E. Smith. Please turn to p. 55. Were Jane and co. at the party? They closed the deal with Pitt, Briggs & Co. at noon. Let's ask Jane and co. They should know. They closed the deal with Pitt, Briggs & Co. It closed yesterday. I can see Mt. Fuji from here. St. Michael's Church is on 5th st. near the light. That is JFK Jr.'s book. I visited the U.S.A. last year. I live in the E.U. How about you? I live in the U.S. How about you? I work for the U.S. Government in Virginia. I have lived in the U.S. for 20 years. She has $100.00 in her bag. She has $100.00. It is in her bag. He teaches science (He previously worked for 5 years as an engineer.) at the local University. Her email is Jane.Doe@example.com. I sent her an email. The site is: https://www.example.50.com/new-site/awesome_content.html. Please check it out. She turned to him, 'This is great.' she said. She turned to him, \"This is great.\" she said. She turned to him, \"This is great.\" She held the book out to show him. Hello!! Long time no see. Hello?? Who is there? Hello!? Is that you? Hello?! Is that you? 1.) The first item 2.) The second item 1.) The first item. 2.) The second item. 1) The first item 2) The second item 1) The first item. 2) The second item. 1. The first item 2. The second item 1. The first item. 2. The second item. • 9. The first item • 10. The second item ⁃9. The first item ⁃10. The second item a. The first item b. The second item c. The third list item This is a sentence\ncut off in the middle because pdf. It was a cold \nnight in the city. features\ncontact manager\nevents, activities\n You can find it at N°. 1026.253.553. That is where the treasure is. She works at Yahoo! in the accounting department. We make a good team, you and I. Did you see Albert I. Jones yesterday? Thoreau argues that by simplifying one’s life, “the laws of the universe will appear less complex. . . .” \"Bohr [...] used the analogy of parallel stairways [...]\" (Smith 55). If words are left off at the end of a sentence, and that is all that is omitted, indicate the omission with ellipsis marks (preceded and followed by a space) and then indicate the end of the sentence with a period . . . . Next sentence. I never meant that.... She left the store. I wasn’t really ... well, what I mean...see . . . what I'm saying, the thing is . . . I didn’t mean it. One further habit which was somewhat weakened . . . was that of combining words into self-interpreting compounds. . . . The practice was not abandoned. . . .ΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡΣΤΥΦΧΨΩΆΈΉΊΌΎΏΪΫαβγδεζηθικλμνξοπρστυφχψωάέήίόύώϊϋ" * 10000
#     benchmark do
#       5.times do
#         string.dup.mb_chars.downcase.to_s
#       end
#       5.times do
#         string.dup.mb_chars.upcase.to_s
#       end
#     end
#   end

  it 'is fast' do
    puts 'this gem'
    string = "Hello World. My name is Jonas. What is your name? My name is Jonas. There it is! I found it. My name is Jonas E. Smith. Please turn to p. 55. Were Jane and co. at the party? They closed the deal with Pitt, Briggs & Co. at noon. Let's ask Jane and co. They should know. They closed the deal with Pitt, Briggs & Co. It closed yesterday. I can see Mt. Fuji from here. St. Michael's Church is on 5th st. near the light. That is JFK Jr.'s book. I visited the U.S.A. last year. I live in the E.U. How about you? I live in the U.S. How about you? I work for the U.S. Government in Virginia. I have lived in the U.S. for 20 years. She has $100.00 in her bag. She has $100.00. It is in her bag. He teaches science (He previously worked for 5 years as an engineer.) at the local University. Her email is Jane.Doe@example.com. I sent her an email. The site is: https://www.example.50.com/new-site/awesome_content.html. Please check it out. She turned to him, 'This is great.' she said. She turned to him, \"This is great.\" she said. She turned to him, \"This is great.\" She held the book out to show him. Hello!! Long time no see. Hello?? Who is there? Hello!? Is that you? Hello?! Is that you? 1.) The first item 2.) The second item 1.) The first item. 2.) The second item. 1) The first item 2) The second item 1) The first item. 2) The second item. 1. The first item 2. The second item 1. The first item. 2. The second item. • 9. The first item • 10. The second item ⁃9. The first item ⁃10. The second item a. The first item b. The second item c. The third list item This is a sentence\ncut off in the middle because pdf. It was a cold \nnight in the city. features\ncontact manager\nevents, activities\n You can find it at N°. 1026.253.553. That is where the treasure is. She works at Yahoo! in the accounting department. We make a good team, you and I. Did you see Albert I. Jones yesterday? Thoreau argues that by simplifying one’s life, “the laws of the universe will appear less complex. . . .” \"Bohr [...] used the analogy of parallel stairways [...]\" (Smith 55). If words are left off at the end of a sentence, and that is all that is omitted, indicate the omission with ellipsis marks (preceded and followed by a space) and then indicate the end of the sentence with a period . . . . Next sentence. I never meant that.... She left the store. I wasn’t really ... well, what I mean...see . . . what I'm saying, the thing is . . . I didn’t mean it. One further habit which was somewhat weakened . . . was that of combining words into self-interpreting compounds. . . . The practice was not abandoned. . . .ΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡΣΤΥΦΧΨΩΆΈΉΊΌΎΏΪΫαβγδεζηθικλμνξοπρστυφχψωάέήίόύώϊϋ" * 10000
    benchmark do
      5.times do
        UnicodeCaseConverter::Converter.new(string).downcase
      end
      5.times do
        UnicodeCaseConverter::Converter.new(string).upcase
      end
      5.times do
        UnicodeCaseConverter::Converter.new(string).capitalize
      end
    end
  end

  it 'is fast' do
    puts 'unicode'
    string = "Hello World. My name is Jonas. What is your name? My name is Jonas. There it is! I found it. My name is Jonas E. Smith. Please turn to p. 55. Were Jane and co. at the party? They closed the deal with Pitt, Briggs & Co. at noon. Let's ask Jane and co. They should know. They closed the deal with Pitt, Briggs & Co. It closed yesterday. I can see Mt. Fuji from here. St. Michael's Church is on 5th st. near the light. That is JFK Jr.'s book. I visited the U.S.A. last year. I live in the E.U. How about you? I live in the U.S. How about you? I work for the U.S. Government in Virginia. I have lived in the U.S. for 20 years. She has $100.00 in her bag. She has $100.00. It is in her bag. He teaches science (He previously worked for 5 years as an engineer.) at the local University. Her email is Jane.Doe@example.com. I sent her an email. The site is: https://www.example.50.com/new-site/awesome_content.html. Please check it out. She turned to him, 'This is great.' she said. She turned to him, \"This is great.\" she said. She turned to him, \"This is great.\" She held the book out to show him. Hello!! Long time no see. Hello?? Who is there? Hello!? Is that you? Hello?! Is that you? 1.) The first item 2.) The second item 1.) The first item. 2.) The second item. 1) The first item 2) The second item 1) The first item. 2) The second item. 1. The first item 2. The second item 1. The first item. 2. The second item. • 9. The first item • 10. The second item ⁃9. The first item ⁃10. The second item a. The first item b. The second item c. The third list item This is a sentence\ncut off in the middle because pdf. It was a cold \nnight in the city. features\ncontact manager\nevents, activities\n You can find it at N°. 1026.253.553. That is where the treasure is. She works at Yahoo! in the accounting department. We make a good team, you and I. Did you see Albert I. Jones yesterday? Thoreau argues that by simplifying one’s life, “the laws of the universe will appear less complex. . . .” \"Bohr [...] used the analogy of parallel stairways [...]\" (Smith 55). If words are left off at the end of a sentence, and that is all that is omitted, indicate the omission with ellipsis marks (preceded and followed by a space) and then indicate the end of the sentence with a period . . . . Next sentence. I never meant that.... She left the store. I wasn’t really ... well, what I mean...see . . . what I'm saying, the thing is . . . I didn’t mean it. One further habit which was somewhat weakened . . . was that of combining words into self-interpreting compounds. . . . The practice was not abandoned. . . .ΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡΣΤΥΦΧΨΩΆΈΉΊΌΎΏΪΫαβγδεζηθικλμνξοπρστυφχψωάέήίόύώϊϋ" * 10000
    benchmark do
      5.times do
        Unicode::downcase(string)
      end
      5.times do
        Unicode::upcase(string)
      end
      5.times do
        Unicode::capitalize(string)
      end
    end
  end
end

def benchmark(&block)
  block.call
  time = Benchmark.realtime { block.call }
  puts "RUNTIME: #{time}"
end