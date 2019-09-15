Return-Path: <cygwin-patches-return-9685-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 64252 invoked by alias); 15 Sep 2019 15:36:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 64241 invoked by uid 89); 15 Sep 2019 15:36:45 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-4.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=screen
X-HELO: NAM05-DM3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr730093.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) (40.107.73.93) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 15 Sep 2019 15:36:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=FQpseIbvg129jYkMAQ9kPkfBr/VtisK8vtd9CEV33ZlNfZ950mojQ4ZX+PXXKuI99ivxedl0Ac+JWo1pLpigxM5vSpYTE5vaJsNhkhAVkm1tekSVXogt3lSKRQ282GYs6bHsMrKhh3mdxHezAUXvhDoZw3SXsQ6CPywG+T7DJmYubYgX0quZAB98aJwEByQZyWzkPc71o5AJLWMzW7IuK9rWl7CemPVFmsIuMNwUztpP1Gp93145Df/L7VIspSjhML27mBL78+gbR47YdEDDWL061v/HB5bNHqwTzHv397zLBDE4grHAa+akLIx+rXPq8UipifTmqM+1NYyS9S/jqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=iJy8OOgb3x3hpaSYGoO9psjjem4vpxtNVbd+FjZpwTg=; b=PYkA+NcoS69Yi3iDDvqOxr0VI2tTLMh0EWFNWx68LfA7hubrINXcnRwB91WJNOfFWFA3NfU+iXW2Y3/iQye77cOa+MBEAKl0YrX7eVBzGOSwvZCJpyIoYYjj897S12N+80Uo8hKs7qvzfIH90ZGCQqOIp6p6r9/hZArufFtEMQ1QWV4DKRy8GxS9E7AOdJvaTy3zR7uJ2JGz1JT4urd6O1ESYxULrxHt9IudN+VK7JxAzg6Kg8yMIsUVzTSfnP1iQNS2JqImDZMXnPQX84n5Ms990WXEjBPoN9vZGT59fScr2qkSPsI8+plevopMUfyr7C4ch2U4wcnl0CGI/uDFIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=iJy8OOgb3x3hpaSYGoO9psjjem4vpxtNVbd+FjZpwTg=; b=WSJkXwCZNLgwE1orV6j8vgHmQxtqYjDq3Kug745njHPmGVoyQsV1snOkxJu1Yukpcb1FOA3HY/08+KzC32Wn18FaOLFbHxlvi5k+7sLFNpMkknxiXjCaMdtU4La8SwWMAqodNKp4wm54TaVK8KvKQdh8Chc3Lqy/JPywcdWU6+s=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB5801.namprd04.prod.outlook.com (20.179.51.84) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.26; Sun, 15 Sep 2019 15:36:41 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473%4]) with mapi id 15.20.2263.023; Sun, 15 Sep 2019 15:36:41 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH 0/3] Some fixes for PTY with pseudo console support (3)
Date: Sun, 15 Sep 2019 15:36:00 -0000
Message-ID: <94fdfef4-fa74-423b-09ef-f6037ad28e33@cornell.edu>
References: <20190915040553.849-1-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190915040553.849-1-takashi.yano@nifty.ne.jp>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-exchange-purlcount: 1
x-ms-oob-tlc-oobclassifiers: OLM:7219;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <FD96F8F178E2EA4CBCEAC51B732788CF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zwZKgMZWnxLV++Y1uTtXK0w0QC5MMxF5UbfxHMt7jtBql7tNczE2wJ/kLy382e2XLJxcK+pByg0elPEuiZ8+Rw==
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00205.txt.bz2

On 9/15/2019 12:05 AM, Takashi Yano wrote:
> [PATCH 1/3] Fix bad file descriptor error in some environment.
> The bad file descriptor problem reported in:
> https://cygwin.com/ml/cygwin-patches/2019-q3/msg00104.html
> was recurring. Fixed again.
>=20
> [PATCH 2/3] Use system NLS function instead of PTY's own one.
> Since calling system __loadlocale() caused execution error,
> PTY used its own NLS function. The cause of the error has been
> found, the corresponding code has been rewritten using system
> function.
>=20
> [PATCH 3/3] Change the timing of clearing screen.
> The code which clears screen is moved from reset_switch_to_pcon()
> to fixup_after_exec() because it seems not too early even at this
> timing.
>=20
> Takashi Yano (3):
>    Cygwin: pty: Fix bad file descriptor error in some environment.
>    Cygwin: pty: Use system NLS function instead of PTY's own one.
>    Cygwin: pty: Change the timing of clearing screen.
>=20
>   winsup/cygwin/fhandler.h      |   1 +
>   winsup/cygwin/fhandler_tty.cc | 527 ++++++++--------------------------
>   winsup/cygwin/tty.cc          |   2 +-
>   winsup/cygwin/tty.h           |   2 +-
>   4 files changed, 120 insertions(+), 412 deletions(-)

Pushed.  Thanks.

Ken
