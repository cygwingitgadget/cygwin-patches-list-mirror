Return-Path: <cygwin-patches-return-5816-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10458 invoked by alias); 6 Apr 2006 16:37:32 -0000
Received: (qmail 10447 invoked by uid 22791); 6 Apr 2006 16:37:31 -0000
X-Spam-Check-By: sourceware.org
Received: from vms042pub.verizon.net (HELO vms042pub.verizon.net) (206.46.252.42)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 06 Apr 2006 16:37:30 +0000
Received: from PHUMBLETXP ([12.6.244.2])  by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-4.02 (built Sep  9 2005)) with ESMTPA id <0IXB00IT37IGP1O7@vms042.mailsrvcs.net> for  cygwin-patches@cygwin.com; Thu, 06 Apr 2006 11:37:28 -0500 (CDT)
Date: Thu, 06 Apr 2006 16:37:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: [Patch] Make getenv() functional before the environment is initialized
To: <cygwin-patches@cygwin.com>
Message-id: <027701c65998$178103f0$280010ac@wirelessworld.airvananet.com>
MIME-version: 1.0
Content-type: multipart/mixed;  boundary="----=_NextPart_000_0274_01C65976.8FD91760"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00004.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0274_01C65976.8FD91760
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Content-length: 1746

This makes getenv return sensibly before the environment is initialized.
The attached file should be properly formatted (Changelog & patch), 
which my mailer can't do.

Pierre


2006-04-06  Pierre Humblet Pierre.Humblet@ieee.org

        * environ.cc (getearly): New function.
           (getenv) : Call getearly if needed.
    
Index: environ.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/environ.cc,v
retrieving revision 1.139
diff -u -p -b -r1.139 environ.cc
--- environ.cc  22 Mar 2006 16:42:44 -0000      1.139
+++ environ.cc  6 Apr 2006 16:06:05 -0000
@@ -224,6 +224,39 @@ my_findenv (const char *name, int *offse
 }
 
 /*
+ * getearly --
+ *     Primitive getenv before the environment is built.
+ */
+
+static char *
+getearly (const char * name)
+{
+  int s = strlen (name);
+  char * rawenv;
+  char ** ptr;
+  child_info *get_cygwin_startup_info ();
+  child_info_spawn *ci = (child_info_spawn *) get_cygwin_startup_info ();
+
+  if (ci && (ptr = ci->moreinfo->envp)) 
+    {
+      for (; *ptr; ptr++)
+       if (strncasematch (name, *ptr, s)
+           && (*(*ptr + s) == '='))
+         return *ptr + s + 1;
+    }
+  else if ((rawenv = GetEnvironmentStrings ()))
+    {
+      while (*rawenv)
+       if (strncasematch (name, rawenv, s)
+           && (*(rawenv + s) == '='))
+         return rawenv + s + 1;
+       else
+         rawenv = strchr (rawenv, 0) + 1;
+    }
+  return NULL;
+}
+
+/*
  * getenv --
  *     Returns ptr to value associated with name, if any, else NULL.
  */
@@ -232,7 +265,8 @@ extern "C" char *
 getenv (const char *name)
 {
   int offset;
-
+  if (!__cygwin_environ)
+    return getearly (name);
   return my_findenv (name, &offset);
 }

------=_NextPart_000_0274_01C65976.8FD91760
Content-Type: application/octet-stream;
	name="environ.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="environ.diff"
Content-length: 1916

=0A=
2006-04-06  Pierre Humblet Pierre.Humblet@ieee.org=0A=
=0A=
	* environ.cc (getearly): New function.=0A=
	(getenv): Call getearly if needed.=0A=
=0A=
=0A=
=0A=
Index: environ.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/environ.cc,v=0A=
retrieving revision 1.139=0A=
diff -u -p -b -r1.139 environ.cc=0A=
--- environ.cc	22 Mar 2006 16:42:44 -0000	1.139=0A=
+++ environ.cc	6 Apr 2006 16:15:31 -0000=0A=
@@ -224,6 +224,39 @@ my_findenv (const char *name, int *offse=0A=
 }=0A=
=20=0A=
 /*=0A=
+ * getearly --=0A=
+ *	Primitive getenv before the environment is built.=0A=
+ */=0A=
+=0A=
+static char *=0A=
+getearly (const char * name)=0A=
+{=0A=
+  int s =3D strlen (name);=0A=
+  char * rawenv;=0A=
+  char ** ptr;=0A=
+  child_info *get_cygwin_startup_info ();=0A=
+  child_info_spawn *ci =3D (child_info_spawn *) get_cygwin_startup_info ()=
;=0A=
+=0A=
+  if (ci && (ptr =3D ci->moreinfo->envp))=20=0A=
+    {=0A=
+      for (; *ptr; ptr++)=0A=
+	if (strncasematch (name, *ptr, s)=0A=
+	    && (*(*ptr + s) =3D=3D '=3D'))=0A=
+	  return *ptr + s + 1;=0A=
+    }=0A=
+  else if ((rawenv =3D GetEnvironmentStrings ()))=0A=
+    {=0A=
+      while (*rawenv)=0A=
+	if (strncasematch (name, rawenv, s)=0A=
+	    && (*(rawenv + s) =3D=3D '=3D'))=0A=
+	  return rawenv + s + 1;=0A=
+	else=0A=
+	  rawenv =3D strchr (rawenv, 0) + 1;=0A=
+    }=0A=
+  return NULL;=0A=
+}=0A=
+=0A=
+/*=0A=
  * getenv --=0A=
  *	Returns ptr to value associated with name, if any, else NULL.=0A=
  */=0A=
@@ -232,7 +265,8 @@ extern "C" char *=0A=
 getenv (const char *name)=0A=
 {=0A=
   int offset;=0A=
-=0A=
+  if (!__cygwin_environ)=0A=
+    return getearly (name);=0A=
   return my_findenv (name, &offset);=0A=
 }=0A=
=20=0A=

------=_NextPart_000_0274_01C65976.8FD91760--
