Return-Path: <cygwin-patches-return-7263-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28871 invoked by alias); 4 Apr 2011 12:43:42 -0000
Received: (qmail 28859 invoked by uid 22791); 4 Apr 2011 12:43:41 -0000
X-SWARE-Spam-Status: No, hits=-2.6 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,TW_NV
X-Spam-Check-By: sourceware.org
Received: from smtpout.karoo.kcom.com (HELO smtpout.karoo.kcom.com) (212.50.160.34)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 04 Apr 2011 12:42:42 +0000
Received: from 213-152-38-55.dsl.eclipse.net.uk (HELO [192.168.0.8]) ([213.152.38.55])  by smtpout.karoo.kcom.com with ESMTP; 04 Apr 2011 13:42:40 +0100
Message-ID: <4D99BCCE.60407@dronecode.org.uk>
Date: Mon, 04 Apr 2011 12:43:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add an additional relocation attempt pass to load_after_fork()
References: <4D7CDDC7.5060708@dronecode.org.uk> <20110313152111.GA7064@calimero.vinschen.de> <4D7E908B.4010004@dronecode.org.uk> <20110315075313.GA5722@calimero.vinschen.de> <20110315150412.GA18662@ednor.casa.cgf.cx> <20110315154609.GE4320@calimero.vinschen.de> <20110330211556.GE13484@calimero.vinschen.de> <20110330212951.GC28494@ednor.casa.cgf.cx>
In-Reply-To: <20110330212951.GC28494@ednor.casa.cgf.cx>
Content-Type: multipart/mixed; boundary="------------030602080700070900090203"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00029.txt.bz2

This is a multi-part message in MIME format.
--------------030602080700070900090203
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 381

On 30/03/2011 22:29, Christopher Faylor wrote:
> On Wed, Mar 30, 2011 at 11:15:56PM +0200, Corinna Vinschen wrote:
>> Chris, are you going to take a look into this patch?
> 
> yep.

Attached is an updated version of the patch which fixes the warning identified
by Yaakov.

I've also attached a slightly cleaned up version of the additional fork
debugging output patch I was using.

--------------030602080700070900090203
Content-Type: text/plain;
 name="dll_init.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dll_init.patch"
Content-length: 3409


2011-03-12  Jon TURNEY  <jon.turney@dronecode.org.uk>

	* dll_init.cc (reserve_at, release_at): New functions.
	(load_after_fork): Make a 3rd pass at trying to load the DLL in
	the right place.


Index: cygwin/dll_init.cc
===================================================================
--- cygwin/dll_init.cc.orig	2011-03-27 18:19:06.000000000 +0100
+++ cygwin/dll_init.cc	2011-03-28 23:43:47.125000000 +0100
@@ -254,15 +254,47 @@
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
@@ -281,15 +313,26 @@
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
+              preferred_block = 0;
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
 
@@ -299,6 +342,15 @@
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

--------------030602080700070900090203
Content-Type: text/plain;
 name="dll_init_debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dll_init_debug.patch"
Content-length: 2804

2011-04-04  Jon TURNEY  <jon.turney@dronecode.org.uk>

	* dll_init.cc (load_after_fork): Add some debug output...
	* environ.cc (parse_thing): ... controlled by 'forkdebug' setting


Index: winsup/cygwin/dll_init.cc
===================================================================
--- winsup.orig/cygwin/dll_init.cc	2011-04-02 21:40:02.000000000 +0100
+++ winsup/cygwin/dll_init.cc	2011-04-03 18:47:09.781250000 +0100
@@ -29,6 +29,7 @@
 dll_list dlls;
 
 static bool dll_global_dtors_recorded;
+bool fork_debug = FALSE;
 
 /* Run destructors for all DLLs on exit. */
 void
@@ -307,6 +308,8 @@
 	     above, the second LoadLibrary will not execute its startup code
 	     unless it is first unloaded. */
 	  HMODULE h = LoadLibraryExW (d->name, NULL, DONT_RESOLVE_DLL_REFERENCES);
+	  if (fork_debug)
+	    system_printf("LoadLibrary %W @ %p (pass %d)", d->name, h, i);
 
 	  if (!h)
 	    system_printf ("can't reload %W, %E", d->name);
@@ -332,7 +335,11 @@
             }
 
 	  if (h == d->handle)
-	    break;		/* Success */
+            {
+              if (fork_debug)
+                system_printf("successfully mapped %W @ %p", d->name, d->handle);
+              break;		/* Success */
+            }
 
 	  if (i > 1)
 	    /* We tried to relocate the dll and it failed. */
@@ -344,6 +351,8 @@
 	     load into the same address space.  In the "forked" process, the
 	     second DLL always loads into a different location. So, block all
 	     of the memory up to the new load address and try again. */
+	  if (fork_debug)
+	    system_printf("reserve_upto %p to try to force it to load there", d->handle);
 	  reserve_upto (d->name, (DWORD) d->handle);
 
           /* Dll *still* loaded in the wrong place.  This can happen if it
@@ -352,6 +361,8 @@
              preferred address and try again. */
           if (i > 0)
             {
+              if (fork_debug)
+                system_printf("reserved_at %p to try to force it to load elsewhere", h);
               preferred_block = reserve_at(d->name, (DWORD)h);
             }
 	}
Index: winsup/cygwin/environ.cc
===================================================================
--- winsup.orig/cygwin/environ.cc	2011-04-02 22:26:44.000000000 +0100
+++ winsup/cygwin/environ.cc	2011-04-02 22:28:10.937500000 +0100
@@ -37,6 +37,7 @@
 bool reset_com = false;
 static bool envcache = true;
 static bool create_upcaseenv = false;
+extern bool fork_debug;
 
 static char **lastenviron;
 
@@ -605,6 +606,7 @@
   {"tty", {NULL}, set_process_state, NULL, {{0}, {PID_USETTY}}},
   {"upcaseenv", {&create_upcaseenv}, justset, NULL, {{false}, {true}}},
   {"winsymlinks", {&allow_winsymlinks}, justset, NULL, {{false}, {true}}},
+  {"forkdebug", {&fork_debug}, justset, NULL, {{false}, {true}}},
   {NULL, {0}, justset, 0, {{0}, {0}}}
 };
 

--------------030602080700070900090203--
