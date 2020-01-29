Return-Path: <cygwin-patches-return-10031-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 40842 invoked by alias); 29 Jan 2020 17:22:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 40752 invoked by uid 89); 29 Jan 2020 17:22:20 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM11-CO1-obe.outbound.protection.outlook.com
Received: from mail-co1nam11on2092.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) (40.107.220.92) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 29 Jan 2020 17:22:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=Ideur8MBDwnCQgOoRM7SqcdFfNYpRRcwSY/lCQJKgyyA4bGBa8062HpH6GnWpcdEntk4w/nrLVPz8aCxrMyUeImDlOHIy1xHasiKSa3eUNe30pno4nESS7G4vHDEkcRunhC4TJcHsLxMRZ09nwove9EifjpzuoUfVAbAKndpAS5SnZP4GQy9HyQ8k2IHlhLxFSl6OlQicXgFS8/ACgBfWXTkEqonYCFgjgNfHewZNUu0JN8utCVIiB+CmpdcH71doiEHCQnT/lmS+mTINLPRa5jNY9kRcJJssib7IPtvuexNxxRghb0DKwHfILbxTfubLFvZBpEWUCMa76s/cgqC9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=zjbv6c/2NEd0YVd93hyUa0u+JqAxgY/MLQ2wNFbejhM=; b=Z56O/JepSMhD0doMzoVnRbxx9683mFnk/M57qO0Z2YLpvrPxq4tVm9hcIK4U4og/c/WKmq6jP/OSWOlYAOWwguqbcljeD9Gy7NEOfHcZFM/jVW5G4wIzjIFWiOcGG7fccLomacFBq8xi2lJ1KE8UJZEYICKVfTmoVvQUHoK935f8aH9/QZiLNVwoSb22ENyYjLE/50aVddsk7kxKaXy5nKW2h3p42fsdNB2uCde9mGc7rPkROAVNSmN0sKlX/Y+CH5IFonL+LqKt4oiOv0NCchPLcDXAWgqPSeJ7KcC3X3aQwYPSkCjjKO6t/42HgLKmp1d6zH66HVW6iBZ5yUXzcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=zjbv6c/2NEd0YVd93hyUa0u+JqAxgY/MLQ2wNFbejhM=; b=RPkwop6K6W5f5Ou2U/1pHxcCxWPCdmunCYgzZKuJQ51Pv0NZ3riqYqbaDNIkZo0faO05ZvYKi1I2uIfEWhiO0gxd+JbrSLaZ2bwmUIZbCCrE8furNw1lsoDgRtmGFYimJeTsyf+SEoGAN0u9DWlU3v2hwCSDXMAhcixp0EXUUVo=
Received: from BYAPR04MB5735.namprd04.prod.outlook.com (20.179.59.153) by BYAPR04MB3896.namprd04.prod.outlook.com (52.135.220.152) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.26; Wed, 29 Jan 2020 17:22:13 +0000
Received: from BYAPR04MB5735.namprd04.prod.outlook.com ([fe80::5142:1dd7:256:399]) by BYAPR04MB5735.namprd04.prod.outlook.com ([fe80::5142:1dd7:256:399%5]) with mapi id 15.20.2665.027; Wed, 29 Jan 2020 17:22:13 +0000
Received: from localhost.localdomain (65.112.130.194) by BN7PR06CA0042.namprd06.prod.outlook.com (2603:10b6:408:34::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend Transport; Wed, 29 Jan 2020 17:22:13 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH v2 5/5] Cygwin: document recent changes
Date: Wed, 29 Jan 2020 17:22:00 -0000
Message-ID: <20200129172147.1566-6-kbrown@cornell.edu>
References: <20200129172147.1566-1-kbrown@cornell.edu>
In-Reply-To: <20200129172147.1566-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:7691;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-messagedata: 1120gSwHrxMewCubiKC/a0JUyFLwTekVp4I+Wofa23nJlbrUmxxpEmUOH+idA4Otp79HmU7JLgYddj4fmChEoL8U4H0+WlSq4UAAfeCYxrpJ12z0GvHIDwZ2o+puzfpmhm/6KzEQeWnOqz6lB23ewQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KTdzdiOxVSfNSQJfensEkG/oGHkVACi7bJgoVtuaGBFLQzWbMFtPMygXLMsHdEvRT7OgZsPsWxiCzVVWpZ3rfw==
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00137.txt

---
 winsup/cygwin/release/3.1.3 | 2 ++
 winsup/doc/new-features.xml | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/winsup/cygwin/release/3.1.3 b/winsup/cygwin/release/3.1.3
index f8752ad56..06ed1eb57 100644
--- a/winsup/cygwin/release/3.1.3
+++ b/winsup/cygwin/release/3.1.3
@@ -11,6 +11,8 @@ What changed:
 - Support the Linux-specific AT_EMPTY_PATH flag for fchownat(2) and
   fstatat(2).
=20
+- Allow AF_LOCAL sockets to be opened with O_PATH.
+
 Bug Fixes:
 ----------
=20
diff --git a/winsup/doc/new-features.xml b/winsup/doc/new-features.xml
index 967c64ac5..78c7760cf 100644
--- a/winsup/doc/new-features.xml
+++ b/winsup/doc/new-features.xml
@@ -69,6 +69,12 @@ Support the Linux-specific AT_EMPTY_PATH flag for fchown=
at(2) and
 fstatat(2).
 </para></listitem>
=20
+<listitem><para>
+Allow AF_LOCAL sockets to be opened with O_PATH.  If that flag is not
+set, or if an attempt is made to open a different type of socket, the
+errno is now EOPNOTSUPP instead of ENXIO.
+</para></listitem>
+
 </itemizedlist>
=20
 </sect2>
--=20
2.21.0
