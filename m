Return-Path: <SRS0=TlDz=BL=gmx.de=johannes.schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id 6782C3858D35
	for <cygwin-patches@cygwin.com>; Mon, 22 May 2023 11:36:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6782C3858D35
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1684755389; i=johannes.schindelin@gmx.de;
	bh=aXuCU9qWmeKbHEZlg1nLDP6Yh9lZx5q7M5CbENBNEuI=;
	h=X-UI-Sender-Class:Date:From:To:Subject;
	b=Lqs4zwRWn0mWPYl7eEaQr1zF8KwMYkenz7eOSsd686EbAxgvuYAwKkqTtb7Ib5mIO
	 PAAM59HjOSBm/aw4kqhg43TI1blPDoAsgNr5RrXKl25BIIsuR4fvKCrie42txkF0RH
	 sWmmkYyJ4cDZCqQKxqkEouUzeQLWSFfX3d8QJzD+FsqANYcWLdWswm6EoCs3+A4RYO
	 mX8HIBaPHus85iNm0Z0ld3/pQikvuNuZozSlO3PXWBc+zVnKd45sSnlPOZx6rIKrFr
	 GA0f5Ll40kByiuybB1FGIlXeSWj2ViHTK3Ny6HcHwnzyJmOyDWSq4/VuzF3mjC674b
	 +7OVREBiVCpkw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.249]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Msq2E-1qGXLx0b96-00t8yM for
 <cygwin-patches@cygwin.com>; Mon, 22 May 2023 13:36:29 +0200
Date: Mon, 22 May 2023 13:36:27 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Adjust CWD magic to accommodate for the latest Windows
 previews
Message-ID: <60e1e112b1c293a69bfa4df3fe5094e562898bbb.1684755365.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bjiaI+aRbg5tkIzAmiA1FB8iKBme6llEBqpzOM6FdAJY8zwAd19
 yqwahKtEpaCdZyIzriNXckJdnWQg+L513dSma5zCEvlbZaGxlUucXpjFUz4Av3Vq62NVDld
 dj4nRX940xNgxF32zaEnWgPZT/hVSZ/qVOv1wKHU8WfGy0uQv15ZxDLAu4AVVq3gZgTPSJq
 6/+RhsSuGMogorhF/BJQQ==
UI-OutboundReport: notjunk:1;M01:P0:fh3188ZI3uM=;eQbzMcOi/udXBPDAZ8//qMjW39D
 KBeREYnYEQstDNBKtEGw5tB8lo6rODDIIZWxN1oU5WhLu5pBXDDYWmtfD2+avX9aOmm9TJw/T
 gFTCL69Wggn1JUk435n90SpX0KwSDd0bUwtDtzSJYBxKc7b3F8w/icAQuJNwq0H7Qzbfa1saX
 z0yNNf9FPlKP3QhOHaj6evRBOCMQg5mNucncawyZKjXVJ1WJ3Jqur/PDslWMQUedR6eoZGBjC
 DBlmkxyK9BU1/KcCo3i1vbtpweO2bYLneW3QiMa7EU39/aCbBfnzuVpQ16RQnAuycW5Iux301
 Ivbdh9O3QbNuIv1dd8vJVYV1Fh+BYaR1vZH2rnPmFyskfNzUH4rCq/oiEkj8IDCj+vHv7t2MG
 IDSxiAQe3ce7AvYr1jaTO7GTuF2A4pUErM3vXPhfcWN9ZZ1JZm8F9eSv2JPQBAKeve6pKv7JA
 7Hnz+l3nlu7TFdIEeegEZXXo0qLA+WAQS4Nm/5upN2ucs2wUjCSTCed6mLoQoglVuYbdwpWN2
 UhDUCFYo9XvNAkODw7SEpndbDNYIA/MiVfCgueRc1rn+mLGeJB9W5f/lI04y78DkwoYgQiSsp
 ip+rRJZ/BYxd6WTFZ9UWrM4x7YaYgBWc8m8zu3CMtFUCnoQYND9bdmdlHd6JTXVCOifou6Voe
 juHUU0fs2iqlruCvt/72tOyqYsUZQSdu6tzeN+DLGB9C1xYNhYgaG4DKpMwBDAlwzpKXBOTVO
 z7kuQR38a1zm2J6bh5wHKeFI+RrBG+oKH+L0nDhpS0dQp+oNpCK7KFqHomOzX01yAENb1or7p
 G0mV2lnPh+emZijmtPh7jQbYUhKh0plP6g8JJjWJWvwmJr0YLTJ7pc4jNHfV3cAmn4N0XD878
 8BFG3GvL2oQ/V2WzrBQPTXVmCH57nD6XUsW36D7rM6zTc4P6BOhrQFiFd+x7cVuyxaSn430gV
 FHEgTFk9R1hGm62NSLtrJEeJ1AY=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Reportedly Windows 11 build 25*** from Insider changed the current
working directory logic a bit, and Cygwin's "magic" (or:
"technologically sufficiently advanced") code needs to be adjusted
accordingly.

This fixes https://github.com/git-for-windows/git/issues/4429

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
Published-As: https://github.com/dscho/msys2-runtime/releases/tag/adjust-c=
ygwin-cwd-magic-to-newest-windows-v1
Fetch-It-Via: git fetch https://github.com/dscho/msys2-runtime adjust-cygw=
in-cwd-magic-to-newest-windows-v1

 winsup/cygwin/path.cc | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index 582238d150..fd09e5dc78 100644
=2D-- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -4514,10 +4514,24 @@ find_fast_cwd_pointer ()
 	     or, then `mov %r12,%rcx', then `callq RtlEnterCriticalSection'. */
 	  lock =3D (const uint8_t *) memmem ((const char *) use_cwd, 80,
 					   "\x4c\x8d\x25", 3);
-	  if (!lock)
-	    return NULL;
 	  call_rtl_offset =3D 14;
 	}
+
+      if (!lock)
+	{
+	  /* A recent Windows Preview calls `lea rel(rip),%r13' then
+	     some unrelated instructions, then `callq RtlEnterCriticalSection'.
+	     */
+	  lock =3D (const uint8_t *) memmem ((const char *) use_cwd, 80,
+					   "\x4c\x8d\x2d", 3);
+	  call_rtl_offset =3D 24;
+	}
+
+      if (!lock)
+	{
+	  return NULL;
+	}
+
       PRTL_CRITICAL_SECTION lockaddr =3D
         (PRTL_CRITICAL_SECTION) (lock + 7 + peek32 (lock + 3));
       /* Test if lock address is FastPebLock. */

base-commit: e7858c0a585e29c48a4109933423a0de362fc62d
=2D-
2.41.0.rc0.windows.1
