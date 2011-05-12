Return-Path: <cygwin-patches-return-7347-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31313 invoked by alias); 12 May 2011 15:10:34 -0000
Received: (qmail 31158 invoked by uid 22791); 12 May 2011 15:09:49 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 12 May 2011 15:09:13 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B11C32C0577; Thu, 12 May 2011 17:09:10 +0200 (CEST)
Date: Thu, 12 May 2011 15:10:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Extending /proc/*/maps
Message-ID: <20110512150910.GE18135@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4DCA1E59.4070800@cs.utoronto.ca> <20110511111455.GC11041@calimero.vinschen.de> <4DCACB72.6070201@cs.utoronto.ca> <20110511193107.GF11041@calimero.vinschen.de> <20110512121012.GB18135@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20110512121012.GB18135@calimero.vinschen.de>
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
X-SW-Source: 2011-q2/txt/msg00113.txt.bz2

On May 12 14:10, Corinna Vinschen wrote:
> On May 11 21:31, Corinna Vinschen wrote:
> > On May 11 13:46, Ryan Johnson wrote:
> > > Given that Heap32* has already been reverse-engineered by others,
> > > the main challenge would involve sorting the set of heap block
> > > addresses and distilling them down to a set of allocation bases. We
> > > don't want to do repeated linear searches over 50k+ heap blocks.
> > 
> > While the base address of the heap is available in
> > DEBUG_HEAP_INFORMATION, I don't see the size of the heap.  Maybe it's in
> > the block of 7 ULONGs marked as "Reserved"?  It must be somewhere.
> > Assuming just that, you could scan the list of blocks once and drop
> > those within the orignal heap allocation.  The remaining blocks are big
> > blocks which have been allocated by additional calls to VirtualAlloc.
> 
> After some debugging, I now have the solution. [...]

Here's a prelimiary patch to fhandler_process.cc which takes everything
into account I have learned in the meantime.  For instance, there are
actually heaps marked as shareable.  Please have a look.  What's missing
is the flag for low-fragmentation heaps, but I'm just hunting for it.


Corinna


Index: fhandler_process.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_process.cc,v
retrieving revision 1.96
diff -u -p -r1.96 fhandler_process.cc
--- fhandler_process.cc	11 May 2011 10:31:22 -0000	1.96
+++ fhandler_process.cc	12 May 2011 15:08:03 -0000
@@ -609,39 +609,78 @@ struct dos_drive_mappings
   }
 };
 
+/* Known heap flags */
+#define HEAP_FLAG_NOSERIALIZE	0x1
+#define HEAP_FLAG_GROWABLE	0x2
+#define HEAP_FLAG_EXCEPTIONS	0x4
+#define HEAP_FLAG_NONDEFAULT	0x1000
+#define HEAP_FLAG_SHAREABLE	0x8000
+#define HEAP_FLAG_EXECUTABLE	0x40000
+
 struct heap_info
 {
   struct heap
   {
     heap *next;
-    void *base;
+    unsigned heap_id;
+    uintptr_t base;
+    uintptr_t end;
+    unsigned long flags;
   };
   heap *heaps;
 
   heap_info (DWORD pid)
     : heaps (0)
   {
-    HANDLE hHeapSnap = CreateToolhelp32Snapshot (TH32CS_SNAPHEAPLIST, pid);
-    HEAPLIST32 hl;
-    hl.dwSize = sizeof(hl);
-
-    if (hHeapSnap != INVALID_HANDLE_VALUE && Heap32ListFirst (hHeapSnap, &hl))
-      do
-	{
-	  heap *h = (heap *) cmalloc (HEAP_FHANDLER, sizeof (heap));
-	  *h = (heap) {heaps, (void*) hl.th32HeapID};
-	  heaps = h;
-	} while (Heap32ListNext (hHeapSnap, &hl));
-    CloseHandle (hHeapSnap);
+    PDEBUG_BUFFER buf;
+    NTSTATUS status;
+    PDEBUG_HEAP_ARRAY harray;
+
+    buf = RtlCreateQueryDebugBuffer (0, FALSE);
+    if (!buf)
+      return;
+    status = RtlQueryProcessDebugInformation (pid, PDI_HEAPS | PDI_HEAP_BLOCKS,
+					      buf);
+    if (NT_SUCCESS (status)
+	&& (harray = (PDEBUG_HEAP_ARRAY) buf->HeapInformation) != NULL)
+      for (ULONG hcnt = 0; hcnt < harray->Count; ++hcnt)
+      	{
+	  PDEBUG_HEAP_BLOCK barray = (PDEBUG_HEAP_BLOCK)
+				     harray->Heaps[hcnt].Blocks;
+	  if (!barray)
+	    continue;
+	  for (ULONG bcnt = 0; bcnt < harray->Heaps[hcnt].BlockCount; ++bcnt)
+	    if (barray[bcnt].Flags & 2)
+	      {
+		heap *h = (heap *) cmalloc (HEAP_FHANDLER, sizeof (heap));
+		*h = (heap) {heaps, hcnt, barray[bcnt].Address,
+			     barray[bcnt].Address + barray[bcnt].Size,
+			     harray->Heaps[hcnt].Flags};
+		heaps = h;
+	      }
+	}
+    RtlDestroyQueryDebugBuffer (buf);
   }
   
-  char *fill_if_match (void *base, char *dest )
+  char *fill_if_match (void *base, ULONG type, char *dest )
   {
-    long count = 0;
-    for (heap *h = heaps; h && ++count; h = h->next)
-      if (base == h->base)
+    for (heap *h = heaps; h; h = h->next)
+      if ((uintptr_t) base >= h->base && (uintptr_t) base < h->end)
 	{
-	  __small_sprintf (dest, "[heap %ld]", count);
+	  char *p;
+	  __small_sprintf (dest, "[heap %ld", h->heap_id);
+	  p = strchr (dest, '\0');
+	  if (!(h->flags & HEAP_FLAG_NONDEFAULT))
+	    p = stpcpy (p, " default");
+	  if ((h->flags & HEAP_FLAG_SHAREABLE) && (type & MEM_MAPPED))
+	    p = stpcpy (p, " share");
+	  if (h->flags & HEAP_FLAG_EXECUTABLE)
+	    p = stpcpy (p, " exec");
+	  if (h->flags & HEAP_FLAG_GROWABLE)
+	    p = stpcpy (p, " grow");
+	  if (h->flags & HEAP_FLAG_NOSERIALIZE)
+	    p = stpcpy (p, " noserial");
+	  stpcpy (p, "]");
 	  return dest;
 	}
     return 0;
@@ -777,11 +816,13 @@ format_process_maps (void *data, char *&
 		    sys_wcstombs (posix_modname, NT_MAX_PATH, dosname);
 		  stat64 (posix_modname, &st);
 		}
-	      else if (mb.Type & MEM_MAPPED)
-		strcpy (posix_modname, "[shareable]");
-	      else if (!(mb.Type & MEM_PRIVATE
-			 && heaps.fill_if_match (cur.abase, posix_modname)))
-		posix_modname[0] = 0;
+	      else if (!heaps.fill_if_match (cur.abase, mb.Type, posix_modname))
+		{
+		  if (mb.Type & MEM_MAPPED)
+		    strcpy (posix_modname, "[shareable]");
+		  else
+		    posix_modname[0] = 0;
+		}
 	    }
 	}
     }
Index: ntdll.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/ntdll.h,v
retrieving revision 1.117
diff -u -p -r1.117 ntdll.h
--- ntdll.h	11 May 2011 13:25:27 -0000	1.117
+++ ntdll.h	12 May 2011 15:08:03 -0000
@@ -63,6 +63,7 @@
 
 #define PDI_MODULES 0x01
 #define PDI_HEAPS 0x04
+#define PDI_HEAP_BLOCKS 0x10
 #define LDRP_IMAGE_DLL 0x00000004
 #define WSLE_PAGE_READONLY 0x001
 #define WSLE_PAGE_EXECUTE 0x002
@@ -525,6 +526,20 @@ typedef struct _DEBUG_HEAP_INFORMATION
   PVOID Blocks;
 } DEBUG_HEAP_INFORMATION, *PDEBUG_HEAP_INFORMATION;
 
+typedef struct _DEBUG_HEAP_ARRAY
+{
+  ULONG Count;
+  DEBUG_HEAP_INFORMATION Heaps[1];
+} DEBUG_HEAP_ARRAY, *PDEBUG_HEAP_ARRAY;
+
+typedef struct _DEBUG_HEAP_BLOCK
+{
+  ULONG Size;
+  ULONG Flags;
+  ULONG Unknown;
+  ULONG Address;
+} DEBUG_HEAP_BLOCK, *PDEBUG_HEAP_BLOCK;
+
 typedef struct _DEBUG_MODULE_INFORMATION
 {
   ULONG Reserved[2];


-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
