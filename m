From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: bugs in path_conv::update_fs_info.
Date: Sun, 10 Jun 2001 20:50:00 -0000
Message-id: <20010610235112.A10720@redhat.com>
References: <s1siti8upft.fsf@jaist.ac.jp> <20010610233146.E10208@redhat.com>
X-SW-Source: 2001-q2/msg00283.html

On Sun, Jun 10, 2001 at 11:31:46PM -0400, Christopher Faylor wrote:
>On Fri, Jun 08, 2001 at 03:15:18AM +0900, Kazuhiro Fujieda wrote:
>>There are trivial mistakes in path_conv::update_fs_info.
>>It can't handle the case where GetCurrentDirectory will fail,
>>and invokes GetDriveType with an invalid argument.
>
>Gah!  We're calling GetCurrentDirectory?  I missed that.  What's the
>rationale for this?  The previous code didn't have this.  This looks
>like YA path_conv slowdown. (These observations are for Egor)
>
>I'd rather just nuke all of this GetCurrentDirectory logic.  I don't
>see how it makes sense to use the current directory in this context,
>anyway.

Which I've done.  I've also incorporated the "Set root_dir before
invoking GetDriveType." part of this patch.

cgf
