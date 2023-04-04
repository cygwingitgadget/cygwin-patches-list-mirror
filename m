Return-Path: <SRS0=8BlN=73=gmx.de=johannes.schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by sourceware.org (Postfix) with ESMTPS id 9B3513858407
	for <cygwin-patches@cygwin.com>; Tue,  4 Apr 2023 15:07:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9B3513858407
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1680620866; i=johannes.schindelin@gmx.de;
	bh=DzFTO2RzBVGtYoad6nKPpXGUueF5OTmDENSjulnQcys=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
	b=IRts1A7xxD5mPtPyPW+rdIhpGU5KY+QrJ1hZQZqAat3lr/XYKi+igdGATG5rIE9z9
	 2LTC0GuPBiluCdpjoRVJs59Ia34oyug+eLHiKijVc/WKrchMG1iyu5MD4CMSADTOOv
	 gX8uPDB/lT8rQOP4isJMr7uLGPZR8CjoZsZOF8jdatlzf6f4ooWfvyw7qpBskfxdhM
	 rZXXJx/eybbsjQzMPf42KQlGeDWrVoy6f+88yT1X/tw+KLKwQrWPNUIre4ocm01pIo
	 51yeJPkOomfNazZBOESQq9URoL7SS4b+Gtdw62YRJ9ux0YDKo3lWzFMJF1KbZYvPX+
	 wqvcfzn/yAmAQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.182]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrQJ5-1qEJrZ1hXL-00oUan for
 <cygwin-patches@cygwin.com>; Tue, 04 Apr 2023 17:07:46 +0200
Date: Tue, 4 Apr 2023 17:07:45 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH v6 1/4] Allow deriving the current user's home directory via
 the HOME variable
In-Reply-To: <cover.1680620830.git.johannes.schindelin@gmx.de>
Message-ID: <e26cae9439b01c8a958eb19072c88e9db3abd36e.1680620830.git.johannes.schindelin@gmx.de>
References: <cover.1680532960.git.johannes.schindelin@gmx.de> <cover.1680620830.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:buMBb6vOQ22HFn5k2kmXShu9E915ceWo0guu3+VeOYwrpu+aTYZ
 8O0yB34EJZjDSoH/tivFtVtZ5a4EG3lZ4CJ636AAB1yCK96vEhikXf3u04ti0Erf4yF8Vjp
 G1meLivxxmhV+HT0GdntBzaxj/jHdqp8jbkpzxWoXC+uRRG5+pisQd7LX3rNJe/XRkUYFF5
 4Niv4Wp4sLsPMlC6KQY4g==
UI-OutboundReport: notjunk:1;M01:P0:oXCB6OY/cN8=;9FTBKtOlw/xKKH3jk2zVbbeTytv
 DhyJrQmS6FM3t8/hVLidBdgHi73k4RF3yy2tHo6VDYBTAolg1VPlRbwtHJZnf5z2LMviaHlgE
 GTRS7Rwcr+pzvAskmDAQa38i0glGRIANljEm85ekQXiASkuJGYfePqxdEsfADhQVIP+JXds+Q
 21/M8c3zr93RVg4FixLqau3Dt0Q4sD4MYnPDFuJXEhBUUh/xkzfZ4X3btDmk0iy90dshRDtCA
 3JvJic2cKvJarSfJ0vx8O4840FgCrqSOo1h4qlxsSK+DgL4qacGevA7n9yNdtiVZpE63QEn36
 PSFCJN18Fa8KvaJ04PP4/24mZHMTJ9z/urt0s+YHH/IITU1cvX4eC1srPzpUaVGswcBQp2V3K
 0em9AcD4/jJx8U2UsaxnbAoSBQioBpGaR4OK/sO8tpUCbif67X4VmAZf9J49RcYI1ORKEQHut
 zfYPidTaMWcHFQZ+XFkNkcc1UPsA7ud+kTiSYjIY+quB6lkUQm5zzIXPXPFP0iqy7UVQa+k1y
 G+Fh/kLHdPhSAjXVq1WvbXmocw8tqQ4lrnAFvjDh+5+fNETnxaDiozS18uQthV0fAaAEoucey
 3aGPQrm/yQHRSstOUGetwbZW26dt/ySG2Gs6K7iLShpBV5KHkx8J6k6BQGRi6VHBEauPXhorK
 F96oGaEs5N3uMyctaR0D5Te5TgwJrhO1o/p63NmiqeRMod1t/O7yXIvGIUGKszLrLrYb1QjK7
 Cl/0FT3dJEOzwnmYrraFBzYkOD/bM3V0Chdoy9jewQSbbuJHdmBd+LNUOCDVcSI6PmHdULoS4
 yhzMI2goO5y410jjrS8sla6IguEhuMAP5gJMIAeJ92GBjCq+XkEfepk78XSUFeBceakTutF8B
 sUKUHrmu1DD5cItbO18RyiYZKCXIzAZcfMwXsWYgxrZygLQuENaBucxIs+B29sDIJG+b/sWtM
 usJ2Mg==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
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
2.40.0.windows.1


