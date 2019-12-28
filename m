Return-Path: <cygwin-patches-return-9879-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5018 invoked by alias); 28 Dec 2019 19:52:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 5002 invoked by uid 89); 28 Dec 2019 19:52:33 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-7.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=opening, achieve, H*Ad:U*cygwin-patches
X-HELO: NAM11-CO1-obe.outbound.protection.outlook.com
Received: from mail-co1nam11on2091.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) (40.107.220.91) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 28 Dec 2019 19:52:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=FWNxWxNbhlU5zPO0l6SkaNHst1i7dFTouTAo5UK3s6QgI4HEmY51WTpGGZswMvOrQarwr+YCR/4/GcJGdZ18VB1jJucDA63eY5nuFuC+4Mvu8yC00yl+UOc0hSHHXx3pco4nazVAFbcYZahMVOZ8cFesq9AMo3oFToJphQxtsWz1SJ2GI1Ep/eBc2ZViObJ8dE3+T4KAL08Y4y5rbEiSRg8sj1ovZZmZwwKJEyW4KwGVB9flwSrKWUg8x9IlFOjXH2T+H12X/fz6HFq0qq9p5lymRlczFtyTvw9Bk4SmpVzUgXdn//2KK2Sm7cqNh4Y1KI7LeUI9Cd03COmo7oKiPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=waRghVT6qadLsIWiCs+3j1s5DzbUx9fP7ywakW0ndDg=; b=CuUdilK1r7VkMht8Mj39hDQikR7UAf6dR2Lzidis6YweEH6DQQVr79rca34GqvOsLsA9tf6ea+SQCemm3CIY4TEHryTzCO7cWm9rQKaH1ZXWCjMPxGvuum379mrllBCrxYjMR21DPhNqLT5pxmGh4BdCSIX0M+ceRSqWDOqcijYE0zcdkr6MfQKFOsXYZcx8veuouLdXKE5P77bVY8Wiak0M4EugwelQbmLzyYSw7o50WNh0eRPc6GWfP0O1AD0SzSGBoO9lQJKU5iB2qUW2Yty3BFMvkgNUGqZZHs8DFvPyoaFZrWVRApi3QFVPA0ucflHPRirTNBlCsUFIcZBLBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=waRghVT6qadLsIWiCs+3j1s5DzbUx9fP7ywakW0ndDg=; b=KWzKoAq8kZMPPGzq1XWvTFhFHW9OuCmioaZq9vzzG9wQmEF/u+NzcTtBIXkxBSrcF1d4PoDYGImACcuJ7afk6NhOzHfzWNVsrXLW68Q9dAT/yCre6G//zB2spy1WqDgnwsZ4klkr+Vq0NhjG7QSnfhicElzs0t/Agz4MbfPGbTU=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB5210.namprd04.prod.outlook.com (20.178.24.151) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.12; Sat, 28 Dec 2019 19:52:29 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::f894:edec:b80c:d524]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::f894:edec:b80c:d524%3]) with mapi id 15.20.2581.007; Sat, 28 Dec 2019 19:52:29 +0000
Received: from localhost.localdomain (68.175.129.7) by CH2PR18CA0048.namprd18.prod.outlook.com (2603:10b6:610:55::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend Transport; Sat, 28 Dec 2019 19:52:28 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 0/3] Support opening a symlink with O_PATH | O_NOFOLLOW
Date: Sat, 28 Dec 2019 19:52:00 -0000
Message-ID: <20191228195213.1570-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:9508;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pcy0gkZ3NRgyZS6Fr8tFVSUhittA719MBTlQLLzWn6cOft/oZeNnyyi4gYBkm6uxMyUzMfIv6cpvLDn+XQK4nA==
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00150.txt.bz2

Currently, opening a symlink with O_NOFOLLOW fails with ELOOP.
Following Linux, the first patch in this series allows the call to
succeed if O_PATH is also specified.

According to the Linux man page for 'open', the file descriptor
returned by the call should be usable as the dirfd argument in calls
to fchownat, fstatat, and readlinkat with an empty pathname, to have
the calls operate on the symbolic link.  The second and third patches
achieve this.  For fchownat and fstatat, we do this by adding support
for the AT_EMPTY_PATH flag.  [The man page mentions linkat also, but
it already supports the AT_EMPTY_PATH flag.]

Ken Brown (3):
  Cygwin: allow opening a symlink with O_PATH | O_NOFOLLOW
  Cygwin: readlinkat: allow pathname to be empty
  Cygwin: fchownat and fstatat: support the AT_EMPTY_PATH flag

 winsup/cygwin/syscalls.cc | 51 +++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 13 deletions(-)

--=20
2.21.0
