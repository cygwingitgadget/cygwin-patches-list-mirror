Return-Path: <cygwin-patches-return-5653-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29971 invoked by alias); 21 Sep 2005 13:24:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29866 invoked by uid 22791); 21 Sep 2005 13:24:44 -0000
Received: from sccrmhc13.comcast.net (HELO sccrmhc13.comcast.net) (204.127.202.64)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Wed, 21 Sep 2005 13:24:44 +0000
Received: from [192.168.0.100] (c-67-172-242-110.hsd1.ut.comcast.net[67.172.242.110])
          by comcast.net (sccrmhc13) with ESMTP
          id <2005092113244101300abnshe>; Wed, 21 Sep 2005 13:24:41 +0000
Message-ID: <43315F17.9050702@byu.net>
Date: Wed, 21 Sep 2005 13:24:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: PING: fix ARG_MAX
References: <loom.20050906T172937-420@post.gmane.org> <loom.20050910T164247-175@post.gmane.org> <20050912152245.GB29379@calimero.vinschen.de> <43265113.3000207@byu.net> <20050919143101.GA16760@trixie.casa.cgf.cx> <433003E8.90701@byu.net> <20050920160542.GA6720@trixie.casa.cgf.cx>
In-Reply-To: <20050920160542.GA6720@trixie.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-SW-Source: 2005-q3/txt/msg00108.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Christopher Faylor on 9/20/2005 10:05 AM:
> AFAICT, we're not talking about defaults.  We're talking about the
> optimum setting.
> 
> Your change to xargs doesn't permit me to go beyond 32K.  Personally,
> I'd like to be able to override that.

So would I.  See below.

> 
> I have a similar test which shows noticeable improvement when going from
> 32K to 64K and miniscule-but-still-there improvements after that:

Was this benchmark run on a modified xargs, or did you still suffer from
the 32k limit?  xargs truncates the -s arg down to what it is told is the
system limit; use the undocumented xargs --show-limits to prove that you
are getting the buffer size you are requesting.

> 
> I am not really interested in providing a non-standard interface which
> would ultimately end up being used just by xargs.  That would mean that
> we're adding an interface to cygwin so that a UNIX program could work
> better with non-cygwin programs.  I think I've been pretty consistent in
> stating that I want to encumber cygwin as little as possible when it
> comes to accommodating non-cygwin programs.

POSIX allows extensions to sysconf and pathconf for a reason, but I can
understand if you are reluctant to add _PC_ARG_MAX.

> 
> If you want to keep the 32K limit, that's ok with me.  I'd just ask that
> you make it possible to override it.

My current findutils release just bypasses the _SC_ARG_MAX check
altogether with a hard-coded 32k upper limit to -s, without touching the
code that defaults to 128k (since xargs automatically trims its default
down to the results of its _SC_ARG_MAX check as needed).  But my next
release of findutils, after cygwin 1.5.19 is out (where all cygwin
processes and not just cygexec mount points get the larger cygwin arg
limits), will change the default from 128k to 32k, but use the normal
_SC_ARG_MAX as the upper limit of -s.  So maybe instead of having
_SC_ARG_MAX return 1 meg, you should make it even larger, since cygwin
processes really can pass more than 1 meg.
> 
> But, then, I suspect that this wasn't overrideable when I was providing
> xargs either so you can feel free to ignore my request.

Correct, your earlier releases of xargs could not exceed your hardcoded
ARG_MAX limitation either.

- --
Life is short - so eat dessert first!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDMV8X84KuGfSFAYARAjH3AJsFVfYmqzWBcqQyYNYYdwfRQjnykACeMzvB
GX41apLMG8QW9NyjslbhRjo=
=22kM
-----END PGP SIGNATURE-----
