From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: mount.exe's error message
Date: Tue, 28 Aug 2001 11:48:00 -0000
Message-id: <20010828144809.A25840@redhat.com>
References: <3B8BDD70.18800.1904953@localhost>
X-SW-Source: 2001-q3/msg00090.html

On Tue, Aug 28, 2001 at 06:05:36PM +0200, Gerrit P. Haase wrote:
>Hi,
>
>I think this error message is not 'correct'.
>
>$ mount -s -b
>mount: too many arguments
>[...]

You're right.  It's not correct.  Your change would only make the
error message correct when there weren't enough arguments, though.
Too many arguments is also a possible error condition.

I checked in a fix which deals with both scenarios.

Thanks for noticing this.

cgf

>diff -ur src/winsup/utils/mount.cc src-patched/winsup/utils/mount.cc
>--- src/winsup/utils/mount.cc	Tue Aug 28 14:19:39 2001
>+++ src-patched/winsup/utils/mount.cc	Tue Aug 28 15:53:50 2001
>@@ -214,7 +214,7 @@
>     default:
>       if (optind != (argc - 1))
>     {
>-      fprintf (stderr, "%s: too many arguments\n", progname);
>+      fprintf (stderr, "%s: too few arguments\n", progname);
>       usage ();
>     }
>       if (force || !mount_already_exists (argv[optind + 1], flags))
>
>
>Gerrit
>
>
>-- 
>gerrit.haase@convey.de

-- 
cgf@cygnus.com                        Red Hat, Inc.
http://sources.redhat.com/            http://www.redhat.com/
