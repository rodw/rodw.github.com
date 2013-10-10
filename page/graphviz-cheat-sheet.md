# Basics

## (Undirected) Graphs

{% highlight gv %}
graph G {                   // <-- A graph named `G`.
  A -- B                    // <-- A node named `A` connected to a node named `B`.
  C                         // <-- A disconnected node.
  A -- "Another Node"       // <-- Use quotes around node names with whitespace.
  B -- "Yet\nAnother\nNode" // <-- Use `\n` for newlines.
  // C-style inline comments.
  /* C-style block (multi-line) comments. */
}
{% endhighlight gv %}

## Directed Graphs

{% highlight gv %}
digraph H {                 // <-- A DIrected GRAPH named `H`.
  A -> B                    // <-- A node named `A` pointing to a node named `B`.
  B -> A                    // <-- Edges can go both ways.
}
{% endhighlight gv %}

## Edge and Node Attributes

Attributes are name/value pairs, delimited by whitespace.

{% highlight gv %}
digraph G {
  A [style=filled fillcolor=red]
  B [style=filled fillcolor=green]
  A -> B [color=blue arrowhead=empty]
}
{% endhighlight %}

A long list of attributes can be found at <a href="http://www.graphviz.org/content/attrs">graphviz.org/content/attrs</a>.

Using `node` or `edge`, one can set the (default) attributes for the subsequent nodes and edges.

{% highlight gv %}
digraph G {
  edge [color=blue]
  node [style=filled fillcolor=red]
    A -> B
    C [fillcolor=green]
  edge [dir=both]
    B -> C
}
{% endhighlight %}

## Some Common Attributes

digraph G {
  bgcolor = lightgray // <-- graph- or cluster-level attributes look like this.
  node [style=filled fillcolor=gray]
    Square [shape=square];
    Rect [shape=rect];       // also `box` or `rectangle`
    Circle [shape=circle];
    Ellipse [shape=ellipse];    // also `oval`
    Point [shape=point];
    None [shape=none];       // also `plaintext`
    Diamond [shape=diamond];
    Egg [shape=egg];
    Triangle [shape=triangle];
    Trapezium [shape=trapezium];
    Parallelogram [shape=parallelogram];
}
// circle	point	egg	triangle
// plaintext	diamond	trapezium	parallelogram

// house	pentagon	hexagon	septagon

// octagon	doublecircle	doubleoctagon	tripleoctagon

// invtriangle	invtrapezium	invhouse	Mdiamond

// Msquare	Mcircle	rect	rectangle

// square	none	note	tab

// folder	box3d	component	promoter

// cds	terminator	utr	primersite

// restrictionsite	fivepoverhang	threepoverhang	noverhang

// assembly	signature	insulator	ribosite

// rnastab	proteasesite	proteinstab	rpromoter

// rarrow	larrow	lpromoter
