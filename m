Return-Path: <cygwin-patches-return-7341-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19076 invoked by alias); 11 May 2011 18:33:39 -0000
Received: (qmail 19065 invoked by uid 22791); 11 May 2011 18:33:38 -0000
X-SWARE-Spam-Status: No, hits=-1.1 required=5.0	tests=AWL,BAYES_00,SPF_NEUTRAL
X-Spam-Check-By: sourceware.org
Received: from smtp3.epfl.ch (HELO smtp3.epfl.ch) (128.178.224.226)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Wed, 11 May 2011 18:33:24 +0000
Received: (qmail 793 invoked by uid 107); 11 May 2011 18:33:23 -0000
Received: from sb-gw15.cs.toronto.edu (HELO discarded) (128.100.3.15) (authenticated)  by smtp3.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPA; Wed, 11 May 2011 20:33:23 +0200
Message-ID: <4DCAD672.6030806@cs.utoronto.ca>
Date: Wed, 11 May 2011 18:33:00 -0000
From: Ryan Johnson <ryan.johnson@cs.utoronto.ca>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Improvements to fork handling (5/5)
Content-Type: multipart/mixed; boundary="------------040109080402030707080601"
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
X-SW-Source: 2011-q2/txt/msg00107.txt.bz2

This is a multi-part message in MIME format.
--------------040109080402030707080601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 685

Hi all,

This last patch adds a small optimization which reserves the lower 4MB 
of address space early in the process's lifetime (even if it's not a 
forkee). This was motivated by the observation that Windows tends to 
move things around a lot in that area, increasing the probability of 
future fork failures if the parent allows cygwin dlls to land there.  
The patch does not fully address the problem, however, because ASLR 
clobbers addresses above 4M as well. As a result, this patch may or may 
not improve fork success rates in practice: most fork failures for me 
involve DLL_LINK dlls which landed badly in the child.

It should be independent of the other patches.

Ryan


--------------040109080402030707080601
Content-Type: text/plain;
 name="fork-bad-addr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fork-bad-addr.patch"
Content-length: 2595

diff --git a/dcrt0.cc b/dcrt0.cc
--- a/dcrt0.cc
+++ b/dcrt0.cc
@@ -792,6 +792,13 @@ dll_crt0_1 (void *)
   main_vfork = vfork_storage.create ();
 #endif
 
+  /* Windows doesn't use the lower 4MB of address space consistently,
+     and those uses arise before cygwin1.dll loads. If a dll loads
+     there we risk being unable to fork later. To avoid the problem,
+     we just reserve everything that's left in that space -- windows
+     can still do what it wants since it got there first. */
+  dlls.block_bad_address_space ();
+  
   cygbench ("pre-forkee");
   if (in_forkee)
     {
diff --git a/dll_init.cc b/dll_init.cc
--- a/dll_init.cc
+++ b/dll_init.cc
@@ -359,6 +359,44 @@ dll_list::init ()
 #define A64K (64 * 1024)
 
 
+void
+dll_list::block_bad_address_space ()
+{
+  /* For some reason VirtualQuery doesn't return consistent values of
+     RegionSize for free space, so we have to compute it manually by
+     looking for MEM_FREE followed by a not-free region. We ensure not
+     to leave a danging free region by allowing the loop to examine
+     0x00400000, which is always the address of the application's
+     executable image.
+   */
+  MEMORY_BASIC_INFORMATION mb;
+  DWORD here;
+  for (DWORD i=A64K; i <= 64*A64K; i += mb.RegionSize)
+    {
+      if ( !VirtualQuery ((void*)i, &mb, sizeof(mb)))
+	api_fatal ("-> unable to examine address space at %08lx, %E", i);
+      here = (DWORD) mb.BaseAddress;
+      
+      /* this should never happen. If it does we'll need to write some
+	 code to compensate for it */
+      if (here != i)
+	api_fatal ("VirtualQuery returned info for %lx instead of %lx",
+		   here, i);
+      if (mb.State == MEM_FREE)
+	{
+	  DWORD size = mb.RegionSize;
+	  if (!VirtualAlloc ((void*) here, size, MEM_RESERVE, PAGE_NOACCESS))
+	    system_printf ("-> couldn't block out %08lx, %E", here);
+	}
+      else if (mb.RegionSize & (A64K-1))
+	{
+	  /* skip free space at the end of mapped slices -- they can't
+	     be used by anything else */
+	  mb.RegionSize = (mb.RegionSize + A64K - 1) & -A64K;
+	}
+    }
+}
+
 /* Reserve the chunk of free address space starting _here_ and (usually)
    covering at least _dll_size_ bytes. However, we must take care not
    to clobber the dll's target address range because it often overlaps.
diff --git a/dll_init.h b/dll_init.h
--- a/dll_init.h
+++ b/dll_init.h
@@ -83,6 +83,7 @@ public:
   int tot;
   int loaded_dlls;
   int reload_on_fork;
+  void block_bad_address_space ();
   dll *operator [] (const PWCHAR name);
   dll *alloc (HINSTANCE, per_process *, dll_type);
   dll *find (void *);

--------------040109080402030707080601
Content-Type: text/plain;
 name="fork-bad-addr.changes"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fork-bad-addr.changes"
Content-length: 369

        * dcrt0.cc (dll_crt0_1): call dll_list::block_bad_address_space
        * dll_init.cc (dll_list::block_bad_address_space): new function to
        reserve all free space in the low 4MB. Reduces somewhat the
        probability of a dynamic dll clashing with windows heaps or thread
        stacks.
        * dll_init.h (struct dll_list): declaration for above.

--------------040109080402030707080601--
