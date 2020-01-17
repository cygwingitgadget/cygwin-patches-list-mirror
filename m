Return-Path: <cygwin-patches-return-9948-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 47096 invoked by alias); 17 Jan 2020 16:11:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 47087 invoked by uid 89); 17 Jan 2020 16:11:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-12.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM04-CO1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr690122.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) (40.107.69.122) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 17 Jan 2020 16:11:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=j79svHY09Dzk3Su8WXIbvCRi32/qYCoktGgdz0nbKCnfzqDCLkPIbQsssQSvYBdtNesDVdXkJh/T9pPwotx6t+Zt1c/S72Ewop1RA2DQlfFYm5+xmioagCFnczDLKtJ1sG7b1cA6OJb01v0oOIuRI84GgAHPzIGfKru25nQ55OidXr5dzTqLfq3TMnOEzLnfbEnrPhtNfYJnAJT/t2uTnuIQVuEAMx7oQkf86Y3nLGc+hd4hBv70po58UMANnxuC3piXmhqcmkKfbBd6ZXXvWGQ0+fbXyvncgyZAc+6uVd4ixQ3Vm3QlP+fJDAUJNh4fB2E5Npp6J2pnT5RhQcR0fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=TnQoSBDQ5VvdO5+BuuEXBZZOR7sxoN16ai3xdjhSswM=; b=bYUt94zF59jU09Yu9kJD0JjSQV5niEvvz1LHfdvWANghyTGW7lQQh7StBxuXJT2MOAWq6DFrnwwEa+PcFPDFPWIclobq9s29pSg8lQYqGGJx03icWo4u718KdpqNv4fDtvNV65bFzwctX9LG37vbJECK6TrRl/Ofy9K0BfDC6xHNa+Twi9HEbl0zCGECtnpEZGSMljkZi+bDF4V8OmVjZNO/qbJJdoU3SbcewooBIHSCddyeV1TgDspYuJ2IUGX5jpeHalFQAwMwzE2IqBAhgVpAyfO7tlQRbAQ5xreFaTR2FE2NK5ysm6HMBYcxgGgMi9rEA+fz5oMSs1oylB/1Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=TnQoSBDQ5VvdO5+BuuEXBZZOR7sxoN16ai3xdjhSswM=; b=cP5a2Mbp5rVJcoqZN9tf5MD9xYQiSCs/6BJrzra4j+2LxKXRiK+wP6/FVyJm5RSUQrmg1FNGHm4BfTz7bid8ND9yqR9yL/22l60X3Z9FyuQW31iCAq1UncVE3x4jmzg7YNCor00fTs62JTD1KoDUGgrWDL5FzabXhJjAAQvSQOU=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB4761.namprd04.prod.outlook.com (20.176.107.144) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19; Fri, 17 Jan 2020 16:11:00 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831%7]) with mapi id 15.20.2644.015; Fri, 17 Jan 2020 16:11:00 +0000
Received: from localhost.localdomain (65.112.130.194) by BN6PR14CA0035.namprd14.prod.outlook.com (2603:10b6:404:13f::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend Transport; Fri, 17 Jan 2020 16:10:59 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH v4 0/4] Support opening a symlink with O_PATH | O_NOFOLLOW
Date: Fri, 17 Jan 2020 16:11:00 -0000
Message-ID: <20200117161037.1828-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:8882;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AyxvrPb/X7pZU6Qzci5l2ZlF5HIi8s3XSr49tAJVSN69oeJx/1mirhGMs27S53pPP0LhXcPubfhVMoqXQwXnsA==
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00054.txt

Currently, opening a symlink with O_NOFOLLOW fails with ELOOP.
Following Linux, the first patch in this series allows the call to
succeed if O_PATH is also specified.

According to the Linux man page for open(2), "the call returns a file
descriptor referring to the symbolic link.  This file descriptor can
be used as the dirfd argument in calls to fchownat(2), fstatat(2),
linkat(2), and readlinkat(2) with an empty pathname to have the calls
operate on the symbolic link."

The second patch achieves this for readlinkat.  The third patch does
this for fstatat and fchownat by adding support for the AT_EMPTY_PATH
flag.  Nothing needs to be done for linkat, which already supports the
AT_EMPTY_PATH flag.


Ken Brown (4):
  Cygwin: allow opening a symlink with O_PATH | O_NOFOLLOW
  Cygwin: readlinkat: allow pathname to be empty
  Cygwin: fstatat, fchownat: support the AT_EMPTY_PATH flag
  Cygwin: document recent changes

 winsup/cygwin/release/3.1.3 | 19 +++++++++--
 winsup/cygwin/syscalls.cc   | 68 ++++++++++++++++++++++++++++++++-----
 winsup/doc/new-features.xml | 19 +++++++++++
 3 files changed, 94 insertions(+), 12 deletions(-)

--=20
2.21.0
