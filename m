Return-Path: <cygwin-patches-return-2800-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 11462 invoked by alias); 8 Aug 2002 13:39:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11447 invoked from network); 8 Aug 2002 13:39:04 -0000
Message-ID: <3D527477.6040307@hekimian.com>
Date: Thu, 08 Aug 2002 06:39:00 -0000
X-Sybari-Trust: 5465ada6 b923d9bf 4738785c 00000109
From: Joe Buehler <jbuehler@hekimian.com>
Reply-To:  joseph.buehler@spirentcom.com
Organization: Spirent Communications
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.0.0) Gecko/20020530
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: patch for infinite loop in unlink()
Content-Type: multipart/mixed;
 boundary="------------010900030505000405090902"
X-SW-Source: 2002-q3/txt/msg00248.txt.bz2

This is a multi-part message in MIME format.
--------------010900030505000405090902
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 549

Here is a patch for the problem of "rm -fr" getting into an infinite loop
when it tries to delete a file that is open.

It is a little incomplete in that it depends on the existence of a directory
named .cygdel in the root directory of the involved drive, but does not
attempt to create the directory.  So some solution is needed for that.
The patch code has no effect if anything fails.

It has worked for me for some time now, but definitely needs to be
checked by someone who knows the guts of the code involved.

Please critique...

Joe Buehler

--------------010900030505000405090902
Content-Type: text/plain;
 name="temp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="temp.patch"
Content-length: 1019

Index: src/winsup/cygwin/syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.214
diff -u -r1.214 syscalls.cc
--- src/winsup/cygwin/syscalls.cc	2 Jul 2002 03:06:32 -0000	1.214
+++ src/winsup/cygwin/syscalls.cc	8 Aug 2002 13:31:35 -0000
@@ -142,6 +142,23 @@
 	SetFileAttributes (win32_name, (DWORD) win32_name & ~FILE_ATTRIBUTE_READONLY);
     }
 
+  // attempt to rename before deleting
+  char *basename;
+  basename = strrchr(win32_name, '\\');
+  if (basename && *++basename) {
+    const char *rootdir = win32_name.root_dir();
+    if (rootdir) {
+      const char *s = strrchr(rootdir, '\\');
+      if (s && !s[1]) {
+	char newname[MAX_PATH + 12];
+	__small_sprintf(newname, "%s.cygdel\\%s", rootdir, basename);
+	if (MoveFile(win32_name.get_win32(), newname)) {
+	  win32_name.check(newname, PC_SYM_NOFOLLOW | PC_FULL);
+	}
+      }
+    }
+  }
+
   DWORD lasterr;
   lasterr = 0;
   for (int i = 0; i < 2; i++)

--------------010900030505000405090902--
