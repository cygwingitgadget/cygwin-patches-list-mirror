Return-Path: <cygwin-patches-return-2450-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18030 invoked by alias); 17 Jun 2002 21:09:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17989 invoked from network); 17 Jun 2002 21:09:34 -0000
Message-ID: <032601c21643$81228be0$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <003c01c213f3$2ed077f0$6132bc3e@BABEL> <005801c213f6$ab0e2a30$6132bc3e@BABEL> <20020615010600.GB5699@redhat.com> <005b01c21465$b97a07f0$0100a8c0@advent02>
Subject: Re: Mount interaction with /dev & /proc entries
Date: Mon, 17 Jun 2002 14:09:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00433.txt.bz2

"Chris January" <chris@atomice.net> wrote:
> Well, when I was writing the /proc stuff, I wrote it on the premise
there
> was an imaginary proc filesystem mounted a /proc. This means if you
chroot,
> that filesystem won't be mounted at /proc anymore and hence it is
correct
> that /proc doesn't work. i.e. the path handling is done with mount
points in
> mind.

I'm sympathetic to this approach and I realised it was deliberate -- I
should have addressed you directly on this: sorry about that, I
(wrongly) assume that most of the DLL code is the sole interest of the
good folks at RedHat rather than any of the contributors.

Anyhow, I was thinking more that while the mount system is as it is
now (i.e. you've no choice about where the /proc vfs is "mounted"),
it's either going to remain or disappear when someone's chroot'ed.
Since then it can be done "right" at the moment, I thought it would be
better at least to be consistent :-) i.e. make it the same as /dev,
the only other vfs. But since my patch was broken, it's all a bit
academic :-(

> I would argue, as Chris F has suggested above, that this is best
left for
> the re-write of the mount stuff.

I'm happily agreeing with both Chris F and yourself that this is best
left for that re-write, then it can be done "right".

Cheers,

// Conrad


