From: Chris Faylor <cgf@cygnus.com>
To: Robert Collins <robert.collins@itdomain.com.au>
Cc: cygwin-patches@sourceware.cygnus.com
Subject: Re: stackdump revisited - line number achieved!
Date: Fri, 14 Jul 2000 16:25:00 -0000
Message-id: <20000714192440.A16900@cygnus.com>
References: <8600BF007197944F8DD3906E40CB42808F83@itdomain001.itdomain.net.au> <20000709205322.A8625@cygnus.com> <011501bfede5$c8a7b130$f7c723cb@lifelesswks>
X-SW-Source: 2000-q3/msg00016.html

On Sat, Jul 15, 2000 at 08:49:30AM +1000, Robert Collins wrote:
>Chris,
>
>Here's a patch that fixed my problems. with stack dumping daemons. Your
>suggestions did help me, although (as I mentioned ) I still can't get gdb to
>attach properly.. ah well another day another problem.
>
>Notes on the diff's:
>Path.cc - get device name has an unchecked parameter, and would never return
>FH_BAD.
>The hinfo.cc - delinearize fd loop shouldn't iterate at all failed when
>max_used_fd is -1. I'm still getting my programming shoes back on, so the if
>check is _not_ portable. (How _do_ you check for a overflow issues on
>size_t - which is theoretically unsigned??)

In this case it can be changed by making max_unused_fd into an int, which I've
done.

Thanks for tracking this down.

There should be no need to protect the device name against NULL since it
is not ever supposed to get a NULL.

The attached patch should hopefully fix this problem.  I'll check it in soon.

cgf

Index: hinfo.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/hinfo.cc,v
retrieving revision 1.8
diff -u -p -r1.8 hinfo.cc
--- hinfo.cc	2000/07/01 17:30:35	1.8
+++ hinfo.cc	2000/07/14 22:57:59
@@ -497,8 +497,8 @@ hinfo::linearize_fd_array (unsigned char
 LPBYTE
 hinfo::de_linearize_fd_array (LPBYTE buf)
 {
-  int len;
-  size_t max_used_fd, inc_size;
+  int len, max_used_fd;
+  size_t inc_size;
 
   debug_printf ("buf %x", buf);
 
@@ -518,7 +518,7 @@ hinfo::de_linearize_fd_array (LPBYTE buf
       return NULL;
     }
 
-  for (size_t i = 0; i <= max_used_fd; i++)
+  for (int i = 0; i <= max_used_fd; i++)
     {
       /* 0xFF means closed */
       if (*buf == 0xff)
