Return-Path: <cygwin-patches-return-7201-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2723 invoked by alias); 13 Mar 2011 15:07:52 -0000
Received: (qmail 2711 invoked by uid 22791); 13 Mar 2011 15:07:50 -0000
X-SWARE-Spam-Status: No, hits=-2.6 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from smtpout.karoo.kcom.com (HELO smtpout.karoo.kcom.com) (212.50.160.34)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 13 Mar 2011 15:07:43 +0000
Received: from 213-152-38-55.dsl.eclipse.net.uk (HELO [192.168.0.5]) ([213.152.38.55])  by smtpout.karoo.kcom.com with ESMTP; 13 Mar 2011 15:07:40 +0000
Message-ID: <4D7CDDC7.5060708@dronecode.org.uk>
Date: Sun, 13 Mar 2011 15:07:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Add an additional relocation attempt pass to load_after_fork()
Content-Type: multipart/mixed; boundary="------------050000030304030101000803"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q1/txt/msg00056.txt.bz2

This is a multi-part message in MIME format.
--------------050000030304030101000803
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 527


Attached is a patch which avoids a fork failure due to remap error in the
specific circumstances described in my email [1], by adding an additional pass
to load_after_fork() which forces the DLL to be relocated by VirtualAlloc()ing
a block of memory at the load address as well.

Hopefully it can be seen by inspection that this code doesn't change the
behaviour of the first two passes, and so will only be changing the behaviour
in what was an fatal error case before.

[1] http://cygwin.com/ml/cygwin/2011-03/msg00373.html

--------------050000030304030101000803
Content-Type: text/plain;
 name="dll_init.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dll_init.patch"
Content-length: 3623


2011-03-12  Jon TURNEY  <jon.turney@dronecode.org.uk>

	* dll_init.cc (reserve_at, release_at): New functions.
	(load_after_fork): Make a 3rd pass at trying to load the DLL in
	the right place.


Index: cygwin/dll_init.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dll_init.cc,v
retrieving revision 1.77
diff -u -p -r1.77 dll_init.cc
--- cygwin/dll_init.cc	15 Feb 2011 15:56:00 -0000	1.77
+++ cygwin/dll_init.cc	13 Mar 2011 14:50:11 -0000
@@ -254,15 +254,47 @@ release_upto (const PWCHAR name, DWORD h
       }
 }
 
+/* Mark one page at "here" as reserved.  This may force
+   Windows NT to load a DLL elsewhere. */
+static DWORD
+reserve_at (const PWCHAR name, DWORD here)
+{
+  DWORD size;
+  MEMORY_BASIC_INFORMATION mb;
+
+  if (!VirtualQuery ((void *) here, &mb, sizeof (mb)))
+    size = 64 * 1024;
+
+  if (mb.State != MEM_FREE)
+    return 0;
+
+  size = mb.RegionSize;
+  if (!VirtualAlloc ((void *) here, size, MEM_RESERVE, PAGE_NOACCESS))
+    api_fatal ("couldn't allocate memory %p(%d) for '%W' alignment, %E\n",
+               here, size, name);
+  return here;
+}
+
+/* Release the memory previously allocated by "reserve_at" above. */
+static void
+release_at (const PWCHAR name, DWORD here)
+{
+  if (!VirtualFree ((void *) here, 0, MEM_RELEASE))
+    api_fatal ("couldn't release memory %p for '%W' alignment, %E\n",
+               here, name);
+}
+
 /* Reload DLLs after a fork.  Iterates over the list of dynamically loaded
    DLLs and attempts to load them in the same place as they were loaded in the
    parent. */
 void
 dll_list::load_after_fork (HANDLE parent)
 {
+  DWORD preferred_block = 0;
+
   for (dll *d = &dlls.start; (d = d->next) != NULL; )
     if (d->type == DLL_LOAD)
-      for (int i = 0; i < 2; i++)
+      for (int i = 0; i < 3; i++)
 	{
 	  /* See if DLL will load in proper place.  If so, free it and reload
 	     it the right way.
@@ -281,15 +313,26 @@ dll_list::load_after_fork (HANDLE parent
 	      if (h == d->handle)
 		h = LoadLibraryW (d->name);
 	    }
-	  /* If we reached here on the second iteration of the for loop
+
+	  /* If we reached here on subsequent iterations of the for loop
 	     then there is a lot of memory to release. */
 	  if (i > 0)
 	    release_upto (d->name, (DWORD) d->handle);
+
+          /* If we reached here on the last iteration of the for loop
+             then there's a bit of memory to release */
+          if (i > 1)
+            {
+              if (preferred_block)
+                release_at(d->name, preferred_block);
+              preferred_block = NULL;
+            }
+
 	  if (h == d->handle)
 	    break;		/* Success */
 
-	  if (i > 0)
-	    /* We tried once to relocate the dll and it failed. */
+	  if (i > 1)
+	    /* We tried to relocate the dll and it failed. */
 	    api_fatal ("unable to remap %W to same address as parent: %p != %p",
 		       d->name, d->handle, h);
 
@@ -299,6 +342,15 @@ dll_list::load_after_fork (HANDLE parent
 	     second DLL always loads into a different location. So, block all
 	     of the memory up to the new load address and try again. */
 	  reserve_upto (d->name, (DWORD) d->handle);
+
+          /* Dll *still* loaded in the wrong place.  This can happen if it
+             couldn't load at the preferred base in the parent, but can in
+             the child, due to ordering differences.  Block memory at it's
+             preferred address and try again. */
+          if (i > 0)
+            {
+              preferred_block = reserve_at(d->name, (DWORD)h);
+            }
 	}
   in_forkee = false;
 }

--------------050000030304030101000803--
