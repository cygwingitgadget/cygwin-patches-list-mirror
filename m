Return-Path: <cygwin-patches-return-1658-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 8559 invoked by alias); 7 Jan 2002 14:03:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8544 invoked from network); 7 Jan 2002 14:03:47 -0000
Message-ID: <013601c19784$1f95c1f0$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
Subject: getsem cleanup
Date: Mon, 07 Jan 2002 06:03:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0133_01C197E0.52917F20"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 07 Jan 2002 14:03:46.0202 (UTC) FILETIME=[1F705FA0:01C19784]
X-SW-Source: 2002-q1/txt/msg00015.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0133_01C197E0.52917F20
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 241

My first foray into signals...

ChangeLog:

2002-01-08  Robert Collins  rbtcollins@hotmail.com

    * sigproc.cc (getsem): Rearrange code to be more readable, and to
    always output an error if accessing or creating the semaphore fails.



------=_NextPart_000_0133_01C197E0.52917F20
Content-Type: application/octet-stream;
	name="getsem.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="getsem.patch"
Content-length: 2106

Index: sigproc.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/sigproc.cc,v=0A=
retrieving revision 1.95.2.2=0A=
diff -u -p -r1.95.2.2 sigproc.cc=0A=
--- sigproc.cc	2002/01/04 03:56:10	1.95.2.2=0A=
+++ sigproc.cc	2002/01/07 14:03:20=0A=
@@ -930,38 +930,33 @@ getsem (_pinfo *p, const char *str, int=20=0A=
 		  ISSTATE (p, PID_INITIALIZING));=0A=
       for (int i =3D 0; ISSTATE (p, PID_INITIALIZING) && i < wait; i++)=0A=
 	Sleep (1);=0A=
-    }=0A=
-=0A=
-  SetLastError (0);=0A=
-  if (p =3D=3D NULL)=0A=
-    {=0A=
-      char sa_buf[1024];=0A=
-=0A=
-      DWORD winpid =3D GetCurrentProcessId ();=0A=
-      h =3D CreateSemaphore (allow_ntsec ? sec_user_nih (sa_buf) : &sec_no=
ne_nih,=0A=
-			   init, max, str =3D shared_name (str, winpid));=0A=
-      p =3D myself;=0A=
-    }=0A=
-  else=0A=
-    {=0A=
+      SetLastError (0);=0A=
       h =3D OpenSemaphore (SEMAPHORE_ALL_ACCESS, FALSE,=0A=
-			 str =3D shared_name (str, p->dwProcessId));=0A=
+	  		 str =3D shared_name (str, p->dwProcessId));=0A=
=20=0A=
       if (h =3D=3D NULL)=0A=
-	{=0A=
+        {=0A=
 	  if (GetLastError () =3D=3D ERROR_FILE_NOT_FOUND && !proc_exists (p))=0A=
 	    set_errno (ESRCH);=0A=
 	  else=0A=
 	    set_errno (EPERM);=0A=
-	  return NULL;=0A=
 	}=0A=
     }=0A=
-=0A=
-  if (!h)=0A=
+  else=0A=
     {=0A=
-      system_printf ("can't %s %s, %E", p ? "open" : "create", str);=0A=
-      set_errno (ESRCH);=0A=
+      SetLastError (0);=0A=
+      char sa_buf[1024];=0A=
+=0A=
+      DWORD winpid =3D GetCurrentProcessId ();=0A=
+      h =3D CreateSemaphore (allow_ntsec ? sec_user_nih (sa_buf) : &sec_no=
ne_nih,=0A=
+			   init, max, str =3D shared_name (str, winpid));=0A=
+      p =3D myself;=0A=
+      if (h =3D=3D NULL)=0A=
+	set_errno (ESRCH);=0A=
     }=0A=
+=0A=
+  if (h =3D=3D NULL)=0A=
+    system_printf ("can't %s %s, %E", p ? "open" : "create", str);=0A=
   return h;=0A=
 }=0A=
=20=0A=

------=_NextPart_000_0133_01C197E0.52917F20--
