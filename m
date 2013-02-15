Return-Path: <cygwin-patches-return-7797-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23100 invoked by alias); 15 Feb 2013 08:03:04 -0000
Received: (qmail 23071 invoked by uid 22791); 15 Feb 2013 08:03:03 -0000
X-SWARE-Spam-Status: No, hits=-4.6 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,KHOP_RCVD_TRUST,KHOP_SPAMHAUS_DROP,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mail-vc0-f181.google.com (HELO mail-vc0-f181.google.com) (209.85.220.181)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 15 Feb 2013 08:02:51 +0000
Received: by mail-vc0-f181.google.com with SMTP id d16so2057381vcd.12        for <cygwin-patches@cygwin.com>; Fri, 15 Feb 2013 00:02:50 -0800 (PST)
X-Received: by 10.58.106.161 with SMTP id gv1mr2009370veb.35.1360915370299;        Fri, 15 Feb 2013 00:02:50 -0800 (PST)
Received: from YAAKOV04 (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id o6sm80278287vdd.11.2013.02.15.00.02.48        (version=SSLv3 cipher=RC4-SHA bits=128/128);        Fri, 15 Feb 2013 00:02:49 -0800 (PST)
Date: Fri, 15 Feb 2013 08:03:00 -0000
From: Yaakov (Cygwin/X) <yselkowitz@users.sourceforge.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH 64bit] utils: port dumper to 64bit
Message-ID: <20130215020235.3f769e45@YAAKOV04>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/MTY5d6A=n3=zD_1DLHuVV_p"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2013-q1/txt/msg00008.txt.bz2


--MP_/MTY5d6A=n3=zD_1DLHuVV_p
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Content-length: 212

I just uploaded cygwin64-libiconv, cygwin64-gettext, and
cygwin64-libbfd to Ports, so that dumper.exe could be built.  It
appears it hasn't been ported yet, so here's a first attempt.  Comments
welcome.


Yaakov

--MP_/MTY5d6A=n3=zD_1DLHuVV_p
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=utils-dumper-64bit.patch
Content-length: 9485

Index: dumper.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/dumper.cc,v
retrieving revision 1.20.2.1
diff -u -p -r1.20.2.1 dumper.cc
--- dumper.cc	23 Nov 2012 15:14:40 -0000	1.20.2.1
+++ dumper.cc	15 Feb 2013 07:53:24 -0000
@@ -1,6 +1,6 @@
 /* dumper.cc
 
-   Copyright 1999, 2001, 2002, 2004, 2006, 2007, 2011 Red Hat Inc.
+   Copyright 1999, 2001, 2002, 2004, 2006, 2007, 2011, 2013 Red Hat Inc.
 
    Written by Egor Duda <deo@logos-m.ru>
 
@@ -84,7 +84,8 @@ dumper::dumper (DWORD pid, DWORD tid, co
 			  pid);
   if (!hProcess)
     {
-      fprintf (stderr, "Failed to open process #%lu, error %ld\n", pid, GetLastError ());
+      fprintf (stderr, "Failed to open process #%lu, error %ld\n",
+	       (unsigned long) pid, (long) GetLastError ());
       return;
     }
 
@@ -192,7 +193,7 @@ dumper::add_thread (DWORD tid, HANDLE hT
 }
 
 int
-dumper::add_mem_region (LPBYTE base, DWORD size)
+dumper::add_mem_region (LPBYTE base, SIZE_T size)
 {
   if (!sane ())
     return 0;
@@ -209,14 +210,15 @@ dumper::add_mem_region (LPBYTE base, DWO
   new_entity->u.memory.base = base;
   new_entity->u.memory.size = size;
 
-  deb_printf ("added memory region %08x-%08x\n", (DWORD) base, (DWORD) base + size);
+  deb_printf ("added memory region %0*zx-%0*zx\n", 2 * __SIZEOF_SIZE_T__,
+	      (SIZE_T) base, 2 * __SIZEOF_SIZE_T__, (SIZE_T) base + size);
   return 1;
 }
 
 /* split_add_mem_region scans list of regions to be excluded from dumping process
    (excl_list) and removes all "excluded" parts from given region. */
 int
-dumper::split_add_mem_region (LPBYTE base, DWORD size)
+dumper::split_add_mem_region (LPBYTE base, SIZE_T size)
 {
   if (!sane ())
     return 0;
@@ -255,7 +257,7 @@ dumper::add_module (LPVOID base_address)
   if (!sane ())
     return 0;
 
-  char *module_name = psapi_get_module_name (hProcess, (DWORD) base_address);
+  char *module_name = psapi_get_module_name (hProcess, (SIZE_T) base_address);
   if (module_name == NULL)
     return 1;
 
@@ -270,7 +272,7 @@ dumper::add_module (LPVOID base_address)
 
   parse_pe (module_name, excl_list);
 
-  deb_printf ("added module %08x %s\n", base_address, module_name);
+  deb_printf ("added module %0*lx %s\n", 2 * __SIZEOF_LONG__, base_address, module_name);
   return 1;
 }
 
@@ -284,8 +286,8 @@ dumper::collect_memory_sections ()
 
   LPBYTE current_page_address;
   LPBYTE last_base = (LPBYTE) 0xFFFFFFFF;
-  DWORD last_size = 0;
-  DWORD done;
+  SIZE_T last_size = (SIZE_T) 0;
+  SIZE_T done;
 
   char mem_buf[PAGE_BUFFER_SIZE];
 
@@ -329,9 +331,9 @@ dumper::collect_memory_sections ()
 	      for (int i = 0; i < 10; i++)
 		strcat (buf, pt[i]);
 
-	      deb_printf ("warning: failed to read memory at %08x-%08x (protect = %s), error %ld.\n",
-			  (DWORD) current_page_address,
-			  (DWORD) current_page_address + mbi.RegionSize,
+	      deb_printf ("warning: failed to read memory at %0*zx-%0*zx (protect = %s), error %ld.\n",
+			  2 * __SIZEOF_SIZE_T__, (SIZE_T) current_page_address,
+			  2 * __SIZEOF_SIZE_T__, (SIZE_T) current_page_address + mbi.RegionSize,
 			  buf, err);
 	      skip_region_p = 1;
 	    }
@@ -369,9 +371,9 @@ dumper::dump_memory_region (asection * t
   if (!sane ())
     return 0;
 
-  DWORD size = memory->size;
-  DWORD todo;
-  DWORD done;
+  SIZE_T size = memory->size;
+  SIZE_T todo;
+  SIZE_T done;
   LPBYTE pos = memory->base;
   DWORD sect_pos = 0;
 
@@ -516,12 +518,13 @@ dumper::collect_process_information ()
 
   if (!DebugActiveProcess (pid))
     {
-      fprintf (stderr, "Cannot attach to process #%lu, error %ld", pid, GetLastError ());
+      fprintf (stderr, "Cannot attach to process #%lu, error %ld",
+	       (unsigned long) pid, (long) GetLastError ());
       return 0;
     }
 
   char event_name[sizeof ("cygwin_error_start_event") + 20];
-  sprintf (event_name, "cygwin_error_start_event%16lx", pid);
+  sprintf (event_name, "cygwin_error_start_event%16lx", (unsigned long) pid);
   HANDLE sync_with_debugee = OpenEvent (EVENT_MODIFY_STATE, FALSE, event_name);
 
   DEBUG_EVENT current_event;
@@ -660,7 +663,7 @@ dumper::prepare_core_dump ()
   char sect_name[50];
 
   flagword sect_flags;
-  DWORD sect_size;
+  SIZE_T sect_size;
   bfd_vma sect_vma;
 
   asection *new_section;
@@ -812,10 +815,10 @@ dumper::write_core_dump ()
       if (p->section == NULL)
 	continue;
 
-      deb_printf ("writing section type=%u base=%08x size=%08x flags=%08x\n",
+      deb_printf ("writing section type=%u base=%0*lx size=%0*lx flags=%08x\n",
 		  p->type,
-		  p->section->vma,
-		  bfd_get_section_size (p->section),
+		  2 * __SIZEOF_LONG__, p->section->vma,
+		  2 * __SIZEOF_LONG__, bfd_get_section_size (p->section),
 		  p->section->flags);
 
       switch (p->type)
@@ -936,7 +939,7 @@ main (int argc, char **argv)
   DWORD tid = 0;
 
   if (verbose)
-    printf ("dumping process #%lu to %s\n", pid, core_file);
+    printf ("dumping process #%lu to %s\n", (unsigned long) pid, core_file);
 
   dumper d (pid, tid, core_file);
   if (!d.sane ())
Index: dumper.h
===================================================================
RCS file: /cvs/src/src/winsup/utils/dumper.h,v
retrieving revision 1.3
diff -u -p -r1.3 dumper.h
--- dumper.h	24 Jul 2007 19:08:23 -0000	1.3
+++ dumper.h	15 Feb 2013 07:53:24 -0000
@@ -1,6 +1,6 @@
 /* dumper.h
 
-   Copyright 1999,2001 Red Hat Inc.
+   Copyright 1999, 2001, 2013 Red Hat Inc.
 
    Written by Egor Duda <deo@logos-m.ru>
 
@@ -28,7 +28,7 @@
 typedef struct
 {
   LPBYTE base;
-  DWORD size;
+  SIZE_T size;
 } process_mem_region;
 
 typedef struct
@@ -67,16 +67,16 @@ typedef struct _process_entity
 class exclusion
 {
 public:
-  int last;
-  int size;
-  int step;
+  size_t last;
+  size_t size;
+  size_t step;
   process_mem_region* region;
 
-  exclusion ( int step ) { last = size = 0;
-			   this->step = step;
-			   region = NULL; }
+  exclusion ( size_t step ) { last = size = 0;
+			      this->step = step;
+			      region = NULL; }
   ~exclusion () { free ( region ); }
-  int add ( LPBYTE mem_base, DWORD mem_size );
+  int add ( LPBYTE mem_base, SIZE_T mem_size );
   int sort_and_check ();
 };
 
@@ -105,10 +105,10 @@ class dumper
 
   process_entity* add_process_entity_to_list ( process_entity_type type );
   int add_thread ( DWORD tid, HANDLE hThread );
-  int add_mem_region ( LPBYTE base, DWORD size );
+  int add_mem_region ( LPBYTE base, SIZE_T size );
 
   /* break mem_region by excl_list and add add all subregions */
-  int split_add_mem_region ( LPBYTE base, DWORD size );
+  int split_add_mem_region ( LPBYTE base, SIZE_T size );
 
   int add_module ( LPVOID base_address );
 
@@ -133,7 +133,7 @@ public:
 
 extern int deb_printf ( const char* format, ... );
 
-extern char* psapi_get_module_name ( HANDLE hProcess, DWORD BaseAddress );
+extern char* psapi_get_module_name ( HANDLE hProcess, SIZE_T BaseAddress );
 
 extern int parse_pe ( const char* file_name, exclusion* excl_list );
 
Index: module_info.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/module_info.cc,v
retrieving revision 1.4.2.1
diff -u -p -r1.4.2.1 module_info.cc
--- module_info.cc	29 Jan 2013 21:54:42 -0000	1.4.2.1
+++ module_info.cc	15 Feb 2013 07:53:24 -0000
@@ -1,6 +1,6 @@
 /* module_info.cc
 
-   Copyright 1999, 2000, 2001, 2010 Red Hat, Inc.
+   Copyright 1999, 2000, 2001, 2010, 2013 Red Hat, Inc.
 
    Written by Egor Duda <deo@logos-m.ru>
 
@@ -33,7 +33,7 @@ static tf_GetModuleFileNameExA *psapi_Ge
    Uses psapi.dll. */
 
 char *
-psapi_get_module_name (HANDLE hProcess, DWORD BaseAddress)
+psapi_get_module_name (HANDLE hProcess, SIZE_T BaseAddress)
 {
   DWORD len;
   MODULEINFO mi;
@@ -103,7 +103,7 @@ psapi_get_module_name (HANDLE hProcess, 
 	  goto failed;
 	}
 
-      if ((DWORD) (mi.lpBaseOfDll) == BaseAddress)
+      if ((SIZE_T) (mi.lpBaseOfDll) == BaseAddress)
 	{
 	  free (DllHandle);
 	  return strdup (name_buf);
Index: parse_pe.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/parse_pe.cc,v
retrieving revision 1.9.4.2
diff -u -p -r1.9.4.2 parse_pe.cc
--- parse_pe.cc	29 Jan 2013 21:54:42 -0000	1.9.4.2
+++ parse_pe.cc	15 Feb 2013 07:53:25 -0000
@@ -1,6 +1,6 @@
 /* parse_pe.cc
 
-   Copyright 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2007, 2012 Red Hat, Inc.
+   Copyright 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2007, 2012, 2013 Red Hat, Inc.
 
    Written by Egor Duda <deo@logos-m.ru>
 
@@ -28,7 +28,7 @@
 #include "dumper.h"
 
 int
-exclusion::add (LPBYTE mem_base, DWORD mem_size)
+exclusion::add (LPBYTE mem_base, SIZE_T mem_size)
 {
   while (last >= size)
     size += step;
@@ -62,7 +62,8 @@ exclusion::sort_and_check ()
 	continue;
       if (p->base + size > q->base)
 	{
-	  fprintf (stderr, "region error @ (%8p + %d) > %8p\n", p->base, size, q->base);
+	  fprintf (stderr, "region error @ (%*p + %zd) > %*p\n",
+		   2 * __SIZEOF_SIZE_T__, p->base, size, 2 * __SIZEOF_SIZE_T__, q->base);
 	  return 0;
 	}
     }
@@ -77,7 +78,7 @@ select_data_section (bfd * abfd, asectio
   if ((sect->flags & (SEC_CODE | SEC_DEBUGGING)) &&
       sect->vma && bfd_get_section_size (sect))
     {
-      excl_list->add ((LPBYTE) sect->vma, (DWORD) bfd_get_section_size (sect));
+      excl_list->add ((LPBYTE) sect->vma, (SIZE_T) bfd_get_section_size (sect));
       deb_printf ("excluding section: %20s %08lx\n", sect->name,
 		  bfd_get_section_size (sect));
     }

--MP_/MTY5d6A=n3=zD_1DLHuVV_p--
