Return-Path: <SRS0=deyK=7U=gmx.de=johannes.schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by sourceware.org (Postfix) with ESMTPS id EF2903858281
	for <cygwin-patches@cygwin.com>; Tue, 28 Mar 2023 08:17:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EF2903858281
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1679991435; i=johannes.schindelin@gmx.de;
	bh=WkSy+YCVPKqEr+3yEa493Ly2ucX5MLVzGRGy+WqHfRE=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
	b=cZoZmeJtTUXRWIhY5KEbcNEnVw3/kYGmPh1S3+PvziTAC2C5owkjiDAHCYtJ7/4aw
	 30Lu61YBRE6kYEn6TrzYP+cJicEmyqNo1VSYoahdUwOdhA5Bt22Urf7W/VUqUOjhiL
	 qOTQ5DXymFbzMggbLXYJQ90Em/3c7fNCnxuDeHX49JXr6wVnR9tyuyKeD+5L8Pt2Ao
	 /7hkx7/0UpUNAXSzNjcguhfEfYg3Hjz3/coMr1sOsA9c+OuKNDbjEu1gEEo6y0nZ/W
	 2RkH11MqjVcQJxxe9ogeKpghTqkG23rku1rO1/cvK51g1fWolVDSy2DroDi2W5WCdn
	 mtPKF6pudrzJQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.93]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPGRp-1q6kHG2xdF-00PeVd for
 <cygwin-patches@cygwin.com>; Tue, 28 Mar 2023 10:17:15 +0200
Date: Tue, 28 Mar 2023 10:17:14 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH v4 1/3] Allow deriving the current user's home directory via
 the HOME variable
In-Reply-To: <cover.1679991274.git.johannes.schindelin@gmx.de>
Message-ID: <7a074997ea64d9f9d6dab766d1c49627e762cbed.1679991274.git.johannes.schindelin@gmx.de>
References: <cover.1663761086.git.johannes.schindelin@gmx.de> <cover.1679991274.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:d9P+eILIoXMGsTEatDz7tXpS7Ra1HV6IzlO1zwqNLYOpoTo/m25
 x9kvlcWDErVQkfOZbf5IlylTq0vQwFEzhwGqVMEP1aNuPY4/wGcrOIgHl1JlNOGizvLujLv
 mZXHT6TQ/BM/TvDYWb+Zjylrj3enh9fJvY0K6px24mitX0v/FzXsFFgUsWcFzixvrkX0lfu
 CB34rlmGLXDkzjansRoSg==
UI-OutboundReport: notjunk:1;M01:P0:vVDMOv0FC/4=;KCZDZgo9SZIOjDcY381vxVROpvz
 Xb5UD3LA7405Ix0cq1bhbPOInCY4ZKWJm/byWBueKFjZcxOcuhq+qmrNhX4tYRYcmqMa49HOv
 seOQYroerA+cyniqk9QQrYtZm/QH4PjVSzw8mWKNekcbm3hOo6hlAQ848WCqebiCclcdMwZ8E
 jMzKevUnRTeuMo6oxMBcpTUZfVzDudDGb4E8Gt4JCYxTvVNDleaWGLBU5aF5YkYY1eVTLeKwK
 2MzD9lZV5phqA5twOgQP52un9aT6HpGmTscztOo+l1CF0niWfDYk3hxails6DI68i3L3IX+2M
 u192+05gZl3MK8zc4Nc9IBVfbj1b8mDRsCIoeVF9J4h2iqfYZWFVWGZYlGTpmm3ZfrDgD4V47
 Pjskg3FYWuifOXrQ/RlAuDb9TwVYvXVILVW4zQo/Y11MwbXa8CLvpPld543emsw4KV9VT8nJD
 juagyHj47geeTrbHqCXfk9kROGEm+fT84hns70kIYR/d1fCOMZ8Hb14WjLVwYKmpvemOvzNZF
 lCJ36w1bJvcUJH7zcEdTfj1j6sq7/mZBOURE87K/VMeiS+/sHbIrbRMw7r6b3hdEabC++8uST
 acfZVZsvTleEsPbp+taz5QJ+m9iIf08PrijKTFEBLIBr0uSr2TOgw+d4l85diSyipmyP0Oql6
 wKPSBw3+XMe0JzK+PqQ7IrqRahTIvTvMvVFQQ3crwWc5YL0PE5MsEPZTZg4OEZdAMRwpCXtA5
 ClqREcuEBqwu58XpQQhawCoiaqYhbfJF/5lAxIpLylSFwx4f1LrBk3KaWse43K7+iBWDlm5mM
 EZ8ev614e5wMXnGjnTmHoyhXluiDh9OEWDOpAVbfSLPiOfwLf9CpPCwtrrI6hB5Ehor2ugFBC
 WhU4LRRQNyvaUV/XKEdGFs4JNisMsVaL46WvKwyewNNMWgh/DCbp3b8TpUY+vyCJw0+Odl4gh
 al1Vfqb0C7GyuoGsCZ7S22S/HqA=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This patch hails from Git for Windows (where the Cygwin runtime is used
in the form of a slightly modified MSYS2 runtime), where it is a
well-established technique to let the `$HOME` variable define where the
current user's home directory is, falling back to `$HOMEDRIVE$HOMEPATH`
and `$USERPROFILE`.

The idea is that we want to share user-specific settings between
programs, whether they be Cygwin, MSYS2 or not.  Unfortunately, we
cannot blindly activate the "db_home: windows" setting because in some
setups, the user's home directory is set to a hidden directory via an
UNC path (\\share\some\hidden\folder$) -- something many programs
cannot handle correctly, e.g. `cmd.exe` and other native Windows
applications that users want to employ as Git helpers.

The established technique is to allow setting the user's home directory
via the environment variables mentioned above: `$HOMEDRIVE$HOMEPATH` or
`$USERPROFILE`.  This has the additional advantage that it is much
faster than querying the Windows user database.

Of course this scheme needs to be opt-in.  For that reason, it needs
to be activated explicitly via `db_home: env` in `/etc/nsswitch.conf`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 winsup/cygwin/local_includes/cygheap.h |  3 +-
 winsup/cygwin/uinfo.cc                 | 51 ++++++++++++++++++++++++++
 winsup/doc/ntsec.xml                   | 22 +++++++++++
 3 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/local_includes/cygheap.h b/winsup/cygwin/local_=
includes/cygheap.h
index d885ca1230..b6acdf7f18 100644
=2D-- a/winsup/cygwin/local_includes/cygheap.h
+++ b/winsup/cygwin/local_includes/cygheap.h
@@ -358,7 +358,8 @@ public:
     NSS_SCHEME_UNIX,
     NSS_SCHEME_DESC,
     NSS_SCHEME_PATH,
-    NSS_SCHEME_FREEATTR
+    NSS_SCHEME_FREEATTR,
+    NSS_SCHEME_ENV
   };
   struct nss_scheme_t {
     nss_scheme_method	method;
diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
index 30df6db6d8..baa670478d 100644
=2D-- a/winsup/cygwin/uinfo.cc
+++ b/winsup/cygwin/uinfo.cc
@@ -733,6 +733,8 @@ cygheap_pwdgrp::nss_init_line (const char *line)
 		    scheme[idx].method =3D NSS_SCHEME_UNIX;
 		  else if (NSS_CMP ("desc"))
 		    scheme[idx].method =3D NSS_SCHEME_DESC;
+		  else if (NSS_CMP ("env"))
+		    scheme[idx].method =3D NSS_SCHEME_ENV;
 		  else if (NSS_NCMP ("/"))
 		    {
 		      const char *e =3D c + strcspn (c, " \t");
@@ -921,6 +923,42 @@ fetch_from_path (cyg_ldap *pldap, PUSER_INFO_3 ui, cy=
gpsid &sid, PCWSTR str,
   return ret;
 }

+static char *
+fetch_home_env (void)
+{
+  /* If `HOME` is set, prefer it */
+  const char *home =3D getenv ("HOME");
+  if (home)
+    return strdup (home);
+
+  /* If `HOME` is unset, fall back to `HOMEDRIVE``HOMEPATH`
+     (without a directory separator, as `HOMEPATH` starts with one). */
+  const char *home_drive =3D getenv ("HOMEDRIVE");
+  if (home_drive)
+    {
+      const char *home_path =3D getenv ("HOMEPATH");
+      if (home_path)
+	{
+	  tmp_pathbuf tp;
+	  char *p =3D tp.c_get (), *q;
+
+	  // concatenate HOMEDRIVE and HOMEPATH
+	  q =3D stpncpy (p, home_drive, NT_MAX_PATH);
+	  strlcpy (q, home_path, NT_MAX_PATH - (q - p));
+	  return (char *) cygwin_create_path (CCP_WIN_A_TO_POSIX, p);
+	}
+    }
+
+  /* If neither `HOME` nor `HOMEDRIVE``HOMEPATH` are set, fall back
+     to `USERPROFILE`; In corporate setups, this might point to a
+     disconnected network share, hence this is the last fall back. */
+  home =3D getenv ("USERPROFILE");
+  if (home)
+    return (char *) cygwin_create_path (CCP_WIN_A_TO_POSIX, home);
+
+  return NULL;
+}
+
 char *
 cygheap_pwdgrp::get_home (cyg_ldap *pldap, cygpsid &sid, PCWSTR dom,
 			  PCWSTR dnsdomain, PCWSTR name, bool full_qualified)
@@ -980,6 +1018,10 @@ cygheap_pwdgrp::get_home (cyg_ldap *pldap, cygpsid &=
sid, PCWSTR dom,
 		}
 	    }
 	  break;
+	case NSS_SCHEME_ENV:
+	  if (RtlEqualSid (sid, cygheap->user.sid ()))
+	    home =3D fetch_home_env ();
+	  break;
 	}
     }
   return home;
@@ -1012,6 +1054,10 @@ cygheap_pwdgrp::get_home (PUSER_INFO_3 ui, cygpsid =
&sid, PCWSTR dom,
 	  home =3D fetch_from_path (NULL, ui, sid, home_scheme[idx].attrib,
 				  dom, NULL, name, full_qualified);
 	  break;
+	case NSS_SCHEME_ENV:
+	  if (RtlEqualSid (sid, cygheap->user.sid ()))
+	    home =3D fetch_home_env ();
+	  break;
 	}
     }
   return home;
@@ -1031,6 +1077,7 @@ cygheap_pwdgrp::get_shell (cyg_ldap *pldap, cygpsid =
&sid, PCWSTR dom,
 	case NSS_SCHEME_FALLBACK:
 	  return NULL;
 	case NSS_SCHEME_WINDOWS:
+	case NSS_SCHEME_ENV:
 	  break;
 	case NSS_SCHEME_CYGWIN:
 	  if (pldap->fetch_ad_account (sid, false, dnsdomain))
@@ -1095,6 +1142,7 @@ cygheap_pwdgrp::get_shell (PUSER_INFO_3 ui, cygpsid =
&sid, PCWSTR dom,
 	case NSS_SCHEME_CYGWIN:
 	case NSS_SCHEME_UNIX:
 	case NSS_SCHEME_FREEATTR:
+	case NSS_SCHEME_ENV:
 	  break;
 	case NSS_SCHEME_DESC:
 	  if (ui)
@@ -1176,6 +1224,8 @@ cygheap_pwdgrp::get_gecos (cyg_ldap *pldap, cygpsid =
&sid, PCWSTR dom,
 		sys_wcstombs_alloc (&gecos, HEAP_NOTHEAP, val);
 	    }
 	  break;
+	case NSS_SCHEME_ENV:
+	  break;
 	}
     }
   if (gecos)
@@ -1202,6 +1252,7 @@ cygheap_pwdgrp::get_gecos (PUSER_INFO_3 ui, cygpsid =
&sid, PCWSTR dom,
 	case NSS_SCHEME_CYGWIN:
 	case NSS_SCHEME_UNIX:
 	case NSS_SCHEME_FREEATTR:
+	case NSS_SCHEME_ENV:
 	  break;
 	case NSS_SCHEME_DESC:
 	  if (ui)
diff --git a/winsup/doc/ntsec.xml b/winsup/doc/ntsec.xml
index c6871ecf05..1678ff6575 100644
=2D-- a/winsup/doc/ntsec.xml
+++ b/winsup/doc/ntsec.xml
@@ -1203,6 +1203,17 @@ schemata are the following:
 	      See <xref linkend=3D"ntsec-mapping-nsswitch-desc"></xref>
 	      for a more detailed description.</listitem>
   </varlistentry>
+  <varlistentry>
+    <term><literal>env</literal></term>
+    <listitem>Derives the home directory of the current user from the
+	      environment variable <literal>HOME</literal> (falling back to
+	      <literal>HOMEDRIVE\HOMEPATH</literal> and
+	      <literal>USERPROFILE</literal>, in that order).  This is faster
+	      than the <term><literal>windows</literal></term> schema at the
+	      expense of determining only the current user's home directory
+	      correctly.  This schema is skipped for any other account.
+	      </listitem>
+  </varlistentry>
 </variablelist>

 <para>
@@ -1335,6 +1346,17 @@ of each schema when used with <literal>db_home:</li=
teral>
 	      See <xref linkend=3D"ntsec-mapping-nsswitch-desc"></xref>
 	      for a detailed description.</listitem>
   </varlistentry>
+  <varlistentry>
+    <term><literal>env</literal></term>
+    <listitem>Derives the home directory of the current user from the
+	      environment variable <literal>HOME</literal> (falling back to
+	      <literal>HOMEDRIVE\HOMEPATH</literal> and
+	      <literal>USERPROFILE</literal>, in that order).  This is faster
+	      than the <term><literal>windows</literal></term> schema at the
+	      expense of determining only the current user's home directory
+	      correctly.  This schema is skipped for any other account.
+	      </listitem>
+  </varlistentry>
   <varlistentry>
     <term><literal>@ad_attribute</literal></term>
     <listitem>AD only: The user's home directory is set to the path given
=2D-
2.40.0.windows.1


