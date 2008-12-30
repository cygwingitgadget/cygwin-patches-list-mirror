Return-Path: <cygwin-patches-return-6400-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20229 invoked by alias); 30 Dec 2008 20:15:26 -0000
Received: (qmail 20219 invoked by uid 22791); 30 Dec 2008 20:15:26 -0000
X-SWARE-Spam-Status: No, hits=1.1 required=5.0 	tests=BAYES_50,HK_OBFDOM,J_CHICKENPOX_82
X-Spam-Check-By: sourceware.org
Received: from vms046pub.verizon.net (HELO vms046pub.verizon.net) (206.46.252.46)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 30 Dec 2008 20:14:48 +0000
Received: from PHUMBLETLAPXP ([173.9.58.250])  by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006)) with ESMTPA id <0KCP00LM9HK7Q8Y2@vms046.mailsrvcs.net> for  cygwin-patches@cygwin.com; Tue, 30 Dec 2008 14:14:37 -0600 (CST)
Date: Tue, 30 Dec 2008 20:15:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch] Make cygcheck handle Window paths with spaces
To: <cygwin-patches@cygwin.com>
Message-id: <00ad01c96abb$3ccee370$640410ac@wirelessworld.airvananet.com>
MIME-version: 1.0
Content-type: multipart/mixed;  boundary="----=_NextPart_000_00AA_01C96A91.4FF07290"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q4/txt/msg00044.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_00AA_01C96A91.4FF07290
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 2022

Formatting is more likely to be preserved in the attached files.

Pierre 

2008-12-30  Pierre Humblet  <Pierre.Humblet@ieee.org>

        * cygcheck.cc (pretty_id): Quote the path for popen.
        (dump_sysinfo_services): Ditto.


Index: cygcheck.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/cygcheck.cc,v
retrieving revision 1.105
diff -u -p -r1.105 cygcheck.cc
--- cygcheck.cc 12 Sep 2008 22:43:10 -0000 1.105
+++ cygcheck.cc 30 Dec 2008 19:20:32 -0000
@@ -1032,9 +1032,10 @@ pretty_id (const char *s, char *cygwin, 
       return;
     }
 
-  FILE *f = popen (id, "rt");
-
   char buf[16384];
+  snprintf (buf, sizeof (buf), "\"%s\"", id);
+  FILE *f = popen (buf, "rt");
+
   buf[0] = '\0';
   fgets (buf, sizeof (buf), f);
   pclose (f);
@@ -1118,7 +1119,7 @@ dump_sysinfo_services ()
     }
 
   /* check for a recent cygrunsrv */
-  snprintf (buf, sizeof (buf), "%s --version", cygrunsrv);
+  snprintf (buf, sizeof (buf), "\"%s\" --version", cygrunsrv);
   if ((f = popen (buf, "rt")) == NULL)
     {
       printf ("Failed to execute '%s', skipping services check.\n", buf);
@@ -1136,7 +1137,7 @@ dump_sysinfo_services ()
   /* For verbose mode, just run cygrunsrv --list --verbose and copy output
      verbatim; otherwise run cygrunsrv --list and then cygrunsrv --query for
      each service.  */
-  snprintf (buf, sizeof (buf), (verbose ? "%s --list --verbose" : "%s --list"),
+  snprintf (buf, sizeof (buf), (verbose ? "\"%s\" --list --verbose" : "%s --list"),
      cygrunsrv);
   if ((f = popen (buf, "rt")) == NULL)
     {
@@ -1167,7 +1168,7 @@ dump_sysinfo_services ()
       if (nchars > 0)
  for (char *srv = strtok (buf, "\n"); srv; srv = strtok (NULL, "\n"))
    {
-     snprintf (buf2, sizeof (buf2), "%s --query %s", cygrunsrv, srv);
+     snprintf (buf2, sizeof (buf2), "\"%s\" --query %s", cygrunsrv, srv);
      if ((f = popen (buf2, "rt")) == NULL)
        {
   printf ("Failed to execute '%s', skipping services check.\n", buf2);

------=_NextPart_000_00AA_01C96A91.4FF07290
Content-Type: application/octet-stream;
	name="cygcheck.cc.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cygcheck.cc.diff"
Content-length: 2163

Index: cygcheck.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/utils/cygcheck.cc,v=0A=
retrieving revision 1.105=0A=
diff -u -p -r1.105 cygcheck.cc=0A=
--- cygcheck.cc	12 Sep 2008 22:43:10 -0000	1.105=0A=
+++ cygcheck.cc	30 Dec 2008 19:20:32 -0000=0A=
@@ -1032,9 +1032,10 @@ pretty_id (const char *s, char *cygwin,=20=0A=
       return;=0A=
     }=0A=
=20=0A=
-  FILE *f =3D popen (id, "rt");=0A=
-=0A=
   char buf[16384];=0A=
+  snprintf (buf, sizeof (buf), "\"%s\"", id);=0A=
+  FILE *f =3D popen (buf, "rt");=0A=
+=0A=
   buf[0] =3D '\0';=0A=
   fgets (buf, sizeof (buf), f);=0A=
   pclose (f);=0A=
@@ -1118,7 +1119,7 @@ dump_sysinfo_services ()=0A=
     }=0A=
=20=0A=
   /* check for a recent cygrunsrv */=0A=
-  snprintf (buf, sizeof (buf), "%s --version", cygrunsrv);=0A=
+  snprintf (buf, sizeof (buf), "\"%s\" --version", cygrunsrv);=0A=
   if ((f =3D popen (buf, "rt")) =3D=3D NULL)=0A=
     {=0A=
       printf ("Failed to execute '%s', skipping services check.\n", buf);=
=0A=
@@ -1136,7 +1137,7 @@ dump_sysinfo_services ()=0A=
   /* For verbose mode, just run cygrunsrv --list --verbose and copy output=
=0A=
      verbatim; otherwise run cygrunsrv --list and then cygrunsrv --query f=
or=0A=
      each service.  */=0A=
-  snprintf (buf, sizeof (buf), (verbose ? "%s --list --verbose" : "%s --li=
st"),=0A=
+  snprintf (buf, sizeof (buf), (verbose ? "\"%s\" --list --verbose" : "%s =
--list"),=0A=
 	    cygrunsrv);=0A=
   if ((f =3D popen (buf, "rt")) =3D=3D NULL)=0A=
     {=0A=
@@ -1167,7 +1168,7 @@ dump_sysinfo_services ()=0A=
       if (nchars > 0)=0A=
 	for (char *srv =3D strtok (buf, "\n"); srv; srv =3D strtok (NULL, "\n"))=
=0A=
 	  {=0A=
-	    snprintf (buf2, sizeof (buf2), "%s --query %s", cygrunsrv, srv);=0A=
+	    snprintf (buf2, sizeof (buf2), "\"%s\" --query %s", cygrunsrv, srv);=
=0A=
 	    if ((f =3D popen (buf2, "rt")) =3D=3D NULL)=0A=
 	      {=0A=
 		printf ("Failed to execute '%s', skipping services check.\n", buf2);=0A=

------=_NextPart_000_00AA_01C96A91.4FF07290
Content-Type: application/octet-stream;
	name="ChangeLog.cygcheck"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ChangeLog.cygcheck"
Content-length: 175

2008-12-30  Pierre Humblet  <Pierre.Humblet@ieee.org>=0A=
=0A=
        * cygcheck.cc (pretty_id): Quote the path for popen.=0A=
	(dump_sysinfo_services): Ditto.=0A=
=0A=
=0A=

------=_NextPart_000_00AA_01C96A91.4FF07290--
