Return-Path: <cygwin-patches-return-5049-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30933 invoked by alias); 12 Oct 2004 22:12:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30924 invoked from network); 12 Oct 2004 22:12:13 -0000
Message-ID: <n2m-g.ckhrjl.3vvankf.1@buzzy-box.bavag>
From: Bas van Gompel <cygwin-patches.buzz@bavag.tmfweb.nl>
Subject: [Patch] cygheap.cc: Allow _crealloc to shrink memory-block.
Reply-To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Organisation: Ehm...
To: cygwin-patches@cygwin.com
Date: Tue, 12 Oct 2004 22:12:00 -0000
X-SW-Source: 2004-q4/txt/msg00050.txt.bz2

Hi,

Following (trivial IMO) patch, allows memory blocks on the cygheap to
be shrunk.

There are some issues with this:
- The code is slightly slower.
- This change is in a block of code marked ``copyright D. J. Delorie''.
- I'm not sure _crealloc is ever called with a smaller size. (If it
  isn't, this patch is useless.)

(I did test this, and it WJFFM.)


ChangeLog-entry:

20040-10-13  Bas van Gompel  <cygwin-patch.buzz@bavag.tmfweb.nl>

	* cygheap.cc (_crealloc): Allow memory-block to shrink.


--- src/winsup/cygwin/cygheap.cc	2 Jun 2004 21:20:53 -0000	1.103
+++ src/winsup/cygwin/cygheap.cc	12 Oct 2004 02:43:30 -0000
@@ -324,16 +324,22 @@ _cfree (void *ptr)
 static void *__stdcall
 _crealloc (void *ptr, unsigned size)
 {
+  unsigned sz;
   void *newptr;
   if (ptr == NULL)
     newptr = _cmalloc (size);
   else
     {
       unsigned oldsize = 1 << to_cmalloc (ptr)->b;
-      if (size <= oldsize)
+
+     /* Calculate size as a power of two. */
+      for (sz = 8; sz && sz < size; sz <<= 1)
+	continue;
+
+      if (sz == oldsize)
 	return ptr;
       newptr = _cmalloc (size);
-      memcpy (newptr, ptr, oldsize);
+      memcpy (newptr, ptr, min(sz, oldsize));
       _cfree (ptr);
     }
   return newptr;


Buzz.
-- 
  ) |  | ---/ ---/  Yes, this | This message consists of true | I do not
--  |  |   /    /   really is |   and false bits entirely.    | mail for
  ) |  |  /    /    a 72 by 4 +-------------------------------+ any1 but
--  \--| /--- /---  .sigfile. |   |perl -pe "s.u(z)\1.as."    | me. 4^re
