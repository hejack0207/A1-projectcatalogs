# groff_man(7) - groff man macros to support generation of man pages

Groff Version 1.22.3, 4 November 2014






<a name="synopsis"></a>

# Synopsis


```
.SY "groff&nbsp;-man" [options .\|.\|.] [files .\|.\|.] .SY "groff&nbsp;-m&nbsp;man" [options .\|.\|.] [files .\|.\|.] .YS
```


<a name="description"></a>

# Description


The
**man**
macros used to generate
_man&nbsp;pages_
with
_groff_
were written by James Clark.
This document provides a brief summary of the use of each macro in that
package.


<a name="options"></a>

# Options


The
**man**
macros understand the following command line options (which define
various registers).

* **-rcR=1**  
  This option (the default if in nroff mode) creates a single, very
  long page instead of multiple pages.
  Say
  **-rcR=0**
  to disable it.
* **-rC1**  
  If more than one manual page is given on the command line, number the
  pages continuously, rather than starting each at&nbsp;1.
* **-rD1**  
  Double-sided printing.
  Footers for even and odd pages are formatted differently.
* **-rFT=**_dist_  
  Set distance of the footer relative to the bottom of the page if
  negative or relative to the top if positive.
  The default is -0.5i.
* **-rHY=**_flags_  
  Set hyphenation flags.
  Possible values are 1&nbsp;to hyphenate without restrictions, 2&nbsp;to not
  hyphenate the last word on a page, 4&nbsp;to not hyphenate the last two
  characters of a word, and 8&nbsp;to not hyphenate the first two characters
  of a word.
  These values are additive; the default is&nbsp;14.
* **-rIN=**_width_  
  Set body text indentation to
  _width_.
  The default is 7n for
  _nroff_,
  7.2n for
  _troff_.
  For
  _nroff_,
  this value should always be an integer multiple of unit \[oq]n\[cq] to
  get consistent indentation.
* **-rLL=**_line-length_  
  Set line length.
  If this option is not given, the line length is set to respect any
  value set by a prior \[oq].ll\[cq] request (which
  _must_
  be in effect when the \[oq].TH\[cq] macro is invoked),
  if this differs from the built-in default for the formatter;
  otherwise it defaults to 78n in
  _nroff_
  mode and 6.5i in
  _troff_
  mode.
* Note that the use of a \[oq].ll\[cq] request to initialize the line
  length is supported for backward compatibility with some versions of
  the
  **man**
  program;
  direct initialization of the \[oq]LL\[cq] register should
  _always_
  be preferred to the use of such a request.
  In particular, note that a \[oq].ll&nbsp;65n\[cq] request does
  _not_
  preserve the normal
  _nroff_
  default line length,
  (the
  **man**
  default initialization to 78n prevails), whereas, the
  \[oq]-rLL=65n\[cq] option, or an equivalent \[oq].nr&nbsp;LL&nbsp;65n\[cq]
  request preceding the use of the \[oq]TH\[cq] macro,
  _does_
  set a line length of 65n.
* **-rLT=**_title-length_  
  Set title length.
  If this option is not given, the title length defaults to the line
  length.
* **-rP**_nnn_  
  Enumeration of pages start with
  _nnn_
  rather than with&nbsp;1.
* **-rS**_xx_  
  Base document font size is
  _xx_
  points
  (_xx_
  can be 10, 11, or&nbsp;12) rather than 10&nbsp;points.
* **-rSN=**_width_  
  Set sub-subheading indentation to
  _width_.
  The default is 3n.
* **-rX**_nnn_  
  After page&nbsp;\c
  _nnn_,
  number pages as
  _nnn_a,
  _nnn_b,
  _nnn_c,
  etc.
  For example, the option \[oq]-rX2\[cq] produces the following page
  numbers: 1, 2, 2a, 2b, 2c, etc.
  

<a name="usage"></a>

# Usage


This section describes the available macros for manual pages.
For further customization, put additional macros and requests into the
file
**man.local**,
which is loaded immediately after the
**man**
package.

* **.EX**  
  .TQ
  **.EE**
  Example/End Example.
  After
  **.EX**,
  filling is disabled and the font is set to constant-width.
  This is useful for formatting code, command, and configuration-file
  examples.
  The
  **EE**
  macro restores filling and restores the previous font.
* These macros are defined on many (but not all) legacy Unix systems
  running classic troff.
  To be certain your page will be portable to those systems, copy
  their definitions from the
  **an-ext.tmac**
  file of a
  **groff**
  installation.
* **.HP**_ [nnn]_  
  Set up a paragraph with hanging left indentation.
  The indentation is set to
  _nnn_
  if that argument is supplied (the default unit is \[oq]n\[cq] if
  omitted), otherwise it is set to the previous indentation value
  specified with
  **.TP**,
  **.IP**,
  or
  **.HP**
  (or to the default value if none of them have been used yet).
  Font size and face are reset to its default values.
  The following paragraph illustrates the effect of this macro with
  hanging indentation set to&nbsp;4 (enclosed by
  **.RS**
  and
  **.RE**
  to set the left margin temporarily to the current indentation):
      .HP 4
      This is a paragraph following an invocation of the
      **HP**
      macro.
      As you can see, it produces a paragraph where all lines but the first
      are indented.
* Use of this presentation-level macro is deprecated.
  While it is universally portable to legacy Unix systems, a hanging
  indentation cannot be expressed naturally under HTML, and many
  HTML-based manual viewers simply interpret it as a starter for a
  normal paragraph.
  Thus, any information or distinction you tried to express with the
  indentation may be lost.
* **.IP**_ [designator] [nnn]_  
  Set up an indented paragraph, using
  _designator_
  as a tag to mark its beginning.
  The indentation is set to
  _nnn_
  if that argument is supplied (the default unit is \[oq]n\[cq] if
  omitted), otherwise it is set to the previous indentation value
  specified with
  **.TP**,
  **.IP**,
  or
  **.HP**
  (or to the default value if none of them have been used yet).
  Font size and face of the paragraph (but not the designator) are reset
  to its default values.
* To start an indented paragraph with a particular indentation but
  without a designator, use \[oq]""\[cq] (two doublequotes) as the
  second argument.
* For example, the following paragraphs were all set up with bullets as
  the designator, using \[oq].IP&nbsp;\·&nbsp;4\[cq].
  The whole block has been enclosed with
  **.RS**
  and
  **.RE**
  to set the left margin temporarily to the current indentation value.
    * ·  
      **IP**
      is one of the three macros used in the
      **man**
      package to format lists.
    * ·  
      **HP**
      is another.
      This macro produces a paragraph with a left hanging indentation.
    * ·  
      **TP**
      is another.
      This macro produces an unindented label followed by an indented
      paragraph.
* **.LP**  
  .TQ
  **.PP**
  .TQ
  **.P**
  These macros are mutual aliases.
  Any of them causes a line break at the current position, followed by a
  vertical space downwards by the amount specified by the
  **PD**
  macro.
  The font size and shape are reset to the default value (normally 10pt
  Roman).
  Finally, the current left margin and the indentation is reset to the
  default values.
* **.RE**_ [nnn]_  
  This macro moves the left margin back to level
  _nnn_,
  restoring the previous left margin.
  If no argument is given, it moves one level back.
  The first level (i.e., no call to
  **.RS**
  yet) has number&nbsp;1, and each call to
  **.RS**
  increases the level by&nbsp;1.
* **.RS**_ [nnn]_  
  This macro moves the left margin to the right by the value
  _nnn_
  if specified (default unit is \[oq]n\[cq]); otherwise it is set to the
  previous indentation value specified with
  **.TP**,
  **.IP**,
  or
  **.HP**
  (or to the default value if none of them have been used yet).
  The indentation value is then set to the default.
* Calls to the
  **RS**
  macro can be nested.
* **.SH**_ [text for a heading]_  
  Set up an unnumbered section heading sticking out to the left.
  Prints out all the text following
  **.SH**
  up to the end of the line (or the text in the next input line if there
  is no argument to
  **.SH**)
  in bold face
  (or the font specified by the string
  **HF**),
  one size larger than the base document size.
  Additionally, the left margin and the indentation for the following
  text is reset to the default values.
* **.SS**_ [text for a heading]_  
  Set up a secondary, unnumbered section heading.
  Prints out all the text following
  **.SS**
  up to the end of the line (or the text in the next input line if there
  is no argument to
  **.SS**)
  in bold face
  (or the font specified by the string
  **HF**),
  at the same size as the base document size.
  Additionally, the left margin and the indentation for the following
  text is reset to the default values.
* **.TH**_ title section [extra1] [extra2] [extra3]_  
  Set the title of the
  _man&nbsp;page_
  to
  _title_
  and the section to
  _section_,
  which must take on a value between 1 and&nbsp;8.
  The value
  _section_
  may also have a string appended, e.g. \[oq].pm\[cq], to indicate a
  specific subsection of the
  _man&nbsp;pages_.
  Both
  _title_
  and
  _section_
  are positioned at the left and right in the header line (with
  _section_
  in parentheses immediately appended to
  _title_.
  _extra1_
  is positioned in the middle of the footer line.
  _extra2_
  is positioned at the left in the footer line (or at the left on
  even pages and at the right on odd pages if double-sided printing is
  active).
  _extra3_
  is centered in the header line.
* For HTML output, headers and footers are completely suppressed.
* Additionally, this macro starts a new page; the new line number is&nbsp;1
  again (except if the \[oq]-rC1\[cq] option is given on the command
  line) -- this feature is intended only for formatting multiple
  _man&nbsp;pages_;
  a single
  _man&nbsp;page_
  should contain exactly one
  **TH**
  macro at the beginning of the file.
* **.TP**_ [nnn]_  
  Set up an indented paragraph with label.
  The indentation is set to
  _nnn_
  if that argument is supplied (the default unit is \[oq]n\[cq] if omitted),
  otherwise it is set to the previous indentation value specified with
  **.TP**,
  **.IP**,
  or
  **.HP**
  (or to the default value if none of them have been used yet).
* The first input line of text following this macro is interpreted as a
  string to be printed flush-left, as it is appropriate for a label.
  It is not interpreted as part of a paragraph, so there is no attempt
  to fill the first line with text from the following input lines.
  Nevertheless, if the label is not as wide as the indentation the
  paragraph starts at the same line (but indented), continuing on the
  following lines.
  If the label is wider than the indentation the descriptive part of the
  paragraph begins on the line following the label, entirely indented.
  Note that neither font shape nor font size of the label is set to a
  default value; on the other hand, the rest of the text has default
  font settings.
* The
  **TP**
  macro is the macro used for the explanations you are just reading.
* **.TQ**  
  The
  **TQ**
  macro sets up header continuation for a
  **TP**
  macro.
  With it, you can stack up any number of labels (such as in a
  glossary, or list of commands) before beginning the indented
  paragraph.
  For an example, look up the documentation of the
  **LP**,
  **PP**,
  and
  **P**
  macros.
* This macro is not defined on legacy Unix systems running classic
  troff.
  To be certain your page will be portable to those systems,
  copy its definition from the
  **an-ext.tmac**
  file of a
  **groff**
  installation.

To summarize, the following macros cause a line break with the
insertion of vertical space (which amount can be changed with the
**PD**
macro):
**SH**,
**SS**,
**TP**,
**TQ**,
**LP**
(**PP**,
**P**),
**IP**,
and
**HP**.
The macros
**RS**,
**RE**,
**EX**,
and
**EE**
also cause a break but no insertion of vertical space.


<a name="macros-to-set-fonts"></a>

# Macros to Set Fonts


The standard font is Roman; the default text size is 10&nbsp;point.

* **.B**_ [text]_  
  Causes
  _text_
  to appear in bold face.
  If no text is present on the line where the macro is called the text
  of the next input line appears in bold face.
* **.BI **_text_  
  Causes text on the same line to appear alternately in bold face and
  italic.
  The text must be on the same line as the macro call.
  Thus
    * this "word and" that

would cause \[oq]this\[cq] and \[oq]that\[cq] to appear in bold face,
while \[oq]word and\[cq] appears in italics.

* **.BR **_text_  
  Causes text on the same line to appear alternately in bold face and
  roman.
  The text must be on the same line as the macro call.
* **.I**_ [text]_  
  Causes
  _text_
  to appear in italic.
  If no text is present on the line where the macro is called the text
  of the next input line appears in italic.
* **.IB **_text_  
  Causes text to appear alternately in italic and bold face.
  The text must be on the same line as the macro call.
* **.IR **_text_  
  Causes text on the same line to appear alternately in italic and
  roman.
  The text must be on the same line as the macro call.
* **.RB **_text_  
  Causes text on the same line to appear alternately in roman and bold
  face.
  The text must be on the same line as the macro call.
* **.RI **_text_  
  Causes text on the same line to appear alternately in roman and
  italic.
  The text must be on the same line as the macro call.
* **.SB**_ [text]_  
  Causes the text on the same line or the text on the next input line to
  appear in boldface font, one point size smaller than the default font.
* **.SM**_ [text]_  
  Causes the text on the same line or the text on the next input line to
  appear in a font that is one point size smaller than the default font.
  

<a name="macros-to-describe-hyperlinks-and-email-addresses"></a>

# Macros to Describe Hyperlinks and Email Addresses


The following macros are not defined on legacy Unix systems
running classic troff.
To be certain your page will be portable to those systems, copy
their definitions from the
**an-ext.tmac**
file of a
**groff**
installation.

Using these macros helps ensure that you get hyperlinks when your
manual page is rendered in a browser or other program that is
Web-enabled.

* **.MT**_ address_  
  .TQ
  **.ME**_ [punctuation]_
  Wrap an email address.
  The argument of
  **.MT**
  is the address; text following, until
  **.ME**,
  is a name to be associated with the address.
  Any argument to the
  **ME**
  macro is pasted to the end of the link text.
  On a device that is not a browser,
    * .EX
      contact
      .MT fred.foonly@\e:fubar.net
      Fred Foonly
      .ME
      for more information
      .EE
* usually displays like this: \[lq]contact Fred Foonly
  &lt;fred.foonly@​fubar.net&gt; for more information\[rq].
* The use of
  **\e:**
  to insert hyphenless breakpoints is a groff extension and can
  be omitted.
* **.UR**_ URL_  
  .TQ
  **.UE**_ [punctuation]_
  Wrap a World Wide Web hyperlink.
  The argument to
  **.UR**
  is the URL; thereafter, lines until
  **.UE**
  are collected and used as the link text.
  Any argument to the
  **UE**
  macro is pasted to the end of the text.
  On a device that is not a browser,
    * .EX
      this is a link to
      .UR http://\e:randomsite.org/\e:fubar
      some random site
      .UE ,
      given as an example
      .EE
* usually displays like this: \[lq]this is a link to some random
  site &lt;http://​randomsite.org/​fubar&gt;, given as an example\[rq].
* The use of
  **\e:**
  to insert hyphenless breakpoints is a groff extension and can be
  omitted.
  

<a name="macros-to-describe-command-synopses"></a>

# Macros to Describe Command Synopses


The following macros are not defined on legacy Unix systems
running classic troff.
To be certain your page will be portable to those systems, copy their
definitions from the
**an-ext.tmac**
file of a
**groff**
installation.

These macros are a convenience for authors.
They also assist automated translation tools and help browsers in
recognizing command synopses and treating them differently from
running text.

* **.OP**_ key value_  
  Describe an optional command argument.
  The arguments of this macro are set surrounded by option braces
  in the default Roman font; the first argument is printed with
  a bold face, while the second argument is typeset as italic.
* **.SY**_ command_  
  Begin synopsis.
  Takes a single argument, the name of a command.
  Text following, until closed by
  **.YS**,
  is set with a hanging indentation with the width of
  _command_
  plus a space.
  This produces the traditional look of a Unix command synopsis.
* **.YS**  
  This macro restores normal indentation at the end of a command
  synopsis.

Here is a real example:

* .EX
  .SY groff
  .OP \e-abcegiklpstzCEGNRSUVXZ
  .OP \e-d cs
  .OP \e-f fam
  .OP \e-F dir
  .OP \e-I dir
  .OP \e-K arg
  .OP \e-L arg
  .OP \e-m name
  .OP \e-M dir
  .OP \e-n num
  .OP \e-o list
  .OP \e-P arg
  .OP \e-r cn
  .OP \e-T dev
  .OP \e-w name
  .OP \e-W name
  [ file
  .\e|.\e|. ]
  .YS
  .EE

produces the following output:

.SY groff
.OP -abcegiklpstzCEGNRSUVXZ
.OP -d cs
.OP -f fam
.OP -F dir
.OP -I dir
.OP -K arg
.OP -L arg
.OP -m name
.OP -M dir
.OP -n num
.OP -o list
.OP -P arg
.OP -r cn
.OP -T dev
.OP -w name
.OP -W name
[_file_
_.\|.\|._]
.YS

If necessary, you might use
**br**
requests to control line breaking.
You can insert plain text as well; this looks like the traditional
(unornamented) syntax for a required command argument or filename.


<a name="miscellaneous"></a>

# Miscellaneous


The default indentation is 7.2n in troff mode and 7n in nroff mode
except for
**grohtml**,
which ignores indentation.

* **.AT**_ [system [release]]_  
  Alter the footer for use with \f[CR]AT&T\f[]
  _man&nbsp;pages_.
  This command exists only for compatibility; don\[aq]t use it.
  See the
  _groff_
  info manual for more.
* **.BT**  
  Print the footer string.
  Redefine this macro to get control of the footer.
* **.DT**  
  Set tabs every 0.5&nbsp;inches.
  Since this macro is always called during a
  **TH**
  macro, it makes sense to call it only if the tab positions have been
  changed.
* Use of this presentation-level macro is deprecated.
  It translates poorly to HTML, under which exact whitespace control
  and tabbing are not readily available.
  Thus, information or distinctions that you use
  **.DT**
  to express are likely to be lost.
  If you feel tempted to use it, you should probably be composing a
  table using
  **tbl**(1)
  markup instead.
* **.PD**_ [nnn]_  
  Adjust the empty space before a new paragraph or section.
  The optional argument gives the amount of space (default unit is
  \[oq]v\[cq]); without parameter, the value is reset to its default
  value (1&nbsp;line in nroff mode, 0.4v&nbsp;otherwise).
  This affects the macros
  **SH**,
  **SS**,
  **TP**,
  **LP**
  (resp.
  **PP**
  and
  **P**),
  **IP**,
  and
  **HP**.
* Use of this presentation-level macro is deprecated.
  It translates poorly to HTML, under which exact control of
  inter-paragraph spacing is not readily available.
  Thus, information or distinctions that you use
  **.PD**
  to express are likely to be lost.
* **.PT**  
  Print the header string.
  Redefine this macro to get control of the header.
* **.UC**_ [version]_  
  Alter the footer for use with \f[CR]BSD\f[]
  _man&nbsp;pages_.
  This command exists only for compatibility; don\[aq]t use it.
  See the
  _groff_
  info manual for more.

The following strings are defined:

* **\e*R**  
  The \[oq]registered\[cq] sign.
* **\e*S**  
  Switch back to the default font size.
* **\e*(lq**  
  .TQ
  **\e*(rq**
  Left and right quote.
  This is equal to \[oq]\e(lq\[cq] and \[oq]\e(rq\\[cq], respectively.
* **\e*(HF**  
  The typeface used to print headings and subheadings.
  The default is \[oq]B\[cq].
* **\e*(Tm**  
  The \[oq]trademark\[cq] sign.

If a preprocessor like
**tbl**
or
**eqn**
is needed, it has become common to make the first line of the
_man&nbsp;page_
look like this:

**'\e"&nbsp;**_word_

Note the single space character after the double quote.
_word_
consists of letters for the needed preprocessors: \[oq]e\[cq] for
**eqn**,
\[oq]r\[cq] for
**refer**,
and \[oq]t\[cq] for
**tbl**.
Modern implementations of the
**man**
program read this first line and automatically call the right
preprocessor(s).


<a name="portability-and-troff-requests"></a>

# Portability and Troff Requests


Since the
**man**
macros consist of groups of
_groff_
requests, one can, in principle, supplement the functionality of the
**man**
macros with individual
_groff_
requests where necessary.
See the
_groff_
info pages for a complete reference of all requests.

Note, however, that using raw troff requests is likely to make your
page render poorly on the (increasingly common) class of viewers that
render it to HTML.
Troff requests make implicit assumptions about things like character
and page sizes that may break in an HTML environment; also, many of
these viewers don\[aq]t interpret the full troff vocabulary, a problem
that can lead to portions of your text being silently dropped.

For portability to modern viewers, it is best to write your page
entirely in the requests described on this page.
Further, it is best to completely avoid those we have described as
\[oq]presentation-level\[cq]
(**.HP**,
**.PD**,
and
**.DT**).

The macros we have described as extensions
(**.EX**/**.EE**,
**.SY**/**.OP**/**.YS**,
**.UR**/**.UE**,
and
**.MT**/**.ME**)
should be used with caution, as they may not yet be built in to
some viewer that is important to your audience.
If in doubt, copy the implementation onto your page.


<a name="files"></a>

# Files



* **man.tmac**  
  .TQ
  **an.tmac**
  These are wrapper files to call
  **andoc.tmac**.
* **andoc.tmac**  
  Use this file in case you don\[aq]t know whether the
  **man**
  macros or the
  **mdoc**
  package should be used.
  Multiple man pages (in either format) can be handled.
* **an-old.tmac**  
  Most
  **man**
  macros are contained in this file.
* **an-ext.tmac**  
  The extension macro definitions for
  **.SY**,
  **.OP**,
  **.YS**,
  **.TQ**,
  **.EX/.EE**,
  **.UR/.UE**,
  and
  **.MT/.ME**
  are contained in this file.
  It is written in classic troff, and released for free re-use,
  and not copylefted; manual page authors concerned about
  portability to legacy Unix systems are encouraged to copy these
  definitions into their pages, and maintainers of troff
  or its workalikes are encouraged to re-use them.
* Note that the definitions for these macros are read after the call of
  **TH**,
  so they will replace macros of the same names given at the beginning of
  your file.
  If you must use your own definitions for these macros, they must be
  given after calling
  **TH**.
* **man.local**  
  Local changes and customizations should be put into this file.
  

<a name="see-also"></a>

# See Also


**tbl**(1),
**eqn**(1),
**refer**(1),
**man**(1),
**man**(7),
**groff_mdoc**(7)


<a name="copying"></a>

# Copying



    

<a name="authors"></a>

# Authors


.au





