Return-Path: <cygwin-patches-return-4153-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21709 invoked by alias); 31 Aug 2003 20:52:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21700 invoked from network); 31 Aug 2003 20:52:02 -0000
Message-Id: <3.0.5.32.20030831164810.008161c0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sun, 31 Aug 2003 20:52:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: Signal handling tune up.
In-Reply-To: <20030831202150.GA7225@redhat.com>
References: <3.0.5.32.20030831161147.008294d0@incoming.verizon.net>
 <3.0.5.32.20030819084636.0081c730@incoming.verizon.net>
 <20030819143305.GA17431@redhat.com>
 <3F43B482.AC7F68F4@phumblet.no-ip.org>
 <3.0.5.32.20030828205339.0081f920@incoming.verizon.net>
 <20030829011926.GA16898@redhat.com>
 <20030829031256.GA18890@redhat.com>
 <3F4F60EA.4DBB8A51@phumblet.no-ip.org>
 <3.0.5.32.20030830152207.007bde60@incoming.verizon.net>
 <3.0.5.32.20030831112352.008161c0@incoming.verizon.net>
 <3.0.5.32.20030831161147.008294d0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q3/txt/msg00169.txt.bz2

At 04:21 PM 8/31/2003 -0400, you wrote:
>>>Ok.  I see what you mean but the old code was not actually right either.
>>>I wrote a test case (enclosed) which sent a signal to a process running
>>>a modified version of cygwin1.dll after the call to sigframe
>>>("guaranteed" with the judicious use of Sleep) in sig_dispatch_pending.
>>>The 'ouch' wasn't triggered by the either the old or new cygwin code.
>>>So, I've checked in new code in sig_dispatch_pending.
>>
>>Why would the ouch be triggered? The parent is long dead when
>>the child kills its ppid, which by that time is 1.
>
>`a modified version of cygwin1.dll...  ("guaranteed" with the judicious
>use of Sleep)'
>

Sorry I misunderstood. Exactly where did you add a Sleep?

Pierre
