Return-Path: <cygwin-patches-return-10026-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 39882 invoked by alias); 29 Jan 2020 17:22:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 39873 invoked by uid 89); 29 Jan 2020 17:22:13 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-12.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=opening
X-HELO: NAM02-SN1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr770104.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) (40.107.77.104) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 29 Jan 2020 17:22:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=OdiHFZ84djDFXE5vG8UCnIGqcNT19fcMQqHp0TQ7Zc+P3W3HHkhDCDCzp/liq+AajIDItAVkarEbQd7kHXQSDEridWpHugE4FTXanEfJMQRdBhYlRSbgGIgAwQq0OedmNv8Mk/XEvk5vo/2Jn05H//RyvKR09TmJWcJqF7c+8d8e/vrkntFi2+MAHc+0vmaxNc8bA5kVf7OECLZh1GqoNaeVTSNrxgcFeAinUaJeGz4Axcoh1zWkLNfc14Qa0QWFJ7vTks7RcTaK2nGuYFCgbszM13+cxaKM+6hZ95C/MQHAvaF6laSOHDQuF8m5A6WaVJfn5CNwL435tDk+y06PHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=cP64mQ45OMPwEmYhR4pfr3quE85OqfWUdbYXwJ01+nE=; b=NgB56eDqKqL7SyxvsuGwVd+7xudKto5ST4eme9M3URlNkbvcwGi4rax1pTTu3U3xgCGdHmAB0rKuEmXP9CaCG6bFDdXJY4bVlKxB+yQhB3MOOEQAaRQ/k5I6ekTf9wJ9P3yNi0X4MzwhllAsebENg6FGPMCh3rbfnYDjHODDrLtLxrukZqffJHxWV+AnHmt9xAE2wg/ycIkvq9mdYjSl0T11h2R7DNqBvQNJcxYR4L184qdwnES196365zMOOGoC3Dh0oUnp1VN2tbnyFPl/+MWMxEK7HLPDnUIuHJJ+uLsKeURfX7sMf7tVOyCudIeL+JXmE3vf7VsIsK7WvHIwnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=cP64mQ45OMPwEmYhR4pfr3quE85OqfWUdbYXwJ01+nE=; b=K1X4pYIhE+G4FOiyQ9JCObUVKkdxcfTJ/PYuSCCepaiYI8b5jx9lxApEB9c8gbP9p52oszv9c8cYdc7JC393fB5OH/ObqQhVTP2K/TI/i9n0GRWRvPO9+IQ2FmeCiFBUfTVbIyQjj3EAxMDXXhMgTnW5jlwl+r5uVKW860vrMF0=
Received: from BYAPR04MB5735.namprd04.prod.outlook.com (20.179.59.153) by BYAPR04MB5432.namprd04.prod.outlook.com (20.178.51.153) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.24; Wed, 29 Jan 2020 17:22:10 +0000
Received: from BYAPR04MB5735.namprd04.prod.outlook.com ([fe80::5142:1dd7:256:399]) by BYAPR04MB5735.namprd04.prod.outlook.com ([fe80::5142:1dd7:256:399%5]) with mapi id 15.20.2665.027; Wed, 29 Jan 2020 17:22:10 +0000
Received: from localhost.localdomain (65.112.130.194) by BN7PR06CA0042.namprd06.prod.outlook.com (2603:10b6:408:34::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend Transport; Wed, 29 Jan 2020 17:22:09 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH v2 0/5] Support opening an AF_LOCAL socket with O_PATH
Date: Wed, 29 Jan 2020 17:22:00 -0000
Message-ID: <20200129172147.1566-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:6430;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-messagedata: NA5EhwevF7Z+Er2bLH/7bv0jDwGcv74lQgYK6PWPvAhs2uETrMC6WfqY3kxjm4SczEcqowiKmbHSc1TwTZC+QGbfeM++xbuUSbGeAN2bOtdlXnq32f0Za6tcReGQ7DJfRIrl98N3UtW0BZmfafFM9w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LmZmjT0ylJAsU+dnPnWs8X1OUDgzvYn1/HCBwfYtA9Ao2C2R9bxvkDdk2DICzBIVasXTi26M9nxC+eNDJDSZ2Q==
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00132.txt

I'll follow up with the program I used to test this patch series.

Ken Brown (5):
  Cygwin: AF_LOCAL: allow opening with the O_PATH flag
  Cygwin: AF_LOCAL: set appropriate errno on system calls
  Cygwin: AF_LOCAL::fstatvfs: use our handle if O_PATH is set
  Cygwin: AF_LOCAL: fix fcntl and dup if O_PATH is set
  Cygwin: document recent changes

 winsup/cygwin/fhandler.h               |  3 ++
 winsup/cygwin/fhandler_socket_local.cc | 39 ++++++++++++++++++++++++++
 winsup/cygwin/net.cc                   | 19 ++++++++++---
 winsup/cygwin/release/3.1.3            |  2 ++
 winsup/doc/new-features.xml            |  6 ++++
 5 files changed, 65 insertions(+), 4 deletions(-)

--=20
2.21.0
