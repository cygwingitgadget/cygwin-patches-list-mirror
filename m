Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 4C6A73858019; Tue, 10 Dec 2024 13:23:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4C6A73858019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1733837018;
	bh=UvS8usSjif5XyUVpR69Cmr+Y9faBhmFWSbxp+HE4lhU=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=mBgrbFc7p5RNbWVwmM4shgetYCjQO6FmM43XoqRN9+4OWRRNMgZEiQ7HMamAI6+6F
	 EtMxo9f0vgi0xYrxIEb5YK/pfYJkhS4COr2N397/BRyIvJuQ356EnIvBbh9XNs0yE4
	 oKlLqFiiuxXdzaMlf8/xoB670t2CNkztxZyfMwAo=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 1600FA8093F; Tue, 10 Dec 2024 14:23:36 +0100 (CET)
Date: Tue, 10 Dec 2024 14:23:36 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: SMBFS mount's file cannot be made executable
Message-ID: <Z1hA2KFehQjXi3Wp@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241119175806.321cdb7e65a727a2eb58c8a6@nifty.ne.jp>
 <Zzz7FJim9kIiqjyy@calimero.vinschen.de>
 <20241208081338.e097563889a03619fc467930@nifty.ne.jp>
 <Z1bQfIgv7MIDL1fB@calimero.vinschen.de>
 <20241209224400.978983b35ac2b5e5ebc35ef2@nifty.ne.jp>
 <20241209225759.9c71db3a2dcbafe0b4769a7b@nifty.ne.jp>
 <Z1cMPRDvfIqZAsL3@calimero.vinschen.de>
 <20241210212140.dcdaec01428393465929dc59@nifty.ne.jp>
 <Z1g7hVhAbbfnnmR5@calimero.vinschen.de>
 <20241210221057.6e9edf37a27b8fc2777bc9e4@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241210221057.6e9edf37a27b8fc2777bc9e4@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Dec 10 22:10, Takashi Yano wrote:
> On Tue, 10 Dec 2024 14:00:53 +0100
> Corinna Vinschen wrote:
> > diff --git a/winsup/cygwin/local_includes/path.h b/winsup/cygwin/local_includes/path.h
> > index 3dd21d975abf..2a05cf44d40a 100644
> > --- a/winsup/cygwin/local_includes/path.h
> > +++ b/winsup/cygwin/local_includes/path.h
> > @@ -323,7 +323,7 @@ class path_conv
> >    }
> >    inline POBJECT_ATTRIBUTES init_reopen_attr (OBJECT_ATTRIBUTES &attr, HANDLE h)
> >    {
> > -    if (has_buggy_reopen ())
> > +    if (!h || has_buggy_reopen ())
> >        InitializeObjectAttributes (&attr, get_nt_native_path (),
> >  				  objcaseinsensitive (), NULL, NULL)
> >      else
> > -- 
> > 2.47.0
> > 
> 
> Thanks! Is your patch better than?
> +  if (pc.handle ())
> +    pc.init_reopen_attr (attr, pc.handle ());
> +  else
> +    pc.get_object_attr (attr, sec_none_nih);

Well, it fixes the problem once and for all, without having to
add a conditional in multiple places.


Corinna
