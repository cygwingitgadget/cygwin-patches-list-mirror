Return-Path: <cygwin-patches-return-2192-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 23742 invoked by alias); 17 May 2002 01:01:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23701 invoked from network); 17 May 2002 01:01:21 -0000
Message-Id: <3.0.5.32.20020516205822.007f7b20@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Thu, 16 May 2002 18:01:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: set_errno() fixes
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1021611502==_"
X-SW-Source: 2002-q2/txt/msg00176.txt.bz2

--=====================_1021611502==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 442

2002-05-16  Pierre Humblet <pierre.humblet@ieee.org>

	* fhandler_raw.cc (fhandler_dev_raw::open): Replace set_errno()
	by __seterrno_from_win_error(). 
	* security.cc (open_local_policy): Ditto. (get_lsa_srv_inf): Ditto.
	(get_user_groups): Ditto. (get_user_primary_group): Ditto.
	(create_token): Ditto. (subauth): Ditto.

I have also removed some debug_printf() when the printf()'s from
__seterrno_from_win_error() are unambiguous.

Pierre
--=====================_1021611502==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="security.cc.diff"
Content-length: 3075

--- security.cc.orig	Thu May 16 20:04:36 2002
+++ security.cc	Thu May 16 20:24:14 2002
@@ -184,7 +184,7 @@

   NTSTATUS ret =3D LsaOpenPolicy(NULL, &oa, POLICY_EXECUTE, &lsa);
   if (ret !=3D STATUS_SUCCESS)
-    set_errno (LsaNtStatusToWinError (ret));
+    __seterrno_from_win_error (LsaNtStatusToWinError (ret));
   return lsa;
 }

@@ -210,7 +210,7 @@
   if ((ret =3D LsaQueryInformationPolicy (lsa, PolicyAccountDomainInformat=
ion,
 					(PVOID *) &adi)) !=3D STATUS_SUCCESS)
     {
-      set_errno (LsaNtStatusToWinError(ret));
+      __seterrno_from_win_error (LsaNtStatusToWinError(ret));
       return FALSE;
     }
   lsa2wchar (account, adi->DomainName, INTERNET_MAX_HOST_NAME_LENGTH + 1);
@@ -218,7 +218,7 @@
   if ((ret =3D LsaQueryInformationPolicy (lsa, PolicyPrimaryDomainInformat=
ion,
 					(PVOID *) &pdi)) !=3D STATUS_SUCCESS)
     {
-      set_errno (LsaNtStatusToWinError(ret));
+      __seterrno_from_win_error (LsaNtStatusToWinError(ret));
       return FALSE;
     }
   lsa2wchar (primary, pdi->Name, INTERNET_MAX_HOST_NAME_LENGTH + 1);
@@ -282,8 +282,7 @@
 			    MAX_PREFERRED_LENGTH, &cnt, &tot);
   if (ret)
     {
-      debug_printf ("%d =3D NetUserGetGroups ()", ret);
-      set_errno (ret);
+      __seterrno_from_win_error (ret);
       /* It's no error when the user name can't be found. */
       return ret =3D=3D NERR_UserNotFound;
     }
@@ -356,8 +355,7 @@
 			   MAX_PREFERRED_LENGTH, &cnt, &tot, NULL);
   if (ret)
     {
-      debug_printf ("%d =3D NetLocalGroupEnum ()", ret);
-      set_errno (ret);
+      __seterrno_from_win_error (ret);
       return FALSE;
     }

@@ -434,8 +432,7 @@
     ret =3D NetUserGetInfo (NULL, wuser, 3, (LPBYTE *) &buf);
   if (ret)
     {
-      debug_printf ("%d =3D NetUserGetInfo ()", ret);
-      set_errno (ret);
+      __seterrno_from_win_error (ret);
       return FALSE;
     }

@@ -848,7 +845,7 @@
 		       &auth_luid, &exp, &user, grps, privs, &owner, &pgrp,
 		       &dacl, &source);
   if (ret)
-    set_errno (RtlNtStatusToDosError (ret));
+    __seterrno_from_win_error (RtlNtStatusToDosError (ret));
   else if (GetLastError () =3D=3D ERROR_PROC_NOT_FOUND)
     {
       __seterrno ();
@@ -929,7 +926,7 @@
   if (ret !=3D STATUS_SUCCESS)
     {
       debug_printf ("LsaRegisterLogonProcess: %d", ret);
-      set_errno (LsaNtStatusToWinError(ret));
+      __seterrno_from_win_error (LsaNtStatusToWinError(ret));
       goto out;
     }
   else if (GetLastError () =3D=3D ERROR_PROC_NOT_FOUND)
@@ -943,7 +940,7 @@
   if (ret !=3D STATUS_SUCCESS)
     {
       debug_printf ("LsaLookupAuthenticationPackage: %d", ret);
-      set_errno (LsaNtStatusToWinError(ret));
+      __seterrno_from_win_error (LsaNtStatusToWinError(ret));
       LsaDeregisterLogonProcess(lsa_hdl);
       goto out;
     }
@@ -972,7 +969,7 @@
   if (ret !=3D STATUS_SUCCESS)
     {
       debug_printf ("LsaLogonUser: %d", ret);
-      set_errno (LsaNtStatusToWinError(ret));
+      __seterrno_from_win_error (LsaNtStatusToWinError(ret));
       LsaDeregisterLogonProcess(lsa_hdl);
       goto out;
     }

--=====================_1021611502==_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="fhandler_raw.cc.diff"
Content-length: 400

--- fhandler_raw.cc.orig	Thu May 16 19:59:56 2002
+++ fhandler_raw.cc	Thu May 16 20:20:18 2002
@@ -171,8 +171,7 @@
 				FILE_SYNCHRONOUS_IO_NONALERT);
   if (!NT_SUCCESS (status))
     {
-      set_errno (RtlNtStatusToDosError (status));
-      debug_printf ("NtOpenFile: NTSTATUS: %d, Win32: %E", status);
+      __seterrno_from_win_error (RtlNtStatusToDosError (status));
       return 0;
     }
 

--=====================_1021611502==_--
