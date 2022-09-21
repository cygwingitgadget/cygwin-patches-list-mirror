Return-Path: <johannes.schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id 67B903858C74
	for <cygwin-patches@cygwin.com>; Wed, 21 Sep 2022 11:52:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 67B903858C74
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1663761120;
	bh=XuaUUvlC/1UjCaCIe/4DQQgM6lwu2A8CnzO7VDQSfwQ=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
	b=RtJe6dxK1edvWvxcSsryPemEE1iyLZXSEWHexDVXL96fzXh5UU5aOJRLDK+5x3meT
	 R16ko05K51UlLHoZ03pJKB8p2fJC+uZkUCP3ip9+fdhPYDjpgvMf8nZiHcj3Whvubo
	 9lagvEecnOb+tpMzG52Wafri5CG1GJEkNbiw9qfk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.115.55] ([89.1.213.188]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mqs4Z-1p5r6X0TPl-00mp6m for
 <cygwin-patches@cygwin.com>; Wed, 21 Sep 2022 13:52:00 +0200
Date: Wed, 21 Sep 2022 13:52:00 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH v3 2/3] Respect `db_home` setting even for SYSTEM/Microsoft
 accounts
In-Reply-To: <cover.1663761086.git.johannes.schindelin@gmx.de>
Message-ID: <1b4ee89aa72479632434ceb450b4306b1de3c705.1663761086.git.johannes.schindelin@gmx.de>
References: <cover.1450375424.git.johannes.schindelin@gmx.de> <cover.1663761086.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:02sNyGRrawdQmwH8hNECsaklMiEyZm3AcqTxAWpnlTKX/TCCvND
 BnUI+VTFCqxD5Ly7jIRCRbEvUYxFDwY3uyxbahTLL1Ukre6eKpdhk4gQdpIYEX5gRmRj77m
 /tYoCPTB3nb4xMxOKSiMvd4TLvemhKtvab3UAK7N+XK247mOn0kOvHwwi2VwOfgpboj9ntI
 Y7mhpbTRe1PQmiLXSBi8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+EfjNr3sjhs=:6RVhiLTH9JT1OutOeMRpHB
 vgxB54qCL7yIW07dtqSWyCmWyypynQtE9zpRUvsniSJJE/6xRKFied4GhzLW3ObMehLczJISk
 kyg6V4cAAV5TYzSHG9XkVO92qlCtEmXSxkbIW3kzA1KxDBzD77tCpIl+mzrPsQwMr37FlJK4/
 zC5mO58Nu+UtJ/LEDVkduz0t5wKe5uMUNU7OtM1dbCxmt6rtXJohPMZy5l5gPD9JLeuXFIoNc
 +38Z4vBtepzHZZd3g68PmtT9vLz4QhHBGTAlrJwwHrL0xHhjY3w+RWr88Vel1PJkjd6amADYw
 B92/PAEtMvkycqeU2puitlaC9fsuwY1ybUFPNxH3QFYjCek+z5Zpy2qECz3Q/Pbg9V98D0PGT
 ZIKSyDXNH4QBDa2W7m3nBqHHVynUMTVCoo+9iF5karNHKRrXCFdYpgp1wPGnx/WIiVOJwX84m
 0W5qozFt4Q4PnM4lXkfBhKspg6UumTWbVRbyctqBkKK9Lr+zehCgIpf2uJfXcSVXxxvi5X9PB
 jyazKnGneYncBRvWePaVMtE4yOBH9guY/VoO1EYJ0lQ7q61rVEAsqWM4sgspCI1LK+XnQZ6bd
 ayBW7kP/kWw9xoNo7jB0cPpZZIF9mRYp/KJiisITAaQb0x5KbhReSqv1eOlTHW229Q7JmCtj/
 n4vIATloB8l+nRpt/i98KG2n5kolRaRFpWmoQHCXu0q5umc8DQzPzGoU+NXbv/gyVeMt6xU5D
 UZgwtKJ17fwn/gN1ukW98v/QABFeAGy0BLmrqsAOSLB0CiafLPnnivpZmvt6MzDLvqmG+wdh5
 7PFvt61WxMWVBmnWu+W9Q5jgPmas9xeuFd6w7I7O112vTQnMGyz/9od4UuaCKXSh0Xqx+eXyB
 RuF0u8KyJvkUEhbyZzuW9BWVvOKtVRYcV9hFa298lXqcXh5sZlA/Hyon+sg6MTOvWMZCCrxoS
 rHVdwvxRIYVtO2ISb7a6F6eVn+lIqRbnjHoMrV67MCu4ezJS84rwFcgUybNuK2zVrKY2/CiAc
 0y2wT6WJCgxumysRq4K3X9VqhVc8qnxLs44Ed7CKKrmVSW3ubGYc0KSCP1m54+L498Du9nfaC
 xFZvS3pCdXixa8MzX/tzL2h8Fpg2yQVP57xXAyC40X8GNRwVLnzQBwPGZmn6qGutl2AtCGBWh
 h06VvEiC7nD9VhaNO330llrXIr
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

We should not blindly set the home directory of the SYSTEM account (or
of Microsoft accounts) to /home/SYSTEM, especially not when that value
disagrees with what is configured via the `db_home` line in the
`/etc/nsswitch.conf` file.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 winsup/cygwin/uinfo.cc | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
index 6e673ee39e..5e4243fa4e 100644
=2D-- a/winsup/cygwin/uinfo.cc
+++ b/winsup/cygwin/uinfo.cc
@@ -2253,7 +2253,11 @@ pwdgrp::fetch_account_from_windows (fetch_user_arg_=
t &arg, cyg_ldap *pldap)
 	 it to a well-known group here. */
       if (acc_type =3D=3D SidTypeUser
 	  && (sid_sub_auth_count (sid) <=3D 3 || sid_id_auth (sid) =3D=3D 11))
-	acc_type =3D SidTypeWellKnownGroup;
+	{
+	  acc_type =3D SidTypeWellKnownGroup;
+	  home =3D cygheap->pg.get_home ((PUSER_INFO_3) NULL, sid, dom, name,
+				       fully_qualified_name);
+	}
       switch ((int) acc_type)
 	{
 	case SidTypeUser:
=2D-
2.38.0.rc0.windows.1


