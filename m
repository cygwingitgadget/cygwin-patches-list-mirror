Return-Path: <cygwin-patches-return-3609-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26611 invoked by alias); 21 Feb 2003 01:16:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26602 invoked from network); 21 Feb 2003 01:16:59 -0000
Message-Id: <3.0.5.32.20030220201534.007fb310@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com (Unverified)
Date: Fri, 21 Feb 2003 01:16:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: access()
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1045808134==_"
X-SW-Source: 2003-q1/txt/msg00258.txt.bz2

--=====================_1045808134==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 2818

Corinna,

Here is a patch with a new implementation of access() using AccessCheck.
Compared to the old version, the readonly attribute and the deny ace's
are taken into account, and the function does not rely on /etc/passwd
nor on /etc/group. It also seems to be somewhat faster.

I was wondering if it would declare that all directories are x, because
of the Bypass Traverse (a.k.a. Change Notify) privilege, but it doesn't.
Except for that it reflects the Windows permissions perfectly.

Note that the builtin "test" in ash uses access(), but /bin/test and 
bash don't.
/> ls -l test
--wx-wx---+   1 PHumblet Users       43310 Oct 24 15:13 test*
/> sh -c 'if [ -r test ]; then echo yes; else echo no; fi'
yes                                                          <== CORRECT!
/> bash -c 'if [ -r test ]; then echo yes; else echo no; fi'
no                                                           <== WRONG
/> getfacl test
# file: test
# owner: PHumblet
# group: Users
user::--x
group::-wx
group:Administrators:r-x                    <== NOT CONSIDERED BY bash
mask:rwx
other:---

The reason that bash and /bin/test do not use access() is that
according to POSIX (but not to Cygwin), access() reflects the 
permissions for the real (and not effective) {u,g}ids.
Thus these two programs define an eaccess() function based on stat().
It doesn't work properly on Cygwin, as shown above.

However bash already uses access() when AFS is defined. Thus it
would be a 1/2 line patch in bash (test.c and findcmd.c) to also
use access() for Cygwin. 
- #if defined (AFS)
+ #if defined (AFS) || defined (__CYGWIN__)
That would be a significant improvement, IMO. What do you think?

Going off-topic, there is a strange feature in findcmd.c (file_status). 
If we are the owner of a file but do not have x permission, 
and the gid is one of our groups and has x permission, 
or others have x permission, then bash considers that the file is 
executable, although it isn't for us.
  /* If `others' have execute permission to the file, then so do we,
     since we are also `others'. */
Fortunately this interpretation is not present in the eaccess function.

Finally I have two questions:
1) Is (!real_path.exists ()) a reliable indicator of file non-existence?
   If so, shouldn't stat take advantage of that, for disk files?
   Stat currently tries twice to open non-existent files. 
2) I am not sure when to use LoadDLLfuncEx vs. LoadDLLfunc.

Pierre

2003-02-21  Pierre Humblet  <pierre.humblet@ieee.org>

	* autoload.cc (AccessCheck): Add.
	(DuplicateToken): Add.
	* security.h (check_file_access): Declare.
	* syscalls.cc (access): Convert path to Windows, check existence
	and readonly attribute. Call check_file_access instead of acl_access.
	* security.cc (check_file_access): Create.
	* sec_acl (acl_access): Delete.


--=====================_1045808134==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="access.diff"
Content-length: 7562

Index: autoload.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/autoload.cc,v
retrieving revision 1.62
diff -u -p -r1.62 autoload.cc
--- autoload.cc	20 Feb 2003 11:12:44 -0000	1.62
+++ autoload.cc	21 Feb 2003 00:14:23 -0000
@@ -307,6 +307,7 @@ wsock_init ()
 LoadDLLprime (wsock32, wsock_init)
 LoadDLLprime (ws2_32, wsock_init)

+LoadDLLfunc (AccessCheck, 32, advapi32)
 LoadDLLfunc (AddAccessAllowedAce, 16, advapi32)
 LoadDLLfunc (AddAccessDeniedAce, 16, advapi32)
 LoadDLLfunc (AddAce, 20, advapi32)
@@ -318,6 +319,7 @@ LoadDLLfuncEx (CryptAcquireContextA, 20,
 LoadDLLfuncEx (CryptGenRandom, 12, advapi32, 1)
 LoadDLLfuncEx (CryptReleaseContext, 8, advapi32, 1)
 LoadDLLfunc (DeregisterEventSource, 4, advapi32)
+LoadDLLfunc (DuplicateToken, 12, advapi32)
 LoadDLLfuncEx (DuplicateTokenEx, 24, advapi32, 1)
 LoadDLLfunc (EqualSid, 8, advapi32)
 LoadDLLfunc (GetAce, 12, advapi32)
Index: security.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/security.h,v
retrieving revision 1.40
diff -u -p -r1.40 security.h
--- security.h	10 Feb 2003 22:43:29 -0000	1.40
+++ security.h	21 Feb 2003 00:14:29 -0000
@@ -225,6 +225,7 @@ LONG __stdcall read_sd(const char *file,
 LONG __stdcall write_sd(const char *file, PSECURITY_DESCRIPTOR sd_buf, DWO=
RD sd_size);
 BOOL __stdcall add_access_allowed_ace (PACL acl, int offset, DWORD attribu=
tes, PSID sid, size_t &len_add, DWORD inherit);
 BOOL __stdcall add_access_denied_ace (PACL acl, int offset, DWORD attribut=
es, PSID sid, size_t &len_add, DWORD inherit);
+int __stdcall check_file_access (const char *, int);

 void set_security_attribute (int attribute, PSECURITY_ATTRIBUTES psa,
 			     void *sd_buf, DWORD sd_buf_size);
Index: syscalls.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.245
diff -u -p -r1.245 syscalls.cc
--- syscalls.cc	10 Feb 2003 22:43:29 -0000	1.245
+++ syscalls.cc	21 Feb 2003 00:14:35 -0000
@@ -1163,8 +1163,6 @@ cygwin_lstat (const char *name, struct _
   return ret;
 }

-extern int acl_access (const char *, int);
-
 extern "C" int
 access (const char *fn, int flags)
 {
@@ -1176,11 +1174,33 @@ access (const char *fn, int flags)
       return -1;
     }

-  if (allow_ntsec)
-    return acl_access (fn, flags);
+  path_conv real_path (fn, PC_SYM_FOLLOW | PC_FULL, stat_suffixes);
+  if (real_path.error)
+    {
+      set_errno (real_path.error);
+      return -1;
+    }
+
+  if (!real_path.exists ())
+    {
+      set_errno (ENOENT);
+      return -1;
+    }
+
+  if (!(flags & (R_OK | W_OK | X_OK)))
+    return 0;
+
+  if (real_path.has_attribute (FILE_ATTRIBUTE_READONLY) && (flags & W_OK))
+    {
+      set_errno (EACCES);
+      return -1;
+    }
+
+  if (real_path.has_acls () && allow_ntsec)
+    return check_file_access (real_path, flags);

   struct __stat64 st;
-  int r =3D stat_worker (fn, &st, 0);
+  int r =3D stat_worker (real_path, &st, 0);
   if (r)
     return -1;
   r =3D -1;
Index: security.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/security.cc,v
retrieving revision 1.137
diff -u -p -r1.137 security.cc
--- security.cc	10 Feb 2003 22:43:29 -0000	1.137
+++ security.cc	21 Feb 2003 00:14:41 -0000
@@ -1918,3 +1918,54 @@ set_file_attribute (int use_ntsec, const
   return set_file_attribute (use_ntsec, file,
 			     myself->uid, myself->gid, attribute);
 }
+
+int
+check_file_access (const char *fn, int flags)
+{
+  int ret =3D -1;
+  char sd_buf[4096];
+  DWORD sd_size =3D sizeof sd_buf;
+  PSECURITY_DESCRIPTOR psd =3D (PSECURITY_DESCRIPTOR) sd_buf;
+  HANDLE hToken, hIToken;
+  BOOL status;
+  char pbuf[sizeof (PRIVILEGE_SET) + 3 * sizeof (LUID_AND_ATTRIBUTES)];
+  DWORD desired =3D 0, granted, plength =3D sizeof pbuf;
+  static GENERIC_MAPPING NO_COPY mapping =3D { FILE_GENERIC_READ,
+					     FILE_GENERIC_WRITE,
+					     FILE_GENERIC_EXECUTE,
+					     FILE_ALL_ACCESS };
+  if (read_sd (fn, psd, &sd_size) <=3D 0)
+    goto done;
+
+  if (cygheap->user.issetuid ())
+    hToken =3D cygheap->user.token;
+  else if (!OpenProcessToken (hMainProc, TOKEN_DUPLICATE, &hToken))
+    {
+      __seterrno ();
+      goto done;
+    }
+  if (!(status =3D DuplicateToken (hToken, SecurityIdentification, &hIToke=
n)))
+    __seterrno ();
+  if (hToken !=3D cygheap->user.token)
+    CloseHandle (hToken);
+  if (!status)
+    goto done;
+
+  if (flags & R_OK)
+    desired |=3D FILE_READ_DATA;
+  if (flags & W_OK)
+    desired |=3D FILE_WRITE_DATA;
+  if (flags & X_OK)
+    desired |=3D FILE_EXECUTE;
+  if (!AccessCheck (psd, hIToken, desired, &mapping,
+		    (PPRIVILEGE_SET) pbuf, &plength, &granted, &status))
+    __seterrno ();
+  else if (!status)
+    set_errno (EACCES);
+  else
+    ret =3D 0;
+  CloseHandle (hIToken);
+ done:
+  debug_printf ("flags %x, ret %d", flags, ret);
+  return ret;
+}
Index: sec_acl.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/sec_acl.cc,v
retrieving revision 1.26
diff -u -p -r1.26 sec_acl.cc
--- sec_acl.cc	5 Feb 2003 16:15:22 -0000	1.26
+++ sec_acl.cc	21 Feb 2003 00:14:45 -0000
@@ -413,69 +413,6 @@ getacl (const char *file, DWORD attr, in
   return pos;
 }

-int
-acl_access (const char *path, int flags)
-{
-  __aclent32_t acls[MAX_ACL_ENTRIES];
-  int cnt;
-
-  if ((cnt =3D acl32 (path, GETACL, MAX_ACL_ENTRIES, acls)) < 1)
-    return -1;
-
-  /* Only check existence. */
-  if (!(flags & (R_OK | W_OK | X_OK)))
-    return 0;
-
-  for (int i =3D 0; i < cnt; ++i)
-    {
-      switch (acls[i].a_type)
-	{
-	case USER_OBJ:
-	case USER:
-	  if (acls[i].a_id !=3D myself->uid)
-	    {
-	      /*
-	       * Check if user is a NT group:
-	       * Take SID from passwd, search SID in token groups
-	       */
-	      cygsid owner;
-	      struct passwd *pw;
-
-	      if ((pw =3D internal_getpwuid (acls[i].a_id)) !=3D NULL
-		  && owner.getfrompw (pw)
-		  && internal_getgroups (0, NULL, &owner) > 0)
-		break;
-	      continue;
-	    }
-	  break;
-	case GROUP_OBJ:
-	case GROUP:
-	  if (acls[i].a_id !=3D myself->gid)
-            {
-	      cygsid group;
-	      struct __group32 *gr =3D NULL;
-
-	      if ((gr =3D internal_getgrgid (acls[i].a_id)) !=3D NULL
-		  && group.getfromgr (gr)
-		  && internal_getgroups (0, NULL, &group) > 0)
-		break;
-	      continue;
-	    }
-	  break;
-	case OTHER_OBJ:
-	  break;
-	default:
-	  continue;
-	}
-      if ((!(flags & R_OK) || (acls[i].a_perm & S_IROTH))
-	  && (!(flags & W_OK) || (acls[i].a_perm & S_IWOTH))
-	  && (!(flags & X_OK) || (acls[i].a_perm & S_IXOTH)))
-	return 0;
-    }
-  set_errno (EACCES);
-  return -1;
-}
-
 static
 int
 acl_worker (const char *path, int cmd, int nentries, __aclent32_t *aclbufp,

--=====================_1045808134==_--
