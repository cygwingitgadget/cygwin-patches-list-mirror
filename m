Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 34F484BA2E1D; Fri, 19 Dec 2025 11:11:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 34F484BA2E1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1766142684;
	bh=SVatDRrsw46DleM075DKBzvTIRlSJTO/sS3MAsUwBk4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Ruw8jNsnPBUPbQfSICU4rJLwZZC8gNPZlAELZ/F1pZ98aB2UYsXa+HCU6C7ycz2nL
	 riOT2NbQHl16JR/poAxSZrGR2yYwaI7/Bzgjv0PD44qkx+vHKzF1iSjxzh0l486EtL
	 j1XpwrOA3IkVqlDWLn8J/+yn0NWXvuy/MYip65Lo=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 4CCE9A80BEF; Fri, 19 Dec 2025 12:11:22 +0100 (CET)
Date: Fri, 19 Dec 2025 12:11:22 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Thomas Wolff <towo@towo.net>
Cc: cygwin-patches@cygwin.com
Subject: Re: Unicode 17.0 updates: build scripts and data tables
Message-ID: <aUUy2isLSmhFR9b0@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Thomas Wolff <towo@towo.net>, cygwin-patches@cygwin.com
References: <88d56dc4-1fb6-478b-8cf0-219313f52281@towo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <88d56dc4-1fb6-478b-8cf0-219313f52281@towo.net>
List-Id: <cygwin-patches.cygwin.com>

Hi Thomas,

thanks for the patches.  Three problems...

- The patches should ideally go to the newlib mailing list

- The patches are in `git show' format, not in `git format-patch'
  format, so they can't be applied via `git am'.

- The commit message doesn't contain an empty line to split the
  message into a summary line and the body, as in...

On Dec 19 11:58, Thomas Wolff wrote:
>     Unicode table build: update scripts for generation of width data to recent changes in Unicode.org data file layout

  --- SNIP ---
  Update scripts creating unicode tables
                                           <- Line 2 empty!
  Unicode.org data file layout changed,
  yada yada yada
  -- SNAP ---


Thanks,
Corinna
