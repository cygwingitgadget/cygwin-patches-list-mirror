Return-Path: <cygwin-patches-return-7686-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10449 invoked by alias); 27 Jul 2012 08:08:31 -0000
Received: (qmail 10417 invoked by uid 22791); 27 Jul 2012 08:08:28 -0000
X-SWARE-Spam-Status: No, hits=-5.5 required=5.0	tests=AWL,BAYES_00,KHOP_PGP_SIGNED,SPF_HELO_PASS,TW_YG,T_RP_MATCHES_RCVD
X-Spam-Check-By: sourceware.org
Received: from dancol.org (HELO dancol.org) (96.126.100.184)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 27 Jul 2012 08:07:56 +0000
Received: from c-76-22-66-162.hsd1.wa.comcast.net ([76.22.66.162] helo=[0.0.0.0])	by dancol.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)	(Exim 4.72)	(envelope-from <dancol@dancol.org>)	id 1SufaU-0004oE-KL	for cygwin-patches@cygwin.com; Fri, 27 Jul 2012 01:07:54 -0700
Message-ID: <50124C62.9080405@dancol.org>
Date: Fri, 27 Jul 2012 08:08:00 -0000
From: Daniel Colascione <dancol@dancol.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: New modes for cygpath that terminate path with null byte, nothing
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="------------enigCDB11275A53A7C677EDF3965"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q3/txt/msg00007.txt.bz2

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCDB11275A53A7C677EDF3965
Content-Type: multipart/mixed;
 boundary="------------020701070607020006080708"

This is a multi-part message in MIME format.
--------------020701070607020006080708
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-length: 518

I wrote this patch because I often write this:

$ cygpath -aw foo > /dev/clipboard

Today, cygpath always appends a newline to the information in the
clipboard, which is annoying when trying to paste into a program that
interprets newlines specially. This patch implements two new options:
-0/--null and -n/--no-newline. The former separates all paths output by
cygpath with a null byte; the latter separates them with nothing at all.
With -n, my example above works more smoothly and pastes don't include a
newline.


--------------020701070607020006080708
Content-Type: text/plain; charset=windows-1252;
 name="cygpath-n0.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="cygpath-n0.patch"
Content-length: 3295

Index: cygpath.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/utils/cygpath.cc,v
retrieving revision 1.69
diff -u -r1.69 cygpath.cc
--- cygpath.cc	6 Jul 2012 14:52:33 -0000	1.69
+++ cygpath.cc	27 Jul 2012 08:01:19 -0000
@@ -37,6 +37,7 @@
 static char *prog_name;
 static char *file_arg, *output_arg;
 static int path_flag, unix_flag, windows_flag, absolute_flag;
+static int separator_mode; // 0 =3D newline, 1 =3D null, 2 =3D nothing
 static int shortname_flag, longname_flag;
 static int ignore_flag, allusers_flag, output_flag;
 static int mixed_flag, options_from_file_flag, mode_flag;
@@ -47,6 +48,8 @@
 static struct option long_options[] =3D {
   {(char *) "absolute", no_argument, NULL, 'a'},
   {(char *) "close", required_argument, NULL, 'c'},
+  {(char *) "no-newline", no_argument, NULL, 'n'},
+  {(char *) "null", no_argument, NULL, '0'},
   {(char *) "dos", no_argument, NULL, 'd'},
   {(char *) "file", required_argument, NULL, 'f'},
   {(char *) "help", no_argument, NULL, 'h'},
@@ -73,14 +76,14 @@
   {0, no_argument, 0, 0}
 };
=20
-static char options[] =3D "ac:df:hilmMopst:uVwAC:DHOPSWF:";
+static char options[] =3D "ac:df:hilmMopst:uVwAC:DHOPSWF:n0";
=20
 static void
 usage (FILE * stream, int status)
 {
   if (!ignore_flag || !status)
     fprintf (stream, "\
-Usage: %1$s (-d|-m|-u|-w|-t TYPE) [-f FILE] [OPTION]... NAME...\n\
+Usage: %1$s (-d|-m|-u|-w|-t TYPE) [-n0] [-f FILE] [OPTION]... NAME...\n\
        %1$s [-c HANDLE] \n\
        %1$s [-ADHOPSW] \n\
        %1$s [-F ID] \n\
@@ -132,6 +135,8 @@
   -f, --file FILE       read FILE for input; use - to read from STDIN\n\
   -o, --option          read options from FILE as well (for use with --fil=
e)\n\
   -c, --close HANDLE    close HANDLE (for use in captured process)\n\
+  -n, --no-newline      do not print a newline after the path\n\
+  -0, --null            print a null byte instead of a newline after each =
path\n\
   -i, --ignore          ignore missing argument\n\
   -h, --help            output usage information and exit\n\
   -V, --version         output version information and exit\n\
@@ -303,6 +308,29 @@
   return ret;
 }
=20
+static void
+output_with_separator (const char* buf)
+{
+  fputs (buf, stdout);
+
+  switch (separator_mode)
+    {
+    case 0:
+      fputc ('\n', stdout);
+      break;
+
+    case 1:
+      fputc ('\0', stdout);
+      break;
+
+    case 2:
+      break;
+
+    default:
+      abort ();
+    }
+}
+
 static char *
 get_device_paths (char *path)
 {
@@ -621,7 +649,8 @@
       if (mixed_flag)
 	convert_slashes (buf);
     }
-  printf ("%s\n", buf);
+
+  output_with_separator (buf);
 }
=20
 static void
@@ -756,7 +785,8 @@
 	}
     }
=20
-  puts (print_tmp ? tmp : buf);
+  output_with_separator (print_tmp ? tmp : buf);
+=20=20
   if (buf2)
     free (buf2);
   if (buf)
@@ -810,6 +840,14 @@
 	  CloseHandle ((HANDLE) strtoul (optarg, NULL, 16));
 	  break;
=20
+        case '0':
+          separator_mode =3D 1;
+          break;
+
+        case 'n':
+          separator_mode =3D 2;
+          break;
+
 	case 'd':
 	  windows_flag =3D 1;
 	  shortname_flag =3D 1;

--------------020701070607020006080708--

--------------enigCDB11275A53A7C677EDF3965
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 259

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (Cygwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlASTGIACgkQ17c2LVA10VsXtgCggy61JfOEANCdFufK8r9iFcQ2
po8AoJB73e1Xu/Zo2Br52BNr8a1THwOP
=VoHm
-----END PGP SIGNATURE-----

--------------enigCDB11275A53A7C677EDF3965--
