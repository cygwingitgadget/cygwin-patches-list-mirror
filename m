Return-Path: <cygwin-patches-return-7718-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24533 invoked by alias); 3 Sep 2012 11:25:12 -0000
Received: (qmail 23961 invoked by uid 22791); 3 Sep 2012 11:24:48 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Mon, 03 Sep 2012 11:24:31 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B62082C0259; Mon,  3 Sep 2012 13:24:28 +0200 (CEST)
Date: Mon, 03 Sep 2012 11:25:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] suggestion for faster pseudo-reloc.
Message-ID: <20120903112428.GN13401@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <503982F3.9010004@gmail.com> <20120902102718.GC13401@calimero.vinschen.de> <50439CAE.6080603@gmail.com> <50441E6B.7060703@cwilson.fastmail.fm> <504479A3.6080609@users.sourceforge.net> <20120903103518.GK13401@calimero.vinschen.de> <50448E3E.208@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="f2QGlHpHGjS2mn6Y"
Content-Disposition: inline
In-Reply-To: <50448E3E.208@users.sourceforge.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q3/txt/msg00039.txt.bz2


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-length: 1536

On Sep  3 19:02, JonY wrote:
> On 9/3/2012 18:35, Corinna Vinschen wrote:
> > On Sep  3 17:34, JonY wrote:
> >> On 9/3/2012 11:05, Charles Wilson wrote:
> >>> On 9/2/2012 1:51 PM, Jin-woo Ye wrote:
> >>>> Now it is clear that this patch would be needed other relevant projects
> >>>> such as mingw, mingw-w64. thanks for your effort on simplified one.
> >>>
> >>> Yes, while it is not required that all of those systems stay exactly in
> >>> sync, there has been some effort in ensuring that the pseudo-reloc
> >>> implementation used by all three remains very similar if not identical.
> >>>
> >>> Please bring this patch to the attention of the mingw.org and
> >>> mingw64.sf.net people, if it's not too much trouble.
> >>>
> >>> --
> >>> Chuck
> >>>
> >>>
> >>>
> >>
> >> Original message already forwarded to mingw-w64 devel list. Thanks
> >> Jin-woo Ye.
> > 
> > Do you want the patch I eventually applied, too?
> > 
> > 
> > Corinna
> > 
> 
> Yeah, that will be good too.
> 
> I forwarded the CVS commit message too.

It differs a lot from the original source, so you might contemplate
to send a follow up mail to the mingw-w64 devel with the attached
patch.

> I'm not sure if anybody else is
> more suited to comment on it than Kai, he is still on vacation though.

No worries.  I'm on vacation myself.  If my slipped disc hadn't kept me
home, I would be in England now :|


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat

--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="pseudo-reloc.diff"
Content-length: 3361

===================================================================
RCS file: /cvs/src/src/winsup/cygwin/pseudo-reloc.cc,v
retrieving revision 1.10
retrieving revision 1.11
diff -u -r1.10 -r1.11
--- src/winsup/cygwin/pseudo-reloc.cc	2012/08/16 23:34:44	1.10
+++ src/winsup/cygwin/pseudo-reloc.cc	2012/09/02 10:21:34	1.11
@@ -126,6 +126,49 @@
 #endif
 }
 
+/*
+ * This function automatically sets addr as PAGE_EXECUTE_READWRITE
+ * by deciding whether VirtualQuery for the addr is actually needed.
+ * And it assumes that it is called in LdrpCallInitRoutine.
+ * Hence not thread safe.
+ */
+static void
+auto_protect_for (void* addr)
+{
+  static MEMORY_BASIC_INFORMATION mbi;
+  static bool state = false;
+  static DWORD oldprot;
+
+  if (!addr)
+    {
+      /* Restore original protection. */
+      if (!(mbi.Protect & (PAGE_EXECUTE_READWRITE | PAGE_READWRITE)))
+        VirtualProtect (mbi.BaseAddress, mbi.RegionSize, oldprot, &oldprot);
+      state = false;
+      return;
+    }
+  if (state)
+    {
+      /* We have valid region information.  Are we still within this region?
+         If so, just leave. */
+      void *ptr = ((void*) ((ptrdiff_t) mbi.BaseAddress + mbi.RegionSize));
+      if (addr >= mbi.BaseAddress && addr < ptr)
+	return;
+      /* Otherwise, restore original protection and fall through to querying
+         and potentially changing next region. */
+      if (!(mbi.Protect & (PAGE_EXECUTE_READWRITE | PAGE_READWRITE)))
+	VirtualProtect (mbi.BaseAddress, mbi.RegionSize, oldprot, &oldprot);
+    }
+  else
+    state = true;
+  /* Query region and temporarily allow write access to read-only protected
+     memory.  */
+  VirtualQuery (addr, &mbi, sizeof mbi);
+  if (!(mbi.Protect & (PAGE_EXECUTE_READWRITE | PAGE_READWRITE)))
+    VirtualProtect (mbi.BaseAddress, mbi.RegionSize,
+	PAGE_EXECUTE_READWRITE, &oldprot);
+}
+
 /* This function temporarily marks the page containing addr
  * writable, before copying len bytes from *src to *addr, and
  * then restores the original protection settings to the page.
@@ -142,27 +185,12 @@
 static void
 __write_memory (void *addr, const void *src, size_t len)
 {
-  MEMORY_BASIC_INFORMATION b;
-  DWORD oldprot;
-
   if (!len)
     return;
-
-  if (!VirtualQuery (addr, &b, sizeof (b)))
-    {
-      __report_error ("  VirtualQuery failed for %d bytes at address %p",
-		      (int) sizeof (b), addr);
-    }
-
-  /* Temporarily allow write access to read-only protected memory.  */
-  if (b.Protect != PAGE_EXECUTE_READWRITE && b.Protect != PAGE_READWRITE)
-    VirtualProtect (b.BaseAddress, b.RegionSize, PAGE_EXECUTE_READWRITE,
-		  &oldprot);
+  /* Fix page protection for writing. */
+  auto_protect_for (addr);
   /* write the data. */
   memcpy (addr, src, len);
-  /* Restore original protection. */
-  if (b.Protect != PAGE_EXECUTE_READWRITE && b.Protect != PAGE_READWRITE)
-    VirtualProtect (b.BaseAddress, b.RegionSize, oldprot, &oldprot);
 }
 
 #define RP_VERSION_V1 0
@@ -232,6 +260,8 @@
 	  newval = (*((DWORD*) reloc_target)) + o->addend;
 	  __write_memory ((void *) reloc_target, &newval, sizeof (DWORD));
 	}
+      /* Restore original protection. */
+      auto_protect_for (NULL);
       return;
     }
 
@@ -322,7 +352,9 @@
 	  break;
 #endif
 	}
-     }
+    }
+  /* Restore original protection. */
+  auto_protect_for (NULL);
 }
 
 #ifdef __CYGWIN__

--f2QGlHpHGjS2mn6Y--
