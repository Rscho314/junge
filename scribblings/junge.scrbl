#lang scribble/manual
@;require[@for-label[junge racket/base]]

@title{junge}
@author{Raoul Schorer}

@defmodule[junge]

@section{To Do}
@itemlist[@item{start simple with only the four arithmetic operations and integers.}
 #:style 'ordered]
@subsection{Name Ideas}
@itemlist[@item{@bold{junge}: J and befunge contraction.}
          #:style 'ordered]

@section{Language Specification}
@subsection{Features}
@centered{In decreasing order of importance}
@itemlist[@item{array programming}
          @item{tacit programming & terseness}
          @item{automatic parallelism}
          @item{fast & practical IDE}
          @item{functions with multiple inputs, single output}
          @item{array views}
          @item{ad hoc polymorphism}
          #:style 'ordered]

@subsection{Concepts}
@subsubsection{What makes junge stand out}
Junge tries to provide a solution to what personally frustrated me when using visual programming
languages and environments: code navigation, and spaghetti code. Junge therefore places UI first
and foremost by providing efficient ways of isolating and making easily accessible the elements
that the users wants when editing a piece of code.
@subsubsection{Execution Model}
N-dimensional space stack-based execution model, where instructions are identified by their spatial
coordinates. In practice, a functional, N-dimensional Forth with no assignment operator. A suite of
instructions in a straight line (SL) is a full program corresponding to athread. Changing orientation
in space spawns a new thread. Source files are 2-dimensional projections of an SL with all of its
immediate children. Conceptually, source is N-dimensional, with N determined by the number of
vertices attached to the node possessing the maximal number of vertices.
@subsubsection{Execution Flow}
The direction of execution flow is deduced from the SL initial instruction coordinates and the SL
working dimension, which respectively mark the start and execution direction of the thread. The
last instruction is also marked as such to avoid confusion when the source code array is densely
populated. The first instruction takes input from all adjacent last cells. The dimension of
execution is signed to indicate the direction of information flow.
@subsubsection{Development Environment}
Snappy, and entirely controlled by keyboard, optionally mouse. Focused on code navigation by using
projections and rotations to get the desired code into view. Strong use of semantic visual cues.

@subsection{Source Code}
@subsubsection{File Structure}
Each file is divided in blocks, each defining a SL. Blocks are separated by newlines.
An SL is defined by the following elements:
@itemlist[@item{block name (alphanumeric)}
           @item{dimension of execution (number)}
           @item{coordinates of first instruction (list of numbers)}
           @item{SL code (alphanumeric, single line)}
          #:style 'ordered]
@subsubsection{Basic File Example}
def
HelloWorld
0
0
"Hello, World!"
@subsubsection{composed File Example}
simplest (sequential computation, equivalent to Forth),
@verbatim|{Beginning
0
0
"Hello, " "World!" concatenate}|

rewritten in parallel (slower, finish is obtained from new thread),
@verbatim|{First
0
0 0
"Hello, "

Second
1
1 1
"World!"

HelloWorld
0
1 0
concatenate}|

more easily rewritten,
@verbatim|{Start
0
0 0
"Hello, " concatenate

Finish
1
1 0
"World!"}|

but the follwing is incorrect,
@verbatim|{Initial
0
0
"Hello, " concatenate

Subsequent
0
2
"World!"}|

@subsubsection{Source Semantics}
Each source block is a struct.
@verbatim|{HW
0
0
"HW"}|
is compiled to a struct as:
@verbatim|{(struct block (name dimension start-position))}|

Block name will be used by the UI to display the block to the user in high-level view. Navigation
between blocks is done through keyboard interaction. Any block can be entered to display its
components (primitives, or other blocks as in the composed file example above).
Source code is fused to multidimensional array at compile time.
Function input argument order is defined in increasing order of dimensions, since contiguous
elements to a node are pushed to the stack in this order. For each SL, the computed coordinates
of next block (adding the number of SL tokens to the starting number in the relevant dimension)
defines the output block coordinates. Instruction collision detection and solving is performed
automatically (i.e. the instruction array is maximally densified). The third example above
illustrates that due to the stack execution model, function inputs must be stacked before
function execution is attempted.

@section{Ideas}
@itemlist[@item{@bold{variables:} perhaps not needed thanks to muldimensionality}
          @item{@bold{types:} dependent}
          @item{bold{lib:} MKSA system as types}]