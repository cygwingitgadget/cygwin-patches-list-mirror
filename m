Return-Path: <cygwin-patches-return-3483-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17812 invoked by alias); 3 Feb 2003 15:06:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17803 invoked from network); 3 Feb 2003 15:06:38 -0000
Message-Id: <3.0.5.32.20030203100325.008056f0@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com (Unverified)
Date: Mon, 03 Feb 2003 15:06:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: set_process_privilege and chown
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1044302605==_"
X-SW-Source: 2003-q1/txt/msg00132.txt.bz2

--=====================_1044302605==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 454

Corinna,

Here is a chown related patch, fixing one old and one recent bug.

2003/02/03  Pierre Humblet  <pierre.humblet@ieee.org>

	* security.h: Add third argument to set_process_privilege.
	* autoload.cc: Add OpenThreadToken.
	* sec_helper.cc (set_process_privilege): Add and use use_thread argument.
	* security.cc (alloc_sd): Modify call to set_process_privilege. Remember
	the result in each process. If failed and file owner is not the user, fail.
--=====================_1044302605==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="chown.diff"
Content-length: 4459

Index: security.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/security.h,v
retrieving revision 1.36
diff -u -p -r1.36 security.h
--- security.h	14 Dec 2002 17:23:42 -0000	1.36
+++ security.h	3 Feb 2003 14:16:39 -0000
@@ -236,7 +236,7 @@ BOOL get_logon_server (const char * doma

 /* sec_helper.cc: Security helper functions. */
 BOOL __stdcall is_grp_member (__uid32_t uid, __gid32_t gid);
-int set_process_privilege (const char *privilege, BOOL enable =3D TRUE);
+int set_process_privilege (const char *privilege, bool enable =3D true, bo=
ol use_thread =3D false);

 /* shared.cc: */
 /* Retrieve a security descriptor that allows all access */
Index: sec_helper.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/sec_helper.cc,v
retrieving revision 1.32
diff -u -p -r1.32 sec_helper.cc
--- sec_helper.cc	26 Jan 2003 06:42:40 -0000	1.32
+++ sec_helper.cc	3 Feb 2003 14:21:24 -0000
@@ -294,7 +294,7 @@ got_it:
 #endif //unused

 int
-set_process_privilege (const char *privilege, BOOL enable)
+set_process_privilege (const char *privilege, bool enable, bool use_thread)
 {
   HANDLE hToken =3D NULL;
   LUID restore_priv;
@@ -302,8 +302,12 @@ set_process_privilege (const char *privi
   int ret =3D -1;
   DWORD size;

-  if (!OpenProcessToken (hMainProc, TOKEN_QUERY | TOKEN_ADJUST_PRIVILEGES,
-			 &hToken))
+  if ((use_thread
+       && !OpenThreadToken (GetCurrentThread (), TOKEN_QUERY | TOKEN_ADJUS=
T_PRIVILEGES,
+			    0, &hToken))
+      ||(!use_thread
+	 && !OpenProcessToken (hMainProc, TOKEN_QUERY | TOKEN_ADJUST_PRIVILEGES,
+			     &hToken)))
     {
       __seterrno ();
       goto out;
@@ -329,7 +333,6 @@ set_process_privilege (const char *privi
      be enabled. GetLastError () returns an correct error code, though. */
   if (enable && GetLastError () =3D=3D ERROR_NOT_ALL_ASSIGNED)
     {
-      debug_printf ("Privilege %s couldn't be assigned", privilege);
       __seterrno ();
       goto out;
     }
Index: security.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/security.cc,v
retrieving revision 1.132
diff -u -p -r1.132 security.cc
--- security.cc	26 Jan 2003 06:42:40 -0000	1.132
+++ security.cc	3 Feb 2003 14:27:36 -0000
@@ -1563,9 +1563,20 @@ alloc_sd (__uid32_t uid, __gid32_t gid,
     }
   owner_sid.debug_print ("alloc_sd: owner SID =3D");

-  /* Must have SE_RESTORE_NAME privilege to change owner */
-  if (cur_owner_sid && owner_sid !=3D cur_owner_sid
-      && set_process_privilege (SE_RESTORE_NAME) < 0 )
+  /* Try turning privilege on, may not have WRITE_OWNER or WRITE_DAC acces=
s.
+     Must have privilege to set different owner, else BackupWrite misbehav=
es */
+  static int NO_COPY saved_res; /* 0: never, 1: failed, 2 & 3: OK */
+  int res;
+  if (!saved_res || cygheap->user.issetuid ())
+    {
+      res =3D 2 + set_process_privilege (SE_RESTORE_NAME, true,
+				       cygheap->user.issetuid ());
+      if (!cygheap->user.issetuid ())
+	saved_res =3D res;
+    }
+  else
+    res =3D saved_res;
+  if (res =3D=3D 1 && owner_sid !=3D cygheap->user.sid ())
     return NULL;

   /* Get SID of new group. */
Index: autoload.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/autoload.cc,v
retrieving revision 1.59
diff -u -p -r1.59 autoload.cc
--- autoload.cc	15 Jan 2003 10:21:23 -0000	1.59
+++ autoload.cc	3 Feb 2003 14:33:17 -0000
@@ -352,6 +352,7 @@ LoadDLLfunc (LsaOpenPolicy, 16, advapi32
 LoadDLLfunc (LsaQueryInformationPolicy, 12, advapi32)
 LoadDLLfunc (MakeSelfRelativeSD, 12, advapi32)
 LoadDLLfunc (OpenProcessToken, 12, advapi32)
+LoadDLLfunc (OpenThreadToken, 16, advapi32)
 LoadDLLfunc (RegCloseKey, 4, advapi32)
 LoadDLLfunc (RegCreateKeyExA, 36, advapi32)
 LoadDLLfunc (RegDeleteKeyA, 8, advapi32)

--=====================_1044302605==_--
