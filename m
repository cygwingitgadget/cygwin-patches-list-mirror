From: Danny Smith <danny_r_smith_2001@yahoo.co.nz>
To: cygwin-patches <cygwin-patches@cygwin.com>, rbcollins@cygwin.com
Subject: Re: src/winsup/w32api ChangeLog include/wingdi.h
Date: Fri, 21 Dec 2001 00:00:00 -0000
Message-ID: <20011221080001.90765.qmail@web14506.mail.yahoo.com>
References: <20011221065358.25757.qmail@sources.redhat.com>
X-SW-Source: 2001-q4/msg00348.html
Message-ID: <20011221000000.EsD1iW_HZWO7lJFbPrDfZb42cf38ytEGQ9wPbZvZQzU@z>

 --- rbcollins@cygwin.com wrote: > CVSROOT:	/cvs/src
> Module name:	src
> Changes by:	rbcollins@sources.redhat.com	2001-12-20 22:53:57
> 
> Modified files:
> 	winsup/w32api  : ChangeLog 
> 	winsup/w32api/include: wingdi.h 
> 
> Log message:
> 	2001-12-21  Robert Collins  <rbtcollins@hotmail.com>
> 	
> 	* include/wingdi.h: Add GetRandomRgn and SYSRGN.
> 
Robert. I know your intentions were good, but please there is no need to
submit to the patch tracker page at mingw SourceForge site as well. That is
for submission of new patches needing review.  Unless you make clear that
you have comitted this patch to winsup CVS, it may lead to someone else
(like myself) checking in your patch to the SourceForge CVS (perhaps
modified) leading to conflicts at merging.

Also, in future, keeping to the general layout of existing w32api headers
(defines, then typedefs, then prototypes) would be good.  This makes it
easier to protect typedefs and prototypes against RC_INVOKED, while leaving
the constants visible to windres.

Thanks

Danny



http://greetings.yahoo.com.au - Yahoo! Greetings
- Send your festive greetings online!
