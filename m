From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Comments on Robert's category feature
Date: Sun, 17 Jun 2001 18:09:00 -0000
Message-id: <20010617211004.A530@redhat.com>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF08F069@itdomain002.itdomain.net.au> <004301c0f4a8$2d6f0ef0$0200a8c0@lifelesswks> <20010614203149.A14254@redhat.com> <20010614225309.A16513@redhat.com>
X-SW-Source: 2001-q2/msg00317.html

On Thu, Jun 14, 2001 at 10:53:09PM -0400, Christopher Faylor wrote:
>On Thu, Jun 14, 2001 at 08:31:49PM -0400, Christopher Faylor wrote:
>>I'm testing the other stuff in the meantime.
>
>I'm still checking but I also checked in the parsing parts of your patch
>since I think that they are definitely the way to go.

Ok, I've played with Robert's changes and I don't think that they go far
enough.  Has anyone else looked at them?

I think we still need to change the chooser dialog so that it can
create different views.  The default view should just display categories.
Maybe categories should have those nifty chooser things so that you can
deselect the whole thing, use test versions for the category, download
sources for the category, skip the category, etc.

Clicking on the category name should expand it (maybe we need an icon next
to the category name to make this clear).  Underneath the category name
would be the list of everything in the category, in the standard format.

If we were ambitious, we could also have a button at the top which switched
everything to the "old view" where all packages were displayed.

I don't think that these changes are too huge.  Robert has already laid
the infrastructure for doing this.

Does this make any sense?  Comments?

Thanks to Robert for getting the ball rolling with this.

cgf
