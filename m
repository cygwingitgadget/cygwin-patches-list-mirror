From: Christopher Faylor <cgf@redhat.com>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: Re: Patch to make setrlimit() more forgiving
Date: Thu, 04 Jan 2001 18:41:00 -0000
Message-id: <20010104214112.A32564@redhat.com>
References: <30E7BC40E838D211B3DB00104B09EFB77953DE@delorean.optimation.co.nz>
X-SW-Source: 2001-q1/msg00005.html

It looks good but I need a ChangeLog.

cgf

On Fri, Jan 05, 2001 at 03:38:43PM +1300, David Sainty wrote:
>Attached is a simple patch that prevents setrlimit() failing with an error
>when the operation would not have changed anything.  This allows all
>resource types to be set, so long as the setting is identical to the current
>pseudo-settings.
>
>One "problem" with the patch is that it calls getrlimit(), which calls
>VirtualQuery() on an internal address that we are sure is ok.  This isn't
>incorrect, it's just overkill.  The fix would be to use getrlimit() as a
>wrapper to an internal function that avoids the memory test.  But... I'm not
>sure why these tests are here at all, they don't seem to occur on other API
>functions...  A crash is just as legitimate as an EFAULT? :)
>
>Cheers,
>
>Dave
>



-- 
cgf@cygnus.com                        Red Hat, Inc.
http://sources.redhat.com/            http://www.redhat.com/
