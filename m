Return-Path: <cygwin-patches-return-2853-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 12564 invoked by alias); 21 Aug 2002 23:36:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12547 invoked from network); 21 Aug 2002 23:36:19 -0000
Message-ID: <00ae01c2496b$eba3e3f0$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <017501c24948$aa02fa30$6132bc3e@BABEL>
Subject: Re: recv/send revert patch
Date: Wed, 21 Aug 2002 16:36:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00301.txt.bz2

"Conrad Scott" <Conrad.Scott@dsl.pipex.com> wibbled on at length:
> Attached is a patch to revert the recv/send patch I submitted a
> couple of weeks ago.  This doesn't revert the whole patch, just
> those parts related to using recvfrom/sendto calls to implement
> recv/send.

And please *don't* apply this patch!  The code is fine as I had
it, the problem is one that needs to be fixed elsewhere.  The
problem isn't even introduced by my patch, altho' it is related to
using sendto(2) when send(2) might be better.

The issue (in both NT4.0 and win98SE at least) concerns an
interaction between sendto(2) and connect(2) on connection-less
sockets.  I think the NT4.0 behaviour may be strictly correct (or
at least, allowed by SUSv3) but it doesn't match win2k's behaviour
nor that of most other socket implementations (e.g. Linux and
FreeBSD).

If you call connect(2) on a connection-less socket, it sets the
peer address for future recv(2) and send(2) calls on that socket.
The question is what then happens if you call sendto(2) w/ an
explicit address on such a "connected" connection-less socket.
Most implementations (including win2k etc.) ignore the address,
but on win98SE and NT4.0 (at least) you get a EISCONN error.

I'll have another look at this but I think the best thing to do
might be to put a minor patch into the code to avoid the error,
i.e. if the socket has been connected, don't pass on the address
parameters for sendto(2), just pass NULL etc..  A strictly
conforming application can't expect any particular result in that
situation (since SUSv3 doesn't actually mention it), so it
wouldn't be non-conforming and it would allow sloppily written
programs (like my test program?) to run correctly.

Summary: don't apply this patch please, and I'll provide a simple
patch to get around the real problem.

Of course, nothing but my weird test program is ever to going to
check this behaviour: if any ported application had tried to use
this, the "bug" would presumably have been reported on the cygwin
list and there is not a whisper of anything about this issue.  So
I'm panicking about practically irrelevant details again :-(  But
what the hell, I'm good at panicking :-)

// Conrad


