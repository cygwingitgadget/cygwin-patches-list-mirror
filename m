Return-Path: <cygwin-patches-return-1869-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 13667 invoked by alias); 18 Feb 2002 23:00:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13597 invoked from network); 18 Feb 2002 23:00:22 -0000
Message-ID: <002801c1b8d0$0042a300$f400a8c0@mchasecompaq>
From: "Michael A Chase" <mchase@ix.netcom.com>
To: <cygwin-patches@cygwin.com>
Subject: [PATCH]setup.exe passwd-grp.bat being created when not needed
Date: Mon, 18 Feb 2002 16:40:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0023_01C1B88C.E3C8E290"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q1/txt/msg00226.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0023_01C1B88C.E3C8E290
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Content-length: 1067

Currently /etc/postinstall/passwd-grp.bat is opened before the need for it
is determined.  This results in the file always being executed even though
it is normally empty.   This patch may eliminate the flashing console window
at the end of setup.exe when no action is expected.

I left the iostream::mkpath_p() call at the top of the function to make sure
/etc/postinstall/ always exists after make_passwd_group() is called.  This
appears to be the only place the directory is created explicitly.

Sorry for the separate patches.  The two issues are independent and I didn't
notice this until I'd already sent the previous patch.  The patches may be
combined if you wish.
--
Mac :})
** I normally forward private questions to the appropriate mail list. **
Ask Smarter: http://www.tuxedo.org/~esr/faqs/smart-questions.htm
Give a hobbit a fish and he eats fish for a day.
Give a hobbit a ring and he eats fish for an age.

ChangeLog:

2002-02-18  Michael A Chase <mchase@ix.netcom.com>

    * desktop.cc (make_passwd_group): Don't create passwd-grp.bat
unnecessarily.

------=_NextPart_000_0023_01C1B88C.E3C8E290
Content-Type: application/octet-stream;
	name="cinstall-mac-020218-2.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cinstall-mac-020218-2.patch"
Content-length: 1194

--- desktop.cc-0	Mon Feb 18 11:19:19 2002=0A=
+++ desktop.cc	Mon Feb 18 14:54:58 2002=0A=
@@ -280,9 +280,9 @@ make_passwd_group ()=0A=
   String fname =3D cygpath ("/etc/postinstall/passwd-grp.bat");=0A=
   io_stream::mkpath_p (PATH_TO_FILE, fname);=0A=
=20=0A=
-  FILE *p =3D fopen (fname.cstr_oneuse(), "wt");=0A=
-  if (!p)=0A=
+  if (uexists ("/etc/passwd") && uexists ("/etc/group"))=0A=
     return;=0A=
+=0A=
   if (verinfo.dwPlatformId !=3D VER_PLATFORM_WIN32_NT)=0A=
     {=0A=
       packagedb db;=0A=
@@ -294,19 +294,17 @@ make_passwd_group ()=0A=
 	  String inst_version =3D=0A=
 	    canonicalize_version (pkg->installed->Canonical_version ());=0A=
 	  if (inst_version.compare(border_version) <=3D 0)=0A=
-	    goto out;=0A=
+	    return;=0A=
 	}=0A=
     }=0A=
=20=0A=
-  if (uexists ("/etc/passwd") && uexists ("/etc/group"))=0A=
-    goto out;=0A=
-=0A=
+  FILE *p =3D fopen (fname.cstr_oneuse(), "wt");=0A=
+  if (!p)=0A=
+    return;=0A=
   if (!uexists ("/etc/passwd"))=0A=
     fprintf (p, "bin\\mkpasswd -l > etc\\passwd\n");=0A=
   if (!uexists ("/etc/group"))=0A=
     fprintf (p, "bin\\mkgroup -l > etc\\group\n");=0A=
-=0A=
-out:=0A=
   fclose (p);=0A=
 }=0A=
=20=0A=

------=_NextPart_000_0023_01C1B88C.E3C8E290--

