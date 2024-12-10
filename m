Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 62AC7385842C; Tue, 10 Dec 2024 13:39:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 62AC7385842C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1733837965;
	bh=3c4oqP4YEzzBsbvqmc86QeZ9duhvgQaPRyIkGL7etuU=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=myPMoqwr+YSOOMFc9OJvDY4p5l5uiQjioL4c2CNVoQkRQalp5b3vT6eCwFoDgX1jk
	 i9ylaOtUW1N8PbM5YDkblEpM+dJJR3Q7YvVg2qjaLg5qbqHqToXAnLOuKwwqfut7nH
	 Pme/ijyOV9rx16X3lkPG9cWq9QzH7k/uPMgFOQdE=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id E6ACDA80451; Tue, 10 Dec 2024 14:39:22 +0100 (CET)
Date: Tue, 10 Dec 2024 14:39:22 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: SMBFS mount's file cannot be made executable
Message-ID: <Z1hEimJXtOwr76G_@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241208081338.e097563889a03619fc467930@nifty.ne.jp>
 <Z1bQfIgv7MIDL1fB@calimero.vinschen.de>
 <20241209224400.978983b35ac2b5e5ebc35ef2@nifty.ne.jp>
 <20241209225759.9c71db3a2dcbafe0b4769a7b@nifty.ne.jp>
 <Z1cMPRDvfIqZAsL3@calimero.vinschen.de>
 <20241210212140.dcdaec01428393465929dc59@nifty.ne.jp>
 <Z1g7hVhAbbfnnmR5@calimero.vinschen.de>
 <20241210221057.6e9edf37a27b8fc2777bc9e4@nifty.ne.jp>
 <Z1hA2KFehQjXi3Wp@calimero.vinschen.de>
 <20241210223358.7757b61d93bdbbe3cfc11fb2@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241210223358.7757b61d93bdbbe3cfc11fb2@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Dec 10 22:33, Takashi Yano wrote:
> On Tue, 10 Dec 2024 14:23:36 +0100
> Corinna Vinschen wrote:
> > On Dec 10 22:10, Takashi Yano wrote:
> > > On Tue, 10 Dec 2024 14:00:53 +0100
> > > Corinna Vinschen wrote:
> > > > diff --git a/winsup/cygwin/local_includes/path.h b/winsup/cygwin/local_includes/path.h
> > > > index 3dd21d975abf..2a05cf44d40a 100644
> > > > --- a/winsup/cygwin/local_includes/path.h
> > > > +++ b/winsup/cygwin/local_includes/path.h
> > > > @@ -323,7 +323,7 @@ class path_conv
> > > >    }
> > > >    inline POBJECT_ATTRIBUTES init_reopen_attr (OBJECT_ATTRIBUTES &attr, HANDLE h)
> > > >    {
> > > > -    if (has_buggy_reopen ())
> > > > +    if (!h || has_buggy_reopen ())
> > > >        InitializeObjectAttributes (&attr, get_nt_native_path (),
> > > >  				  objcaseinsensitive (), NULL, NULL)
> > > >      else
> > > > -- 
> > > > 2.47.0
> > > > 
> > > 
> > > Thanks! Is your patch better than?
> > > +  if (pc.handle ())
> > > +    pc.init_reopen_attr (attr, pc.handle ());
> > > +  else
> > > +    pc.get_object_attr (attr, sec_none_nih);
> > 
> > Well, it fixes the problem once and for all, without having to
> > add a conditional in multiple places.
> 
> Ok. Then, the similar code at:
> sec/base.cc:61
> sec/base.cc:231
> can be simplified with your patch. Right?

Yes, indeed, thanks!  I'll add that to my patch.

I just have to go AFK for 2 hours or so, but will do this later today.


Thanks,
Corinna
