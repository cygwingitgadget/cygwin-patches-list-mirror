From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Danny Smith" <danny_r_smith_2001@yahoo.co.nz>, "cygwin-patches" <cygwin-patches@cygwin.com>, <rbcollins@cygwin.com>
Subject: RE: src/winsup/w32api ChangeLog include/wingdi.h
Date: Fri, 21 Dec 2001 03:54:00 -0000
Message-ID: <FC169E059D1A0442A04C40F86D9BA760014AAF@itdomain003.itdomain.net.au>
X-SW-Source: 2001-q4/msg00349.html
Message-ID: <20011221035400.ZLxM5yJIa9IVhTKciL9_78TVdfeqczzTEMHaeuYGid0@z>

> Robert. I know your intentions were good, but please there is 
> no need to
> submit to the patch tracker page at mingw SourceForge site as 
> well. That is
> for submission of new patches needing review.  Unless you 
> make clear that
> you have comitted this patch to winsup CVS, it may lead to 
> someone else
> (like myself) checking in your patch to the SourceForge CVS (perhaps
> modified) leading to conflicts at merging.

Ok. So does this sound right:
If I commit to cygwin, don't submit to sourceforge, if I don't checkin
myself, post to sourceforge?
 
> Also, in future, keeping to the general layout of existing 
> w32api headers
> (defines, then typedefs, then prototypes) would be good.  
> This makes it
> easier to protect typedefs and prototypes against RC_INVOKED, 
> while leaving
> the constants visible to windres.

Ok. I was following the MS header arrangement - I wasnt' aware of a
particular layout in the headers for w32api. Will follow in the future.

Rob
