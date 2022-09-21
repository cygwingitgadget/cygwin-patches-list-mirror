Return-Path: <johannes.schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id E434A3857C7A
	for <cygwin-patches@cygwin.com>; Wed, 21 Sep 2022 11:52:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org E434A3857C7A
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1663761124;
	bh=Mk+27sJrttGPe1R+Zjj+eIZ5DWOlmB0cJKKVI7KMMK4=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
	b=CPIZ+gUJK8efHv2SXGODaYXsvprXYXrsPq1E4aT7EOCovlqFS9NSMGw/4jzXHK7tD
	 Bv5QTCfBK81QnwJJChL0UEEi0YKi7wPylQkO96qcbwBawRNqiJ87EsZLcZfbleCTPy
	 366qUjFBRVr0JrmNhz+PelENexRi7IKPgcQP4ahE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.115.55] ([89.1.213.188]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5VDE-1pKLgk1i5S-016wfQ for
 <cygwin-patches@cygwin.com>; Wed, 21 Sep 2022 13:52:04 +0200
Date: Wed, 21 Sep 2022 13:52:04 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH v3 3/3] Respect `db_home: env` even when no uid can be
 determined
In-Reply-To: <cover.1663761086.git.johannes.schindelin@gmx.de>
Message-ID: <4d90319e44ff50b86be7727739944862476257f3.1663761086.git.johannes.schindelin@gmx.de>
References: <cover.1450375424.git.johannes.schindelin@gmx.de> <cover.1663761086.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Q03qR2u8q9Vhah6FWcAkUbp3DMSaGzCqIvbzi8+vgE/Xg6X2baL
 PM6FWVjeX4sP40geLzBMpJSioN3uPytn0+oObcVbuSlWJbMdCjSua47FXM3rMXrZJqsKU6e
 H8tMow+ci0eJo2zNl42BvqT+edMJJ38PMcepzCdSt2dOyInTFYQWGQS0xPzYRXYoHt/YEgS
 tmoDX0b0MxR9hsH39qs4g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fL32vGiJnw8=:vp21GStmAVKnKOD+Je5Y/x
 sLrFkosG+notsB4Yu0SeTDQEWKXM2fmW5+TwXopk4jtZUyk2g+w0L5vSaVpAx4fJ4vim/qG4c
 gu6lBJLbQvF/ZtoqVyn2eWuyCC1Y/Zfd6ZiBhL5puXAPE1KhvIZUbIqcazboBpk+ZktpLrNVh
 7KJ/SoeL8pSMir540qPXnxsi+2/sIyQ2TTVOHQ2jkCSioUDrLmBgRATGIvK8i/dQ4fS82j6xB
 Sx6YOmVvmv7fe8Tk3cQIN9OVWmgLr9V7hhymrREY1yUoeV3NBie9seAr66/ihtIo/Y/Bf017J
 jK6c2/So/8sOk+JduTUhQjvQbTwSryuRepTD+Zx0DiAUPWTgA03jU7DXXOn2pRSVmkv3u2Bbs
 O0moq73xBgifml4nl3J2nM/u4QMcLlxONwqzgkgCqCauKeZ9FZ8M0FD5hnfGApU4YzdXoVFAo
 ESf1KTxqQ7WZppsyxGTNWmZbGYRVG1ntaeZeFowGsmOvEkC3hfq8S7jet1IZWGEAYogCRs77M
 Mk6ZRqcj6rN4ayu+HJDwk49gc7yBQyqQrcWYvwNSH0hLWSvZxzpNmbpETfWztXSo8ybdGDJnz
 5bVq65+Y+e/FHNzSpinSi9ga0TVLFjjwCYfJBcODHg1LzSrw/As81EixHaHHX3yp9cdwen+wa
 hUZrYPl7BYo8Iz8Ml/WZpH9od7saHIs7L/YjC5tUllIm8PwjbQ3RWqm3SPf9rMYcisRCVEe/4
 DYVlYYrpdVXbHCq2YbUxcsofW0rualUyq2wDwn74se/OXA7Bi1TA/HATWiEdJ9//yde+wFsfk
 o/uSiWf6LdstWKxzpjLW8t/VaYFvaX0Mo1KaLoeXIqJiNyB43PsFOeKVlXJDskAxNnM1n+Uid
 thduY8vX4IyAU+Goex5Ot2sPV2yp8sRMGJHY6zI+cjVyi76tUHJwDKbw+xGDVZ8dlc/29xsNt
 OJAt0omDE1nDTqwH1R6H8YK4fWwC7llAebjH59SnzsqR45DnqRgdgF/lD+eF8TVXvuaFPgRVp
 n/FZJI1bTQJ7rmI0H9VDbKAX79qTb24rS1z6tlg/mtNR/IPI2lEVZlT5t2c/WeotR0z2DIcR7
 aOm2/LNPEKQzBO91NrDfJKxtnU5XqSbFY9uQtZ0k8/qIndHQrUuhNjvK6/2Kh1YaonAD6s1NU
 3TXZvhnoI3vnTTvJHXMtjiUXuS
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

In particular when we cannot figure out a uid for the current user, we
should still respect the `db_home: env` setting. Such a situation occurs
for example when the domain returned by `LookupAccountSid()` is not our
machine name and at the same time our machine is no domain member: In
that case, we have nobody to ask for the POSIX offset necessary to come
up with the uid.

It is important that even in such cases, the `HOME` environment variable
can be used to override the home directory, e.g. when Git for Windows is
used by an account that was generated on the fly, e.g. for transient use
in a cloud scenario.

Reported by David Ebbo.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 winsup/cygwin/uinfo.cc | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
index 5e4243fa4e..b79c2b265d 100644
=2D-- a/winsup/cygwin/uinfo.cc
+++ b/winsup/cygwin/uinfo.cc
@@ -904,6 +904,8 @@ fetch_from_path (cyg_ldap *pldap, PUSER_INFO_3 ui, cyg=
psid &sid, PCWSTR str,
 	    case L'u':
 	      if (full_qualified)
 		{
+		  if (!dom)
+		    break;
 		  w =3D wcpncpy (w, dom, we - w);
 		  if (w < we)
 		    *w++ =3D cygheap->pg.nss_separator ()[0];
@@ -914,6 +916,8 @@ fetch_from_path (cyg_ldap *pldap, PUSER_INFO_3 ui, cyg=
psid &sid, PCWSTR str,
 	      w =3D wcpncpy (w, name, we - w);
 	      break;
 	    case L'D':
+	      if (!dom)
+		break;
 	      w =3D wcpncpy (w, dom, we - w);
 	      break;
 	    case L'H':
@@ -2200,6 +2204,10 @@ pwdgrp::fetch_account_from_windows (fetch_user_arg_=
t &arg, cyg_ldap *pldap)
 	{
 	  /* Just some fake. */
 	  sid =3D csid.create (99, 1, 0);
+	  if (arg.id =3D=3D cygheap->user.real_uid)
+	    home =3D cygheap->pg.get_home ((PUSER_INFO_3) NULL,
+					 cygheap->user.sid(),
+					 NULL, NULL, false);
 	  break;
 	}
       else if (arg.id >=3D UNIX_POSIX_OFFSET)
@@ -2760,10 +2768,11 @@ pwdgrp::fetch_account_from_windows (fetch_user_arg=
_t &arg, cyg_ldap *pldap)
      logon.  Unless it's the SYSTEM account.  This conveniently allows to
      logon interactively as SYSTEM for debugging purposes. */
   else if (acc_type !=3D SidTypeUser && sid !=3D well_known_system_sid)
-    __small_sprintf (linebuf, "%W:*:%u:%u:U-%W\\%W,%s:/:/sbin/nologin",
+    __small_sprintf (linebuf, "%W:*:%u:%u:U-%W\\%W,%s:%s:/sbin/nologin",
 		     posix_name, uid, gid,
 		     dom, name,
-		     sid.string ((char *) sidstr));
+		     sid.string ((char *) sidstr),
+		     home ? home : "/");
   else
     __small_sprintf (linebuf, "%W:*:%u:%u:%s%sU-%W\\%W,%s:%s%W:%s",
 		     posix_name, uid, gid,
=2D-
2.38.0.rc0.windows.1
