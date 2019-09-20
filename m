Return-Path: <cygwin-patches-return-9710-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 108663 invoked by alias); 20 Sep 2019 21:59:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 108632 invoked by uid 89); 20 Sep 2019 21:59:52 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.9 required=5.0 tests=BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=HX-Languages-Length:593, apps, segfault
X-HELO: NAM05-BY2-obe.outbound.protection.outlook.com
Received: from mail-eopbgr710099.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) (40.107.71.99) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 20 Sep 2019 21:59:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=N++ByAoRTKXymsyq0JlMKZmsKQ6coAbm0O2KdS2WOqrDM1M0F8I4zcLPCb/cmKaOhxqmk4SYvs0bqbGh3pmG4k1s6fYmSQ5xuRk3wx0sIkatqQXAcVkgyA5kMn+ynC/PvJFq0s+8qLBJTjKU7SYAojUrgRoAPcWUbfmpkJmI3SYcRiM9PM2Na6ch2ubm1htu0Om7EsLb664yW2gBaBfv7uU0MoGkMe7D9Od4LAYDnQwKEUBQ4Ugpu/NoysmA2SeDrQbHrsaRaHL7m/0KQBcNGELGXgSY6CTaZZxsdjFxljQ/5LmRkRstNdt8PENVB1drepdA5rBkrLX6GzoUzbFXhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=Dd3IVvu2ywJS2kqYtjsOWHs9fE1mXbHZnhxwOcSmJW4=; b=TwIeJ4f9wQHkDxEdXticgbyg5Uxs3x4O5bm8adEETrBa95UMBw4Ovzk8c42yBh99x9HDY94ReHGIrb4TDW478ft4Uo3K54WCST2AW1XRxJZOPBU+zGGomJhDCpUffIUYkvgShlSTMr3JgnJds/exQeJGMbW6xGS+mW2sAxrpP6aMShWHCtXxXupxMfAI7WgTmFLQ+VJEMWIVDdaOq2HV4x0UN9a+QQa+xl98umReVKvQmOQfFaAjAhYhL3QTPkFfO7sSxijYyQdb6mznZmRlAUyDohoHudUNOicCdGjiwDin7mJs5OTmKj3W9eKRgX4SqKxyWfmPthJeAnwI5VgUEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=Dd3IVvu2ywJS2kqYtjsOWHs9fE1mXbHZnhxwOcSmJW4=; b=O1aFYtjqLCwomHcALF14jDyDaH3lrMSB/eyEsU7UM2qoF2vMCYrTombptnIpkUyzeaBg7MhpwLygbxDZ9gMQKdcdzAd5rSWEydtSF1d2o9Lp8IVBcsNyFIYICN9d4mcTPkQhs1APZjTjaTgXoTrTor+f8XGbBgzrCVuP7DSw5V8=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB4667.namprd04.prod.outlook.com (20.176.107.140) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.18; Fri, 20 Sep 2019 21:59:49 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473%4]) with mapi id 15.20.2263.023; Fri, 20 Sep 2019 21:59:49 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH 0/5] Some fixes for PTY with pseudo console support (4)
Date: Fri, 20 Sep 2019 21:59:00 -0000
Message-ID: <550330b2-3d44-1cec-1541-810eb8c9607c@cornell.edu>
References: <20190918142921.835-1-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190918142921.835-1-takashi.yano@nifty.ne.jp>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:3383;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <60541CA4841AE14983F8CBC4269D8FB5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DyQ+8/TqyTTJCeeVf7E6/ti6lQoKd+eroj+0SOLcslGZIw7K8I5YvaWvZlfKhueR2x1ZbJnhEcvHZ1z7ykMcHA==
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00230.txt.bz2

On 9/18/2019 10:29 AM, Takashi Yano wrote:
> Takashi Yano (5):
>    Cygwin: pty: Avoid potential segfault in PTY code when ppid =3D 1.
>    Cygwin: pty: Make GDB work again on pty.
>    Cygwin: pty: Unify the charset conversion codes into a function.
>    Cygwin: pty: Add charset conversion for console apps in legacy PTY.
>    Cygwin: pty: Add missing guard when PTY is in the legacy mode.
>=20
>   winsup/cygwin/fhandler_tty.cc | 188 +++++++++++++++++++---------------
>   1 file changed, 104 insertions(+), 84 deletions(-)

Pushed.  Thanks.

Ken
