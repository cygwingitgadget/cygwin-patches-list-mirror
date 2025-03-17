Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id A252E3858D34; Mon, 17 Mar 2025 09:18:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A252E3858D34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1742203101;
	bh=jyCvmLgKNtxBQTO1zsHQd3Mdpdf9CwS/XZIKGpuD7RM=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=qk7C7YK1nROjEWj9DX9pgjMzhDGUSkPbi4P8+SC2dQo6fDqIigNcyUcLagNUnbYNR
	 jlz/DNXFjpuRtp91yjtq/7XaL5CiwEVxfRr0iDMCDR5DPHAQlIK2kV+MDvd2lFotli
	 UE2cVQhwvODdNC1m8EQGf6Rmuy+qxkvhgxLrSZ40=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 898D2A8077E; Mon, 17 Mar 2025 10:18:19 +0100 (CET)
Date: Mon, 17 Mar 2025 10:18:19 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Carry process affinity through to result
Message-ID: <Z9fo27vEcb39GWHc@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <https://cygwin.com/pipermail/cygwin/2025-March/257628.html>
 <20250316092247.391-1-mark@maxrnd.com>
 <af93e922-7fb4-9479-60d6-88718925d149@t-online.de>
 <2ab6322a-6195-4144-8203-4cc1c30a181e@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ab6322a-6195-4144-8203-4cc1c30a181e@maxrnd.com>
List-Id: <cygwin-patches.cygwin.com>

On Mar 16 13:55, Mark Geisert wrote:
> On 3/16/2025 7:09 AM, Christian Franke wrote:
> > Mark Geisert wrote:
> [...]
> > 
> > Could only test the single cpu group (aka single physical cpu) case
> > which is the most common, I guess. Works as expected:
> > 
> > $ uname -r
> > 3.6.0-dev-440-g5ec497dc80bc-dirty.x86_64
> > 
> > $ grep '^model name' /proc/cpuinfo | uniq -c
> >       28 model name      : Intel(R) Core(TM) i7-14700K
> > 
> > $ stress-ng --pthread 1 -v &
> > [1] 1323
> > ...
> > stress-ng: debug: [1324] pthread: [1324] started (instance 0 on CPU 10)
> > 
> > $ taskset -c -p 1324
> > pid 1324's current affinity list: 0-27
> > 
> > $ taskset -p fff0000 1324 # All E-cores
> > pid 1324's current affinity mask: fffffff
> > pid 1324's new affinity mask: fff0000
> > 
> > $ taskset -p fff5555 1324 # All cores but no HT
> > pid 1324's current affinity mask: fff0000
> > pid 1324's new affinity mask: fff5555
> > 
> > $ taskset -c -p 8,9 1324 # P-core 4 with HT
> > pid 1324's current affinity list: 0,2,4,6,8,10,12,14,16-27
> > pid 1324's new affinity list: 8,9
> > 
> > $ taskset -p 1324
> > pid 1324's current affinity mask: 300
> > 
> > The settings have the desired effect on reported core usage.
> 
> Thanks very much Christian for testing.  I want to make a minor change to
> the patch:
>     if (procmask == 0)
> will be changed to
>     if (groupcount > 1)
> to make it clearer what's going on.  I will also add a few words to both
> code comments and the patch description saying what will happen on systems
> with more than one cpu group.
> 
> It sure would be nice to test on a system with more than 64 h/w threads but
> I don't have that kind of budget ;-).
> 
> So, v2 patch incoming shortly.  Comments from other folks welcome.

Only one: Thanks for looking into this stuff!

I wonder if, after your v2 patch, it's about time to release 3.6.0.


Thanks,
Corinna
