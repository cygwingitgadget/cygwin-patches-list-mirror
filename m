From: Christopher Faylor <cgf@redhat.com>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Re: X_OK redefinition protection.
Date: Fri, 20 Apr 2001 09:37:00 -0000
Message-id: <20010420123732.A24555@redhat.com>
References: <3ADEFDEF.626A46EC@yahoo.com>
X-SW-Source: 2001-q2/msg00128.html

On Thu, Apr 19, 2001 at 11:02:07AM -0400, Earnie Boyd wrote:
>I've also sent the sys-unistd file to newlib.
>
>Earnie.
>2001-04-19  Earnie Boyd  <earnie@users.sourceforge.net>
>
>	* include/sys/file.h (X_OK): Remove redefinition warnings when 
>	including both sys/unistd.h and sys/file.h.  Make the definition
>	consistent with sys/unistd.h.

I've checked in an alternate patch for this.

I don't think there is any reason to protect F_OK, W_OK, and R_OK.
Those definitions haven't changed for years.  The real problem was that
I somehow got the #ifdef wrong.

Are you actually seeing problems with F_OK redefinition?

cgf
