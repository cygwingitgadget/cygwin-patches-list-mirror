Return-Path: <cygwin-patches-return-9963-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8208 invoked by alias); 20 Jan 2020 14:59:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 8199 invoked by uid 89); 20 Jan 2020 14:59:05 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-8.5 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=H*i:sk:ed59eb9, ANSI, styling, H*f:sk:ed59eb9
X-HELO: NAM12-BN8-obe.outbound.protection.outlook.com
Received: from mail-bn8nam12on2108.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) (40.107.237.108) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 20 Jan 2020 14:58:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=IBYNN7SxaP2zlQtmDCfa2vO5/M2egJXmZ6vLk4A8Rs3Wbo5KoqJt+6llRHt7+tZAwtFbbFLbm5ic6J2+mWLzxJwXx8+ZxDMKtWUiGcztSMo/66VX9I+tgWjl0cvLQZel/SOX6paDTFfBVFphs1GdtaQPtzYj5LO+JRl3qqmABPj3Spz3XVn8xUPAm2HMHrIQ6yeMX+intubc1JT2YQXnSQmjJtchSkUaAJAlOmCN/DT3on6Aqa0/5U2S8NVn++Oex922q7YZ653W3jwp2qot/LQl4UBW6+uoG7T0MBEp0z6LufhY176Kn/yDONA87ybs0FRTA60G5ma6XvDq1FJmNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=wBshCEfIoobMmSjW77RBb7vyQPWO+RK+qBZykRp3E4Y=; b=JXfQYdTIZvKMIoFwybyHQmbsi6JjQLaIupV0ioFQphAsZD/IgIIu34mes9fDYXUXnfFBpu2BWfEZj7q3dtKzsNdMsN3rEAOJz2gFUqpGILYqa09GC0BrC9PGhpf17keFzuJfbNhoAVQOb/DkTTxSOEUawtG2V6ANVGGhjStDRkShn7o/pNLW73EtN6ExHPuYUGBQmNWYew9Zf+IrA2gd2WzcTlpEG22XTL59ApPuzIVcpYOwZQfA5KXrh6ALAAx2jvYjUcDyhwT3+ddxClYoZPDIB05gCvKYpFSt9Ko62/SRKyPhsFyzLxZytPphxla0w7uCCgyVjiZ5g2G+rOMuoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=wBshCEfIoobMmSjW77RBb7vyQPWO+RK+qBZykRp3E4Y=; b=VLwWN2g6Mc3c3E/LrZEtmBN/SJZ/BAGuTtheYihZfpYGMsoOdCbAgPC4uKGw3IMUtIGVxtcvoAZxw1GXEISC/EyayR9BIHn6MuMsSciKNIHLfB1IyKffnEFzbIx4kpY2iTwUvuydGGIZMEc7IWikr4U9SR7uUfb/T6HWgVT4esw=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB4172.namprd04.prod.outlook.com (20.176.76.141) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18; Mon, 20 Jan 2020 14:58:52 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831%7]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020 14:58:52 +0000
Received: from [10.13.22.8] (65.112.130.194) by BN6PR17CA0023.namprd17.prod.outlook.com (2603:10b6:404:65::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend Transport; Mon, 20 Jan 2020 14:58:52 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] Cygwin: pty: Introduce disable_pcon in environment CYGWIN.
Date: Mon, 20 Jan 2020 14:59:00 -0000
Message-ID: <8f78d0f4-6a03-505a-6b69-9df1e4c6cf4a@cornell.edu>
References: <20200120025015.1520-1-takashi.yano@nifty.ne.jp> <20200120100646.GE20672@calimero.vinschen.de> <20200120214124.9da79990b75a658016cf34d7@nifty.ne.jp> <ed59eb98-8e59-f0d1-d1c3-9f44cb6cbee7@dronecode.org.uk>
In-Reply-To: <ed59eb98-8e59-f0d1-d1c3-9f44cb6cbee7@dronecode.org.uk>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101 Thunderbird/68.4.1
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:8882;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <F4B1C957777CE748AE253FA3D99EC8C9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LJBBY8Ya0XexBi4wXUI0NqqxFMVwZ6UgZTinEAlsn4zlzJinc8lJRH85EiCDa+C3PMiitS5dYgXtfP9gpKy8hg==
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00069.txt

[Adding the cgdb maintainer to the CC.]

On 1/20/2020 9:18 AM, Jon Turney wrote:
> On 20/01/2020 12:41, Takashi Yano wrote:
>> Hi Corinna,
>>
>> On Mon, 20 Jan 2020 11:06:46 +0100
>> Corinna Vinschen wrote:
>>> On Jan 20 11:50, Takashi Yano wrote:
>>>> - For programs which does not work properly with pseudo console,
>>>> =A0=A0 disable_pcon in environment CYGWIN is introduced. If disable_pc=
on
>>>> =A0=A0 is set, pseudo console support is disabled.
>>> Oh well, do we really need that?
>>
>> This is, for example, needed to solve the issue reported in
>> https://www.cygwin.com/ml/cygwin/2020-01/msg00147.html.
>>
>> I looked into this problem, and found that cgdb read output of
>> gdb from pty master and write it to ncurses. The output from
>> pty master includes a lot of escape sequences which are generated
>> by pseudo console, however, ncurses does not pass-through them
>> and shows garbages. This is the cause of that issue.
>>
>> cgdb is the only program do such things so far, however, there
>> may be more programs which do not expect escape sequences read
>> from pty.
>>
>> There is no way to control pseudo console not to generate
>> escape sequences, therefore, I proposed this patch.
>>
>=20
> I think this may actually be an issue with cgdb being old.
>=20
> The latest gdb enables "output styling" using ANSI escape sequences by de=
fault,=20
> but our cgdb can't handle them?
>=20
> See: https://github.com/cgdb/cgdb/issues/211
