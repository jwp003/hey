HEY(1) - General Commands Manual

# NAME

**hey** - set urgency hint on containing window

# SYNOPSIS

**hey**
\[**-v**]

# DESCRIPTION

**hey**
is a simple tool to set the urgent flag on the containing window.
The window manager should provide some visual indication that the
window requires attention.

**hey**
is useful for providing an alert when a long running command has
finished.

# OPTIONS

**-v**

> Print version information to standard output and exit

# ENVIRONMENT

`WINDOWID`
is used to determine which window to set the urgency hint on.
Most terminal emulators (XTerm, urxvt, konsole, etc.) set this
automatically.
If it is not set,
**hey**
will fail.

# EXAMPLES

**hey**
can be used to provide an alert when a long-running command
finishes:

		make; hey

Once make finishes,
**hey**
will set the urgent hint, and the window manager will alert the
user.

# BUGS

Please report bugs at:
[https://github.com/jonnepaa/hey](https://github.com/jonnepaa/hey)

hey-1.0 - July 12, 2017
