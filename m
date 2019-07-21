Return-Path: <cygwin-patches-return-9502-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 47176 invoked by alias); 21 Jul 2019 01:58:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 47157 invoked by uid 89); 21 Jul 2019 01:58:24 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SEM_URI,SEM_URIRED,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=hang, cygwindevelopers, cygwin-developers, cygwincom
X-HELO: NAM04-CO1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr690091.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) (40.107.69.91) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 21 Jul 2019 01:58:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=T5x9Fqtv51aTBOdDsiYZ49+u2GM+qbwTJV9M93mtyZ+AeXq+xlnRjcKmovOxL+bzosfgTyctNE656DsGGLbsQPqsDn1E+Az9n86QNnQ+34cftdZAq9mEzQiNjsqtA5jSbLt4vhY0gWj6jpC0S7W9jY5y9et+lfU0DTWMckdC35AosrnIo+wtlIpG3wC2izOLyue6GjA5t/N4zrpz9P7YA6QqzjrzAs0QRpqJYSyrwXVnjAd9925xq/KtWACnLoidLleFMRJo4uRSvJgw8tPh8hntTuk1ik8bl5pauHI19f6Q3K0L20fjPxwlKNDzaqbzaSm/QVKZNA+Hl9GcpxDfUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=aluts8/GXQr7DW/i6bppu34b/NLl7PzmKxqbjsYtym8=; b=Yamst5cBLF4xaBzgbnsptEhj7mhVePeQxd/68FPdshZTht8FygVXd/gksmSAQcPpYpc9+7V3iRFzBBGNysWW9h66ijjHgbMo5mR1pRe+qj+u0krp6CNyLMUJ4kWjWqQ4tyyPDvJPNipG5jbk89T/ScXiXmSsAW6lLId6b7zCp5wIpJSBveCvdDQ9DlT3KuWUxUf6DlrFFrY31IdQMirRX7AD9UwGJm2S+FzvuPp2UEBg61hQb2MflyLQG8X8TgXaDZsuWQtHq2wuLC+Uc7Beod+ZA7VuqUvD8jGOprtdE7ROlHuQoXsvM99ecLwEUxAdNd1DO+/XRg1jsNcoQsCfjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass smtp.mailfrom=cornell.edu;dmarc=pass action=none header.from=cornell.edu;dkim=pass header.d=cornell.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=aluts8/GXQr7DW/i6bppu34b/NLl7PzmKxqbjsYtym8=; b=Pq8tYk9xNTaOan5s3UrHg79k3dj/f2IknVL7H9EDv8N3I0ABHa4j+psyoHQCo2dX7j4FJxQcN6Dk+2FQh0u+ddOgkJMMWXrcLWwhVGdOsoSPCqveUgarmgG1D7ZAw4mn5IzkbTeQluYPDV0qres6lgLACmU9Gm15xUwlgzjTAbs=
Received: from CY1PR04MB2300.namprd04.prod.outlook.com (10.167.10.148) by CY1PR04MB2250.namprd04.prod.outlook.com (10.167.8.150) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.14; Sun, 21 Jul 2019 01:58:19 +0000
Received: from CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8]) by CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8%8]) with mapi id 15.20.2094.013; Sun, 21 Jul 2019 01:58:19 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: document the last bug fix
Date: Sun, 21 Jul 2019 01:58:00 -0000
Message-ID: <20190721015803.2971-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-exchange-purlcount: 2
x-ms-oob-tlc-oobclassifiers: OLM:586;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00022.txt.bz2

---
 winsup/cygwin/release/3.0.8 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/winsup/cygwin/release/3.0.8 b/winsup/cygwin/release/3.0.8
index e3734c9b7..11d11db6f 100644
--- a/winsup/cygwin/release/3.0.8
+++ b/winsup/cygwin/release/3.0.8
@@ -11,3 +11,6 @@ Bug Fixes
=20
 - Fix a hang when opening a FIFO with O_PATH.
   Addresses: https://cygwin.com/ml/cygwin-developers/2019-06/msg00001.html
+
+- Don't append ".lnk" when renaming a socket file.
+  Addresses: https://cygwin.com/ml/cygwin/2019-07/msg00139.html
--=20
2.21.0
