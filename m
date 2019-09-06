Return-Path: <cygwin-patches-return-9655-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 105105 invoked by alias); 6 Sep 2019 17:59:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 105094 invoked by uid 89); 6 Sep 2019 17:59:07 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.9 required=5.0 tests=BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM02-CY1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr760108.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) (40.107.76.108) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 06 Sep 2019 17:59:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=GlkAdOxdwcU89uukCUz3UQnUR7Xhc3/AsSAHNye+y7QiVPPr1PmPFGjz2R6/r4ZqjwAC+BVqBnAxvDpBC8B7rjaW2uGcCnOLD86/bhysBDTSRITboYUwkzdkK0etJqKKz4RQuhIfGPW9TyWy/bGlQPV7k5R8kTnxCCGcm+51aQ5BP06gFkkjh76IhRPygiKYtuZiXX6JZS7vGzTvpIUj5Yuc+tQUlMNrIpsTAS+YlGFoy7GQDq3lNEp07+GU8KJpdbNzgb18yZzD2yv7AgteDemD0cQdQFxzgXw6hCXueABo5FzKp1NZMWr6qLdHxFkmnx0ZQq0D1l99AROQrYSUag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=MFAyHDL/l7MKdE2pAOKMM/XiN8JM3bESw5XvIE5W5oU=; b=LMf3S6ef5NPgLIMTJNtFEhdZxgRPDn/Yg1xRDkCabn2w/7ydjIulkxkRJcTueWwWJSggO53xD4+trCEoP+S9oSigFaAeeHGKIeTYQ2jOELK7N3SoFXhv2S8p9JkxDhE49r5h4umw18Eh4IekZIS3TMjte2TY+vKl/i+O15Aj4nwJk9/iagwz0C0P0EqflUTmFi1HrsdcKzJbM6/X+1kn04f7pyMC4FoD2wm/js4Z7IpRJkFEBj6DDs+16oH1DbZm7yzyV1I+Ldqq2frgXMiJkMEWoA9xJnrDb4xn5upg0WzqNO5AAgJjCk6ijEXLMqGZilttKvfUs0vSY1IQZzPR2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=MFAyHDL/l7MKdE2pAOKMM/XiN8JM3bESw5XvIE5W5oU=; b=U2eRXy03GHA5FsfB1ej+vBi3C5HXmSeJgWTR7wG0SSTmLTos1Sn/HO+tOg2GvfmvKaEPSnJswpsv4HatwmibXABnbSVt6ehCYlAkRE0keR5ucXiCkriAmdUMmDRElPG2XZlvEag3elZBnFVkpd7V1iq/M9rCQ2HIo0pr2GBCxR4=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB5641.namprd04.prod.outlook.com (20.179.48.95) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.15; Fri, 6 Sep 2019 17:59:02 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473%4]) with mapi id 15.20.2220.022; Fri, 6 Sep 2019 17:59:02 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v3 0/1] Cygwin: pty: Fix the behaviour of Ctrl-C in the pseudo console mode.
Date: Fri, 06 Sep 2019 17:59:00 -0000
Message-ID: <3cf7455c-25b6-5c97-3cdb-d68590e44d8f@cornell.edu>
References: <20190906145200.802-1-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190906145200.802-1-takashi.yano@nifty.ne.jp>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.8.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:8273;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <5C9FC5E7241B8A4D96D0E667C7D34A70@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OyTIZnm76luGm/SqI+77Z/XSHGInqujYounSIDFknlg98FcTEhEwxyCfeDUw0UOAq1aUQroGho4a1anPIlMN4Q==
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00175.txt.bz2

Hi Takashi,

On 9/6/2019 10:51 AM, Takashi Yano wrote:
> - When the I/O pipe is switched to the pseudo console side, the
>    behaviour of Ctrl-C is unstable. This rarely happens, however,
>    for example, shell sometimes crashes by Ctrl-C in that situation.
>    This patch fixes that issue.
>=20
> v3:
> Fix mistake in v2.
>=20
> v2:
> Remove the code which accidentally clears ENABLE_ECHO_INPUT flag.
>=20
> Takashi Yano (1):
>    Cygwin: pty: Fix the behaviour of Ctrl-C in the pseudo console mode.
>=20
>   winsup/cygwin/fhandler.h      |   4 +-
>   winsup/cygwin/fhandler_tty.cc |  33 +++++----
>   winsup/cygwin/select.cc       |   2 +-
>   winsup/cygwin/spawn.cc        | 128 +++++++++++++++++-----------------
>   4 files changed, 89 insertions(+), 78 deletions(-)

I had several problems after applying this patch.

1. I noticed some display glitches when building cygwin (with -j13 if that'=
s=20
relevant).  For example, there were some unexpected blank lines and indente=
d lines.

2. At one point the build wouldn't complete at all.  It hung and had to be=
=20
killed with Ctrl-C.

3. I used ssh from my normal account to log into an administrator account. =
 I=20
ran a script that produced a lot of output and piped it to less.  I pressed=
 'q'=20
after the first screen was displayed, and the displayed text didn't get cle=
ared.

Ken

P.S. I'm leaving tomorrow for a short vacation, so I might not have time to=
=20
review any more patches until I return in about a week.
