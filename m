Return-Path: <SRS0=XVHH=55=gmx.de=johannes.schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id 8DF533858D33
	for <cygwin-patches@cygwin.com>; Wed,  1 Feb 2023 14:08:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8DF533858D33
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1675260499; bh=iT3Tl+0xRNfQCVnP7ZFzGmTnrz0MlTQE3XuSGTxYq/o=;
	h=X-UI-Sender-Class:Date:From:To:Subject;
	b=rfnfAFEg1xAVUggokPfi7eTsLJwpQxMzkme7wJHhazBW3okLD1sjCapA5m122SbN5
	 444jCtOtBxRjXsCsdWOGj5xu4NOXxiOgtgxHGyFcRJFigSGD1jetgxevuBNeYvnR3Z
	 rXrsw8An7tVrZhd+nP+p9QompSBATG4AgByHzijwDhPbIZNjQKbel0Xqk6XF5FSNqn
	 TNBg9F+vS2H8ZHX89s5AS8MW/YKqK4146xJxrKR4poPPwSsaLjaLhAwoLNlhesuWWe
	 hEym/wjJyTRU2n/1Ah0rsOEHrOnxwfyfBv/Y9Al/tLAgYPhtGJ0rrbNY8JnfvF7R9M
	 gxMtlJaUgYHcw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.128.75] ([89.1.215.7]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKsjH-1p4k633m2f-00LDwz for
 <cygwin-patches@cygwin.com>; Wed, 01 Feb 2023 15:08:18 +0100
Date: Wed, 1 Feb 2023 15:08:16 +0100 (CET)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH] dumper: avoid linker problem when `libbfd` depends on
 `libsframe`
Message-ID: <50ed771a961112edb5c4b69421d9ad8cecf7a7cb.1675260460.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:krfoaDVGp9Fd6AoKS6RAd+BsC+/yXWYWD8/TS4X/fAyPVOxh7Tr
 F6/cddb4qp6V4p4D42tGxo7vzi/HsMiwY8t4lMhjf2Fj0D12MROwsFGiRmOgIKa1k9oN7Or
 bkeC2+R0gA2//8gvGfH0Qclzh0ZuLEkr7+pX1XHNtOcymsh1SawC7FerkWP5/YId9c6LFqn
 k150/6bEhrNtpf8EEEDbQ==
UI-OutboundReport: notjunk:1;M01:P0:sTXTluiUFkQ=;p/hCSrd5rSeAoZIH3XSMm2qOV8G
 zvAj2ssDZWg6BoRMmvG43pcSjue8XphpYl9rwmlHvyRA+1cHwLjbCoTuubDmyu75HiOAZAtcy
 3zRPKM7aKbRqDHS7teai3EMhGTNuBjjRl1rDV/INb7xRO8P1FYb10JUxtZCwZm5vsw38Cfvni
 s2pajii8ZDByHLgZTSig3GDGtGf9U+xRYeJhb5MV6ZD8xVBWZrQBDkMU7BMd+mTi4bJTkMXBs
 +spsMWk8FgdFpZGqBUIS6BoH8Q7wrpLa2936u4PX4jSDHXJ1muEWdfSwUf7u2M7uUTMb4dhJ2
 WPvYYEQtQwarbrlElpopdPYBN8s8jYWQVabM0hT1LpMVyGVvpKS5XUTHTLo0k1CKB6tTeJpKZ
 kY0z38p1LNqwfuCvG3aondmmE8faypppzaH0W7yE0clgB3xlx9DPnCWlO7B8H2PD3pSaJYb9m
 Nmz284a7Xu2Efq9CBsv/pWe6jg66tEg3YdDmPWvT02H+ilVtxr04USpjbrMd6gxo3QDoMGPhh
 pKUg9ujzZgpkM6IrMEmW165CEvEDoa5xCLxDd6u517IIaUWltVnUnsKvUxqbWDEruvslTt92/
 ckOSaXF/Puol7Bm6JxfHpg6opVaZBB9p+wCPU6FEuAKzhNl2y6fKvB2YGqMyLu9p988K4lTik
 F55I1ph9aYDjsSOTmVxTpf1EbFl1p1C/jq/BwjlZY1jtFFX6HCTWz8wrt/D8Co9U58hpiFSGZ
 l4Ii1qOa3JlLGLoVXXwE88pvBkxMkMwGy3zz338tZMV6FiLE1FJH40ygdByEOnlKx1R3KuEyE
 o5FBVN7BEtiaRYbME6OHUzs5vEir66F+CArETJvAEAb+70Kna6pgbxmNldME2JHoAq1yH7m+C
 Pl8CMUkh0079soPwM9Nl6a0vZjNGTkkFqJ7dhGuEH4xdqFgvtoAvVuWrVJyPCt2ubtWnhBxR2
 jffZWXkUJW1uDLq6aAzqQeY4EnA=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

A recent binutils version introduced `libsframe` and made it a
dependency of `libbfd`. This caused a linker problem in the MSYS2
project, and once Cygwin upgrades to that binutils version it would
cause the same problems there.

Let's preemptively detect the presence of `libsframe` and if detected,
link to it in addition to `libbfd`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
Published-As: https://github.com/dscho/msys2-runtime/releases/tag/do-link-=
libsframe-if-available-v1
Fetch-It-Via: git fetch https://github.com/dscho/msys2-runtime do-link-lib=
sframe-if-available-v1

 winsup/configure.ac      | 5 +++++
 winsup/utils/Makefile.am | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/winsup/configure.ac b/winsup/configure.ac
index b155cabe43..76baf0a7da 100644
=2D-- a/winsup/configure.ac
+++ b/winsup/configure.ac
@@ -118,6 +118,11 @@ AC_ARG_ENABLE([dumper],

 AM_CONDITIONAL(BUILD_DUMPER, [test "x$build_dumper" =3D "xyes"])

+AC_CHECK_LIB([sframe], [sframe_decode],
+	     AC_MSG_NOTICE([Detected libsframe; Assuming that libbfd depends on =
it]), [true])
+
+AM_CONDITIONAL(HAVE_LIBSFRAME, [test "x$ac_cv_lib_sframe_sframe_decode" =
=3D "xyes"])
+
 AC_CONFIG_FILES([
     Makefile
     cygwin/Makefile
diff --git a/winsup/utils/Makefile.am b/winsup/utils/Makefile.am
index d4d56386f7..f59cf9f50c 100644
=2D-- a/winsup/utils/Makefile.am
+++ b/winsup/utils/Makefile.am
@@ -89,6 +89,10 @@ profiler_LDADD =3D $(LDADD) -lntdll
 cygps_LDADD =3D $(LDADD) -lpsapi -lntdll
 newgrp_LDADD =3D $(LDADD) -luserenv

+if HAVE_LIBSFRAME
+dumper_LDADD +=3D -lsframe
+endif
+
 if CROSS_BOOTSTRAP
 SUBDIRS =3D mingw
 endif

base-commit: 3a4c740f59c03b4c8346fa0ee8599b1c0582ae96
=2D-
2.39.1
