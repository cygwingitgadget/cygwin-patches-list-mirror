Return-Path: <cygwin-patches-return-3323-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20837 invoked by alias); 16 Dec 2002 12:07:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20827 invoked from network); 16 Dec 2002 12:07:34 -0000
From: "Hartmut Honisch" <hartmut_honisch@web.de>
To: <cygwin-patches@cygwin.com>
Subject: Minor additions to winbase.h and ntdll.def
Date: Mon, 16 Dec 2002 04:07:00 -0000
Message-ID: <NFBBLLCAILKHOEOHEFMHGEBDCEAA.hartmut_honisch@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0000_01C2A504.1705E630"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-SW-Source: 2002-q4/txt/msg00274.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0000_01C2A504.1705E630
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 248

Winbase.h
- Changed NMPWAIT_WAIT_FOREVER constant from (-1) to 0xffffffff (like in
Microsoft's header file)
- Added LOGON32_LOGON_NETWORK

ntdll.def:
- Added Nt-/ZwConnectPort, Nt-/ZwOpenEvent, Nt-/ZwRequestWaitReplyPort,
Nt-/ZwWaitForSingleObject

------=_NextPart_000_0000_01C2A504.1705E630
Content-Type: application/octet-stream;
	name="w32api.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="w32api.patch"
Content-length: 3207

Index: include/winbase.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/w32api/include/winbase.h,v=0A=
retrieving revision 1.31=0A=
diff -u -p -r1.31 winbase.h=0A=
--- include/winbase.h	24 Sep 2002 01:28:00 -0000	1.31=0A=
+++ include/winbase.h	16 Dec 2002 11:53:49 -0000=0A=
@@ -106,9 +106,9 @@ extern "C" {=0A=
 #define OF_PROMPT	8192=0A=
 #define OF_REOPEN	32768=0A=
 #define OF_VERIFY	1024=0A=
-#define NMPWAIT_NOWAIT	1=0A=
-#define NMPWAIT_WAIT_FOREVER	(-1)=0A=
-#define NMPWAIT_USE_DEFAULT_WAIT	0=0A=
+#define NMPWAIT_NOWAIT 0x00000001=0A=
+#define NMPWAIT_WAIT_FOREVER	0xffffffff=20=20=0A=
+#define NMPWAIT_USE_DEFAULT_WAIT	0x00000000=0A=
 #define CE_BREAK	16=0A=
 #define CE_DNS	2048=0A=
 #define CE_FRAME	8=0A=
@@ -351,6 +351,7 @@ extern "C" {=0A=
 #define LOGON32_PROVIDER_DEFAULT	0=0A=
 #define LOGON32_PROVIDER_WINNT35	1=0A=
 #define LOGON32_LOGON_INTERACTIVE	2=0A=
+#define LOGON32_LOGON_NETWORK 3=0A=
 #define LOGON32_LOGON_BATCH	4=0A=
 #define LOGON32_LOGON_SERVICE	5=0A=
 #define MOVEFILE_REPLACE_EXISTING 1=0A=
Index: lib/ntdll.def=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/w32api/lib/ntdll.def,v=0A=
retrieving revision 1.5=0A=
diff -u -p -r1.5 ntdll.def=0A=
--- lib/ntdll.def	11 Oct 2002 03:38:14 -0000	1.5=0A=
+++ lib/ntdll.def	16 Dec 2002 11:53:50 -0000=0A=
@@ -21,6 +21,7 @@ NtAccessCheck@32=0A=
 NtAdjustPrivilegesToken@24=0A=
 NtAllocateVirtualMemory@24=0A=
 NtClose@4=0A=
+NtConnectPort@32=0A=
 NtCreateFile@44=0A=
 NtCreateKey@28=0A=
 NtCurrentTeb@0=0A=
@@ -32,6 +33,7 @@ NtEnumerateValueKey@24=0A=
 NtFlushVirtualMemory@16=0A=
 NtFreeVirtualMemory@16=0A=
 NtLockVirtualMemory@16=0A=
+NtOpenEvent@12=0A=
 NtOpenFile@24=0A=
 NtOpenKey@12=0A=
 NtOpenProcessToken@12=0A=
@@ -43,10 +45,12 @@ NtQueryValueKey@24=0A=
 NtQueryVirtualMemory@24=0A=
 NtReadFile@36=0A=
 NtReadVirtualMemory@20=0A=
+NtRequestWaitReplyPort@12=0A=
 NtSetSecurityObject@12=0A=
 NtSetValueKey@24=0A=
 NtShutdownSystem@4=0A=
 NtUnlockVirtualMemory@16=0A=
+NtWaitForSingleObject@12=20=0A=
 NtWriteFile@36=0A=
 NtWriteVirtualMemory@20=0A=
 RtlAcquirePebLock@0=0A=
@@ -218,6 +222,7 @@ ZwAccessCheck@32=0A=
 ZwAdjustPrivilegesToken@24=0A=
 ZwAllocateVirtualMemory@24=0A=
 ZwClose@4=0A=
+ZwConnectPort@32=0A=
 ZwCreateFile@44=0A=
 ZwCreateKey@28=0A=
 ZwDeleteValueKey@8=0A=
@@ -226,6 +231,7 @@ ZwEnumerateValueKey@24=0A=
 ZwFlushVirtualMemory@16=0A=
 ZwFreeVirtualMemory@16=0A=
 ZwLockVirtualMemory@16=0A=
+ZwOpenEvent@12=0A=
 ZwOpenFile@24=0A=
 ZwOpenKey@12=0A=
 ZwOpenProcessToken@12=0A=
@@ -237,9 +243,11 @@ ZwQueryValueKey@24=0A=
 ZwQueryVirtualMemory@24=0A=
 ZwReadFile@36=0A=
 ZwReadVirtualMemory@20=0A=
+ZwRequestWaitReplyPort@12=0A=
 ZwSetSecurityObject@12=0A=
 ZwSetValueKey@24=0A=
 ZwUnlockVirtualMemory@16=0A=
+ZwWaitForSingleObject@12=20=0A=
 ZwWriteFile@36=20=0A=
 ZwWriteVirtualMemory@20=0A=
 __isascii=0A=

------=_NextPart_000_0000_01C2A504.1705E630--
