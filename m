From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygwin-patches@cygwin.com
Subject: `ls A:/foo' can succeed incorrectly.
Date: Thu, 05 Apr 2001 12:36:00 -0000
Message-id: <s1sn19vqgtv.fsf@jaist.ac.jp>
X-SW-Source: 2001-q2/msg00008.html

`ls A:/foo' can succeed even when the floppy drive has no medium
on Windows NT/2000.

2001-04-06  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>

	* syscalls.cc (stat_worker): Return error if it fails in the case
	specific to NT.

Index: syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.100
diff -u -p -r1.100 syscalls.cc
--- syscalls.cc	2001/04/03 02:53:24	1.100
+++ syscalls.cc	2001/04/05 19:29:00
@@ -1081,8 +1081,8 @@ stat_worker (const char *caller, const c
 	    buf->st_nlink = (dtype == DRIVE_REMOTE
 			     ? 1
 			     : num_entries (real_path.get_win32 ()));
-	  goto done;
 	}
+      goto done;
     }
   if (atts != -1 || (!oret && get_errno () != ENOENT
 			   && get_errno () != ENOSHARE))

____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
