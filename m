Return-Path: <cygwin-patches-return-4553-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30132 invoked by alias); 3 Feb 2004 01:23:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30116 invoked from network); 3 Feb 2004 01:23:36 -0000
Message-Id: <3.0.5.32.20040202202201.007e7e80@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Tue, 03 Feb 2004 01:23:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch]: heap_chunk_size
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1075789321==_"
X-SW-Source: 2004-q1/txt/msg00043.txt.bz2

--=====================_1075789321==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 506

Here is a no brainer patch that eliminates the use of 
"heap_chunk" in the cygwin shared. That removes a source 
of DOS attack and it's another step towards the demise
of the cygwin shared.
Actually deleting the "heap_chunk" member from the structure
will be done shortly.

Pierre

2004-02-02  Pierre Humblet <pierre.humblet@ieee.org>

	* shared.cc (shared_info::heap_chunk_size): Delete.
	* heap.cc (heap_chunk_size): Create.
	(heap_init): Call heap_chunk_size instead of
	cygwin_shared->heap_chunk_size.

--=====================_1075789321==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="chunk.diff"
Content-length: 3256

Index: heap.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/heap.cc,v
retrieving revision 1.39
diff -u -p -r1.39 heap.cc
--- heap.cc	14 Jan 2004 15:45:36 -0000	1.39
+++ heap.cc	3 Feb 2004 01:18:58 -0000
@@ -30,6 +30,38 @@ extern "C" size_t getpagesize ();

 #define MINHEAP_SIZE (4 * 1024 * 1024)

+static unsigned
+heap_chunk_size ()
+{
+  unsigned int heap_chunk;
+
+  /* Fetch misc. registry entries.  */
+
+  reg_key reg (KEY_READ, NULL);
+
+  /* Note that reserving a huge amount of heap space does not result in
+     the use of swap since we are not committing it. */
+  /* FIXME: We should not be restricted to a fixed size heap no matter
+     what the fixed size is. */
+
+  heap_chunk =3D reg.get_int ("heap_chunk_in_mb", 0);
+  if (!heap_chunk) {
+    reg_key r1 (HKEY_LOCAL_MACHINE, KEY_READ, "SOFTWARE",
+		CYGWIN_INFO_CYGNUS_REGISTRY_NAME,
+		CYGWIN_INFO_CYGWIN_REGISTRY_NAME, NULL);
+    heap_chunk =3D r1.get_int ("heap_chunk_in_mb", 384);
+  }
+
+  if (!heap_chunk)
+    heap_chunk =3D MINHEAP_SIZE;
+  else if (!(heap_chunk <<=3D 20))
+    heap_chunk =3D 384 * 1024 * 1024;
+
+  debug_printf ("fixed heap size is %u", heap_chunk);
+
+  return heap_chunk;
+}
+
 /* Initialize the heap at process start up.  */
 void
 heap_init ()
@@ -40,7 +72,7 @@ heap_init ()
   page_const =3D system_info.dwPageSize;
   if (!cygheap->user_heap.base)
     {
-      cygheap->user_heap.chunk =3D cygwin_shared->heap_chunk_size ();
+      cygheap->user_heap.chunk =3D heap_chunk_size ();
       while (cygheap->user_heap.chunk >=3D MINHEAP_SIZE)
 	{
 	  /* Initialize page mask and default heap size.  Preallocate a heap
Index: shared.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/shared.cc,v
retrieving revision 1.80
diff -u -p -r1.80 shared.cc
--- shared.cc	1 Dec 2003 15:03:43 -0000	1.80
+++ shared.cc	3 Feb 2004 01:18:58 -0000
@@ -244,37 +244,3 @@ memory_init ()

   user_shared_initialize (false);
 }
-
-unsigned
-shared_info::heap_chunk_size ()
-{
-  if (!heap_chunk)
-    {
-      /* Fetch misc. registry entries.  */
-
-      reg_key reg (KEY_READ, NULL);
-
-      /* Note that reserving a huge amount of heap space does not result in
-      the use of swap since we are not committing it. */
-      /* FIXME: We should not be restricted to a fixed size heap no matter
-      what the fixed size is. */
-
-      heap_chunk =3D reg.get_int ("heap_chunk_in_mb", 0);
-      if (!heap_chunk) {
-	reg_key r1 (HKEY_LOCAL_MACHINE, KEY_READ, "SOFTWARE",
-		    CYGWIN_INFO_CYGNUS_REGISTRY_NAME,
-		    CYGWIN_INFO_CYGWIN_REGISTRY_NAME, NULL);
-	heap_chunk =3D r1.get_int ("heap_chunk_in_mb", 384);
-      }
-
-      if (heap_chunk < 4)
-	heap_chunk =3D 4 * 1024 * 1024;
-      else
-	heap_chunk <<=3D 20;
-      if (!heap_chunk)
-	heap_chunk =3D 384 * 1024 * 1024;
-      debug_printf ("fixed heap size is %u", heap_chunk);
-    }
-
-  return heap_chunk;
-}

--=====================_1075789321==_--
