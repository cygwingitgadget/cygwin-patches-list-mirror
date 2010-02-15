Return-Path: <cygwin-patches-return-6968-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21055 invoked by alias); 15 Feb 2010 05:48:36 -0000
Received: (qmail 21044 invoked by uid 22791); 15 Feb 2010 05:48:34 -0000
X-SWARE-Spam-Status: No, hits=-2.6 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from out2.smtp.messagingengine.com (HELO out2.smtp.messagingengine.com) (66.111.4.26)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 15 Feb 2010 05:48:30 +0000
Received: from compute2.internal (compute2.internal [10.202.2.42]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id EC180E0C78 	for <cygwin-patches@cygwin.com>; Mon, 15 Feb 2010 00:48:28 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])   by compute2.internal (MEProxy); Mon, 15 Feb 2010 00:48:28 -0500
Received: from [192.168.1.3] (user-0c6sbd2.cable.mindspring.com [24.110.45.162]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id 85A1539CB4; 	Mon, 15 Feb 2010 00:48:28 -0500 (EST)
Message-ID: <4B78E01F.8050007@cwilson.fastmail.fm>
Date: Mon, 15 Feb 2010 05:48:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Add xdr support
References: <4B764A1F.6060003@cwilson.fastmail.fm>  <20100213113509.GJ5683@calimero.vinschen.de>  <4B76C334.8080101@cwilson.fastmail.fm>  <20100213210122.GA20649@ednor.casa.cgf.cx>  <4B773B70.8040208@cwilson.fastmail.fm>  <4B778315.9090300@gmail.com>  <4B778E43.5020701@cwilson.fastmail.fm>  <4B7834AD.3040606@gmail.com> <20100214190623.GB19242@ednor.casa.cgf.cx>
In-Reply-To: <20100214190623.GB19242@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q1/txt/msg00084.txt.bz2

Christopher Faylor wrote:
> You could make the same argument for much of the functionality we've
> added to cygwin.  I'm sure a significant number of functions could be
> added to newlib if we were so inclined.  Just take a look at the libc
> directory or the regex directory.

Good points.  regex functions are also typically provided by libc.so,
yet cygwin has its own versions not provided by newlib...

> One of my problems with newlib is that, once this is added, you'll need
> to get permission from Jeff J. for any future modifications - with all of
> the bottleneck potential that involves.

An issue from /your/ perspective, as an actual cygwin maintainer.  From
/my/ perspective, it's just a *different* hoop to jump thru -- Jeff J.
vs. Corinna/cgf -- not an additional hoop, except the self-imposed one
I'm jumping thru right now.  'Course, from my limited observations on
the newlib lists, you guys are somewhat more responsive.

>  The other problem is that you
> potentially have to deal with the other truly embedded projects which
> use the library.  They sometimes have objections to the way things
> are implemented.

True -- I know, as I'm sure you do from your experience at t*m*s*s, why
"they" sometimes feel that way.  However, xdr (and rpc) code is
basically 25 years old or more, and little changed in implementation
over that time.  If they want an implementation that -- for instance --
avoids even the minimal use of malloc() required by the standard
implementation, they can put one in libc/sys/$arch/ (*).  But for most
systems with less draconian rules, the standard implementation should be
fine, with the addition of some possible #ifdefs around longlong,
double, and/or stdio-requiring bits.  Which shouldn't affect us.

More below.

(*) Besides, well-designed protocols based on XDR encode/decode should
specify the maximum length of "variable length" data, which in turn
allows pre-allocated storage to be used when ACTUALLY
serializing/deserializing data.  In this way, even embedded systems with
"draconian" malloc rules can guarantee that the calls to malloc()/free()
are never actually encountered in practice.  So that's really a
non-issue, IMO.

> (And I hate having to use _DEFUN in the year 2010)

Yeah, that was...icky.

> And, although it doesn't apply in this case, if I was Red Hat, I'd be
> leery about allowing major new functionality into newlib because it
> dilutes their Cygwin ownership.  How can you claim to own something like
> Cygwin when a major amount of the code is added and modified without a
> license assignment?

Ack. I'll keep that in mind in the future.

> I understand why, from a purist's point of view, someone might think
> this belongs in newlib.  I just think that adding things to newlib
> means more hoops to jump through for the Cygwin project.  I'm more
> concerned about that than I am about newlib's project definition.

Yes, I can see that if there is some problem for _cygwin_ from code in
newlib/xdr, then ultimately it would be the responsibility of the cygwin
 maintainers to "get it fixed" (not that I'm planning on getting hit by
a bus anytime soon).  If it's in winsup, then you maintainer types can
just git'er'done, but in newlib/ even you must jump thru an extra hoop.

OTOH, for xdr, this code has been around for decades and has been pretty
thoroughly vetted over that time (not by me, obviously; I take credit
for very little other than pulling it together and integrating into
newlib/). I don't think non-embedded targets, like cygwin, need to worry
much about fixing the code... unless, of course, those pesky embedded
guys break something for /us/ while trying to make it work for /them/.

If that happens and it gets too annoying, we can always copy it over to
winsup and "turn off" the newlib version for $host=cygwin.

> All of that said, however, I'll leave it up to Chuck.  I assume that
> since he's already done the work for newlib it would be a lot of extra
> work to get this into Cygwin.  I'm not going to offer any objections
> if this gets accepted to newlib.

Yeah, I think that's my first choice.  I'll wait for resolution of my
currently-pending patch at newlib, and then post the newlib bits over
there.  If Jeff shoots it down, then my second choice would be to
(re)integrate the code into winsup.  Without DEFUN()...

--
Chuck
