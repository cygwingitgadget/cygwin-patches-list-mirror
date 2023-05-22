Return-Path: <SRS0=TlDz=BL=gmx.de=johannes.schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id EC1163858002
	for <cygwin-patches@cygwin.com>; Mon, 22 May 2023 11:12:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EC1163858002
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1684753965; i=johannes.schindelin@gmx.de;
	bh=p71oPRLh8ghUjoaiERHgauB7QQ65xKcXJkkGV64xN9E=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
	b=mrlLAjkGB4byrBLMKUu3C80wHgfdWgF5HyTO08DB7Pe7zZP4GUsl968yAWNapMZ1A
	 KHVmyhDO8YZowDdIqF3l3u165eqHu7oeTUVK/ynMicK0ouTd2WRoShrOar2J3rUS28
	 xgUIaDFJhzmi7z3+ieHwOBDkFc7GpgGPLPbjQCS8oPnTL4tLbOl6jesooWIvUIUNWn
	 OTKGw8vHYZUIozYGAn8t3L+6ch6hADRH1jEz5Nw5zE7tymiyMdg+87TBGqVcz+nNpT
	 bN0HUuAvCnIdFZinY2rMHgOejZWnxWpowsdTSUz9FZqxu7XKnRXmGgOlW6z/Z7Pt0J
	 NfSlBS70H0XpA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.249]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1wlv-1q7TYi30On-012Ehr for
 <cygwin-patches@cygwin.com>; Mon, 22 May 2023 13:12:45 +0200
Date: Mon, 22 May 2023 13:12:44 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH v7 2/4] Respect `db_home` setting even for SYSTEM/Microsoft
 accounts
In-Reply-To: <cover.1684753872.git.johannes.schindelin@gmx.de>
Message-ID: <085d4dd8b67f603f0de49999d8e877a27a6751e1.1684753873.git.johannes.schindelin@gmx.de>
References: <cover.1680620830.git.johannes.schindelin@gmx.de> <cover.1684753872.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zsBU/K2wB7TUnFL1pu+cxwXyKZ3z2ks976xm3y94TP75cQtmTXc
 1Ca/4bq/kU/Dl+oZ33DbPugGulAVKf1yPpaNJQF8IskQm+0+ZGdmxbrQMQuDTZPEdfW8arq
 45Td2/j+HxGcP9+RZq2s59RD97gCMIPIWBJ7c8ew/52R7SwXMDvknLRhWpEAvbJ3ugOGlch
 RIFJYdQGYKkpEUdr4/4LA==
UI-OutboundReport: notjunk:1;M01:P0:n6uQU/2zLM0=;2zqsliXD92Z7e5v3HguGaRVTw4I
 Dy8PMgNzSpzo12e5pD66J4Mj5rWzthW7cUNt7Xd3b2HZ3PNT/dbqMV/R9v+V2BMj6qjweYtFx
 xPlz3IQreAYd6w1Gl41+WiIob+sG2E8vZedd7aRT7ptcLpjYuGsAj1mpDHEoyPqX8rfLV7Q0o
 fPqgSCluZDG5NL7sGwYvpkUPdVijRSnHQXGDxJl+mnu+4rC+J5WHnYnuaUz/KZJ2D6w50ZYrA
 qM/2xn0p+jljouRI3aOq1Eggbz4GIe3d++eZ1MZL/uGaP1rBA34SRh0o2pGhgPKeEaF52SRKJ
 R+mHXefEu7RYilRE7SisnYv8wdGfhObV1iXLskz0h9RIisYDaWK0SpeyevYXiDK1uOjHNd98p
 PKp2jW7PQqcfrIflibEiDJWVMwVdhuiB5i7nqO+X4L3Vk2G9BY4PGt/0C4GBnW79payabN1LR
 jfqITaz/AtOpcSs2iMW2b4OzX8ALJZ6dcfkzIAiynRDF7d56kZhbq8ebmPbwAE3uhhDsAEsSW
 PEKwJHJgxBeX3vi60Ok4WrEFgnALuzbsExNn1/hRnNvlxhkwO6Wd5g0prMOcxy2Nq8D0g67UR
 6oiZbK5BbEZ+gY1hkrX2NmiXBfxd6i++9m82VCSW36sk+Qx/0fF4R6EoklokC2KpgtNTyt/76
 7Hhp/7h3JZYb8O7241eHmlf1XTv2g58mD6D/qTny0Z5M+6ldXUu7l8hqLYtukjNqhE4UXNkez
 d54Y0hmtLpPrZKKtmVvHsBkme6CmUN7iBFKDuMs9geN+3o8dc3Ip2zi6TmhmTxfpxjz3jFAMw
 2jUIjhhf3g6m8UixcKTcbHzYGXI6scRSGO9awNN7t+cpbhVU0waKursWcFjtK6A8UZJkqjABI
 zAOFejxS9YBYaTsHFcrYqq9qN3uC2R5+/bFXTXFP/uDo9GL87M0emo5+KYk3NVHIVD+EWcwAY
 a+TLt+4xqzctJljOG35NuEoSgPo=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-11.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

We should not blindly set the home directory of the SYSTEM account (or
of Microsoft accounts) to `/home/<name>`, especially
`/etc/nsswitch.conf` defines `db_home: env`, in which case we want to
respect the `HOME` variable.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 winsup/cygwin/uinfo.cc | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
index baa670478d..d493d29b3b 100644
=2D-- a/winsup/cygwin/uinfo.cc
+++ b/winsup/cygwin/uinfo.cc
@@ -2234,7 +2234,11 @@ pwdgrp::fetch_account_from_windows (fetch_user_arg_=
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
2.41.0.rc0.windows.1


