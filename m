Return-Path: <cygwin-patches-return-5007-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5696 invoked by alias); 5 Oct 2004 02:21:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5664 invoked from network); 5 Oct 2004 02:21:12 -0000
Message-Id: <3.0.5.32.20041004221645.0081f420@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Tue, 05 Oct 2004 02:21:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch] has_security
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q4/txt/msg00008.txt.bz2

Another cleanup, following the changes in environ.cc.

Pierre

2004-10-05  Pierre Humblet <pierre.humblet@ieee.org>

	* external.cc (check_ntsec): Do not call wincap.has_security.
	* path.cc (path_conv::check): Ditto.
	* security.cc (get_object_attribute): Ditto.
	(get_file_attribute): Ditto.



Index: external.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/external.cc,v
retrieving revision 1.66
diff -u -p -r1.66 external.cc
--- external.cc 28 May 2004 19:50:05 -0000      1.66
+++ external.cc 5 Oct 2004 01:58:33 -0000
@@ -125,9 +125,9 @@ static DWORD
 check_ntsec (const char *filename)
 {
   if (!filename)
-    return wincap.has_security () && allow_ntsec;
+    return allow_ntsec;
   path_conv pc (filename);
-  return wincap.has_security () && allow_ntsec && pc.has_acls ();
+  return allow_ntsec && pc.has_acls ();
 }
 
 extern "C" unsigned long
Index: security.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/security.cc,v
retrieving revision 1.176
diff -u -p -r1.176 security.cc
--- security.cc 12 Sep 2004 03:47:57 -0000      1.176
+++ security.cc 5 Oct 2004 01:58:36 -0000
@@ -1382,7 +1382,7 @@ int
 get_object_attribute (HANDLE handle, SE_OBJECT_TYPE object_type,
                      mode_t *attribute, __uid32_t *uidret, __gid32_t *gidret)
 {
-  if (allow_ntsec && wincap.has_security ())
+  if (allow_ntsec)
     {
       get_nt_object_attribute (handle, object_type, attribute, uidret,
gidret);
       return 0;
@@ -1398,7 +1398,7 @@ get_file_attribute (int use_ntsec, HANDL
   int res;
   syscall_printf ("file: %s", file);
 
-  if (use_ntsec && allow_ntsec && wincap.has_security ())
+  if (use_ntsec && allow_ntsec)
     {
       if (!handle || get_nt_object_attribute (handle, SE_FILE_OBJECT,
                                              attribute, uidret, gidret))
Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.323
diff -u -p -r1.323 path.cc
--- path.cc     2 Oct 2004 02:20:20 -0000       1.323
+++ path.cc     5 Oct 2004 01:58:42 -0000
@@ -840,8 +840,8 @@ out:
       if (fs.update (path))
        {
          debug_printf ("this->path(%s), has_acls(%d)", path, fs.has_acls ());
-         if (fs.has_acls () && allow_ntsec && wincap.has_security ())
+         if (fs.has_acls () && allow_ntsec)
            set_exec (0);  /* We really don't know if this is executable or
not here
                              but set it to not executable since it will be
figured out
                              later by anything which cares about this. */
