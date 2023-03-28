Return-Path: <SRS0=deyK=7U=gmx.de=johannes.schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by sourceware.org (Postfix) with ESMTPS id 72ACC3857B93
	for <cygwin-patches@cygwin.com>; Tue, 28 Mar 2023 08:17:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 72ACC3857B93
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1679991446; i=johannes.schindelin@gmx.de;
	bh=5LQUrqmI7XGa7+3RC4f+CsYFf+R2VQ5ModZbV3onOWU=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
	b=mWBxNQgrXEelTqjywjzYYiBva1zYCrWH/U30+wOL2LArawFGRZVf7pVqX0oQBw1RL
	 ND7BaNwN7qUczZDL/29Spn15drdpSOuJohLBPd637KGV2Md9AtGX6N7KV8fyta4KE1
	 EkthlZi31hMWo+d95tBjxA5y2E2dm3OW6SLMRA0YKnueOXjgLGnf+KcOr8AMmld3t4
	 POPqH3KcgyNFDykWYbZER+enw7yaEZ/7gqCVW/FnsGzm4Stp0hqnQWgiOcr3IGfwCZ
	 buovwRkajjxF9kbFLJT9TaIiejS+HOki38rVs6HHcWSXDmCHIcM2J1d3pJBCH4DO/Q
	 1/DPSc5Ub00nA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.93]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPokN-1q2sej17gJ-00MqD3 for
 <cygwin-patches@cygwin.com>; Tue, 28 Mar 2023 10:17:26 +0200
Date: Tue, 28 Mar 2023 10:17:25 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH v4 3/3] Respect `db_home: env` even when no uid can be
 determined
In-Reply-To: <cover.1679991274.git.johannes.schindelin@gmx.de>
Message-ID: <4cd6ae73074f327064b54a08392906dbc140714a.1679991274.git.johannes.schindelin@gmx.de>
References: <cover.1663761086.git.johannes.schindelin@gmx.de> <cover.1679991274.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ph2AuDoaNJFukpQ70UgLfkaJmSzgrWlaxW7w/+tcciHFKRdLrbw
 X1XIgzgmgVXFL/WGRPgLBCf4W5EjNBMguk+S1R+ylfCJMJv6llZEs4pBCZiRsaURxz2C35E
 NcpnkFaiE0XgLZ03+4PgjSDHxKJF+JBEk228x/WjD2bkXU6P8jASXb9wzBnrhOnTHgfrPz3
 gACuF5a22LV4ejUctHLiA==
UI-OutboundReport: notjunk:1;M01:P0:du2RGYpxOT4=;p4Ve2vEBFcHCMzMTEw0Ao0cNNG9
 lDp8eD/ckRP3QPWe/3WNrGnj1gsPmFBtQS+kuefLcqTGNVpTvbTq3d6wM+uNr9fe0UAdezwKk
 u6dBq9tnQZ/GnkWJztljgGpm9TzF9R+RraOTYP329qOBG00Qd5e3Sgs7HrFWaK1jtsr9pgRZz
 t8aI770nQRTSOc/4sGYEK90ywlzJfXs0+4g1VSIi1Qf/7lLYB0chdC/6o6Caht0WD1E0Lht3z
 ha3j2Yx2wkghFr/V2qDfF3IW4xvWfqDvk8tV9Mk4qXUOzkqRk9TSzm1gYnG0RuQpt9k+YWXBB
 cM/0C0GTzNsEwQUQy6hb3phLhasasHzQQQf5YJw7vvviJa2eH0Yp0/ztBpk24wR8FDBS+VffF
 LsoqiFH1Y+arkkmEoftiypFaay/58yvbBDMLiiPOPFVBF7jVFQqu+j4PYx64ue0DD8og7VuSq
 OmePFB9hto3cYw/lUJdNUrj92yAFz+e0g0ktVgIwiGKmTXtWNoIojOC5gyz3TVAcpqRx6oaWj
 7fvsZEh8btiISThn8cqQ73unprJ9rpyuyKvx5PRpytfY+hn/+Cad4shSIguhWkwnO5lKI5yeQ
 o7ZFoyK1qRgr6hq6CjjQx5Hp4q9Dih0h2DUTtTDNeICQs/tYWCMBJotM5KEfQSIT96/tMgDqN
 PBdeR711S8yw8yX/WdQtlB2fQnXMAkcnoFr2dBoNGkarWmFvka9qjEKt4g+On7ufeM3vBPg86
 jWnBIqUj4t9cHew1VW4j529D75A68vuq5H6qCE3lzBzdyNBV9x0GwgcjMTSIwfJ1uQ5wLtIe6
 l7Frw+6BkOL8uTFMPC1i2E5yfNLf8SqvmwhXFG3EpnyLnjaNyvGCEHi7/MQ7MOaW6GkhWsRb7
 uV/ykFHcA8p+VxGKizIiXl/N38YQcQf2dUqeXAzbVsX4N1Eto24mN7UytL6wc17UOrFoMT20I
 U1CmMPvmfO9qgJGH35WhA/b9Nxo=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
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
index d493d29b3b..b01bcff5cb 100644
=2D-- a/winsup/cygwin/uinfo.cc
+++ b/winsup/cygwin/uinfo.cc
@@ -883,6 +883,8 @@ fetch_from_path (cyg_ldap *pldap, PUSER_INFO_3 ui, cyg=
psid &sid, PCWSTR str,
 	    case L'u':
 	      if (full_qualified)
 		{
+		  if (!dom)
+		    break;
 		  w =3D wcpncpy (w, dom, we - w);
 		  if (w < we)
 		    *w++ =3D NSS_SEPARATOR_CHAR;
@@ -893,6 +895,8 @@ fetch_from_path (cyg_ldap *pldap, PUSER_INFO_3 ui, cyg=
psid &sid, PCWSTR str,
 	      w =3D wcpncpy (w, name, we - w);
 	      break;
 	    case L'D':
+	      if (!dom)
+		break;
 	      w =3D wcpncpy (w, dom, we - w);
 	      break;
 	    case L'H':
@@ -2181,6 +2185,10 @@ pwdgrp::fetch_account_from_windows (fetch_user_arg_=
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
@@ -2710,10 +2718,11 @@ pwdgrp::fetch_account_from_windows (fetch_user_arg=
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
2.40.0.windows.1
