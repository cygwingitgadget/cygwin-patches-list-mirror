Return-Path: <cygwin-patches-return-5651-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20803 invoked by alias); 20 Sep 2005 12:45:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19481 invoked by uid 22791); 20 Sep 2005 12:43:29 -0000
Received: from rwcrmhc13.comcast.net (HELO rwcrmhc12.comcast.net) (204.127.198.39)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Tue, 20 Sep 2005 12:43:29 +0000
Received: from [192.168.0.100] (c-67-172-242-110.hsd1.ut.comcast.net[67.172.242.110])
          by comcast.net (rwcrmhc13) with ESMTP
          id <200509201243230150044b6he>; Tue, 20 Sep 2005 12:43:23 +0000
Message-ID: <433003E8.90701@byu.net>
Date: Tue, 20 Sep 2005 12:45:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: PING: fix ARG_MAX
References: <loom.20050906T172937-420@post.gmane.org> <loom.20050910T164247-175@post.gmane.org> <20050912152245.GB29379@calimero.vinschen.de> <43265113.3000207@byu.net> <20050919143101.GA16760@trixie.casa.cgf.cx>
In-Reply-To: <20050919143101.GA16760@trixie.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-SW-Source: 2005-q3/txt/msg00106.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Christopher Faylor on 9/19/2005 8:31 AM:
> If this is really true, then the findutils configury should be
> attempting some kind of timing which finds that magic point where it
> should be ignoring _SC_ARG_MAX.  It shouldn't be vaguely assuming that
> it is in its best interests to ignore it because someone thinks that the
> cost of processing each argument outweighs the benefits of forking fewer
> tests.

POSIX allows xargs to have a default size (currently, xargs defaults to
128k unless otherwise constrained by _SC_ARG_MAX), and that -s can change
that size to anything within the range permitted by _SC_ARG_MAX.

> 
> Given that cost of forking is much more expensive on cygwin than on
> other systems I really don't see how you can use this argument anyway
> and, IMO, it doesn't make much sense on standard UNIX either.  If you
> create more processes via fork you are invoking the OS and incurring
> context switches.  You're still processing the same number of arguments
> but you're just going to the OS to handle them more often.  I don't see
> how that's ever a win.

In isolation, no.  But it is what else you are doing with the arguments -
the text processing of xargs to parse it into chunks, and the invoked
utility's processing of its argv, that also consumes time.  Also, lots of
data tends to imply more page faults, which can be as expensive as context
switches anyways.

> 
> I'm willing to be proven wrong by hard data but I think that you and the
> findutils mailing list shouldn't be making assumptions without data to
> back them up.

Did you not read the thread on bug-findutils?  Bob Proulx proposed a test
that shows that there is NO MEASURABLE DIFFERENCE between a simple xargs
beyond a certain -s:
http://lists.gnu.org/archive/html/bug-findutils/2005-09/msg00038.html

Then I repeated the test on cygwin, and found similar results:
http://lists.gnu.org/archive/html/bug-findutils/2005-09/msg00039.html

There comes a point, where even when all xargs is doing is invoking echo,
that the cost of passing that much information through pipes does overtake
the cost of forks.

However, I am also keen on providing a more reasonable -s behavior in
xargs.  If cygwin were to have pathconf(filename, _PC_ARG_MAX), where a
PATH search were done when filename does not contain '/', then pathconf
could return 32k on Windows processes, and unlimited (or an actual known
limit) for cygwin processes, so that xargs can then allow unlimited -s
sizes for cygwin processes but cap windows processes at 32k and never
encounter the E2BIG.

- --
Life is short - so eat dessert first!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDMAPo84KuGfSFAYARAry+AKCrEPEhqsTIQwWKrLpNA2M1qC/dFACeLz9k
aPTSZXTkUZCHUkoDNIiPdxA=
=zS83
-----END PGP SIGNATURE-----
