Return-Path: <cygwin-patches-return-3922-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9499 invoked by alias); 4 Jun 2003 01:21:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9464 invoked from network); 4 Jun 2003 01:21:52 -0000
Message-Id: <3.0.5.32.20030603212215.007fe100@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com (Unverified)
Date: Wed, 04 Jun 2003 01:21:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: stat weird feature
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1054704135==_"
X-SW-Source: 2003-q2/txt/msg00149.txt.bz2

--=====================_1054704135==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 431

Here is the patch discussed today on the developers' list.
I have also moved a comment that had drifted out of its 
natural spot.

Pierre

2003-06-04  Pierre Humblet  <pierre.humblet@ieee.org>

	* fhandler_disk_file.cc (fhandler_disk_file::fstat): Mark the pc
	as non-executable if the file cannot be opened for read. Retry query 
	open only if errno is EACCES. Never change the mode, even if it is 000 
	when query open() fails. 

--=====================_1054704135==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="fhandler_disk_file.diff"
Content-length: 3397

Index: fhandler_disk_file.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler_disk_file.cc,v
retrieving revision 1.54
diff -u -p -r1.54 fhandler_disk_file.cc
--- fhandler_disk_file.cc	1 Jun 2003 19:37:13 -0000	1.54
+++ fhandler_disk_file.cc	4 Jun 2003 00:54:25 -0000
@@ -137,8 +137,6 @@ fhandler_disk_file::fstat (struct __stat
 {
   int res =3D -1;
   int oret;
-  __uid32_t uid;
-  __gid32_t gid;
   int open_flags =3D O_RDONLY | O_BINARY | O_DIROPEN;
   bool query_open_already;

@@ -159,27 +157,15 @@ fhandler_disk_file::fstat (struct __stat
   if (query_open_already && strncasematch (pc->volname (), "FAT", 3)
       && !strpbrk (get_win32_name (), "?*|<>"))
     oret =3D 0;
-  else if (!(oret =3D open (pc, open_flags, 0)))
+  else if (!(oret =3D open (pc, open_flags, 0))
+	   && !query_open_already
+	   && get_errno () =3D=3D EACCES)
     {
-      mode_t ntsec_atts =3D 0;
       /* If we couldn't open the file, try a "query open" with no permissi=
ons.
 	 This will allow us to determine *some* things about the file, at least. =
*/
+      pc->set_exec (0);
       set_query_open (true);
-      if (!query_open_already && (oret =3D open (pc, open_flags, 0)))
-	/* ok */;
-      else if (allow_ntsec && pc->has_acls () && get_errno () =3D=3D EACCES
-		&& !get_file_attribute (TRUE, get_win32_name (), &ntsec_atts, &uid, &gid)
-		&& !ntsec_atts && uid =3D=3D myself->uid && gid =3D=3D myself->gid)
-	{
-	  /* Check a special case here. If ntsec is ON it happens
-	     that a process creates a file using mode 000 to disallow
-	     other processes access. In contrast to UNIX, this results
-	     in a failing open call in the same process. Check that
-	     case. */
-	  set_file_attribute (TRUE, get_win32_name (), 0400);
-	  oret =3D open (pc, open_flags, 0);
-	  set_file_attribute (TRUE, get_win32_name (), ntsec_atts);
-	}
+      oret =3D open (pc, open_flags, 0);
     }

   if (!oret || get_nohandle ())
@@ -217,7 +203,11 @@ fhandler_disk_file::fstat_helper (struct
   to_timestruc_t (&ftCreationTime, &buf->st_ctim);
   buf->st_dev =3D pc->volser ();
   buf->st_size =3D ((_off64_t)nFileSizeHigh << 32) + nFileSizeLow;
-  /* Unfortunately the count of 2 confuses `find (1)' command. So
+  /* The number of links to a directory includes the
+     number of subdirectories in the directory, since all
+     those subdirectories point to it.
+     This is too slow on remote drives, so we do without it.
+     Setting the count to 2 confuses `find (1)' command. So
      let's try it with `1' as link count. */
   if (pc->isdir () && !pc->isremote () && nNumberOfLinks =3D=3D 1)
     buf->st_nlink =3D num_entries (pc->get_win32 ());
@@ -336,11 +326,6 @@ fhandler_disk_file::fstat_helper (struct
       buf->st_mode &=3D ~(cygheap->umask);
     }

-  /* The number of links to a directory includes the
-     number of subdirectories in the directory, since all
-     those subdirectories point to it.
-     This is too slow on remote drives, so we do without it and
-     set the number of links to 2. */
  done:
   syscall_printf ("0 =3D fstat (, %p) st_atime=3D%x st_size=3D%D, st_mode=
=3D%p, st_ino=3D%d, sizeof=3D%d",
 		  buf, buf->st_atime, buf->st_size, buf->st_mode,

--=====================_1054704135==_--
