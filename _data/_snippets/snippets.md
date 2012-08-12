######################################################################
tags: [ruby]
title: Sorting a Ruby hash by key or value.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

## by key

{% highlight ruby %}
h.sort
{% endhighlight %}

## by value

{% highlight ruby %}
h.sort_by {|k,v| v}
{% endhighlight %}

Note both forms return an array of key-value pairs (i.e., an array of arrays).

######################################################################
tags: [ruby]
title: Using Ruby arrays as stacks and queues.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

 * `array.push` appends an element to the array.  
 * `array.pop` removes (and returns) the last element in the array.
 * Hence `array.last` (and `array[-1]`) operates like `array.peek` would if it existed--it returns (but does not remove) the item on the top of the stack.
 * `array.shift` removes (and returns) the first element in the array.  
 * Hence `array.shift` "pops" an element in a queue-like way--first in, first out.  `array.first` (and `array[1]`) allow one to "peek" at this element.

{% highlight ruby %}
> a = [ 1, 2, 3 ]         # => [1, 2, 3]
> a.push 4                # => [1, 2, 3, 4]
> a.pop                   # => 4
> a                       # => [1, 2, 3]
> a.last                  # => 3
> a                       # => [1, 2, 3]
> a.shift                 # => 1
> a                       # => [2, 3]
> a.first                 # => 2
{% endhighlight %}

######################################################################
tags: [ruby,cli]
title: Reading from input files or STDIN in Ruby using ARGF.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

`ARGF` makes it easy for a Ruby script to read from STDIN, a file specified on the command-line argument or multiple files specified on the command line, all through the same interface.

Recall that `ARGV` array contains the arguments passed to your Ruby script on the command line.

`ARGF` assumes that any elements that remain in `ARGV` represent files.  Methods like `ARGF.each` (accepting a block) and `ARGF.readlines` (returning an array) operate on the concatentation of all files found in `ARGV`.  If `ARGV` is empty, then `ARGF` operates on STDIN instead.

For example, a `cat`-like program could be implemented in Ruby as:

{% highlight ruby %}
ARGF.each_line { |line| puts line }
{% endhighlight %}

When working with `optparse`, use the `parse!` method to strip recognized "flag" parameters from `ARGV`, leaving only the files you want to operate so that `ARGF` works just like you want it to. For example:

{% highlight ruby %}
require 'optparse'

options = { }
opt_parser = OptionParser.new do |opt|
  opt.banner = "Usage: #{$0} [OPTIONS]"
  opt.separator  ""
  opt.separator  "OPTIONS"

  opt.on("-h","--heading HEADING","a heading to display.") do |pattern|
    options[:tagpattern] = pattern
  end

  opt.on("-v","--verbose","be more chatty") do |pattern|
    options[:verbose] = true
  end
end
opt_parser.parse!

puts options[:heading] unless options[:heading].nil?
ARGF.each_line { |line| puts line }
{% endhighlight %}

######################################################################
tags: [linux,text-processing,sed,cli]
title: Strip characters from a string or file
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

{% highlight bash %}
$ echo "A1B2C3" | sed 's/[A-Z]//g'
123
{% endhighlight %}

######################################################################
tags: [linux,text-processing,awk,cli]
title: Strip characters from a field in awk
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

E.g., the following command strips alpha characters from the second (tab delimited) field.

{% highlight bash %}
awk -F"\t" '{gsub(/[A-Za-z]/,"",$2); print $2 }'
{% endhighlight %}

######################################################################
tags: [linux,text-processing,awk,cli]
title: Some `awk` basics
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Extract tab delimited fields from a file:

{% highlight bash %}
awk -F"\t" '{print "field one=" $1 "; field two=" $2 }' file
{% endhighlight %}


######################################################################
tags: [linux,text-processing,sed,cli]
title: Skip the first N lines in file
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

## using `tail`

To skip the first line of a file (and start piping data at the second line):

{% highlight bash %}
tail -n +2 filename
{% endhighlight %}

More generally:

{% highlight bash %}
tail -n +M filename
{% endhighlight %}

where **`M`** is the number of the first line you want to see (i.e., the number of lines to skip plus one).

## using `sed`

To skip the first line of a file (and start piping data at the second line):

{% highlight bash %}
sed 1d filename
{% endhighlight %}

More generally:

{% highlight bash %}
tail A,Bd filename
{% endhighlight %}

when you want to exclude lines **`A`** through **`B`** from the output.

######################################################################
tags: [linux]
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
To view a list of available fonts, use `fc-list`.

######################################################################
tags: [ruby]
title: Split a Ruby array into two halves.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
To split a Ruby array in two two equally-sized (+/-1) parts:
{% highlight ruby %}
left,right = a.each_slice( (a.size/2.0).round ).to_a
{% endhighlight %}

For example:

{% highlight ruby %}
a = [1,2,3,4,5]
=> [1, 2, 3, 4, 5]
a.each_slice( (a.size/2.0).round ).to_a
=> [[1, 2, 3], [4, 5]]
{% endhighlight %}

######################################################################
tags: [ruby]
title: Split a Ruby array into N equally-sized parts.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
To split a Ruby array `a` into `n` equally-sized parts:
{% highlight ruby %}
a.each_slice( (a.size/n.to_f).round ).to_a
{% endhighlight %}

For example:

{% highlight ruby %}
a = [1,2,3,4,5]; n = 3
=> 3
a.each_slice( (a.size/n.to_f).round ).to_a
=> [[1, 2], [3, 4], [5]]
{% endhighlight %}

######################################################################
tags: [mind hack,inspiration]
title: Begin with the end in mind.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Intuitive thinkers work best when they understand the big picture. 

Try to articulate *why* this task is important,

######################################################################
tags: [mind hack,inspiration,foo]
title: The first step is to assume success.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Imagine the work is complete and wildly successful. what does that look like? what did you do to get there?

######################################################################
tags: [mind hack,inspiration]
title: Channel Someone
credit: I'm pretty sure I cribbed this from something, but I can remember what.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Why limit yourself to asking, "What would Jesus do?" (WWJD?) when you can not only ask "WWBD?" ("What would Buddha do?") or "WWMD?" ("What would Mohammed do?"), but also:
 * WWBBD? - What would Bugs Bunny do?
 * WWMAD? - What would Marcus Aurelius do?
 * WWMPD? - What would Mary Poppins do?
 * WWRMSD? - What would Richard M. Stallman do?
 * WWSOHD? - What would Scarlett O'Hara do?
 * WWYMD? - What would your mom do?

######################################################################
tags: [bash]
title: Append to ~/.bash_history "immediately"
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
{% highlight bash %}
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
{% endhighlight %}

######################################################################
