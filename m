Return-Path: <cygwin-patches-return-4999-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31828 invoked by alias); 2 Oct 2004 00:46:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31812 invoked from network); 2 Oct 2004 00:46:33 -0000
Message-Id: <3.0.5.32.20041001204157.0081c100@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sat, 02 Oct 2004 00:46:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch]: PATH_ISDISK
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q4/txt/msg00000.txt.bz2

As discussed earlier today.

Note that if GetVolumeInformation fails, has_acls won't get set
and cygwin will work as if ntsec was off... 
Not sure how to avoid that, reliably.

Pierre

2004-10-02  Pierre Humblet <pierre.humblet@ieee.org>

	* path.h (enum path_types): Delete PATH_ISDISK.
	(path_conv::isdisk): Delete method.
	(path_conv::set_isdisk): Ditto.
	* path.cc (path_conv::check): Do not call set_isdisk.
	* uinfo.cc(pwdgrp::load): Do not call pc.isdisk. 


Index: path.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.h,v
retrieving revision 1.66
diff -u -p -r1.66 path.h
--- path.h      17 Jun 2004 13:34:24 -0000      1.66
+++ path.h      2 Oct 2004 00:28:49 -0000
@@ -64,7 +64,6 @@ enum path_types
   PATH_ALL_EXEC = (PATH_CYGWIN_EXEC | PATH_EXEC),
   PATH_LNK =         0x01000000,
   PATH_TEXT =        0x02000000,
-  PATH_ISDISK =              0x04000000,
   PATH_HAS_SYMLINKS = 0x10000000,
   PATH_SOCKET =       0x40000000
 };
@@ -123,7 +122,6 @@ class path_conv
   device dev;
   bool case_clash;
 
-  int isdisk () const { return path_flags & PATH_ISDISK;}
   bool isremote () {return fs.is_remote_drive ();}
   int has_acls () const {return fs.has_acls (); }
   int has_symlinks () const {return path_flags & PATH_HAS_SYMLINKS;}
@@ -165,7 +163,6 @@ class path_conv
   void set_binary () {path_flags |= PATH_BINARY;}
   void set_symlink (DWORD n) {path_flags |= PATH_SYMLINK; symlink_length =
n;}
   void set_has_symlinks () {path_flags |= PATH_HAS_SYMLINKS;}
-  void set_isdisk () {path_flags |= PATH_ISDISK; dev.devn = FH_FS;}
   void set_exec (int x = 1) {path_flags |= x ? PATH_EXEC : PATH_NOTEXEC;}
 
   void check (const char *src, unsigned opt = PC_SYM_FOLLOW,
Index: uinfo.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/uinfo.cc,v
retrieving revision 1.129
diff -u -p -r1.129 uinfo.cc
--- uinfo.cc    3 Sep 2004 01:53:12 -0000       1.129
+++ uinfo.cc    2 Oct 2004 00:28:50 -0000
@@ -511,7 +511,7 @@ pwdgrp::load (const char *posix_fname)
 
   paranoid_printf ("%s", posix_fname);
 
-  if (pc.error || !pc.exists () || !pc.isdisk () || pc.isdir ())
+  if (pc.error || !pc.exists () || pc.isdir ())
     {
       paranoid_printf ("strange path_conv problem");
       res = failed;
Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.322
diff -u -p -r1.322 path.cc
--- path.cc     24 Sep 2004 19:41:19 -0000      1.322
+++ path.cc     2 Oct 2004 00:29:11 -0000
@@ -839,7 +839,6 @@ out:
     {
       if (fs.update (path))
        {
-         set_isdisk ();
          debug_printf ("this->path(%s), has_acls(%d)", path, fs.has_acls ());
          if (fs.has_acls () && allow_ntsec && wincap.has_security ())
            set_exec (0);  /* We really don't know if this is executable or
not here
