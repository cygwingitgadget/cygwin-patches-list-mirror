Return-Path: <lavr@ncbi.nlm.nih.gov>
Received: from nihcesxway4.hub.nih.gov (nihcesxway4.hub.nih.gov
 [128.231.90.119])
 by sourceware.org (Postfix) with ESMTPS id B8A98384F031
 for <cygwin-patches@cygwin.com>; Wed, 21 Jul 2021 17:57:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org B8A98384F031
IronPort-SDR: WUZDLcN6EKrxv5XhMHAYYghqiOutTYamO86rc3bNWtVc1z+km0SN2z1FjNf0t5IsK/XNo7v4kI
 GzCWt4DEWEmw==
X-SBRS-Extended: Low
X-IronPortListener: ces-out
X-IronPort-AV: E=Sophos;i="5.84,258,1620705600"; d="scan'208";a="294709862"
Received: from unknown (HELO mail.nih.gov) ([156.40.79.162])
 by nihcesxway4.hub.nih.gov with ESMTP/TLS/AES256-GCM-SHA384;
 21 Jul 2021 13:57:31 -0400
Received: from nihexb4.nih.gov (156.40.79.164) by nihexb2.nih.gov
 (156.40.79.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Wed, 21 Jul
 2021 13:57:31 -0400
Received: from GCC02-BL0-obe.outbound.protection.outlook.com (156.40.79.133)
 by nihexb4.nih.gov (156.40.79.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14 via Frontend Transport; Wed, 21 Jul 2021 13:57:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLK3oFOFD9t8Xl4lQQa5uEfYVs5Qi9RJ/jw+V33SSGmS4eyt9zGTNfhAHUEQcf+PNsSuZtc9W+926YLyhvgHC5IInYf90MZHyU5dglsLDjun4Owq7cmRAwngcxwxuwQwabfEhHLJxS16++za6pzOsQ6/n75m2Iu8csE+bdcoIZ8pzAmaPsm9iQ4alEWX81EOAI9ReOCXNMor6HRcTFj5/kHsfnljJhe95o1qMJ2hMK9zXihO6TjzZCqBPAbpetbR8suLXr+PkBOkV+ctkWgXqp+pUl5/Xwc+rPLkjIi/SPeBWR3O/yi2FraoEqnUfqRgMKL3czlVAMnzVNAXg5KHLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8p9LKo3RozeMolZfed5eTgdtppVHhutT1Gqt1gba1E=;
 b=YryXI2EV6C9b16f+ilmuxxJDp/QQCkJJ/VJTWlodKcvgNDfSi+DIhVh7EFkFiZmO3/wVHqurD2n1deXZELKJX2yA7mz6MoRWzzshItosiPRRICKY/1op5wGY53KZzWsX9pDA2O4v88OimaMwCXrK1s/lDtY1JNYzV65n8cC+xc2Sy9tiwqyPzFlhg10N/oShfS50lIn3m6kIf+n9MHys4gB3/nX2kTZ130AHWFlzPavd6M5e7jNm2ki8EoJBmLmDAiR2RT0y2bshtsbbfAaxwS7dNvygxeqiwmG2jEEzbbMrmNlHEwltZFu1UypAjg9ZaiR24ODixdPwyD0D8TjLzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ncbi.nlm.nih.gov; dmarc=pass action=none
 header.from=ncbi.nlm.nih.gov; dkim=pass header.d=ncbi.nlm.nih.gov; arc=none
Received: from DM8PR09MB7095.namprd09.prod.outlook.com (2603:10b6:5:2e3::14)
 by DM8PR09MB7015.namprd09.prod.outlook.com (2603:10b6:5:2f1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24; Wed, 21 Jul
 2021 17:57:30 +0000
Received: from DM8PR09MB7095.namprd09.prod.outlook.com
 ([fe80::1425:940:c8d4:9388]) by DM8PR09MB7095.namprd09.prod.outlook.com
 ([fe80::1425:940:c8d4:9388%6]) with mapi id 15.20.4352.025; Wed, 21 Jul 2021
 17:57:30 +0000
From: "Lavrentiev, Anton (NIH/NLM/NCBI) [C]" <lavr@ncbi.nlm.nih.gov>
To: David Allsopp <David.Allsopp@cl.cam.ac.uk>, "cygwin-patches@cygwin.com"
 <cygwin-patches@cygwin.com>
Subject: RE: Fix nanosleep returning negative rem
Thread-Topic: Fix nanosleep returning negative rem
Thread-Index: Add9eS/VixoQahcVTP2uK87XyOsdjgAksGKAAAD4GwAAANGCAAAAFB6AAA2ZgoAAA5+3EA==
Date: Wed, 21 Jul 2021 17:57:30 +0000
Message-ID: <DM8PR09MB709596AB900FED8AE7BB23A7A5E39@DM8PR09MB7095.namprd09.prod.outlook.com>
References: <000201d77d7a$2faae510$8f00af30$@cl.cam.ac.uk>
 <YPfdSyPTCdSWhRv/@calimero.vinschen.de>
 <0189b5495b2149c5a690de0431b7695c@metastack.com>
 <YPfpSgbZbr+bnOWE@calimero.vinschen.de>
 <YPfp0WgZUVo0nap7@calimero.vinschen.de>
 <2271051beb734ce984ed71eab4180746@metastack.com>
In-Reply-To: <2271051beb734ce984ed71eab4180746@metastack.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d334cbbf-5419-48ad-2448-08d94c71027c
x-ms-traffictypediagnostic: DM8PR09MB7015:
x-microsoft-antispam-prvs: <DM8PR09MB70151A97CCD82C3E6D0BBD6BA5E39@DM8PR09MB7015.namprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KdctvH4i1AFvAl6xsQw5B6rlUP8meYzNG3xIVnFvzgavpHBlCQA/CJW9+TdQA/lSYqnlYJawCD7xUF8vzX4T8IcmyHoE0kUQJprXgy927k0wkh13hN+l2+M2m+8UGyvhXxdCLw7D8U4/PkNMtQ5Epom6If5LL+yG6iG83Q4GBejS3oEw3J6m+06yNEBWloaw2uZzoG2vOiTOr4XTP2Kz3DwA+jFy4v+HwPmegRD7l7Cj/YXQgNR3VTCM9iKns7irGs65CthABLBQtFCcCKePe98r9pWENyR4+w/lHqn0EBy+Er11XSooX9wlgY9i1M0glhedjFDlw1HfwKS6RrFoJ0b8grx9vFb3JrqYpJZtoynv6XAzwbmKQmX7Kd65ZCikGy4I5TqEWd7qUL5JMyLr99dB8M2/MC0EmklcpUtIZo68SFNnLok8TbcOJ2ChOMhDOK0qR2Mg8hWcC5fC3+KM8JvyrQk7OnDJheIRn4PzQyHRnDE5Q4LonUefXvsko83T/sH54FiaY3BSvIdqVQ3LqwSjSCflTAv0ysYbHwzOWqZNO2wKY2KgMBFwt0t0zJyjSEGdcTwS9dD5FemQj1mkF3cLH1ZI6BQxMQ3ofPUR/f5Tyit1bdl83ixYgcHhBESieHkrRGzgsCHdqySPl1k9xb8rOxmQ5cWR2pDAK0kZ7iYHCtTgmbS4rwFcQDmhVShbu5WkpYF5OJNUW9Ihohnwuw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR09MB7095.namprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(71200400001)(5660300002)(8936002)(508600001)(7696005)(8676002)(86362001)(316002)(9686003)(2906002)(110136005)(55016002)(83380400001)(33656002)(52536014)(122000001)(38100700002)(6506007)(26005)(66476007)(186003)(66946007)(64756008)(66556008)(76116006)(66446008)(38070700004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3O9p8TdceJjj3a67NZtj1d3Ol5XH4zybix+2WG1G51/jqG3Tof6IQzqN5t7o?=
 =?us-ascii?Q?Zde0Y2Wgowfw/aJzoAbAetYFJ8Y/fAo4YHSd/DG36RKytc+t9iCSvo3QjUWv?=
 =?us-ascii?Q?mqF0e5lkLtW/AR35+Mm+GV30fysHTntvAQU43W6d15serp5C5U3thGw0TR79?=
 =?us-ascii?Q?uJ2Xo6/QpIqlsPeJXfo6Cyk42NgAusqcMg7jRp09oCBxQ5GiGEePA+Jhha6j?=
 =?us-ascii?Q?kbI/8HNIp2hCWMWMHcgJeOiap1v8HXTRdg5mBhMH3k/qVSyHrV+V8uGBgnZh?=
 =?us-ascii?Q?OY3ikh8SnGu+pPrlMdkpbNcnoIC4NrF5SvS8FscSOLAOsRhk//dHnnpSPinL?=
 =?us-ascii?Q?H808XUYTmKY1vpHj3J/ckn8v6XugpfHwHvAedYx8QIvCjbPCOrnX6jP8v4Jh?=
 =?us-ascii?Q?7TCwKJCP+sXaw5T8YZecr6ByNZwWp+5mIo0sgn2djRiudh2BCPAdQKZx482I?=
 =?us-ascii?Q?dSJRaXATmQD1gcyllCkSJMoPj38zECT/RJvRujqHsielAce5x6P4GWeFOiwT?=
 =?us-ascii?Q?zsunWMflpQGHnDt2lFUbi+pWjfRYVIXn244/AZs8Pom2TMAzZgLfc6IAUBwE?=
 =?us-ascii?Q?qIC6v0duiRSaT9NiyYJUU6Z1z06tHcWBRzeejyt5aWBmXRHQUNmcd0xpGAEH?=
 =?us-ascii?Q?sanmrXw1DeyIM+c9U1cjMext1+41IMwEx1fqzTsD+AjGorTFhQO1T86iozW8?=
 =?us-ascii?Q?nDnKSnYSyzFj5aoD/ooYWW7N1ih6HTNUXKGvtUZxS7mnWW86nojKC1IZ0Z5f?=
 =?us-ascii?Q?zdwCwYnMX/hOohdrs6k0aD8tI8xsfiU/JCB9mgZGDonvne7Gjld5qQO4Im83?=
 =?us-ascii?Q?CkT08Z36dS4UABcyafkHY3rE3QS7vXr1KH6+5J6Lyp6b9DBjr9fEnc9AH3xp?=
 =?us-ascii?Q?uO/VUL/3tXfNy2WSeLi+xxGN3zHuaZHU9oXXa418dfn5iKBp2h8t8s8yaVP1?=
 =?us-ascii?Q?R0/ec28q1v9Yz9WVqrUYR0S7dqsJ7SL2DEQ/Cgos380wWvfyilThnptOrsSY?=
 =?us-ascii?Q?CzRntJD9pyxZzQiv0L/GlK19CW0uZv5y4eKoc9KnLrMPQ+87iUAC/mRBI9ra?=
 =?us-ascii?Q?S6k6Vrz0eVVZgs87ukqNlt3cAxLgrl4IK39PVbgyq5+5Vr08A4NNoTPn0KNn?=
 =?us-ascii?Q?nphxr4HQ2tqeIGFjbPco98fsyen6LEcXL+G9xqV3xRj6ounx6pSZF0hmnNcK?=
 =?us-ascii?Q?0oaYDK0N4kMR575DJvzdSsBx2dFkDHegT69rMkkSHcpvAmxtGuyjNSHRgn3T?=
 =?us-ascii?Q?0PEwW/qFSSEULA13Nx/QGBYlTH+uN3XLB0c1tV/Mjy9gMtsQatDAxS6LIjKZ?=
 =?us-ascii?Q?KKo=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR09MB7095.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d334cbbf-5419-48ad-2448-08d94c71027c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2021 17:57:30.5136 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 14b77578-9773-42d5-8507-251ca2dc2b06
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR09MB7015
X-OriginatorOrg: ncbi.nlm.nih.gov
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_EF, SPF_PASS, TXREP,
 T_SPF_HELO_PERMERROR autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Wed, 21 Jul 2021 17:57:34 -0000

> I can get it easily get this on my desktop (AMD Ryzen Threadripper 3990X)=
 but not at all on my laptop (Intel Core i7-8650U)

Not sure if that's really related but:

Have you checked what is your default Windows timer resolution?  Some appli=
cations change it from the default
100HZ to 1000HZ (by e.g. using timeBeginPeriod(1) -- MS Edge does this, and=
 Chrome, I think, but not Firefox -- yet
the change is actually _global_ as documented).

The following code shows the timer resolution:

#include <windows.h>
#include <timeapi.h>
#include <stdio.h>
#include <synchapi.h>

int main()
{
    unsigned int prev =3D timeGetTime(), next;
    Sleep(1);
    next =3D timeGetTime();
    printf("Sleep(1) =3D %u\n", next - prev);
    return 0;
}

Output:

Sleep(1) =3D 10
means the default 100HZ

Sleep(1) =3D 1
means the increased resolution of 1ms

Anton Lavrentiev
Contractor NIH/NLM/NCBI

P.S. timeBeginPeriod():

This function affects a global Windows setting. Windows uses the lowest val=
ue (that is, highest
resolution) requested by any process. Setting a higher resolution can impro=
ve the accuracy of
time-out intervals in wait functions. However, it can also reduce overall s=
ystem performance,
because the thread scheduler switches tasks more often. High resolutions ca=
n also prevent the
CPU power management system from entering power-saving modes.
