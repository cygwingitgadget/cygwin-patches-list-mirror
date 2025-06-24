Return-Path: <SRS0=Y/LP=ZH=gmx.de=johannes.schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by sourceware.org (Postfix) with ESMTPS id 997853858C24
	for <cygwin-patches@cygwin.com>; Tue, 24 Jun 2025 08:08:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 997853858C24
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 997853858C24
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750752494; cv=none;
	b=oOUbhBufCyr8xTmrqq+tMzdN7Qh2m7TBfBHc1dIYMm8UUcz4S+0wBTKQ69mjInE0ffKXbhlC6NBnf778B8d7T7cbmQzBhlf3KMyuMLWXrj62jEP/HHdJ1Xfu2ZjWVPTNcQvp5zQqCcS5D0raMe3v9c896rjLHxP562sAET1Qa+Y=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750752494; c=relaxed/simple;
	bh=UsqblyQZWXRmzCv+TGlReII/EWCEl1ke8TWkzEOlbxk=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=nIv1opkhlTPaW204f8sEv3pI1imI5eLyuHFJpPuyUdmGjVaT7rVaqBnJTwlrcP5fQjB9o2mfn7k4R8hrGKoP7DSrOrFfoSPyRN8AW0X50jkRkBOcQMQGE2unGtVwH4shLrDK/iDkdsEcRggkni0PaDISu53gtSr1mqpzYyfACGI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 997853858C24
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=jDFu1f/H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1750752492; x=1751357292;
	i=johannes.schindelin@gmx.de;
	bh=37bA631k/w68mLnK19Fi3uDvofKVrTqiu6yonRAdixw=;
	h=X-UI-Sender-Class:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jDFu1f/Ha9wi123cKFkIQ+bnOztqjzJ7BdAHvwjLHsTDrDxbS5IPLpnwxJPRoKZD
	 S6WRmkyW39C0aeil/aU79i8hmBPb3mi/flYGusYDjqxjk3HpRnSJqBx7amP0my8Y6
	 Vmx08kJVCZSQugz0Zmk5+yMo9WPQ/7vrnBXJO0JoIyCtMQOtDGB713DulF4wfYrPD
	 N7V1ulIWpDbc/mRqstipwOswKB84JRH5xR+mXtrdhqzD98fNBHUSFgAmYDkFVRzuy
	 iJGQsBrWP06aHrG+I1+8pFKj39xlOKzjHwvhVa8sHObuApmYBssw5a0yGXCEyUTbK
	 S+94ZrV3aU3ONU9wYw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.6]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLzFx-1uCaPF0Rv7-00S0vr for
 <cygwin-patches@cygwin.com>; Tue, 24 Jun 2025 10:08:12 +0200
Date: Tue, 24 Jun 2025 10:08:10 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: add release note about `..` symlinks
Message-ID: <bcca7e8ef4ffea3405629285d3c79d9acaaeae0e.1750752451.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:PdWKi++CKqSreHINLjMfoUaghaHSSQFFcXZeUb3FkZcLIh9ywy+
 HIHKekHstjBtQhHxZTrf8+Alp7Qv7F9RxPYNxVKS6HwH2UTxwemSN+aWoYkvdRcLut0llx/
 5AIVqAwf7/ifoMONL6MADhkUtCrgLKJSaKUdhrY4nh0YNnv+0rpvDWxtycxEjPe9dc888tW
 HXCEjYMT8gBLEbpj6XqaQ==
UI-OutboundReport: notjunk:1;M01:P0:uMv95WY0a7c=;XgwByH8ZwwuTqtB+azGPfmNRBVV
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_ABUSEAT,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_W,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
Published-As: https://github.com/dscho/msys2-runtime/releases/tag/fix-dotd=
ot-native_symlink-relnote-v1
Fetch-It-Via: git fetch https://github.com/dscho/msys2-runtime fix-dotdot-=
native_symlink-relnote-v1

	Here you go, sorry for missing that.

 winsup/cygwin/release/3.6.4 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/winsup/cygwin/release/3.6.4 b/winsup/cygwin/release/3.6.4
index 8eb693c40c..c80a29ea4f 100644
=2D-- a/winsup/cygwin/release/3.6.4
+++ b/winsup/cygwin/release/3.6.4
@@ -6,3 +6,6 @@ Fixes:
=20
 - Make pthread initializer macros compatible with C++ constinit.
   Addresses: https://cygwin.com/pipermail/cygwin/2025-June/258305.html
+
+- Fix creating native symlinks to `..` (it used to target `../../<dir>`
+  instead).

base-commit: 5979f22b9094a22d07cc2382e129f3f858008c88
=2D-=20
2.50.0.windows.1
