Return-Path: <SRS0=8XOt=CP=gmx.de=johannes.schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by sourceware.org (Postfix) with ESMTPS id D429D3858D28
	for <cygwin-patches@cygwin.com>; Tue, 27 Jun 2023 20:51:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D429D3858D28
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1687899092; x=1688503892; i=johannes.schindelin@gmx.de;
 bh=y58zIjzjLHB1zEuux4lVvPPzCxaY/sbEY4Dcgjx7Gic=;
 h=X-UI-Sender-Class:Date:From:To:Subject;
 b=ee+O4KfHgG6kLK/8Rg8IBgeq9fRuhRqz0vu4GIG9Y8IzDYhpsQZlcu+11iLR792Tna7V2tN
 dkAE5ivYqdXpJ9Rkt8PLMXgNzMApMvxPuApOPEh4nH3JxZAt1SUrozVesKTLHmNgtPMcRgIBF
 75/ysrpdDCEQurFvSfc0PzTdckq2tF5sSZ4MnC5zYTcfIfTJZ9B4BZXgWu78npgkmglGGVtH0
 zwZLBkzz/vyjgB3FTFSptfSfl+RUQsDwpvLfhszLMarMkkA/grOjs7RrJqOj+jhQ1XGBDw0Hj
 ud9U9Za6V1WgkqrnkJ7hqcMxOrNkrG6H0yJsuI7lDKA3yc4zkVIg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.221]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOzSu-1qQIKO1pZU-00PPJQ for
 <cygwin-patches@cygwin.com>; Tue, 27 Jun 2023 22:51:32 +0200
Date: Tue, 27 Jun 2023 22:51:30 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH] fchmodat/fstatat: fix regression with empty `pathname`
Message-ID: <c985ab15b28da4fe6f28da4e20236bc0feb484bd.1687898935.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1qQ16Ytb1aZoGDmUw3jH77nOGoMH+N480OUN6fH4mU19Jd8uaCO
 nCVyBYjJImJQ6G9Ujrc9xQfvWOZC9iAPlt3p2zJ1/nyFNbkLYGoT2Ld1efLDJCayeCQMZF2
 IWHpD3BBy5FWcpzaJwBZ33KW6t6zzZIcFMI5hdwBpSnSkKpnVLP2QCuM3Owot2+1GNHpMgC
 2ED+Kk8NRQYV5vTNmaunA==
UI-OutboundReport: notjunk:1;M01:P0:rqLdYy5zudU=;L+8WoQ4MgJphfM1f7Iaqk1KMjqQ
 w5jlv2LwPo5894rXfgRuxsmFqNUEaIB8PAdDjqRQWZot2p6ihh8F+HfVt1WOCd9OhzARMNecQ
 LF4pG8uelr9YzZKLrV0cUUuwEJ4SN54xMGVqTu6ueCM7lu1mvnnZywG4bCYh7eZwCD5isIyUH
 30e56ghHa7V7lzzyRXBqx8/E/TmyjAOKi/3wwB3pOPFTKE1iwUqyao/kl78ir8o01uQhJY1gV
 aQ7K2LYNaL6pzxuRGbc2j5G0E7w2H9zMr+JkGFqY1H9ZWEPpV0rF2/HPyW3VG8mt7d3vNHyKH
 Tx136dl36gkPEVhleBFGWNumf1aHbVGx3Ur9EHA/XuP0SDKA2lvx1/g4Ijlpa0HZWFozPEwaQ
 jH5jaSi4elgC16DY84KQO4aeQH9F+4YeeJtOXO3GQ6gEMoaVD4VT9CZON7Mk9swqFCl4pY7qe
 +cQCYnCRX1jNS3IefQn3xtwpOofCypZUVg4aD/Xn0U4SwL1K3+qR9ymZUwdAeqxlCtNn1dydw
 fvOHFQFRc2MnmKh6YsqSY0lRFcTYGvW4MRG/ru1B/wpW6OlTkpJNf2LWBzfJwbDXHaqnDyvvF
 kUp3qO66w4KB1/fItW1D/jKmbINH72d8++oQMkTI0Fksm2oYNLghwLc0FNea1Qq2qhFqubpTk
 FQwHqdWCDPtOF7OUjnJPvluU5eI6KKxTX/F5TSbMCrxHXcarHz4OBhGl5yletgy4Z3EqYExKN
 aRcZI8r4UrAogTRdhaLRKRxPLgxt9/vFLSYyPgkOCjpDpag9xp5zBAJN5mmzAMSn2rFH0Jm0i
 P4S2g/MBAi6fP8FYWhLa5NjaJ5wzerNKDagr2EP2UziqhWWs183cTXr6lbCo7jWrTxaVvE2U2
 5uLFULF5h02IJhVq2BLZlRagRAtZ3EK7iEtEMCCeFjZgYdgMp6/qDUNsPKLFehiacuUg08k0M
 v4i0w+9Pt141OofkYWeFuSkq4nI=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

In 4b8222983f (Cygwin: fix errno values set by readlinkat, 2023-04-18)
the code of `readlinkat()` was adjusted to align the `errno` with Linux'
behavior.

To accommodate for that, the `gen_full_path_at()` function was modified,
and the caller was adjusted to expect either `ENOENT` or `ENOTDIR` in
the case of an empty `pathname`, not just `ENOENT`.

However, `readlinkat()` is not the only caller of that helper function.

And while most other callers simply propagate the `errno` produced by
`gen_full_path_at()`, two other callers also want to special-case empty
`pathnames` much like `readlinkat()`: `fchmodat()` and `fstatat()`.

Therefore, these two callers need to be changed to expect `ENOTDIR` in
case of an empty `pathname`, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
Published-As: https://github.com/dscho/msys2-runtime/releases/tag/fix-tar-=
xf-with-symlinks-cygwin-v1
Fetch-It-Via: git fetch https://github.com/dscho/msys2-runtime fix-tar-xf-=
with-symlinks-cygwin-v1

	I noticed this issue when one of my workflows failed consistently
	while trying to untar an archive containing a symbolic link and
	claiming this:

		Cannot change mode to rwxr-xr-x: Not a directory

	With this here fix, things start working as expected again.

 winsup/cygwin/syscalls.cc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 73343ecc1f..c1889aec91 100644
=2D-- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -4580,7 +4580,7 @@ fchownat (int dirfd, const char *pathname, uid_t uid=
, gid_t gid, int flags)
       int res =3D gen_full_path_at (path, dirfd, pathname);
       if (res)
 	{
-	  if (!(errno =3D=3D ENOENT && (flags & AT_EMPTY_PATH)))
+	  if (!((errno =3D=3D ENOENT || errno =3D=3D ENOTDIR) && (flags & AT_EMP=
TY_PATH)))
 	    __leave;
 	  /* pathname is an empty string.  Operate on dirfd. */
 	  if (dirfd =3D=3D AT_FDCWD)
@@ -4625,7 +4625,7 @@ fstatat (int dirfd, const char *__restrict pathname,=
 struct stat *__restrict st,
       int res =3D gen_full_path_at (path, dirfd, pathname);
       if (res)
 	{
-	  if (!(errno =3D=3D ENOENT && (flags & AT_EMPTY_PATH)))
+	  if (!((errno =3D=3D ENOENT || errno =3D=3D ENOTDIR) && (flags & AT_EMP=
TY_PATH)))
 	    __leave;
 	  /* pathname is an empty string.  Operate on dirfd. */
 	  if (dirfd =3D=3D AT_FDCWD)

base-commit: 4c7d0dfec5793cbf5cf3930b91f930479126d8ce
=2D-
2.41.0.windows.1
