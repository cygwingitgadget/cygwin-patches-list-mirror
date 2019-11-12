Return-Path: <cygwin-patches-return-9833-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24797 invoked by alias); 12 Nov 2019 13:46:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 24771 invoked by uid 89); 12 Nov 2019 13:46:10 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.9 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM04-BN3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr680139.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) (40.107.68.139) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 12 Nov 2019 13:46:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=CDKmhUfD2fkKI0FRHHiRr6l67MUmBrE7JfOPwJTL3JWZ87j1a1vNPW4FkIuvSvnJaTeyPw+ObnRzpFyioERo/HhwUDoKfVFH6PUAhQ960s67HRlUlQCVF3985LoX1H4WGNFR6qaWlpNrIcJVREoATlwp9Hz9bsht1J4XOQi6BE5RKPtLDne0am0UT4ljXH40ZreVLl45zxiw7ChFVKYTmrCKvXqOe0N5qgwj1hPUMoNblwRPbAUswU3dqveaLYZZwu+o3dMMt3QaNwk9oik4FR5MxXtr2p/kyi9njNmUKJOQMPZQ7AijgRMFVnTp3sHkW1udx+lagTPqw0Ijfn1HZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=qR8L2VSnVlrt0S4dd9KQZIVdA/5GhM2fgqNVqgV2ttE=; b=BhJ5hdGJETTHUDapXNDQkjEJ8zduLbNjVwJaKzhts9KzFv+fMvjeNxdAO7OhEfHCUypkd8lL1VbRh6ZF/fZ9cYx0dpkdHAmUjXixWxnaBwKsS88qoXwWE3+hF/CRcblhqcvxb49l9kvvN+moKiyLiW+SJyZK7l4hnz4CBPwnQ7rGS5lidGZgzdaa6VwazJsNfsVFd0QPj13JcOfF8h6Cofqo3R+Rq3i+afCAoe7QM9fsDm25/y8BjGwPq8I/w2+A33+tT93lgURAsaZP0NklxhB3T0qxnv+dW9aE7L0KVe0V8grsKI5tMxXAqqmIdctDMw2lYZChKvBbiOXQnEva5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=qR8L2VSnVlrt0S4dd9KQZIVdA/5GhM2fgqNVqgV2ttE=; b=enh7T8zqBNmvOf+dO5AOdbpmP2Mh0NmmR4+NXktRQSwu2wdPeu8bBFoUTkJOP5hvvq5sgOEb1VA9t+VrRB/N3w51/1fqi6y7MQrkdML65BiMfynTsEf8p5PBUv2/l3ZjAT8znkFW60j8PoU5Z1OFpOpeh5Kde1cQOUCeqgdOjlI=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB6777.namprd04.prod.outlook.com (10.186.143.139) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20; Tue, 12 Nov 2019 13:46:04 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::d589:29c7:67ac:164c]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::d589:29c7:67ac:164c%5]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019 13:46:04 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v3] Cygwin: console, pty: Prevent error in legacy console mode.
Date: Tue, 12 Nov 2019 13:46:00 -0000
Message-ID: <554c30df-d61b-22fa-e758-2c4d43186180@cornell.edu>
References: <20191106162929.739-1-takashi.yano@nifty.ne.jp> <20218a47-2077-878c-4d9c-e23f6b0d4add@cornell.edu> <20191112115535.90777ac110e6f72c76a99753@nifty.ne.jp>
In-Reply-To: <20191112115535.90777ac110e6f72c76a99753@nifty.ne.jp>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.1
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:6790;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <450B9F77B7E3BA47B603A599729D7310@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pzcPYdeAllmsvSMIB720mixjDe4IcH1TyqlJxjiu6D3gxHCRY3Z2S3DbrvdjMsyrlucQa7SMEMHu3b3uXlR+FA==
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00104.txt.bz2

On 11/11/2019 9:55 PM, Takashi Yano wrote:
> Hi Ken,
>=20
> On Mon, 11 Nov 2019 19:39:46 +0000
> Ken Brown wrote:
>> After this commit, the XWin Server Start Menu shortcut no longer works. =
 I think
>> it's /usr/bin/xwin-xdg-menu.exe that fails, but I haven't checked this c=
arefully.
>=20
> Could you please check whether the attached patch solves the issue?

Yes, that fixes it.  Thanks.

Ken
