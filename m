From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: hierarchy in setup
Date: Mon, 25 Jun 2001 07:27:00 -0000
Message-id: <20010625102821.D9771@redhat.com>
References: <00cc01c0fd7e$3e8d7b20$0200a8c0@lifelesswks>
X-SW-Source: 2001-q2/msg00333.html

On Mon, Jun 25, 2001 at 11:53:41PM +1000, Robert Collins wrote:
>is it worth my continuing to hack on my variant of setup?  Or has your
>time traveling yielded better/more appropriate/whatever results?

I actually got bogged down in fixing a cygwin bug.  When I tried to
build things on my laptop, cygwin hung.  I should have expected this,
of course.

So, once I got beyond that, I only had time to fix generic setup problems.

I haven't looked at your patch yet, Robert, but right now it is the only
game in town.

With regard to the source question, though, I think that the way that this
should be handled is that the source packages should just be included
along with the other packages but they should be excluded by default.
Maybe you get a "source view", or something so that the installation is
not cluttered with extra packages.

cgf
