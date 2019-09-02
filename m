Return-Path: <cygwin-patches-return-9590-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 33526 invoked by alias); 2 Sep 2019 13:10:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 33517 invoked by uid 89); 2 Sep 2019 13:10:33 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.4 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM04-BN3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr680131.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) (40.107.68.131) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 02 Sep 2019 13:10:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=AZ6ImYafSfHLP63bbyJyAr2rmXiQ/1SRxASOLbGoJXDNq2YWA+08PMugD84R42YklirROnHdmHG56+5bX3Cq9FRAb5HT0YiuRlE4PRk6IGgio1hRP0G9NCBnrzANG2D4HN4udvzyf16x8Owf2y+ATPtWEkmXFDHn7Jayy3+nrv835lHscojr2EPOqLPRCMIOUWsgUeebYT4eeH8mj3+T7QgeHFjxIQj5+WDOq/QPvWvrzlcSw56VgYcHmZlBVcBo2WUYE6ifCPVgyASt3l5ptTUGsRPPYoEljrhIeHcRKsUjkpMKm36WpxYUjPvz0HtMvWF3/gkbPNlhZaNSgc+ioA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=QxIzi5Z4js4i6mU1rNfNqSJKVo/noYpk4Depydb6cTQ=; b=XlzNc6o2L4XD6dZSs2ZolDBP2ihstJk7QoMz9jv+H60JDulfHi5Wob4wHNAuOvv+eDXOZzTu98uv14OcWhKiyDOqo3yzqC3wkEIui6sZMbHENpAv6EjN8VeAtNAP1A5bsoWULDoYEWN1w9knJ6Oali0JtFGP2n1iTDlET6brGwoa/w+kbFhtj8jRsD4lkzRt+k65mdfVAp1kpZszCvv3zyGgWJly+f7DFw875vk+rEaxxVFu0BN+Nyh0RGuJp1NZuocUeC9/u+wD6iYX4AGADdGJKrwnjir6eqZuGVmNs+mTLFMBw6OfM4q6eggYDyhyy9uzGaFxbC+U5SeFmhxRiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=QxIzi5Z4js4i6mU1rNfNqSJKVo/noYpk4Depydb6cTQ=; b=W8f+NtOZ5b2jF0u30h2/djBO7rzYQM+DVM7eBVVdpJPMc7RRIyszS+6c+I5dwHZ0/kMm9zkFMRM+ixSMoN29mIJ5Zzv7zG5UQjqRe9DGE7HnSAGc010vSuHLdYQCTAUhvBBvyBaibel8rI+SYJG7Y0dOgNuBzBMGb1YRYcst/Ws=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB5050.namprd04.prod.outlook.com (20.176.111.143) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.22; Mon, 2 Sep 2019 13:10:28 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473%4]) with mapi id 15.20.2220.022; Mon, 2 Sep 2019 13:10:27 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v2 0/1] Fix PTY state management in pseudo console support.
Date: Mon, 02 Sep 2019 13:10:00 -0000
Message-ID: <da0ea694-93ff-4703-e7fc-c92f02e04f7c@cornell.edu>
References: <20190831225446.1506-1-takashi.yano@nifty.ne.jp> <1169565b-6e96-2865-4cad-eb7b2e6abe05@cornell.edu> <20190902065321.5c288f415052f88b6392622c@nifty.ne.jp>
In-Reply-To: <20190902065321.5c288f415052f88b6392622c@nifty.ne.jp>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.8.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:1728;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <9944EC0484F9284B8924EF3D267440E0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P1QmzJ8pP5Y8LiHIssDJFgnoOnSwPeNxL5k1GYclmLqkbb4A3XSqs55VrietxyXgBx4bYQAZZEcyT3OYPMrQKQ==
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00110.txt.bz2

On 9/1/2019 5:53 PM, Takashi Yano wrote:
> Hi Ken,
>=20
> Thank you for testing.
>=20
> On Sun, 1 Sep 2019 15:13:47 +0000
> Ken Brown wrote:
>> On 8/31/2019 6:54 PM, Takashi Yano wrote:
>>> Pseudo console support in test release TEST: Cygwin 3.1.0-0.3,
>>> introduced by commit 169d65a5774acc76ce3f3feeedcbae7405aa9b57,
>>> has some bugs which cause mismatch between state variables and
>>> real pseudo console state regarding console attaching and r/w
>>> pipe switching. This patch fixes this issue by redesigning the
>>> state management.
>>
>> After applying this patch, I get the following in mintty:
>>
>> $ cygcheck -cd | grep bash
>> grep: write error: Bad file descriptor
>>
>> Further commands after that lead to the cursor jumping around.
>=20
> I have fixed this problem. I will post it as v3 patch soon.
>=20
>> Here's a second glitch I've noticed (starting with commit
>> 169d65a5774acc76ce3f3feeedcbae7405aa9b57): In emacs, if I run a command =
that
>> uses compilation mode, the output displayed in the compilation buffer st=
arts
>> with ^[[H^[[J.  Here ^[ is the escape character, so this is apparently t=
he two
>> ANSI escape sequences ESC[H and ESC[J.
>>
>> Sample commands that use compilation mode are 'M-x compile', 'M-x rgrep'=
, and
>> 'M-x find-name-directory'.  I can provide more detailed reproduction
>> instructions if you're not an emacs user.
>=20
> Hmmm, it seems that ANSI escape sequences are not recognized in emacs.
>=20
>> 'M-x find-name-directory'
> Do you mean find-name-dired ?

Yes.

Ken
