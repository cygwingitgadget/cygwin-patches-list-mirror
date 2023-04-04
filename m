Return-Path: <SRS0=8BlN=73=gmx.de=johannes.schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by sourceware.org (Postfix) with ESMTPS id 8F4B238582A4
	for <cygwin-patches@cygwin.com>; Tue,  4 Apr 2023 15:07:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8F4B238582A4
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1680620875; i=johannes.schindelin@gmx.de;
	bh=nWInKePtD14mrfP9c6dDYpR/nESNgAlacvk08H6ZEK0=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
	b=XFU22ScgX1WwIOrPpLySh88rkVciIkJwqWJJ8gmRJCFyRF5grw2xM2IXE0oFedl+F
	 tJXgVSMOLL827y4SXmSq4uXUnslKkrZA7yduUZKxh6GbYvC5NZ+qLMSveLcY8FwZq7
	 Kr86gJk6xwxpqaYMVz98NIjaU/LbDbNXW4WZtdY7tbCWfdQ3UHKtY8KVO73h21sKjJ
	 eOCNrIf3mJfYnIiNIwARhk2aqRGCwTrksAS0LKNx2GHTBSc0ZtpJ+rfsdVG7oQUJzT
	 ZuNWlT7CMAxK2u8EDM67O3TURTvyjiMqwgqckeCB6hRL2F5IPAP2SZZwZyABxodqun
	 yaIPISkdt8fmw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.182]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MybGX-1qc3lu3Ndd-00z00c for
 <cygwin-patches@cygwin.com>; Tue, 04 Apr 2023 17:07:55 +0200
Date: Tue, 4 Apr 2023 17:07:54 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH v6 3/4] uinfo: special-case IIS APPPOOL accounts
In-Reply-To: <cover.1680620830.git.johannes.schindelin@gmx.de>
Message-ID: <9b79624368e13aef1e71eaee17c422df794ebe5d.1680620830.git.johannes.schindelin@gmx.de>
References: <cover.1680532960.git.johannes.schindelin@gmx.de> <cover.1680620830.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:WS6lUIymgrzrxCqToya45Tb1tVUUTrgt7MIZ+mo3lU+lzfv6Rn5
 fWYk/uKaX5aVsCnTeTQbEysJC3WNcoo//CV49KaeeZMJl1jkja6NNvgZcIVUuOZ9sO2Y3X8
 vH1pe4E168SQwf2GPcByO+/tJhALFavVViifheKiKh28Eodz1uI/poE652xJfZeGCpsOOUN
 VT9gPHZgP3L+xoZRArXUg==
UI-OutboundReport: notjunk:1;M01:P0:9fe2EDr7zMQ=;WqnBFagD6hr/GhW+ETPkCv8h4WU
 WU2wjDCnbJ4lInDyyUTsPlXwef3UaEpekYNUA/qK3TSW2XFPz54LNLklLIMTEqWDTuBlsCa2k
 CB3pS/z8ku0WO5WgW3eX1ejcAHXfLoBBaePoREOAb0Kq7YOycCFunGPRO+2jiIxI7tT0zNZkh
 w3+Wxwr/aUyWgoFl95Q28SuL7S9X2c9eb0ww3i95+rG6hyRCryVkmD6oMH/EdPqLDypxew2H2
 IV1xWO0J+HOcXnZSBv44XEwMof0N+QCcXwglaPCzO21s9RkGZ2mvyta1vrl7ET/eIZ4185lQi
 XsFqk0IYnVAe0GkMFIcVssFMITLPQ1aNy30dRhVoYi3Zm96P/vyncL4T3EIF+pCco/B3LIgHE
 L/dRfqOAuWLqRWyg+19hz1WBfAqgZbgu3MU2OsuF62HpZzcc97Li2C/23065mYbQetMXiYv+C
 bwfPKLNBUNRhS6HhqCwIoY4jHnrEJfugnuY/drSVZsMddJvbcr0XGBSTTz+bPala6Lyo9RRaQ
 99jINAGM0chOXSKdbMwTRjKvQHWRDJk13bRtor3IUcxQ4DJ6g9gxRc6PbzE80gBWgKlm1lsWf
 bPQnwz+/bu7Dqg6yTADDMazsvpThUYIvM7SqGQ1bTaDxV9Q7oREe4irjx4snlkioBsRJX3v4X
 Md9KsAAj3dgi40svu/5hCfmK8fSFEdjzq1VeIySDWiQW68Vvz1iQhFmA1iusxr7Oho0VYaadK
 rOfKGQTbRPpv2FBHwlNxOzkmJ9kKPpPnv2qDoHresZO9qgRDjwETsvmM/4qBBUYLFjjxiN1fv
 nngbeSdAhg7xFbac9Z/92uoB4iKzzMmcHINy0eylbRV0IpQIl9RGEccgzzlOeEDhz9tNWtKIn
 9TDjHXWuuHV+YUeF+FrgKzU3nN0WieRvbKUN0XBaRIBOdkRG2icQatlVZQ/HzwcWlDVguK4de
 Sw1a5g==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The account under which Azure Web Apps run is an IIS APPOOL account that
is generated on the fly.

These are special because the virtual machines on which thes Apps run
are not domain-joined, yet the accounts are domain accounts.

To support the use case where such a Web App needs to call `ssh` (e.g.
to deploy from a Git repository that is accessible only via SSH), we do
need OpenSSH's `getpwuid (getuid ())` invocation to work.

But currently it does not. Concretely, `getuid ()` returns -1 for these
accounts, and OpenSSH fails to find the correct home directory
(_especially_ when that home directory was overridden via a `db_home:
env` line in `/etc/nsswitch.conf`).

This can be verified e.g. in a Kudu console (for details about Kudu
consoles, see https://github.com/projectkudu/kudu/wiki/Kudu-console):
the domain is `IIS APPPOOL`, the account name is the name of the Azure
Web App, the SID starts with 'S-1-5-82-`, and
`pwdgrp::fetch_account_from_windows()` runs into the code path where
"[...] the domain returned by LookupAccountSid is not our machine name,
and if our machine is no domain member, we lose.  We have nobody to ask
for the POSIX offset."

Since these IIS APPPOOL accounts are relatively similar to AzureAD
accounts in this scenario, let's imitate the latter to support also the
former.

Reported-by: David Ebbo <david.ebbo@gmail.com>
Helped-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 winsup/cygwin/uinfo.cc | 107 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 98 insertions(+), 9 deletions(-)

diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
index d493d29b3b..5e2d88bcd7 100644
=2D-- a/winsup/cygwin/uinfo.cc
+++ b/winsup/cygwin/uinfo.cc
@@ -1485,9 +1485,9 @@ get_logon_sid ()
     }
 }

-/* Fetch special AzureAD group, which is part of the token group list but
-   *not* recognized by LookupAccountSid (ERROR_NONE_MAPPED). */
-static cygsid azure_grp_sid ("");
+/* Fetch special AzureAD and IIS APPPOOL groups, which are part of the to=
ken
+   group list but *not* recognized by LookupAccountSid (ERROR_NONE_MAPPED=
). */
+static cygsid azure_grp_sid (""), iis_apppool_grp_sid ("");

 static void
 get_azure_grp_sid ()
@@ -1515,6 +1515,36 @@ get_azure_grp_sid ()
     }
 }

+static void
+get_iis_apppool_grp_sid ()
+{
+  if (PSID (iis_apppool_grp_sid) =3D=3D NO_SID)
+    {
+      NTSTATUS status;
+      ULONG size;
+      tmp_pathbuf tp;
+      PTOKEN_GROUPS groups =3D (PTOKEN_GROUPS) tp.w_get ();
+
+      status =3D NtQueryInformationToken (hProcToken, TokenGroups, groups=
,
+					2 * NT_MAX_PATH, &size);
+      if (!NT_SUCCESS (status))
+	debug_printf ("NtQueryInformationToken (TokenGroups) %y", status);
+      else
+	{
+	  for (DWORD pg =3D 0; pg < groups->GroupCount; ++pg)
+	    {
+	      PSID sid =3D groups->Groups[pg].Sid;
+	      if (sid_id_auth (sid) =3D=3D 5 &&
+		  sid_sub_auth (sid, 0) =3D=3D SECURITY_APPPOOL_ID_BASE_RID)
+		{
+		  iis_apppool_grp_sid =3D sid;
+		  break;
+		}
+	    }
+	}
+    }
+}
+
 void *
 pwdgrp::add_account_post_fetch (char *line, bool lock)
 {
@@ -1796,6 +1826,16 @@ pwdgrp::construct_sid_from_name (cygsid &sid, wchar=
_t *name, wchar_t *sep)
 	}
       return false;
     }
+  if (sep && wcscmp (name, L"IIS APPPOOL\\Group") =3D=3D 0)
+    {
+      get_iis_apppool_grp_sid ();
+      if (PSID (logon_sid) !=3D NO_SID)
+	{
+	  sid =3D iis_apppool_grp_sid;
+	  return true;
+	}
+      return false;
+    }
   if (!sep && wcscmp (name, L"CurrentSession") =3D=3D 0)
     {
       get_logon_sid ();
@@ -2018,8 +2058,11 @@ pwdgrp::fetch_account_from_windows (fetch_user_arg_=
t &arg, cyg_ldap *pldap)
       /* Last but not least, some validity checks on the name style. */
       if (!fq_name)
 	{
-	  /* AzureAD user must be prepended by "domain" name. */
-	  if (sid_id_auth (sid) =3D=3D 12)
+	  /* AzureAD and IIS APPPOOL users must be prepended by "domain"
+	     name. */
+	  if (sid_id_auth (sid) =3D=3D 12 ||
+	      (sid_id_auth (sid) =3D=3D 5 &&
+	       sid_sub_auth (sid, 0) =3D=3D SECURITY_APPPOOL_ID_BASE_RID))
 	    return NULL;
 	  /* name_only account is either builtin or primary domain, or
 	     account domain on non-domain machines. */
@@ -2045,8 +2088,10 @@ pwdgrp::fetch_account_from_windows (fetch_user_arg_=
t &arg, cyg_ldap *pldap)
 	}
       else
 	{
-	  /* AzureAD accounts should be fully qualifed either. */
-	  if (sid_id_auth (sid) =3D=3D 12)
+	  /* AzureAD and IIS APPPOOL accounts should be fully qualifed either. *=
/
+	  if (sid_id_auth (sid) =3D=3D 12 ||
+	      (sid_id_auth (sid) =3D=3D 5 &&
+	       sid_sub_auth (sid, 0) =3D=3D SECURITY_APPPOOL_ID_BASE_RID))
 	    break;
 	  /* Otherwise, no fully_qualified for builtin accounts, except for
 	     NT SERVICE, for which we require the prefix.  Note that there's
@@ -2125,6 +2170,19 @@ pwdgrp::fetch_account_from_windows (fetch_user_arg_=
t &arg, cyg_ldap *pldap)
 	  sid =3D csid =3D azure_grp_sid;
 	  break;
 	}
+      else if (arg.id =3D=3D 0x1002)
+        {
+	  /* IIS APPPOOL S-1-5-82-* user */
+	  csid =3D cygheap->user.saved_sid ();
+	}
+      else if (arg.id =3D=3D 0x1003)
+        {
+	  /* Special IIS APPPOOL group SID */
+	  get_iis_apppool_grp_sid ();
+	  /* LookupAccountSidW will fail. */
+	  sid =3D csid =3D iis_apppool_grp_sid;
+	  break;
+	}
       else if (arg.id =3D=3D 0xfffe)
 	{
 	  /* Special case "nobody" for reproducible construction of a
@@ -2253,7 +2311,9 @@ pwdgrp::fetch_account_from_windows (fetch_user_arg_t=
 &arg, cyg_ldap *pldap)

 		 Those we let pass, but no others. */
 	      bool its_ok =3D false;
-	      if (sid_id_auth (sid) =3D=3D 12)
+	      if (sid_id_auth (sid) =3D=3D 12 ||
+		  (sid_id_auth (sid) =3D=3D 5 &&
+		   sid_sub_auth (sid, 0) =3D=3D SECURITY_APPPOOL_ID_BASE_RID))
 		its_ok =3D true;
 	      else /* Microsoft Account */
 		{
@@ -2342,7 +2402,7 @@ pwdgrp::fetch_account_from_windows (fetch_user_arg_t=
 &arg, cyg_ldap *pldap)
 		    posix_offset =3D fetch_posix_offset (td, &loc_ldap);
 		}
 	    }
-	  /* AzureAD S-1-12-1-W-X-Y-Z user */
+	  /* AzureAD S-1-12-1-W-X-Y-Z and IIS APPOOL S-1-5-82-* user */
 	  else if (sid_id_auth (sid) =3D=3D 12)
 	    {
 	      uid =3D gid =3D 0x1000;
@@ -2355,6 +2415,21 @@ pwdgrp::fetch_account_from_windows (fetch_user_arg_=
t &arg, cyg_ldap *pldap)
 					     name, fully_qualified_name);
 	      break;
 	    }
+	  /* IIS APPOOL S-1-5-82-* user */
+	  else if (sid_id_auth (sid) =3D=3D 5 &&
+		   sid_sub_auth (sid, 0) =3D=3D SECURITY_APPPOOL_ID_BASE_RID)
+	    {
+	      uid =3D 0x1002;
+	      gid =3D 0x1003;
+	      fully_qualified_name =3D true;
+	      home =3D cygheap->pg.get_home ((PUSER_INFO_3) NULL, sid, dom, name=
,
+					   fully_qualified_name);
+	      shell =3D cygheap->pg.get_shell ((PUSER_INFO_3) NULL, sid, dom,
+					     name, fully_qualified_name);
+	      gecos =3D cygheap->pg.get_gecos ((PUSER_INFO_3) NULL, sid, dom,
+					     name, fully_qualified_name);
+	      break;
+	    }
 	  /* If the domain returned by LookupAccountSid is not our machine
 	     name, and if our machine is no domain member, we lose.  We have
 	     nobody to ask for the POSIX offset. */
@@ -2614,6 +2689,20 @@ pwdgrp::fetch_account_from_windows (fetch_user_arg_=
t &arg, cyg_ldap *pldap)
       fully_qualified_name =3D true;
       acc_type =3D SidTypeUnknown;
     }
+  else if (sid_id_auth (sid) =3D=3D 5 &&
+	   sid_sub_auth (sid, 0) =3D=3D SECURITY_APPPOOL_ID_BASE_RID)
+    {
+      /* Special IIS APPPOOL group SID which can't be resolved by
+         LookupAccountSid (ERROR_NONE_MAPPED).  This is only allowed
+	 as group entry, not as passwd entry. */
+      if (is_passwd ())
+	return NULL;
+      uid =3D gid =3D 0x1003;
+      wcpcpy (dom, L"IIS APPPOOL");
+      wcpcpy (name =3D namebuf, L"Group");
+      fully_qualified_name =3D true;
+      acc_type =3D SidTypeUnknown;
+    }
   else if (sid_id_auth (sid) =3D=3D 5 /* SECURITY_NT_AUTHORITY */
 	   && sid_sub_auth (sid, 0) =3D=3D SECURITY_LOGON_IDS_RID)
     {
=2D-
2.40.0.windows.1


