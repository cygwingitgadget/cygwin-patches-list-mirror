Return-Path: <cygwin-patches-return-9884-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 86692 invoked by alias); 29 Dec 2019 17:57:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 86679 invoked by uid 89); 29 Dec 2019 17:57:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-8.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=touched, symbolic
X-HELO: NAM12-MW2-obe.outbound.protection.outlook.com
Received: from mail-mw2nam12on2132.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) (40.107.244.132) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 29 Dec 2019 17:56:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=LLl4xqLLWgiM3Y08AP1urHRx6R6OiB7WslxS520kEOIQYnD+mYnHk11KtNX/nl6sQqP7urYnnxEzUjkV1GgC5IBBXBtrmChFenB/szZKrqCKCWe/SfIT/c7OYvOlLgK4C++66IYbnvyEjEwshCJIP29/u0tngoN13XEsDHtXVgm1EkOKWoZhv+PvaBBKkIMKFwYhtfYr/zCRMMrurY8VuB7vh+Kw+E8bF/DfSBdjXUx96uP/qjcFi0kpEk0Ip45v1MA2Egflx1lM/2S4I790Gm6IHJM/EvhlRCMVKcU5w/G8AivZqCE2pMriOIDEFU70igcq6wJ92jCPZEjSPaUgnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=6KJdN/y8zFyllOAbSkTbcDIdf07QslNE4Pf6KCI1zlY=; b=OssL+xe7PC33A8mT3lxJ8w+HUDwXAx9aD+A0h2qjXkqyBq+ACpc1wKDplVqZvyR1NJKrG4/sm6/QFtn0GYINeRWse6f8V/DhH7msxAJHyOt/XvqIgjFPZUDe0v+w3GLmNSTHTD/hC08DXU+VCPeB5MCz5AUhudKNm0htPsMmx1xzhYkClXZa2JR0RztgpNCfl2LrnvL6R1jfsBjKVp3pSuEcDs8A6K+T9y4+E+MrFOXuHUFtdlcV1VgWQmDTzkslb++TuNEBq1mHLZC+9f4CMBoJjVgyk4TYSsCmHqZF+7kcerCtKT8AQzfmKswC3gqvIelcEyeyfYd08E5yAhmdtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=6KJdN/y8zFyllOAbSkTbcDIdf07QslNE4Pf6KCI1zlY=; b=VPPQRkRVLs6UljG0qtGOdAJz1jPi5mckS5YoKU+Y78JeLrZs2xL9qchKJsAz9T0nSSjQRvuHI0MgssJBGvEB+NvhrtkMkod4xy2y97/iazBPWPJQkA+F9ps7FEcjCevn1TBbbSU0dCrYXWIFqundxJ/zQq+Om9rnZO01LC1xUEk=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB4345.namprd04.prod.outlook.com (20.176.76.21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11; Sun, 29 Dec 2019 17:56:56 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::f894:edec:b80c:d524]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::f894:edec:b80c:d524%3]) with mapi id 15.20.2581.007; Sun, 29 Dec 2019 17:56:56 +0000
Received: from localhost.localdomain (68.175.129.7) by CH2PR15CA0013.namprd15.prod.outlook.com (2603:10b6:610:51::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.12 via Frontend Transport; Sun, 29 Dec 2019 17:56:55 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH v2 0/3] Support opening a symlink with O_PATH | O_NOFOLLOW
Date: Sun, 29 Dec 2019 17:57:00 -0000
Message-ID: <20191229175637.1050-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:9508;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k3aWex/kyh6EYZ9uz2ks2/8ZKMuv1naigoPgrP5itBkgwyLWcNo6GIHX1v/GaFHTf0h96aI4C9XOss+z+1MUpA==
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00155.txt.bz2

Currently, opening a symlink with O_NOFOLLOW fails with ELOOP.
Following Linux, the first patch in this series allows the call to
succeed if O_PATH is also specified.

According to the Linux man page for 'open', the file descriptor
returned by the call should be usable as the dirfd argument in calls
to fstatat and readlinkat with an empty pathname, to have
the calls operate on the symbolic link.  The second and third patches
achieve this.  For fstatat, we do this by adding support
for the AT_EMPTY_PATH flag.

Note: The man page mentions fchownat and linkat also.  linkat already
supports the AT_EMPTY_PATH flag, so nothing needs to be done.  But I
don't understand how this could work for fchownat, because fchown
fails with EBADF if its fd argument was opened with O_PATH.  So I
haven't touched fchownat.

Am I missing something?

Ken Brown (3):
  Cygwin: allow opening a symlink with O_PATH | O_NOFOLLOW
  Cygwin: readlinkat: allow pathname to be empty
  Cygwin: fstatat: support the AT_EMPTY_PATH flag

 winsup/cygwin/syscalls.cc | 40 +++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

--=20
2.21.0
