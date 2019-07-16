Return-Path: <cygwin-patches-return-9486-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 105245 invoked by alias); 16 Jul 2019 17:34:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 105145 invoked by uid 89); 16 Jul 2019 17:34:34 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=california, California, 1990, HX-Languages-Length:765
X-HELO: NAM01-SN1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr820093.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) (40.107.82.93) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 16 Jul 2019 17:34:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=Ly9o2Y6LvJWOq/BlinHpc7mo+sAmEBfnRdiPBYdXs37khen/zpf+tGDzd0dHeghP/Zsh4DqOv4XFKfeNKDp2EWuNYampjX4j/kggFsCfkZLYnrDAp7ui0fhwvUtU7fqe0NvtMgZ/hSTB1u8ca9O7Uh9k3IUncA4f7ZDhPSPwOyhnwbrlVdjH5UPgwlWwGo/3QDlzxkWbc4Pb7sGitEbVdrI7f2XCc6QRNfRigaMXm036FSfHc5Y7eAk3AiinnKioYpdUAicRqyEAOuZTZeDmbS4PSWm6UV1lOxW3TtdVLiJz7ccTI40yzW8z9LIkdiov4UIKeS+luq2GGBIQafHPJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=vuc6mTdX+7HqmHjxsxcuuyG33amUBN1v0Ct1C9PciSc=; b=JitWPxKYF+b3SH+/xlRckPljG2hzI6dURnDaWacXOvpMOXKPUoATuIBMIkGI8YF9oLyZaaVKaWBzcpqSuSVBQ94Mbzxv99eRh2p4Eyue8K0Oh0dzUPNVSDIhuOF4upM5Fb6LNDuoVaxey5HPuMQaJsc4Z9oVz/fvRtV2dFzRV+QkB+3HhbYq6/DaqQDkSIEwxGvQaby96ota8ZbsPnXG4+CtuDbrQlTiwzh06VRtdJG38jvy8Gn+WWK55mxFnQsdh8VlhHG3BHckLy0PEvjL4LP8Jg7PMXCtvG8fGFep4tF9x1LkiiKq0kPHHUbowvJMjw0xd45yoEbnhXjlT4fDSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass smtp.mailfrom=cornell.edu;dmarc=pass action=none header.from=cornell.edu;dkim=pass header.d=cornell.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=vuc6mTdX+7HqmHjxsxcuuyG33amUBN1v0Ct1C9PciSc=; b=UplFrV7XIbQUYlan5XJKcT/AU/AUL0L8/+q5GimjSmR6xJmepT6Fs93IugI4WGMdRjQ6vCZfN2qKsYDG5/b6YlNlwjtk+JQ2VsYtJuxXayCNb42n1NZhpej1RstROBwtX9RnzFMXsLb6QBAmHEknIWZHqQUxktUu/CyMoIezdOA=
Received: from CY1PR04MB2300.namprd04.prod.outlook.com (10.167.10.148) by CY1PR04MB2234.namprd04.prod.outlook.com (10.167.16.18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2073.14; Tue, 16 Jul 2019 17:34:27 +0000
Received: from CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8]) by CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8%8]) with mapi id 15.20.2073.012; Tue, 16 Jul 2019 17:34:27 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 4/5] Cygwin: fix GCC 8.3 'asm volatile' errors
Date: Tue, 16 Jul 2019 17:34:00 -0000
Message-ID: <20190716173407.17040-5-kbrown@cornell.edu>
References: <20190716173407.17040-1-kbrown@cornell.edu>
In-Reply-To: <20190716173407.17040-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:3826;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00006.txt.bz2

Remove 'volatile'.
---
 winsup/cygwin/miscfuncs.cc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/miscfuncs.cc b/winsup/cygwin/miscfuncs.cc
index e02bc9c1f..0bbf4975d 100644
--- a/winsup/cygwin/miscfuncs.cc
+++ b/winsup/cygwin/miscfuncs.cc
@@ -724,7 +724,7 @@ err:
    See FreeBSD src/lib/libc/amd64/string/memset.S
    and FreeBSD src/lib/libc/amd64/string/bcopy.S */
=20
-asm volatile ("								\n\
+asm ("								\n\
 /*									\n\
  * Written by J.T. Conklin <jtc@NetBSD.org>.				\n\
  * Public domain.							\n\
@@ -791,7 +791,7 @@ L1:     rep								\n\
 	.seh_endproc							\n\
 ");
=20
-asm volatile ("								\n\
+asm ("								\n\
 /*-									\n\
  * Copyright (c) 1990 The Regents of the University of California.	\n\
  * All rights reserved.							\n\
--=20
2.21.0
