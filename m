Return-Path: <SRS0=8FCa=SO=warnr.net=david@sourceware.org>
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	by sourceware.org (Postfix) with ESMTPS id 2B2783858D35
	for <cygwin-patches@cygwin.com>; Tue, 19 Nov 2024 09:55:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2B2783858D35
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=warnr.net
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=warnr.net
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2B2783858D35
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=185.70.43.17
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732010140; cv=none;
	b=dr8jR5ACg6QOG/pGldwFQZML1jAh18YuLzHVpqK33rirFkRSvVxH/uQ09K2a6nzzr/grcGoSaBZhRi4iKTV1T7GcmgE9hXi8Pzd+EmSrVafpx09kyXuMJVvxIxMFZ5Y8l8+rr1m7smuD6kOZcqLdAm3ORmWFNh6em2UMPC4jN4E=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732010140; c=relaxed/simple;
	bh=92/KkDypOHDR6LHZEy0O4YK6OoYV4smrPLCFIXwV9SI=;
	h=DKIM-Signature:Date:To:From:Subject:Message-ID:MIME-Version; b=TifP2IzGXeFPUgIYQK3q6//4NCKNRCdamJlPbPUthK++KH3eScK94UcJHYIt7iklPjkp4B0uWWFe9qMEA8nxFb5/hLn3MINDbDQaaXEeStH/bry50jmDSltkuru/opBXkdZd7wxcRcG93tavu40spLByxtV5LdQ++68eOPdoIls=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2B2783858D35
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=warnr.net header.i=@warnr.net header.a=rsa-sha256 header.s=protonmail3 header.b=X1lqOh4a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=warnr.net;
	s=protonmail3; t=1732010138; x=1732269338;
	bh=yeKaI0hjAde/dRdXA1v+tzXoI0Kep6K5xHZKPyKcGoc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=X1lqOh4abdNNBl1P9dpjxdMfVpwI5J4JJbRXE8YsJOXY5oRiB1Ts9roUp4nJrTGSL
	 ga7uFIpd1dJsR3SEDAqkAc1DqjOx+8tAzbEJjCiSa2ckuYokIaPqmNMS97Gi25j63D
	 DOxfPzk/ozIkr1XKVg/tAqN/xe4nwRwm+5rMBcGwwbYFnrdtsmqLWCAt/Jixw5UqJv
	 3ipR0dXjVPYJCI1IyPJbxsApR8KPOH/8UBU9G+GhrmmXo4hNTGWPzif14mb1o3mzg3
	 ccdWR4uMgwZZcvtaNxI1FWaohRFYNEFLpDs4KPyXxG/vqBPZcCGSPx+NE8mSX+Q478
	 /llTchXaWHWGg==
Date: Tue, 19 Nov 2024 09:55:34 +0000
To: cygwin-patches@cygwin.com
From: David Warner <david@warnr.net>
Cc: David Warner <david@warnr.net>
Subject: [PATCH] Add Windows Server 2025 build number
Message-ID: <20241119095530.41303-1-david@warnr.net>
Feedback-ID: 42670675:user:proton
X-Pm-Message-ID: 90d8753244abe244fadc41d7cbf0e6f826387075
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


