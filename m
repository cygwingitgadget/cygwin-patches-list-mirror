From: Corinna Vinschen <corinna@vinschen.de>
To: Chris Faylor <cgf@cygnus.com>
Cc: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: Re: [RFA]: some speed up changes
Date: Sun, 23 Apr 2000 15:59:00 -0000
Message-id: <39038021.94903485@vinschen.de>
References: <3902C84A.C0ED2C59@vinschen.de> <20000423103954.A5811@cygnus.com>
X-SW-Source: 2000-q2/msg00028.html

Chris Faylor wrote:
> 
> On Sun, Apr 23, 2000 at 11:54:18AM +0200, Corinna Vinschen wrote:
> >- In symlink::check() a request for nt attributes is eliminated.
> >  The check for exec bit isn't used later but is very time
> >  consuming.
> 
> I did a little more checking on this.  The setting of PATH_EXEC *is*
> used by other things.  It's tested via the path_conv::isexec method
> in fhandler.cc.  It short-circuits a file open and a check for '#!'.

That's right, I checked that a week ago, too. But if you check it
further you will see that it's only used to set the execable flag in
class fhandler which itself is used only once:
It's used to set the x bit if and only if get_file_attribute fails!

Now the question: Why should get_file_attribute be used to get a flag
that is used only if get_file_attribute fails?!? IMHO that is paradox!

> Also, rather than test for os_being_run == winNT, couldn't you be
> using the has_acls() method?

Maybe but that would disallow further usage of the file handle in
ntea.cc. What's about a test for allow_ntsec resp. allow_ntea?

Corinna
