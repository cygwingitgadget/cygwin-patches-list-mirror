From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: [PATCH]: `wincap' instead of `os_being_run' and `iswinnt'
Date: Wed, 12 Sep 2001 11:21:00 -0000
Message-id: <20010912202058.H1285@cygbert.vinschen.de>
X-SW-Source: 2001-q3/msg00135.html

I have just checked in a huge patch which changes all code which
asks for the OS to behave different on different systems.

The global variables `os_being_run' and `iswinnt' are eliminated.

Instead we have a new global variable called `wincap' which is
the only member of class `wincapc'. The definition of that stuff
is in the new file wincap.h.

What's new?  The wincap object contains the capabilities of the
OS which we are currently running under.  The code in Cygwin
doesn't have to ask for the operating system anymore but just for
"does the system I'm currently running under support the capability
`foo'"?  The way to do that now is the following:

Edit wincap.h and add a flag (or any other integral datatype which
is appropriate) to the struct wincaps:

	unsigned has_foo	: 1;

Then add the appropriate has_foo() method to class wincapc:

	bool IMPLEMENT (has_foo)

Then add wincap.cc and add an initialisation for the new struct
member `has_foo' to all structs given in wincap.cc.  These structs
are named so that it's clear which OS is addressed:

	wincap_unknown,
	wincap_95,
	wincap_95osr2,
	wincap_98,
	wincap_98se,
	wincap_me,
	wincap_nt3,
	wincap_nt4,
	wincap_nt4sp4,
	wincap_2000,
	wincap_xp.

Just add an

	has_foo:false

or

	has_foo:true

as appropriate for that OS.

The usage is easy then.  In your code which needs to differ, just call

	if (wincap.has_foo ())
	  ...
	else
	  ...

Chris and I are hoping that this makes some code pieces a bit more
obvious due to the usage of a `talking' conditional.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
