Return-Path: <cygwin-patches-return-9883-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 109019 invoked by alias); 29 Dec 2019 15:18:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 109004 invoked by uid 89); 29 Dec 2019 15:18:05 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=H*r:160
X-HELO: NAM10-MW2-obe.outbound.protection.outlook.com
Received: from mail-mw2nam10on2139.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) (40.107.94.139) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 29 Dec 2019 15:18:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=ZRoQuYBzzvBcaYPmOFPrjwDDDse4lFpB84F0pLzbp1kGRKkJR2U3cwqQd+LJpgQa1NVqrf3OVgbCU5Te3v8MDVAXl6ktMoW6iIbsLcV4CoFIE2TLj6inLU2/bBiQ7/hVbjdkIIkDa8nF6rXSaf9pDp0rhcdoVT9/YJu6SOPFYmGUazc0wF/hWZ6IgzJTDeXJQDdPx4PAMxR/iHDWxyInBdOkBBpMXk+6ilGfhxnIPLXEcCvz7KtpxYnv5smVSXrpfBtx6+C76NMdZ6qP52vo4Pc52tGQPAWHNa/taIo32ryVkk3tvNhWaDUJ3inrU0YkCU6oMnsxBuN0VKPSltq24g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=Q2p/DppvF30JTjax454nJppwQ60LZszrOivTeLYObAU=; b=lFPcUS0XDu93V5j+STsrOpHYmwp8feSo+5IKOfvMRvvdR3OOaXD7fL+3SWnt4ArOKXMfEMCSd2y5Yd1Qk8tBouLytrzqMpjKkrgFAq63nM2VMW+hNLZYJSpDW2hNmLzIKppXSb+SYvsAg32kg8+30qz4kKnHFUy3oWoX/RxMoWA7tzG5Vi98jQNebQkb756iJZwF1M9+sG3bSe6gEbvvBookUGUwV0xBZtWJlW7ED/FQEHH1aLEyEvrE/OWcIotuIX+ddjp38EouJ5xr12Q1gN/AS5KNr70MTSkK5spT5UrZASJHBC2ZwH+Z3MHfHJg4AGQTNj5YZNq4dBVmAvxQLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=Q2p/DppvF30JTjax454nJppwQ60LZszrOivTeLYObAU=; b=T3Nav7Rs4mXrHyc2dLbxtw5N+tFNsf3dsDs7PG2liNQtOgVHxQwc17WS2v81dDeXHulG/aQccHPXzyG09S+drmzA5M2RsDnoOD9J0KodOJZy+RXA/nBhBz4IQo/CdVFb7G3HkKwHGYPYfcv5M4FsEb7IkC88zJsjpaGFdX/RJGA=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB6496.namprd04.prod.outlook.com (20.179.227.24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11; Sun, 29 Dec 2019 15:18:01 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::f894:edec:b80c:d524]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::f894:edec:b80c:d524%3]) with mapi id 15.20.2581.007; Sun, 29 Dec 2019 15:18:01 +0000
Received: from [192.168.0.19] (68.175.129.7) by MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.7 via Frontend Transport; Sun, 29 Dec 2019 15:18:00 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH 3/3] Cygwin: fchownat and fstatat: support the AT_EMPTY_PATH flag
Date: Sun, 29 Dec 2019 15:18:00 -0000
Message-ID: <e3444bfc-9d2b-392a-7d5b-035fd964e7b8@cornell.edu>
References: <20191228195213.1570-1-kbrown@cornell.edu> <20191228195213.1570-4-kbrown@cornell.edu>
In-Reply-To: <20191228195213.1570-4-kbrown@cornell.edu>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.1
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:8882;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <AE265F9794F8A34889DF84B079BB4E83@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: atIp2xzoGzjgcuLmE0We/YFckt/qKSyu0/jL3QHunPgzry/9343EyoqULeO8kOT3+YhJHBZqyxtZ5ZNyRYb1Fw==
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00154.txt.bz2

On 12/28/2019 2:52 PM, Ken Brown wrote:
> Following Linux, allow the pathname argument to be empty if the
> AT_EMPTY_PATH is specified.  In this case the dirfd argument can refer
> to any type of file, not just a directory, and the call operates on
> that file.  In particular, dirfd can refer to a symlink that was
> opened with O_PATH and O_NOFOLLOW.
>=20
> Add a new optional argument to gen_full_path_at to help implement
> this.

I don't like the way I did this, at least for fstatat.  If dirfd was opened=
 with=20
O_PATH, I've ignored the purpose of that flag.  I'll rethink this and possi=
bly=20
submit a v2.

Ken
