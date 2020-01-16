Return-Path: <cygwin-patches-return-9941-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28886 invoked by alias); 16 Jan 2020 20:50:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 28877 invoked by uid 89); 16 Jan 2020 20:50:20 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM10-MW2-obe.outbound.protection.outlook.com
Received: from mail-mw2nam10on2122.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) (40.107.94.122) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 16 Jan 2020 20:50:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=KH0R4QnJ0LNizUYJPGYx07qxYXYoPSrfl97JYZyMH6y3bypQfAkTaEFZoR4qyqmYwe5mX6Ff+E6TsvR54dg8luockqhr1oV7gDcW93zIYSzzID6MEiiyNSWPtr5puelPe/BZUYUJiAtAL1vW+NA1Mi8GbQSMpHAPYDoxil+P80CZKpES9xdkyEvTUn5ZjrfruQUojthpONWNrBG1E69OOOZBCm4EfBz7McQGQExIt4us9Nio1dBCcMTMngCEWzkCD133CxIoqCgQ1tqPbUfUPL5YLi9lJgKWP3rqSj9hJyZb6RtijSBLvwLxMhZqitY3SutD/Bxhyg60qQnehh1STA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=+8tKjAKpN4egFlaFKchE7uxfSgIWvJYnzenAYPwio00=; b=IBDG3Zqs3qOomvw/JpRsdB8WMEyrvgW1n3AgbSy2FPGhIQD45OIa7AQAUgwJEgRytSBd99Iqt0tFWb1PSQ/p4XRqOvhQJH2rTH1jVKEn6+KzUbuFxcKKMaHLdRVcm9gyM+jnpPb172nEVdS04W1Hb0D1G/PIZLKSA0ZrwGsZ8gwORXDTihhnaUwd0/O+oDrfQHkL3IOifmcH0LruGHGS6wFWsT9fxv0EM/h33K/6g+ZOXLC4X0xGg1VlyHaLIDA7Hm10LSRDPVdRykq+j8erL+W+Ljgs6S1PbxE3+stPd/71vZwEJkTi8vSaUNABg1QLkYF+q+GwuQvYnDLu+IIv3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=+8tKjAKpN4egFlaFKchE7uxfSgIWvJYnzenAYPwio00=; b=JF4hQ9KZHh2LTJOOeHRVmE0LxOUgWZp55q4lG/wqVhLuMXpJKc1ZMk7nsRL87N9JQ+RETb5cYCKHN3fxFlaAbB6pkLq+mo11j+C2feVZjxIYxMQ3d6VZg6mdyFSzAUEiDcAuJkNZLfbLyBfm8MeB03Y1x01bqSLwtg06Q0Ln548=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB6378.namprd04.prod.outlook.com (10.141.160.86) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19; Thu, 16 Jan 2020 20:50:07 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831%7]) with mapi id 15.20.2644.015; Thu, 16 Jan 2020 20:50:07 +0000
Received: from localhost.localdomain (65.112.130.194) by BN8PR04CA0060.namprd04.prod.outlook.com (2603:10b6:408:d4::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend Transport; Thu, 16 Jan 2020 20:50:06 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH v3 1/3] Cygwin: allow opening a symlink with O_PATH | O_NOFOLLOW
Date: Thu, 16 Jan 2020 20:50:00 -0000
Message-ID: <20200116204944.2348-2-kbrown@cornell.edu>
References: <20200116204944.2348-1-kbrown@cornell.edu>
In-Reply-To: <20200116204944.2348-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:2582;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l7bIQ0mr4qLsuFNSKysjgcxGlNxel43OLLqzThCjc/LXvV9kxI88xVOyMlaOTdQBOz7PcLtKEH0GEevZ+Kz1/w==
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00047.txt

Up to now, opening a symlink with O_NOFOLLOW fails with ELOOP.
Following Linux, allow this to succeed if O_PATH is also specified.
---
 winsup/cygwin/syscalls.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 20126ce10..038a316db 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -1470,7 +1470,7 @@ open (const char *unix_path, int flags, ...)
=20
       if (!(fh =3D build_fh_name (unix_path, opt, stat_suffixes)))
 	__leave;		/* errno already set */
-      if ((flags & O_NOFOLLOW) && fh->issymlink ())
+      if ((flags & O_NOFOLLOW) && fh->issymlink () && !(flags & O_PATH))
 	{
 	  set_errno (ELOOP);
 	  __leave;
--=20
2.21.0
