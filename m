Return-Path: <johannes.schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by sourceware.org (Postfix) with ESMTPS id 3F1E73A603EC
	for <cygwin-patches@cygwin.com>; Fri, 21 Oct 2022 21:43:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 3F1E73A603EC
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1666388572;
	bh=sXv72NViLqRvUOuG8U4+KZrvqDVsUkkr0k8Lj4+fmRU=;
	h=X-UI-Sender-Class:Date:From:To:Subject;
	b=NLt/hzTF0XzM3ZP01e2AmKZ3njV9AR8zv0QPMJBrI6Q01WtG89EP4fOl4No9lUwG2
	 XI7ZsFi8t8anpcQMPsBK0u0BRezuUKou0kkOBH3Mp3bClELc+2I75j4gBHd4IAUCZh
	 UfyW19wHdri2hUwEcnaCnRafjUoWOuyN3pZPHqx8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.192.185] ([213.196.212.100]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McpJq-1pKmYs0pyk-00ZwI6 for
 <cygwin-patches@cygwin.com>; Fri, 21 Oct 2022 23:37:36 +0200
Date: Fri, 21 Oct 2022 23:37:35 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Fix `Bad address` when running `cmd /c [...]`
Message-ID: <8rqs6n82-0oq9-2200-944n-74s7o699385o@tzk.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:6fe22EmOYDo0Ee56gF/IkfoVphxsE4eU5lPAwPnBPmBy9IpBV75
 +xaAl4GfGkVh1i5vbzpphzEhWFFh4fvmQs32jSK/d3ViL2Y/SFH9/6Oezm+3WaTBuVq4ATV
 MTybnLc/exx6rkO4UWog1WiClcLgb14SHaGXM3xgC53KedBIiUzm9nBkdUr7Xzbke2soNGy
 xpzwJ8MGYvNSK6A3r7F9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O/2vrr/DUZ4=:uybmlcqEn77meGYHYHMcm5
 innJw1EOYiqAerXTj6IpWGbm9qAXu8GZhD02V+SlQ5YYmwxhiijRFFnEe2VBwELmq9pZS824U
 l9T6y03dq2G8vzJQNYEMu2vZjp0JwNHBcPa7HRWlYS94vL0J1osZCXj+qyy4JH65cFheMN6hY
 Xce5BnzDFVDDoSY0JSNakf/QgnyHr4ZpkROPfOI+gmYRMCawrR5QgGlNj2hQNjk5Qy1Xd/aJt
 mwCBXOlgFJhoMXCEhfgiLTMQe68cAQUiIcjFVAL95BZT3wQye7Vh9Y3B8TB4gCSqFESlhfBDm
 i7oorNlOYTdneR4hoRZztr3tDN1YyZfBvm3Mkm98XnuPRLTpQu8hPxWDH+yInfaNvvntHCbLF
 zc+8Igp1Pnsqgo+EMhw+rXE9QdVVW9tfRUjdBVsHNYlbwTKMGSmJTMgjBmUlzCOLIODIwQ5qQ
 7KQoTBCI42NF/4avh3fTAbBqoz0Rwag1q6WJVnAluGziziRi4AM9p983ZbfS+U2vL22hSCg8q
 unqcHqeFc9i64YzwbJ88fRX1pa16iUvTywSt1Wy9/CKACzdQsIin24Wwz8E2hRS/j3wbiQ3D2
 Igskr8GdbiL3NiiLAMZF9bBrtZ/+IT+5FPNfVeOKoMhux/X8u8JdFyTGx5GvB3J2/ZylPPICK
 VsGxOqmDIMBeZ7XbZy6iGr02Lf59EcaBK1Umo/3RcWSd1ztNdWo6JAGZtgwU4SxNaAYtf9gwu
 u2wwpToGkCivmhA4p4gXk+ELiFclL8kDWvS5miuHW0kE8icc0aIUAlIHt+g6GOE+NNvOKK3zZ
 riwfwhI8gI0vwjSTIrYEY4ivvOm6i6KC11mQAm1s35hCKVyua+N5aefoUdD6yJ3CJ2i7/vSww
 UDv7YOc0c9/rC7iCSNS/I2GgsATdCHAdjR0Kdr2PmJl31jFWaErI5F/h7jihMFtdl8RU6VAcp
 I25t5+oZl9YZOvqNNlrwTGiGeZxpRkGOD8ENsCC+xj44haGu5AOTxGv4U65zICp0QWv14DcC9
 OMms6YudhMwAtMyjpUycsWVlGly76x4cXzTEEFdp+NLzSo31vH/b2jD3emdANM1adPaI1UFBN
 5S6gwXz9PnVjwf8/tsnEYy3FORVLvNPEYrg6FBQD0TDeUH4BXvguOzrqpYz8pgvtQxvzNRsAf
 /Q2pQ74w6HitBoxoyB1rXuzNYtVVNhUfJocL7OkUEb0P4g6e+2pPMmgX96K1ySQF6bZ4+ace1
 dxTOOzfSpeb5lLDz/uHK1Qg0vymKCqt4YaUVSoncklpKKNg3LVkpzuBTuTg4xp15UfVhlJwTj
 5I6LJWpcPpshlZOGj9ubf5MQ1iXodLKrnz+ccuOP9nPZwtY+CjC3NtXvNCKjKUai5xTC5PfLp
 VIuKQ+pbMH8pQLIoV48yMpEKal6GD7GTqXcj50sD13dGyDJ+nQ+BJPWszjmWLQJREExlUXIng
 mETR/w8M/BQZAH3LWToJu7Q1ZvoZvY04TvIxY37VFY6BmFnS8lSS5pDF5FAKkW02N3oRUcZ88
 heM8aI55TrZyZ0u7viTU53dJ9fh8aMFV9qFQfvR+O565RM/y+lAaNt1PQeWD3zN6FeQ==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

In 2b4f986e49 (Cygwin: pty: Treat *.bat and *.cmd as a non-cygwin
console app., 2022-07-31), we introduced a bug fix that specifically
looks for a suffix of the command's file name.

However, that file name might be set to `NULL`, namely when
`null_app_name =3D=3D true`, which is the case when we detected a
command-line `cmd /c [...]`.

But the commit mentioned above did not account for that possibility,
instead assuming that it always has to check the file name for a `.bat`
or `.cmd` suffix. As a consequence, `cmd /c [...]` invocations are
completely broken in v3.3.6, resulting in a `Bad address` error.

Let's guard the code properly so that it does not try to look at the
file name suffix of `(WCHAR *)NULL`.

This fixes https://github.com/msys2/msys2-runtime/issues/108

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
Published-As: https://github.com/dscho/msys2-runtime/releases/tag/fix-bad-=
address-in-cmd-invocation-v1
Fetch-It-Via: git fetch https://github.com/dscho/msys2-runtime fix-bad-add=
ress-in-cmd-invocation-v1

 winsup/cygwin/spawn.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index d9d7716519..d4e7f10e2b 100644
=2D-- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -209,7 +209,7 @@ is_console_app (WCHAR *filename)
   char *p =3D (char *) memmem (buf, n, "PE\0\0", 4);
   if (p && p + id_offset < buf + n)
     return p[id_offset] =3D=3D '\003'; /* 02: GUI, 03: console */
-  else
+  else if (filename)
     {
       wchar_t *e =3D wcsrchr (filename, L'.');
       if (e && (wcscasecmp (e, L".bat") =3D=3D 0 || wcscasecmp (e, L".cmd=
") =3D=3D 0))

base-commit: 1ca46b22d6edb3d469b51475e8b096d86deaac67
=2D-
2.38.1.windows.1
