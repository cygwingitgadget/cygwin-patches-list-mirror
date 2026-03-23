Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 70B0D4BAD177; Mon, 23 Mar 2026 08:44:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 70B0D4BAD177
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1774255471;
	bh=hqHkGFwdXtZJTJsuCfAjVCUDRES/gViUKteS9CJbli4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=i4VYkBSuVnsZRXN5Y01+uLc/JEjNdht9vP56cAy8Wz61lCKAUmeH13JMMDDWUWrLF
	 iwdDye0RahL1SYL8oenZeQF0qc8JUYHsRUeqo6FDwzK2MJiMLTh1aFo6yvbWakN0m6
	 nS8oSmBiUZcyQ20q8E3Dl9pAGA32MmLPPioL9vpA=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id E2B48A80936; Mon, 23 Mar 2026 09:44:28 +0100 (CET)
Date: Mon, 23 Mar 2026 09:44:28 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Igor Podgainoi <Igor.Podgainoi@arm.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>,
	nd <nd@arm.com>
Subject: Re: [PATCH v2 1/1] Cygwin: SEH: Fix crash and handle second unwind
 phase on AArch64
Message-ID: <acD9bNOqacDnRPSi@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Igor Podgainoi <Igor.Podgainoi@arm.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>,
	nd <nd@arm.com>
References: <cover.1771414249.git.igor.podgainoi@arm.com>
 <c4f8c7507e38602ef2935a8dbafe7409a63377ad.1771414249.git.igor.podgainoi@arm.com>
 <aZWrI3WPFRqj7P_j@arm.com>
 <abGAGofEMp7sikvK@calimero.vinschen.de>
 <ab1fpH4XEFR8FEEU@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ab1fpH4XEFR8FEEU@arm.com>
List-Id: <cygwin-patches.cygwin.com>

Hi  Igor,

On Mar 20 14:54, Igor Podgainoi wrote:
> Hello Corinna,
> 
> On Mar 11 14:45, Corinna Vinschen wrote:
> > On Feb 18 12:05, Igor Podgainoi wrote:
> > > Subject: [PATCH v2 1/1] Cygwin: SEH: Fix crash and handle second unwind phase
> > >  on AArch64
> > > 
> > > This patch adds the definition of the TRY_HANDLER_DATA macro for
> > > the AArch64 architecture, as well as makes modifications to the
> > > exception handler responsible for the __try/__except blocks.
> > 
> > This patch is puzzeling me.  We don't have a TRY_HANDLER_DATA macro
> > for x86_64, and what you're adding below looks like the __try macro.
> 
> Thanks for taking a look.
> 
> In the cover letter I mentioned two dependent patches; one of them
> introduces TRY_HANDLER_DATA, which this change relies on.

Ok, but these patches have been marked as "work-in-progress and not yet
ready for upstream review".  If you'd like to introduce this patch, the
original patches have to put up for review and merging first.

Alternatively you provide a patch without TRY_HANDLER_DATA and tweak
it in a later patch together with introducing TRY_HANDLER_DATA.


Thanks,
Corinna
