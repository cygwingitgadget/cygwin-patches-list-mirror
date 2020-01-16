Return-Path: <cygwin-patches-return-9940-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28428 invoked by alias); 16 Jan 2020 20:50:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 28414 invoked by uid 89); 16 Jan 2020 20:50:10 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-8.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM10-MW2-obe.outbound.protection.outlook.com
Received: from mail-mw2nam10on2122.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) (40.107.94.122) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 16 Jan 2020 20:50:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=Y7aJp2K+3VZpHAorCFZTpktg4y71WxaJIUpYNvM+AtrFBI6qmGq3/PbVeOisCKdW/irvr2i1biSyfXPv30Yi0e0KEFxdtUnWL3uiINqj3xNmI4oBNFgcDcKltTE7wMGOTmdjwANTPItg1yaII2ViDCEytdO/LkqR8a0Sgnqpy4JkIvafV131MugUj/GPbl7D9barFWQz5pzzkCPd31jnZwSrGwYZJyR057gO417V+KzKq00JPfS629P2G8xsxgm7LdWip55UlKgjut5Jk2kac9aAtOUWXd6CKgs5ZrSWmoH100ORauAtlfmMmOU7eeDWhvZ3QLFgiHRe0fCwk3N3AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=E6yB9KmxAqQJqQ0XbdlHsmEb+rfDqXvH+vVNYB3vFVg=; b=R6LH2DCEy0+Sr379La807eMQLQg/mOn8xY0bNqLYuArbdIMmXrM9bmlc2pqlwwF2+Lst2Cxb8gHY+ysASTgWfRpqnQIGtO+GXA07EjBbV9B9PwxvR93VD7A5xMGA2dtyUysTRHhZFRhtJ1gPlM/slqhzVkzw2D+q3EvFGV4nvKWjhClYXAwzrqYuOBOVRX73iZ/CydwPz0nJeURkFZBH5NTEh9AvWHnqV86bv8Gqv914WW4fkV5FtdZ0UDJcCapx/Y/rs9ZH+tunusmf+FdGD0y5WKUo/5oo/GlWClWDf2VslJkq9GXsd9k+nFvLU9dSjR68LaBKz8vsaVpJJgLdLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=E6yB9KmxAqQJqQ0XbdlHsmEb+rfDqXvH+vVNYB3vFVg=; b=YYLgo/S0lsNEA7fGHx7+xT4U/O2V0hyQjMQIw80KSL2u66jgQRRVozkEZRU7gA/IZA75s9yts7s1ZKsXKknfvCtJARs9+jEtD9+YdAOjngx5JjGEb872y7lPjPM8DlPXCU1nRCDFv8hDVDFPz5I806cCnLvFk7WgLScqzNK2Tcw=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB6378.namprd04.prod.outlook.com (10.141.160.86) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19; Thu, 16 Jan 2020 20:50:06 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831%7]) with mapi id 15.20.2644.015; Thu, 16 Jan 2020 20:50:06 +0000
Received: from localhost.localdomain (65.112.130.194) by BN8PR04CA0060.namprd04.prod.outlook.com (2603:10b6:408:d4::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend Transport; Thu, 16 Jan 2020 20:50:05 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH v3 0/3] Support opening a symlink with O_PATH | O_NOFOLLOW
Date: Thu, 16 Jan 2020 20:50:00 -0000
Message-ID: <20200116204944.2348-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:8882;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 51Ol2FEvZa2noQZ7wCnFcGW96rnxevHiqQ7fZIZjbDDaVJpuT6DvyUA1aPvjtAM5UVimb5dmGonn/4tpashEhA==
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00046.txt

Currently, opening a symlink with O_NOFOLLOW fails with ELOOP.
Following Linux, the first patch in this series allows the call to
succeed if O_PATH is also specified.

According to the Linux man page for open(2), "the call returns a file
descriptor referring to the symbolic link.  This file descriptor can
be used as the dirfd argument in calls to fchownat(2), fstatat(2),
linkat(2), and readlinkat(2) with an empty pathname to have the calls
operate on the symbolic link."

The second patch achieves this for readlinkat and fchownat.  The third
patch does this for fstatat by adding support for the AT_EMPTY_PATH
flag.  Nothing needs to be done for linkat, which already supports the
AT_EMPTY_PATH flag.

Ken Brown (3):
  Cygwin: allow opening a symlink with O_PATH | O_NOFOLLOW
  Cygwin: readlinkat, fchownat: allow pathname to be empty
  Cygwin: fstatat: support the AT_EMPTY_PATH flag

 winsup/cygwin/syscalls.cc | 61 +++++++++++++++++++++++++++++++++------
 1 file changed, 52 insertions(+), 9 deletions(-)

--=20
2.21.0
