Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 8458D3858CDB; Mon, 31 Mar 2025 08:19:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8458D3858CDB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1743409161;
	bh=2WmY5SN3VRC+RuYJD8RMlLFpEGFkJ1TQYrxv3EAndbA=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=bPWlL33D12SPFVzdXkMQ/DGic67uB8rI7VgBmsAR2/4z6F2G/69BfeaOhCHlaDMIK
	 jzKtu1kCgnMKSC8Lc0HHnTLXt1RwiNgRSAXQ65+Jplmz6TV/vTLcgNtEYyKaQ9briJ
	 4mKA6YdSL14Ie08aPJJCoH/iq4/LXLll2Umc/HOQ=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 5DDF0A80A71; Mon, 31 Mar 2025 10:19:19 +0200 (CEST)
Date: Mon, 31 Mar 2025 10:19:19 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 0/5] find_fast_cwd_pointer rewrite
Message-ID: <Z-pQB1d2It9jkuFS@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <56da8997-5d48-dfb7-8a41-b3fa6ccfbecc@jdrake.com>
 <bd7bc794-7a50-228f-4f9e-a34a02fd12f6@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bd7bc794-7a50-228f-4f9e-a34a02fd12f6@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Mar 30 19:45, Jeremy Drake via Cygwin-patches wrote:
> On Sat, 29 Mar 2025, Jeremy Drake via Cygwin-patches wrote:
> 
> >     ++#if defined (__i386__)
> >      +  static const BYTE thunk[] = "\x8b\xff\x55\x8b\xec\x5d\x90\xe9";
> >     -+#elif defined(__x86_64__)
> >     ++  static const BYTE thunk2[0];
> >     ++#elif defined (__x86_64__)
> >      +  /* see
> >      +     https://learn.microsoft.com/en-us/windows/arm/arm64ec-abi#fast-forward-sequences */
> >      +  static const BYTE thunk[] = "\x48\x8b\xc4\x48\x89\x58\x20\x55\x5d\xe9";
> >     ++  /* on windows 11 22000 the thunk is different than documented on that page */
> >     ++  static const BYTE thunk2[] = "\x48\x8b\xff\x55\x48\x8b\xec\x5d\x90\xe9";
> 
> I noticed that in 22000 the x86_64 "thunk" is the same as the i386 one had
> been in every version I tested, except with the 0x48 "REX" prefix added
> to two of the instructions.
> I guess they found a different sequence had better compatibility with API
> hooking software.
> 
> I just did some wandering on the internet and came across someone who
> seems to confirm this:
> 
> http://www.emulators.com/docs/abc_arm64ec_explained.htm#FFS
> > This sequence is not the original FFS we shipped in Windows 11 SV1
> > (build 22000) back in 2021.  We had a simpler sequence but as it turned
> > out this broke some video games because we used x64 instructions that
> > their hotpatchers were not used to seeing.  After a constructive email
> > exchange with the folks at Valve we zeroed in on this much more
> > compatible code sequence.  Pro tip: This is why Windows 11 SV2 (build
> > 22621) is the minimum version of Windows on ARM you should be using your
> > ARM64 device.  If your device came with build 22000 or even Windows 10
> > build 19041, or you are building using a Windows SDK prior to build
> > 22621, upgrade it!

Huh, so 22000 is actually kind of a dead duck.

Jeremy, I don't think you have push perms to the Cygwin repo.

If you want to push your own patches and are willing to review patches
on this list occassionally (especially when I'm on one of my longish
vacations), see the handy dandy little form at
https://sourceware.org/cgi-bin/pdw/ps_form.cgi

Project should be Cygwin, approver is my email address I'm using in
the Cygwin logs.

In terms of the current patchset, just tell me if you want to use it
as test of your new rights on sware, or if I should push it for you.


Thanks,
Corinna
