From: Earnie Boyd <earnie_boyd@yahoo.com>
To: cygwin-patches@sources.redhat.com
Subject: Re: src/winsup/cinstall ChangeLog desktop.cc
Date: Wed, 08 Nov 2000 11:14:00 -0000
Message-id: <20001108191409.10579.qmail@web112.yahoomail.com>
X-SW-Source: 2000-q4/msg00015.html

Shouldn't this patch wait until the changes for mkpasswd and mkgroup have made
distribution?

Cheers,
Earnie
--- corinna@sourceware.cygnus.com wrote:
> CVSROOT:	/cvs/src
> Module name:	src
> Changes by:	corinna@sources.redhat.com	2000-11-08 08:24:39
> 
> Modified files:
> 	winsup/cinstall: ChangeLog desktop.cc 
> 
> Log message:
> 	* desktop.cc (make_passwd_group): Don't exit when started
> 	on 9x/ME since mkpasswd/mkgroup are usable on 9x/ME now.
> 
> Patches:
>
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cinstall/ChangeLog.diff?cvsroot=src&r1=2.25&r2=2.26
>
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cinstall/desktop.cc.diff?cvsroot=src&r1=2.4&r2=2.5
> 


__________________________________________________
Do You Yahoo!?
Thousands of Stores.  Millions of Products.  All in one Place.
http://shopping.yahoo.com/
