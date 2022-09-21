Return-Path: <johannes.schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id 076D03858D37
	for <cygwin-patches@cygwin.com>; Wed, 21 Sep 2022 11:51:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 076D03858D37
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1663761108;
	bh=iOC4CpdxdNlNW7+wIYfwj03MChWHjc5MEuSoP2kjPp4=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
	b=VLDEaegDbLcqhGOobs80oX9YVD0ITpA4YS7jcLjoEHiejUfzW0rsd6w1n4Sf7+Q03
	 xtszH/ylhnMUhcTEqfeSMsTfEcf+kGo7+93+YIfa7WiyCKlQVW6ZhS6RCOclkP9n/U
	 mCiifqXUCDh4J+EsHDb0R3dkbr5lLhj5Fs11GnfE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.115.55] ([89.1.213.188]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MzQg6-1pVwX6237Y-00vS6F for
 <cygwin-patches@cygwin.com>; Wed, 21 Sep 2022 13:51:48 +0200
Date: Wed, 21 Sep 2022 13:51:47 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH v3 0/3] Support deriving the current user's home directory
 via HOME
In-Reply-To: <cover.1450375424.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1663761086.git.johannes.schindelin@gmx.de>
References: <cover.1450375424.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zkfA06Jyv3rZEZTLmZf7tYzeIsH8vBhJGEvpYAZJSoPYYSgR0wx
 Nr05E/QelAvPZWwOZu5kCTH+TrI8P9ZEwI4nSUh/kIT+kUMoNWRMQtjJB9sRgpb/LbALVBP
 1/y4F1w70PX6uzapToE+e3CJRavGJ4KgD/PtYedDL2jo4n0JB50YAvclaNk3GN9xJ8mCIVU
 k56ikuFiHqGGINQBCwymg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jxX5PVIbp+k=:L9hDrsOY2vAtHbm/aVdHfR
 QjEmJuDaSS3cS8KMYVwNY3iEK92wvlKc+Aru7xFLeJZXEPPaYhQw/gHQ7Pp8CrTnKcmbg+4Lt
 I466Zskx/Q1l8gSYlMbHs25+fmnj+Huwk/BR85M+2P3uSLLgtlpzuXgTAoYRv4aDomcwDQNxJ
 s4X/e3xxZ5xDOxdVgFOvKSC2iY1HYEY72s9QfAFizzvBoXLUMT+JgIcX7uGKrdTNkvduCI7K6
 cUCSDqIhb2EdlL+d77zT6ENmb62PgNxF+QylixPu48VzgAwLajgcMVwZ5fcdvmWTd/8C7aPb/
 URVnlejlUhqWzvA0BdDISMGKcA3wZW8afT/5Vwlxi+zj0a20JuOs37qlw+iaqlq3HMhlVcQdW
 ZnsxW8hCfZTDkNwiC02s7zB0/6je8ALEDjlWVkjgR5G6PKjKJUkZJDWHV1Lu64fe3nja70Znk
 xpF6IiODGe63YPTIYShQHNHXLXgHqvyxkJZGaCI9BoEAr/s1Jx/++RLEJ1t8DXqCnwOODIBpw
 +xXayS7jocOYqDtzQreuKP4GQSSdD9JPKLGxr/uLskMSUOaSU390Qr1Dfvs14VYL33tdwR1jq
 KTbvgYogiHckKpncZ6lnZvJcGWVHATynaV2ZMcLk6Sql6v3n8q8AHB0PsAaRE+8O7jDGzBhfb
 PMtTbeRGloE1M/GT8cvwDfg2Z2OQIOkCH5cQMW4BLL2Tg3R4d3GTmdxRnGOZBzYTW8d3vhH4G
 ShUFTKXT3/NVyZkyRxarnH4A0TEqjjf8CWUOrA/mNlG3XUB6w/lZCR+RDz+KpkIPcdUuXsO6F
 8Wj3nP/1d25JZEGYWL1HQdzMASHPTNE0jF351OWKvnE/gI6a4tqvzhG/PGECeMHcbnZRBLgmt
 Ei2LCZ41N1yeK56zeznygHMYHo31lTd3tGUA1sKUYcYfZOeloxDb9dcY28UsLIQhDVs2AiT5j
 US/5vJ/qiaUT5pMl/HbIG9xLB1MPAVIuOwHuqfwfdqG/pOorEsoU4MpYoIr2nevEAKS+FTDtF
 Htn+v1/cdZQbJiV3uaUGNcmKtCygeESsAfX/f+9ZEVL4e8tTePVIXzmKpK6Wia8NkEnIY/wTv
 2rUI7CgxPkVK88prttc8ImYm21Wk6quslPnMDwW7M52saCsjmkkaIZMyoZNm5bnRnVdSJCD5P
 EzZoM1CybvZs3mKLmjFKxopVmZ
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This patch mini-series supports Git for Windows' main strategy to
determine the current user's home directory by looking at the
environment variable HOME, falling back to HOMEDRIVE and HOMEPATH, and
if these variables are also unset, to USERPROFILE.

This strategy is a quick method to determine the home directory, and it
also allows users to override the home directory easily (e.g. in case
that their real home directory is a network share that is not all that
well handled by some commands such as cmd.exe's cd command).

Sorry for sending out v3 sooooo late...!

Changes since v2:
- Using `getenv()` and `cygwin_create_path()` instead of the
  `GetEnvironmentVariableW()`/`cygwin_conv_path()` dance
- Adjusted the documentation to drive home that this only affects the
  _current_ user's home directory
- Using the `PUSER_INFO_3` variant of `get_home()`
- Adjusted the commit messages
- Added another patch, to support "ad-hoc cloud accounts"

Johannes Schindelin (3):
  Allow deriving the current user's home directory via the HOME variable
  Respect `db_home` setting even for SYSTEM/Microsoft accounts
  Respect `db_home: env` even when no uid can be determined

 winsup/cygwin/local_includes/cygheap.h |  3 +-
 winsup/cygwin/uinfo.cc                 | 54 ++++++++++++++++++++++++--
 winsup/doc/ntsec.xml                   | 22 +++++++++++
 3 files changed, 75 insertions(+), 4 deletions(-)

Range-diff:
1:  047fe1d78c ! 1:  6f8fe89d9d Allow deriving the current user's home dir=
ectory via the HOME variable
    @@ Metadata
      ## Commit message ##
         Allow deriving the current user's home directory via the HOME var=
iable

    -            * uinfo.cc (cygheap_pwdgrp::get_home): Offer an option in
    -            nsswitch.conf that let's the environment variable HOME (o=
r
    -            HOMEDRIVE & HOMEPATH, or USERPROFILE) define the home
    -            directory of the current user.
    -
    -            * ntsec.xml: Document the `env` schema.
    -
    -    Detailed comments:
    -
    -    In the context of Git for Windows, it is a well-established techn=
ique
    -    to let the `$HOME` variable define where the current user's home
    -    directory is, falling back to `$HOMEDRIVE$HOMEPATH` and `$USERPRO=
FILE`.
    +    This patch hails from Git for Windows (where the Cygwin runtime i=
s used
    +    in the form of a slightly modified MSYS2 runtime), where it is a
    +    well-established technique to let the `$HOME` variable define whe=
re the
    +    current user's home directory is, falling back to `$HOMEDRIVE$HOM=
EPATH`
    +    and `$USERPROFILE`.

         The idea is that we want to share user-specific settings between
    -    programs, whether they be Cygwin, MSys2 or not.  Unfortunately, w=
e
    +    programs, whether they be Cygwin, MSYS2 or not.  Unfortunately, w=
e
         cannot blindly activate the "db_home: windows" setting because in=
 some
         setups, the user's home directory is set to a hidden directory vi=
a an
         UNC path (\\share\some\hidden\folder$) -- something many programs
    -    cannot handle correctly, e.g. cmd.exe and other native Windows
    +    cannot handle correctly, e.g. `cmd.exe` and other native Windows
         applications that users want to employ as Git helpers.

         The established technique is to allow setting the user's home dir=
ectory
    -    via the environment variables mentioned above.  This has the addi=
tional
    -    advantage that it is much faster than querying the Windows user d=
atabase.
    +    via the environment variables mentioned above: `$HOMEDRIVE$HOMEPA=
TH` or
    +    `$USERPROFILE`.  This has the additional advantage that it is muc=
h
    +    faster than querying the Windows user database.

         Of course this scheme needs to be opt-in.  For that reason, it ne=
eds
         to be activated explicitly via `db_home: env` in `/etc/nsswitch.c=
onf`.

         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

    - ## winsup/cygwin/cygheap.h ##
    -@@ winsup/cygwin/cygheap.h: public:
    + ## winsup/cygwin/local_includes/cygheap.h ##
    +@@ winsup/cygwin/local_includes/cygheap.h: public:
          NSS_SCHEME_UNIX,
          NSS_SCHEME_DESC,
          NSS_SCHEME_PATH,
    @@ winsup/cygwin/uinfo.cc: fetch_from_path (cyg_ldap *pldap, PUSER_INF=
O_3 ui, cygps
        return ret;
      }

    -+static size_t
    -+fetch_env(LPCWSTR key, char *buf, size_t size)
    -+{
    -+  WCHAR wbuf[32767];
    -+  DWORD max =3D sizeof wbuf / sizeof *wbuf;
    -+  DWORD len =3D GetEnvironmentVariableW (key, wbuf, max);
    -+
    -+  if (!len || len >=3D max)
    -+    return 0;
    -+
    -+  len =3D sys_wcstombs (buf, size, wbuf, len);
    -+  return len && len < size ? len : 0;
    -+}
    -+
     +static char *
     +fetch_home_env (void)
     +{
    -+  char home[32767];
    -+  size_t max =3D sizeof home / sizeof *home, len;
    ++  tmp_pathbuf tp;
    ++  char *p, *q;
    ++  const char *home, *home_drive, *home_path;
     +
    -+  if (fetch_env (L"HOME", home, max)
    -+      || ((len =3D fetch_env (L"HOMEDRIVE", home, max))
    -+        && fetch_env (L"HOMEPATH", home + len, max - len))
    -+      || fetch_env (L"USERPROFILE", home, max))
    -+    {
    -+      tmp_pathbuf tp;
    -+      cygwin_conv_path (CCP_WIN_A_TO_POSIX | CCP_ABSOLUTE,
    -+	  home, tp.c_get(), NT_MAX_PATH);
    -+      return strdup(tp.c_get());
    -+    }
    ++  if ((home =3D getenv ("HOME"))
    ++      || ((home_drive =3D getenv ("HOMEDRIVE"))
    ++	  && (home_path =3D getenv ("HOMEPATH"))
    ++	  // concatenate HOMEDRIVE and HOMEPATH
    ++          && (home =3D p =3D tp.c_get ())
    ++	  && (q =3D stpncpy (p, home_drive, NT_MAX_PATH))
    ++          && strlcpy (q, home_path, NT_MAX_PATH - (q - p)))
    ++      || (home =3D getenv ("USERPROFILE")))
    ++    return (char *) cygwin_create_path (CCP_WIN_A_TO_POSIX, home);
     +
     +  return NULL;
     +}
    @@ winsup/cygwin/uinfo.cc: cygheap_pwdgrp::get_shell (PUSER_INFO_3 ui,=
 cygpsid &sid
     +	case NSS_SCHEME_ENV:
      	  break;
      	case NSS_SCHEME_DESC:
    - 	  shell =3D fetch_from_description (ui->usri3_comment, L"shell=3D\"=
", 7);
    + 	  if (ui)
     @@ winsup/cygwin/uinfo.cc: cygheap_pwdgrp::get_gecos (cyg_ldap *pldap=
, cygpsid &sid, PCWSTR dom,
      		sys_wcstombs_alloc (&gecos, HEAP_NOTHEAP, val);
      	    }
    @@ winsup/cygwin/uinfo.cc: cygheap_pwdgrp::get_gecos (PUSER_INFO_3 ui,=
 cygpsid &sid
     +	case NSS_SCHEME_ENV:
      	  break;
      	case NSS_SCHEME_DESC:
    - 	  gecos =3D fetch_from_description (ui->usri3_comment, L"gecos=3D\"=
", 7);
    + 	  if (ui)

      ## winsup/doc/ntsec.xml ##
     @@ winsup/doc/ntsec.xml: schemata are the following:
    @@ winsup/doc/ntsec.xml: schemata are the following:
     +	      <literal>USERPROFILE</literal>, in that order).  This is fast=
er
     +	      than the <term><literal>windows</literal></term> schema at th=
e
     +	      expense of determining only the current user's home directory
    -+	      correctly.</listitem>
    ++	      correctly.  This schema is skipped for any other account.
    ++	      </listitem>
     +  </varlistentry>
      </variablelist>

    @@ winsup/doc/ntsec.xml: of each schema when used with <literal>db_hom=
e:</literal>
     +	      <literal>USERPROFILE</literal>, in that order).  This is fast=
er
     +	      than the <term><literal>windows</literal></term> schema at th=
e
     +	      expense of determining only the current user's home directory
    -+	      correctly.</listitem>
    ++	      correctly.  This schema is skipped for any other account.
    ++	      </listitem>
     +  </varlistentry>
        <varlistentry>
          <term><literal>@ad_attribute</literal></term>
2:  90c5b45fbe ! 2:  1b4ee89aa7 Respect `db_home` setting even for the SYS=
TEM account
    @@ Metadata
     Author: Johannes Schindelin <johannes.schindelin@gmx.de>

      ## Commit message ##
    -    Respect `db_home` setting even for the SYSTEM account
    +    Respect `db_home` setting even for SYSTEM/Microsoft accounts

    -    We should not blindly set the home directory of the SYSTEM accoun=
t to
    -    /home/SYSTEM, especially not when that value disagrees with what =
is
    -    configured via the `db_home` line in the `/etc/nsswitch.conf` fil=
e.
    -
    -    This fixes https://github.com/git-for-windows/git/issues/435
    +    We should not blindly set the home directory of the SYSTEM accoun=
t (or
    +    of Microsoft accounts) to /home/SYSTEM, especially not when that =
value
    +    disagrees with what is configured via the `db_home` line in the
    +    `/etc/nsswitch.conf` file.

         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

    @@ winsup/cygwin/uinfo.cc: pwdgrp::fetch_account_from_windows (fetch_u=
ser_arg_t &ar
     -	acc_type =3D SidTypeWellKnownGroup;
     +	{
     +	  acc_type =3D SidTypeWellKnownGroup;
    -+	  home =3D cygheap->pg.get_home (pldap, sid, dom, domain, name,
    ++	  home =3D cygheap->pg.get_home ((PUSER_INFO_3) NULL, sid, dom, nam=
e,
     +				       fully_qualified_name);
     +	}
    -       switch (acc_type)
    -       	{
    +       switch ((int) acc_type)
    + 	{
      	case SidTypeUser:
-:  ---------- > 3:  4d90319e44 Respect `db_home: env` even when no uid ca=
n be determined

base-commit: a68e99f8839e4697790077c8a77b506d528cc674
Published-As: https://github.com/dscho/msys2-runtime/releases/tag/home-env=
-cygwin-v3
Fetch-It-Via: git fetch https://github.com/dscho/msys2-runtime home-env-cy=
gwin-v3

=2D-
2.38.0.rc0.windows.1

