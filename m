From: Corinna Vinschen <corinna@vinschen.de>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Cc: Chris Faylor <cgf@cygnus.com>
Subject: Re: [RFA]: some speed up changes
Date: Sun, 23 Apr 2000 16:30:00 -0000
Message-id: <39038591.4572C422@vinschen.de>
References: <3902C84A.C0ED2C59@vinschen.de> <20000423103954.A5811@cygnus.com> <39038021.94903485@vinschen.de>
X-SW-Source: 2000-q2/msg00029.html

Corinna Vinschen wrote:
> 
> Chris Faylor wrote:
> >
> > On Sun, Apr 23, 2000 at 11:54:18AM +0200, Corinna Vinschen wrote:
> > >- In symlink::check() a request for nt attributes is eliminated.
> > >  The check for exec bit isn't used later but is very time
> > >  consuming.
> >
> > I did a little more checking on this.  The setting of PATH_EXEC *is*
> > used by other things.  It's tested via the path_conv::isexec method
> > in fhandler.cc.  It short-circuits a file open and a check for '#!'.

The get_file_attribute() call opens the file, reads the backup
streams and closes the file. The code that you mention only reads
a few bytes and seeks back to 0 while the file is already opened.
So the check for #! is more efficient than the get_file_attribute.

Moreover the text below is evident though it was the wrong
argumentation relative to your description.

> That's right, I checked that a week ago, too. But if you check it
> further you will see that it's only used to set the execable flag in
> class fhandler which itself is used only once:
> It's used to set the x bit if and only if get_file_attribute fails!
> 
> Now the question: Why should get_file_attribute be used to get a flag
> that is used only if get_file_attribute fails?!? IMHO that is paradox!

Corinna
