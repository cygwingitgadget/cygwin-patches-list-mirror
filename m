Return-Path: <SRS0=TlDz=BL=gmx.de=johannes.schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id 63EBD3858D35
	for <cygwin-patches@cygwin.com>; Mon, 22 May 2023 11:12:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 63EBD3858D35
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1684753951; i=johannes.schindelin@gmx.de;
	bh=ZvSkuOSxZ6vWvAc5I33N+GnbwkJNiB/IztUDNRZ3uEI=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
	b=qHUHclQv100wmghALrOBHBDUZwdpLEqMB0hJ/AL2PCme2HSOEjeRkOQ9SDoFxmqVk
	 QTDfOYmlCylBe2Lw31Vfjggo6WjyAiYXtCdr69n+sS0cOC0iVIi0xXfzICiEc8QDPM
	 ofo2Mnzz3qifEI7CjYKmBWOUxLA9EJUSZ1Ip47mTiA34HTDRKdbQ05ToA6s0nOyuZK
	 lQsVioX/tk/EJpqfiZYI1OV9sR5BhN8GV+1jofPWNFgZLtV8PqnyP0L3tiGroyOW/f
	 rRWpgEWOzvT1hH8cNmCEEO1tCHJ8NGgAtgyF5cNWkUno30NkYMgeDbRt1LCjwlErNa
	 E323tiaAIA4GA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.249]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQvCv-1po4e805Pr-00NwXb for
 <cygwin-patches@cygwin.com>; Mon, 22 May 2023 13:12:31 +0200
Date: Mon, 22 May 2023 13:12:29 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH v7 0/4] Support deriving the current user's home directory
 via HOME
In-Reply-To: <cover.1680620830.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1684753872.git.johannes.schindelin@gmx.de>
References: <cover.1680620830.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:g9X1FbMyFgFbDv3FT9lGO6PmCTm6CKgXNeJfTaFjf6NRZKEnmmI
 dfaFn8nNeWRNcQG8aDXVCFsNAjQpekvaecwHLMERNpj3+TDUxIOMbqhnMUTukLgCguH5TvN
 CqiAhExDTV4HrOmCgAehfIWZw1QKiiNY5jS7gtuaTBV96NRiZaRUUC4o69yfNIHhJ8jdvzt
 hmNBuB6nlud1XYpNPdv6w==
UI-OutboundReport: notjunk:1;M01:P0:PdB2Nii/TZg=;teQv381YI7exIihy4elVqt+tDMX
 irEXfJMIMqQ9Zn006oq6bjvsWOvOFJ8POe6JKpTc8A8/VcBaOuPwxLa+y8fUiLV4dFRHRVlqD
 MEZ82svCR4DOrWNeRfumQvHecmjnkFQEarZC/pOI0vFUq4fPJrQ0napbDeqpi8ih8l9VRqH93
 E+FbDpacDNBYamGrshTYa7MJzHHd2oxxy5rjiVk8uO2HgWaTv+r9SRlWL0xA2diqOPvAHA6b7
 9VxDQWz39WLw1uuQ0BN/0nQylsv/p+mEX4bLQzZe68yXnPykQDtrobGvVwQ+KNAHLeOj3MhFZ
 jKz8yJR6WKTyiIiLM7J3CJ0mx83XFuxesFXt2DTRUFrc7EnJFoKlFAiExI1hNpEETHKNzIgww
 DJsNeYRnSywPuVlH4U2TD0VI9NLYml0nqhImK5ltFnksfssFK1N+sIIx1MW3rDSq9V6mXnXgT
 y1kv0q92A0N3n3MFZYKIJlmFhnWanFD4CDzBdvJo3LbICc2CIHusOyun63yKzYhTApdgFN7uf
 9nq9cAW1A10JTe4B6C9621oZOvWsLDS29oKXj82BLnsQQr510PxQAYx5iPgu7fO5qJtPFxrr1
 DlX9Jgc2apMfQ800ZIF+z1My0/jzFiOMz0Z1Zj7F89xl8VE77Re5Bwq2tvhtgOTtNdEkN7AAX
 DPWXMA0AdllpvPt8BjX2auXSTXK4MQFBpUt0JpOKkpzFyiziz5+jWfXpfMc1JpIyfFpVtk42/
 On9OgbgkdhhS8jrMBwA0sW2BbVedxOs+oVTGqCdyDKOlZftFfhHUx53Q2q9M+QxcMyFOL+lcJ
 BR91Ix7NGi561zQsuD/2EghS3Jztd98rSx/2/Bj/7E7+n7nPdV0eEONVkglkmzy2nK7fIUyNj
 nsQvtxeJ4ippFv2P0z9+ehg45HqqiVcrENuRhJ0ZloePld6APiAgnPpueBNntevWPMurOWNQ9
 zrQ2/A==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

NOTE! This iteration presents patches 1 & 2 only for completeness' sake
and for backporting, as they have been applied to Cygwin's main branch
already.

This patch series supports Git for Windows' default strategy to
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

Changes since v6:

- Fixed a typo in the last commit's message.

- Support UNC paths as `HOME` values, too. (Tested, works beautifully, I
  can now share my WSL home directory with Cygwin.)

Changes since v5:

- Replaced the third patch by a patch that imitates AzureAD account
  handling also for IIS APPPPOOL ones.

- Added a fourth patch to fix a bug in the first patch (which
  unfortunately was already applied in the buggy form) where _very
  early_ calls to `internal_pwsid ()` would result in completely bogus
  home directory values.

Changes since v4:

- Squashed in Corinna's documentation fixes (read: patch 1 should not be
  applied to Cygwin's main branch, it's presented here for backporting
  purposes).

- Fixed the commit message of the second patch that mistakenly claimed
  that Microsoft accounts would be associated with `/home/SYSTEM`.

- Completely overhauled the commit message of the third patch to motivate
  much better why this fix is needed.

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

Johannes Schindelin (4):
  Allow deriving the current user's home directory via the HOME variable
  Respect `db_home` setting even for SYSTEM/Microsoft accounts
  uinfo: special-case IIS APPPOOL accounts
  Do not rely on `getenv ("HOME")`'s path conversion

 winsup/cygwin/local_includes/cygheap.h |   3 +-
 winsup/cygwin/uinfo.cc                 | 170 +++++++++++++++++++++++--
 winsup/doc/ntsec.xml                   |  20 ++-
 3 files changed, 181 insertions(+), 12 deletions(-)

Range-diff:
1:  e26cae9439 =3D 1:  e26cae9439 Allow deriving the current user's home d=
irectory via the HOME variable
2:  085d4dd8b6 =3D 2:  085d4dd8b6 Respect `db_home` setting even for SYSTE=
M/Microsoft accounts
3:  9b79624368 =3D 3:  9b79624368 uinfo: special-case IIS APPPOOL accounts
4:  8ac1548b92 ! 4:  002d94a244 Do not rely on `getenv ("HOME")`'s path co=
nversion
    @@ Commit message
         look at the environment variable `HOME` and use it, if set.

         When all of this happens, though, the `pinfo_init ()` function ha=
s had no
    -    change to run yet (and therefore, `environ_init ()`). At this sta=
ge,
    +    chance to run yet (and therefore, `environ_init ()`). At this sta=
ge,
         therefore, `getenv ()`'s `findenv_func ()` call still finds `gete=
arly ()`
         and we get the _verbatim_ value of `HOME`. That is, the Windows f=
orm.
         But we need the "POSIX" form.
    @@ Commit message
         Let's detect when the `HOME` value is still in Windows format in
         `fetch_home_env ()`, and convert it in that case.

    +    For good measure, interpret this "Windows format" not only to inc=
lude
    +    absolute paths with drive prefixes, but also UNC paths.
    +
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

      ## winsup/cygwin/uinfo.cc ##
    @@ winsup/cygwin/uinfo.cc: fetch_home_env (void)
     +    {
     +      /* In the very early code path of `user_info::initialize ()`, =
the value
     +         of the environment variable `HOME` is still in its Windows =
form. */
    -+      if (isdrive (home))
    ++      if (isdrive (home) || home[0] =3D=3D '\\')
     +	return (char *) cygwin_create_path (CCP_WIN_A_TO_POSIX, home);
     +      return strdup (home);
     +    }

base-commit: a9a17f5fe51498b182d4a11ac48207b8c7ffe8ec
Published-As: https://github.com/dscho/msys2-runtime/releases/tag/home-env=
-cygwin-v7
Fetch-It-Via: git fetch https://github.com/dscho/msys2-runtime home-env-cy=
gwin-v7

=2D-
2.41.0.rc0.windows.1

