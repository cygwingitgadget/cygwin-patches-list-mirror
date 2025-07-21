Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 7642E3858D1E; Mon, 21 Jul 2025 13:46:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7642E3858D1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1753105587;
	bh=NDo7PxbuRlHAYNhPEJETR4f8M0BPG4UP1vkZ3eSZEfw=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=Vnj5KWs9TJv963k5Pb+TnLpi7nNBkvLbRVZGZ/3RMg7XplyCs9Y8vQsrcYJ9NFmUb
	 cPOCY2EuvVrGK8OL7ZWfkgN8pRI6zczUWCToS+CAhBSd4jKCNPuFqyCVKD5PcyDLAY
	 kvSf6itgd0Pord4NBkujKb8bH8gzV+3T1EApVMAA=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C6871A80DCD; Mon, 21 Jul 2025 15:46:25 +0200 (CEST)
Date: Mon, 21 Jul 2025 15:46:25 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: malloc_wrapper: port to AArch64
Message-ID: <aH5EsVT1Hhe_7yHV@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <DB9PR83MB092300A5FEDFB941EEB3F5969248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aHUEhDwuvRmJVZ1X@calimero.vinschen.de>
 <aHUFzEEGq448gvZ0@calimero.vinschen.de>
 <bd64e817-ffa8-4299-a3bc-6d1ff691ca9b@dronecode.org.uk>
 <aH5CvWENvjsmKbjJ@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aH5CvWENvjsmKbjJ@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

On Jul 21 15:38, Corinna Vinschen wrote:
> On Jul 21 14:15, Jon Turney wrote:
> > If Radek is going to be adding Signed-off: lines of behalf of his
> > colleagues, maybe this is an appropriate place to ask what he thinks he's
> > attesting to with it?
> > 
> > 
> > Corinna,
> > 
> > Maybe the "Before you get started" section in [1] should mention Signed-off:
> > and what we think it means?
> 
> That's a good point.
> 
> dll.html is outdated.  We don't use the CONTRIBUTORS file anymore.  It
> was a remnant of the past, when we switched our license and we still
> needed to keep track of the developers and the 2-clause BSD rule while
> long-living contracts with the old buyout license were still active.

On second thought, I think we should rename the file to
PAST_CONTRIBUTORS and prepend some lines that we switched to the
Developer Certificate of Origin, pointing to dll.html...

> These days, I would like to enforce the Signed-off-by: line and it
> should have the same place and same significance as in the Linux kernel,
> that is...
> 
>   https://developercertificate.org/
> 
> Briefly, the sign-off means, that the contributor has, both, the right
> and the willingness, to contribute code to this project under the
> project's open source license, i.e., GPL v3+ in case of Cygwin.
> 
> > If we really want it to be mandatory, I guess I could explore the
> > possibility of a push hook to enforce that?
> > 
> > [1] https://cygwin.com/contrib/dll.html

...and dll.html should be written anew from the pararaph starting
with "If your change is going to be a significant one"... by just
stating that we expect a Developer Certificate of Origin per
https://developercertificate.org/, i.e., a "Signed-off-by:" line
per patch.


Does that sound about right?


Thanks,
Corinna


> Yeah, but there's one twist: We don't and can't enforce Signed-off-by:
> lines in case of contributions to newlib.  Newlib is not under GPL.
> Rather it's a collection of multiple open source licenses.  So in case
> of newlib the meaning of a signed-off is rather fuzzy.
> 
> Therefore we only can enforce contributions to Cygwin code and docs.
> 
> 
> Corinna
