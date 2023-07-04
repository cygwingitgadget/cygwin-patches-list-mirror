Return-Path: <SRS0=st34=CW=gmx.de=johannes.schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id E5AA83858D35
	for <cygwin-patches@cygwin.com>; Tue,  4 Jul 2023 15:34:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E5AA83858D35
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688484896; x=1689089696; i=johannes.schindelin@gmx.de;
 bh=q/1Oeq2bA4wGEouq0fcKWarj/59oqh/Kagnm+fg6K/g=;
 h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
 b=DdmSxJgo7rN/j3darkPUZbazUcKLjeHla+70YLY+2IxJBK5us+l4uQvKBBDprCXDgHoaMnZ
 XskAPlUxLmBk7gZCNnrl2tdlID0O48wXSa+lxw28vxg5EHOT5Ap/FLgP6YCdZBZh3cFDc672x
 GaCBbc2/2y/Q7p8ZdlYX4WJfUEzknGoKMApDTKrCEoKpXU2uIHrkKUgNUMxBjp82fdo+odrHl
 IuuTmDZTsqKZ9/iEBhSXCbtro83lXuu1WG1I2tIZp8+W9YIZ7MEfmHJqZldy7CFNBQthZGxDN
 No63lRDSgNQCYclxDyR5pEM9/R7q72VSTYxysAM+pYM3DfxPM+6g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.221]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCbIn-1q8hhD2Oqx-009knK for
 <cygwin-patches@cygwin.com>; Tue, 04 Jul 2023 17:34:56 +0200
Date: Tue, 4 Jul 2023 17:34:55 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2] fchmodat/fstatat: fix regression with empty `pathname`
In-Reply-To: <c985ab15b28da4fe6f28da4e20236bc0feb484bd.1687898935.git.johannes.schindelin@gmx.de>
Message-ID: <072b5c57a76c935d79a321526e0c60a1383d22c4.1688484863.git.johannes.schindelin@gmx.de>
References: <c985ab15b28da4fe6f28da4e20236bc0feb484bd.1687898935.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2LKzTPjNne919h0DBtpF/Ighhp0XLHUcFixZfZvURvt5qvWKU4r
 jkfdNrE4me27JghzfdoBwcfqC7VrdjPtr8IFaf4OX81mZtoPRhGIuTezvFPpH/pbn0L2yQm
 41YN+5nj1r2dTacobQ3+6uNaVGCXAkJsdxe7G1z4fRl4DljKupQglyeDN3+xf9OTNOHeqLK
 tXlJXz821NAYGIZHJbYRg==
UI-OutboundReport: notjunk:1;M01:P0:kxzAbqXbZBs=;wMwmMvfZ5ZsGhuMJbYqF53ZnmOI
 nEGMbnvAoS2hPy2y9I9Eqbc37BpnNROdMLH9VWRLLmaPBdRGqnp55w8rdpxUxu9ZJp/b4B40G
 h7Tx5z79AfRd6jYv7ygnf6DkwexeWkvspWeLJjx75yUEhH/tERkF2F8nqxDBk+F8fJxUxW4r6
 kge5yJwRWNP+qcRHZqEtH4ZMzbuyryirqf3L3g1G9Gqe8zaKTyyel2PyX3piIjUxW6XMHdvv4
 RmvSbV2P3wL8Y9gK9v4HzXnkTgTwW5446aPrymnw4Ttl4YfwwCiIdak0UonnDGSZxsbBBroev
 SYSVlIzk5TmQpN/AQuQHUbkrMwqiuwCJpAuFdNilC4SsW6oP1GffHHRr821EtaMbEx5tUcbTM
 jG/1pm2OW8xzolPr0prXKX88320sQMaiBRVbl56DKuVMRxuIEYaO9vNcPQ+5o8eY5C2poQiuG
 4UmCGHtUQav6gbqRcxCCm4QXCYj4jxhDDz8t8c3jGCaIE1Pfeh+qpOeIiRg+zMqomUqqaufy1
 son06u+9I1g1e3OUojXuQ0QiAmyT3tuqe6dxuAIbE6z7DyoYT43libAOg+PltncOLIR+Zz4gM
 bGDtIsU2bUmCPDXt4AtUKGkThFWIkWg1Hcp5E+jkXchG/hCP+VYaUWvS7915d9CYu+8Sp3RbZ
 en7HWyCD/QrRYol6FVwonjvC01INkVBTP+0GfQ7K91KDbq8wH9zPekpuCFQJYHRSft0T2izZd
 xW94/Jz9Bpy6QLaECY082RS4J8xqOdeV8jhfqBcqeZVyKd2/eR0z8tKO4bpPGXD61+fSNZijo
 gZIIVdIvcZfO/+Z05V58/8gdQXD4yfkWM8Exh3IN0nfYunGndpfyKLXc9eeiI3nl41HOH2y1o
 4ZuOlzTuSFjkU0Ptaq5uyPmB2RJO9rqpF2cUh6bpwtMZJGybQU97XKWb9cmGYYwVHtBS9DXJO
 phiXCXJtoNXSpoix+KsbAQbnz5w=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

I noticed this issue when one of my workflows failed consistently
while trying to untar an archive containing a symbolic link and
claiming this:

    Cannot change mode to rwxr-xr-x: Not a directory

With this here fix, things start working as expected again.

Fixes: 4b8222983f (Cygwin: fix errno values set by readlinkat, 2023-04-18)
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
Published-As: https://github.com/dscho/msys2-runtime/releases/tag/fix-tar-=
xf-with-symlinks-cygwin-v2
Fetch-It-Via: git fetch https://github.com/dscho/msys2-runtime fix-tar-xf-=
with-symlinks-cygwin-v2

Range-diff:
1:  c985ab15b2 ! 1:  072b5c57a7 fchmodat/fstatat: fix regression with empt=
y `pathname`
    @@ Commit message
         Therefore, these two callers need to be changed to expect `ENOTDI=
R` in
         case of an empty `pathname`, too.

    +    I noticed this issue when one of my workflows failed consistently
    +    while trying to untar an archive containing a symbolic link and
    +    claiming this:
    +
    +        Cannot change mode to rwxr-xr-x: Not a directory
    +
    +    With this here fix, things start working as expected again.
    +
    +    Fixes: 4b8222983f (Cygwin: fix errno values set by readlinkat, 20=
23-04-18)
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

      ## winsup/cygwin/syscalls.cc ##

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
