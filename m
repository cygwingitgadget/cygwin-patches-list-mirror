Return-Path: <cygwin-patches-return-7629-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26676 invoked by alias); 29 Mar 2012 14:40:26 -0000
Received: (qmail 26303 invoked by uid 22791); 29 Mar 2012 14:40:22 -0000
X-SWARE-Spam-Status: No, hits=-0.7 required=5.0	tests=AWL,BAYES_00,SPF_NEUTRAL,TO_NO_BRKTS_PCNT,TW_CP
X-Spam-Check-By: sourceware.org
Received: from smtp0.epfl.ch (HELO smtp0.epfl.ch) (128.178.224.219)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Thu, 29 Mar 2012 14:40:08 +0000
Received: (qmail 8032 invoked by uid 107); 29 Mar 2012 14:40:02 -0000
Received: from 76-10-162-117.dsl.teksavvy.com (HELO [192.168.0.100]) (76.10.162.117) (authenticated)  by smtp0.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPA; Thu, 29 Mar 2012 16:40:03 +0200
Message-ID: <4F747440.2020402@cs.utoronto.ca>
Date: Thu, 29 Mar 2012 14:40:00 -0000
From: Ryan Johnson <ryan.johnson@cs.utoronto.ca>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Compiler warnings when building latest cygwin cvs with gcc-4.6 (2/2)
References: <4F747373.5030605@cs.utoronto.ca>
In-Reply-To: <4F747373.5030605@cs.utoronto.ca>
Content-Type: multipart/mixed; boundary="------------000604080801050903000808"
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
X-SW-Source: 2012-q1/txt/msg00052.txt.bz2

This is a multi-part message in MIME format.
--------------000604080801050903000808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 843

On 29/03/2012 10:36 AM, Ryan Johnson wrote:
> Patch 2: fix compiler misc. warnings
         * fhandler_disk_file.cc (fhandler_disk_file::fchmod): Fix harmless
         out of bounds array access.
         * hookapi.cc (find_first_notloaded_dll): Remove write-only
         variable.
         * net.cc (inet_ntop6): Initialize possibly-uninitialized
         variables; probably a spurious warning from gcc-4.6.
         * path.cc (symlink_info::check): Remove write-only variable.
         (cygwin_conv_path_list): Ditto.
         * pinfo.cc (pinfo::init): Ditto.
         (_pinfo::commune_request): Ditto.
         * sched.cc (sched_setparam): Mark write-only variable unused.
         * sec_acl.cc (aclcheck32): Ditto.
         * sigproc.cc (proc_subproc): Remove write-only variable.
         * spawn.cc (child_info_spawn::worker): Ditto.


--------------000604080801050903000808
Content-Type: text/plain; charset=windows-1252;
 name="gcc-4.6-warnings.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="gcc-4.6-warnings.patch"
Content-length: 7664

? winsup/cygwin/cscope.out
Index: winsup/cygwin/fhandler_disk_file.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_disk_file.cc,v
retrieving revision 1.373
diff -u -r1.373 fhandler_disk_file.cc
--- winsup/cygwin/fhandler_disk_file.cc	16 Feb 2012 11:02:05 -0000	1.373
+++ winsup/cygwin/fhandler_disk_file.cc	29 Mar 2012 13:26:18 -0000
@@ -809,8 +809,7 @@
       ffei_buf.ffei.EaNameLength = sizeof (NFS_V3_ATTR) - 1;
       ffei_buf.ffei.EaValueLength = sizeof (fattr3);
       strcpy (ffei_buf.ffei.EaName, NFS_V3_ATTR);
-      fattr3 *nfs_attr = (fattr3 *) (ffei_buf.ffei.EaName
-				     + ffei_buf.ffei.EaNameLength + 1);
+      fattr3 *nfs_attr = (fattr3 *) (ffei_buf.buf + ffei_buf.ffei.EaNameLength);
       memset (nfs_attr, 0, sizeof (fattr3));
       nfs_attr->type = NF3REG;
       nfs_attr->mode = mode;
Index: winsup/cygwin/hookapi.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/hookapi.cc,v
retrieving revision 1.26
diff -u -r1.26 hookapi.cc
--- winsup/cygwin/hookapi.cc	13 Mar 2012 17:15:28 -0000	1.26
+++ winsup/cygwin/hookapi.cc	29 Mar 2012 13:26:24 -0000
@@ -214,10 +214,8 @@
   if (pExeNTHdr)
     {
       DWORD importRVA;
-      DWORD importRVASize;
       DWORD importRVAMaxSize;
       importRVA = pExeNTHdr->OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].VirtualAddress;
-      importRVASize = pExeNTHdr->OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].Size;
       if (importRVA)
 	{
 	  long delta = rvadelta (pExeNTHdr, importRVA, importRVAMaxSize);
Index: winsup/cygwin/net.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/net.cc,v
retrieving revision 1.296
diff -u -r1.296 net.cc
--- winsup/cygwin/net.cc	8 Mar 2012 16:02:44 -0000	1.296
+++ winsup/cygwin/net.cc	29 Mar 2012 13:26:28 -0000
@@ -3152,6 +3152,7 @@
   for (i = 0; i < IN6ADDRSZ; i++)
     words[i / 2] |= (src[i] << ((1 - (i % 2)) << 3));
   best.base = -1;
   cur.base = -1;
+  cur.len = best.len = 0; // avoid (spurious) warning about uninitialized use
   for (i = 0; i < (IN6ADDRSZ / INT16SZ); i++)
     {
Index: winsup/cygwin/path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.651
diff -u -r1.651 path.cc
--- winsup/cygwin/path.cc	8 Mar 2012 14:56:18 -0000	1.651
+++ winsup/cygwin/path.cc	29 Mar 2012 13:26:31 -0000
@@ -2349,8 +2349,6 @@
   bool had_ext = !!*ext_here;
   while (suffix.next ())
     {
-      bool no_ea = false;
-
       error = 0;
       get_nt_native_path (suffix.path, upath, pflags & PATH_DOS);
       if (h)
@@ -2381,7 +2379,6 @@
 		 root dir which has EAs enabled? */
 	      || status == STATUS_INVALID_PARAMETER))
 	{
-	  no_ea = true;
 	  /* If EAs are not supported, there's no sense to check them again
 	     with suffixes attached.  So we set eabuf/easize to 0 here once. */
 	  if (status == STATUS_EAS_NOT_SUPPORTED
@@ -3339,7 +3336,6 @@
   int ret;
   char *winp = NULL;
   void *orig_to = NULL;
-  size_t orig_size = (size_t) -1;
   tmp_pathbuf tp;
 
   switch (what & CCP_CONVTYPE_MASK)
@@ -3357,7 +3353,6 @@
 	       * sizeof (WCHAR);
       what = (what & ~CCP_CONVTYPE_MASK) | CCP_POSIX_TO_WIN_A;
       orig_to = to;
-      orig_size = size;
       to = (void *) tp.w_get ();
       size = 65536;
       break;
Index: winsup/cygwin/pinfo.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/pinfo.cc,v
retrieving revision 1.305
diff -u -r1.305 pinfo.cc
--- winsup/cygwin/pinfo.cc	21 Mar 2012 05:23:12 -0000	1.305
+++ winsup/cygwin/pinfo.cc	29 Mar 2012 13:26:31 -0000
@@ -249,7 +249,6 @@
       return;
     }
 
-  void *mapaddr;
   int createit = flag & (PID_IN_USE | PID_EXECED);
   DWORD access = FILE_MAP_READ
 		 | (flag & (PID_IN_USE | PID_EXECED | PID_MAP_RW)
@@ -296,7 +295,7 @@
 	    case ERROR_INVALID_HANDLE:
 	      api_fatal ("MapViewOfFileEx h0 %p, i %d failed, %E", h0, i);
 	    case ERROR_INVALID_ADDRESS:
-	      mapaddr = NULL;
+	      break;
 	    }
 	  debug_printf ("MapViewOfFileEx h0 %p, i %d failed, %E", h0, i);
 	  yield ();
@@ -653,7 +652,6 @@
   HANDLE& hp = si._si_commune._si_process_handle;
   HANDLE& fromthem = si._si_commune._si_read_handle;
   HANDLE request_sync = NULL;
-  bool locked = false;
 
   res.s = NULL;
   res.n = 0;
@@ -680,7 +678,6 @@
     }
   va_end (args);
 
-  locked = true;
   char name_buf[MAX_PATH];
   request_sync = CreateSemaphore (&sec_none_nih, 0, LONG_MAX,
 				  shared_name (name_buf, "commune", myself->pid));
Index: winsup/cygwin/sched.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/sched.cc,v
retrieving revision 1.20
diff -u -r1.20 sched.cc
--- winsup/cygwin/sched.cc	6 Jul 2011 18:35:44 -0000	1.20
+++ winsup/cygwin/sched.cc	29 Mar 2012 13:26:32 -0000
@@ -319,7 +319,7 @@
   pid_t localpid;
   int winpri;
   DWORD Class;
-  int ThreadPriority;
+  int __attribute__((unused)) ThreadPriority; /* GROT? */
   HANDLE process;
 
   if (!param || pid < 0)
Index: winsup/cygwin/sec_acl.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/sec_acl.cc,v
retrieving revision 1.71
diff -u -r1.71 sec_acl.cc
--- winsup/cygwin/sec_acl.cc	3 Dec 2011 21:43:26 -0000	1.71
+++ winsup/cygwin/sec_acl.cc	29 Mar 2012 13:26:33 -0000
@@ -495,12 +495,12 @@
   bool has_group_obj = false;
   bool has_other_obj = false;
   bool has_class_obj = false;
-  bool has_ug_objs = false;
+  bool __attribute__((unused)) has_ug_objs = false;
   bool has_def_user_obj = false;
   bool has_def_group_obj = false;
   bool has_def_other_obj = false;
   bool has_def_class_obj = false;
-  bool has_def_ug_objs = false;
+  bool __attribute__((unused)) has_def_ug_objs = false;
   int pos2;
 
   for (int pos = 0; pos < nentries; ++pos)
Index: winsup/cygwin/sigproc.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/sigproc.cc,v
retrieving revision 1.381
diff -u -r1.381 sigproc.cc
--- winsup/cygwin/sigproc.cc	28 Mar 2012 17:28:27 -0000	1.381
+++ winsup/cygwin/sigproc.cc	29 Mar 2012 13:26:34 -0000
@@ -185,7 +185,6 @@
 {
   int rc = 1;
   int potential_match;
-  _pinfo *child;
   int clearing;
   waitq *w;
 
@@ -252,7 +251,7 @@
       wval->ev = NULL;		// Don't know event flag yet
 
       if (wval->pid == -1 || !wval->pid)
-	child = NULL;		// Not looking for a specific pid
+        ;                       // Not looking for a specific pid
       else if (!mychild (wval->pid))
 	goto out;		// invalid pid.  flag no such child
 
Index: winsup/cygwin/spawn.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/spawn.cc,v
retrieving revision 1.329
diff -u -r1.329 spawn.cc
--- winsup/cygwin/spawn.cc	21 Mar 2012 15:54:50 -0000	1.329
+++ winsup/cygwin/spawn.cc	29 Mar 2012 13:26:35 -0000
@@ -767,7 +767,6 @@
   /* Name the handle similarly to proc_subproc. */
   ProtectHandle1 (pi.hProcess, childhProc);
 
-  pid_t pid;
   if (mode == _P_OVERLAY)
     {
       myself->dwProcessId = pi.dwProcessId;
@@ -775,7 +774,6 @@
       myself.hProcess = hExeced = pi.hProcess;
       real_path.get_wide_win32_path (myself->progname); // FIXME: race?
       sigproc_printf ("new process name %W", myself->progname);
-      pid = myself->pid;
       if (!iscygwin ())
 	close_all_files ();
     }
@@ -815,7 +813,6 @@
 	  res = -1;
 	  goto out;
 	}
-      pid = child->pid;
     }
 
   /* Start the child running */

--------------000604080801050903000808--
