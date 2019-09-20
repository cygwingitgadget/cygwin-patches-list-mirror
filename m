Return-Path: <cygwin-patches-return-9713-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 117406 invoked by alias); 20 Sep 2019 22:05:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 117395 invoked by uid 89); 20 Sep 2019 22:05:20 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-3.6 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=seven, HX-Languages-Length:914
X-HELO: NAM03-CO1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr790101.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) (40.107.79.101) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 20 Sep 2019 22:05:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=hbs6UOrSAyV2BlTzl4Y8EaciMhL956nKY8B8j5YT9RELnULcfSeBbf43ZqFo4eMgpnQv3y4/aon8gIIqFQIv1Vgq/FH4GHMyu9YcPS2dn2Er8gdSvQGlh+p4Jjhbw55voLEGP3C4QYHmrB83IfELkP4wOvO3JLRrr3n7W7Xe0O192UHwkBqglHJk2SJhcPrZkanj9D3DmNSooZH7F2RPQTMVyS+hb3HW2rm5VTsU3Aco77fpGKxKpUMoLilINPa+9UzaVZNEBQGZ8qmpkXJvf2pvWR8HUYbTS6jGDDARvDtWC39dj3Ykhka6NmT4u88GMeeGvgNkwky1q+2QKWQjAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=oMQDf4fPYvxv7ZGfUBzX+9H9OQP0tvaSEEJfYIuKyY8=; b=b3W0YguV9DRVCKGTC3guJeIJso5F+iIDM4p9e4Ziv5GckA1/LOFdfgIqSYuxep3lU77utsPLtkaIY8iH1s3u1+LVHRwfNPmJmbXlKfLcpLZHH5/Qk44lTXl+tTQMpUq3D4tpP0HV00CneLF6km1IHOWaTSu3NDdh8lIpTG9dlgR0FL8Cs1Y4oI/Wf6ScAmMVlI3ybIgLEsysm9yPlXWVWcfoqobO0d9m4NHdcj36T27lzeay7e2taTsUbYjXfh7fgDvbUXX/nha7lWLG+pcyn4VE6rvTOSo10S0Lyoc1UayygrbdhuxkG+LjMlIzBycXwi3wUNrdANOsOuRTQ+tINw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=oMQDf4fPYvxv7ZGfUBzX+9H9OQP0tvaSEEJfYIuKyY8=; b=XcMkTT1j6jQwVM10UzqGVPXCDX9u0/haL/D/VNfcum1t5uSqWSacw2uVVAjwlql+bZTYbyjwuJ1d77Se8WEubeNsP/HkMEhjbXpLjUzR9b9PBu+A2hcvgqguIxEkRpmQgo5D09haM90kERxkHaBSgaRed3mrbLL+hL2SpAiGvaY=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB4891.namprd04.prod.outlook.com (20.176.109.76) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.21; Fri, 20 Sep 2019 22:05:16 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473%4]) with mapi id 15.20.2263.023; Fri, 20 Sep 2019 22:05:16 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [ANNOUNCEMENT] cygwin 3.1.0-0.5 (TEST)
Date: Fri, 20 Sep 2019 22:05:00 -0000
Message-ID: <b4bc7a67-87ab-7876-8b8c-69a1b75e3a85@cornell.edu>
References: <announce.20190915144631.711-1-kbrown@cornell.edu> <20190918234043.5dcf3104ec188bb6f3c81218@nifty.ne.jp>
In-Reply-To: <20190918234043.5dcf3104ec188bb6f3c81218@nifty.ne.jp>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:972;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <EF7E353C001AD04DA24ED527F32F7481@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mixAgnYMEVcrjkIqzAoPifIXWfNnIox+ZJoyl3+1OHTs5PU+nihPoklP+FN3L+vFEdtPQbMu6x6EEqmOY5+Lig==
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00233.txt.bz2

[Redirecting to cygwin-pathces.]

On 9/18/2019 10:40 AM, Takashi Yano wrote:
> Hi Ken,
>=20
> I have just posted seven patches against git head (cygwin 3.1.0-0.5).
>=20
> [PATCH] Cygwin: console: Revive Win7 compatibility.
> [PATCH 1/5] Cygwin: pty: Avoid potential segfault in PTY code when ppid =
=3D 1.
> [PATCH 2/5] Cygwin: pty: Make GDB work again on pty.
> [PATCH 3/5] Cygwin: pty: Unify the charset conversion codes into a functi=
on.
> [PATCH 4/5] Cygwin: pty: Add charset conversion for console apps in legac=
y PTY.
> [PATCH 5/5] Cygwin: pty: Add missing guard when PTY is in the legacy mode.
> [PATCH] Cygwin: console: Make console input work in GDB and strace.

I think I've pushed all your patches now.

> I am sorry to submit patches in a short time since last test release.

No problem.

I'll make a new test release this weekend, or whenever you think it's time.

Ken
