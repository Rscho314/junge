#lang scribble/manual
@;require[@for-label[junge racket/base]]

@title{junge}
@author{Raoul Schorer}

@defmodule[junge]

@section{To Do}
@itemlist[@item{start simple with only the four arithmetic operations and integers.}
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
@subsubsection{Execution Model}
N-dimensional space stack-based execution model, where instructions are identified by their spatial
coordinates. A suite of instructions in a straight line (SL) is a full program corresponding to a
thread. Changing orientation in space spawns a new thread. Source files are 2-dimensional projections
of an SL with all of its immediate children, and source code is therefore 2-D. Conceptually, source is
N-dimensional, with N determined by the number of vertices attached to the node possessing the
maximal number of vertices.
@subsubsection{Development Environment}
Snappy, and entirely controlled by keyboard, optionally mouse. Focused on code navigation by using
projections and rotations to get the desired code into view. Strong use of semantic visual cues.

@subsection{Source Code}
@subsubsection{Anatomy}
Each file is a 2D array of characters, including the relevant SL and its name, and the spatial
coordinates of the first instruction of all of its immediate parents (i.e. providing input) and
children (i.e. given output).
@subsubsection{File Structure}
A file contains three columns separated by spaces. The left column is a list of input coordinates in
parentheses. The central column contains the SL code. The right column is similar to the left one and
defines outputs.
@subsubsection{File Example}
@tabular[#:style 'boxed
         #:column-properties '(left left left left)
         #:row-properties '(bottom-border ())
         (list (list @bold{parents} @bold{SL}          @bold{children} @bold{meaning})
               (list ""             "do this and that" ""              "SL (function) name")
               (list ""             "(0 0 0)"          ""              "ID of 1st intruction")
               (list ""             'cont              'cont           "(here, origin or program start)")
               (list "(6 5 0)"      "*"                ""              "multiply with inputs")
               (list ""             "//comment"        'cont           "{(0 0 0)(6 5 0)}")
               (list ""             'cont              'cont           "and output")
               (list ""             'cont              'cont"{(1 0 0)}")
               (list "(0 0 0)"      "+/"               "(12 5 3)"      "sum with inputs")
               (list ""             'cont              'cont           "{(0 0 0)(1 0 0)}")
               (list ""             'cont              'cont           "and outputs")
               (list ""             'cont              'cont           "{(2 0 0)(12 5 3)}"))]

@section{Ideas}
@itemlist[@item{@bold{variables:} perhaps not needed thanks to muldimensionality}
          @item{@bold{types:} numbers, string, array}]