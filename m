Return-Path: <cygwin-patches-return-2119-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7832 invoked by alias); 27 Apr 2002 17:13:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7817 invoked from network); 27 Apr 2002 17:13:51 -0000
Message-ID: <001901c1ee0e$61f789d0$0100a8c0@world9t3igycu7>
Reply-To: "Joshua Daniel Franklin" <joshuadfranklin@yahoo.com>
From: "Joshua Daniel Franklin" <joshuadfranklin@yahoo.com>
To: <cygwin-patches@cygwin.com>
Subject: Patch for mkpasswd
Date: Sat, 27 Apr 2002 10:13:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0016_01C1EDE4.760E9C80"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00103.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0016_01C1EDE4.760E9C80
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 484

Here is a patch for mkpasswd. It brings mkpasswd up to date with the
changes already made to mkgroup.

Changelog:

2001-03-19  Joshua Daniel Franklin  joshuadfranklin@yahoo.com
    * mkpasswd.c (usage): Simplify usage output.  Generalize to allow use
    for help. Correct '?' typo to 'h'.
    (longopts): Add version option.
    (opts): Add 'v' version option.
    (print_version): New function.
    (main): Accommodate new version option.  Accommodate usage parameter
    changes. 

------=_NextPart_000_0016_01C1EDE4.760E9C80
Content-Type: application/octet-stream;
	name="mkpasswd.c-patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="mkpasswd.c-patch"
Content-length: 5422

--- mkpasswd.c-orig	Sun Feb 24 13:28:27 2002=0A=
+++ mkpasswd.c	Tue Mar 19 19:21:32 2002=0A=
@@ -1,6 +1,6 @@=0A=
 /* mkpasswd.c:=0A=
=20=0A=
-   Copyright 1997, 1998, 1999, 2000, 2001 Red Hat, Inc.=0A=
+   Copyright 1997, 1998, 1999, 2000, 2001, 2002 Red Hat, Inc.=0A=
=20=0A=
    This file is part of Cygwin.=0A=
=20=0A=
@@ -21,6 +21,8 @@=0A=
 #include <sys/fcntl.h>=0A=
 #include <lmerr.h>=0A=
=20=0A=
+static const char version[] =3D "$Revision: 1.20 $";=0A=
+=0A=
 SID_IDENTIFIER_AUTHORITY sid_world_auth =3D {SECURITY_WORLD_SID_AUTHORITY}=
;=0A=
 SID_IDENTIFIER_AUTHORITY sid_nt_auth =3D {SECURITY_NT_AUTHORITY};=0A=
=20=0A=
@@ -393,26 +395,27 @@ print_special (int print_sids,=0A=
 }=0A=
=20=0A=
 int=0A=
-usage ()=0A=
+usage (FILE * stream, int status)=0A=
 {=0A=
-  fprintf (stderr, "Usage: mkpasswd [OPTION]... [domain]\n\n");=0A=
-  fprintf (stderr, "This program prints a /etc/passwd file to stdout\n\n")=
;=0A=
-  fprintf (stderr, "Options:\n");=0A=
-  fprintf (stderr, "   -l,--local              print local user accounts\n=
");=0A=
-  fprintf (stderr, "   -d,--domain             print domain accounts (from=
 current domain\n");=0A=
-  fprintf (stderr, "                           if no domain specified)\n")=
;=0A=
-  fprintf (stderr, "   -o,--id-offset offset   change the default offset (=
10000) added to uids\n");=0A=
-  fprintf (stderr, "                           in domain accounts.\n");=0A=
-  fprintf (stderr, "   -g,--local-groups       print local group informati=
on too\n");=0A=
-  fprintf (stderr, "                           if no domain specified\n");=
=0A=
-  fprintf (stderr, "   -m,--no-mount           don't use mount points for =
home dir\n");=0A=
-  fprintf (stderr, "   -s,--no-sids            don't print SIDs in GCOS fi=
eld\n");=0A=
-  fprintf (stderr, "                           (this affects ntsec)\n");=
=0A=
-  fprintf (stderr, "   -p,--path-to-home path  use specified path instead =
of user account home dir\n");=0A=
-  fprintf (stderr, "   -u,--username username  only return information for=
 the specified user\n");=0A=
-  fprintf (stderr, "   -?,--help               displays this message\n\n")=
;=0A=
-  fprintf (stderr, "One of `-l', `-d' or `-g' must be given on NT/W2K.\n")=
;=0A=
-  return 1;=0A=
+  fprintf (stream, "Usage: mkpasswd [OPTION]... [domain]\n\n"=0A=
+                   "This program prints a /etc/passwd file to stdout\n\n"=
=0A=
+                   "Options:\n"=0A=
+                   "   -l,--local              print local user accounts\n=
"=0A=
+                   "   -d,--domain             print domain accounts (from=
 current domain\n"=0A=
+                   "                           if no domain specified)\n"=
=0A=
+                   "   -o,--id-offset offset   change the default offset (=
10000) added to uids\n"=0A=
+                   "                           in domain accounts.\n"=0A=
+                   "   -g,--local-groups       print local group informati=
on too\n"=0A=
+                   "                           if no domain specified\n"=
=0A=
+                   "   -m,--no-mount           don't use mount points for =
home dir\n"=0A=
+                   "   -s,--no-sids            don't print SIDs in GCOS fi=
eld\n"=0A=
+                   "                           (this affects ntsec)\n"=0A=
+                   "   -p,--path-to-home path  use specified path instead =
of user account home dir\n"=0A=
+                   "   -u,--username username  only return information for=
 the specified user\n"=0A=
+                   "   -h,--help               displays this message\n"=0A=
+                   "   -v,--version            version information and exi=
t\n\n"=0A=
+                   "One of `-l', `-d' or `-g' must be given on NT/W2K.\n")=
;=0A=
+  return status;=0A=
 }=0A=
=20=0A=
 struct option longopts[] =3D {=0A=
@@ -425,10 +428,33 @@ struct option longopts[] =3D {=0A=
   {"path-to-home", required_argument, NULL, 'p'},=0A=
   {"username", required_argument, NULL, 'u'},=0A=
   {"help", no_argument, NULL, 'h'},=0A=
+  {"version", no_argument, NULL, 'v'},=0A=
   {0, no_argument, NULL, 0}=0A=
 };=0A=
=20=0A=
-char opts[] =3D "ldo:gsmhp:u:";=0A=
+char opts[] =3D "ldo:gsmhp:u:v";=0A=
+=0A=
+static void=0A=
+print_version ()=0A=
+{=0A=
+  const char *v =3D strchr (version, ':');=0A=
+  int len;=0A=
+  if (!v)=0A=
+    {=0A=
+      v =3D "?";=0A=
+      len =3D 1;=0A=
+    }=0A=
+  else=0A=
+    {=0A=
+      v +=3D 2;=0A=
+      len =3D strchr (v, ' ') - v;=0A=
+    }=0A=
+  printf ("\=0A=
+mkpasswd (cygwin) %.*s\n\=0A=
+passwd File Generator\n\=0A=
+Copyright 1997, 1998, 1999, 2000, 2001, 2002 Red Hat, Inc.\n\=0A=
+Compiled on %s", len, v, __DATE__);=0A=
+}=0A=
=20=0A=
 int=0A=
 main (int argc, char **argv)=0A=
@@ -455,7 +481,7 @@ main (int argc, char **argv)=0A=
   if (GetVersion () < 0x80000000)=0A=
     {=0A=
       if (argc =3D=3D 1)=0A=
-	return usage ();=0A=
+	return usage (stderr, 1);=0A=
       else=0A=
 	{=0A=
 	  while ((i =3D getopt_long (argc, argv, opts, longopts, NULL)) !=3D EOF)=
=0A=
@@ -494,7 +520,10 @@ main (int argc, char **argv)=0A=
 		disp_username =3D optarg;=0A=
 		break;=0A=
 	      case 'h':=0A=
-		return usage ();=0A=
+		return usage (stdout, 0);=0A=
+	      case 'v':=0A=
+               print_version ();=0A=
+		exit (0);=0A=
 	      default:=0A=
 		fprintf (stderr, "Try `%s --help' for more information.\n", argv[0]);=0A=
 		return 1;=0A=

------=_NextPart_000_0016_01C1EDE4.760E9C80--
