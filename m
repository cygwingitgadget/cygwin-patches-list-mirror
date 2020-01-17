Return-Path: <cygwin-patches-return-9949-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 47533 invoked by alias); 17 Jan 2020 16:11:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 47524 invoked by uid 89); 17 Jan 2020 16:11:25 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM04-CO1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr690122.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) (40.107.69.122) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 17 Jan 2020 16:11:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=dBw3POcOGAQ4eXAEiS9t/NuEkBOQWtqKvq8P9/8lqE/3kb96uCsG3+RlD5KMu/s2RP+5AhdAZibVx+KIALVIr/m8cT7NLrpVLmjx3QH3BuLlJ9VvKDuVo5cZOtY76P5tlkGIdML2BrF3l8HjgcjsZ2jYMjMprspPL67ATo84M0l+Z9t4zu+5s5lZfcEO7Z1lr7VElQlSx6C/1EoaZfViCl+9soDpQqLfN6YMM6WW2PooVGqEXNWEQ+s0CYe7HIhJ45w6aYz1uDAahVvMvmge2cHYBUtfIow46IEAFeJYh3KSGGnjYBhi5dAgOWGdt5zXiXd7hoW6Td2UqF8es+kxNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=+8tKjAKpN4egFlaFKchE7uxfSgIWvJYnzenAYPwio00=; b=KxDSppQd3cJg13AaPk+7dolz6ygCw1OZ7s4sHWbhR+wxYAKA/skkvDbhnOWMMhkj0l4Ee8fnbFbjyucJ8YE1NGbBHCn29OCsXf+SULb1o4pU/r2GKstpZ65i3zf1TZBO7Yg81vgwkFt85kPb7Q3MhyPhOxZVS53Z2FhLHzedCVbQcXEFJ1e8Dgbg84d1CWB0oy3hRSAJY/kwmOq7J3RCNYbsghATkNFP1mNL1p+GOLtWxXvjIMDWj5rjNNW/InTYO0A3wSgRfQr4q5KEvQLXxfaR/u0WouqhcbWZ7FYeTLyS2RWU+citTnMMd36XhJuLT1PjfIinSQlAlg4OR3tfxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=+8tKjAKpN4egFlaFKchE7uxfSgIWvJYnzenAYPwio00=; b=RGNCsOJZ54K8pc2MXkPzup2HX1V2ilfvo110ob3F4orhMHjRtCaMuJVnbt+dmNTnz88KNpkzciNjpr/50UA60yDBemuxB+qR2MN2wC1suWhmOdYmvl7Q2HF9ecB9ghcZqaxKQIUaUmIBzr2kpifWyCX9Cf1uOVkYb+EiL6qsDZI=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB4761.namprd04.prod.outlook.com (20.176.107.144) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19; Fri, 17 Jan 2020 16:11:00 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831%7]) with mapi id 15.20.2644.015; Fri, 17 Jan 2020 16:11:00 +0000
Received: from localhost.localdomain (65.112.130.194) by BN6PR14CA0035.namprd14.prod.outlook.com (2603:10b6:404:13f::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend Transport; Fri, 17 Jan 2020 16:11:00 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH v4 1/4] Cygwin: allow opening a symlink with O_PATH | O_NOFOLLOW
Date: Fri, 17 Jan 2020 16:11:00 -0000
Message-ID: <20200117161037.1828-2-kbrown@cornell.edu>
References: <20200117161037.1828-1-kbrown@cornell.edu>
In-Reply-To: <20200117161037.1828-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:2582;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p/7ErK4rn7SVbx3nG1B9p2fX+b3cGE/d1GySiAmdQc4s3D/31qYiEjGLdSzlVn6eXQFgBOlTb3n2IY+fo24LMQ==
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00055.txt

Up to now, opening a symlink with O_NOFOLLOW fails with ELOOP.
Following Linux, allow this to succeed if O_PATH is also specified.
---
 winsup/cygwin/syscalls.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 20126ce10..038a316db 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -1470,7 +1470,7 @@ open (const char *unix_path, int flags, ...)
=20
       if (!(fh =3D build_fh_name (unix_path, opt, stat_suffixes)))
 	__leave;		/* errno already set */
-      if ((flags & O_NOFOLLOW) && fh->issymlink ())
+      if ((flags & O_NOFOLLOW) && fh->issymlink () && !(flags & O_PATH))
 	{
 	  set_errno (ELOOP);
 	  __leave;
--=20
2.21.0
