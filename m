Return-Path: <cygwin-patches-return-3752-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9609 invoked by alias); 27 Mar 2003 07:28:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9597 invoked from network); 27 Mar 2003 07:28:29 -0000
Message-ID: <006701c2f432$c62a5380$fa6d86d9@ellixia>
Reply-To: "Elfyn McBratney" <elfyn-cygwin@exposure.org.uk>
From: "Elfyn McBratney" <elfyn-cygwin@exposure.org.uk>
To: "cygwin-patches" <cygwin-patches@cygwin.com>
Subject: [PATCH] New '--install-type' option for cygcheck?
Date: Thu, 27 Mar 2003 07:28:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0064_01C2F432.C5AE45B0"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
X-SW-Source: 2003-q1/txt/msg00401.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0064_01C2F432.C5AE45B0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 394

I've been working on a new option for `cygcheck' that checks who Cygwin was
installed for. This could be used when users on the mailing list have
problems running services when the installation was done for "Just Me",
executing files in the same situation etc. Would this be a desirable
feature? Yes/no...patch attached :-)


Regards,

Elfyn McBratney
elfyn@exposure.org.uk
www.exposure.org.uk

------=_NextPart_000_0064_01C2F432.C5AE45B0
Content-Type: application/octet-stream;
	name="cygcheck.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cygcheck.diff"
Content-length: 3326

Index: utils/cygcheck.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/utils/cygcheck.cc,v=0A=
retrieving revision 1.33=0A=
diff -u -p -r1.33 cygcheck.cc=0A=
--- utils/cygcheck.cc	25 Mar 2003 01:20:04 -0000	1.33=0A=
+++ utils/cygcheck.cc	27 Mar 2003 07:26:30 -0000=0A=
@@ -26,6 +26,7 @@ int sysinfo =3D 0;=0A=
 int givehelp =3D 0;=0A=
 int keycheck =3D 0;=0A=
 int check_setup =3D 0;=0A=
+int install_type =3D 0;=0A=
=20=0A=
 #ifdef __GNUC__=0A=
 typedef long long longlong;=0A=
@@ -1310,12 +1311,53 @@ check_keys ()=0A=
   return 0;=0A=
 }=0A=
=20=0A=
+static int=0A=
+check_install_type (void)=0A=
+{=0A=
+  HKEY cyg_hkey;=0A=
+  long lret;=0A=
+  bool status =3D false;=0A=
+  int ret =3D 0;=0A=
+=20=20=0A=
+  lret =3D RegOpenKeyEx (HKEY_LOCAL_MACHINE,=0A=
+		       "SOFTWARE\\Cygnus Solutions\\Cygwin\\mounts v2\\/",=0A=
+		       0, KEY_READ, &cyg_hkey);=0A=
+=0A=
+  if (lret =3D=3D ERROR_SUCCESS)=0A=
+    {=0A=
+      printf ("Cygwin was installed for \"All Users\"\n");=0A=
+      RegCloseKey (cyg_hkey);=0A=
+      status =3D true;=0A=
+    }=0A=
+=0A=
+  if (!status)=0A=
+    {=0A=
+      lret =3D RegOpenKeyEx (HKEY_CURRENT_USER,=0A=
+                           "Software\\Cygnus Solutions\\Cygwin\\mounts v2\=
\/",=0A=
+                           0, KEY_READ, &cyg_hkey);=0A=
+=0A=
+      if (lret =3D=3D ERROR_SUCCESS)=0A=
+	{=0A=
+          printf ("Cygwin was installed for \"Just You\"\n");=0A=
+          RegCloseKey (cyg_hkey);=0A=
+	}=0A=
+      else=0A=
+	{=0A=
+          keyeprint ("check_install_type: RegOpenKeyEx");=0A=
+          ret =3D 1;=0A=
+	}=0A=
+    }=0A=
+=0A=
+  return (ret);=0A=
+}=0A=
+=0A=
 static void=0A=
 usage (FILE * stream, int status)=0A=
 {=0A=
   fprintf (stream, "\=0A=
 Usage: cygcheck [OPTIONS] [program ...]\n\=0A=
  -c, --check-setup  check packages installed via setup.exe\n\=0A=
+ -i, --install-type check who cygwin was installed for\n\=0A=
  -s, --sysinfo      system information (not with -k)\n\=0A=
  -v, --verbose      verbose output (indented) (for -s or programs)\n\=0A=
  -r, --registry     registry search (requires -s)\n\=0A=
@@ -1328,6 +1370,7 @@ You must at least give either -s or -k o=0A=
=20=0A=
 struct option longopts[] =3D {=0A=
   {"check-setup", no_argument, NULL, 'c'},=0A=
+  {"install-type", no_argument, NULL, 'i'},=0A=
   {"sysinfo", no_argument, NULL, 's'},=0A=
   {"registry", no_argument, NULL, 'r'},=0A=
   {"verbose", no_argument, NULL, 'v'},=0A=
@@ -1337,7 +1380,7 @@ struct option longopts[] =3D {=0A=
   {0, no_argument, NULL, 0}=0A=
 };=0A=
=20=0A=
-static char opts[] =3D "chkrsvV";=0A=
+static char opts[] =3D "cihkrsvV";=0A=
=20=0A=
 static void=0A=
 print_version ()=0A=
@@ -1376,6 +1419,9 @@ main (int argc, char **argv)=0A=
       case 'c':=0A=
 	check_setup =3D 1;=0A=
 	break;=0A=
+      case 'i':=0A=
+	install_type =3D 1;=0A=
+	break;=0A=
       case 'r':=0A=
 	registry =3D 1;=0A=
 	break;=0A=
@@ -1408,6 +1454,9 @@ main (int argc, char **argv)=0A=
=20=0A=
   if (keycheck)=0A=
     return check_keys ();=0A=
+=20=20=0A=
+  if (install_type)=0A=
+    return check_install_type ();=0A=
=20=0A=
   init_paths ();=0A=
=20=0A=

------=_NextPart_000_0064_01C2F432.C5AE45B0--

