Return-Path: <cygwin-patches-return-5361-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18850 invoked by alias); 2 Mar 2005 15:48:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18805 invoked from network); 2 Mar 2005 15:48:25 -0000
Received: from unknown (HELO gate15-norfolk.nmci.navy.mil) (138.162.5.12)
  by sourceware.org with SMTP; 2 Mar 2005 15:48:25 -0000
Received: from naeanrfkms04.nmci.navy.mil by gate15-norfolk.nmci.navy.mil
          via smtpd (for sourceware.org [12.107.209.250]) with ESMTP; Wed, 2 Mar 2005 15:48:25 +0000
Received: (private information removed)
Received: from no.name.available by naeanrfkfw14c.nmci.navy.mil
          via smtpd (for insidesmtp2.nmci.navy.mil [10.16.0.170]) with ESMTP; Wed, 2 Mar 2005 15:48:20 +0000
Received: (private information removed)
Received: (private information removed)
Received: (private information removed)
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: cygstart patch
Date: Wed, 02 Mar 2005 15:48:00 -0000
Message-ID: <49D88D820A7BC0479A7B0932D4219EFE1A4BC7@NAEAPAXREX04VA.nadsusea.nads.navy.mil>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
From: "Derosa, Anthony  CIV NAVAIR 2035, 2, 205/214" <Anthony.Derosa1@navy.mil>
To: <cygwin-patches@cygwin.com>
X-OriginalArrivalTime: 02 Mar 2005 15:47:40.0423 (UTC) FILETIME=[2A5F8170:01C51F3F]
X-SW-Source: 2005-q1/txt/msg00064.txt.bz2

I found a small bug and added a feature to the cygstart utility, which is p=
art of the cygutils package.  The feature that I added removes the limit on=
 the length of the command line arguments passed to the target application,=
 which was previously limited to MAX_PATH.  The bug I fixed was in regard t=
o freeing the variable "args" instead of tyring to free "workDir" twice.  A=
 patch and change log follow below.  As this is my first contribution, plea=
se correct me if I did something incorrectly.

-Anthony


Change Log

2005-03-02  Anthony DeRosa  <Anthony dot DeRosa dot 1 at navy dot mil>

* cygstart.c (main): removed limit on the length of command line arguments =
passed to the target application

* cygstart.c (main): fixed typo that freed the variable "workDir" twice ins=
tead of freeing "args"


Patch

--- ../cygutils-1.2.6/src/cygstart/cygstart.c	2002-03-16 00:49:44.000000000=
 -0500
+++ src/cygstart/cygstart.c	2005-03-02 09:16:00.383625000 -0500
@@ -340,14 +340,18 @@ int main(int argc, const char **argv)
=20
     /* Retrieve any arguments */
     if (rest && *rest) {
-        if ((args =3D (char *) malloc(MAX_PATH+1)) =3D=3D NULL) {
+        if ((args =3D (char *) malloc(strlen(*rest)+1)) =3D=3D NULL) {
             fprintf(stderr, "%s: memory allocation error\n", argv[0]);
             exit(1);
-        }
-        strncpy(args, *rest, MAX_PATH);
+        }=09=20
+        strcpy(args, *rest);
         while (rest++ && *rest) {
-            strncat(args, " ", MAX_PATH-strlen(args));
-            strncat(args, *rest, MAX_PATH-strlen(args));
+            if ( (args =3D (char *) realloc(args, strlen(args) + strlen(*r=
est) + 1)) =3D=3D NULL) {
+                fprintf(stderr, "%s: memory allocation error\n", argv[0]);
+                exit(1);
+            }=09=09
+            strcat(args, " ");
+            strcat(args, *rest);
         }
     }
=20
@@ -359,7 +363,7 @@ int main(int argc, const char **argv)
     if (action)
         free(action);
     if (args)
-        free(workDir);
+        free(args);
     if (workDir)
         free(workDir);
     if (file)
