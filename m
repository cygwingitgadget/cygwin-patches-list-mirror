Return-Path: <cygwin-patches-return-9675-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 68499 invoked by alias); 14 Sep 2019 13:11:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 68490 invoked by uid 89); 14 Sep 2019 13:11:00 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-4.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=H*i:sk:2019090, cygwin-patches, cygwinpatches
X-HELO: NAM03-DM3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr800125.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) (40.107.80.125) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 14 Sep 2019 13:10:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=Famh0WpxToZc9Y8XD+mu03wOC9Vr+oy5QIvJc9S/mLHG/+pEGwmowMRLnslq929wwKHJteTaBI757y0p1v1AZD2yTm7+QrJeiy1V7/ifygWClYJ44zjD4onEWN2a2sJUUpC91nSSnO/YGTisTZp//mC+Nrb3duX5wLJmH2FAQJ2BAhqBFGEXpFKzWgiWR0LmZjBWbFFa9E2Kok2VnvTZgS20GtHb/IJjq76rFZMHmBqRjKrtHGtJuaw8yRrHRcQ+k3ieV3to3esBdZNHLT/XojlWR5cnGL9/KfpsiuCjT4QyCAtxreHhw+d0uURWXABO5py/ynFaU5m65IY++6my1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=I108q9tyoY0ZpiEHPIZR2fwvqGstS4SFRNpmnfHSABc=; b=WxkrYfVAas3tcAXLRtMSPDkUb8Nv1V5/nlYFskJrvUPgOnqWnQRppDHcuZhgdKvKkQwOJ4oqrOqI5OPCybwORdCIgiodZi8qVInbHPCuE/pmy7Yo+C8kERmE0mqdMh04s5lZhY1txRB6XwnRDIq0Ykhv34q2TNddF41Agi576HYCwuJ409Cd+6mJHQt4/XtIMl4hLWcctOuajh5QDSmIboj7mfu9GUU1XleUYHxD8EgKFpHPRtVor5nzR6H29t3ph0ly6vZbLVkFfN3jjoIh+UeHLm9e4CNU97p2pZzzswLQKmV42S2CPC4IMqRodkkfdjoG0PzuJ/1aXBf0w+kFWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=I108q9tyoY0ZpiEHPIZR2fwvqGstS4SFRNpmnfHSABc=; b=exDhoeSCGcS//fSaBmZuf1HWlH2J3ImN8pZH3yWl+O7EjYg2Q/OZIpBhoFzzh9KBqf0SI3JiQAANKUj4lEvbZk6JZyp9NwdfMt1ze0Rxg5l3e8qLhSNX+dACSu6xzPX8KxqkIGxvpnkRxDol5CzyXgd0QLbOFl1mA8DUxvg96gM=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB5385.namprd04.prod.outlook.com (20.178.27.22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.21; Sat, 14 Sep 2019 13:10:51 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473%4]) with mapi id 15.20.2263.023; Sat, 14 Sep 2019 13:10:51 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v5 0/1] Cygwin: pty: Fix the behaviour of Ctrl-C in the pseudo console mode.
Date: Sat, 14 Sep 2019 13:11:00 -0000
Message-ID: <349fb4ea-9e1b-3dc7-4167-0ba77a73b8ec@cornell.edu>
References: <20190908125835.5184-1-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190908125835.5184-1-takashi.yano@nifty.ne.jp>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-exchange-purlcount: 1
x-ms-oob-tlc-oobclassifiers: OLM:5797;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <1DE90D2A6079AF43B355BAAA64D8355C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qBt1SC7XYTns77PM17ef6hW64iUpGnkAjyi2/ClKrDlywJVdzjhfBJ0CytOYpijs56g+Kw3DNyBmPgZvgl4UOQ==
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00195.txt.bz2

On 9/8/2019 8:58 AM, Takashi Yano wrote:
> - When the I/O pipe is switched to the pseudo console side, the
>    behaviour of Ctrl-C was unstable. This rarely happens, however,
>    for example, shell sometimes crashes by Ctrl-C in that situation.
>    Furthermore, Ctrl-C was ignored if output of non-cygwin program
>    is redirected to pipe. This patch fixes these issues.
>=20
> v5:
> Add a workaround for piped non-cygwin program.
>=20
> v4:
> Fix the problem 1 and 2 reported in
> https://cygwin.com/ml/cygwin-patches/2019-q3/msg00175.html
>=20
> v3:
> Fix mistake in v2.
>=20
> v2:
> Remove the code which accidentally clears ENABLE_ECHO_INPUT flag.
>=20
>=20
> Takashi Yano (1):
>    Cygwin: pty: Fix the behaviour of Ctrl-C in the pseudo console mode.
>=20
>   winsup/cygwin/fhandler.h      |  4 ----
>   winsup/cygwin/fhandler_tty.cc | 44 +++++++++++++++++++++++++----------
>   winsup/cygwin/select.cc       |  2 +-
>   winsup/cygwin/spawn.cc        | 42 ++++++++++++++-------------------
>   4 files changed, 50 insertions(+), 42 deletions(-)

Pushed.  Thanks.

Ken
