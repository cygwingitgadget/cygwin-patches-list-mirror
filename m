From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: patch to mkpasswd.c - allows selection of specific user
Date: Sat, 10 Nov 2001 15:12:00 -0000
Message-id: <20011110231252.GB2718@redhat.com>
References: <911C684A29ACD311921800508B7293BA010A8FFB@cnmail>
X-SW-Source: 2001-q4/msg00193.html

On Sat, Nov 10, 2001 at 06:08:56PM -0500, Mark Bradshaw wrote:
>I've gone ahead and rewritten the mkpasswd patch so that only the specific
>user that is desired is actually queried for.  This should significantly
>speed up seek times on large domains.  I'd like to add another function to
>get the particulars for the specific user, and then separate the code that
>actually prints the user information out of the enum_users function into a
>separate function.  This way both the "get em all" and the "get one"
>functions print in the same way, making it easier to maintain I'd think.
>
>Sound okay?

Sure.

cgf
