Return-Path: <cygwin-patches-return-4155-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2478 invoked by alias); 31 Aug 2003 21:38:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2469 invoked from network); 31 Aug 2003 21:38:54 -0000
Message-Id: <3.0.5.32.20030831173427.00826100@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sun, 31 Aug 2003 21:38:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: Signal handling tune up.
In-Reply-To: <20030831210627.GA10412@redhat.com>
References: <3.0.5.32.20030831164810.008161c0@incoming.verizon.net>
 <20030819143305.GA17431@redhat.com>
 <3F43B482.AC7F68F4@phumblet.no-ip.org>
 <3.0.5.32.20030828205339.0081f920@incoming.verizon.net>
 <20030829011926.GA16898@redhat.com>
 <20030829031256.GA18890@redhat.com>
 <3F4F60EA.4DBB8A51@phumblet.no-ip.org>
 <3.0.5.32.20030830152207.007bde60@incoming.verizon.net>
 <3.0.5.32.20030831112352.008161c0@incoming.verizon.net>
 <3.0.5.32.20030831161147.008294d0@incoming.verizon.net>
 <3.0.5.32.20030831164810.008161c0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q3/txt/msg00171.txt.bz2

At 05:06 PM 8/31/2003 -0400, you wrote:
>On Sun, Aug 31, 2003 at 04:48:10PM -0400, Pierre A. Humblet wrote:
>>Sorry I misunderstood. Exactly where did you add a Sleep?
>
>In sig_dispatch_pending after the sigframe.

sig_dispatch_pending wasn't meant for that (unlikely when no 
Sleep) case.

During the Sleep, the sigthread will setup the interrupt in
sigsave (spoofing the first interruptible address, e.g.
the return from write) but it will not set pending_signals.
Thus sig_dispatch_pending won't send SIGFLUSH.

sig_dispatch_pending was meant for the case where the sigthread
had been unable to interrupt, e.g. because it couldn't catch
the mainthread in an interruptible state (without a sigframe),
before the call to sig_dispatch_pending.

Huh, I should have reupdated cvs. You have already done the right
thing to handle this kind of event. 

Pierre
