Return-Path: <cygwin-patches-return-9625-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 39128 invoked by alias); 4 Sep 2019 15:11:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 39119 invoked by uid 89); 4 Sep 2019 15:11:24 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.2 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=screen
X-HELO: NAM05-DM3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr730102.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) (40.107.73.102) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Sep 2019 15:11:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=aRjXJRbGjis6/zD4Q6qVPBdkCLFyF4A9civEC8wsNv/ErZbsi5yPSoXhwomUk9Mf2SUiL67w9/iRvZEb182spvamoREH7BBGCXcGVBln0//vX65mRhaDFTc5DUEis0S2x9kyHXzaz58MmUX2izCj6dEVRsYyEjCUcMmsYRF0rKP6tXCnY2YLNQ8iZdGgdXS7Z/0gKvwmAu7G07Iwy2bxoJVzqS6sJg9kuruqw0Qau7134ejFxl8SLKlKZWQ8FeXeQ1ixbEUXLPTS/VXlR19mEcqq0E3MaAO1Wet+6rOR0rb52Z+oOHazY7u+DuwZ3CxgcxE90NyvkXKtu6y228qTDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=WjdlOb5UJZdxjvaEicnO1Y/9fd54jxKeDajx1Xx2JfQ=; b=Byr4fLeTjr6VuR7J2WdK7oi/h9ZrA/MakRvljHipEEWyJDJWKEeM2OLVeJvSk+5IBfQgZtkVJHJ+d6ZnN4FzfcpXoqpKc6diR5Ndp2L7Sx30QDo1XFHSKd+p0aQ681enWna2+na4AeygBnW4UBkiz/a5muPAwyQcbzHDajExJJMFB6EO83jvQ/7hKuLGVo5EVjo7fkn4y2/P73HZ5wkyFAQmhAtimeMGSUJUXMek/VWK6Xfnbm2Q/XiU+2Gwh+ZLZv0STBMLkwl2lapSVg/6WkBLJnE5S8LCZstT6FVbY9+7GP+pF10dUT1qbCkGG19iTfMSJXxepAEANjo9NwWAKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=WjdlOb5UJZdxjvaEicnO1Y/9fd54jxKeDajx1Xx2JfQ=; b=OSM1vunWX7uM2ETxOr9H7FeBBcNmF5MARfYXjLFWiTIr5AWIwqf0UbOzvIPO/LIH4xszjZptBLZQ501L+eF0gNs/yG3hXETluWyj8oFyGGMFvHOjDclo3rFu6kbFFRaN+LuDpe+IszYB9AYIJNrLQD1ebSeeRBthmaeChAwVHFk=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB3785.namprd04.prod.outlook.com (20.176.87.150) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.20; Wed, 4 Sep 2019 15:11:20 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473%4]) with mapi id 15.20.2220.022; Wed, 4 Sep 2019 15:11:20 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH 2/2] Cygwin: pty: Disable clear screen on new pty if TERM=dumb or emacs*.
Date: Wed, 04 Sep 2019 15:11:00 -0000
Message-ID: <544d0b3f-0623-f2d6-8e35-b21140ea323a@cornell.edu>
References: <20190904014618.1372-1-takashi.yano@nifty.ne.jp> <20190904014618.1372-3-takashi.yano@nifty.ne.jp> <20190904104738.GP4164@calimero.vinschen.de> <20190904214953.50fc84221ea7508475c80859@nifty.ne.jp> <20190904135503.GS4164@calimero.vinschen.de> <20190904234222.4c8bfbb31d9a899eb2670082@nifty.ne.jp>
In-Reply-To: <20190904234222.4c8bfbb31d9a899eb2670082@nifty.ne.jp>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.8.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:6790;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <64B520AD18A0A14A812D73F6D3EF518E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ZTq0uUzj4QIZ2qG2z67KYrSpCCekQz01kQa/Q2cUObWxIZHRpAcXleJMeh+7MgXxIQY+BsyJuKZcAttwgnm4Q==
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00145.txt.bz2

On 9/4/2019 10:42 AM, Takashi Yano wrote:
> On Wed, 4 Sep 2019 15:55:03 +0200
> Corinna Vinschen wrote:
>> The code in fixup_after_attach() is the only code snippet setting
>> need_clear_screen =3D true.  And that code also requires term !=3D "dump=
" &&
>> term =3D=3D "*emacs*" to set need_clear_screen.
>=20
> term !=3D "*emacs*"
>=20
>> The code in reset_switch_to_pcon() requires that the need_clear_screen
>> flag is true regardless of checking TERM.  So this code depends on the
>> successful TERM check from fixup_after_attach anyway.
>>
>> What am I missing?
>=20
> Two checking results may not be the same. Indeed, emacs changes
> TERM between two checks.
>=20
> fixup_after_attach() is called from fixup_after_exec(),
> which is called before executing the program code.
> reset_switch_to_pcon () is mainly called from PTY slave I/O functions.
> This is usually from the program code.

But the first check (the one in fixup_after_attach()) could be dropped, cou=
ldn't it?

Ken
