Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id CB3CE3856DE3; Tue, 22 Jul 2025 08:45:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CB3CE3856DE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1753173900;
	bh=11nQLf1nWWzd5IaWr3Es4X+UNSuA7cNwM6MWW7zIMec=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=sI9QiVuS3udwL44CvN9S1QaQorr/8gbksmcPXEHPvnFmeoxlk8gUAFWwubSmHjryn
	 KY3+us3mANDUlcpVwsVeFWm/wgLNqjgr2fdzBjKLSotTfhrh6qWbldCQVLc0QR7gfd
	 0PmhN3rtFJXz14g9Hbo516huFdDuMzNPtKNCc8qM=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 19C61A80D00; Tue, 22 Jul 2025 10:44:59 +0200 (CEST)
Date: Tue, 22 Jul 2025 10:44:59 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Radek Barton <radek.barton@microsoft.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>,
	Jeremy Drake <cygwin@jdrake.com>
Subject: Re: [PATCH] Cygwin: mkimport: implement AArch64 +/-4GB relocations
Message-ID: <aH9Pi6bJNDa_Q7V1@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Radek Barton <radek.barton@microsoft.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>,
	Jeremy Drake <cygwin@jdrake.com>
References: <DB9PR83MB0923E3D187978CF43940B188925DA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aH4NM_WJNC2KHpHT@calimero.vinschen.de>
 <23af2767-7e76-74fd-198f-2abdee7cc73e@jdrake.com>
 <GV4PR83MB0941B168699D42E77A73814F925CA@GV4PR83MB0941.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <GV4PR83MB0941B168699D42E77A73814F925CA@GV4PR83MB0941.EURPRD83.prod.outlook.com>
List-Id: <cygwin-patches.cygwin.com>

On Jul 22 07:44, Radek Barton via Cygwin-patches wrote:
> Hello.
> 
> I understand your concern and thank you for brining it in. If I
> understand the comment at
> https://github.com/Windows-on-ARM-Experiments/newlib-cygwin/blob/woarm64/winsup/cygwin/lib/_cygwin_crt0_common.cc#L123
> correctly, this can happen when Cygwin application is linked with
> non-Cygwin stdlib. I don't know if this is a legit use-case supported
> on x64

Uh, yes and no.  You don't need to link against another stdlib, you just
have to provide your own malloc/free.  And it's a valid use-case on x64
as well.

Consider tcsh, which comes with its own malloc/free routines.  Or helper
libs like dmalloc.


Corinna
