Return-Path: <cygwin-patches-return-3773-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23984 invoked by alias); 1 Apr 2003 02:27:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23972 invoked from network); 1 Apr 2003 02:26:59 -0000
Message-Id: <3.0.5.32.20030331212603.007ffb50@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com (Unverified)
Date: Tue, 01 Apr 2003 02:27:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Two minor fstat issues
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q2/txt/msg00000.txt.bz2

This patch fixes two minor fstat issues:
- The uid and gid are not set in fhandler_base, causing several handlers
  to return invalid (0) values.
- Tests for wincap.has_security in security.cc can cause some functions to
  return success without providing the expected information.

Pierre
 

2003-04-01  Pierre Humblet  <pierre.humblet@ieee.org>
	
	* fhandler.cc (fhandler_base::fstat): Set the uid and gid fields
	from the current effective ids.
	* fhandler_socket.cc (fhandler_socket::fstat): Keep the uid and gid set
	by fhandler_base::fstat.
	* security.cc (get_nt_attribute): Do not test wincap.has_security ().
	(get_nt_object_attribute): Ditto.
	(get_file_attribute): Add test for wincap.has_security ().
	(get_object_attribute): Ditto.


Index: fhandler.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
retrieving revision 1.144
diff -u -p -r1.144 fhandler.cc
--- fhandler.cc 21 Feb 2003 04:33:53 -0000      1.144
+++ fhandler.cc 1 Apr 2003 00:46:03 -0000
@@ -981,6 +981,8 @@ fhandler_base::fstat (struct __stat64 *b
       break;
     }
 
+  buf->st_uid = geteuid32 ();
+  buf->st_gid = getegid32 ();
   buf->st_nlink = 1;
   buf->st_blksize = S_BLKSIZE;
   time_as_timestruc_t (&buf->st_ctim);
Index: fhandler_socket.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_socket.cc,v
retrieving revision 1.89
diff -u -p -r1.89 fhandler_socket.cc
--- fhandler_socket.cc  20 Mar 2003 08:53:28 -0000      1.89
+++ fhandler_socket.cc  1 Apr 2003 00:47:01 -0000
@@ -444,8 +444,6 @@ fhandler_socket::fstat (struct __stat64 
          buf->st_dev = 0;
          buf->st_ino = (ino_t) get_handle ();
          buf->st_mode = S_IFSOCK | S_IRWXU | S_IRWXG | S_IRWXO;
-         buf->st_uid = geteuid32 ();
-         buf->st_gid = getegid32 ();
        }
       else
        {
Index: security.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/security.cc,v
retrieving revision 1.142
diff -u -p -r1.142 security.cc
--- security.cc 27 Mar 2003 09:40:25 -0000      1.142
+++ security.cc 1 Apr 2003 00:48:18 -0000
@@ -1322,9 +1322,6 @@ static int
 get_nt_attribute (const char *file, mode_t *attribute,
                  __uid32_t *uidret, __gid32_t *gidret)
 {
-  if (!wincap.has_security ())
-    return 0;
-
   syscall_printf ("file: %s", file);
 
   /* Yeah, sounds too much, but I've seen SDs of 2100 bytes! */
@@ -1391,7 +1388,7 @@ get_file_attribute (int use_ntsec, const
 {
   int res;
 
-  if (use_ntsec && allow_ntsec)
+  if (use_ntsec && allow_ntsec && wincap.has_security ())
     {
       res = get_nt_attribute (file, attribute, uidret, gidret);
       if (res)
@@ -1437,9 +1434,6 @@ static int
 get_nt_object_attribute (HANDLE handle, SE_OBJECT_TYPE object_type,
                         mode_t *attribute, __uid32_t *uidret, __gid32_t
*gidret)
 {
-  if (!wincap.has_security ())
-    return 0;
-
   PSECURITY_DESCRIPTOR psd = NULL;
   cygpsid owner_sid;
   cygpsid group_sid;
@@ -1548,7 +1542,7 @@ int
 get_object_attribute (HANDLE handle, SE_OBJECT_TYPE object_type,
                      mode_t *attribute, __uid32_t *uidret, __gid32_t *gidret)
 {
-  if (allow_ntsec)
+  if (allow_ntsec && wincap.has_security ())
     {
       int res = get_nt_object_attribute (handle, object_type, attribute,
                                         uidret, gidret);

