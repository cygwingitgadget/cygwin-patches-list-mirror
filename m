From: Corinna Vinschen <corinna@vinschen.de>
To: Chris Faylor <cgf@cygnus.com>
Cc: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: Re: [RFA]: some speed up changes
Date: Mon, 24 Apr 2000 08:00:00 -0000
Message-id: <3904605E.4AC3C5EB@vinschen.de>
References: <3902C84A.C0ED2C59@vinschen.de> <20000423103954.A5811@cygnus.com> <39038021.94903485@vinschen.de> <20000423205219.B6243@cygnus.com>
X-SW-Source: 2000-q2/msg00031.html

Chris Faylor wrote:
> [...]
> Ok.  I see what you're saying now.  The other reason for the
> get_file_attribute (I hate to be defending this in any way since it's
> not my code) is, I think, to be able to set the "symlink" flag so that
> we don't have to rely on the system attribute.  But that is not
> happening in symlink_info::check.  Maybe I accidentally deleted it at
> some point.

I'm not sure if I'm the only person who is thinking that way but
I really like the solution with the system bit. It has the advantage
that requesting is fast and it's working for all file systems.

Maybe we have to rearrange things to work with samba later again
but I would like to discuss this with Jeremy.

> >> Also, rather than test for os_being_run == winNT, couldn't you be
> >> using the has_acls() method?
> >
> >Maybe but that would disallow further usage of the file handle in
> >ntea.cc. What's about a test for allow_ntsec resp. allow_ntea?
> 
> Yeah.  I think I like that better.  Are these flags only used in the
> case of has_acls () && allow_ntea?

Forget all about this discussion. I have more problems with access
rights of ordinary users now than ever before. Dull as I am, I had
tested everything as admin user. Grrr....
I'm just trying a complete different way...

Corinna
