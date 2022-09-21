Return-Path: <johannes.schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id EFC6B38582B4
	for <cygwin-patches@cygwin.com>; Wed, 21 Sep 2022 11:51:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org EFC6B38582B4
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1663761115;
	bh=xDWPXjvO06HQRsbykBxSLbVB59xi6WxGLuLa9Nqx0S0=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
	b=LhCCNSm4sscKGM999oG0IlTxr3ZYJhsgoGgFhqrZD8YQodicva49ciDGhVhXigV/9
	 QAUSSOhMlP60Gg1/Hs4QzyFkqYcr9uGGPE7Slyf0slAJi+u7vWmtYnjp0NUTubuVY5
	 9Xe3Daph93Jf3IDSjSYa00KNUxjxnvfiKtyQCngk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.115.55] ([89.1.213.188]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNbkv-1ouOn21Lnn-00P7tj for
 <cygwin-patches@cygwin.com>; Wed, 21 Sep 2022 13:51:55 +0200
Date: Wed, 21 Sep 2022 13:51:54 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH v3 1/3] Allow deriving the current user's home directory via
 the HOME variable
In-Reply-To: <cover.1663761086.git.johannes.schindelin@gmx.de>
Message-ID: <6f8fe89d9d747a752107fc180f31a6709e0de4f2.1663761086.git.johannes.schindelin@gmx.de>
References: <cover.1450375424.git.johannes.schindelin@gmx.de> <cover.1663761086.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DpIe9cyiqyNxh1sAOszD4BMUf6s7Rtrj0S8DglDpujEl2RU6lrj
 Z6rGi9UGN3vtnseqGLXn25eJvsQzr5uG2E9LEhdgqx125u9rsK+0C9Xtm3Z9NE0/gPWrW1v
 JRDhnCmBZR7Nm/ufxLCRowaCltkQ4sOy0V7Eo9gL5Ylk33un80OftURPFwpVwC2kOXSnf0j
 qSEUgj/a3Tc9wXTTWgLQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5SOkJJd6H2U=:KzMtjMBSZeZCyJaF5m/Jvy
 1IA77ejaiDbeAXe5emHPvkOflxwzQdP7ES7JAxoHo0lp91k9m14g9y0Ni4bfprHUngrS9CzQE
 3bbQNaoJMAk/fNAfWERwRWtozHWNomyjTO2Aw8Ax4svx/dsQ79VIVtrL/BXntOP1Zv7CPZ9EB
 5U2sLdYk1PS/DQU2yZQ2TjMOhGFtcN/GRiQndUTy06NN6CAT8m6hJFfmQZC4skkdsymGOPvli
 3eX2QWtXoc8oC00/BVDbFYm+Ech1yfVCW+8pPa8Ri4DxJY4neSkoD8lZriO4SMh60pOJz9NZA
 RucyBC4S05lUlY9CKBiaHYZoNH6LPIM6CuKb0Dk0FL13t+FmSOMqA/k5BRYDQxBAUaPwSpE9f
 EZMzpuB9NlWQYjVgQDY9p5J1T21j3UAGuFBZAnjCm1AGfHxB7pdJLe4opkAjordK0c/eUm72z
 l2D+DH3QueCNHsFH257u8k6PAQj0QUJFeagDK8ijBrQRQ4wQKogBP18PMqv8aozIc83aNtSAy
 TDU6hO8IFXe/wGg/va3WvxAGqjEMs6JqCkJsJQ5UnLPi3RMdqlGjLNRc0MtFCzjTs1hAIuspr
 KAx38Iyh/VS5tCOBLQENX7VYfuqWcKC7TNm7q5Xqey5tUmyXMl1b0fE+eX8CLI1DaxyqAFuEW
 jXsrn6SD6H2dEFuDD7v46cbOG3VEWxcH5Q1gN3zxYhXuAAGCLETzHIAJacjUPgBDsQIqa7p4D
 PdXqgJ/k1JQ/jKAFSiT0xLJWTo5SEGXbWSKpPni4bn3QmCO6aK6tXGEDVZ3QwCaMzls3sq7D4
 6BP6nawTav2ibc1XRNx5EtebImwMiZddd0fUprQRfzlZfz5n8iW7Mwnht4mpbNSg0SWRe8UQq
 jT6x7bHOLQPdEkiOfaxc0JVGnBNCdkoZddwqbXsd/R2f0xkTGvx67TRCiVk4lPpRQGE/LLZDS
 cbGOiqH5ndeTI0x0q74GIVDp5mR6WUMxnDaO8oazQjMfD53c9aCPtyhS4nBuok+LDmaHJfA20
 0d6Ug0asbj7mE11gmWsAkjXE6Nqp5+FXt9BoMz2sjqPfbdnEGYEhEsVm1WLL1BKOi8usYDE0Q
 gLBfqAYXjYKtvvwIs3+96v1NiHDALl5GBCZOc4cmt2CnJqeaIIL74fKTScVkIZllzU2yB9sC3
 18vtP2fR6zXQjGcdfiZ2oVq/hf
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
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
 winsup/cygwin/local_includes/cygheap.h |  3 ++-
 winsup/cygwin/uinfo.cc                 | 35 ++++++++++++++++++++++++++
 winsup/doc/ntsec.xml                   | 22 ++++++++++++++++
 3 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/local_includes/cygheap.h b/winsup/cygwin/local_=
includes/cygheap.h
index 6a844babdb..444ca8b55c 100644
=2D-- a/winsup/cygwin/local_includes/cygheap.h
+++ b/winsup/cygwin/local_includes/cygheap.h
@@ -408,7 +408,8 @@ public:
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
index ce997c0f82..6e673ee39e 100644
=2D-- a/winsup/cygwin/uinfo.cc
+++ b/winsup/cygwin/uinfo.cc
@@ -754,6 +754,8 @@ cygheap_pwdgrp::nss_init_line (const char *line)
 		    scheme[idx].method =3D NSS_SCHEME_UNIX;
 		  else if (NSS_CMP ("desc"))
 		    scheme[idx].method =3D NSS_SCHEME_DESC;
+		  else if (NSS_CMP ("env"))
+		    scheme[idx].method =3D NSS_SCHEME_ENV;
 		  else if (NSS_NCMP ("/"))
 		    {
 		      const char *e =3D c + strcspn (c, " \t");
@@ -942,6 +944,26 @@ fetch_from_path (cyg_ldap *pldap, PUSER_INFO_3 ui, cy=
gpsid &sid, PCWSTR str,
   return ret;
 }

+static char *
+fetch_home_env (void)
+{
+  tmp_pathbuf tp;
+  char *p, *q;
+  const char *home, *home_drive, *home_path;
+
+  if ((home =3D getenv ("HOME"))
+      || ((home_drive =3D getenv ("HOMEDRIVE"))
+	  && (home_path =3D getenv ("HOMEPATH"))
+	  // concatenate HOMEDRIVE and HOMEPATH
+          && (home =3D p =3D tp.c_get ())
+	  && (q =3D stpncpy (p, home_drive, NT_MAX_PATH))
+          && strlcpy (q, home_path, NT_MAX_PATH - (q - p)))
+      || (home =3D getenv ("USERPROFILE")))
+    return (char *) cygwin_create_path (CCP_WIN_A_TO_POSIX, home);
+
+  return NULL;
+}
+
 char *
 cygheap_pwdgrp::get_home (cyg_ldap *pldap, cygpsid &sid, PCWSTR dom,
 			  PCWSTR dnsdomain, PCWSTR name, bool full_qualified)
@@ -1001,6 +1023,10 @@ cygheap_pwdgrp::get_home (cyg_ldap *pldap, cygpsid =
&sid, PCWSTR dom,
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
@@ -1033,6 +1059,10 @@ cygheap_pwdgrp::get_home (PUSER_INFO_3 ui, cygpsid =
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
@@ -1052,6 +1082,7 @@ cygheap_pwdgrp::get_shell (cyg_ldap *pldap, cygpsid =
&sid, PCWSTR dom,
 	case NSS_SCHEME_FALLBACK:
 	  return NULL;
 	case NSS_SCHEME_WINDOWS:
+	case NSS_SCHEME_ENV:
 	  break;
 	case NSS_SCHEME_CYGWIN:
 	  if (pldap->fetch_ad_account (sid, false, dnsdomain))
@@ -1116,6 +1147,7 @@ cygheap_pwdgrp::get_shell (PUSER_INFO_3 ui, cygpsid =
&sid, PCWSTR dom,
 	case NSS_SCHEME_CYGWIN:
 	case NSS_SCHEME_UNIX:
 	case NSS_SCHEME_FREEATTR:
+	case NSS_SCHEME_ENV:
 	  break;
 	case NSS_SCHEME_DESC:
 	  if (ui)
@@ -1197,6 +1229,8 @@ cygheap_pwdgrp::get_gecos (cyg_ldap *pldap, cygpsid =
&sid, PCWSTR dom,
 		sys_wcstombs_alloc (&gecos, HEAP_NOTHEAP, val);
 	    }
 	  break;
+	case NSS_SCHEME_ENV:
+	  break;
 	}
     }
   if (gecos)
@@ -1223,6 +1257,7 @@ cygheap_pwdgrp::get_gecos (PUSER_INFO_3 ui, cygpsid =
&sid, PCWSTR dom,
 	case NSS_SCHEME_CYGWIN:
 	case NSS_SCHEME_UNIX:
 	case NSS_SCHEME_FREEATTR:
+	case NSS_SCHEME_ENV:
 	  break;
 	case NSS_SCHEME_DESC:
 	  if (ui)
diff --git a/winsup/doc/ntsec.xml b/winsup/doc/ntsec.xml
index d089964660..c02b1f72e1 100644
=2D-- a/winsup/doc/ntsec.xml
+++ b/winsup/doc/ntsec.xml
@@ -1359,6 +1359,17 @@ schemata are the following:
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
@@ -1491,6 +1502,17 @@ of each schema when used with <literal>db_home:</li=
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
2.38.0.rc0.windows.1


