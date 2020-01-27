Return-Path: <cygwin-patches-return-10013-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 121737 invoked by alias); 27 Jan 2020 13:21:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 121724 invoked by uid 89); 27 Jan 2020 13:21:17 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-12.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=H*MI:edu, brown, Brown, our
X-HELO: NAM04-CO1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr690139.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) (40.107.69.139) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 27 Jan 2020 13:21:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=VPAsSX+C9N56I52JH0S02XyRMik867hzFcmXoPOjVswu4clTPgV8YePstly3osey90b5YkA9RPlL4zgEUZTzG3yMTHrC3VaI+Bk2HGW5Mstix7h4qkhwWwVCk+tJxi1zjbGVzZSzh4Hhgut2nXYydsYciqL8eBHbmwzM9iQm9ljFxU61822lXG+u18iR3WE7WVQyXqGnYGL/HBSXHmP6DOd7aSCsjL5m0hJOKc0Mx/0ASWoBZZLhdoqIntThg0SF+1WLsaQ0TrtNOcT7r5XYdOyXTGIZsWAnV93jY50u2rpfzfbzxEUFWdyg8k83FhKKv96t8BuEwi48lCMnFW5usA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=/Iph2fbiwzCZU5KINFrnwVKmv0ILXTd6DnK7fW68CW4=; b=OByEFiCeJNHiTREqnp/zAma/BH5pP1UmfHQAxo4EIt7InndTzHarEdlGQJgwFMniYmcyEdwgerKeIVL1E/sSUSIXKVgO4V/ynNGoN2+RbNHUiatLwXhI6PdDj1rhTKNWkpc5DRLC7S42o4y6Mc+Qy/cvGXsdkdrkRz1EFlwLuOqwAsXteeQZgOZ6Wm3gf4bI2+8gAm7hFGms2NRU9hCD0wK+uuwt78lewZvpUyQ92X4l3rda9hnwwpvZfzCMn6P7jc/gaPHIZhPS4/5C7LdR0pxIbnW5UxmqJRrPg4moVMR6sVvjplvpB1uF6FLefqL41uU/56bRGVOqwL3IFeDw1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=/Iph2fbiwzCZU5KINFrnwVKmv0ILXTd6DnK7fW68CW4=; b=emNpW8LvDw1UbgWsi/unxoHF42kddwZE7f29to9ad4bMdo01Y6ME5cDvOmkpHn8yjut+cSq+45rK5atQYxlLf3d3UAvDcdWQhiVKvPS8tG1bXNDErTWokdqetopBukHtgsFDvs6ArK/oNBDIo5RwbMRJ8oWpblFiLLYXEuM/UpE=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB4859.namprd04.prod.outlook.com (20.176.109.28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.24; Mon, 27 Jan 2020 13:21:14 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831%7]) with mapi id 15.20.2665.017; Mon, 27 Jan 2020 13:21:14 +0000
Received: from localhost.localdomain (65.112.130.194) by BN3PR03CA0107.namprd03.prod.outlook.com (2603:10b6:400:4::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.22 via Frontend Transport; Mon, 27 Jan 2020 13:21:13 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 0/3] Some O_PATH fixes
Date: Mon, 27 Jan 2020 13:21:00 -0000
Message-ID: <20200127132050.4143-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:3631;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-messagedata: 60p85PAw4WGKuZfXjZo6rU0t0D6sl4XV1zzjo6UKKd/cff8wTRSo0J3HxKE/1vZYd2cxD3TXVa4b2qyLUCk0z/3DkxJSly0iPpB7g8IPCAJU5j51sBskMeM80Ekt580IzUfR+bZqJXT68ACrvynxFA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m4Q7p1O697l2KwIG5xnDWOJLc8XTOQdmAzjIAAZcIYbKlYQx28FxqGEh7xxUBoZk5RlwuCyK1cS9Ruh6qbMfuA==
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00119.txt

Ken Brown (3):
  Cygwin: fhandler_base::fstat_fs: accomodate the O_PATH flag
  Cygwin: fhandler_disk_file::fstatvfs: refactor
  Cygwin: FIFO::fstatvfs: use our handle if O_PATH is set

 winsup/cygwin/fhandler.h            |  1 +
 winsup/cygwin/fhandler_disk_file.cc | 24 +++++++++++++++++-------
 winsup/cygwin/fhandler_fifo.cc      |  8 ++++++++
 3 files changed, 26 insertions(+), 7 deletions(-)

--=20
2.21.0
