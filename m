Return-Path: <cygwin-patches-return-2280-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 29634 invoked by alias); 1 Jun 2002 22:50:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29620 invoked from network); 1 Jun 2002 22:50:54 -0000
Message-ID: <07ee01c209be$f395c430$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <06eb01c209b9$11c491d0$6132bc3e@BABEL> <20020601223846.GB8326@redhat.com>
Subject: Re: strace -f fix
Date: Sat, 01 Jun 2002 15:50:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00263.txt.bz2

"Christopher Faylor" <cgf@redhat.com> wrote:
> On Sat, Jun 01, 2002 at 11:09:57PM +0100, Conrad Scott wrote:
> >I've been playing around with the strace program some more and noticed a
> >minor glitch: it's only meant to trace forked children if the -f flag is
> >given on the command line. Unfortunately it currently always traces
> >children, and the this flag has no effect.
>
> What are you trying to fix?  AFAICT, the -f option is working correctly.

Well, it doesn't work on my machine without the patch I sent in. That is,
strace *always* traces child processes for me regardless of the -f flag.
This is true of both the last release (1.3.10) and the current cvs source.
I've also got a test program that shows exactly the same behaviour unless
the CreateProcess() debug flags are used as per the patch I appended to the
last email message. And I've checked that that patch does change the
behaviour of strace with child processes (for me, on my machine, etc.).

If it's working for you, I'm not quite sure where that leaves us: I'm
running w2k (w/ latest service packs etc.), on a Pentium something-or-other
box, nothing too wacky.

Have you any idea? I'm befuddled now.

// Conrad

