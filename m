Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id F009F385841F; Thu, 27 Mar 2025 19:21:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F009F385841F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1743103288;
	bh=miP6/aDUp6mhDARcbX7YN1dNCCoaqdtjcfmqyjPcXOA=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=F0OwXYKrJzxXEdrrp4ZdtGMeKGD5nSXP2N6oOcPzgyY3M0ozjHEgFmowvHTmO2oRc
	 h0ffma9giD2CpOgyqPRiZk8Ami/ywTzSovoPv74s5F8ER4t89jvsO8oZ5raFzOKQ8V
	 7czXLkjhf2qn1bYoZ3PhZpHaV+uQVeMElMGwWYJ8=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 3B8E9A806F0; Thu, 27 Mar 2025 20:21:26 +0100 (CET)
Date: Thu, 27 Mar 2025 20:21:26 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 5/5] Cygwin: add find_fast_cwd_pointer_aarch64.
Message-ID: <Z-WlNgsKkE0FV1xi@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <24fa8928-2133-b73a-8c1c-28459f48b2da@jdrake.com>
 <Z-U6_zrqfandDmqr@calimero.vinschen.de>
 <f5174205-a664-44ba-f557-16d8dc61f48b@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f5174205-a664-44ba-f557-16d8dc61f48b@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Mar 27 10:28, Jeremy Drake via Cygwin-patches wrote:
> > Naah, I don't know.
> >
> > If you ask me, I would introduce a new directory aarch64 and
> > move the fastcwd_aarch64.cc file into that dir.  Then rename
> > them both to fastcwd.cc.
> >
> > Makefile.am should add the file to TARGET_FILES= for x86_64, i.e.
> >
> > If/when we later add a native aarch64 target, you should have
> > only one file aarch/fastcwd.cc, which is built into Cygwin if
> > TARGET_X86_64 and in a second block defining TARGET_FILES= for
> > TARGET_AARCH64.
> >
> > Make sense?
> 
> I am concerned about having two source files with the same basename in
> winsup/cygwin/Makefile.am.  Are you sure that won't cause any conflicts
> such as with ar or something like that?

We already have fhandler/base.cc and sec/base.cc.

Corinna
