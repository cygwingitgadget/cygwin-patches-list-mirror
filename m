Return-Path: <cygwin-patches-return-9487-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 105525 invoked by alias); 16 Jul 2019 17:34:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 105449 invoked by uid 89); 16 Jul 2019 17:34:35 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-21.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM01-SN1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr820093.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) (40.107.82.93) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 16 Jul 2019 17:34:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=C4QLNFKyB5H+pvFLCpo0RE31KeufgvN10Oqq0IXsmlpYlsQd22bR40FVnODi7tGns0OQeA0qxYiDInRngU6TxoLRfob1bkpy015M5rKHbZQdcbw4oJku4nMvnb9bCelr40FaG85T62DaSdGfRhcuRys9jha18Wa4P2RgjXAlTYEdvQ7F5L6dGuzulp12TyAJC2wVairRN2Ex18rG6ZyFg39Dk98nasaQiNxEODmvG5vBgaEJqmMbDAFMgwsuzBdcdKAH9MPRmIeYLF+cZ3MIdrevZK26pSIOXIOslLdk/BNtQsVu3aZI9KidxbdwPvk6I5uBVAVRZqUiBdRGpJyB8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=WZFbmhwtQpfVfv8l7tJYoPthFkq8bpSZMgBg+aaZB4Y=; b=EfbKehW2IsHQd+vDNxYSL5arHIdGj1B0m5tGwjAIMOjRKmceBynHSpExhbPRsV2CvMdBnm+lyBIBE8HhY+SgqeR0KGcow4lXSlKTcRCwz1wROehQc6R8+n0288vwGcBtu6LieaHORHGBjL+RutzgF4BNUv0zug/avbbyMew+o4F67ipxexMeuMcnCluwHhuBtJjGB020SwuonPMcjItH5GI6Pk+8/yS5lYU+ukv2HTxNORocHAlQL7RPg0Ss2uxTJ0e9YCN17cXmXo+4F3v9gYv593zB/xl36MewHjdHiYtxeoSVW9PIn+otLDS1WiGId8lXnDsrBp6yRhCg5JGeLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass smtp.mailfrom=cornell.edu;dmarc=pass action=none header.from=cornell.edu;dkim=pass header.d=cornell.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=WZFbmhwtQpfVfv8l7tJYoPthFkq8bpSZMgBg+aaZB4Y=; b=RPUX8tFEhuINvPt8WnBoHo1MTmooKBF7ZnEG/ECojMr2EqxubWWsswOz8d+Un2nvUqlgX9B9ukZPVCPdtlSPm1DYnaMSsGjRimNo6WyiYc2Dd/7qShew7vsrKOTwVaz3Jv6Q1dKrYO7gBeRemKoggYL2y8MRxNloIHAQFY0CvtA=
Received: from CY1PR04MB2300.namprd04.prod.outlook.com (10.167.10.148) by CY1PR04MB2234.namprd04.prod.outlook.com (10.167.16.18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2073.14; Tue, 16 Jul 2019 17:34:28 +0000
Received: from CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8]) by CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8%8]) with mapi id 15.20.2073.012; Tue, 16 Jul 2019 17:34:28 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 5/5] Cygwin: fix GCC 8.3 'local external declaration' errors
Date: Tue, 16 Jul 2019 17:34:00 -0000
Message-ID: <20190716173407.17040-6-kbrown@cornell.edu>
References: <20190716173407.17040-1-kbrown@cornell.edu>
In-Reply-To: <20190716173407.17040-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:331;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00007.txt.bz2

Move external declarations out of function definition.
---
 winsup/cygserver/bsd_mutex.cc | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/winsup/cygserver/bsd_mutex.cc b/winsup/cygserver/bsd_mutex.cc
index 52531bc72..13c5f90e8 100644
--- a/winsup/cygserver/bsd_mutex.cc
+++ b/winsup/cygserver/bsd_mutex.cc
@@ -275,13 +275,12 @@ public:
 };
=20
 static msleep_sync_array *msleep_sync;
+extern struct msginfo msginfo;
+extern struct seminfo seminfo;
=20
 void
 msleep_init (void)
 {
-  extern struct msginfo msginfo;
-  extern struct seminfo seminfo;
-
   msleep_glob_evt =3D CreateEvent (NULL, TRUE, FALSE, NULL);
   if (!msleep_glob_evt)
     panic ("CreateEvent in msleep_init failed: %u", GetLastError ());
--=20
2.21.0
