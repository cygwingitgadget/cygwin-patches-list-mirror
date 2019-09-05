Return-Path: <cygwin-patches-return-9643-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 127824 invoked by alias); 5 Sep 2019 16:14:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 127810 invoked by uid 89); 5 Sep 2019 16:14:08 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-4.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=HX-Languages-Length:923, screen
X-HELO: NAM02-SN1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr770099.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) (40.107.77.99) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 05 Sep 2019 16:14:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=hD68dYJyKool9/ER8kgFAepwVm3GkV/G/4jIBMFiYHZIWcSGQjxr5KfGON9YRh8h4vqXeN0M6KolDfJRqNRFltVx/7Hrwzaoj6iuVXCQPsxJFHbkrOi27oKHu+4x5/qP3xTb4zroPhqEWn6X7iEB+sccGxz2h9UMl2xLiQ0cXlJgCfhTpL4v12AkNq0cFU/6S4MYE7nz2M9k6tPH+F5f5TW+CQaYBED9kyV69/tvIOCihO4HUEx5X/fcKKUM9d4N9NweumJkefX5129oEpdoPbdKve0Umssrh0TKfIGCPIeYdhjrpTI+1rSL3Y/TUymS0LoLzpIgc5um7nd4Mvi2MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=+8caTEUvPRmZo/0i6hxD2kbVxPzlmByydST/+Dl7eKU=; b=n8It+bZ2Cf8gVlTFhTnWhZfiLhiULnfMjekk9OneHQxPKiQIlI9e1F56lJP5WUEdv7RU3JPmXOYvtg08IB3SYERKo5RDoDBXlJQvBvL7OTnehdckM6VqraqJGdIBAT5UIKyR2fXzBwHtEd9fk9KR41ZdZ8MbJsFHGMQoPjXBdcuixbVUlGpQEAn9E9Wtq+LF7LfF+oFEaMDxWWYj5IoU0Kqto2Vux6uq9fshTa1lFmnpMaCqKqqcsVPoSSh3QpvCAdLpm1/uksuc3uunnOuEwBB4R7crTSWKSOQO5gM4xx3K671Z2KEYAaJOrHTjRpx/mflm5Ou+3IeK68OpErGbfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=+8caTEUvPRmZo/0i6hxD2kbVxPzlmByydST/+Dl7eKU=; b=PI5SW+p7Up22stjZAo2yBin3jpIPZTzp7lKuehx2Dg0cxrq2h0P7Jb154SmVIFeDhGJsp+xLMe92+/Rc0Jcq3cNkt5srD2290m8if4rgofGW8mAo3I4A3MGV8I2pFkyYu6S4Es8Z893CtM1T7C7caI0Mx48vUTJfrs77eZOwadk=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB4394.namprd04.prod.outlook.com (20.176.78.156) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.15; Thu, 5 Sep 2019 16:14:00 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473%4]) with mapi id 15.20.2220.022; Thu, 5 Sep 2019 16:14:00 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH 0/1] Cygwin: pty: Make it sure to show up system error messages.
Date: Thu, 05 Sep 2019 16:14:00 -0000
Message-ID: <5cb451d2-25ca-b052-6b36-6d772c3d445f@cornell.edu>
References: <20190905132227.1967-1-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190905132227.1967-1-takashi.yano@nifty.ne.jp>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.8.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:5797;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <320211A6AF7B084DB03BBD26E43FF01E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J/sme2w5Ezhk9j3Bl03SlrRhh0t7flvMGGHziZtqCU+oPgmW+a4+DgI3NpNMIdtgxAY+B1TejmXe2rmsYGmpqg==
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00163.txt.bz2

On 9/5/2019 9:22 AM, Takashi Yano wrote:
> - Forcibly attach to pseudo console in advance so that the error
>    messages by system_printf() is displayed to screen reliably.
>    This is needed when stdout is redirected to another pty. In this
>    case, process has two ptys opened. However, process can attach
>    to only one console. So it is necessary to change console attached.
>=20
> Takashi Yano (1):
>    Cygwin: pty: Make it sure to show up system error messages.
>=20
>   winsup/cygwin/fhandler_tty.cc | 55 +++++++++++++++++++++++++++++++----
>   1 file changed, 49 insertions(+), 6 deletions(-)

Pushed, with a couple of minor typo fixes.

Thanks.

Ken

P.S. Please let me know whenever you think I should make a new test release=
.=20
Also, I'll be mostly AFK for about a week starting on Saturday, so I probab=
ly=20
won't be reviewing any patches during that time.
