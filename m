Return-Path: <cygwin-patches-return-5232-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6309 invoked by alias); 17 Dec 2004 03:49:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6183 invoked from network); 17 Dec 2004 03:48:57 -0000
Received: from unknown (HELO phumblet.no-ip.org) (68.163.186.67)
  by sourceware.org with SMTP; 17 Dec 2004 03:48:57 -0000
Received: from [192.168.1.156] (helo=hpn5170)
	by phumblet.no-ip.org with smtp (Exim 4.43)
	id I8ULEN-00HAW5-KK
	for cygwin-patches@cygwin.com; Thu, 16 Dec 2004 22:51:59 -0500
Message-Id: <3.0.5.32.20041216224347.0082d210@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Fri, 17 Dec 2004 03:49:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: Patch to allow trailing dots on managed mounts
In-Reply-To: <20041217032721.GA28985@trixie.casa.cgf.cx>
References: <20041217032627.GF26712@trixie.casa.cgf.cx>
 <20041216160322.GC16474@cygbert.vinschen.de>
 <41C1A1F4.CD3CC833@phumblet.no-ip.org>
 <20041216150040.GA23488@trixie.casa.cgf.cx>
 <20041216155339.GA16474@cygbert.vinschen.de>
 <20041216155707.GG23488@trixie.casa.cgf.cx>
 <20041216160322.GC16474@cygbert.vinschen.de>
 <3.0.5.32.20041216220441.0082a400@incoming.verizon.net>
 <20041217032627.GF26712@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q4/txt/msg00233.txt.bz2

At 10:27 PM 12/16/2004 -0500, Christopher Faylor wrote:
>On Thu, Dec 16, 2004 at 10:26:27PM -0500, Christopher Faylor wrote:
>>I don't see how it could be correct for the slash checking code not to
>>be "in the loop".  Won't this cause a problem if you've done
>
>Ah, nevermind.  I see that your patch handles that.
>
OK.

The key point in my patch is that it's the output Win32 path
that must be checked, not the input path.
The reason we don't care about the input path is that check()
only makes simple Windows calls. They handle the tails as they
judge best (and that worked OK until NtCreateFile was introduced),
we don't have to do anything special.

We want to fix the output path (only for real disk files
that are  not escaped with //./) so that:
1) NtCreateFile mimics the Windows rules
2) the path hash is invariant to the path tail
3) chdir something/....... is prevented

Pierre
