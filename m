Return-Path: <cygwin-patches-return-4606-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18827 invoked by alias); 14 Mar 2004 15:47:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18817 invoked from network); 14 Mar 2004 15:47:25 -0000
Message-Id: <3.0.5.32.20040314104606.00800590@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sun, 14 Mar 2004 15:47:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch]: rmdir
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1079297166==_"
X-SW-Source: 2004-q1/txt/msg00096.txt.bz2

--=====================_1079297166==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 179


2004-03-14  Pierre Humblet <pierre.humblet@ieee.org>

	* dir.cc (rmdir): Construct real_dir with flag PC_FULL.
	Use a loop instead of recursion to handle the current directory.


--=====================_1079297166==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="dir.cc.diff"
Content-length: 4707

Index: dir.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/dir.cc,v
retrieving revision 1.77
diff -u -p -r1.77 dir.cc
--- dir.cc	26 Nov 2003 13:23:27 -0000	1.77
+++ dir.cc	14 Mar 2004 15:42:29 -0000
@@ -308,7 +308,7 @@ rmdir (const char *dir)
   int res =3D -1;
   DWORD devn;

-  path_conv real_dir (dir, PC_SYM_NOFOLLOW);
+  path_conv real_dir (dir, PC_SYM_NOFOLLOW | PC_FULL);

   if (real_dir.error)
     set_errno (real_dir.error);
@@ -326,60 +326,60 @@ rmdir (const char *dir)
 	SetFileAttributes (real_dir,
 			   (DWORD) real_dir & ~FILE_ATTRIBUTE_READONLY);

-      int rc =3D RemoveDirectory (real_dir);
-      DWORD att =3D GetFileAttributes (real_dir);
+      for (bool is_cwd =3D false; ; is_cwd =3D true)
+        {
+	  int rc =3D RemoveDirectory (real_dir);
+	  DWORD att =3D GetFileAttributes (real_dir);

-      /* Sometimes smb indicates failure when it really succeeds, so check=
 for
-	 this case specifically. */
-      if (rc || att =3D=3D INVALID_FILE_ATTRIBUTES)
-	{
-	  /* RemoveDirectory on a samba drive doesn't return an error if the
-	     directory can't be removed because it's not empty. Checking for
-	     existence afterwards keeps us informed about success. */
-	  if (att !=3D INVALID_FILE_ATTRIBUTES)
-	    set_errno (ENOTEMPTY);
-	  else
-	    res =3D 0;
-	}
-      else
-	{
-	  /* This kludge detects if we are attempting to remove the current worki=
ng
-	     directory.  If so, we will move elsewhere to potentially allow the
-	     rmdir to succeed.  This means that cygwin's concept of the current w=
orking
-	     directory !=3D Windows concept but, hey, whaddaregonnado?
-	     Note that this will not cause something like the following to work:
-		     $ cd foo
-		     $ rmdir .
-	     since the shell will have foo "open" in the above case and so Window=
s will
-	     not allow the deletion.
-	     FIXME: A potential workaround for this is for cygwin apps to *never*=
 call
-	     SetCurrentDirectory. */
-	  if (strcasematch (real_dir, cygheap->cwd.win32)
-	      && !strcasematch ("c:\\", cygheap->cwd.win32))
+	  /* Sometimes smb indicates failure when it really succeeds, so check for
+	     this case specifically. */
+	  if (rc || att =3D=3D INVALID_FILE_ATTRIBUTES)
 	    {
-	      DWORD err =3D GetLastError ();
-	      if (!SetCurrentDirectory ("c:\\"))
-		SetLastError (err);
-	      else if ((res =3D rmdir (dir)))
-		SetCurrentDirectory (cygheap->cwd.win32);
+	      /* RemoveDirectory on a samba drive doesn't return an error if the
+		 directory can't be removed because it's not empty. Checking for
+		 existence afterwards keeps us informed about success. */
+	      if (att !=3D INVALID_FILE_ATTRIBUTES)
+		set_errno (ENOTEMPTY);
+	      else
+		res =3D 0;
 	    }
-	  if (res)
+	  else
 	    {
-	      if (GetLastError () !=3D ERROR_ACCESS_DENIED
-		  || !wincap.access_denied_on_delete ())
-		__seterrno ();
-	      else
-		set_errno (ENOTEMPTY);	/* On 9X ERROR_ACCESS_DENIED is
-					       returned if you try to remove a
-					       non-empty directory. */
+	      /* This kludge detects if we are attempting to remove the current w=
orking
+		 directory.  If so, we will move elsewhere to potentially allow the
+		 rmdir to succeed.  This means that cygwin's concept of the current work=
ing
+		 directory !=3D Windows concept but, hey, whaddaregonnado?
+		 FIXME: A potential workaround for this is for cygwin apps to *never* ca=
ll
+		 SetCurrentDirectory. */
+	      if (strcasematch (real_dir, cygheap->cwd.win32)
+		  && !strcasematch ("c:\\", cygheap->cwd.win32) && !is_cwd)
+	        {
+		  DWORD err =3D GetLastError ();
+		  if (!SetCurrentDirectory ("c:\\"))
+		    SetLastError (err);
+		  else
+		    continue;
+		}
+	      if (res)
+	        {
+		  if (GetLastError () !=3D ERROR_ACCESS_DENIED
+		      || !wincap.access_denied_on_delete ())
+		    __seterrno ();
+		  else
+		    set_errno (ENOTEMPTY);	/* On 9X ERROR_ACCESS_DENIED is
+						   returned if you try to remove a
+						   non-empty directory. */

-	      /* If directory still exists, restore R/O attribute. */
-	      if (real_dir.has_attribute (FILE_ATTRIBUTE_READONLY))
-		SetFileAttributes (real_dir, real_dir);
+		  /* If directory still exists, restore R/O attribute. */
+		  if (real_dir.has_attribute (FILE_ATTRIBUTE_READONLY))
+		    SetFileAttributes (real_dir, real_dir);
+		  if (is_cwd)
+		    SetCurrentDirectory (cygheap->cwd.win32);
+		}
 	    }
+	  break;
 	}
     }
-
   syscall_printf ("%d =3D rmdir (%s)", res, dir);
   return res;
 }

--=====================_1079297166==_--
