From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: hierarchy in setup
Date: Mon, 25 Jun 2001 07:53:00 -0000
Message-id: <20010625105405.B11345@redhat.com>
References: <00cc01c0fd7e$3e8d7b20$0200a8c0@lifelesswks> <20010625102821.D9771@redhat.com> <00fa01c0fd85$2a690fe0$0200a8c0@lifelesswks>
X-SW-Source: 2001-q2/msg00335.html

On Tue, Jun 26, 2001 at 12:43:14AM +1000, Robert Collins wrote:
>----- Original Message -----
>From: "Christopher Faylor" <cgf@redhat.com>
>>With regard to the source question, though, I think that the way that
>>this should be handled is that the source packages should just be
>>included along with the other packages but they should be excluded by
>>default.  Maybe you get a "source view", or something so that the
>>installation is not cluttered with extra packages.
>
>That's a much more elegant way of describing my actual internal concept
>:].  My "src" button would be "turning on the source view".  Anyway...
>one step at a time?

Yep.  I originally thought that a separate package for sources would
be nice.  Maybe we can just do that for now.  It might actually be
adequate for the foreseeable future.

Every time I try to work on the sources stuff that is in setup currently,
it just feels "wrong".

For instance, I downloaded the sources for ash, last night while testing
my changes.  When presented with the "chooser" screen after "Install from
local directory", the default choice for ash was to uninstall it.  The
reason was that setup.exe discovered that the current version of setup
was available but there was no corresponding binary tar package.  So,
stepping through the state machine, it came to uninstall.

I was the only one who would see this, since I had made "Skip" changes
which prevented Skip from being displayed if the package was "installed".
So, I had to kludge around this behavior.

If ash-yymmdd-src.tar.bz2 was considered a separate package, however,
there wouldn't have been any problem.  Or, at least there would have
been different problems.

cgf
