Return-Path: <cygwin-patches-return-9676-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8521 invoked by alias); 14 Sep 2019 15:29:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 8512 invoked by uid 89); 14 Sep 2019 15:29:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.9 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=screen, five
X-HELO: NAM03-BY2-obe.outbound.protection.outlook.com
Received: from mail-eopbgr780092.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) (40.107.78.92) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 14 Sep 2019 15:29:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=eGTDvaNbrAAD30uQNJ4kuCfOy+TN//j5eHERxtFtK2RQI+XL0i4MJdV6ibihTNFgTn4xrbwcptmYW2JvAwegBmO0gspvBs40fvQLz/qBV7N43LhvFhr/W7VBCF2f78XUx62h6LdmVPWfXr5jHGarDvbbT6Ne5JcF/HZD+l+uCoBeDTJLjnrA2DZzCDbi1+Ryj8MpTzz5jbgn1YMddN/meg7MEKw/gJ091En5TNgEkhg/0+uU0EKjmYV6JMparj5tzTegEieR18IPsiU1ESod4Jp9DNoY5VkuLj1bBqen3mS63J6OnFKjd9Xagu2b0EUUKXYNmBQs6Q2V0Op+aU43Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=c1srSrDFja4sZDOrQox06FRKGfpTERMy6nKzgNT+y3w=; b=MnX5AhAp8bwHTrnssE/VVK9yY2NvtyIiLBF2w7L3JgXibtHvNLrcT+jWKlbtLkXVlsBJxF1EmgzLLr7Z9XIS6aU4zV7PcVggCIE6QqToQIl3oCAwQWPtBPecXU7HX4YelhoF4bZUtybmP6W5qQ9GxbeTaY1WD0i4ubkYhEPagHvPpz+MO8p2fDFkNSCerxWWGHIxBLf7LtNwsYe7HISzUI2rRIsmQLbmneaV2z/qIHMdo+19295Xa8P6pea++Ri/8rHEmR9/DANUhvKJX+eGfXwXKrJRfn7AMKxqie2ZA0eu4B80Uen0oBL74Bj+88fcMia0IrDXIaqTS53bT+5m3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=c1srSrDFja4sZDOrQox06FRKGfpTERMy6nKzgNT+y3w=; b=TLG8Y3179rUMEJl2hjq0oW3bALeXKpPWSuw3akGdc7XloPhdx69MuSczc74o97Hiw2+Eausnm7CXO9bpIZpnnWlgdOVPA7p0rXw8W9BVnRaxNm9ovH7DEhmhdvqDoIu6ytfXTTfguM8owiEI1hv6TchVKVoD1lV5FFIqSFWMOZk=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB3833.namprd04.prod.outlook.com (20.176.90.151) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.17; Sat, 14 Sep 2019 15:29:50 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473%4]) with mapi id 15.20.2263.023; Sat, 14 Sep 2019 15:29:50 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v3 0/1] Cygwin: pty: Fix the behaviour of Ctrl-C in the pseudo console mode.
Date: Sat, 14 Sep 2019 15:29:00 -0000
Message-ID: <929c430c-b6bf-148c-34e5-a784101c425c@cornell.edu>
References: <20190906145200.802-1-takashi.yano@nifty.ne.jp> <3cf7455c-25b6-5c97-3cdb-d68590e44d8f@cornell.edu> <20190914065234.21c01267db0e0eb3f1347ff2@nifty.ne.jp>
In-Reply-To: <20190914065234.21c01267db0e0eb3f1347ff2@nifty.ne.jp>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:6108;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <1A3473F0809C0F44AA6CD4AECDEB531B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZqTuoM3kO6aZFZVMmWYPd6qiVls/tcWfVh3Q8T6ds3DPMkzEQl+o4UoieM/aUCgjpXBFftpXExnbjf832k3DQw==
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00196.txt.bz2

Hi Takashi,

On 9/13/2019 5:52 PM, Takashi Yano wrote:
> I submitted five patches during your absence.
>=20
> Four of them are for pseudo console support, the other one is for console.
>=20
> [PATCH v5 0/1] Cygwin: pty: Fix the behaviour of Ctrl-C in the pseudo con=
sole mode.
> [PATCH 0/1] Cygwin: pty: Fix screen alternation while pseudo console swit=
ching.
> [PATCH 0/1] Cygwin: pty: Prevent the helper process from exiting by Ctrl-C
> [PATCH v2 0/1] Cygwin: pty: Switch input and output pipes individually.
> [PATCH 0/1] Cygwin: console: Fix read() in non-canonical mode.

All pushed.  Thanks.

Do you think there have been enough changes that I should issue another tes=
t=20
release, or do you have more patches in the works?

Ken
