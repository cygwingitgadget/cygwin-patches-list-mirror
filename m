Return-Path: <cygwin-patches-return-2433-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 8637 invoked by alias); 14 Jun 2002 22:29:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8623 invoked from network); 14 Jun 2002 22:29:32 -0000
Message-ID: <003c01c213f3$2ed077f0$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
Subject: Mount interaction with /dev & /proc entries
Date: Fri, 14 Jun 2002 15:29:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0037_01C213FB.8DFC0CA0"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00416.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0037_01C213FB.8DFC0CA0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 1695

Chris, on the cygwin mailing list recently, you discussed using mount
to change the default binmode/textmode for opening devices. In
particular, as an example you suggested using:

> mount -t -s \dev\piper /dev/piper

I was just looking at mount_info::conv_to_win32_path() and (AFAICS)
this won't work. At path.cc:1443, the code that catches device paths,
short-circuits all the mount point checking (and thus the
binmode/textmode stuff too) by a goto out_no_chroot_check.

Looking at this code I noticed that the /proc handling is different,
that is, it does perform mount point and chroot checking. I would have
thought that it probably doesn't want to be doing chroot checking
(otherwise /proc will always disappear). Also the win32 paths that the
code generates for /proc entries are a bit bogus, e.g.
C:\cygwin\proc\uptime.

I've attached a patch to make /proc more like /dev, i.e. skip the
chroot and mount point checking, and set the path to binary (again,
just as per devices).

This probably isn't exactly right (tho' it may be righter than what's
there now), since you might well want /dev to do mount point checking
(as you suggest). But until there is the ability to mount virtual
filesystems as and where needed (your other suggestion: approx.
mount --type dev /dev), you probably don't want either /dev or /proc
to do chroot checking. So, this patch is halfway there and a little
more consistent. Assuming I haven't missed anything of course.

Cheers,

// Conrad

2002-06-14  Conrad Scott  <conrad.scott@dsl.pipex.com>

 * path.cc (mount_info::conv_to_win32_path): Skip mount point and
 chroot checking for /proc entries and default them to binary mode:
 all as per /dev entries.


------=_NextPart_000_0037_01C213FB.8DFC0CA0
Content-Type: application/octet-stream;
	name="path.cc.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="path.cc.patch"
Content-length: 1331

Index: path.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v=0A=
retrieving revision 1.224=0A=
diff -u -u -r1.224 path.cc=0A=
--- path.cc	13 Jun 2002 03:04:50 -0000	1.224=0A=
+++ path.cc	14 Jun 2002 22:24:09 -0000=0A=
@@ -1444,16 +1444,20 @@=0A=
       goto out_no_chroot_check;=0A=
     }=0A=
=20=0A=
-  /* Check if the cygdrive prefix was specified.  If so, just strip=0A=
-     off the prefix and transform it into an MS-DOS path. */=0A=
-  MALLOC_CHECK;=0A=
   if (isproc (pathbuf))=0A=
     {=0A=
       devn =3D fhandler_proc::get_proc_fhandler (pathbuf);=0A=
       if (devn =3D=3D FH_BAD)=0A=
 	return ENOENT;=0A=
+      *flags =3D MOUNT_BINARY;	/* FIXME: Is this a sensible default for /p=
roc files? */=0A=
+      rc =3D 0;=0A=
+      goto out_no_chroot_check;=0A=
     }=0A=
-  else if (iscygdrive (pathbuf))=0A=
+=0A=
+  /* Check if the cygdrive prefix was specified.  If so, just strip=0A=
+     off the prefix and transform it into an MS-DOS path. */=0A=
+  MALLOC_CHECK;=0A=
+  if (iscygdrive (pathbuf))=0A=
     {=0A=
       int n =3D mount_table->cygdrive_len - 1;=0A=
       if (!pathbuf[n] ||=0A=

------=_NextPart_000_0037_01C213FB.8DFC0CA0
Content-Type: text/plain;
	name="ChangeLog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ChangeLog.txt"
Content-length: 216

2002-06-14  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* path.cc (mount_info::conv_to_win32_path): Skip mount point and
	chroot checking for /proc entries and default them to binary mode:
	all as per /dev entries.

------=_NextPart_000_0037_01C213FB.8DFC0CA0--

