Return-Path: <cygwin-patches-return-9246-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 93542 invoked by alias); 27 Mar 2019 18:10:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 93533 invoked by uid 89); 27 Mar 2019 18:10:23 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-13.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=para
X-HELO: NAM01-BN3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr740123.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) (40.107.74.123) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 27 Mar 2019 18:10:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=Q4W65tgBUr834i2E1Vlz7MpNEs1R6/xeoCGWAJCtmZM=; b=o29e+5AKNGaV0EqMuFdbgwsLgUg1A5r8bbQVXMu6oOdNg9O5n/SOGOXBP2LVBQ5t0Eb6M84qGNqEgqc9YZtVxcWc/fMxIInU8/ZmxDPMG4u22r+ZLeqKYUEYoMgRe1QVKU9PchvlAqQBKn2d5fGV8DOi3f0p6H2Xa6aHMCQmkVw=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB4620.namprd04.prod.outlook.com (20.176.105.209) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1750.15; Wed, 27 Mar 2019 18:10:19 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::14fd:138e:c16b:52d]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::14fd:138e:c16b:52d%4]) with mapi id 15.20.1730.019; Wed, 27 Mar 2019 18:10:19 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: document the recent FIFO changes
Date: Wed, 27 Mar 2019 18:10:00 -0000
Message-ID: <20190327180959.59644-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-exchange-purlcount: 2
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-IsSubscribed: yes
X-SW-Source: 2019-q1/txt/msg00056.txt.bz2

---
 winsup/cygwin/release/3.1.0 | 14 ++++++++++++++
 winsup/doc/new-features.xml | 12 ++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 winsup/cygwin/release/3.1.0

diff --git a/winsup/cygwin/release/3.1.0 b/winsup/cygwin/release/3.1.0
new file mode 100644
index 000000000..1f017bfd1
--- /dev/null
+++ b/winsup/cygwin/release/3.1.0
@@ -0,0 +1,14 @@
+What's new:
+-----------
+
+
+What changed:
+-------------
+
+- FIFOs can now be opened multiple times for writing.
+  Addresses: https://cygwin.com/ml/cygwin/2015-03/msg00047.html
+             https://cygwin.com/ml/cygwin/2015-12/msg00311.html
+
+
+Bug Fixes
+---------
diff --git a/winsup/doc/new-features.xml b/winsup/doc/new-features.xml
index e14fbb1e8..c87601e9d 100644
--- a/winsup/doc/new-features.xml
+++ b/winsup/doc/new-features.xml
@@ -4,6 +4,18 @@
=20
 <sect1 id=3D"ov-new"><title>What's new and what changed in Cygwin</title>
=20
+<sect2 id=3D"ov-new3.1"><title>What's new and what changed in 3.1</title>
+
+<itemizedlist mark=3D"bullet">
+
+<listitem><para>
+FIFOs can now be opened multiple times for writing.
+</para></listitem>
+
+</itemizedlist>
+
+</sect2>
+
 <sect2 id=3D"ov-new3.0"><title>What's new and what changed in 3.0</title>
=20
 <itemizedlist mark=3D"bullet">
--=20
2.17.0
