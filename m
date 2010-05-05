Return-Path: <cygwin-patches-return-7021-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13986 invoked by alias); 5 May 2010 16:35:25 -0000
Received: (qmail 13957 invoked by uid 22791); 5 May 2010 16:35:20 -0000
X-SWARE-Spam-Status: No, hits=-2.2 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-bw0-f214.google.com (HELO mail-bw0-f214.google.com) (209.85.218.214)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 05 May 2010 16:35:12 +0000
Received: by bwz6 with SMTP id 6so3378562bwz.19        for <cygwin-patches@cygwin.com>; Wed, 05 May 2010 09:35:09 -0700 (PDT)
Received: by 10.204.74.77 with SMTP id t13mr1113077bkj.7.1273077309081;        Wed, 05 May 2010 09:35:09 -0700 (PDT)
Received: from [192.168.2.99] (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])        by mx.google.com with ESMTPS id 24sm326815bkr.0.2010.05.05.09.35.03        (version=SSLv3 cipher=RC4-MD5);        Wed, 05 May 2010 09:35:04 -0700 (PDT)
Message-ID: <4BE1A2C5.4090604@gmail.com>
Date: Wed, 05 May 2010 16:35:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: CFA: pseudo-reloc v2
References: <4AC7910E.1010900@cwilson.fastmail.fm> <4AC82056.7060308@cwilson.fastmail.fm>
In-Reply-To: <4AC82056.7060308@cwilson.fastmail.fm>
Content-Type: multipart/mixed; boundary="------------030900090304080303000405"
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
X-SW-Source: 2010-q2/txt/msg00004.txt.bz2

This is a multi-part message in MIME format.
--------------030900090304080303000405
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 2627

[ redirected from cygwin-developers. ]
On 04/10/2009 05:11, Charles Wilson wrote:
[ thread seriously necro'd! ]
> Dave Korn wrote:
>> Charles Wilson wrote:
>>>   120 void
>>>   121 _pei386_runtime_relocator ()
>>>   122 {
>>>   123   static int was_init = 0;
>>>   124   if (was_init)
>>>   125     return;
>>>   126   ++was_init;
>>>   127   do_pseudo_reloc (&__RUNTIME_PSEUDO_RELOC_LIST__,&__RUNTIME_PSEUDO_RELOC_LIST_END__,&_image_base__);
>>>   128 }
>>   Maybe that static should be NO_COPY?  If everything gets remapped in the
>> forkee, do the relocs need rerunning?  (I'm not sure about the behaviour of
>> NtCreateProcess w.r.t modified .text section pages.)
> 
> Good guess!  With the following patch, all of these fork tests perform
> as expected.

  Aha, not so good as all that after all!  We need to re-apply relocs in the
forkee - but only if they *don't* point to regions covered by the .data/.bss
section copying at startup.  Argh!

>  One oddity; it turns out that __INSIDE_CYGWIN__ is not
> defined inside pseudo-reloc.c, so I used __CYGWIN__ as a guard.

  Dunno if we ever went into that, but it's right; pseudo-reloc.o is part of
the CRT in winsup/cygwin/lib/, and is linked statically into every exe and
(user) dll, but is not part of the cygwin1 dll.  Hence not "inside Cygwin".

  So, the attached is my proposed fix.  It resolves the problem reported on
the main list the other day(*) and the supplied testcases all work once it's
applied.  There are two things that people might want to change: the minor one
is that I let a couple of the lines get a bit long, but no longer than we
already have in the definition of NO_COPY at the top of the file, so I didn't
wrap them for the sake of one trailing word.  The slightly bigger one is that,
if I remember, the reason for having non-#if-CYGWIN code in the file at all is
to make any potential future merges from upstream MinGW sources theoretically
easier, but now that I've had to diverge the internal interfaces anyway, is
there any reason not to just delete the whole lot?

winsup/cygwin/ChangeLog:

	lib/pseudo-reloc.c (memskip_t): New struct and typedef.
	(__write_memory): Accept an optional memskip_t argument and avoid
	writing to any memory ranges mentioned in the linked list.
	(do_pseudo_reloc): Accept an optional memskip_t argument and pass
	it through in all calls to __write_memory.
	(_pei386_runtime_relocator): When reapplying relocs in a forked
	child process, avoid doubly-relocating the .data and .bss sections
	that were copied from the parent.

    cheers,
      DaveK
-- 
(*) - http://cygwin.com/ml/cygwin/2010-04/msg00957.html


--------------030900090304080303000405
Content-Type: text/x-c;
 name="fix-double-relocs.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fix-double-relocs.diff"
Content-length: 6665

Index: winsup/cygwin/lib/pseudo-reloc.c
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/lib/pseudo-reloc.c,v
retrieving revision 1.4
diff -p -u -r1.4 pseudo-reloc.c
--- winsup/cygwin/lib/pseudo-reloc.c	26 Oct 2009 14:50:09 -0000	1.4
+++ winsup/cygwin/lib/pseudo-reloc.c	5 May 2010 16:04:46 -0000
@@ -78,6 +78,20 @@ typedef struct {
   DWORD version;
 } runtime_pseudo_reloc_v2;
 
+/* This trivial struct is passed right down through do_pseudo_reloc
+   to __write_memory where it is used to avoid re-relocating those
+   memory areas that we know will have been pre-relocated by copying
+   from the parent of a forked child process.  Since there will only
+   ever be two ranges it's not worth worrying hugely about making it
+   efficient so a simple singly-linked list will do; if we ever start
+   encountering user applications with more than a few hundred or so
+   pseudo-relocs, there might come a time to rethink this.  */
+typedef struct memskip {
+  DWORD start;
+  DWORD end;
+  const struct memskip *next;
+} memskip_t;
+
 static void ATTRIBUTE_NORETURN
 __report_error (const char *msg, ...)
 {
@@ -169,7 +183,7 @@ __report_error (const char *msg, ...)
  * is folded into the (writable) .data when --enable-auto-import.
  */
 static void
-__write_memory (void *addr, const void *src, size_t len)
+__write_memory (void *addr, const void *src, size_t len, const memskip_t *skipranges)
 {
   MEMORY_BASIC_INFORMATION b;
   DWORD oldprot;
@@ -177,6 +191,13 @@ __write_memory (void *addr, const void *
   if (!len)
     return;
 
+  while (skipranges)
+    {
+      if ((skipranges->start <= (DWORD)addr) && (skipranges->end > (DWORD)addr))
+	return;
+      skipranges = skipranges->next;
+    }
+
   if (!VirtualQuery (addr, &b, sizeof(b)))
     {
       __report_error ("  VirtualQuery failed for %d bytes at address %p",
@@ -198,7 +219,7 @@ __write_memory (void *addr, const void *
 #define RP_VERSION_V2 1
 
 static void
-do_pseudo_reloc (void * start, void * end, void * base)
+do_pseudo_reloc (void * start, void * end, void * base, const memskip_t *skipranges)
 {
   ptrdiff_t addr_imp, reldata;
   ptrdiff_t reloc_target = (ptrdiff_t) ((char *)end - (char*)start);
@@ -259,7 +280,7 @@ do_pseudo_reloc (void * start, void * en
 	  DWORD newval;
 	  reloc_target = (ptrdiff_t) base + o->target;
 	  newval = (*((DWORD*) reloc_target)) + o->addend;
-	  __write_memory ((void *) reloc_target, &newval, sizeof(DWORD));
+	  __write_memory ((void *) reloc_target, &newval, sizeof(DWORD), skipranges);
 	}
       return;
     }
@@ -337,17 +358,17 @@ do_pseudo_reloc (void * start, void * en
       switch ((r->flags & 0xff))
 	{
          case 8:
-           __write_memory ((void *) reloc_target, &reldata, 1);
+           __write_memory ((void *) reloc_target, &reldata, 1, skipranges);
 	   break;
 	 case 16:
-           __write_memory ((void *) reloc_target, &reldata, 2);
+           __write_memory ((void *) reloc_target, &reldata, 2, skipranges);
 	   break;
 	 case 32:
-           __write_memory ((void *) reloc_target, &reldata, 4);
+           __write_memory ((void *) reloc_target, &reldata, 4, skipranges);
 	   break;
 #ifdef _WIN64
 	 case 64:
-           __write_memory ((void *) reloc_target, &reldata, 8);
+           __write_memory ((void *) reloc_target, &reldata, 8, skipranges);
 	   break;
 #endif
 	}
@@ -357,11 +378,57 @@ do_pseudo_reloc (void * start, void * en
 void
 _pei386_runtime_relocator (void)
 {
+  /* We only want to apply the pseudo-relocs once, so we use this once-only
+     guard variable - no need for complex serialisation or synchronisation
+     here, as we're in early start-up (if an exe) or at process attach time
+     (if a dll) and we'll be implicitly running single-threaded anyway.
+
+     However, when we fork a process, the OS creates fresh mappings of all
+     the image files, so the pseudo-relocs all get wiped out and we need
+     to reapply them; hence, the guard variable is NO_COPY, so that it
+     starts from zero again in the forked child, and we apply the relocs
+     again.  */
   static NO_COPY int was_init = 0;
+  /* But it isn't quite that simple.  During fork startup the parent and
+     child co-operate to synchronize the memory: code in the Cygwin DLL
+     copies across all the (non-read-only) data and bss sections of the
+     exe and loaded dlls, not to mention heap and stack areas; this is
+     how all the variables in the child end up with the same content as
+     the parent, but it effectively pre-applies any pseudo-relocs that
+     point into those regions for us, as their effect has been copied
+     from the parent.  We need to avoid re-applying them when we fork
+     or the data will end up doubly-relocated and pointing randomly into
+     space, which is obviously a problem.  So we also have a once-only
+     guard variable that does *not* use the NO_COPY attribute; this
+     guard variable won't be reset on a fork but will remain set from
+     the parent, letting us infer that we are re-applying pseudo-relocs
+     in a child process rather than applying them for the first time
+     in an entirely newly-created process.  */
+  static char was_forked = 0;
+  /* In that case, we want to avoid applying any pseudo-relocs that we
+     know will already have been copied, pre-applied, from the parent's
+     .data and .bss sections.  See the references to child_copy() in
+     dcrt0.cc#child_info_fork::handle_fork() and fork.cc#frok::parent()
+     for the details.  We take advantage here of the fact that this code
+     is part of the winsup/cygwin/lib/ runtime library startup code,
+     linked as a static object into each exe and dll rather than being
+     part of the Cygwin DLL itself; this means we can simply look at the
+     linker-supplied labels marking the start and end of our own .data
+     and .bss sections to know which memory areas to avoid re-relocating,
+     and don't have to worry about any complicated mechanism for the DLL
+     to inform us which memory areas it copied.  Phew!  */
+  extern char _data_start__, _data_end__, _bss_start__, _bss_end__;
+  static const memskip_t skipchain[2] = {
+    { .start = (DWORD)&_data_start__, .end = (DWORD)&_data_end__, .next = &skipchain[1] },
+    { .start = (DWORD)&_bss_start__, .end = (DWORD)&_bss_end__, .next = 0 }
+  };
+
   if (was_init)
     return;
   ++was_init;
   do_pseudo_reloc (&__RUNTIME_PSEUDO_RELOC_LIST__,
 		   &__RUNTIME_PSEUDO_RELOC_LIST_END__,
-		   &__MINGW_LSYMBOL(_image_base__));
+		   &__MINGW_LSYMBOL(_image_base__),
+		   was_forked ? skipchain : NULL);
+  was_forked = 1;
 }

--------------030900090304080303000405--
