Return-Path: <cygwin-patches-return-9716-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 87510 invoked by alias); 21 Sep 2019 21:58:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 87501 invoked by uid 89); 21 Sep 2019 21:58:11 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM05-DM3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr730102.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) (40.107.73.102) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 21 Sep 2019 21:58:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=iaHPoFwPloctjV6z7CIEcFxjPey3R57mA3Q2duv7FZGlD/x17NiJSIZvlrnrhxisJ5uEvARuof0xbkp1fbbLwuoEmhlwau7zUlnruvkAt68E3oUEbHjvil4aayVnBUhs4jY2TEGTGRSTcRUa81Ebg2ZZ68Kh9PucXWVlqOd/hXinTJy618S6LaercE4IoK2PUAra3iYiNTCHbXQImVafDDyAM56wWOVDqR4YY6/xEfL25/3MWUOiaQjunhFMOWJRYqZdI55KnXu8ngYa1kWuIU6BvPuxI21STJ6sLeWEXM37YKuG0CXyutQ+OOcy6qZX1h3CM/f+QidtY1AufSD9CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=n3+5CQZ3lD2oJeEnWRNM/1qPaPBbe3LfgQCoBWZMZmE=; b=BVT2kTFYlxI48GHyBCUX7RsxTL1EWZdklEbszEmeh1CqUdmRUa3pWFy2uR67dLy9ctmXJtyyf46C5aECDTmqx832GSPKAfiMdZwAsMJHwanLNCMFvDG6SnoFzBnUxh3OEQHPXKTS7YivOI0AbClaQSbofO+PNzhCKRTvkiyG+/MbKA5KAYupZtkheMgDR8DXLcygMZW4jsYJe7eFHOmNxuzhDoxVonxaLHAS41P2BMYXebhNdA1SFIIu0foLjB0Occ2yZSN5EXdlnGJUmpnmjKJbugalHjOixLIyn20prRLt6vSGu6wrWFFtFhCVnpojA/Eo9r4UVKcBO0SEUcPOJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=n3+5CQZ3lD2oJeEnWRNM/1qPaPBbe3LfgQCoBWZMZmE=; b=icbdkmFpGzjSBFX+ymwMdxfpXzxlk8eMkXYwxH8Jv98jgFhYmb7xbXzNgA5dB7RPF5pN9k7c0sJI39SXuTRdT4o/H/4andlHlLPAyQKuOmCJ3s/ZZuVU9UsDsFnZjOmFsMgPuIvxj85R89YxuvPWrpRNmuttiD+IXX7z7GY9BmI=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB5353.namprd04.prod.outlook.com (20.178.26.158) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.19; Sat, 21 Sep 2019 21:58:07 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473%4]) with mapi id 15.20.2263.023; Sat, 21 Sep 2019 21:58:07 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: Re: [ANNOUNCEMENT] cygwin 3.1.0-0.5 (TEST)
Date: Sat, 21 Sep 2019 21:58:00 -0000
Message-ID: <8f51dfc4-4eae-bfa5-eea7-9daa940f435d@cornell.edu>
References: <announce.20190915144631.711-1-kbrown@cornell.edu> <20190918234043.5dcf3104ec188bb6f3c81218@nifty.ne.jp> <b4bc7a67-87ab-7876-8b8c-69a1b75e3a85@cornell.edu>
In-Reply-To: <b4bc7a67-87ab-7876-8b8c-69a1b75e3a85@cornell.edu>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:3513;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <E06D05EB035D4D4F9008F800C1F5A258@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HbDm29oak/d8/YVXjtrlctJEU+Bydxe1a+hXzLqOUY9FnChKQT105njdsJMKPRiYP86JJ5wPEnc5vYLsjJuCWA==
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00236.txt.bz2

Hi Takashi,

On 9/20/2019 6:05 PM, Ken Brown wrote:> I'll make a new test release this=20
weekend, or whenever you think it's time.

I'm building a new test release right now.  I'll upload it in about 24 hour=
s=20
unless you tell me that you'd like me to wait for further patches.

Ken
