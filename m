Return-Path: <cygwin-patches-return-9712-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 112468 invoked by alias); 20 Sep 2019 22:02:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 112456 invoked by uid 89); 20 Sep 2019 22:02:08 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-5.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM04-CO1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr690099.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) (40.107.69.99) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 20 Sep 2019 22:02:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=QsLFDbPETz/eZdLoywM8cVP+q96bxYen8+BRFahNBQIjoh0iAnNYAW10iimRsu7NGXpQfwnCUW+AOpcaIadtJ7+6sKfvslCDpe3anYRRXmzzNXBtoXQNAnr5rQiez6O52WHe92ZdPbttanBuGPNS8KbUHWlX3YD2r8ql42S9ulI7KBh3hBqU7JUTqaDRuHw/97C/VDsQswBHmXde7mn6rVi7lX/VZ6BULqF6akDlVH0/8XhZH3yp/p3I2ZhccN3Vn0q/rKNcJMeITwy2A6K5ITD21PxYivPJpRdQXMzvTIq85FiUh9ssA3YWdLuwyBO3B6mpXTVUU4Jk/IbtrRX8ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=dS9bvoTnnhXQEO4TZ0vRCLmG/YPhwBlq1MLDda5fiXY=; b=KSl7Vlz5916l4p11/4SW2aqIA/0M97LemxjZ9gCPTHI5czgs6P2yv3yFB0CLp0rh4+8i+P/xAFJdqCR9Iay/9Bc9GSrQXjQSRCOWCVQKZXEFx9uN818dZ+pV83bNqY1a119xJfSs4dYX0du8MQA9sYvy93laEjaZNIPw9XrZBe3uUU6vSS8mdnVfi2qBi+wdo1Erb9StB9wbSgwFweUSLunbDHbUzYyxP+9ImJJ32fYVKa6XSz7yoksZEfOzTyteN4BGILfr8q+ZmH9qAhSP5ZSKii7GWPLc1SShSnhjI67FtDWWrdYgdjVW/GiTX30JSxZAIGWn9qlVGJ80E+odQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=dS9bvoTnnhXQEO4TZ0vRCLmG/YPhwBlq1MLDda5fiXY=; b=eAxk6CPCQLcrdgcDZztaUe+qGdEESJgFIUfS0kDb9xMj1Xhfkr5Wth3Gun++xL0AzXiOOGYt0/GCB+WIvQMzKLgaZRtyFCCJHJouKb9MBKIlICXfpxFuWxLGwiiFVqFSq9RE0CkhOIPVurA/L+CnMMHgJRUyDiHdeMHCWEkY23Y=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB4667.namprd04.prod.outlook.com (20.176.107.140) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.18; Fri, 20 Sep 2019 22:02:04 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473%4]) with mapi id 15.20.2263.023; Fri, 20 Sep 2019 22:02:04 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v2 0/1] Cygwin: Fix incorrect TTY for non-cygwin process.
Date: Fri, 20 Sep 2019 22:02:00 -0000
Message-ID: <e9e782b8-95b3-69bd-ac1d-c139f670a56f@cornell.edu>
References: <20190920030436.973-1-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190920030436.973-1-takashi.yano@nifty.ne.jp>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:741;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <2C9FB79744D4F94CB78F24FBC920C35C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hvob+dGzALisodF3aEmRZ9KfdWFgJnJX178JmUC1xkNpAMWZRHchd3SYxzxnFYKtYxIS5sPakHOLFKqBsZyBGw==
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00232.txt.bz2

On 9/19/2019 11:04 PM, Takashi Yano wrote:
> - After commit d4045fdbef60d8e7e0d11dfe38b048ea2cb8708b, the TTY
>    displayed by ps command is incorrect if the process is non-cygwin
>    process. This patch fixes this issue.
>=20
> v2:
> Simplify the condition to call proc_subproc (PROC_CLEARWAIT, 1) in
> exceptions.cc.
>=20
> Takashi Yano (1):
>    Cygwin: Fix incorrect TTY for non-cygwin process.
>=20
>   winsup/cygwin/exceptions.cc | 2 +-
>   winsup/cygwin/spawn.cc      | 5 +----
>   2 files changed, 2 insertions(+), 5 deletions(-)

Pushed.  Thanks.

Ken
