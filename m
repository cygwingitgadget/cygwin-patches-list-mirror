Return-Path: <SRS0=8FCa=SO=warnr.net=david@sourceware.org>
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	by sourceware.org (Postfix) with ESMTPS id 10D333858D21
	for <cygwin-patches@cygwin.com>; Tue, 19 Nov 2024 10:01:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 10D333858D21
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=warnr.net
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=warnr.net
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 10D333858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=185.70.43.17
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732010516; cv=none;
	b=kNNj/j69AfHuwoYScQkmLc23gt/7kFM6WgDoR2meIyPV9EvD1nMaE+HMlr/itohSZ98Feb5EX7kCPdt8ie51OUU7+HZ5D63k1leeVL29m37VDUY8YJmWMqY1IK6fK5xExRAHJwzMCuE1cnDC+UPbr0YOqbeRb5hcROpgXsTh7qo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732010516; c=relaxed/simple;
	bh=92/KkDypOHDR6LHZEy0O4YK6OoYV4smrPLCFIXwV9SI=;
	h=DKIM-Signature:Date:To:From:Subject:Message-ID:MIME-Version; b=jSu3SPLvKkUTcCMuSEAEIdjbc57gyFfUWUsye9HKYacpknJCoLB/unRXwmfJHhJn2oC5U25islvq2mKYsVY+JuitpJBcS6Mj/QvdthlcHF7OyzOS9xbuJ7jzFKeNfSQp0lReDEoWqXwvbbrC2fL3sk42dc6cZgGGrfsK5iAkscY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 10D333858D21
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=warnr.net header.i=@warnr.net header.a=rsa-sha256 header.s=protonmail3 header.b=IE833W6Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=warnr.net;
	s=protonmail3; t=1732010514; x=1732269714;
	bh=yeKaI0hjAde/dRdXA1v+tzXoI0Kep6K5xHZKPyKcGoc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=IE833W6YEI4EcVDLULmXWFJC0iZs3AksmgPREYoVJ41MKMGBn4fdIkBIncvMk0xET
	 /Ck/VLVlNGEmW4Wyb1zg8LyoDCEYNt8vCoXyl9nF7HwP6it5O/ClLbhjiCp1Ro9qVO
	 9vdZH7HctNVrDxVFXnxKGGlMOwNV+JiBzxdycE/Pc5yVNX4uHdDnKlyn8RLLXn4bnR
	 HLfHoBPJyBoqzzdWT2aqWjBcLeas1KS8mrjTXwNBj9ezHRYdezjNiklnYjHpk5T7nn
	 0TrEIXAah13I6xNrJbpyBu1s0PN+jWcinjCRv0smznZi+RZgvQLuFLlWWU5DcNn6z1
	 O8N1cjdLQWHNA==
Date: Tue, 19 Nov 2024 10:01:47 +0000
To: cygwin-patches@cygwin.com
From: David Warner <david@warnr.net>
Cc: David Warner <david@warnr.net>
Subject: [PATCH 1/2] Add Windows Server 2025 build number
Message-ID: <20241119100140.43240-1-david@warnr.net>
Feedback-ID: 42670675:user:proton
X-Pm-Message-ID: f23231704b96ae965b2e9abab2f7324c0ea47f66
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-12.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

---
 winsup/utils/mingw/cygcheck.cc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/winsup/utils/mingw/cygcheck.cc b/winsup/utils/mingw/cygcheck.c=
c
index 1dde2ecba..659e8428a 100644
--- a/winsup/utils/mingw/cygcheck.cc
+++ b/winsup/utils/mingw/cygcheck.cc
@@ -1459,7 +1459,9 @@ dump_sysinfo ()
 =09=09  else if (osversion.dwBuildNumber <=3D 17763)
 =09=09    strcpy (osname, "Server 2019");
 =09=09  else if (osversion.dwBuildNumber <=3D 20348)
-=09=09    strcpy (osname, "Server 2022");
+            strcpy (osname, "Server 2022");
+          else if (osversion.dwBuildNumber <=3D 26100)
+            strcpy (osname, "Server 2025");
 =09=09  else
 =09=09    strcpy (osname, "Server 20??");
 =09=09}
--=20
2.47.0


