Return-Path: <SRS0=deyK=7U=gmx.de=johannes.schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by sourceware.org (Postfix) with ESMTPS id 4F971385840A
	for <cygwin-patches@cygwin.com>; Tue, 28 Mar 2023 08:17:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4F971385840A
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1679991429; i=johannes.schindelin@gmx.de;
	bh=ihXJCrAfuvlZntWvSaJ19SK3Oi6j1YNFJIvnzkj3Lho=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
	b=sGCWIr1Tkuw6hBGP3eXiggkql9abiByd5efpYMXDriAn0nD+uJBpjXXNUO93Upb1N
	 XAZ95rXzh+wnO45hMh+/JtDlcAu8QH4ijzIHgDouQej8lEh8rgw+VdHVCKU3ABKs5s
	 OQFOBxBobwR0BxMAt/Ol0RJkyfakTLNiA0GPNuCx0+0NZAkOrnj4540U4pfIWfZdub
	 FLhy6gETJUN1Cjp9Mgv9EZCCd/0Bz7of50xYx2cedLiTzcpPvO4Uv4hvgUCLNSZOH3
	 4ifLFiyujj/B+Od4IUAWw4ej0WIhMqnxa2mTwbTuNiWNdb3ZDJDjYbdNYvjc2JLzvo
	 +Kaw6FVq3ssWw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.93]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUGiJ-1ppd7W1sR9-00RGRc for
 <cygwin-patches@cygwin.com>; Tue, 28 Mar 2023 10:17:09 +0200
Date: Tue, 28 Mar 2023 10:17:07 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH v4 0/3] Support deriving the current user's home directory
 via HOME
In-Reply-To: <cover.1663761086.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1679991274.git.johannes.schindelin@gmx.de>
References: <cover.1663761086.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:obXpIsZ4Q0i69BYKR+jBFnxflQRLJLpmE21N017Q8Emb4Ep+aQT
 twjDdo7RZnuLaa9Kd2G4yuxkayicpIjDouQrdPHjEtz7bIbNY7fBzyu16xbYp8RPNTQZodr
 NIPC0+A6WyFiKhbpwkGnpm+HD/vLKFQmKzIQoyd/q3Krr1a/D+f/9TQDdirnSfyBazuoVtg
 S/Gsa73BGSe7lOg8P4jAQ==
UI-OutboundReport: notjunk:1;M01:P0:xmz6AJEJ6iM=;c5ieIw6fYlZcx4FWoMy4L9Bi/qx
 Q7GoxLClk31U1S+Bt24qCnZ5mL5F5g2qbCr7oOK/M1ohaFgSpb79wvSLYyD1aPXSarXnkKfhs
 FbYz82K+d4fb/y63v2qIINEhaOd6yKidXkpkxfwVIxFShA8v13QkG89Mf2qxJoFOwQGc0qVx8
 ivD7cNtrj2JODxWjWouP+HRNgp93Oxq9Ea06o81kpbp4SnmakgrWBnt0Df+cblu8k2BOOeufN
 2XY+0X6SzD09miEL7vodz0Qwkv241dhjX6USogVnYm5NMdJZcbJNBlSvZrkKUvTyFj9blsSSG
 EAcsxXpT9CSppScQ2e6mHlalUNWFcYJEmYNqsAjw2BMo0SiNb3D74YauaABJY9hBQc2d0c0is
 ofHXk1+lOk6IwTd5sT2HM5CRbtkyhLrmvj1UZusDuz8pSSf6FQibwUPanvOvlsJKIkt+leKed
 gMN5qvUeOtr+0c7104kE52nZRF/zxUQN32RnDZZzl4ooq1OdxMSE1MIZxCdNFS9vZ4f4uenGP
 qqTVyzRUp3Z6I/CI++cSknWBOkIyg5Jp+LqPrtCmP7H/C68dtRHdkmt6Drev9JF7pSYcfsjKt
 d6hOiSUgOo6S9SPGENny91JgZBxBMjDK5WSQUXs9INtPzWYu684ARAAsrNEbcM5ZxuqZkBuMC
 bgvMs0ygzQsHzJjPDsgMhKzxoFBsfTaQh43kMMWHyG9szPI1Q/oZ05wvB4qmYtWMNnUS606V/
 ic1oiOnBUW8R+Sh6q5bJMsBc94W2Vfw6Rp9UYMhPGsBVo2kP2y6cZFjEIzFHCmQhjo1RCau0a
 mljK9zooTpIWz17bAGzkTcliwgzEhxKhUFFGNHaJP/IsyMnvX4W2EwGyOzoPMmmHdODWh4vlF
 6OTf7qnAteaEUx7bdz2juDVnkI8RrdcanQKgxmDryF4bOdAeMSm3cnI3t3OdRptpJt7/4mpKc
 g+jSwc2RehhVXyKp+tbXDvt8irU=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This patch mini-series supports Git for Windows' default strategy to
determine the current user's home directory by looking at the
environment variable HOME, falling back to HOMEDRIVE and HOMEPATH, and
if these variables are also unset, to USERPROFILE.

This strategy is a quick method to determine the home directory,
certainly quicker than looking at LDAP, even more so when a domain
controller is unreachable and causes long hangs in Cygwin's startup.

This strategy also allows users to override the home directory easily
(e.g. in case that their real home directory is a network share that is
not all that well handled by some commands such as cmd.exe's cd
command).

Sorry for sending out v4 sooooo late...!

Changes since v3:

- Fixed the bug in v2 where `getenv("HOME")` would convert the value to
  a Unix-y path and the `fetch_home_env()` function would then try to
  convert it _again_.

- Disentangled the logic in `fetch_home_env()` instead of doing
  everything in one big, honking, unreadable `if` condition.

- Commented the code in `fetch_home_env()`.

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
 winsup/cygwin/uinfo.cc                 | 70 ++++++++++++++++++++++++--
 winsup/doc/ntsec.xml                   | 22 ++++++++
 3 files changed, 91 insertions(+), 4 deletions(-)

Range-diff:
1:  6f8fe89d9d ! 1:  7a074997ea Allow deriving the current user's home dir=
ectory via the HOME variable
    @@ winsup/cygwin/uinfo.cc: fetch_from_path (cyg_ldap *pldap, PUSER_INF=
O_3 ui, cygps
     +static char *
     +fetch_home_env (void)
     +{
    -+  tmp_pathbuf tp;
    -+  char *p, *q;
    -+  const char *home, *home_drive, *home_path;
    ++  /* If `HOME` is set, prefer it */
    ++  const char *home =3D getenv ("HOME");
    ++  if (home)
    ++    return strdup (home);
    ++
    ++  /* If `HOME` is unset, fall back to `HOMEDRIVE``HOMEPATH`
    ++     (without a directory separator, as `HOMEPATH` starts with one).=
 */
    ++  const char *home_drive =3D getenv ("HOMEDRIVE");
    ++  if (home_drive)
    ++    {
    ++      const char *home_path =3D getenv ("HOMEPATH");
    ++      if (home_path)
    ++	{
    ++	  tmp_pathbuf tp;
    ++	  char *p =3D tp.c_get (), *q;
     +
    -+  if ((home =3D getenv ("HOME"))
    -+      || ((home_drive =3D getenv ("HOMEDRIVE"))
    -+	  && (home_path =3D getenv ("HOMEPATH"))
     +	  // concatenate HOMEDRIVE and HOMEPATH
    -+          && (home =3D p =3D tp.c_get ())
    -+	  && (q =3D stpncpy (p, home_drive, NT_MAX_PATH))
    -+          && strlcpy (q, home_path, NT_MAX_PATH - (q - p)))
    -+      || (home =3D getenv ("USERPROFILE")))
    ++	  q =3D stpncpy (p, home_drive, NT_MAX_PATH);
    ++	  strlcpy (q, home_path, NT_MAX_PATH - (q - p));
    ++	  return (char *) cygwin_create_path (CCP_WIN_A_TO_POSIX, p);
    ++	}
    ++    }
    ++
    ++  /* If neither `HOME` nor `HOMEDRIVE``HOMEPATH` are set, fall back
    ++     to `USERPROFILE`; In corporate setups, this might point to a
    ++     disconnected network share, hence this is the last fall back. *=
/
    ++  home =3D getenv ("USERPROFILE");
    ++  if (home)
     +    return (char *) cygwin_create_path (CCP_WIN_A_TO_POSIX, home);
     +
     +  return NULL;
2:  1b4ee89aa7 =3D 2:  a70c77dc8f Respect `db_home` setting even for SYSTE=
M/Microsoft accounts
3:  4d90319e44 ! 3:  4cd6ae7307 Respect `db_home: env` even when no uid ca=
n be determined
    @@ winsup/cygwin/uinfo.cc: fetch_from_path (cyg_ldap *pldap, PUSER_INF=
O_3 ui, cygps
     +		    break;
      		  w =3D wcpncpy (w, dom, we - w);
      		  if (w < we)
    - 		    *w++ =3D cygheap->pg.nss_separator ()[0];
    + 		    *w++ =3D NSS_SEPARATOR_CHAR;
     @@ winsup/cygwin/uinfo.cc: fetch_from_path (cyg_ldap *pldap, PUSER_IN=
FO_3 ui, cygpsid &sid, PCWSTR str,
      	      w =3D wcpncpy (w, name, we - w);
      	      break;

base-commit: a9a17f5fe51498b182d4a11ac48207b8c7ffe8ec
Published-As: https://github.com/dscho/msys2-runtime/releases/tag/home-env=
-cygwin-v4
Fetch-It-Via: git fetch https://github.com/dscho/msys2-runtime home-env-cy=
gwin-v4

=2D-
2.40.0.windows.1

