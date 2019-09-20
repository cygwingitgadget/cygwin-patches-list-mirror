Return-Path: <cygwin-patches-return-9711-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 110757 invoked by alias); 20 Sep 2019 22:00:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 110605 invoked by uid 89); 20 Sep 2019 22:00:44 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-4.4 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=HX-Languages-Length:538
X-HELO: NAM04-CO1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr690137.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) (40.107.69.137) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 20 Sep 2019 22:00:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=eNZVfpZhPdnoDzg+xvNokMse+a28lpWkNu7JiPkcolQ7x7HYiToeCnGSzhYqNbWc9/4mpMyVJ9+iQC3PCmjIaBl90mXoJZi5FC74h//ueGd6Km58i862XzaquQpARPdR1cyXQ78Mx18xoc+Qz7UJ9hdcnzcWvKF9q0dnE9FfNVyMfM1u2oyV07HnSRi4tIfHsVgpU1EngmQS2t186W+WhJMeQIspZW4xV5Nfs1hZozRCkYWtUAIGZVzkQXkql7btY02YQKv2eEUELxM7uM/6+IXHCKtdFPGiTTBYnu+62upjtduO59sCBzgEfLMJOWH4w5Us9sPCIz3eJxqD25jZVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=IFGU9HNYDeTJhTpqNyLKA1fUiWehIXfThjxPgiOqOYY=; b=Wk5xf97FfNEtlypMkLSb3iWB9P4xK30ri7PhJc+JgvCa2X10elNZWxNa9tIjgilJmVQioOl9eqhuuNDHOaKZ0j9JRgY+hGP0bPn/zj5r2sJFE3Na6izbGp1+8s9oVSRobHJcZUPK9hBeJmLTv/zuA3e1BKnpKf0bhQ1aiQDQl8AEw6SfXFJtO6s81Qkq1jbaQJL73MjBX0d7oSKrVvPQ48gT+V7+ZW9Izu9FZNGXP628oFkvtGFm7Rxs9QLHx9KE7ym+IhLPOMMAao/5mi69Sq/flz0PpEHpDSS8tzuP9hrpA0WpnWlMzps7Hcub4wo4Fp6YyYNRoZ1AYcIW1qpr5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=IFGU9HNYDeTJhTpqNyLKA1fUiWehIXfThjxPgiOqOYY=; b=UgW/pQVVhXznOZmQZlxbYYmK6dQZFGpox/MtEab3nzKqL3h7ACMH2bxvdFGHj0+V9HTjTr02qFF9k17z1EczI+GyUpUSalk0zBMF4akGeeePfvPunJe9D97FhIlS1VnvI6dKXqnucFizfP03agDMzl+0ZC4sx/NJ9xfyQ7BQonY=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB4667.namprd04.prod.outlook.com (20.176.107.140) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.18; Fri, 20 Sep 2019 22:00:34 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473%4]) with mapi id 15.20.2263.023; Fri, 20 Sep 2019 22:00:34 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v2 0/1] Cygwin: console: Make console input work in GDB and strace.
Date: Fri, 20 Sep 2019 22:00:00 -0000
Message-ID: <ae1a4ce1-37c5-2d1d-5f75-1f059aade2a7@cornell.edu>
References: <20190920211035.952-1-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190920211035.952-1-takashi.yano@nifty.ne.jp>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:612;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <03766CA81613F34FA5B5F709FE00A6D6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9npJU3kGfVz9d2ei+dnfs+iG1VbMgSBjVhlmmSHTw7icaypTbB0YUa+yUjAzjJPpxlAOlYfB5urK7y9as8ROog==
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00231.txt.bz2

On 9/20/2019 5:10 PM, Takashi Yano wrote:
> - After commit 2232498c712acc97a38fdc297cbe53ba74d0ec2c, console
>    input cause error in GDB or strace. This patch fixes this issue.
>=20
> v2:
> Patch pinfo.cc rather than fhandler_termios.cc. This probably is
> the right thing.
>=20
> Takashi Yano (1):
>    Cygwin: console: Make console input work in GDB and strace.
>=20
>   winsup/cygwin/pinfo.cc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Pushed.  Thanks.

Ken
