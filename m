Return-Path: <SRS0=TlDz=BL=gmx.de=johannes.schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id 3839B3858430
	for <cygwin-patches@cygwin.com>; Mon, 22 May 2023 11:12:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3839B3858430
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1684753960; i=johannes.schindelin@gmx.de;
	bh=yBWdpTEWnSECDOTXv2wNbNIQ09RBb6ASIYXG/uX+4VU=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
	b=NHC0VCqLdbPTvJ1FL1uF7LOU5D4b7TDkjiueLRE6ApNoeYyNu+qlM7PaS+o45Hg6K
	 Z4kbcgV4qKhbscAjKloiNsXs4HEi5Bu2H/NDIT70sFo5z0X6m/fwQ+AwE9YOw3hZb1
	 laVZ2kB9ZBdIrwTbT8nFNCYEIoumHM7qykk5Cj6evFcmUZm6wRGd0I5fvaf6T0g0JQ
	 xN/DPPapd07MGvsXcQ847ckQld1+H18rUxvntHxjez5QHvPUH08+90AYqEXtbpx9sx
	 i828x8RqRLQNtxrFJb6fKVSKIJIiesShmEPU5ZN6Fx2gOJcPvEP1vn2kn32clBgTrr
	 gRKegnBoMCHlA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.249]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MI5Q5-1pwyat0Hax-00FCOu for
 <cygwin-patches@cygwin.com>; Mon, 22 May 2023 13:12:40 +0200
Date: Mon, 22 May 2023 13:12:38 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH v7 1/4] Allow deriving the current user's home directory via
 the HOME variable
In-Reply-To: <cover.1684753872.git.johannes.schindelin@gmx.de>
Message-ID: <e26cae9439b01c8a958eb19072c88e9db3abd36e.1684753873.git.johannes.schindelin@gmx.de>
References: <cover.1680620830.git.johannes.schindelin@gmx.de> <cover.1684753872.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:BUa8wG3G+C7Uzp36FYZfmFHzZTKzCZaroSiOzdM8ZSAxOYaqiDQ
 uTSOe8ADfuTQlkCOY4/YDvgFM41lEd9FOWGFuiDmD+7PKqvbXKH0gkmG3L9CeT/gOWuzqWg
 MdovAZIEiiRpd4rEZ5CFcc/H8wtfkaBzTwK2e+JrDnbuA9u1nwKB/Vi2MF9/+caD4Q5vzv9
 zRMWYaD+7BzX1jzy1P14w==
UI-OutboundReport: notjunk:1;M01:P0:MsZAJqt8rhk=;Uv2MyIIZlUYwjIsWsdMr2BJzP9s
 YGI1SXFw8s/NKUEB0XU3VR/YAnx1J/hPAwZuqBuS4jzTgNw/cP2QUDMeiAY346Wq18DVS42Gu
 90YPxeWfbXb4iUbm/N6FnvbVhjAyekLk8jANDI5xKjwvklFfAKV86v6aCeXvNRdhQ0fnC2fNZ
 JxB5CQpTHr0O9OQW37yuT7541RuC6Sw17C1+cpBCo+znPN9V2PtXuOWjtAhWSFoHpO1yYBDFl
 cuXVpL2fkFbqjSLcWpzh3kzJZhTHCclZpf3LYxZALDDCJn7Wgo981tz7rIc+Y97Kl+7wozkkI
 PlwYTxwvWEVnV6JLExx/GM5natgiuB5DXtFuXZwHeIGUwmb4KQAxNENPcJix/7bPQDfl5SWF/
 BC/q1Gp01fp4ppXNFMciFpkPZETDeTSwT1gbXhKQbG2Xq3XYoDz1IQM1jUaEhTRuxYXUSxAeg
 pQo4qcbyNsXWA1PeXyqVLuDBO57lcS+SpsUuzsEEoas0U+IhbCOY8YFOMGhxNmNDqhnyC/g2G
 A4jXHFu3gYQf2jOllE/y3rWUe6pQ1mpNWvwVAoO1xYm8RiEdeUF3cSsJfxxu5rwj92XKQFogz
 Osm0qPh5BI6BBAXRQJMsHscmYlkRgcwG8D6oESFmLoEK7f7UB5g7A3EOBdZLx5NZqQpsqvVbX
 vCtuKPuhCiG6uoHpYSgPrh930iwlyHcg/mW8GRiO+jlQkj4+AY3lKPGQ8lCGRg+MRb1oGBFdB
 HXIZIqr2W8RHI0sLY2j5ryLIT/13nmosU3sBZNOXpyIipfIQmCFqw//k9faDRhVli1KkeBfzW
 tY8Bv5Ta6DhrQ8hMVUX4E6R5X1vrCp712NddYWqE0Yf1mOgEpyF7ZEK6PVeUDMy4AEBjvzV3L
 z5wlPZ/z0dR92RFVg867MolFGAsZTvqbUc/ProLTwg9xiYfQreqs+T1OG+BnorwjVib4xEgt5
 wYaUdQ==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Documentation-fixes-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 winsup/cygwin/local_includes/cygheap.h |  3 +-
 winsup/cygwin/uinfo.cc                 | 51 ++++++++++++++++++++++++++
 winsup/doc/ntsec.xml                   | 20 +++++++++-
 3 files changed, 72 insertions(+), 2 deletions(-)

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
index c6871ecf05..687789076c 100644
=2D-- a/winsup/doc/ntsec.xml
+++ b/winsup/doc/ntsec.xml
@@ -1167,7 +1167,7 @@ and on non-AD machines.
 </para>

 <para>
-Four schemata are predefined, two schemata are variable.  The predefined
+Five schemata are predefined, two schemata are variable.  The predefined
 schemata are the following:
 </para>

@@ -1203,6 +1203,13 @@ schemata are the following:
 	      See <xref linkend=3D"ntsec-mapping-nsswitch-desc"></xref>
 	      for a more detailed description.</listitem>
   </varlistentry>
+  <varlistentry>
+    <term><literal>env</literal></term>
+    <listitem>Utilizes the user's environment.  This schema is only suppo=
rted
+	      for setting the home directory yet.
+	      See <xref linkend=3D"ntsec-mapping-nsswitch-home"></xref> for
+	      the description.</listitem>
+  </varlistentry>
 </variablelist>

 <para>
@@ -1335,6 +1342,17 @@ of each schema when used with <literal>db_home:</li=
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
+	      than the <literal>windows</literal> schema at the
+	      expense of determining only the current user's home directory
+	      correctly.  This schema is skipped for any other account.
+	      </listitem>
+  </varlistentry>
   <varlistentry>
     <term><literal>@ad_attribute</literal></term>
     <listitem>AD only: The user's home directory is set to the path given
=2D-
2.41.0.rc0.windows.1


