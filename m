Return-Path: <cygwin-patches-return-9836-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 78284 invoked by alias); 12 Nov 2019 19:41:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 78274 invoked by uid 89); 12 Nov 2019 19:41:33 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-3.4 required=5.0 tests=AWL,BAYES_00,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=HX-Languages-Length:571, cygwinapps, cygwin-apps
X-HELO: nihcesxway5.hub.nih.gov
Received: from nihcesxway5.hub.nih.gov (HELO nihcesxway5.hub.nih.gov) (128.231.90.120) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 12 Nov 2019 19:41:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;  d=nih.gov; i=@nih.gov; q=dns/txt; s=NIH; t=1573587690;  x=1605123690;  h=from:to:subject:date:message-id:   content-transfer-encoding:mime-version;  bh=ozWsfBuWGKqbqgPzx8LHrqHZlSTNv0PIuGfLbVH4iLE=;  b=hqINNs5m7wqRZLeK3xj7sGVIHvwOdTTfxtwZdHOt+d4IlG26pOvD7QJy   lddHgYTXKqs2hp3Xx85euXqL6Nem1tEdNdP+9Aq4vxzxTqBZlxlOrQ0Ke   69snPOg45b9iVDeOwNTAweUcgT4LCuI1dO/zG7lPh4NpNiXAvM6Xb7L9I   XY7htWoXDbepSpOJJ9W26czrVZikHrHKx8Lmr0xZz9CcvoS9Zg1YB4Z5f   4gzQdBtIuOTsQWrrF1ahBucNfmD3i1bgCh/EKmzc8pJyAaZj4BEfQmE4K   C+Uf5l+9/j4Gfj/V03x/IgHglSTXY24J1BcDXeRpX7DIFEVtKwKYzQE8I   Q==;
IronPort-SDR: 0D0qjHckHZGwem6ijzfv0GTPyGxwEDQfdMnvKnfw1TaFK2RxHZr2KQr/EdFWvr0tFEC6+GJBlz kGpz/oBCDodg==
Received: from uccsx02.nih.gov (HELO ces.nih.gov) ([165.112.194.92])  by nihcesxway5.hub.nih.gov with ESMTP/TLS/ECDHE-RSA-AES256-SHA384; 12 Nov 2019 14:41:28 -0500
Received: from uccsX01.nih.gov (165.112.194.91) by uccsX02.nih.gov (165.112.194.92) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Nov 2019 14:41:28 -0500
Received: from GCC02-BL0-obe.outbound.protection.outlook.com (165.112.194.6) by uccsX01.nih.gov (165.112.194.91) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend Transport; Tue, 12 Nov 2019 14:41:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=E6CrqZo0VObNvKNGgZ5QRfLRATb0lr/zS5qKMmbGScne3tUZ79T20oCiHp8tt8SsEpW/hfrZ9rLrH/XxAhWe+SOF7YZQtCFwIo/vi6HR/toj6q7o6Gb6sL4rpWGXBX84B2k+/oYrJ+pntOLBuaAmH2YvKG90v/McVW2HVXXffixO1TEMVbZF6k+4MOIbTQJc/JhTaIKanikBqneV2ow4CWExlMa6t8E1aKQVXJob7xJvkDP/TxvbU7cbj9NjCJ2Xn0n5I2nS3Vs3AUXVKgHC3sXbfPG6BAGcZOJ+CWk5sPEzjUzOPlJEwL/BMfWCq10+sY63IKtLwtK6iT1U5LMX8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=ozWsfBuWGKqbqgPzx8LHrqHZlSTNv0PIuGfLbVH4iLE=; b=XAVHm1XxmAFR0gS5luLxVrinK91J6N5E3cBq7dv/DG7dWPsDJKKhXMTnEGubVCNCVvMJ3+d9DyLKSNHNCU4Tc37PIUhgLrbRzWS3SMaPsUCtIIALhMdDfLtXZ2g2Npv512uE83itBgR52xwN4GBOcn/4i101bb4kElFNOjcdFktaqoVfd+5s+kYsVHcpUk9gdONJkndKFUZCXcaDd1yCCzbedcfk2LdFXrtvLdh7hu/KXyeS0XegepdEc/geHQDyevaG8ETG0Yl65mpiQ31KgqsFvfIL6RZ0XNTa0fyS4YzgKvcAFs/DbOysRaPfD/xgKCev6QGhleswqvP1CDD0Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=ncbi.nlm.nih.gov; dmarc=pass action=none header.from=ncbi.nlm.nih.gov; dkim=pass header.d=ncbi.nlm.nih.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nih.onmicrosoft.com; s=selector2-nih-onmicrosoft-com; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=ozWsfBuWGKqbqgPzx8LHrqHZlSTNv0PIuGfLbVH4iLE=; b=T5MdM8vL8i7JugshEZSYAn7DeKJ0Y91oM/zapnfi8bHO8566/IM3Cabs/D9tT3kuSF4Qv9+1av2PidA2zXGsIN8JJtwOYebgw/BULidSzkzRErhH+zAWVmDjNoHVO1dfF2LYjZrrksWxAHzI13BQtybeMsBamp+UIcYoG7iKfz4=
Received: from MN2PR09MB3983.namprd09.prod.outlook.com (52.132.174.141) by MN2PR09MB4030.namprd09.prod.outlook.com (52.132.172.92) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23; Tue, 12 Nov 2019 19:41:27 +0000
Received: from MN2PR09MB3983.namprd09.prod.outlook.com ([fe80::58e8:d488:497a:428d]) by MN2PR09MB3983.namprd09.prod.outlook.com ([fe80::58e8:d488:497a:428d%7]) with mapi id 15.20.2430.020; Tue, 12 Nov 2019 19:41:27 +0000
From: "Lavrentiev, Anton (NIH/NLM/NCBI) [C] via cygwin-patches" <cygwin-patches@cygwin.com>
Reply-To: "Lavrentiev, Anton (NIH/NLM/NCBI) [C]" <lavr@ncbi.nlm.nih.gov>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: cygrunsrv patch
Date: Tue, 12 Nov 2019 19:41:00 -0000
Message-ID: <MN2PR09MB398333C47F420E68A5E95E93A5770@MN2PR09MB3983.namprd09.prod.outlook.com>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=lavr@ncbi.nlm.nih.gov;
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4hZXjxLrsgox8o8NvvpwqztCXObpYnX3X60z3NOxKIRU+YoLdNwYsAOwp9Awysxs
Return-Path: lavr@ncbi.nlm.nih.gov
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00107.txt.bz2

Hi,

Looks like I finally prepared a patch for cygrunsrv that I mentioned as an =
added feature way back in Feb (I did not need to come around to that since =
then):

https://cygwin.com/ml/cygwin/2019-02/msg00173.html

But the GIT URL given in the message does not seem to work for me:

https://cygwin.com/git/?p=3Dcygwin-apps/cygrunsrv.git

$ git clone 'https://cygwin.com/git/?p=3Dcygwin-apps/cygrunsrv.git' ./cygru=
nsrv
Cloning into './cygrunsrv'...
fatal: repository 'https://cygwin.com/git/?p=3Dcygwin-apps/cygrunsrv.git/' =
not found

Any ideas?

Thanks,
Anton
