Return-Path: <cygwin-patches-return-7273-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6682 invoked by alias); 6 Apr 2011 11:54:34 -0000
Received: (qmail 6671 invoked by uid 22791); 6 Apr 2011 11:54:33 -0000
X-SWARE-Spam-Status: No, hits=-2.6 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from smtpout.karoo.kcom.com (HELO smtpout.karoo.kcom.com) (212.50.160.34)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 06 Apr 2011 11:54:28 +0000
Received: from 213-152-38-55.dsl.eclipse.net.uk (HELO [192.168.0.8]) ([213.152.38.55])  by smtpout.karoo.kcom.com with ESMTP; 06 Apr 2011 12:54:23 +0100
Message-ID: <4D9C5482.10303@dronecode.org.uk>
Date: Wed, 06 Apr 2011 11:54:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add an additional relocation attempt pass to load_after_fork()
References: <20110313152111.GA7064@calimero.vinschen.de> <4D7E908B.4010004@dronecode.org.uk> <20110315075313.GA5722@calimero.vinschen.de> <20110315150412.GA18662@ednor.casa.cgf.cx> <20110315154609.GE4320@calimero.vinschen.de> <20110330211556.GE13484@calimero.vinschen.de> <20110330212951.GC28494@ednor.casa.cgf.cx> <4D99BCCE.60407@dronecode.org.uk> <20110404143917.GA1140@ednor.casa.cgf.cx> <4D9B3D5F.4040306@dronecode.org.uk> <20110405162102.GA18669@ednor.casa.cgf.cx>
In-Reply-To: <20110405162102.GA18669@ednor.casa.cgf.cx>
Content-Type: multipart/mixed; boundary="------------070706020804020608080801"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00039.txt.bz2

This is a multi-part message in MIME format.
--------------070706020804020608080801
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 934

On 05/04/2011 17:21, Christopher Faylor wrote:
> On Tue, Apr 05, 2011 at 05:03:43PM +0100, Jon TURNEY wrote:
>> On 04/04/2011 15:39, Christopher Faylor wrote:
> I'm trying to imagine a scenario where it would screw up to just do the
> reserve_upto + "reserve the low block" and I can't think of one.  It's
> potentially a little more work, of course, but I think it may catch the
> more common failing conditions so it shouldn't be too noticeable.
> 
>>> If so, it seems like we're allocating and freeing the space up to the DLL more
>>> than once.  I think we could avoid doing that.
>>
>> For performance reasons, I think you are right.  Or do you mean there is a
>> correctness issue with that?
>>
>> If you indicate your preferences I'll respin the patch.
>>
>> 1) Combine passes 2 and 3
> 
> I'd prefer this.  If we can get people test the snapshot maybe we an
> figure out if a separate loop is useful.

Updated patch attached.

--------------070706020804020608080801
Content-Type: text/plain;
 name="dll_init.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dll_init.patch"
Content-length: 3592

2011-04-06  Jon TURNEY  <jon.turney@dronecode.org.uk>

	* dll_init.cc (reserve_at, release_at): New functions.
	(load_after_fork): If the DLL was loaded higher than the required
	address, assume that it loaded at it's base address and also reserve
	memory there to force it to be relocated.

Index: cygwin/dll_init.cc
===================================================================
--- cygwin/dll_init.cc.orig	2011-04-06 10:32:08.242187500 +0100
+++ cygwin/dll_init.cc	2011-04-06 10:44:33.250000000 +0100
@@ -257,12 +257,44 @@
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
       for (int i = 0; i < 2; i++)
@@ -284,10 +316,18 @@
 	      if (h == d->handle)
 		h = LoadLibraryW (d->name);
 	    }
+
 	  /* If we reached here on the second iteration of the for loop
 	     then there is a lot of memory to release. */
 	  if (i > 0)
-	    release_upto (d->name, (DWORD) d->handle);
+            {
+              release_upto (d->name, (DWORD) d->handle);
+
+              if (preferred_block)
+                release_at(d->name, preferred_block);
+              preferred_block = 0;
+            }
+
 	  if (h == d->handle)
 	    break;		/* Success */
 
@@ -297,11 +337,20 @@
 		       d->name, d->handle, h);
 
 	  /* Dll loaded in the wrong place.  Dunno why this happens but it
-	     always seems to happen when there are multiple DLLs attempting to
-	     load into the same address space.  In the "forked" process, the
-	     second DLL always loads into a different location. So, block all
-	     of the memory up to the new load address and try again. */
+             always seems to happen when there are multiple DLLs with the
+             same base address.  In the "forked" process, the relocated DLL
+             may load at a different address. So, block all of the memory up
+             to the relocated load address and try again. */
 	  reserve_upto (d->name, (DWORD) d->handle);
+
+          /* Also, if the DLL loaded at a higher address than wanted (probably
+             it's base address), reserve the memory at that address. This can
+             happen if it couldn't load at the preferred base in the parent, but
+             can in the child, due to differences in the load ordering.
+             Block memory at it's preferred address and try again. */
+          if ((DWORD)h > (DWORD)d->handle)
+            preferred_block = reserve_at(d->name, (DWORD)h);
+
 	}
   in_forkee = false;
 }

--------------070706020804020608080801--
