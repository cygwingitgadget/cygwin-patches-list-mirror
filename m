Return-Path: <cygwin-patches-return-5085-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26348 invoked by alias); 27 Oct 2004 02:36:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26338 invoked from network); 27 Oct 2004 02:36:21 -0000
Message-ID: <417F09A1.4090003@x-ray.at>
Date: Wed, 27 Oct 2004 02:36:00 -0000
From: Reini Urban <rurban@x-ray.at>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8a3) Gecko/20040817
MIME-Version: 1.0
To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Subject: sync(3)
Content-Type: multipart/mixed;
 boundary="------------020000000706060503020901"
X-SW-Source: 2004-q4/txt/msg00086.txt.bz2

This is a multi-part message in MIME format.
--------------020000000706060503020901
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 81

Why is this a bad idea?
-- 
Reini Urban
http://xarch.tu-graz.ac.at/home/rurban/


--------------020000000706060503020901
Content-Type: text/plain;
 name="sync.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sync.patch"
Content-length: 903

2004-10-27  Reini Urban  <rurban@x-ray.at>

	* syscalls.cc (sync): Implement it via cygheap->fdtab and 
	FlushFileBuffers. Better than a noop.

Index: syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.345
diff -u -b -r1.345 syscalls.cc
--- syscalls.cc	3 Sep 2004 01:53:12 -0000	1.345
+++ syscalls.cc	27 Oct 2004 02:30:01 -0000
@@ -1082,6 +1082,24 @@
 extern "C" void
 sync ()
 {
+  int err = 0;
+  cygheap->fdtab.lock ();
+
+  fhandler_base *fh;
+  for (int i = 0; i < (int) cygheap->fdtab.size; i++)
+    if ((fh = cygheap->fdtab[i]) != NULL)
+      {
+#ifdef DEBUGGING
+	debug_printf ("syncing fd %d", i);
+#endif
+	if (FlushFileBuffers (fh->get_handle ()) == 0)
+	  {
+	    __seterrno ();
+	    err++;
+	  }
+      }
+  cygheap->fdtab.unlock ();
+  return err ? 1 : 0;
 }
 
 /* Cygwin internal */

--------------020000000706060503020901--
