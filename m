From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygwin-patches@cygwin.com
Subject: Re: control characters echoed incorrectly.
Date: Wed, 09 May 2001 13:14:00 -0000
Message-id: <s1sn18mxotl.fsf@jaist.ac.jp>
References: <s1spudixvai.fsf@jaist.ac.jp> <20010509145355.A2089@redhat.com>
X-SW-Source: 2001-q2/msg00214.html

>>> On Wed, 9 May 2001 14:53:55 -0400
>>> Christopher Faylor <cgf@redhat.com> said:

> I've checked your changes in, with some modification.  I'd appreciate it
> if you'd double check my modifications to your changes.

I'm afraid I can't compile fhandler_termios.cc for lack of
`interlock.h'.

Index: fhandler_termios.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_termios.cc,v
retrieving revision 1.18
retrieving revision 1.19
diff -u -p -r1.18 -r1.19
--- fhandler_termios.cc	2001/04/28 23:48:28	1.18
+++ fhandler_termios.cc	2001/05/09 18:53:55	1.19
@@ -17,6 +17,7 @@ details. */
 #include "cygerrno.h"
 #include "fhandler.h"
 #include "sync.h"
+#include "interlock.h"
 #include "sigproc.h"
 #include "pinfo.h"
 #include "tty.h"
____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
