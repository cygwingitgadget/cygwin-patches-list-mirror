Return-Path: <cygwin-patches-return-5122-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4182 invoked by alias); 12 Nov 2004 04:41:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3922 invoked from network); 12 Nov 2004 04:41:20 -0000
Received: from unknown (HELO phumblet.no-ip.org) (68.163.170.214)
  by sourceware.org with SMTP; 12 Nov 2004 04:41:20 -0000
Received: from [192.168.1.156] (helo=hpn5170)
	by phumblet.no-ip.org with smtp (Exim 4.43)
	id I71UHY-002ZFP-KL
	for cygwin-patches@cygwin.com; Thu, 11 Nov 2004 23:44:22 -0500
Message-Id: <3.0.5.32.20041111233632.00811470@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Fri, 12 Nov 2004 04:41:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch] Fixing the PROCESS_DUP_HANDLE security hole.
In-Reply-To: <20041112042412.GC21129@trixie.casa.cgf.cx>
References: <3.0.5.32.20041111224857.00819b20@incoming.verizon.net>
 <3.0.5.32.20041111224857.00819b20@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q4/txt/msg00123.txt.bz2

At 11:24 PM 11/11/2004 -0500, Christopher Faylor wrote:
>On Thu, Nov 11, 2004 at 10:48:57PM -0500, Pierre A. Humblet wrote:
>>P.S.: I have no news about the recent patch to /bin/kill -f
>
>That is because I was sure that I'd used 'kill -f' to kill windows pids
>in the past and wanted to check your patch.  I haven't been near a
>WinMe system in a while, though.  My vmware version isn't working
>currently.

Funny, I had the same feeling. But this is what happens now:

~: ps
      PID    PPID    PGID     WINPID  TTY  UID    STIME COMMAND
   606855       1  606855 4294360441  con  740 23:06:35 /c/PROGRAM
FILES/CYGWIN/BIN/RXVT
   537691  606855  537691 4294504569    0  740 23:06:36 /c/PROGRAM
FILES/CYGWIN/BIN/BASH
   460171  537691  460171 4294214685    0  740 23:24:07 /c/PROGRAM
FILES/CYGWIN/BIN/PS
~: /bin/kill -f 4294504569
couldn't open pid 2147483647

2147483647 = 0x7FFFFFFF, due to strtol saturating.


I just researched the ChangeLog and found a possible cause:
2003-09-20  Christopher Faylor  <cgf@redhat.com>

        * kill.cc (main): Allow negative pids (indicates process groups).

Another complication is due to
#define CW_NEXTPID 0x80000000      /* or with pid to get next one */

Pierre

