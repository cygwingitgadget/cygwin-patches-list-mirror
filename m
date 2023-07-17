Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 7F7E03858C2A; Mon, 17 Jul 2023 14:22:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7F7E03858C2A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1689603758;
	bh=KYGfkhKl5uRouNwW9qju/hfhtYDagxCDW0trcytO7O4=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=QAxk9/EjaGUiGXH9enBSh9ghW5vTZEPMXUmlivWXNsqKmC0QQUO6Vf7/k0HkMT2ZH
	 gE+iz9kFGSyC+5HaVg3V7wYsmS0ekVZa8rtUdQA9ggOhT/0992ACj45tRoTn1Uxkl6
	 bC3RcJ8HMa3qvc8P3W/yiBmL3GAve/uetFEGbLyU=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 70E43A80BB0; Mon, 17 Jul 2023 16:22:36 +0200 (CEST)
Date: Mon, 17 Jul 2023 16:22:36 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 08/11] Cygwin: testsuite: Busy-wait in cancel3 and cancel5
Message-ID: <ZLVOrD44M3gCLC0j@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
 <20230713113904.1752-9-jon.turney@dronecode.org.uk>
 <ZLA/j6L/tPcqHiG7@calimero.vinschen.de>
 <ZLBEajmAonZGmsqx@calimero.vinschen.de>
 <ZLBIJTlbCtRvYlU9@calimero.vinschen.de>
 <5aa21952-a13d-f304-8b63-18ee4885c308@dronecode.org.uk>
 <8a504ebe-9ce0-867a-f1a3-f38411129019@dronecode.org.uk>
 <ZLVKU26aNI5oKpQF@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZLVKU26aNI5oKpQF@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

On Jul 17 16:04, Corinna Vinschen wrote:
> On Jul 17 12:51, Jon Turney wrote:
> > Perhaps there is a better way to write a test that async cancellation works
> > in the absence of cancellation points, but it eludes me...
> 
> Same here, so just go ahead.

Actually, it's not just that.  I think this is the right thing to do.


Corinna
