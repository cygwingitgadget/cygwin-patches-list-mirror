Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id E16B359EAE0D; Tue,  9 Dec 2025 10:16:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E16B359EAE0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1765275397;
	bh=kqkxveuI5ExvFretiyfgywzFFeXmm+qxkcMbt0s4MOI=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=xXrtl5BsnezAL1d3Oj0cW0z/+LRtEyzmTWiVbFVIak9NqZ6ppl8JZLYRwr1N5t/ca
	 niPMA++4v0lw2AMSo9ExfLi0is57f8DfkvaBZvpvGNwBTqsGLqk1u0Cb99b6Ak2Cuf
	 nrgHGtqLfjamk7fsYyjEJV5I0KNj/p3zsmW7sV+E=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 16BA2A80BA1; Tue, 09 Dec 2025 11:16:36 +0100 (CET)
Date: Tue, 9 Dec 2025 11:16:36 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/3] Cygwin: newgrp(1): improve POSIX compatibility
Message-ID: <aTf3BPKzr6ChHpdA@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20251205194200.4011206-1-corinna-cygwin@cygwin.com>
 <20251205194200.4011206-2-corinna-cygwin@cygwin.com>
 <9f4ccea4-95c9-481d-93ca-9d1e5ae31de3@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9f4ccea4-95c9-481d-93ca-9d1e5ae31de3@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Dec  6 11:56, Jon Turney wrote:
> On 05/12/2025 19:41, Corinna Vinschen wrote:
> > +	  fprintf (stderr, "Usage: %s [-] [group]\n",
> 
> Maybe '[-|-l]'?

The usage message is the same as used by the shadow-utils newgrp
on Linux.  It supports -l, but doesn't print it for some reason.

If you think we should do it better, I can change our usage output
and send a v2 patch, no worries.

> > +		   program_invocation_short_name);
> > +	  return 1;
> > +	}
> >         new_child_env = true;
> >         --argc;
> >         ++argv;
> > @@ -165,8 +165,16 @@ main (int argc, const char **argv)
> >       }
> >     else
> >       {
> > -      gr = getgrnam (argv[1]);
> > -      if (!gr)
> > +      char *eptr;
> > +
> > +      if ((gr = getgrnam (argv[1])) != NULL)
> > +	/*valid*/;
> > +      else if (isdigit ((int) argv[1][0])
> > +	       && (gid = strtoul (argv[1], &eptr, 10)) != ULONG_MAX
> > +	       && *eptr == '\0'
> > +	       && (gr = getgrgid (gid)) != NULL)
> 
> I spent a bit of time worrying how this handled edge cases like '' or '0',
> but I think it's all good!

Thanks for checking!


Corinna
