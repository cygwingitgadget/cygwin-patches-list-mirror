From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: updated: Categories and basic dependency handling for setup
Date: Thu, 14 Jun 2001 17:31:00 -0000
Message-id: <20010614203149.A14254@redhat.com>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF08F069@itdomain002.itdomain.net.au> <004301c0f4a8$2d6f0ef0$0200a8c0@lifelesswks>
X-SW-Source: 2001-q2/msg00308.html

On Thu, Jun 14, 2001 at 06:01:11PM +1000, Robert Collins wrote:
>By the way, just to be clear: I'm not going to put a changelog together
>again, until the patch is fully acceptable - and I didn't mean to
>include my temp change to getpkgbyname in the patch (I was tracking a
>bug).

Your temp change to getpkgbyname is actually correct.  It's consistent
with the rest of the uses of package.  I'm going to check this in.

I'm testing the other stuff in the meantime.

cgf
