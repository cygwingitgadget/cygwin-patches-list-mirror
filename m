Return-Path: <cygwin-patches-return-4609-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2496 invoked by alias); 18 Mar 2004 03:23:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2486 invoked from network); 18 Mar 2004 03:23:12 -0000
Message-Id: <3.0.5.32.20040317222144.007f3890@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Thu, 18 Mar 2004 03:23:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch]: rmdir
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1079598104==_"
X-SW-Source: 2004-q1/txt/msg00099.txt.bz2

--=====================_1079598104==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 642

This is not a bug fix, just the reversion of a comment removal
following some recent tests on NT, plus some code simplification.

Here are the details:
- Until last Sunday, rmdir(".") didn't work.
- Now it works on 9x if the directory is empty. 
  "rmdir ." from a shell works there too.
- It also works on NT if the directory is empty AND no other process
  is using it as working directory. "rmdir ." doesn't work from a shell.
Following my initial experience on 9x, I had deleted some comments.
That was premature.

2004-03-17  Pierre Humblet <pierre.humblet@ieee.org>

	* dir.cc (rmdir): Reorganize error handling to reduce indentation. 

--=====================_1079598104==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="dir.cc.diff"
Content-length: 3798

Index: dir.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/dir.cc,v
retrieving revision 1.78
diff -u -p -r1.78 dir.cc
--- dir.cc	14 Mar 2004 16:16:45 -0000	1.78
+++ dir.cc	17 Mar 2004 02:10:24 -0000
@@ -328,6 +328,7 @@ rmdir (const char *dir)

       for (bool is_cwd =3D false; ; is_cwd =3D true)
         {
+	  DWORD err;
 	  int rc =3D RemoveDirectory (real_dir);
 	  DWORD att =3D GetFileAttributes (real_dir);

@@ -338,48 +339,51 @@ rmdir (const char *dir)
 	      /* RemoveDirectory on a samba drive doesn't return an error if the
 		 directory can't be removed because it's not empty. Checking for
 		 existence afterwards keeps us informed about success. */
-	      if (att !=3D INVALID_FILE_ATTRIBUTES)
-		set_errno (ENOTEMPTY);
-	      else
-		res =3D 0;
-	    }
-	  else
-	    {
-	      /* This kludge detects if we are attempting to remove the current w=
orking
-		 directory.  If so, we will move elsewhere to potentially allow the
-		 rmdir to succeed.  This means that cygwin's concept of the current work=
ing
-		 directory !=3D Windows concept but, hey, whaddaregonnado?
-		 FIXME: A potential workaround for this is for cygwin apps to *never* ca=
ll
-		 SetCurrentDirectory. */
-	      if (strcasematch (real_dir, cygheap->cwd.win32)
-		  && !strcasematch ("c:\\", cygheap->cwd.win32) && !is_cwd)
-	        {
-		  DWORD err =3D GetLastError ();
-		  if (!SetCurrentDirectory ("c:\\"))
-		    SetLastError (err);
-		  else
-		    continue;
-		}
-	      if (res)
+	      if (att =3D=3D INVALID_FILE_ATTRIBUTES)
 	        {
-		  if (GetLastError () !=3D ERROR_ACCESS_DENIED
-		      || !wincap.access_denied_on_delete ())
-		    __seterrno ();
-		  else
-		    set_errno (ENOTEMPTY);	/* On 9X ERROR_ACCESS_DENIED is
-						   returned if you try to remove a
-						   non-empty directory. */
-
-		  /* If directory still exists, restore R/O attribute. */
-		  if (real_dir.has_attribute (FILE_ATTRIBUTE_READONLY))
-		    SetFileAttributes (real_dir, real_dir);
-		  if (is_cwd)
-		    SetCurrentDirectory (cygheap->cwd.win32);
+		  res =3D 0;
+		  break;
 		}
+	      err =3D ERROR_DIR_NOT_EMPTY;
 	    }
+	  else
+	    err =3D GetLastError ();
+
+	  /* This kludge detects if we are attempting to remove the current worki=
ng
+	     directory.  If so, we will move elsewhere to potentially allow the
+	     rmdir to succeed.  This means that cygwin's concept of the current w=
orking
+	     directory !=3D Windows concept but, hey, whaddaregonnado?
+	     Note that this will not cause something like the following to work:
+		     $ cd foo
+		     $ rmdir .
+	     since the shell will have foo "open" in the above case and so Window=
s will
+	     not allow the deletion. (Actually it does on 9X.)
+	     FIXME: A potential workaround for this is for cygwin apps to *never*=
 call
+	     SetCurrentDirectory. */
+
+	  if (strcasematch (real_dir, cygheap->cwd.win32)
+	      && !strcasematch ("c:\\", cygheap->cwd.win32)
+	      && !is_cwd
+	      && SetCurrentDirectory ("c:\\"))
+	    continue;
+
+	  /* On 9X ERROR_ACCESS_DENIED is returned
+	     if you try to remove a non-empty directory. */
+	  if (err =3D=3D ERROR_ACCESS_DENIED
+	      && wincap.access_denied_on_delete ())
+	    err =3D ERROR_DIR_NOT_EMPTY;
+
+	  __seterrno_from_win_error (err);
+
+	  /* Directory still exists, restore its characteristics. */
+	  if (real_dir.has_attribute (FILE_ATTRIBUTE_READONLY))
+	    SetFileAttributes (real_dir, real_dir);
+	  if (is_cwd)
+	    SetCurrentDirectory (cygheap->cwd.win32);
 	  break;
 	}
     }
+
   syscall_printf ("%d =3D rmdir (%s)", res, dir);
   return res;
 }

--=====================_1079598104==_--
