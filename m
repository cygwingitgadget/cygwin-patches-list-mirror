Return-Path: <cygwin-patches-return-3845-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13905 invoked by alias); 4 May 2003 09:52:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13896 invoked from network); 4 May 2003 09:52:13 -0000
From: "Chris January" <chris@atomice.net>
To: <cygwin-patches@cygwin.com>
Subject: RE: hostid patch
Date: Sun, 04 May 2003 09:52:00 -0000
Message-ID: <ICEBIHGCEJIPLNMBNCMKOEHHCFAA.chris@atomice.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
In-Reply-To: <20030430013844.GA21521@redhat.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-SW-Source: 2003-q2/txt/msg00072.txt.bz2

> On Wed, Apr 30, 2003 at 11:04:43AM +1000, Robert Collins wrote:
> >On Wed, 2003-04-30 at 11:00, Christopher Faylor wrote:
> >
> >> Three runs, two different results:
> >
> >I count three runs, three result there.
>
> Hmm.  You're right.  I thought the last two hostids were the same but
> they obviously weren't.
>
> >Interestingly, the PSN was different on every case..
>
> Running under strace the PSN stayed the same for a long time.  I thought
> it was going to be one of those "runs fine under strace" scenarios.
>
> >Is this a real box, or VMWare / bochs etc?
>
> It's an FreeBSD box running VMWare, running linux.  I'm running
> cygwin under
> wine on linux.  I can't see how that could be a problem. :-)
>
> >How many cpus are in it?
>
> cygcheck attached.  Hmm.  Cygcheck doesn't say how many CPUs, does it?
>
> /proc/cpuinfo attached, too.
>
> Two CPUs.  Different steppings for each.  The Dell BIOS kindly informs
> me of that fact on each reboot.

I neglected to set the Thread affinity when I got the CPU serial number, so
it gets a different number for each CPU. As to why the last two values are
off by five - I can't explain that without delving into the sources. I can't
do that until I install Cygwin on my new machine.

Chris
