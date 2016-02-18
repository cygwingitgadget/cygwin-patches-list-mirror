Return-Path: <cygwin-patches-return-8328-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21932 invoked by alias); 18 Feb 2016 10:51:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 20216 invoked by uid 89); 18 Feb 2016 10:51:38 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.1 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW autolearn=no version=3.3.2 spammy=lightly, edi, ecx, ebp
X-HELO: rgout0103.bt.lon5.cpcloud.co.uk
Received: from rgout0103.bt.lon5.cpcloud.co.uk (HELO rgout0103.bt.lon5.cpcloud.co.uk) (65.20.0.123) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 18 Feb 2016 10:51:30 +0000
X-OWM-Source-IP: 86.141.131.217 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090205.56C5A22F.00A8,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2016.2.12.235716:17:27.888,ip=86.141.131.217,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __ANY_URI, __URI_NO_WWW, __URI_NO_PATH, __STOCK_PHRASE_7, BODY_SIZE_10000_PLUS, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[217.131.141.86.fur], HTML_00_01, HTML_00_10, RDNS_SUSP_GENERIC, RDNS_SUSP, NO_URI_HTTPS
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (86.141.131.217) by rgout01.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 56B9DEA200F909A1; Thu, 18 Feb 2016 10:51:27 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] ssp: Fixes for 64-bit
Date: Thu, 18 Feb 2016 10:51:00 -0000
Message-Id: <1455792655-5424-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2016-q1/txt/msg00034.txt.bz2

Fix various 32/64-bit portability issues in ssp, the single-step profiler, and
also build it for 64-bit.

This didn't turn out to actually be very useful for what I wanted to use it for,
so it's only been lightly tested.

It appears that on x86_64, single-step exceptions occur for much more of the
code in system DLLs, unlike x86, so ssp may take much, much longer to profile
some programs.  There is existing code to use breakpoints to mitigate this, but
that is currently disabled.

Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
---
 winsup/utils/ssp.c | 204 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 109 insertions(+), 95 deletions(-)

diff --git a/winsup/utils/ssp.c b/winsup/utils/ssp.c
index 3136a9f..c9165f3 100644
--- a/winsup/utils/ssp.c
+++ b/winsup/utils/ssp.c
@@ -13,20 +13,6 @@
  *
  */
 
-#ifdef __x86_64__
-
-#include <stdio.h>
-
-int
-main (int argc, char **argv)
-{
-  fprintf (stderr, "%s: This application is unsuported on x86_64 so far.\n",
-	   argv[0]);
-  return 1;
-}
-
-#else
-
 #include <errno.h>
 #include <stdio.h>
 #include <string.h>
@@ -56,39 +42,60 @@ static struct option longopts[] =
 
 static char opts[] = "+cdehlstvV";
 
+#ifdef __x86_64__
+#define KERNEL_ADDR 0x00007FF000000000
+#define CONTEXT_SP Rsp
+#define CONTEXT_IP Rip
+typedef DWORD64 CONTEXT_REG;
+#define CONTEXT_REG_FMT "%016llx"
+#define ADDR_SSCANF_FMT "%lli"
+#else
 #define KERNEL_ADDR 0x77000000
+#define CONTEXT_SP Esp
+#define CONTEXT_IP Eip
+typedef DWORD CONTEXT_REG;
+#define CONTEXT_REG_FMT "%08lx"
+#define ADDR_SSCANF_FMT "%li"
+#endif
 
 #define TRACE_SSP 0
 
 #define VERBOSE	1
 #define TIMES	1000
 
-/* from winsup/gmon.h */
+/* from winsup/cygwin/gmon.h */
 struct gmonhdr {
-	unsigned long	lpc;	/* base pc address of sample buffer */
-	unsigned long	hpc;	/* max pc address of sampled buffer */
+	size_t	lpc;		/* base pc address of sample buffer */
+	size_t	hpc;		/* max pc address of sampled buffer */
 	int	ncnt;		/* size of sample buffer (plus this header) */
 	int	version;	/* version number */
 	int	profrate;	/* profiling clock rate */
 	int	spare[3];	/* reserved */
 };
+
+struct rawarc {
+	size_t from_pc;
+	size_t to_pc;
+	long count;
+};
+
 #define GMONVERSION	0x00051879
 #define HISTCOUNTER unsigned short
 
 typedef struct {
-  unsigned int base_address;
+  CONTEXT_REG base_address;
   int pcount;
   int scount;
   char *name;
 } DllInfo;
 
 typedef struct {
-  unsigned int address;
+  CONTEXT_REG address;
   unsigned char real_byte;
 } PendingBreakpoints;
 
-unsigned low_pc=0, high_pc=0;
-unsigned last_pc=0, pc, last_sp=0, sp;
+CONTEXT_REG low_pc, high_pc=0;
+CONTEXT_REG last_pc=0, pc, last_sp=0, sp;
 int total_cycles, count;
 HANDLE hProcess;
 PROCESS_INFORMATION procinfo;
@@ -98,7 +105,6 @@ HISTCOUNTER *hits=0;
 struct gmonhdr hdr;
 int running = 1, profiling = 1;
 char dll_name[1024], *dll_ptr, *cp;
-int eip;
 unsigned opcode_count = 0;
 
 int stepping_enabled = 1;
@@ -111,8 +117,8 @@ int verbose = 0;
 #define MAXTHREADS 100
 DWORD active_thread_ids[MAXTHREADS];
 HANDLE active_threads[MAXTHREADS];
-DWORD thread_step_flags[MAXTHREADS];
-DWORD thread_return_address[MAXTHREADS];
+int thread_step_flags[MAXTHREADS];
+CONTEXT_REG thread_return_address[MAXTHREADS];
 int num_active_threads = 0;
 int suspended_count=0;
 
@@ -125,10 +131,10 @@ PendingBreakpoints pending_breakpoints[MAXPENDS];
 int num_breakpoints=0;
 
 static void
-add_breakpoint (unsigned int address)
+add_breakpoint (CONTEXT_REG address)
 {
   int i;
-  DWORD rv;
+  SIZE_T rv;
   static char int3[] = { 0xcc };
   for (i=0; i<num_breakpoints; i++)
     {
@@ -153,10 +159,10 @@ add_breakpoint (unsigned int address)
 }
 
 static int
-remove_breakpoint (unsigned int address)
+remove_breakpoint (CONTEXT_REG address)
 {
   int i;
-  DWORD rv;
+  SIZE_T rv;
   for (i=0; i<num_breakpoints; i++)
     {
       if (pending_breakpoints[i].address == address)
@@ -231,7 +237,7 @@ dll_sort (const void *va, const void *vb)
 }
 
 static char *
-addr2dllname (unsigned int addr)
+addr2dllname (CONTEXT_REG addr)
 {
   int i;
   for (i=num_dlls-1; i>=0; i--)
@@ -249,39 +255,44 @@ dump_registers (HANDLE thread)
 {
   context.ContextFlags = CONTEXT_FULL;
   GetThreadContext (thread, &context);
+#ifdef __x86_64__
+  printf ("eax %016llx ebx %016llx ecx %016llx edx %016llx eip\n",
+	  context.Rax, context.Rbx, context.Rcx, context.Rdx);
+  printf ("esi %016llx edi %016llx ebp %016llx esp %016llx %016llx\n",
+	  context.Rsi, context.Rdi, context.Rbp, context.Rsp, context.Rip);
+#else
   printf ("eax %08lx ebx %08lx ecx %08lx edx %08lx eip\n",
 	  context.Eax, context.Ebx, context.Ecx, context.Edx);
   printf ("esi %08lx edi %08lx ebp %08lx esp %08lx %08lx\n",
-	  context.Esi, context.Esi, context.Ebp, context.Esp, context.Eip);
+	  context.Esi, context.Edi, context.Ebp, context.Esp, context.Eip);
+#endif
 }
 
 typedef struct Edge {
   struct Edge *next;
-  unsigned int from_pc;
-  unsigned int to_pc;
-  unsigned int count;
+  struct rawarc rawarc;
 } Edge;
 
 Edge *edges[4096];
 
 void
-store_call_edge (unsigned int from_pc, unsigned int to_pc)
+store_call_edge (CONTEXT_REG from_pc, CONTEXT_REG to_pc)
 {
   Edge *e;
   unsigned int h = ((from_pc + to_pc)>>4) & 4095;
   for (e=edges[h]; e; e=e->next)
-    if (e->from_pc == from_pc && e->to_pc == to_pc)
+    if (e->rawarc.from_pc == from_pc && e->rawarc.to_pc == to_pc)
       break;
   if (!e)
     {
       e = (Edge *)malloc (sizeof (Edge));
       e->next = edges[h];
       edges[h] = e;
-      e->from_pc = from_pc;
-      e->to_pc = to_pc;
-      e->count = 0;
+      e->rawarc.from_pc = from_pc;
+      e->rawarc.to_pc = to_pc;
+      e->rawarc.count = 0;
     }
-  e->count++;
+  e->rawarc.count++;
 }
 
 void
@@ -291,7 +302,7 @@ write_call_edges (FILE *f)
   Edge *e;
   for (h=0; h<4096; h++)
     for (e=edges[h]; e; e=e->next)
-      fwrite (&(e->from_pc), 1, 3*sizeof (unsigned int), f);
+      fwrite (&(e->rawarc), 1, sizeof (struct rawarc), f);
 }
 
 char *
@@ -326,14 +337,14 @@ run_program (char *cmdline)
 		     | DEBUG_ONLY_THIS_PROCESS,
 		     0, 0, &startup, &procinfo))
     {
-      fprintf (stderr, "Can't create process: error %ld\n", GetLastError ());
+      fprintf (stderr, "Can't create process: error %u\n", (unsigned int)GetLastError ());
       exit (1);
     }
 
   hProcess = procinfo.hProcess;
 #if 0
-  printf ("procinfo: %08x %08x %08x %08x\n",
-	 hProcess, procinfo.hThread, procinfo.dwProcessId, procinfo.dwThreadId);
+  printf ("procinfo: %p %p %08x %08x\n",
+	  hProcess, procinfo.hThread, (int)procinfo.dwProcessId, (int)procinfo.dwThreadId);
 #endif
 
   active_threads[0] = procinfo.hThread;
@@ -369,7 +380,7 @@ run_program (char *cmdline)
   while (running)
     {
       int src, dest;
-      DWORD rv;
+      SIZE_T rv;
       DEBUG_EVENT event;
       int contv = DBG_CONTINUE;
 
@@ -382,16 +393,16 @@ run_program (char *cmdline)
       hThread = lookup_thread_id (event.dwThreadId, &tix);
 
 #if 0
-      printf ("DE: %x/%d %d %d ",
+      printf ("DE: %p/%d %d %d ",
 	      hThread, tix,
-	     event.dwDebugEventCode, num_active_threads);
+	      (int)event.dwDebugEventCode, num_active_threads);
       for (src=0; src<num_active_threads; src++)
 	{
 	  int sc = SuspendThread (active_threads[src]);
 	  int rv = GetThreadContext (active_threads[src], &context);
 	  ResumeThread (active_threads[src]);
-	  printf (" [%x,%x,%x]",
-		 active_threads[src], context.Eip, active_thread_ids[src]);
+	  printf (" [%p," CONTEXT_REG_FMT ",%x]",
+		  active_threads[src], context.CONTEXT_IP, (int)active_thread_ids[src]);
 	}
       printf ("\n");
 #endif
@@ -404,10 +415,10 @@ run_program (char *cmdline)
 
 	case CREATE_THREAD_DEBUG_EVENT:
 	  if (verbose)
-	    printf ("create thread %08lx at %08x %s\n",
-		   event.dwThreadId,
-		   (int)event.u.CreateThread.lpStartAddress,
-		   addr2dllname ((unsigned int)event.u.CreateThread.lpStartAddress));
+	    printf ("create thread %08x at " CONTEXT_REG_FMT " %s\n",
+		    (int)event.dwThreadId,
+		    (CONTEXT_REG)event.u.CreateThread.lpStartAddress,
+		    addr2dllname ((CONTEXT_REG)event.u.CreateThread.lpStartAddress));
 
 	  active_thread_ids[num_active_threads] = event.dwThreadId;
 	  active_threads[num_active_threads] = event.u.CreateThread.hThread;
@@ -417,16 +428,16 @@ run_program (char *cmdline)
 	  if (trace_all_threads && stepping_enabled)
 	    {
 	      thread_step_flags[num_active_threads-1] = stepping_enabled;
-	      add_breakpoint ((int)event.u.CreateThread.lpStartAddress);
+	      add_breakpoint ((CONTEXT_REG)event.u.CreateThread.lpStartAddress);
 	    }
 
 	  break;
 
 	case EXIT_THREAD_DEBUG_EVENT:
 	  if (verbose)
-	    printf ("exit thread %08lx, code=%ld\n",
-		   event.dwThreadId,
-		   event.u.ExitThread.dwExitCode);
+	    printf ("exit thread %08x, code=%d\n",
+		    (int)event.dwThreadId,
+		    (int)event.u.ExitThread.dwExitCode);
 
 	  for (src=0, dest=0; src<num_active_threads; src++)
 	    if (active_thread_ids[src] != event.dwThreadId)
@@ -443,24 +454,24 @@ run_program (char *cmdline)
 	  switch (event.u.Exception.ExceptionRecord.ExceptionCode)
 	    {
 	    case STATUS_BREAKPOINT:
-	      if (remove_breakpoint ((int)event.u.Exception.ExceptionRecord.ExceptionAddress))
+	      if (remove_breakpoint ((CONTEXT_REG)event.u.Exception.ExceptionRecord.ExceptionAddress))
 		{
-		  context.Eip --;
+		  context.CONTEXT_IP --;
 		  if (!rv)
 		    SetThreadContext (hThread, &context);
-		  if (ReadProcessMemory (hProcess, (void *)context.Esp, &rv, 4, &rv))
+		  if (ReadProcessMemory (hProcess, (void *)context.CONTEXT_SP, &rv, sizeof(rv), &rv))
 		      thread_return_address[tix] = rv;
 		}
 	      set_step_threads (event.dwThreadId, stepping_enabled);
 	    case STATUS_SINGLE_STEP:
 	      opcode_count++;
-	      pc = (unsigned int)event.u.Exception.ExceptionRecord.ExceptionAddress;
-	      sp = (unsigned int)context.Esp;
+	      pc = (CONTEXT_REG)event.u.Exception.ExceptionRecord.ExceptionAddress;
+	      sp = context.CONTEXT_SP;
 	      if (tracing_enabled)
-		fprintf (tracefile, "%08x %08lx\n", pc, event.dwThreadId);
+		fprintf (tracefile, CONTEXT_REG_FMT " %08x\n", pc, (int)event.dwThreadId);
 	      if (trace_console)
 		{
-		  printf ("%d %08x\n", tix, pc);
+		  printf ("%d " CONTEXT_REG_FMT "\n", tix, pc);
 		  fflush (stdout);
 		}
 
@@ -469,7 +480,7 @@ run_program (char *cmdline)
 		  int i;
 		  for (i=num_dlls-1; i>=0; i--)
 		    {
-		      if (dll_info[i].base_address < context.Eip)
+		      if (dll_info[i].base_address < context.CONTEXT_IP)
 			{
 			  if (hThread == procinfo.hThread)
 			    dll_info[i].pcount++;
@@ -485,23 +496,23 @@ run_program (char *cmdline)
 		  static int ncalls=0;
 		  static int qq=0;
 		  if (++qq % 100 == 0)
-		    fprintf (stderr, " %08x %d %d \r",
+		    fprintf (stderr, " " CONTEXT_REG_FMT " %d %d \r",
 			    pc, ncalls, opcode_count);
 
-		  if (sp == last_sp-4)
+		  if (sp == last_sp-sizeof(CONTEXT_REG))
 		    {
 		      ncalls++;
 		      store_call_edge (last_pc, pc);
 		      if (last_pc < KERNEL_ADDR && pc > KERNEL_ADDR)
 			{
-			  int retaddr;
-			  DWORD rv;
+#if 0
+			  CONTEXT_REG retaddr;
+			  SIZE_T rv;
 			  ReadProcessMemory (hProcess,
 					    (void *)sp,
 					    (LPVOID)&(retaddr),
-					    4, &rv);
-#if 0
-			  printf ("call last_pc = %08x pc = %08x rv = %08x\n",
+					     sizeof(retaddr), &rv);
+			  printf ("call last_pc = " CONTEXT_REG_FMT " pc = " CONTEXT_REG_FMT " rv = " CONTEXT_REG_FMT "\n",
 				 last_pc, pc, retaddr);
 			  /* experimental - try to skip kernel calls for speed */
 			  add_breakpoint (retaddr);
@@ -520,10 +531,10 @@ run_program (char *cmdline)
 	    default:
 	      if (verbose)
 		{
-		  printf ("exception %ld, ", event.u.Exception.dwFirstChance);
-		  printf ("code: %lx flags: %lx\n",
-			 event.u.Exception.ExceptionRecord.ExceptionCode,
-			 event.u.Exception.ExceptionRecord.ExceptionFlags);
+		  printf ("exception %d, ", (int)event.u.Exception.dwFirstChance);
+		  printf ("code: %x flags: %x\n",
+			  (int)event.u.Exception.ExceptionRecord.ExceptionCode,
+			  (int)event.u.Exception.ExceptionRecord.ExceptionFlags);
 		  if (event.u.Exception.dwFirstChance == 1)
 		    dump_registers (hThread);
 		}
@@ -562,11 +573,11 @@ run_program (char *cmdline)
 			    &rv);
 	  if (!i)
 	    {
-	      printf ("error reading memory: %ld %ld\n", rv, GetLastError ());
+	      printf ("error reading memory: %zu %u\n", (size_t)rv, (unsigned int)GetLastError ());
 	    }
 	  if (verbose)
-	    printf ("ODS: %x/%d \"%s\"\n",
-		   (int)hThread, tix, string);
+	    printf ("ODS: %p/%d \"%s\"\n",
+		    hThread, tix, string);
 
 	  if (strcmp (string, "ssp on") == 0)
 	    {
@@ -585,21 +596,22 @@ run_program (char *cmdline)
 
 	case LOAD_DLL_DEBUG_EVENT:
 	  if (verbose)
-	    printf ("load dll %08x:",
-		   (int)event.u.LoadDll.lpBaseOfDll);
+	    printf ("load dll " CONTEXT_REG_FMT ":",
+		    (CONTEXT_REG)event.u.LoadDll.lpBaseOfDll);
 
 	  dll_ptr = (char *)"( u n k n o w n ) \0\0";
 	  if (event.u.LoadDll.lpImageName)
 	    {
+	      void *buf;
 	      ReadProcessMemory (hProcess,
 				event.u.LoadDll.lpImageName,
-				(LPVOID)&src,
-				sizeof (src),
+				(LPVOID)&buf,
+				sizeof (buf),
 				&rv);
-	      if (src)
+	      if (buf)
 		{
 		  ReadProcessMemory (hProcess,
-				    (void *)src,
+				    buf,
 				    (LPVOID)dll_name,
 				    sizeof (dll_name),
 				    &rv);
@@ -617,8 +629,7 @@ run_program (char *cmdline)
 	    }
 
 
-	  dll_info[num_dlls].base_address
-	    = (unsigned int)event.u.LoadDll.lpBaseOfDll;
+	  dll_info[num_dlls].base_address = (CONTEXT_REG)event.u.LoadDll.lpBaseOfDll;
 	  dll_info[num_dlls].pcount = 0;
 	  dll_info[num_dlls].scount = 0;
 	  dll_info[num_dlls].name = wide_strdup (dll_ptr);
@@ -636,9 +647,9 @@ run_program (char *cmdline)
 
 	case EXIT_PROCESS_DEBUG_EVENT:
 	  if (verbose)
-	    printf ("process %08lx %08lx exit %ld\n",
-		   event.dwProcessId, event.dwThreadId,
-		   event.u.ExitProcess.dwExitCode);
+	    printf ("process %08x %08x exit %d\n",
+		    (int)event.dwProcessId, (int)event.dwThreadId,
+		    (int)event.u.ExitProcess.dwExitCode);
 
 	  running = 0;
 	  break;
@@ -892,8 +903,8 @@ main (int argc, char **argv)
 
   if ( (argc - optind) < 3 )
     usage (stderr);
-  sscanf (argv[optind++], "%i", &low_pc);
-  sscanf (argv[optind++], "%i", &high_pc);
+  sscanf (argv[optind++], ADDR_SSCANF_FMT, &low_pc);
+  sscanf (argv[optind++], ADDR_SSCANF_FMT, &high_pc);
 
   if (low_pc > high_pc-8)
     {
@@ -904,7 +915,7 @@ main (int argc, char **argv)
   hits = (HISTCOUNTER *)malloc (high_pc-low_pc+4);
   memset (hits, 0, high_pc-low_pc+4);
 
-  fprintf (stderr, "prun: [%08x,%08x] Running '%s'\n",
+  fprintf (stderr, "prun: [" CONTEXT_REG_FMT "," CONTEXT_REG_FMT "] Running '%s'\n",
 	  low_pc, high_pc, argv[optind]);
 
   run_program (argv[optind]);
@@ -923,8 +934,13 @@ main (int argc, char **argv)
 
   if (dll_counts)
     {
+#ifdef __x86_64__
+      /*       1234567 123% 1234567 123% 1234567812345678 xxxxxxxxxxx */
+      printf (" Main-Thread Other-Thread BaseAddr         DLL Name\n");
+#else
       /*       1234567 123% 1234567 123% 12345678 xxxxxxxxxxx */
       printf (" Main-Thread Other-Thread BaseAddr DLL Name\n");
+#endif
 
       total_pcount = 0;
       total_scount = 0;
@@ -940,7 +956,7 @@ main (int argc, char **argv)
       for (i=0; i<num_dlls; i++)
 	if (dll_info[i].pcount || dll_info[i].scount)
 	  {
-	    printf ("%7d %3d%% %7d %3d%% %08x %s\n",
+	    printf ("%7d %3d%% %7d %3d%% " CONTEXT_REG_FMT " %s\n",
 		   dll_info[i].pcount,
 		   (dll_info[i].pcount*100)/opcode_count,
 		   dll_info[i].scount,
@@ -952,5 +968,3 @@ main (int argc, char **argv)
 
   exit (0);
 }
-
-#endif /* !__x86_64 */
-- 
2.7.0
