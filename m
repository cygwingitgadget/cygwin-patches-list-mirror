From: Corinna Vinschen <corinna@vinschen.de>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: grp.cc
Date: Mon, 03 Apr 2000 10:04:00 -0000
Message-id: <38E8CEF0.2BE9EA4F@vinschen.de>
X-SW-Source: 2000-q2/msg00005.html

We already talked about that:

        * grp.cc (parse_grp): Save empty array instead of
        NULL in gr_mem if no supplementary group is given.

I would like to commit this patch:

Index: grp.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/grp.cc,v
retrieving revision 1.2
diff -u -p -r1.2 grp.cc
--- grp.cc      2000/02/21 05:20:37     1.2
+++ grp.cc      2000/04/03 16:55:30
@@ -92,7 +92,7 @@ parse_grp (struct group &grp, const char
              grp.gr_mem = namearray;
             }
           else
-            grp.gr_mem = NULL;
+            grp.gr_mem = (char **) calloc (1, sizeof (char *));
           return 1;
         }
     }

Corinna
