Return-Path: <cygwin-patches-return-6308-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14823 invoked by alias); 19 Mar 2008 00:24:40 -0000
Received: (qmail 14812 invoked by uid 22791); 19 Mar 2008 00:24:38 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 19 Mar 2008 00:24:22 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1Jbm6O-0001fT-Cy 	for cygwin-patches@cygwin.com; Wed, 19 Mar 2008 00:24:20 +0000
Message-ID: <47E05D34.FCC2E30A@dessent.net>
Date: Wed, 19 Mar 2008 00:24:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] better stackdumps
Content-Type: multipart/mixed;  boundary="------------D5EDE906A32FF83C63B56DBC"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00082.txt.bz2

This is a multi-part message in MIME format.
--------------D5EDE906A32FF83C63B56DBC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 1412


This patch adds the ability to see functions/symbols in the .stackdump
files generated when there's a fault.  It parses the export sections of
each loaded module and finds the closest exported address for each stack
frame address.  This of course won't be perfect as it will show the
wrong function if the frame is in the middle of a non-exported function,
but it's better than what we have now.

This also uses a couple of tricks to make the output more sensible.  It
can "see through" the sigfe wrappers and print the actual functions
being wrapped.  It also has a set of internal symbols that it consults
for symbols in Cygwin.  This allows it to get the bottom frame correct
(_dll_crt0_1) even though that function isn't exported.  If there are
any other such functions they can be easily added to the 'hints' array.

Also attached is a sample output of an invalid C program and the
resulting stackdump.  Note that the frame labeled _sigbe really should
be a frame somewhere inside the main .exe.  I pondered trying to extract
the sigbe's return address off the signal stack and using that for the
label but I haven't quite gotten there, since I can't think of a
reliable way to figure out the correct location on the tls stack where
the real return address is stored.

Of course the labeling works for any module/dll, not just cygwin1.dll,
but I didn't have a more elaborate testcase to demonstrate.

Brian
--------------D5EDE906A32FF83C63B56DBC
Content-Type: text/plain; charset=us-ascii;
 name="backtrace_symbols.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="backtrace_symbols.patch"
Content-length: 9629

2008-03-18  Brian Dessent  <brian@dessent.net>

	* exceptions.cc (maybe_adjust_va_for_sigfe): New function to cope
	with signal wrappers.
	(prettyprint_va): New function that attempts to find a symbolic
	name for a memory location by walking the export sections of all
	modules.
	(stackdump): Call it.
	* gendef: Mark __sigfe as a global so that its address can be
	used by the backtrace code.
	* ntdll.h (struct _PEB_LDR_DATA): Declare.
	(struct _LDR_MODULE): Declare.
	(struct _PEB): Use actual LDR_DATA type for LdrData.
	(RtlImageDirectoryEntryToData): Declare.

Index: exceptions.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/exceptions.cc,v
retrieving revision 1.319
diff -u -p -r1.319 exceptions.cc
--- exceptions.cc	12 Mar 2008 12:41:49 -0000	1.319
+++ exceptions.cc	19 Mar 2008 00:04:13 -0000
@@ -284,6 +284,158 @@ stack_info::walk ()
   return 1;
 }
 
+/* These symbols are used by the below functions to put a prettier face
+   on a stack backtrace.  */
+extern u_char etext asm ("etext");  /* End of .text */
+extern u_char _sigfe, _sigbe;
+void dll_crt0_1 (void *);
+
+const struct {
+  DWORD va;
+  const char *label;
+} hints[] = {
+  { (DWORD) &_sigbe, "_sigbe" },
+  { (DWORD) &dll_crt0_1, "_dll_crt0_1" }
+};
+
+/* Helper function to assist with backtraces.  This tries to detect if
+   an entrypoint is really a sigfe wrapper and returns the actual address
+   of the function.  Here's an example:
+
+   610ab9f0 <__sigfe_printf>:
+   610ab9f0:       68 40 a4 10 61          push   $0x6110a440
+   610ab9f5:       e9 bf eb ff ff          jmp    610aa5b9 <__sigfe>
+   
+   Suppose that we are passed 0x610ab9f0.  We need to recognise the
+   push/jmp combination and return 0x6110a440 <_printf> instead.  Note
+   that this is a relative jump.  */
+static DWORD
+maybe_adjust_va_for_sigfe (DWORD va)
+{
+  if (va < (DWORD) user_data->hmodule || va > (DWORD) &etext)
+    return va;
+
+  unsigned char *x = (unsigned char *) va;
+
+  if (x[0] == 0x68 && x[5] == 0xe9)
+    {
+      DWORD jmprel = *(DWORD *)(x + 6);
+  
+      if ((unsigned) va + 10 + (unsigned) jmprel == (unsigned) &_sigfe)
+        return *(DWORD *)(x + 1);
+    }
+  return va;
+}
+
+/* Walk the list of modules in the current process and parse their
+   export tables in order to find the entrypoint closest to but less
+   than 'faultva'.  This won't be perfect, such as when 'faultva'
+   actually resides in a non-exported function, but it is still better
+   than nothing.  Note that this algorithm could be made much more
+   efficient by both sorting the export tables as well as saving the
+   result between calls. However, this implementation requires no
+   allocation of memory and minimal system calls, so it should be safe
+   in the context of an exception handler.  And we're probably about to
+   terminate the process anyway, so performance is not critical.  */
+static char *
+prettyprint_va (DWORD faultva)
+{
+  static char buf[256];
+  
+  ULONG bestmatch_va = 0;
+
+  PLIST_ENTRY head = &NtCurrentTeb()->Peb->LdrData->InMemoryOrderModuleList;
+  for (PLIST_ENTRY x = head->Flink; x != head; x = x->Flink)
+    {
+      PLDR_MODULE mod = CONTAINING_RECORD (x, LDR_MODULE,
+                                           InMemoryOrderModuleList);
+      if ((DWORD) mod->BaseAddress > faultva)
+        continue;
+
+      DWORD len;
+      IMAGE_EXPORT_DIRECTORY *edata_va = (IMAGE_EXPORT_DIRECTORY *)
+              RtlImageDirectoryEntryToData ((HMODULE) mod->BaseAddress,
+              TRUE, IMAGE_DIRECTORY_ENTRY_EXPORT, &len);
+
+      if (edata_va)
+        {
+          PULONG functions = (PULONG) ((PCHAR) mod->BaseAddress +
+                                       edata_va->AddressOfFunctions);
+          int bestmatch_i = -1;
+          for (int i = 0; i < (USHORT) edata_va->NumberOfFunctions; i++)
+            {
+              /* Some DLLs have unused ordinals -> rva=0 */
+              if (!functions[i])
+                continue;
+              
+              /* Convert rva to va */
+              ULONG va = (ULONG)((PCHAR) mod->BaseAddress + functions[i]);
+              
+              /* If the va points inside .edata it's a forwarder */
+              if (va >= (ULONG) edata_va && va < (ULONG) (edata_va) + len)
+                continue;
+
+              va = maybe_adjust_va_for_sigfe (va);
+              
+              if (!bestmatch_va || (va <= faultva && va > bestmatch_va))
+                {
+                  bestmatch_va = va;
+                  bestmatch_i = i;
+                }
+            }
+          
+          if (bestmatch_i == -1)
+            continue;
+
+          /* Look up the name corresponding to bestmatch_i */
+          PUSHORT ordinals = (PUSHORT) ((PCHAR) mod->BaseAddress +
+                                        edata_va->AddressOfNameOrdinals);
+          PULONG names = (PULONG) ((PCHAR) mod->BaseAddress +
+                                   edata_va->AddressOfNames);
+          unsigned j;
+          for (j = 0; j < edata_va->NumberOfNames; j++)
+            if (ordinals[j] == bestmatch_i)
+              {
+                __small_sprintf (buf, "%S!%s+0x%x", &mod->BaseDllName,
+                                 (PCHAR) mod->BaseAddress + names[j],
+                                 faultva - bestmatch_va);
+                break;
+              }
+          if (j == edata_va->NumberOfNames)
+            /* No name, just an ordinal */
+            __small_sprintf (buf, "%S!%hu+0x%x", &mod->BaseDllName,
+                             (USHORT)(bestmatch_i + edata_va->Base),
+                             faultva - bestmatch_va);
+        }
+      else
+        {
+          /* This module has no exports, e.g. main .exe. */
+          bestmatch_va = (DWORD) mod->EntryPoint;
+          __small_sprintf (buf, "%S+0x%x", &mod->BaseDllName,
+                           faultva - bestmatch_va);
+        }
+
+    }
+
+  /* If this is an address in Cygwin, we can check a few non-exported
+     symbols for better matches too.  */
+  if (faultva > (DWORD) user_data->hmodule && faultva < (DWORD) &etext)
+    for (unsigned i = 0; i < sizeof (hints); i++)
+      if (hints[i].va <= faultva && hints[i].va > bestmatch_va)
+        {
+          bestmatch_va = hints[i].va;
+          __small_sprintf (buf, "cygwin1.dll!%s+0x%x", hints[i].label,
+                           faultva - hints[i].va);
+        }
+  
+  /* Shouldn't happen, but who knows what might happen if the process
+     has really trashed its memory.  */
+  if (!bestmatch_va)
+    buf[0] = '\0';
+
+  return buf;
+}
+
 static void
 stackdump (DWORD ebp, int open_file, bool isexception)
 {
@@ -308,7 +460,7 @@ stackdump (DWORD ebp, int open_file, boo
 		    thestack.sf.AddrPC.Offset);
       for (unsigned j = 0; j < NPARAMS; j++)
 	small_printf ("%s%08x", j == 0 ? " (" : ", ", thestack.sf.Params[j]);
-      small_printf (")\r\n");
+      small_printf (") %s\r\n", prettyprint_va (thestack.sf.AddrPC.Offset));
     }
   small_printf ("End of stack trace%s\n",
 	      i == 16 ? " (more stack frames may be present)" : "");
Index: gendef
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/gendef,v
retrieving revision 1.29
diff -u -p -r1.29 gendef
--- gendef	1 Mar 2008 13:18:22 -0000	1.29
+++ gendef	19 Mar 2008 00:04:13 -0000
@@ -115,6 +115,7 @@ __sigfe_maybe:
 	popl	%ebx
 	ret
 
+	.global __sigfe
 __sigfe:
 	pushl	%ebx
 	pushl	%edx
Index: ntdll.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/ntdll.h,v
retrieving revision 1.79
diff -u -p -r1.79 ntdll.h
--- ntdll.h	15 Feb 2008 17:53:10 -0000	1.79
+++ ntdll.h	19 Mar 2008 00:04:13 -0000
@@ -519,12 +525,41 @@ typedef struct _RTL_USER_PROCESS_PARAMET
   UNICODE_STRING RuntimeInfo;
 } RTL_USER_PROCESS_PARAMETERS, *PRTL_USER_PROCESS_PARAMETERS;
 
+typedef struct _PEB_LDR_DATA
+{
+    ULONG               Length;
+    BOOLEAN             Initialized;
+    PVOID               SsHandle;
+    LIST_ENTRY          InLoadOrderModuleList;
+    LIST_ENTRY          InMemoryOrderModuleList;
+    LIST_ENTRY          InInitializationOrderModuleList;
+} PEB_LDR_DATA, *PPEB_LDR_DATA;
+
+typedef struct _LDR_MODULE
+{
+    LIST_ENTRY          InLoadOrderModuleList;
+    LIST_ENTRY          InMemoryOrderModuleList;
+    LIST_ENTRY          InInitializationOrderModuleList;
+    void*               BaseAddress;
+    void*               EntryPoint;
+    ULONG               SizeOfImage;
+    UNICODE_STRING      FullDllName;
+    UNICODE_STRING      BaseDllName;
+    ULONG               Flags;
+    SHORT               LoadCount;
+    SHORT               TlsIndex;
+    HANDLE              SectionHandle;
+    ULONG               CheckSum;
+    ULONG               TimeDateStamp;
+    HANDLE              ActivationContext;
+} LDR_MODULE, *PLDR_MODULE;
+
 typedef struct _PEB
 {
   BYTE Reserved1[2];
   BYTE BeingDebugged;
   BYTE Reserved2[9];
-  PVOID LoaderData;
+  PPEB_LDR_DATA LdrData; 
   PRTL_USER_PROCESS_PARAMETERS ProcessParameters;
   BYTE Reserved3[448];
   ULONG SessionId;
@@ -872,6 +907,7 @@ extern "C"
   VOID NTAPI RtlFreeAnsiString (PANSI_STRING);
   VOID NTAPI RtlFreeOemString (POEM_STRING);
   VOID NTAPI RtlFreeUnicodeString (PUNICODE_STRING);
+  PVOID NTAPI RtlImageDirectoryEntryToData (HMODULE, BOOL, WORD, ULONG *);
   VOID NTAPI RtlInitEmptyUnicodeString (PUNICODE_STRING, PCWSTR, USHORT);
   VOID NTAPI RtlInitUnicodeString (PUNICODE_STRING, PCWSTR);
   NTSTATUS NTAPI RtlIntegerToUnicodeString (ULONG, ULONG, PUNICODE_STRING);

--------------D5EDE906A32FF83C63B56DBC
Content-Type: text/plain; charset=us-ascii;
 name="sample.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sample.txt"
Content-length: 877

int main ()
{
  char *bad = (char *)0xFEED;
  printf ("foo bar %s", bad);
}


$ cat a.exe.stackdump 
Exception: STATUS_ACCESS_VIOLATION at eip=610F74B1
eax=00000000 ebx=FFFFFFFF ecx=FFFFFFFF edx=0000FEED esi=00000000 edi=0000FEED
ebp=0022C568 esp=0022C564 program=\\?\C:\cygwin\home\brian\testcases\backtrace\a.exe, pid 5912, thread main
cs=001B ds=0023 es=0023 fs=003B gs=0000 ss=0023
Stack trace:
Frame     Function  Args
0022C568  610F74B1  (0000FEED, 0022C676, 00402008, 00000001) cygwin1.dll!_strlen+0x11
0022CC98  610FDD3B  (0022D008, 6111C668, 00402000, 0022CCC8) cygwin1.dll!_fputc+0x34EB
0022CCB8  6110A310  (00402000, 0000FEED, 00000009, 00401065) cygwin1.dll!_printf+0x30
0022CCE8  610AA4A8  (00000001, 61290878, 00680098, 00000000) cygwin1.dll!_sigbe+0x0
0022CD98  61006094  (00000000, 0022CDD0, 61005430, 0022CDD0) cygwin1.dll!_dll_crt0_1+0xC64
End of stack trace

--------------D5EDE906A32FF83C63B56DBC--
