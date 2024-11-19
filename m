Return-Path: <SRS0=8FCa=SO=warnr.net=david@sourceware.org>
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
	by sourceware.org (Postfix) with ESMTPS id 423123858405
	for <cygwin-patches@cygwin.com>; Tue, 19 Nov 2024 10:02:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 423123858405
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=warnr.net
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=warnr.net
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 423123858405
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=185.70.40.22
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732010536; cv=none;
	b=RpwOcSYL6XToqiFmHB1UTrssdeAxLWizXnvL9OlWGc3CCn11bQ+vG79UhDz2Vix4M3035JLWLX6/2mZjC4mZ2C4VIRDk0ZfR2RGcnTd24JIv+4L33vBEcNkldAxLzKaj8Hs9iWy40CrhhYQ/ugN2qvcL6E+UAjQhCSQW3ffn4RQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732010536; c=relaxed/simple;
	bh=sPhV/cC2OvQBkBkNYmODLqW1BoUvdzyQKiwQLHci918=;
	h=DKIM-Signature:Date:To:From:Subject:Message-ID:MIME-Version; b=shAi0gan4WbyPb30tMDVDU2GIhTnB+lelTksaadBa1KpI9cukjAQUPo6ZWdAOE5gm1wcSgIZ4eJvXRy7RezPQrwyhOfvo8Z2XTvu4uhRLCv8XSfV434NfjhbqWC3G9+igs9PVhai8i7SyVPQvG4dTl8h1yu8c948qVAKHBHVqnI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 423123858405
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=warnr.net header.i=@warnr.net header.a=rsa-sha256 header.s=protonmail3 header.b=B/pBdW0Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=warnr.net;
	s=protonmail3; t=1732010534; x=1732269734;
	bh=FreQadtjLFDItBgDmac7M9FB6DvtcqD/eXYuZZHWXPo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=B/pBdW0ZTD/qLicaSjO72n3YkbibroSXC+cdDOAYq9vUEslmauWvU9wPJF3foeJZ0
	 rRK3qlfhowf6Pkl1GRVzeuwzt7D2PVC2xfddt8HVAyBY9GwChuOHDo+UsT7ZiGdruO
	 bHCocR6Gz5IzLcG25fhJwKq5z2Rks0mlvANzuvpwLQgulnqlLRgwTZjyuFuxcXxUii
	 hMIpqreENXxh+5oC4XokJ6mZyHsssFTd6yZK8aSjVWCS2ipbr7at//UuX77RU9oEPk
	 LVrMDzsX3AwjCV6KNQWtqR7i9ns9PS3DaGHxoQaEZ5AYZazXOn6epPIwVNts1zSYzd
	 A3me0AkEA2kXA==
Date: Tue, 19 Nov 2024 10:02:10 +0000
To: cygwin-patches@cygwin.com
From: David Warner <david@warnr.net>
Cc: David Warner <david@warnr.net>
Subject: [PATCH 2/2] Fix tabs/spaces
Message-ID: <20241119100140.43240-2-david@warnr.net>
In-Reply-To: <20241119100140.43240-1-david@warnr.net>
References: <20241119100140.43240-1-david@warnr.net>
Feedback-ID: 42670675:user:proton
X-Pm-Message-ID: 2350eada774b553eb943d144c7f70ba4bc8ab28c
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-12.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

---
 winsup/utils/mingw/cygcheck.cc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/winsup/utils/mingw/cygcheck.cc b/winsup/utils/mingw/cygcheck.c=
c
index 659e8428a..89a08e560 100644
--- a/winsup/utils/mingw/cygcheck.cc
+++ b/winsup/utils/mingw/cygcheck.cc
@@ -1459,9 +1459,9 @@ dump_sysinfo ()
 =09=09  else if (osversion.dwBuildNumber <=3D 17763)
 =09=09    strcpy (osname, "Server 2019");
 =09=09  else if (osversion.dwBuildNumber <=3D 20348)
-            strcpy (osname, "Server 2022");
-          else if (osversion.dwBuildNumber <=3D 26100)
-            strcpy (osname, "Server 2025");
+=09=09    strcpy (osname, "Server 2022");
+=09=09  else if (osversion.dwBuildNumber <=3D 26100)
+=09=09    strcpy (osname, "Server 2025");
 =09=09  else
 =09=09    strcpy (osname, "Server 20??");
 =09=09}
--=20
2.47.0


