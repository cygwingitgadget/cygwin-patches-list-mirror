From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: [patch] Setup.exe choose.cc selection enhancement based on file existence
Date: Tue, 06 Mar 2001 11:58:00 -0000
Message-id: <20010306205837.K7734@cygbert.vinschen.de>
References: <20010306171013.I7734@cygbert.vinschen.de> <VA.0000068c.00d1000e@thesoftwaresource.com>
X-SW-Source: 2001-q1/msg00151.html

On Tue, Mar 06, 2001 at 02:32:48PM -0500, Brian Keener wrote:
> Corinna Vinschen wrote:
> > Even if I install from internet, when
> > choosing the "Full" view, I'm getting "n/a" for every  package
> > which doesn't need update.
> >
> I think the key word there is for every package that *doesn't* need 
> update.  Since the package itself does not need updating then I think I 
> have by default (and it's probably not selectable) the source download 
> set to N/A - this also appear to be the way the current version 
> downloadable from the web works as well.  
> 
> What does it do if the package does need updating? - I think it gives you 
> the Source download option then.  I think the overriding factor here - 
> even on the current version from the web is whether the packaged binaries 
> need updating and my thought process was that if you were getting the 
> source you would probably do it at download/install time and not after 
> the package was already updated - might be a bad conclusion.  We might 
> want to revisit this - what do you and others think?

I would like to see the ability of setup to download all sources,
even the packages which don't need updating. I can't see a reason
that I'm unable to download the sources 10 minutes after installing
only because I forgot to click on the src? button in that moment.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
