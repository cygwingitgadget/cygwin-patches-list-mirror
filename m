Return-Path: <cygwin-patches-return-9727-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21613 invoked by alias); 26 Sep 2019 12:50:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 21603 invoked by uid 89); 26 Sep 2019 12:50:34 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM03-DM3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr800095.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) (40.107.80.95) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 26 Sep 2019 12:50:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=XlKD5OYJSuSkcw+BwUqUlP9PywOy1SIzYzzgdKO077hK0XqZBb6QI9CU+xuxjI/+YSSbw83k1aR0aA1DGbwZ3IKVCzIGKiy06x9KzGmUvg3djS6xqSq3otPIZfEAp4211vYXAcXPwO2MzjWf9bbxm7rHNjCqZF/KYKtI5reAsOfvt8No1KIzB9xe7zsLnoOMVK31qiRmQtSiMJXjV23kLUtKduhoId/Z51RoEw/ljoXvnlTMCqUtRxuUViMHAkLEaG3NfP2k4ZeHjl5QX/aJbVkmOVGrVkB+/xl/mQgC63bs01MniNuBx4K0slAr5kF6SIUJ1qJX1O4c5QgVdrx+Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=Z4+rhd4u2TSVfduNGYI/lYv+JTTNM/qvixwZVkQnIa4=; b=iUWps1u5AzFxPrb1yLToxRRNhaiebHy7dNnaw5gkLi51sFSOZ9W2iCKqYX/QaeeSdJ/NzJUuWMTR6JdvpD8JaUTrIBhPC/9ckUCyXXggidL/fEZX3HJ7D1lrNH9419sOvYVfkxz8CS9xykBmBx8uqmXVmPPw2acE7BGpdLzW03F0uaN0CSu27pq6KoVJyAzzFR20XMMCpr0RIr/s0am/1f0cuNVv4G+ASOZ6tTP8pyd1qyLkcNK6gTZe8O39pYR5S7dIfJ2AS0UKgOabp4v1bBJxFCebs0286SwyA6+yb0hNP+eZrqX+vVan0dg5tmGALAD3EmGr3JKMtuT3Mj/+fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=Z4+rhd4u2TSVfduNGYI/lYv+JTTNM/qvixwZVkQnIa4=; b=Bz+SE1DpBNsFbzQUaPBMkbdoWdeL+Ncvkceit5sT+E/H5cvgaZfWWYImmt5oPKyPxJKvJ7i1YVd37FYGBzqY33KThi8QziKSWc/4u7ln90IpTAor9l/ue5YSO+h03B43hxm/1ZDJuG10k5DlNkQ7d0Rg/rc1cDZfJrFKCLGuPyA=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB4346.namprd04.prod.outlook.com (20.176.81.144) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20; Thu, 26 Sep 2019 12:50:30 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473%4]) with mapi id 15.20.2284.023; Thu, 26 Sep 2019 12:50:30 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: pty: Fix PTY so that cygwin setup shows help with -h option.
Date: Thu, 26 Sep 2019 12:50:00 -0000
Message-ID: <6aa0603a-4cc0-a3af-74aa-cc9051d88c24@cornell.edu>
References: <20190926105246.914-1-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190926105246.914-1-takashi.yano@nifty.ne.jp>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-exchange-purlcount: 1
x-ms-oob-tlc-oobclassifiers: OLM:158;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <0CAA21C8478D3C4AB5F2989805FC3B6F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: no1DG47xjQK/NMPb+sdmdg03LwaEk2D7R93GJyyPXqXvGcFIG5+uAy16IFP0HpcmS5IaMPgSPz0jiEvuRTkV4Q==
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00247.txt.bz2

On 9/26/2019 6:52 AM, Takashi Yano wrote:
> - After commit 169d65a5774acc76ce3f3feeedcbae7405aa9b57, cygwin
>    setup fails to show help message when -h option is specified, as
>    reported in https://cygwin.com/ml/cygwin/2019-09/msg00248.html.
>    This patch fixes the problem.
> ---
>   winsup/cygwin/spawn.cc | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
> index 4d8bcc9fa..f8090a6a4 100644
> --- a/winsup/cygwin/spawn.cc
> +++ b/winsup/cygwin/spawn.cc
> @@ -790,8 +790,6 @@ child_info_spawn::worker (const char *prog_arg, const=
 char *const *argv,
>   	  NtClose (old_winpid_hdl);
>   	  real_path.get_wide_win32_path (myself->progname); // FIXME: race?
>   	  sigproc_printf ("new process name %W", myself->progname);
> -	  if (!iscygwin ())
> -	    close_all_files ();
>   	}
>         else
>   	{
> @@ -890,6 +888,8 @@ child_info_spawn::worker (const char *prog_arg, const=
 char *const *argv,
>   		wait_for_myself ();
>   	    }
>   	  myself.exit (EXITCODE_NOSET);
> +	  if (!iscygwin ())
> +	    close_all_files ();
>   	  break;
>   	case _P_WAIT:
>   	case _P_SYSTEM:

Pushed.  Thanks.

Ken
