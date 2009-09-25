Return-Path: <cygwin-patches-return-6636-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25390 invoked by alias); 25 Sep 2009 03:35:23 -0000
Received: (qmail 25378 invoked by uid 22791); 25 Sep 2009 03:35:22 -0000
X-SWARE-Spam-Status: No, hits=-1.2 required=5.0 	tests=AWL,BAYES_00,J_CHICKENPOX_29,J_CHICKENPOX_82,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta03.emeryville.ca.mail.comcast.net (HELO QMTA03.emeryville.ca.mail.comcast.net) (76.96.30.32)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 25 Sep 2009 03:35:12 +0000
Received: from OMTA16.emeryville.ca.mail.comcast.net ([76.96.30.72]) 	by QMTA03.emeryville.ca.mail.comcast.net with comcast 	id kram1c0081ZMdJ4A3rbCDY; Fri, 25 Sep 2009 03:35:12 +0000
Received: from [192.168.0.101] ([24.10.247.15]) 	by OMTA16.emeryville.ca.mail.comcast.net with comcast 	id krhj1c0020Lg2Gw8crhkfN; Fri, 25 Sep 2009 03:41:45 +0000
Message-ID: <4ABC3A64.1030609@byu.net>
Date: Fri, 25 Sep 2009 03:35:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [1.7] bugs in faccessat
References: <loom.20090903T175736-252@post.gmane.org>
In-Reply-To: <loom.20090903T175736-252@post.gmane.org>
Content-Type: multipart/mixed;  boundary="------------070009000401060508080606"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q3/txt/msg00090.txt.bz2

This is a multi-part message in MIME format.
--------------070009000401060508080606
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 1363

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Eric Blake on 9/3/2009 9:58 AM:
> Second, it is not performing the proper checks when AT_EACCESS is set and the 
> applications' effective id differs from the real id (to fix this would require 
> adding a parameter to fhandler_base::fhaccess).

Actually, faccessat(,AT_EACCESS) was right, but access() and faccessat(,0)
were doing the wrong thing (using effective id instead of real id when
doing the permission check).  I think I got it all right, but please
double-check me.

2009-09-24  Eric Blake  <ebb9@byu.net>

	* fhandler.h (fhandler_base::fhaccess): Add parameter.
	* security.h (check_file_access, check_registry_access): Likewise.
	* security.cc (check_file_access, check_registry_access)
	(check_access): Implement new parameter.
	* fhandler.cc (fhandler_base::fhaccess): Likewise.
	(device_access_denied): Update caller.
	* syscalls.cc (access, faccessat): Update callers.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkq8OmQACgkQ84KuGfSFAYD5ggCglYCjeUDkJF30Bn455/MoEkrn
ynkAn29rXYxx0RV47hEXpAqkVoFijiz2
=mWIO
-----END PGP SIGNATURE-----

--------------070009000401060508080606
Content-Type: text/plain;
 name="cygwin.patch22"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin.patch22"
Content-length: 6769

diff --git a/winsup/cygwin/fhandler.cc b/winsup/cygwin/fhandler.cc
index 44311ca..7a7d801 100644
--- a/winsup/cygwin/fhandler.cc
+++ b/winsup/cygwin/fhandler.cc
@@ -344,11 +344,11 @@ fhandler_base::device_access_denied (int flags)
   if (!mode)
     mode |= R_OK;

-  return fhaccess (mode);
+  return fhaccess (mode, true);
 }

 int
-fhandler_base::fhaccess (int flags)
+fhandler_base::fhaccess (int flags, bool effective)
 {
   int res = -1;
   if (error ())
@@ -373,12 +373,12 @@ fhandler_base::fhaccess (int flags)
     goto eaccess_done;
   else if (has_acls ())
     {
-      res = check_file_access (pc, flags);
+      res = check_file_access (pc, flags, effective);
       goto done;
     }
   else if (get_device () == FH_REGISTRY && open (O_RDONLY, 0) && get_handle ())
     {
-      res = check_registry_access (get_handle (), flags);
+      res = check_registry_access (get_handle (), flags, effective);
       close ();
       return res;
     }
@@ -389,12 +389,12 @@ fhandler_base::fhaccess (int flags)

   if (flags & R_OK)
     {
-      if (st.st_uid == myself->uid)
+      if (st.st_uid == (effective ? myself->uid : cygheap->user.real_uid))
 	{
 	  if (!(st.st_mode & S_IRUSR))
 	    goto eaccess_done;
 	}
-      else if (st.st_gid == myself->gid)
+      else if (st.st_gid == (effective ? myself->gid : cygheap->user.real_gid))
 	{
 	  if (!(st.st_mode & S_IRGRP))
 	    goto eaccess_done;
@@ -405,12 +405,12 @@ fhandler_base::fhaccess (int flags)

   if (flags & W_OK)
     {
-      if (st.st_uid == myself->uid)
+      if (st.st_uid == (effective ? myself->uid : cygheap->user.real_uid))
 	{
 	  if (!(st.st_mode & S_IWUSR))
 	    goto eaccess_done;
 	}
-      else if (st.st_gid == myself->gid)
+      else if (st.st_gid == (effective ? myself->gid : cygheap->user.real_gid))
 	{
 	  if (!(st.st_mode & S_IWGRP))
 	    goto eaccess_done;
@@ -421,12 +421,12 @@ fhandler_base::fhaccess (int flags)

   if (flags & X_OK)
     {
-      if (st.st_uid == myself->uid)
+      if (st.st_uid == (effective ? myself->uid : cygheap->user.real_uid))
 	{
 	  if (!(st.st_mode & S_IXUSR))
 	    goto eaccess_done;
 	}
-      else if (st.st_gid == myself->gid)
+      else if (st.st_gid == (effective ? myself->gid : cygheap->user.real_gid))
 	{
 	  if (!(st.st_mode & S_IXGRP))
 	    goto eaccess_done;
diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 1544cc6..dd9b591 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -392,7 +392,7 @@ class fhandler_base
   bool is_fs_special () {return pc.is_fs_special ();}
   bool issymlink () {return pc.issymlink ();}
   bool device_access_denied (int) __attribute__ ((regparm (2)));
-  int fhaccess (int flags) __attribute__ ((regparm (2)));
+  int fhaccess (int flags, bool) __attribute__ ((regparm (3)));
 };

 class fhandler_mailslot : public fhandler_base
diff --git a/winsup/cygwin/security.cc b/winsup/cygwin/security.cc
index 00a8c32..8c67fc9 100644
--- a/winsup/cygwin/security.cc
+++ b/winsup/cygwin/security.cc
@@ -1,7 +1,7 @@
 /* security.cc: NT file access control functions

    Copyright 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005,
-   2006, 2007 Red Hat, Inc.
+   2006, 2007, 2009 Red Hat, Inc.

    Originaly written by Gunther Ebert, gunther.ebert@ixos-leipzig.de
    Completely rewritten by Corinna Vinschen <corinna@vinschen.de>
@@ -725,15 +725,16 @@ set_file_attribute (HANDLE handle, path_conv &pc,

 static int
 check_access (security_descriptor &sd, GENERIC_MAPPING &mapping,
-	      DWORD desired, int flags)
+	      DWORD desired, int flags, bool effective)
 {
   int ret = -1;
   BOOL status;
   DWORD granted;
   DWORD plen = sizeof (PRIVILEGE_SET) + 3 * sizeof (LUID_AND_ATTRIBUTES);
   PPRIVILEGE_SET pset = (PPRIVILEGE_SET) alloca (plen);
-  HANDLE tok = cygheap->user.issetuid () ? cygheap->user.imp_token ()
-					 : hProcImpToken;
+  HANDLE tok = ((cygheap->user.issetuid () && effective)
+		? cygheap->user.imp_token ()
+		: hProcImpToken);

   if (!tok && !DuplicateTokenEx (hProcToken, MAXIMUM_ALLOWED, NULL,
 				 SecurityImpersonation, TokenImpersonation,
@@ -794,7 +795,7 @@ check_access (security_descriptor &sd, GENERIC_MAPPING &mapping,
 }

 int
-check_file_access (path_conv &pc, int flags)
+check_file_access (path_conv &pc, int flags, bool effective)
 {
   security_descriptor sd;
   int ret = -1;
@@ -810,13 +811,13 @@ check_file_access (path_conv &pc, int flags)
   if (flags & X_OK)
     desired |= FILE_EXECUTE;
   if (!get_file_sd (NULL, pc, sd))
-    ret = check_access (sd, mapping, desired, flags);
+    ret = check_access (sd, mapping, desired, flags, effective);
   debug_printf ("flags %x, ret %d", flags, ret);
   return ret;
 }

 int
-check_registry_access (HANDLE hdl, int flags)
+check_registry_access (HANDLE hdl, int flags, bool effective)
 {
   security_descriptor sd;
   int ret = -1;
@@ -832,7 +833,7 @@ check_registry_access (HANDLE hdl, int flags)
   if (flags & X_OK)
     desired |= KEY_QUERY_VALUE;
   if (!get_reg_sd (hdl, sd))
-    ret = check_access (sd, mapping, desired, flags);
+    ret = check_access (sd, mapping, desired, flags, effective);
   /* As long as we can't write the registry... */
   if (flags & W_OK)
     {
diff --git a/winsup/cygwin/security.h b/winsup/cygwin/security.h
index 7b09bc0..be0ebd4 100644
--- a/winsup/cygwin/security.h
+++ b/winsup/cygwin/security.h
@@ -350,8 +350,8 @@ LONG __stdcall set_file_sd (HANDLE fh, path_conv &, security_descriptor &sd,
 			    bool is_chown);
 bool __stdcall add_access_allowed_ace (PACL acl, int offset, DWORD attributes, PSID sid, size_t &len_add, DWORD inherit);
 bool __stdcall add_access_denied_ace (PACL acl, int offset, DWORD attributes, PSID sid, size_t &len_add, DWORD inherit);
-int __stdcall check_file_access (path_conv &, int);
-int __stdcall check_registry_access (HANDLE, int);
+int __stdcall check_file_access (path_conv &, int, bool effective = true);
+int __stdcall check_registry_access (HANDLE, int, bool effective = true);

 void set_security_attribute (path_conv &pc, int attribute,
 			     PSECURITY_ATTRIBUTES psa,
diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index b00404d..15dbc87 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -1569,7 +1569,7 @@ access (const char *fn, int flags)
       fhandler_base *fh = build_fh_name (fn, NULL, PC_SYM_FOLLOW, stat_suffixes);
       if (fh)
 	{
-	  res =  fh->fhaccess (flags);
+	  res =  fh->fhaccess (flags, false);
 	  delete fh;
 	}
     }
@@ -3864,7 +3864,7 @@ faccessat (int dirfd, const char *pathname, int mode, int flags)
 					     stat_suffixes);
 	  if (fh)
 	    {
-	      res =  fh->fhaccess (mode);
+	      res =  fh->fhaccess (mode, flags & AT_EACCESS);
 	      delete fh;
 	    }
 	}
-- 
1.6.5.rc1


--------------070009000401060508080606--
