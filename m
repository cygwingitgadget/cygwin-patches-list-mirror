Return-Path: <SRS0=8BlN=73=gmx.de=johannes.schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by sourceware.org (Postfix) with ESMTPS id 8F4553853D04
	for <cygwin-patches@cygwin.com>; Tue,  4 Apr 2023 15:07:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8F4553853D04
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1680620871; i=johannes.schindelin@gmx.de;
	bh=rdlqqX1i9rotQsJspmbsq7uiN53Yh8xjfM4sAH4lylI=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
	b=liW4otp2PAKtoM+t25t8M8mbMfSrJnwz/+tK1QXd7SPetbuZicnFvM2KjrxPgeqHJ
	 C0cHy83cRvlf7jQ+bAHyb4571cY5amufrIuEviVKdGu4jdXM3OlLVBm4BC+C/fZfxM
	 Ry58kluocU221Dab6dOl7Ws9X/DjMlmhhHa8RCssW2U77aXXpB5VkYr4vy0xxnwd1R
	 lPgw8sFo7roTl9lkujdy7YftZqPu45BdVwprMCFhZi6jc3OuaTLl10cDg6dn/GVJvW
	 l1tSTbhRbijw5t6R/1/Kn2PvGKlWSu9231HRGDQdromjRBREYMDVT83MotyKWCsQ25
	 leXU9cMrnhdsA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.182]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MD9XF-1pb9YU0tY9-0095Qe for
 <cygwin-patches@cygwin.com>; Tue, 04 Apr 2023 17:07:51 +0200
Date: Tue, 4 Apr 2023 17:07:49 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH v6 2/4] Respect `db_home` setting even for SYSTEM/Microsoft
 accounts
In-Reply-To: <cover.1680620830.git.johannes.schindelin@gmx.de>
Message-ID: <085d4dd8b67f603f0de49999d8e877a27a6751e1.1680620830.git.johannes.schindelin@gmx.de>
References: <cover.1680532960.git.johannes.schindelin@gmx.de> <cover.1680620830.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:w9jqPgbbF3oLH2TW+JIpzLlbE9DpbMIhsCt+3+a+ERnEgQIyheo
 vfI+zmNaODa5o/DNMO4MKWb/HH2M8yFrAFiyZgfWkp9AKrqJtGaRBuIZ6XtAJAgmh71R0xm
 ipzgkCwKqDR2DJFfL95plg6LalsskhIZoRsMza2h65DUcGJLFGQYcndkSyHLPs4Z9saa8ba
 kZqbTvNci5fvGqar7+Zaw==
UI-OutboundReport: notjunk:1;M01:P0:5HDh4UyBRug=;q66nevtiUP/8j7Yz5y3LBpJPZEN
 oQtYn2x679eHJYaNJm47yVi/RU4lNs5W+euBfPm8AgM+7g7E8SoApp61qbHJO2pM8mLDGWj0t
 7n5KbigBs1XkaY8IAPj7417AOYMMqvGXRap9213zwYv4C5Hqebox6bcVCKKZk99nljhu6U05i
 asVP8fO48WUnaRXfxZNprBOPzZ/gZu9ajAkfPxsm7ZAZ4PJPpuQGQ2NFxHXwtkf3RQ3KWbgfO
 uHh/ktuhAS5Ka09QRMX3cYgyE5IR2+98Upqw/rhvY/nF+z4TRcxJIMDw1j3C3V0za533EvDoc
 9PTMpbO1pgseJTAWJmw5DY4mn0jKduZHZcaSocamvfzIRZWOD8R6N780Zqw0caWH7HEAV90X1
 XWux8Ju3bsLplLLd51gsFBsCH3ToPEkQL7S2eWQbj9fb3dXus6wHMA5Q81SkkryiofBpiTkHK
 pT8p/Mui2PFZrffw1S/0fUAvZmqY+x88pkJP9kR6n+zndvcMpgYOp5MHv+FtjGih9ceNWflum
 /dXERaH5/O531AwsqZ+NgybKqNp2fhw0Lcf1ddBTql0IdHeuoTjZWVnTK/QRyZShfJFiw9cFC
 qVObBU9qWiPXjbKkpBQbhCV6GYWjT19dJwhXUCYMQZN+ekpHAYxhf6D9B8/FFAy7WrgGDwvae
 Pt+3M0FQ3z2iYf98nLvwbywfYmMeqvwqEoFjlihTP3OEKDVL4Ze1cdgndtw6WReqCExHXb5bp
 9ZzApiNX830ax5CKCWpQlJr/H453yl40dD9tHZEDgRSaayb9vUlbx7Zg8kwxJQNNXifIb+nII
 p0XXta5+uWS+BW7QUEgCZKdtDcRUuLSFQ4LZMg/8xYmME989k3UHU0Pga8GUuG8eO/A9GFAfI
 d/YaDzzJIAOi4p8vUK4MehXlNdm7Ra9akSTvsKYW60hRowFK8/j+otC/FtQhZYCyM9xDd9bPa
 k48W3A==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
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
2.40.0.windows.1


