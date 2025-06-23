Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 5A0043889F93; Mon, 23 Jun 2025 19:40:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5A0043889F93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750707623;
	bh=nvVjOKXf9jJ1srFFo8bVfKNSbReHc0ydf0Rg2pINSqI=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=shhXC+Qu+zWlwbA+JebPwCA3L2/ifAV57ThT8dQouVOZ/LCQJ72leGAKlFIHV10pr
	 UGrSQFL/e1AmQuOAndSLtsS96vSoorTIJVcMrIE8JpQWMsgsKibMi9LF27bbthv1LT
	 ewMmLRAxZ9nnsp47SqIJkAaqnR68jU8eAEXcFL9I=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 0FB42A80D72; Mon, 23 Jun 2025 21:40:21 +0200 (CEST)
Date: Mon, 23 Jun 2025 21:40:21 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: winsup/cygwin/include/asm/socket.h: add
 SO_REUSEPORT
Message-ID: <aFmtpZfUf76EjvUM@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <6f703b770ddd29e5c174622ae1570761a8a52a92.1750525279.git.Brian.Inglis@SystematicSW.ab.ca>
 <aFkTbV61qw06knEv@calimero.vinschen.de>
 <b34eac53-be01-4822-9e83-0939c1009af8@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b34eac53-be01-4822-9e83-0939c1009af8@SystematicSW.ab.ca>
List-Id: <cygwin-patches.cygwin.com>

On Jun 23 12:39, Brian Inglis wrote:
> On 2025-06-23 02:42, Corinna Vinschen wrote:
> > Hi Brian,
> > 
> > On Jun 21 11:02, Brian Inglis wrote:
> > > SO_REUSEPORT is defined in BSDs, Solaris, and Linux (since 3.9).
> > > It is not available in Windows but S.O. articles suggest
> > 
> > S.O.?
> > 
> > -v, please?
> 
> Hi Corinna,
> 
> Stack Overflow (added dots to distinguish that abbrev from SockOpt).
> 
> > If there's this articel, it might be a good idea to add a link to it
> > in the commit message.
> 
> Might have made the above abbrev more obvious:
> 
> https://stackoverflow.com/questions/13637121/so-reuseport-is-not-defined-on-windows-7#comment18710480_13638757
> 
> Other articles spend a lot of time discussing their opinions of whether
> there are subtle or drastic differences between SO_REUSEADDR and
> SO_REUSEPORT implmentations across available platforms, so don't add much to
> that.
> 
> [One generated answer suggested SO_EXCLUSIVEADDRUSE rather than
> SO_REUSEPORT, but gave the definition of both identically, except for the
> words "do not" in the former, suggesting that the so-called "language model"
> excluded semantics!]

I read it now as well, and I think the resulting patch is not correct.

> +#define SO_REUSEPORT  (SO_REUSEADDR | SO_BROADCAST)

Did you actually *test* that this works as desired?  And I don't mean
your application could be compiled, but did you test that

a) setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, ...) returned success and
b) the behaviour is actually as desired?

I didn't try this myself, but I bet that a) already fails to work.
setsockopt handles one flag at a time.  To set two flags as in
SO_REUSEADDR *and* SO_BROADCAST, you have to call setsockopt twice,
once per flag.

And here comes the surprising fact that Cygwin's setsockopt/getsockopt
functions are not just wrappers for the underlying Windows functions,
but there's s quite a bit of checking, tweaking and faking involved.

To implement this in Cygwin, defining a flag value for SO_REUSEPORT as
you did (the value SO_REUSEADDR | SO_BROADCAST is actually ok-ish, it
doesn't clash with the other SOL_SOCKET values, but see below) is just
the first step.

The second step involves calling Windows' setsockopt correctly (twice) in
fhandler_socket_inet::setsockopt and an equivalent implementation in
fhandler_socket_inet::getsockopt for reading the value.

However, I have some doubts in terms of b) as well. The SO_BROADCAST
option only makes sense on datagram sockets.  Read the question on
stackoverflow again: It asks for a solution to reuse *and* receive
broadcast packages.  That's not what SO_REUSEPORT implies.

To emulate SO_REUSEPORT, you could probably simply set the SO_REUSEADDR
flag.  https://stackoverflow.com/questions/14388706/how-do-so-reuseaddr-and-so-reuseport-differ hints at that and the documented behaviour of Winsock's
bind(2) supports this.

This is actually different from the case of a Cygwin app requesting
SO_REUSEADDR.  We *never* set the SO_REUSEADDR flag because the Windows
default behaviour without SO_REUSEADDR is equivalent to the BSD
behaviour with SO_REUSEADDR.  What we do is only noting that the
app set the SO_REUSEADDR flag, because if it didn't, we set the
SO_EXCLUSIVEADDRUSE option at bind(2) time.

tl;dr: to implement SO_REUSEPORT, make Cygwin actually setting the
SO_REUSEADDR flag and make sure to handle this scenario in
fhandler_socket_inet::bind, too.  This will probably do what you want.


Corinna
