Return-Path: <cygwin-patches-return-6199-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 720 invoked by alias); 20 Dec 2007 15:16:15 -0000
Received: (qmail 682 invoked by uid 22791); 20 Dec 2007 15:16:13 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 20 Dec 2007 15:16:02 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1J5N7w-0005Ef-6u 	for cygwin-patches@cygwin.com; Thu, 20 Dec 2007 15:16:00 +0000
Message-ID: <476A8729.5C05B169@dessent.net>
Date: Thu, 20 Dec 2007 15:16:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [patch] un-NT-ify cygcheck (was: cygwin 1.5.25-7: cygcheck does not   work?)
References: <836045.82708.qm@web33207.mail.mud.yahoo.com> <476A726D.50100@byu.net> <476A78EF.2322FB0A@dessent.net>
Content-Type: multipart/mixed;  boundary="------------F5A2AEC69DAE47BEA696C310"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00051.txt.bz2

This is a multi-part message in MIME format.
--------------F5A2AEC69DAE47BEA696C310
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 953

Brian Dessent wrote:

> Fortunately, I have VMware with a Win98 image here.
> 
> The problem is that bloda.c calls NtQuerySystemInformation without using
> any kind of autoload.cc-type indirection, and so cygcheck gets a hard
> dependency on ntdll.dll which doesn't exist on 9x/ME.  We need to do one
> of:
> 
> - Revert the bloda-check feature on the 1.5 branch
> - Check windows version at runtime and only do NT calls through
> LoadLibrary/GetProcAddress
> - Use the autoload.cc trick in cygcheck
> 
> If we're going to make releases from the 1.5 branch then I don't think
> it's quite acceptible just yet to shaft 9x users, after all that's the
> whole point of the branch.

The attached patch un-NT-ifies bloda.cc but sadly a similar cleanup is
still required for cygpath as well if we are to support 9x/ME out of the
1.5 branch. In that case I suppose you could just revert cygpath.cc to
an older revision before the native APIs were added.

Brian
--------------F5A2AEC69DAE47BEA696C310
Content-Type: text/plain; charset=us-ascii;
 name="cygcheck_bloda_nt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygcheck_bloda_nt.patch"
Content-length: 4906

2007-12-20  Brian Dessent  <brian@dessent.net>

	* Makefile.in (cygcheck.exe): Don't link to ntdll.
	* bloda.cc (pNtQuerySystemInformation): Add.
	(pRtlAnsiStringToUnicodeString): Add.
	(get_process_list): Use function pointers for NT functions.
	(dump_dodgy_apps): Skip dodgy app check on non-NT platforms.
	Use GetProcAddress for NT-specific functions.


Index: Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/utils/Makefile.in,v
retrieving revision 1.67
diff -u -p -r1.67 Makefile.in
--- Makefile.in	3 Aug 2007 19:41:48 -0000	1.67
+++ Makefile.in	20 Dec 2007 15:08:23 -0000
@@ -104,10 +104,10 @@ ifeq "$(libz)" ""
 	@echo '*** Building cygcheck without package content checking due to missing mingw libz.a.'
 endif
 ifdef VERBOSE
-	$(CXX) $(MINGW_CXXFLAGS) -o $@ ${wordlist 1,4,$^} -B$(mingw_build)/ $(MINGW_LDFLAGS) $(libz) -lntdll
+	$(CXX) $(MINGW_CXXFLAGS) -o $@ ${wordlist 1,4,$^} -B$(mingw_build)/ $(MINGW_LDFLAGS) $(libz)
 else
-	@echo $(CXX) -o $@ ${wordlist 1,4,$^} ${filter-out -B%, $(MINGW_CXXFLAGS) $(MINGW_LDFLAGS)} $(libz) -lntdll;\
-	$(CXX) $(MINGW_CXXFLAGS) -o $@ ${wordlist 1,4,$^} -B$(mingw_build)/ $(MINGW_LDFLAGS) $(libz) -lntdll
+	@echo $(CXX) -o $@ ${wordlist 1,4,$^} ${filter-out -B%, $(MINGW_CXXFLAGS) $(MINGW_LDFLAGS)} $(libz);\
+	$(CXX) $(MINGW_CXXFLAGS) -o $@ ${wordlist 1,4,$^} -B$(mingw_build)/ $(MINGW_LDFLAGS) $(libz)
 endif
 
 dumper.o: dumper.cc dumper.h
Index: bloda.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/bloda.cc,v
retrieving revision 1.1
diff -u -p -r1.1 bloda.cc
--- bloda.cc	3 Aug 2007 19:41:48 -0000	1.1
+++ bloda.cc	20 Dec 2007 15:08:23 -0000
@@ -104,13 +104,20 @@ static const size_t num_of_dodgy_apps = 
   to be looked up at runtime and called through a pointer.  */
 VOID NTAPI (*pRtlFreeUnicodeString)(PUNICODE_STRING) = NULL;
 
+NTSTATUS NTAPI (*pNtQuerySystemInformation) (SYSTEM_INFORMATION_CLASS,
+                                             PVOID, ULONG, PULONG) = NULL;
+
+NTSTATUS NTAPI (*pRtlAnsiStringToUnicodeString) (PUNICODE_STRING, PANSI_STRING,
+                                               BOOLEAN) = NULL;
+
+
 static PSYSTEM_PROCESSES
 get_process_list (void)
 {
   int n_procs = 0x100;
   PSYSTEM_PROCESSES pslist = (PSYSTEM_PROCESSES) malloc (n_procs * sizeof *pslist);
 
-  while (NtQuerySystemInformation (SystemProcessesAndThreadsInformation,
+  while (pNtQuerySystemInformation (SystemProcessesAndThreadsInformation,
     pslist, n_procs * sizeof *pslist, 0) == STATUS_INFO_LENGTH_MISMATCH)
     {
       n_procs *= 2;
@@ -126,7 +133,7 @@ get_module_list (void)
   int modsize = 0x1000;
   PSYSTEM_MODULE_INFORMATION modlist = (PSYSTEM_MODULE_INFORMATION) malloc (modsize);
 
-  while (NtQuerySystemInformation (SystemModuleInformation,
+  while (pNtQuerySystemInformation (SystemModuleInformation,
     modlist, modsize, NULL) == STATUS_INFO_LENGTH_MISMATCH)
     {
       modsize *= 2;
@@ -284,19 +291,14 @@ detect_dodgy_app (const struct bad_app_d
       /* Equivalent of RtlInitAnsiString.  */
       ansiname.Length = ansiname.MaximumLength = strlen (det->param);
       ansiname.Buffer = (CHAR *) det->param;
-      rv = RtlAnsiStringToUnicodeString (&unicodename, &ansiname, TRUE);
+      rv = pRtlAnsiStringToUnicodeString (&unicodename, &ansiname, TRUE);
       if (rv != STATUS_SUCCESS)
         {
           printf ("Ansi to unicode conversion failure $%08x\n", (unsigned int) rv);
           break;
         }
       found = find_process_in_list (pslist, &unicodename);
-      if (!pRtlFreeUnicodeString)
-          pRtlFreeUnicodeString = (VOID NTAPI (*)(PUNICODE_STRING)) GetProcAddress (LoadLibrary ("ntdll.dll"), "RtlFreeUnicodeString");
-      if (pRtlFreeUnicodeString)
-        pRtlFreeUnicodeString (&unicodename);
-      else
-        printf ("leaking mem...oops\n");
+      pRtlFreeUnicodeString (&unicodename);
       if (found)
         {
           dbg_printf (("found!\n"));
@@ -337,6 +339,25 @@ dump_dodgy_apps (int verbose)
   size_t i, n_det = 0;
   PSYSTEM_PROCESSES pslist;
   PSYSTEM_MODULE_INFORMATION modlist;
+  HMODULE ntdll;
+
+  if ((ntdll = LoadLibrary ("ntdll.dll")) == NULL)
+    {
+      puts ("Skipping dodgy app check on Win9x/ME.");
+      return;
+    }
+
+#define GPA(func,rv) \
+      if ((p##func = (rv) GetProcAddress (ntdll, #func)) == NULL) \
+        { \
+          puts ("Can't GetProcAddress() for " #func ", " \
+                "skipping dodgy app check."); \
+          return; \
+        }
+  GPA(NtQuerySystemInformation, NTSTATUS NTAPI (*) (SYSTEM_INFORMATION_CLASS,PVOID,ULONG,PULONG));
+  GPA(RtlFreeUnicodeString, VOID NTAPI (*)(PUNICODE_STRING));
+  GPA(RtlAnsiStringToUnicodeString, NTSTATUS NTAPI (*)(PUNICODE_STRING,PANSI_STRING,BOOLEAN));
+#undef GPA
 
   /* Read system info for detect testing.  */
   pslist = get_process_list ();

--------------F5A2AEC69DAE47BEA696C310--
