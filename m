From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [UNPATCH]Slashes in regtool.exe
Date: Wed, 27 Jun 2001 19:46:00 -0000
Message-id: <20010627224716.A30107@redhat.com>
References: <003201c0ff7b$929432a0$6464648a@ca.boeing.com>
X-SW-Source: 2001-q2/msg00363.html

On Wed, Jun 27, 2001 at 07:39:24PM -0700, Michael A. Chase wrote:
>The change is unnecessary.  Corrina added the capability in January 2000.  I
>have confirmed this behavior with the version of regtool.exe that is part of
>1.3.2.  Part of the confusion may be because the leading '\\' is not
>required if '\\' separators are being used; it probably ought to be.
>Perhaps the examples in usage_msg[] could show both types of separators.
>
>If the first character of the key is '/' (see two lines before patch),
>translate() is called to convert '/'s to '\\'s so the user doesn't have to
>dirty his hands with '\\'  _unless_ she wants to use a key part that
>contains '/'.  If any part of the key contains '/', you don't want
>translate() to get its mitts on the string so the first character may not be
>'/'.
>
>Other note:
>
>The help screen says "-p" causes '/' to be appended to key names, but it
>actually appends '\\'.  I still can't send patches since my assignment isn't
>done yet, but you might want to fix this when you reverse the patch.

Ok.  I've reverted the patch and fixed the documentation.

Thanks for checking this.

cgf
