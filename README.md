# unicode_case_converter

A pure Ruby implementation to upcase and downcase unicode strings. The [unicode](https://github.com/blackwinter/unicode) gem works great but for a [Shoes app](http://shoesrb.com/) I am making I needed a pure Ruby solution to simplify things.

Resources:
* [Character Properties, Case Mappings & Names FAQ](http://unicode.org/faq/casemap_charprop.html)
* [UnicodeData.txt](ftp://ftp.unicode.org/Public/UCD/latest/ucd/UnicodeData.txt)
* [SpecialCasing.txt](ftp://ftp.unicode.org/Public/UCD/latest/ucd/SpecialCasing.txt)

## Installation

Add this line to your application's Gemfile:

**Ruby**  
```
gem install unicode_case_converter
```

**Ruby on Rails**  
Add this line to your application’s Gemfile:  
```ruby 
gem 'unicode_case_converter'
```

## Usage

```ruby
text = "ΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡΣΤΥΦΧΨΩΆΈΉΊΌΎΏΪΫ"
UnicodeCaseConverter::Converter.new(text).downcase
# => "αβγδεζηθικλμνξοπρστυφχψωάέήίόύώϊϋ"

text = "αβγδεζηθικλμνξοπρστυφχψωάέήίόύώϊϋ"
UnicodeCaseConverter::Converter.new(text).upcase
# => "ΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡΣΤΥΦΧΨΩΆΈΉΊΌΎΏΪΫ"
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/unicode_case_converter/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

The MIT License (MIT)

Copyright (c) 2016 Kevin S. Dias

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.