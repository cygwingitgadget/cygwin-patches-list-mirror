Return-Path: <cygwin-patches-return-1884-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 10279 invoked by alias); 24 Feb 2002 23:48:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10237 invoked from network); 24 Feb 2002 23:48:49 -0000
Message-ID: <004d01c1bd8d$c0fcdcc0$5c00a8c0@mchasecompaq>
From: "Michael A Chase" <mchase@ix.netcom.com>
To: "Robert Collins" <robert.collins@itdomain.com.au>,
	<cygwin-patches@cygwin.com>
References: <m31yfhdpkf.fsf@appel.lilypond.org><009201c1b9f9$99575fc0$0200a8c0@lifelesswks> <m3r8ng0wex.fsf@appel.lilypond.org> <018a01c1ba55$ff233b10$0200a8c0@lifelesswks> <02db01c1ba65$936be6f0$f400a8c0@mchasecompaq> <014001c1bd20$45424a60$0200a8c0@lifelesswks>
Subject: [Patch]setup.exe type prefixes for io_stream::mkpath_p and io_stream:open paths
Date: Sun, 24 Feb 2002 17:19:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0042_01C1BD4A.831C3CE0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q1/txt/msg00241.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0042_01C1BD4A.831C3CE0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 1687

----- Original Message -----
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Michael A Chase" <mchase@ix.netcom.com>; "Jan Nieuwenhuizen"
<janneke@gnu.org>
Cc: <cygwin-apps@cygwin.com>
Sent: Sunday, February 24, 2002 02:44
Subject: Re: setup.exe /var, /tmp?


> ----- Original Message -----
> From: "Michael A Chase" <mchase@ix.netcom.com>
>
> > These are probably not the only places where the prefixes may be
> missing.
> > Would it be worthwhile to add a log() call if no "file://" or
> "cygfile://"
> > prefix is found in io_stream::mkpath_p()?
>
> Possibly in your sandbox. I don't feel the need in CVS though :}.
>
> > I'm doing a search for all the mkpath_p() calls I can find, but often
> the
> > file or directory name is passed from somewhere else.
>
> Thank you.

I also looked through the calls to io_stream*::open() and found a couple
places that appeared to be missing the required prefix in
io_stream_cygfile.cc.

Robert,

To avoid confusion, perhaps cygpath() should be renamed native_path() or
natpath().  I could make that change fairly easily if you want.

--
Mac :})
** I normally forward private questions to the appropriate mail list. **
Ask Smarter: http://www.tuxedo.org/~esr/faqs/smart-questions.html
Give a hobbit a fish and he eats fish for a day.
Give a hobbit a ring and he eats fish for an age.

ChangeLog:

2002-02-24  Michael A Chase <mchase@ix.netcom.com>

    * desktop.cc (make_link): Add "file://" prefix to io_stream::mkpath_p()
call.
    (make_passwd_group): Ditto.
    * localdir.cc (save_local_dir): Ditto.
    * io_stream_cygfile.cc (io_stream_cygfile::mklink): Wrap long lines.
    Add "file://" prefix to io_stream::open() calls.


------=_NextPart_000_0042_01C1BD4A.831C3CE0
Content-Type: application/octet-stream;
	name="cinstall-mac-020224-1.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cinstall-mac-020224-1.patch"
Content-length: 2313

--- desktop.cc-0	Mon Feb 18 17:50:54 2002=0A=
+++ desktop.cc	Sun Feb 24 14:08:01 2002=0A=
@@ -111,7 +111,7 @@ make_link (String const &linkpath, Strin=0A=
   msg ("make_link %s, %s, %s\n",=0A=
        fname.cstr_oneuse(), title.cstr_oneuse(), target.cstr_oneuse());=0A=
=20=0A=
-  io_stream::mkpath_p (PATH_TO_FILE, fname);=0A=
+  io_stream::mkpath_p (PATH_TO_FILE, String ("file://") + fname);=0A=
=20=0A=
   String exepath;=0A=
=20=0A=
@@ -278,7 +278,7 @@ static void=0A=
 make_passwd_group ()=0A=
 {=0A=
   String fname =3D cygpath ("/etc/postinstall/passwd-grp.bat");=0A=
-  io_stream::mkpath_p (PATH_TO_FILE, fname);=0A=
+  io_stream::mkpath_p (PATH_TO_FILE, String ("file://") + fname);=0A=
=20=0A=
   if (uexists ("/etc/passwd") && uexists ("/etc/group"))=0A=
     return;=0A=
--- io_stream_cygfile.cc-0	Mon Feb 18 11:19:21 2002=0A=
+++ io_stream_cygfile.cc	Sun Feb 24 14:36:44 2002=0A=
@@ -128,16 +128,20 @@ io_stream_cygfile::mklink (String const=20=0A=
 	/* textmode alert: should we translate when linking from an binmode to a=
=0A=
 	   text mode mount and vice verca?=0A=
 	 */=0A=
-	io_stream *in =3D io_stream::open (cygpath (to), "rb");=0A=
+	io_stream *in =3D io_stream::open (String ("file://") + cygpath (to),=0A=
+					 "rb");=0A=
 	if (!in)=0A=
 	  {=0A=
-	    log (LOG_TIMESTAMP, String("could not open ") + to +" for reading in =
mklink");=0A=
+	    log (LOG_TIMESTAMP, String("could not open ") + to +=0A=
+		 " for reading in mklink");=0A=
 	    return 1;=0A=
 	  }=0A=
-	io_stream *out =3D io_stream::open (cygpath (from), "wb");=0A=
+	io_stream *out =3D io_stream::open (String ("file://") + cygpath (from),=
=0A=
+					  "wb");=0A=
 	if (!out)=0A=
 	  {=0A=
-	    log (LOG_TIMESTAMP, String("could not open ")+ from + " for writing i=
n mklink");=0A=
+	    log (LOG_TIMESTAMP, String("could not open ") + from +=0A=
+		 " for writing in mklink");=0A=
 	    delete in;=0A=
 	    return 1;=0A=
 	  }=0A=
--- localdir.cc-0	Mon Feb 18 11:19:22 2002=0A=
+++ localdir.cc	Sun Feb 24 14:23:34 2002=0A=
@@ -45,7 +45,7 @@ extern ThreeBarProgressPage Progress;=0A=
 void=0A=
 save_local_dir ()=0A=
 {=0A=
-  io_stream::mkpath_p (PATH_TO_DIR, local_dir);=0A=
+  io_stream::mkpath_p (PATH_TO_DIR, String ("file://") + local_dir);=0A=
=20=0A=
   io_stream *f;=0A=
   if (get_root_dir ().size())=0A=

------=_NextPart_000_0042_01C1BD4A.831C3CE0--
