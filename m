From: "Gerrit P. Haase" <freeweb@nyckelpiga.de>
To: cygwin-patches@cygwin.com
Subject: mount.exe's error message
Date: Tue, 28 Aug 2001 09:10:00 -0000
Message-id: <3B8BDD70.18800.1904953@localhost>
X-SW-Source: 2001-q3/msg00089.html

Hi,

I think this error message is not 'correct'.

$ mount -s -b
mount: too many arguments
[...]

diff -ur src/winsup/utils/mount.cc src-patched/winsup/utils/mount.cc
--- src/winsup/utils/mount.cc	Tue Aug 28 14:19:39 2001
+++ src-patched/winsup/utils/mount.cc	Tue Aug 28 15:53:50 2001
@@ -214,7 +214,7 @@
     default:
       if (optind != (argc - 1))
     {
-      fprintf (stderr, "%s: too many arguments\n", progname);
+      fprintf (stderr, "%s: too few arguments\n", progname);
       usage ();
     }
       if (force || !mount_already_exists (argv[optind + 1], flags))


Gerrit


-- 
gerrit.haase@convey.de
