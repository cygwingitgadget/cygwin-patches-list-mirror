Return-Path: <cygwin-patches-return-1780-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 27047 invoked by alias); 25 Jan 2002 02:59:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27028 invoked from network); 25 Jan 2002 02:59:08 -0000
Message-ID: <015c01c1a54c$3a4bfac0$a100a8c0@mchasecompaq>
From: "Michael A Chase" <mchase@ix.netcom.com>
To: <cygwin-patches@cygwin.com>
References: <003f01c1a542$742968e0$a100a8c0@mchasecompaq> <20020125015129.GA16592@redhat.com>
Subject: Re: [PATCH]Package extention recognition (revision 1)
Date: Thu, 24 Jan 2002 18:59:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0157_01C1A509.25964BA0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q1/txt/msg00137.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0157_01C1A509.25964BA0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 1738

----- Original Message -----
From: "Christopher Faylor" <cgf@redhat.com>
To: <cygwin-patches@cygwin.com>
Sent: Thursday, January 24, 2002 17:51
Subject: Re: [PATCH]Package extention recognition


> On Thu, Jan 24, 2002 at 05:48:35PM -0800, Michael A Chase wrote:
> >I noticed that find_tar_ext() always returns after checking for
".tar.bz2"
> >and ".tar.gz" so it never gets to the check for ".tar".  As long as I was
> >fixing that, it seemed like a good time to add ".cwp" as an accepted file
> >extension.
>
> Haven't we already debated this issue?  I don't see any reason to inflict
> a .cwp on the world and I can't imagine why we'd ever want a plain .tar
> rather than a .tar.bz2.

The last discussion I saw on ".cwp" kind of wandered off when someone
offered a patch that was more complicated than necessary.  It seemed like a
good idea (along with .deb or rpm) to avoid the next round of 'Why doesn't
the install I did with WinZip not work?', but I can easily change the patch
remove both.

The current un-patched code leaves off ".tar" inadvertently.

The revised patch is identical to the previous one except that the tests for
".cwp", and ".tar" are removed from find_tar_ext().
--
Mac :})
** I normally forward private questions to the appropriate mail list. **
Give a hobbit a fish and he eats fish for a day.
Give a hobbit a ring and he eats fish for an age.

Change (with .cwp and .tar removed):

2002-01-24  Michael A Chase <mchase@ix.netcom.com>

    * filemanip.cc (find_tar_ext): Clean up extensions tests.
    * fromcwd.cc (do_fromcwd): Try same extension as binary archive for -src
    archive before falling back to .tar.bz2 or .tar.gz.
    * install.cc (install_one_source): Add space between words in log()
call.


------=_NextPart_000_0157_01C1A509.25964BA0
Content-Type: application/octet-stream;
	name="install.cc-patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="install.cc-patch"
Content-length: 455

--- install.cc-0	Thu Jan 24 17:22:12 2002=0A=
+++ install.cc	Thu Jan 24 17:22:41 2002=0A=
@@ -184,7 +184,7 @@ install_one_source (packagemeta & pkgm,=20=0A=
   char msg[64];=0A=
   strcpy (msg, "Installing");=0A=
   Progress.SetText1 (msg);=0A=
-  log (0, "%s%s", msg, source.Cached ());=0A=
+  log (0, "%s %s", msg, source.Cached ());=0A=
   io_stream *tmp =3D io_stream::open (source.Cached (), "rb");=0A=
   archive *thefile =3D 0;=0A=
   if (tmp)=0A=

------=_NextPart_000_0157_01C1A509.25964BA0
Content-Type: application/octet-stream;
	name="filemanip.cc-patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="filemanip.cc-patch"
Content-length: 679

--- filemanip.cc-0	Thu Jan 24 16:43:57 2002=0A=
+++ filemanip.cc	Thu Jan 24 16:22:08 2002=0A=
@@ -69,10 +69,12 @@ find_tar_ext (const char *path)=0A=
   char *ext =3D strstr (path, ".tar.bz2");=0A=
   if (ext)=0A=
     return (end - ext) =3D=3D 8 ? ext - path : 0;=0A=
-  if ((ext =3D strstr (path, ".tar.gz")));=0A=
-  return (end - ext) =3D=3D 7 ? ext - path : 0;=0A=
-  if ((ext =3D strstr (path, ".tar")));=0A=
-  return (end - ext) =3D=3D 4 ? ext - path : 0;=0A=
+  if ((ext =3D strstr (path, ".tar.gz")))=0A=
+    return (end - ext) =3D=3D 7 ? ext - path : 0;=0A=
+  return 0;=0A=
 }=0A=
=20=0A=
 /* Parse a filename into package, version, and extension components. */=0A=

------=_NextPart_000_0157_01C1A509.25964BA0
Content-Type: application/octet-stream;
	name="fromcwd.cc-patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="fromcwd.cc-patch"
Content-length: 1350

--- fromcwd.cc-0	Thu Jan 24 16:43:58 2002=0A=
+++ fromcwd.cc	Thu Jan 24 16:40:07 2002=0A=
@@ -179,8 +179,9 @@ do_fromcwd (HINSTANCE h, HWND owner)=0A=
 	    /* Is there a -src file too? */=0A=
 	    int n =3D find_tar_ext (p->info[t].install);=0A=
 	    strcpy (srcpath, p->info[t].install);=0A=
-	    strcpy (srcpath + n, "-src.tar.gz");=0A=
-	    msg ("looking for %s", srcpath);=0A=
+	    strcpy (srcpath + n, "-src");=0A=
+	    /* First try same extension as the binary */=0A=
+	    strcat (srcpath, p->info[t].install + n);=0A=
=20=0A=
 	    WIN32_FIND_DATA wfd;=0A=
 	    HANDLE h =3D FindFirstFile (srcpath, &wfd);=0A=
@@ -189,12 +190,21 @@ do_fromcwd (HINSTANCE h, HWND owner)=0A=
 		strcpy (srcpath + n, "-src.tar.bz2");=0A=
 		h =3D FindFirstFile (srcpath, &wfd);=0A=
 	      }=0A=
+	    if (h =3D=3D INVALID_HANDLE_VALUE)=0A=
+	      {=0A=
+		strcpy (srcpath + n, "-src.tar.gz");=0A=
+		h =3D FindFirstFile (srcpath, &wfd);=0A=
+	      }=0A=
 	    if (h !=3D INVALID_HANDLE_VALUE)=0A=
 	      {=0A=
-		msg ("-- got it");=0A=
+		msg ("found source file %s", srcpath);=0A=
 		FindClose (h);=0A=
 		p->info[t].source =3D _strdup (srcpath);=0A=
 		p->info[t].source_size =3D wfd.nFileSizeLow;=0A=
+	      }=0A=
+	    else=0A=
+	      {=0A=
+		msg ("did not find source file for %s", p->info[t].install);=0A=
 	      }=0A=
 	  }=0A=
     }=0A=

------=_NextPart_000_0157_01C1A509.25964BA0--

