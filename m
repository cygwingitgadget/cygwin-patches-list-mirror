Return-Path: <cygwin-patches-return-5268-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5200 invoked by alias); 22 Dec 2004 09:51:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5119 invoked from network); 22 Dec 2004 09:51:35 -0000
Received: from unknown (HELO ptb-relay02.plus.net) (212.159.14.213)
  by sourceware.org with SMTP; 22 Dec 2004 09:51:35 -0000
Received: from [81.174.168.250] (helo=avocado)
	 by ptb-relay02.plus.net with esmtp (Exim) id 1Ch39U-000MSX-3Z
	for cygwin-patches@cygwin.com; Wed, 22 Dec 2004 09:51:30 +0000
From: "Chris January" <chris@atomice.net>
To: <cygwin-patches@cygwin.com>
Subject: PATCH: Replace spaces with tabs in /proc/<pid>/status.
Date: Wed, 22 Dec 2004 09:51:00 -0000
Message-ID: <067301c4e80b$cd34a440$0207a8c0@avocado>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0674_01C4E80B.CD3BD030"
X-SW-Source: 2004-q4/txt/msg00269.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0674_01C4E80B.CD3BD030
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-length: 174

2004-12-22  Chris January  <chris@atomice.net>

	* fhandler_process.cpp (format_process_status): Use tabs in
formatting
	instead of spaces.

Chris

--
http://www.atomice.com

------=_NextPart_000_0674_01C4E80B.CD3BD030
Content-Type: application/octet-stream;
	name="fhandler_process_status_tabs.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="fhandler_process_status_tabs.patch"
Content-length: 1882

Index: fhandler_process.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_process.cc,v=0A=
retrieving revision 1.46=0A=
diff -u -r1.46 fhandler_process.cc=0A=
--- fhandler_process.cc	18 Dec 2004 16:41:27 -0000	1.46=0A=
+++ fhandler_process.cc	22 Dec 2004 09:47:50 -0000=0A=
@@ -569,23 +569,23 @@=0A=
   // The real uid value for *this* process is stored at cygheap->user.real=
_uid=0A=
   // but we can't get at the real uid value for any other process, so=0A=
   // just fake it as p->uid. Similar for p->gid.=0A=
-  return __small_sprintf (destbuf, "Name:   %s\n"=0A=
-				   "State:  %c (%s)\n"=0A=
-				   "Tgid:   %d\n"=0A=
-				   "Pid:    %d\n"=0A=
-				   "PPid:   %d\n"=0A=
-				   "Uid:    %d %d %d %d\n"=0A=
-				   "Gid:    %d %d %d %d\n"=0A=
-				   "VmSize: %8d kB\n"=0A=
-				   "VmLck:  %8d kB\n"=0A=
-				   "VmRSS:  %8d kB\n"=0A=
-				   "VmData: %8d kB\n"=0A=
-				   "VmStk:  %8d kB\n"=0A=
-				   "VmExe:  %8d kB\n"=0A=
-				   "VmLib:  %8d kB\n"=0A=
-				   "SigPnd: %016x\n"=0A=
-				   "SigBlk: %016x\n"=0A=
-				   "SigIgn: %016x\n",=0A=
+  return __small_sprintf (destbuf, "Name:\t%s\n"=0A=
+				   "State:\t%c (%s)\n"=0A=
+				   "Tgid:\t%d\n"=0A=
+				   "Pid:\t%d\n"=0A=
+				   "PPid:\t%d\n"=0A=
+				   "Uid:\t%d %d %d %d\n"=0A=
+				   "Gid:\t%d %d %d %d\n"=0A=
+				   "VmSize:\t%8d kB\n"=0A=
+				   "VmLck:\t%8d kB\n"=0A=
+				   "VmRSS:\t%8d kB\n"=0A=
+				   "VmData:\t%8d kB\n"=0A=
+				   "VmStk:\t%8d kB\n"=0A=
+				   "VmExe:\t%8d kB\n"=0A=
+				   "VmLib:\t%8d kB\n"=0A=
+				   "SigPnd:\t%016x\n"=0A=
+				   "SigBlk:\t%016x\n"=0A=
+				   "SigIgn:\t%016x\n",=0A=
 			  cmd,=0A=
 			  state, state_str,=0A=
 			  p->pgid,=0A=

------=_NextPart_000_0674_01C4E80B.CD3BD030--
