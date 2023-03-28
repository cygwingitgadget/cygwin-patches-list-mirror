Return-Path: <SRS0=deyK=7U=gmx.de=johannes.schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by sourceware.org (Postfix) with ESMTPS id 4495D38582BD
	for <cygwin-patches@cygwin.com>; Tue, 28 Mar 2023 08:17:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4495D38582BD
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1679991440; i=johannes.schindelin@gmx.de;
	bh=KyKgiTwS9NXjv8nua6PLlNIY/X9nnEdThUfzF7HYaG4=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
	b=mkCdCj+XijzWvgOcPIbrBS0bNDSmXyRc/2CamFQMVnDeAVBssPN9t8tuIOFtpt/VQ
	 EdOrc5Jwd0kCzQ8Kk8makAsG5c2lfF+4iHrAo9urICofL3sgQYMlACZf+qimJUlcfy
	 V8llHkAtF3Tz8LdgeUcKFMcrMSqFQFbdexaXmgSfnhgDQzgKObJeIJIYE25T4AtL9t
	 WEB+i+fCT42TclUv7LGAF/NS9xNQZZ08g/CKTU6iRvT1YCYkY3PUgvijIBLkcAk0S1
	 m2rfi7+5SdzQKgAmm5zuIxvOUs6gwcdNmwDwgfUTcA+yyUy9tAgS9FahnDgPHCYTvc
	 1sUwooc8Us6Ng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.93]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCKFu-1pXgbC2l1u-009PDC for
 <cygwin-patches@cygwin.com>; Tue, 28 Mar 2023 10:17:20 +0200
Date: Tue, 28 Mar 2023 10:17:19 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH v4 2/3] Respect `db_home` setting even for SYSTEM/Microsoft
 accounts
In-Reply-To: <cover.1679991274.git.johannes.schindelin@gmx.de>
Message-ID: <a70c77dc8f0d8417537557ea8e3a38f85bc582dd.1679991274.git.johannes.schindelin@gmx.de>
References: <cover.1663761086.git.johannes.schindelin@gmx.de> <cover.1679991274.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:n+FtkG2isqW31oa77zcTTU9lcE/K7LkftgjOZioSVyB+GsA0oPO
 2guWLqjmEvt1CJbkch9IZsIPD5n5dJe/LY7ZTsmy7dXIyS/gwtgq3xEuArnZ21SEZUpuReT
 4Xar2f1Oo2lDOAxH+S1SrJIjLCM1rnAF4m234+uxg++n0MIYRMwUaWYQNKY+po87ePGhJ+M
 4gwq11rvkF348mrVjQYOw==
UI-OutboundReport: notjunk:1;M01:P0:W0QkUQu+rAI=;ZMuagDM7xyfuOWBDJFGomYZ/IlU
 RHDLKorW2oxtRd7ngP8bhjXSdt4yhMf5ReNlvyOTmLpoXn1lAl0czUFAugJ7LP9yZ4Emfmjt8
 +WFQCTDIds8Og6619Pj/wLVyCd4XKTBfotlx70Y65x+CkJEWiHFP8sTWpvv1mRYYRxNil4tWQ
 qjCKXwOjJsEgNrwaOm25aEtygLyT/iyflj/ELxlPbg4FVY7mt8toO+6hsKjbSTcLZOMXFtFdl
 j8T1Mblv5D0D/BELALkx3XtWWjvXj9wcZGrQWtGhFdGtU+vABl0195sU9QWJMY8xkzk/z8k1b
 BarwtmCMNOtHsoJhhwwydqwPlH2IT8t1gxYh4gkyqMZ/mvZ4SX+mMJAM5DbsGNvNKSeR9ha/t
 NOiN+muzpnHtFzvaAx5zUrhw1N1GvVF/AJ6tIu982uzBEt5NMbsddEeUI9P7U7MbOiSn2VE8q
 iI82jhgFN1LKNK42lpF1yErxkDnB/0M6Ks51LEmw8934C02w4Ev8RnmoGdsdILNiJhOv+v3Eh
 ndv+37ZgXP3L+MdmlESn5g5yUzEKkGN3ANywsW5qD3alw07dzpU7iUk3Eimm3Kw08RzgEOnIc
 9muZo/OLBZUEct1qil9BJ/oxHp8BymT0Zlfi0nSsX9Rr9Y4aYBF1LfTuTzbZcndhKcMY+Tgnj
 tMNzEm8rcRcQDjds1z11Q/6+J1WGn0XQbdJlcIu9JX9IMtx4Os4xilUaRdX+Ls2nHYLdx0gsT
 uKpmRdaHnhHFnNTEDRT1GuI49NIbY+jCvSsMY8lRPy7tdDX5AQhZ1IqhYSDDSkDCtcPLuTGpV
 imSPNcTCJeRC8oeiLD+4MB0SlizCXSmLC5sI+kjYeLBr1GaZ+l2ErNNCktzz5hCeFERc1p3Vi
 m/6nV6cvbhj/v3+V0kdPb+ONjQJPhEtH63iQcWtKZ4HU9+YDCbk7Qcz62RODF5ZKs1ptFI1ca
 /rgYQ//oQMOjG/eEycTlwK52X1c=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
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


