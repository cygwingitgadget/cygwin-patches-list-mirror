Return-Path: <cygwin-patches-return-5097-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26470 invoked by alias); 29 Oct 2004 14:59:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26412 invoked from network); 29 Oct 2004 14:59:36 -0000
Received: from unknown (HELO smartmx-05.inode.at) (213.229.60.37)
  by sourceware.org with SMTP; 29 Oct 2004 14:59:36 -0000
Received: from [62.99.252.218] (port=62942 helo=[192.168.0.2])
	by smartmx-05.inode.at with esmtp (Exim 4.30)
	id 1CNYE3-0003UT-0G
	for cygwin-patches@cygwin.com; Fri, 29 Oct 2004 16:59:35 +0200
Message-ID: <41825AD5.3040205@x-ray.at>
Date: Fri, 29 Oct 2004 14:59:00 -0000
From: Reini Urban <rurban@x-ray.at>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8a3) Gecko/20040817
MIME-Version: 1.0
To: cygwin-patches mailing-list <cygwin-patches@cygwin.com>
Subject: sync() revised
Content-Type: multipart/mixed;
 boundary="------------070907080005080503040001"
X-SW-Source: 2004-q4/txt/msg00098.txt.bz2

This is a multi-part message in MIME format.
--------------070907080005080503040001
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 197

I revised my sync() patch, which compiles and works.
The assignment is on the way.

Still didn't find any package which actually uses that.
-- 
Reini Urban
http://xarch.tu-graz.ac.at/home/rurban/


--------------070907080005080503040001
Content-Type: text/plain;
 name="ru-sync.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ru-sync.patch"
Content-length: 1713

2004-10-29  Reini Urban  <rurban@x-ray.at>

	* syscalls.cc (sync): Implement it via cygheap->fdtab and 
	FlushFileBuffers. Better than a noop.
	(sync_worker) Internalized, because dtable::lock is private.
	* dtable.h: (dtable::sync_worker) Added as friend for lock().

Index: syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.349
diff -u -b -r1.349 syscalls.cc
--- syscalls.cc	28 Oct 2004 01:46:01 -0000	1.349
+++ syscalls.cc	29 Oct 2004 14:43:29 -0000
@@ -1087,10 +1087,33 @@
   return 0;
 }
 
+/* Cygwin internal */
+void __stdcall
+sync_worker ()
+{
+  cygheap->fdtab.lock ();
+
+  /* TODO: check if Admin and iterate over the local volumes instead */
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
+	  }
+      }
+  cygheap->fdtab.unlock ();
+}
+
 /* sync: SUSv3 */
 extern "C" void
 sync ()
 {
+  sync_worker ();
 }
 
 /* Cygwin internal */
Index: dtable.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dtable.h,v
retrieving revision 1.30
diff -u -b -r1.30 dtable.h
--- dtable.h	21 Mar 2004 17:41:40 -0000	1.30
+++ dtable.h	29 Oct 2004 14:43:29 -0000
@@ -85,6 +85,7 @@
   void delete_archetype (fhandler_base *);
   friend void dtable_init ();
   friend void __stdcall close_all_files ();
+  friend void __stdcall sync_worker ();
   friend class cygheap_fdmanip;
   friend class cygheap_fdget;
   friend class cygheap_fdnew;

--------------070907080005080503040001--
