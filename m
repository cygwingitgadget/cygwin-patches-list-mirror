From: Earnie Boyd <earnie_boyd@yahoo.com>
To: cygwin-patches@cygwin.com
Subject: Need LONG_MAX definition in thread.cc
Date: Thu, 04 Jan 2001 07:33:00 -0000
Message-id: <3A5497CA.C4F1EC9B@yahoo.com>
X-SW-Source: 2001-q1/msg00002.html

 
Thu Jan  4 10:29:54  2001  Earnie Boyd  <earnie_boyd@yahoo.com>

	* thread.cc: Need LONG_MAX definition.

Index: thread.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/thread.cc,v
retrieving revision 1.13
diff -u -3 -p -b -r1.13 thread.cc
--- thread.cc	2001/01/03 18:50:25	1.13
+++ thread.cc	2001/01/04 15:28:22
@@ -16,6 +16,7 @@ details. */
 
 #ifdef _MT_SAFE
 #include "winsup.h"
+#include <limits.h>
 #include <errno.h>
 #include <assert.h>
 #include <stdlib.h>
