Return-Path: <cygwin-patches-return-4764-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17406 invoked by alias); 16 May 2004 02:38:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17395 invoked from network); 16 May 2004 02:38:47 -0000
Message-Id: <3.0.5.32.20040515223540.00810100@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sun, 16 May 2004 02:38:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch]: c:.
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1084689340==_"
X-SW-Source: 2004-q2/txt/msg00116.txt.bz2

--=====================_1084689340==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 796

I have run more tests and noticed that c:. and c:..
are now interpreted as c:/
That's because of the new code that strips trailing dots
and spaces. 

A patch is attached. It works fine on WinME (ls, cd, etc...)
but I am wondering how NtCreateFile reacts to that syntax
as well as to c:xxxx 
Depending on the answer we may have to treat these forms in
a new way (perhaps just forbid them).

If we do not use the patch, then chdir must be tuned to
handle these paths appropriately (they are not recognized by
isabspath, although they are absolute).

Paths such as c:../.. are not handled properly, but that's
not a regression.

Windows never stops amazing me!

Pierre

2004-05-16  Pierre Humblet <pierre.humblet@ieee.org>

	* path.c {path_conv::check): Do not strip trailing dots in
	c:. and c:..


--=====================_1084689340==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="dot.diff"
Content-length: 1257

Index: path.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.312
diff -u -p -r1.312 path.cc
--- path.cc	15 May 2004 15:55:43 -0000	1.312
+++ path.cc	16 May 2004 00:40:18 -0000
@@ -556,13 +556,18 @@ path_conv::check (const char *src, unsig
 	       tail--;
 	    }
           /* Remove trailing dots and spaces which are ignored by Win32 fu=
nctions but
-	     not by native NT functions. */
-          while (tail[-1] =3D=3D '.' || tail[-1] =3D=3D ' ')
-	    tail--;
-          if (tail > path_copy + 1 && isslash (tail[-1]))
-            {
-	      error =3D ENOENT;
-              return;
+	     not by native NT functions, except c:. and c:.. */
+	  if (tail - path_copy > 4
+	      || !isdrive (path_copy)
+	      || !(path_copy[2] =3D=3D '.' && (!path_copy[3] || path_copy[3] =3D=
=3D '.')))
+	    {
+	      while (tail[-1] =3D=3D '.' || tail[-1] =3D=3D ' ')
+		tail--;
+	      if (tail > path_copy + 1 && isslash (tail[-1]))
+	        {
+		  error =3D ENOENT;
+		  return;
+		}
 	    }
         }
       path_end =3D tail;

--=====================_1084689340==_--
