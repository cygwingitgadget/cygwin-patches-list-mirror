From: Chris Faylor <cgf@cygnus.com>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: Re: [RFA]: some speed up changes
Date: Sun, 23 Apr 2000 17:52:00 -0000
Message-id: <20000423205219.B6243@cygnus.com>
References: <3902C84A.C0ED2C59@vinschen.de> <20000423103954.A5811@cygnus.com> <39038021.94903485@vinschen.de>
X-SW-Source: 2000-q2/msg00030.html

On Mon, Apr 24, 2000 at 12:58:41AM +0200, Corinna Vinschen wrote:
>Chris Faylor wrote:
>> I did a little more checking on this.  The setting of PATH_EXEC *is*
>> used by other things.  It's tested via the path_conv::isexec method
>> in fhandler.cc.  It short-circuits a file open and a check for '#!'.
>
>That's right, I checked that a week ago, too. But if you check it
>further you will see that it's only used to set the execable flag in
>class fhandler which itself is used only once:
>It's used to set the x bit if and only if get_file_attribute fails!

Ok.  I see what you're saying now.  The other reason for the
get_file_attribute (I hate to be defending this in any way since it's
not my code) is, I think, to be able to set the "symlink" flag so that
we don't have to rely on the system attribute.  But that is not
happening in symlink_info::check.  Maybe I accidentally deleted it at
some point.

So, you're right.  Go ahead and delete this.

>Now the question: Why should get_file_attribute be used to get a flag
>that is used only if get_file_attribute fails?!? IMHO that is paradox!
>
>> Also, rather than test for os_being_run == winNT, couldn't you be
>> using the has_acls() method?
>
>Maybe but that would disallow further usage of the file handle in
>ntea.cc. What's about a test for allow_ntsec resp. allow_ntea?

Yeah.  I think I like that better.  Are these flags only used in the
case of has_acls () && allow_ntea?

cgf
