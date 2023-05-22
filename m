Return-Path: <SRS0=TlDz=BL=gmx.de=johannes.schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id 1732B3858C50
	for <cygwin-patches@cygwin.com>; Mon, 22 May 2023 11:12:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1732B3858C50
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1684753977; i=johannes.schindelin@gmx.de;
	bh=9mny4JTjya8tGQZVHA0XBFy4nPHX2l04b1Q/wXCeZoY=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
	b=uFfyPSflRL/YAVo158FcoZdG1dOrO+HoMqn+mnISZjBnz+i1W3DrueYFzRpgfSzE0
	 lnmPR/t6RYJtZGA24+42v5+UUeDPOnHe1wYGE7K0Lr4S0zr65IZDG1wbmPZg0qwlGW
	 tZgNllYo6Z3ArLcZ4gTO8C161ndoXayc3KVwF+36rOmSuVaV/I1elZWUjvKRtBDef+
	 qL/4UAeMhU/LwOXc+d6Iik/73rtAcPjEgFoxkeJC3AYBvM4wXEpfq29OTQtaThd5A0
	 ZEsLYR90LzpONhsPV6yYwnlPIyI/JdByWEuWQaoWnUVdmwk6Gz6GK35Slk87evQ9iP
	 q3zla2peY6YjQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.249]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7QxL-1qCzKu3MJZ-017it9 for
 <cygwin-patches@cygwin.com>; Mon, 22 May 2023 13:12:57 +0200
Date: Mon, 22 May 2023 13:12:56 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH v7 3/4] uinfo: special-case IIS APPPOOL accounts
In-Reply-To: <cover.1684753872.git.johannes.schindelin@gmx.de>
Message-ID: <9b79624368e13aef1e71eaee17c422df794ebe5d.1684753873.git.johannes.schindelin@gmx.de>
References: <cover.1680620830.git.johannes.schindelin@gmx.de> <cover.1684753872.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ow1x6n8xeI8vI02m3/QWKpXl5ZH2i1OSYlHIv+pzokEVx7ES6uq
 qzXpyBfpxRp+/TtYew86kZQvtpHkpBRf87Ko/1FJZQqIMKNkIksvVcoOP+7iHOo4Tuq87A8
 Rg+W5UbI52/ROdFr3guwozkITi/5+8AEpFTo+L0uE9TiikVR13JFMOr4p8TXdCZMGL7YoJE
 IosMCzMvCozujwoN6PXIA==
UI-OutboundReport: notjunk:1;M01:P0:2CQFrxn0+gU=;8dT7eWuCMb8Qwy2FlxIjlNoXhDn
 z2iUbeYaLzEbUrkm+b5KAmXISH6O2S+TXFgp/l9Dhdh6CW28+glZCGVOATk0j84HtMzOzYUH1
 BuNwZTJBzdJYPUxNxS10El1qL7kB7jOoMe2UuBV0LKGLCwdCugU+dXt9kSC5HmtpuxS2Uy8Re
 2bWfWuQg2RwE/aOaunPS2YsIg5MI/+JwTJVXBflB/8YVIPPvGkImiO8rYQRfo4Gpwk2G2+n5c
 84jZNSaMpkjErX0Wjmzf3nRlcwyIX9xjY1yzFBuZGxGKfjzLp2f81mY71BRnGGVflhtqrcDiI
 6R11KqhaMqNCrUqRfUXbHcqvTC2lKFqyT9c+7s+m2NpytmATZ3Z4Q7ayHyIIEzbbN93tXSUyL
 X+rWGXYyqMh12yK0KAN4AlVryAdaEtkJTbQ4UH0r7k2J2J5aBJNIg6ArykaE+GdWumk7rCtG+
 dpiTs+nhw10zKrIA0bdP+hcBtE72C2o68W4CeDnHlgHuCWJhhmerGQmoLg7EuFyo+3ksbPbIH
 Pj37jlBoOGBtu+Cz1bws6cZwdrQ13EbykpI1FMQiO2WW0FCrQGq5sCkQU3TxVmpwosYM/5028
 iYiXyidBLxAMD+cf0V6VEnbwvYE0733UJVQJb9kFrA0RvoyoqrQUrgLjMm20CeSJJm4sidntb
 KAWvP6K1QQxWPKfuYP/9sVG3PUjouGDaGvGR+5+iOGgknBc5gr+cQnjwji8EhaKprjH78jhtp
 utSOiv0IJ90+bUX4Qr9HGj4GSaJVLJEsy2iftoJunDrC8mUfvHZPvJ825mfjwXqLqvOfP/e2c
 1zaGdmomxFfIwJ+Nr/HeCzX26LUwXlBIDIaZJMhpnFRRVcDBZ3B4NTNGMhsSVTOurba8FF8wq
 nUz0me0vS+qYYehrn3wqIFwEKFafOXZwPX+o9ffp9kVtcfy0Nu5eQHMyCS2xEZweCCozHLmLW
 bU4PdQ==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
2.41.0.rc0.windows.1


