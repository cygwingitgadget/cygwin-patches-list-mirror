Return-Path: <SRS0=VaCb=ZG=gmx.de=johannes.schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by sourceware.org (Postfix) with ESMTPS id 9D3FE3851165
	for <cygwin-patches@cygwin.com>; Mon, 23 Jun 2025 12:09:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9D3FE3851165
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9D3FE3851165
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750680593; cv=none;
	b=JrDlPtOfHDLdDiWx4KSw5Sg0Ns9AQemfBasEHwAhqsHL917PgY/LofcGF1CGV/4Ujpwob+HvzAtqe8F2fN4GzdSrl9S2evyQvBOfCW2mAihdVYtdJgl7DCIUwi08UGKqjxu7+X14+mXxFnoddYE8/yf6mWpBxI4rJLIXf/mJ9+4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750680593; c=relaxed/simple;
	bh=r+STsJB4pOmTgWv7PYus25RLD26xB6p+mTlEyPTm3Vk=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=tz1pdps7a/gH5NOsSjU3i/TqqZXn1A3KlUSbEENIyN+IJ2OyP3UZ6Ey7KNWXZmpANAY5k5mIk6ayl0kxv/AAj2nAQYCDAnUvSEkv8IrApma/a3aXnweBeGL1v72ZvRw0Y0uzzi5kXRl726+9aLaxR6g2gI+nqESDqKi+HE0SzBc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9D3FE3851165
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=JBLdxDr+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1750680591; x=1751285391;
	i=johannes.schindelin@gmx.de;
	bh=e9Rddm5FIfgHD+PT5VlBlOvNojrpaozylJbnE+fxq8c=;
	h=X-UI-Sender-Class:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JBLdxDr+1LBybUOLo/LL1gyiVmhA5ZCzKBR0shegQXmNWfzdaTQdepMt5zyxSboY
	 HK2Vpv1zGZJdtPueN/lKrYJ2aWXka4ES8YntaDgtCvivu5CnON+rfETR7NHDCus3V
	 T2MUObwv5cPW4WV14In4dmFAzY4DiVPkLgFpiMwAutCZZr1c/4Z6B/CpYnaHjfUvs
	 hO0GY5rTK6H6zBXFFzRNe6RhpHVBBcCT2N7Ze8hYVukmcpxMntsCwF4ir5AHl9CzP
	 JukjcHQ6DvzkAJZ7277lrm1/ldLUR6yceqtYI3an+zukz/rDbcnnWa6T/JHrtr3PS
	 YvUnmaYaKpyytWhA8Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.6]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MaJ81-1uHHYY0bn3-00MUwM for
 <cygwin-patches@cygwin.com>; Mon, 23 Jun 2025 14:09:51 +0200
Date: Mon, 23 Jun 2025 14:09:49 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH] pipe: fix SSH hang (again)
Message-ID: <c9b1313d5d8a690aae9788402ec5190a1f18ce75.1750679728.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:t3oRQnPu8ZAnI9RWgvPWYwyV1R+XATGx5K47KVCgw+hgdIBSjpn
 oTcq046yT9an544t70X9f4xCL7MFaDnFXHiixqXoj7z7PlAe4MRxsshL6ahlsi0Grn/sEox
 T4IRdz/ECEI3sSxq0Q6xSGG8556K8UoefDDZ2CInyrKCwnachmHOMohE/P0yIPLSlNJCpZr
 BR2PE7r6ClIVZFwM9LA6Q==
UI-OutboundReport: notjunk:1;M01:P0:5FscQeWYcPw=;+5/e4bAmExyDsDfFAnPrff5jG3a
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_ABUSEAT,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The recent changes in Cygwin's pipe logic are a gift that keeps on
giving.

The recurring pattern is that bugs are fixed, but with many of these bug
fixes, new bugs are produced, and we are stuck in this seemingly endless
tunnel of fixing bugs caused by bug fixes.

In cbfaeba4f7 (Cygwin: pipe: Fix incorrect write length in raw_write(),
2024-11-06), for example, a segmentation fault was fixed. Which is good!
However, a bug was introduced, where e.g. Git for Windows' `git clone`
via SSH frequently hangs indefinitely for large-ish repositories, see
https://github.com/git-for-windows/git/issues/5688.

That commit removed logic whereby in non-blocking mode, not only the
chunk size, but also the overall count of bytes to write (`len`) was
clamped to whatever is indicated as the `WriteQuotaAvailable`. Now only
`chunk` is clamped to that, but `len` is left at its original number.
However, the following `while` loop expects `len - chunk` (which is
assigned to `len1`) not to be positive in non-blocking mode.

Let's reinstate that clamping logic and implicitly fix this SSH hang.

Fixes: cbfaeba4f7 (Cygwin: pipe: Fix incorrect write length in raw_write()=
, 2024-11-06)
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
Published-As: https://github.com/dscho/msys2-runtime/releases/tag/fix-ssh-=
hangs-reloaded-v1
Fetch-It-Via: git fetch https://github.com/dscho/msys2-runtime fix-ssh-han=
gs-reloaded-v1

	This commit message will like any love you can give it. For
	example, I do not _quite_ understand why the `while` loop skips
	large chunks of code unless `len1 > 0`, and what the exact idea
	was behind having that `while` loop even for non-blocking mode.
	Could anyone help me understand that `raw_write()` method? Is
	there any good reason why the non-blocking mode runs into a
	`while` loop? Is it supposed to be run only once in non-blocking
	mode, is _that_ the big secret that allows the code to be shared
	between blocking and non-blocking mode? If so, wouldn't it be much
	better to refactor out that logic and then have non-blocking mode
	take a short-cut, for clarity's sake and peace of readers' mind?

	What I am quite confident is that this works around the problems.

	I would have put more work into the commit message, if it weren't
	for two counter-acting points:

	1. This seems to be a pretty bad regression by which many Git for
	   Windows users are affected. So I do feel quite the pressure to
	   get a fix out to those users.

	2. Despite my pleas, the commit messages in the pipe-related
	   changes keep having too many gaps, still leave way too much
	   unclear for me to make any sense of them, and I have to admit
	   that I do not want to be the only person in that space to put
	   in a large effort to write stellar commit messages. Therefore I
	   left this here commit message in a state I consider "good
	   enough", even if I am more than willing to improve it should
	   someone enlighten me as to the questions I raised above.

 winsup/cygwin/fhandler/pipe.cc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pipe.=
cc
index e35d523bbc..13af7f2ae1 100644
=2D-- a/winsup/cygwin/fhandler/pipe.cc
+++ b/winsup/cygwin/fhandler/pipe.cc
@@ -542,6 +542,8 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t=
 len)
=20
   if (len <=3D (size_t) avail)
     chunk =3D len;
+  else if (is_nonblocking ())
+    chunk =3D len =3D avail;
   else
     chunk =3D avail;
=20

base-commit: 1186791e9f404644832023b8fa801227c2995ab7
=2D-=20
2.50.0.windows.1
