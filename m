Return-Path: <cygwin-patches-return-4341-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6929 invoked by alias); 6 Nov 2003 13:29:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6919 invoked from network); 6 Nov 2003 13:29:25 -0000
Message-ID: <20031106132923.37170.qmail@web13801.mail.yahoo.com>
Date: Thu, 06 Nov 2003 13:29:00 -0000
From: =?iso-8859-1?q?Ian=20Ray?= <ran_iay@yahoo.com>
Subject: Re: [Patch] fhandler_disk_file::opendir memory leak
To: cygwin-patches@cygwin.com
In-Reply-To: <20031106131507.64464.qmail@web13808.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-842784298-1068125363=:36655"
Content-Transfer-Encoding: 8bit
X-SW-Source: 2003-q4/txt/msg00060.txt.bz2

--0-842784298-1068125363=:36655
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline
Content-length: 208

Oops. Typo. Retry.



________________________________________________________________________
Want to chat instantly with your online friends?  Get the FREE Yahoo!
Messenger http://mail.messenger.yahoo.co.uk
--0-842784298-1068125363=:36655
Content-Type: text/plain; name="fhandler_disk_file.changelog"
Content-Description: fhandler_disk_file.changelog
Content-Disposition: inline; filename="fhandler_disk_file.changelog"
Content-length: 127

2003-11-06  Ian Ray  <ran_iay@yahoo.com>

	* fhandler_disk_file.cc (fhandler_disk_file::opendir): Guard against
	memory leak.


--0-842784298-1068125363=:36655
Content-Type: text/plain; name="fhandler_disk_file.patch"
Content-Description: fhandler_disk_file.patch
Content-Disposition: inline; filename="fhandler_disk_file.patch"
Content-length: 1706

--- fhandler_disk_file.1.67	2003-11-06 14:48:48.959065000 +0200
+++ fhandler_disk_file.cc	2003-11-06 15:28:21.081920000 +0200
@@ -605,7 +605,7 @@ fhandler_disk_file::lock (int cmd, struc
 DIR *
 fhandler_disk_file::opendir ()
 {
-  DIR *dir;
+  DIR *dir = NULL;
   DIR *res = NULL;
   size_t len;
 
@@ -613,26 +613,14 @@ fhandler_disk_file::opendir ()
     set_errno (ENOTDIR);
   else if ((len = strlen (pc))> MAX_PATH - 3)
     set_errno (ENAMETOOLONG);
-  else if ((dir = (DIR *) malloc (sizeof (DIR))) == NULL)
+  else if ((dir = (DIR *) calloc (1, sizeof (DIR))) == NULL)
     set_errno (ENOMEM);
   else if ((dir->__d_dirname = (char *) malloc (len + 3)) == NULL)
-    {
-      set_errno (ENOMEM);
-      free (dir);
-    }
+    set_errno (ENOMEM);
   else if ((dir->__d_dirent =
 	    (struct dirent *) malloc (sizeof (struct dirent))) == NULL)
-    {
-      set_errno (ENOMEM);
-      free (dir);
-      free (dir->__d_dirname);
-    }
-  else if (access_worker (pc, R_OK) != 0)
-    {
-      free (dir);
-      free (dir->__d_dirname);
-    }
-  else
+    set_errno (ENOMEM);
+  else if (access_worker (pc, R_OK) == 0)
     {
       strcpy (dir->__d_dirname, get_win32_name ());
       dir->__d_dirent->d_version = __DIRENT_VERSION;
@@ -655,11 +643,21 @@ fhandler_disk_file::opendir ()
 	  dir->__d_dirhash = get_namehash ();
 
 	  res = dir;
+          dir = NULL;
 	}
       if (pc.isencoded ())
 	set_encoded ();
     }
 
+  if (dir != NULL)
+    {
+      if (dir->__d_dirname != NULL)
+        free (dir->__d_dirname);
+      if (dir->__d_dirent != NULL)
+        free (dir->__d_dirent);
+      free (dir);
+    }
+
   syscall_printf ("%p = opendir (%s)", res, get_name ());
   return res;
 }

--0-842784298-1068125363=:36655--
