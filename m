From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
Subject: RE: /dev/clipboard update
Date: Thu, 22 Mar 2001 14:19:00 -0000
Message-id: <EA18B9FA0FE4194AA2B4CDB91F73C0EF02E284@itdomain002.itdomain.net.au>
X-SW-Source: 2001-q1/msg00238.html

/me stops typing on the ChangeLog.... looks puzzled. Shrugs.

Thanks Chris.
 

> -----Original Message-----
> From: Christopher Faylor [ mailto:cgf@redhat.com ]
> Sent: Friday, March 23, 2001 9:12 AM
> To: cygwin-patches@cygwin.com
> Subject: Re: /dev/clipboard update
> 
> 
> On Thu, Mar 22, 2001 at 05:02:25PM -0500, Christopher Faylor wrote:
> >On Thu, Mar 22, 2001 at 04:54:22PM -0500, Christopher Faylor wrote:
> >>On Thu, Mar 22, 2001 at 09:57:14PM +1100, Robert Collins wrote:
> >>>here's a patch for /dev/clipboard that
> >>>* allows sequential reads (the existing code only allowed a single
> >>>read() ).
> >>>* allows writes (sequential only.. I haven't thought thru 
> the logic for
> >>>the boundary cases of random writes).
> >>>* allows binary data (ie it's 8 bit clean). A text version 
> is exported
> >>>for windows, to the first \0.
> >>
> >>Sorry but the ChangeLog is not right.  It doesn't list all 
> of the functions
> >>that you modified in fhandler_clipboard.cc.
> >>
> >>Also, please don't add user32 to the link line in 
> Makefile.in.  Take a look
> >>at autoload.cc and add whatever functions you need there.
> >
> >FYI, I've made the appropriate changes to autoload.cc and 
> have the patch
> >ready to check in once I get an updated ChangeLog.
> 
> Nevermind.  The changes were easy enough to understand.  I've 
> checked in
> a ChangeLog entry too...
> 
> cgf
> 
