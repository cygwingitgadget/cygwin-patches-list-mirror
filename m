Return-Path: <cygwin-patches-return-5128-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21353 invoked by alias); 14 Nov 2004 18:28:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21335 invoked from network); 14 Nov 2004 18:28:52 -0000
Received: from unknown (HELO phumblet.no-ip.org) (68.163.170.214)
  by sourceware.org with SMTP; 14 Nov 2004 18:28:52 -0000
Received: from [192.168.1.156] (helo=hpn5170)
	by phumblet.no-ip.org with smtp (Exim 4.43)
	id I76M5B-005ETN-FU
	for cygwin-patches@cygwin.com; Sun, 14 Nov 2004 13:31:59 -0500
Message-Id: <3.0.5.32.20041114132359.00829ca0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sun, 14 Nov 2004 18:28:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch] Fixing the PROCESS_DUP_HANDLE security hole.
In-Reply-To: <20041114180354.GB13076@trixie.casa.cgf.cx>
References: <3.0.5.32.20041114123430.008289b0@incoming.verizon.net>
 <3.0.5.32.20041111235225.00818340@incoming.verizon.net>
 <3.0.5.32.20041111224857.00819b20@incoming.verizon.net>
 <3.0.5.32.20041111224857.00819b20@incoming.verizon.net>
 <3.0.5.32.20041111235225.00818340@incoming.verizon.net>
 <3.0.5.32.20041114123430.008289b0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q4/txt/msg00129.txt.bz2

At 01:03 PM 11/14/2004 -0500, Christopher Faylor wrote:
>On Sun, Nov 14, 2004 at 12:34:30PM -0500, Pierre A. Humblet wrote:
>>At 12:11 AM 11/14/2004 -0500, Christopher Faylor wrote:
>
>>BTW, have you ever tried using select, having a connection from the
>>parent to the child?
>
>select involves polling or setting up other events to track end-of-pipe
>conditions.  I don't think that's a win.

I meant the Windows select, on sockets.

>>>When I get the code to a point that it can run configure, I'll do a
>>>benchmark and see how bad this technique is.  If there is not a
>>>noticeable degradation, I think I'll probably duplicate the scenario of
>>>last year and checkin this revamp which, I believe will eliminate the
>>>security problem that you were talking about.
>>
>>There is also the case where a setuid child needs to signal its parent.
>>That's another use of my ppid_waitsig, avoiding the PROCESS_DUP_HANDLE
>>issue.
>>Could your "end of pid" pipe be used to transmit signals, with the reader
>>thread forwarding the sigpacket to the local sigthread?
>
>It could but that's not its intent.  It's used now to transmit stop/continue
>state but if you need to send a signal from parent to child, I don't think
>it makes sense to relay it through this mechanism.

Then something else is needed. An advantage of the relay is that it could
allow only stop/continue to pass through. The ppid_waitsig lets all signals
go through.

Pierre
