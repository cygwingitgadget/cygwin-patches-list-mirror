Return-Path: <cygwin-patches-return-2326-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 22802 invoked by alias); 6 Jun 2002 01:06:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22788 invoked from network); 6 Jun 2002 01:06:25 -0000
Message-ID: <01c501c20cf6$987d45b0$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
Subject: Make CW_STRACE_TOGGLE toggle
Date: Wed, 05 Jun 2002 18:06:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_01C2_01C20CFE.FA1D0EB0"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00309.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_01C2_01C20CFE.FA1D0EB0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 864

Another patch but very small.

Currently calls to:

    cygwin_internal (CW_STRACE_TOGGLE, pid)

doesn't toggle the stracing of pid but simply turns it on again, i.e. a
no-op after the first call. This patch makes strace.exe read the current
value of the strace.active flag and invert it, rather than unilaterally
setting it.

I've got a small program that makes this call for a given process, so you
can turn stracing on and off around events of interest etc. I'll send it
along once I've thought of a good name for it (strtoggle? stroggle?
stronoff? . . . ) Any suggestions?

I find this patch useful since (pre-XP) debuggers can't detach from their
targets. Thus you're stuck with strace.exe once it's attached.

// Conrad

Changelog message:
* strace.cc (handle_output_debug_string): Invert the child's strace.active
flag rather than unilaterally setting it.


------=_NextPart_000_01C2_01C20CFE.FA1D0EB0
Content-Type: application/octet-stream;
	name="strace.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="strace.patch"
Content-length: 1013

Index: strace.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/utils/strace.cc,v=0A=
retrieving revision 1.21=0A=
diff -u -u -r1.21 strace.cc=0A=
--- strace.cc	2 Jun 2002 17:46:38 -0000	1.21=0A=
+++ strace.cc	6 Jun 2002 00:58:48 -0000=0A=
@@ -448,7 +448,16 @@=0A=
=20=0A=
   if (special =3D=3D _STRACE_INTERFACE_ACTIVATE_ADDR)=0A=
     {=0A=
-      DWORD new_flag =3D 1;=0A=
+      DWORD new_flag;=0A=
+=0A=
+      if (!ReadProcessMemory (hchild, (LPVOID) n, &new_flag,=0A=
+			       sizeof (new_flag), &nbytes))=0A=
+	error (0,=0A=
+	       "couldn't read strace flag from subprocess, windows error %d",=0A=
+	       GetLastError ());=0A=
+=0A=
+      new_flag =3D !new_flag;=0A=
+=0A=
       if (!WriteProcessMemory (hchild, (LPVOID) n, &new_flag,=0A=
 			       sizeof (new_flag), &nbytes))=0A=
 	error (0,=0A=

------=_NextPart_000_01C2_01C20CFE.FA1D0EB0--

