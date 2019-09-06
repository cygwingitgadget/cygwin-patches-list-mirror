Return-Path: <cygwin-patches-return-9654-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 74542 invoked by alias); 6 Sep 2019 17:44:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 74532 invoked by uid 89); 6 Sep 2019 17:44:51 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.9 required=5.0 tests=BAYES_00,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM01-BN3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr740115.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) (40.107.74.115) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 06 Sep 2019 17:44:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=HLl7qrSqc0Ew/+vOMe172nWqDmWaAvG2xIpKGX90SeBybE7zXOhMhbzuP5DDfXbZNCOT71ws3cNGvAKskeKWpjMWhteYBuUvW1yR2HA3abVfagCoJPslLfsyekEl97VY/WqkHOm6obekklzEjx+k0zaLqJygaNnNpyJaqTY6I83ZY5noFX6lDkXQjHXTmuPkhuik/BkQVfKBX4pC004IbwQJDOb/vJwyENhh5EnjJcRGaWJobyHk+utrpp3OfdssaAMsIZZHTrx1ECY5grXYt2UcuDm/O8rmAqDp7bMhkNLWL/lMKP+9aPkYr3mxMdHCqs9TM+jo+g0LoESXfd2F1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=GDkE0lrUD9F6piLK6hskdED52LkryCydOPtYEwZnSzo=; b=N5WH1GH3j2eFhVkjOc+ssfsKqONw5hTbtMFEVWDnKZS04XqvimjWVExcoTkPs8GJHPB/mms3U4rcbbVWhZwz82WcRJt+uW7xWS+HrHQFsKW4xt/W8HVNFgFzTnKtIpdG4kuC8AI6zu3zMvPtHDyfwOalmLud6gGxNUOiACOmwPa1Cy0cMbfLmxgObprdVkGTYRZZMYWBwnCUKzNsE3rZX8izC9Bx+atlTaS05Qc28UMgDXoxLmEypztgZ/d7aBHKWWV0YzsAK0DsQsnKqMpY+0esJ0fXy36V1zUOeMOVeVBP/GV89C7LAG2hUbgRATtYmiHnfQHcbkSbSfHYcfkoYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=GDkE0lrUD9F6piLK6hskdED52LkryCydOPtYEwZnSzo=; b=ezK1Q2hsb5nVnamwu4EkkzWpg0GiVIM0fIxfS1IWNsG7AKBEdBh234xeWChywU8Y4kd4MrbEVqh1VYlHoVp2+2uFiuBQUXbkPSX+GhSaLrWBQqYQB8E1YY14VkmfW/glnTQ5hxHAHbCeBBcQoYhpMlzSbOeAzDf6eeFsXFNvGVw=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB4713.namprd04.prod.outlook.com (20.176.106.13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.20; Fri, 6 Sep 2019 17:44:47 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473%4]) with mapi id 15.20.2220.022; Fri, 6 Sep 2019 17:44:47 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH 0/1] Cygwin: pty: Make SetConsoleCursorPosition() to be hooked.
Date: Fri, 06 Sep 2019 17:44:00 -0000
Message-ID: <6874f1b3-0546-b8e8-6919-17afc3e38116@cornell.edu>
References: <20190906130127.1928-1-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190906130127.1928-1-takashi.yano@nifty.ne.jp>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.8.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:2958;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <3820BBAAA3CF9F40B35E3FD7F2AFB4B2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JOCCvP1niIoAjPEscu6tJiK1b5k3c71FFGCbA1Be08ZdOxfwrg+lD3jvXv0/mTW21hv2G10lglgUUKK2KJiWtA==
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00174.txt.bz2

On 9/6/2019 9:01 AM, Takashi Yano wrote:
> - Win32 API SetConsoleCursorPosition() injects ANSI escape sequence
>    to pseudo console. Therefore, it should be added to the API list
>    to be hooked.
>=20
> Takashi Yano (1):
>    Cygwin: pty: Make SetConsoleCursorPosition() to be hooked.
>=20
>   winsup/cygwin/fhandler_tty.cc | 9 +++++++++
>   1 file changed, 9 insertions(+)

Pushed.

Thanks.

Ken
