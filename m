From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: SYSTEMROOT, SYSTEMDRIVE
Date: Wed, 09 May 2001 13:21:00 -0000
Message-id: <20010509162006.C2089@redhat.com>
References: <20010508001319.A16059@redhat.com> <8111460809.20010508190550@logos-m.ru> <12720489682.20010509223903@logos-m.ru>
X-SW-Source: 2001-q2/msg00215.html

On Wed, May 09, 2001 at 10:39:03PM +0400, egor duda wrote:
>Hi!
>
>2001-05-09  Egor Duda  <deo@logos-m.ru>
>
>        * environ.cc (append_to_winenv): New function.
>        (winenv): Always add SYSTEMDRIVE and SYSYEMROOT to win32-style
>        environment.

Hmm.  I think I would have done this differently.

You did this:

1) Search native environment for special environment variables and
   store copies.

2) Build environ argv list from passed in arguments.

3) Sort environ argv list.

4) Loop through argv list to build contiguous list that windows
   uses.  Add special environment variables in sorted order.

I think I would have done this as:

1) Build environ argv list from passed in arguments.  Compare each
   element against special environment list to see if the user
   has specifically overridden them.

2) Loop over the special environment list.  If the special environment
   variable was not specified in 1), get its value from the OS and
   append it to the end of the list.

3) Sort environ argv list.

4) Loop through argv list to build contiguous list that windows
   uses.

The difference is the call to the "OS".  It's optional in my case and
mandatory in yours.  I don't know if this makes a difference but I would
bet that the scanning of the environment is not a quick process.  That
would be weighed against the potentially extra two elements to be sorted
by qsort.

Hmm.  Actually, you stop checking for the extra variables after the
build of winenv passes the place where they would be placed, too,
so that is a difference.

I don't know.  I think that the calls to GetEnvironmentVariable outweigh
anything else, especially since most of the time they probably aren't
needed.

Comments?

cgf
