Return-Path: <cygwin-patches-return-7339-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17681 invoked by alias); 11 May 2011 18:32:26 -0000
Received: (qmail 17663 invoked by uid 22791); 11 May 2011 18:32:25 -0000
X-SWARE-Spam-Status: No, hits=-1.1 required=5.0	tests=AWL,BAYES_00,SPF_NEUTRAL
X-Spam-Check-By: sourceware.org
Received: from smtp3.epfl.ch (HELO smtp3.epfl.ch) (128.178.224.226)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Wed, 11 May 2011 18:32:11 +0000
Received: (qmail 639 invoked by uid 107); 11 May 2011 18:32:09 -0000
Received: from sb-gw15.cs.toronto.edu (HELO discarded) (128.100.3.15) (authenticated)  by smtp3.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPA; Wed, 11 May 2011 20:32:10 +0200
Message-ID: <4DCAD629.8010803@cs.utoronto.ca>
Date: Wed, 11 May 2011 18:32:00 -0000
From: Ryan Johnson <ryan.johnson@cs.utoronto.ca>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Improvements to fork handling (3/5)
Content-Type: multipart/mixed; boundary="------------080804050409030201020602"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00105.txt.bz2

This is a multi-part message in MIME format.
--------------080804050409030201020602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 369

Hi all,

This patch fixes a bug in the reserve_at function which caused it to 
sometimes reserve space needed by the dll it was supposed to help land. 
This happens when the dll tries to land in a free region which overlaps 
the desired location. The new code exploits the image introspection 
(patch #2) to get the dll's image size and avoids the corner cases.

Ryan


--------------080804050409030201020602
Content-Type: text/plain;
 name="fork-reserve-at.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fork-reserve-at.patch"
Content-length: 2405

diff --git a/dll_init.cc b/dll_init.cc
--- a/dll_init.cc
+++ b/dll_init.cc
@@ -164,6 +164,7 @@ dll_list::alloc (HINSTANCE h, per_proces
       d->handle = h;
       d->has_dtors = true;
       d->p = p;
+      d->image_size = ((pefile*)h)->optional_hdr ()->SizeOfImage;
       d->ndeps = 0;
       d->deps = NULL;
       d->modname = wcsrchr (d->name, L'\\');
@@ -407,21 +408,33 @@ release_upto (const PWCHAR name, DWORD h
       }
 }
 
-/* Mark one page at "here" as reserved.  This may force
-   Windows NT to load a DLL elsewhere. */
+/* Reserve the chunk of free address space starting _here_ and (usually)
+   covering at least _dll_size_ bytes. However, we must take care not
+   to clobber the dll's target address range because it often overlaps.
+ */
 static DWORD
-reserve_at (const PWCHAR name, DWORD here)
+reserve_at (const PWCHAR name, DWORD here, DWORD dll_base, DWORD dll_size)
 {
   DWORD size;
   MEMORY_BASIC_INFORMATION mb;
 
   if (!VirtualQuery ((void *) here, &mb, sizeof (mb)))
-    size = 64 * 1024;
-
+    api_fatal ("couldn't examine memory at %08lx while mapping %W, %E",
+	       here, name);
   if (mb.State != MEM_FREE)
     return 0;
 
   size = mb.RegionSize;
+  
+  // don't clobber the space where we want the dll to land
+  DWORD end = here + size;
+  DWORD dll_end = dll_base + dll_size;
+  if (dll_base < here && dll_end > here)
+      here = dll_end; // the dll straddles our left edge
+  else if (dll_base >= here && dll_base < end)
+      end = dll_base; // the dll overlaps partly or fully to our right
+  
+  size = end - here;
   if (!VirtualAlloc ((void *) here, size, MEM_RESERVE, PAGE_NOACCESS))
     api_fatal ("couldn't allocate memory %p(%d) for '%W' alignment, %E\n",
                here, size, name);
@@ -499,7 +512,8 @@ dll_list::load_after_fork (HANDLE parent
              can in the child, due to differences in the load ordering.
              Block memory at it's preferred address and try again. */
           if ((DWORD) h > (DWORD) d->handle)
-            preferred_block = reserve_at (d->name, (DWORD) h);
+            preferred_block = reserve_at (d->name, (DWORD) h,
+					  (DWORD) d->handle, d->image_size);
 
 	}
 }
diff --git a/dll_init.h b/dll_init.h
--- a/dll_init.h
+++ b/dll_init.h
@@ -52,6 +52,7 @@ struct dll
   int count;
   bool has_dtors;
   dll_type type;
+  DWORD image_size;
   long ndeps;
   dll** deps;
   PWCHAR modname;

--------------080804050409030201020602
Content-Type: text/plain;
 name="fork-reserve-at.changes"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fork-reserve-at.changes"
Content-length: 341

        * dll_init.cc (dll_list::alloc): initialize dll::image_size.
        (reserve_at): no longer reserves space needed by the target dll if
        the latter overlaps the free region to be blocked.
        (dll_list::load_after_fork): use new version of reserve_at.
        * dll_init.h (struct dll): add new members to track dll size.

--------------080804050409030201020602--
