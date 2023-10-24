Return-Path: <SRS0=FhyQ=GG=proton.me=tryandbuy@sourceware.org>
Received: from mail-40135.protonmail.ch (mail-40135.protonmail.ch [185.70.40.135])
	by sourceware.org (Postfix) with ESMTPS id 9CF733858CDA
	for <cygwin-patches@cygwin.com>; Tue, 24 Oct 2023 17:43:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9CF733858CDA
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=proton.me
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9CF733858CDA
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=185.70.40.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1698169410; cv=none;
	b=SMSBg8WnYOmXQR08ppH0sRPUPVxdjo7ioxs6z7YRuYIKRMcZFtC2Y+VwASkAvnZWV6GC8MXELYK1yOLbm44RIZGwW5mi8Wt64P5jKAmcBJx4d73HEb6step/PUaJeo1sG60eBNBakfhvVLIutd0GZsRTuM7nVaKNMNPH373fGhI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1698169410; c=relaxed/simple;
	bh=tKgLGElw02M4IeUfTT6Vsp+Li0SixOPIJEE8Ti1veGI=;
	h=DKIM-Signature:Date:To:From:Subject:Message-ID:MIME-Version; b=ef3KWrYsDR7+0wCIcGj3z6zn0lIsn4Qk7ztsyuur8smLtsYv55y4A3Nfnje3XaxdyZ/VAgwYbjqyjUp5fR/2TaIK9ILxC8rUd0bUj2GFWyYMXuCOKr4JkwsqOxLAGUuwf5cy0sQr3IMHTQRYctilIHyfv2SYlvE7U2XjiTP5KIU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1698169406; x=1698428606;
	bh=j5/sL/gWnypMdrchEAF3T1ryOydrkWTUwKerOn2eCAg=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=JFY0Hat3vvruZsejFfryEdOLeWsxMDnEv+eBtEoxOBUE/RxOe5mHpu9EXXJDd61io
	 5sQOvBj6H2Uk2NDfZMORJUQeBFDJL6YjK7e4Z+AF2ki70qawicl3g53ctpNC/R6cAj
	 uObhJvkd6a3ixU6HyEwGHNOljEjXlAmzg/CE5TwudIv202DNDYtaJAevOLUV3PS0fS
	 VmX/Saf+GRsV6E3LexGxshjSkhczlFvZsUkcUzf1mLA9nsR711/mOWnNzzOpszhEKp
	 AdcF/g/iePZO7IVBlwzHot7PGcM/QawBSzv0PwdNNmPcMvofVgimOFut/3NvL8Ef74
	 z5o2vTLP5oB5g==
Date: Tue, 24 Oct 2023 17:43:16 +0000
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
From: tryandbuy <tryandbuy@proton.me>
Subject: [PATCH] Cygwin: path: remove unnecessary release_write.
Message-ID: <dvuNgn8HVJSufnkkXFMyJ0UhWT6zC0WOywU_skxiy-75iGnjKeqGkxi1WYjyACgcAsn_sOzmW_gCcoFhSx5IFDM0TsQzT4uEUn718MoSkVc=@proton.me>
Feedback-ID: 63211331:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,KAM_INFOUSMEBIZ,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Fix an old bug that only appeared after replacing muto with SRWLOCK.

The bug leads to a deadlock under certain conditions:
https://cygwin.com/pipermail/cygwin/2023-October/254604.html
---
 winsup/cygwin/path.cc | 1 -
 1 file changed, 1 deletion(-)

diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index 1c3583d76..7165aa8b7 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -4868,7 +4868,6 @@ cwdstuff::set (path_conv *nat_cwd, const char *posix_=
cwd)
 =09=09=09peb.ProcessParameters->CurrentDirectoryHandle,
 =09=09=09GetCurrentProcess (), &h, 0, TRUE, 0))
 =09    {
-=09      release_write ();
 =09      if (peb.ProcessParameters->CurrentDirectoryHandle)
 =09=09debug_printf ("...and DuplicateHandle failed with %E.");
 =09      dir =3D NULL;
--=20
2.42.0.windows.2

