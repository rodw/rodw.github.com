---
file_type: snippet
context:
  template: snippet.dust
  active_tab: snippets
---
===============================================================================
---
tags: [ruby,dev]
slug: ruby-hash-sort
---
# Sorting a Ruby hash by key or value.

## by key

```ruby
h.sort
```

## by value

```ruby
h.sort_by {|k,v| v}
```

Note both forms return an array of key-value pairs (i.e., an array of arrays).

===============================================================================
---
tags: [ruby,dev]
slug: ruby-stack-queue
---
# Using Ruby arrays as stacks and queues.

 * `array.push` appends an element to the array.
 * `array.pop` removes (and returns) the last element in the array.
 * Hence `array.last` (and `array[-1]`) operates like `array.peek` would if it existed--it returns (but does not remove) the item on the top of the stack.
 * `array.shift` removes (and returns) the first element in the array.
 * Hence `array.shift` "pops" an element in a queue-like way--first in, first out.  `array.first` (and `array[1]`) allow one to "peek" at this element.

```irb
> a = [ 1, 2, 3 ]         # => [1, 2, 3]
> a.push 4                # => [1, 2, 3, 4]
> a.pop                   # => 4
> a                       # => [1, 2, 3]
> a.last                  # => 3
> a                       # => [1, 2, 3]
> a.shift                 # => 1
> a                       # => [2, 3]
> a.first                 # => 2
```

===============================================================================
---
tags: [ruby,dev,cli]
slug: ruby-argf-basics
---
# Reading from input files or STDIN in Ruby using ARGF.

`ARGF` makes it easy for a Ruby script to read from STDIN, a file specified on the command-line argument or multiple files specified on the command line, all through the same interface.

Recall that `ARGV` array contains the arguments passed to your Ruby script on the command line.

`ARGF` assumes that any elements that remain in `ARGV` represent files.  Methods like `ARGF.each` (accepting a block) and `ARGF.readlines` (returning an array) operate on the concatenation of all files found in `ARGV`.  If `ARGV` is empty, then `ARGF` operates on STDIN instead.

For example, a `cat`-like program could be implemented in Ruby as:

```ruby
ARGF.each_line { |line| puts line }
```

When working with `optparse`, use the `parse!` method to strip recognized "flag" parameters from `ARGV`, leaving only the files you want to operate so that `ARGF` works just like you want it to. For example:

```ruby
require 'optparse'

options = { }
opt_parser = OptionParser.new do |opt|
  opt.banner = "Usage: #{$0} [OPTIONS]"
  opt.separator  ""
  opt.separator  "OPTIONS"

  opt.on("-h","--heading HEADING","a heading to display.") do |heading|
    options[:heading] = heading
  end

  opt.on("-v","--verbose","be more chatty") do
    options[:verbose] = true
  end
end
opt_parser.parse!

puts options[:heading] unless options[:heading].nil?
ARGF.each_line { |line| puts line }
```

===============================================================================
---
tags: [ruby,dev]
slug: split-ruby-array-in-half
---
# Split a Ruby array into two halves.

To split a Ruby array into two equally-sized (+/-1) parts:

```ruby
left,right = a.each_slice( (a.size/2.0).round ).to_a
```

For example:

```irb
a = [1,2,3,4,5]                         # => [1, 2, 3, 4, 5]
a.each_slice( (a.size/2.0).round ).to_a # => [[1, 2, 3], [4, 5]]
```

===============================================================================
---
tags: [ruby,dev]
slug: split-ruby-array-equally
---
# Split a Ruby array into N equally-sized parts.

To split a Ruby array into **n** equally-sized parts:

```ruby
a.each_slice( (a.size/n.to_f).round ).to_a
```

For example:

```irb
a = [1,2,3,4,5]; n = 3                     # => 3
a.each_slice( (a.size/n.to_f).round ).to_a # => [[1, 2], [3, 4], [5]]
```
