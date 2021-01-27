Return-Path: <kbrown@cornell.edu>
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2133.outbound.protection.outlook.com [40.107.94.133])
 by sourceware.org (Postfix) with ESMTPS id 5306D3857C73
 for <cygwin-patches@cygwin.com>; Wed, 27 Jan 2021 12:16:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5306D3857C73
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JyIwq0FBLWN57nAbtrG+i4KmZJTZ834/9Ljo2gYqDH5eOU6YziPthvAHnp41tb2EzmP77S+49mQtgoyWI4jAWPRiJ+wo/A3q21fmyIIwN5vPq8oWeTQT3b/RrLJi2nJrLfpbdToxiQwz17+Qe/zfskaj8s43YUTGiUy6/TYL8Jlca2UtkkdrM8SyKYe+gFk8NvPHSeak+CVkLvKUOqE/2Wune2S+cvBj10t2E8n3LuS8RAR8INi4NhH+LV5TsK0uR9bXgo1LH8fp5fXA5KzGrCnLkh7FVUBupoK1ipmbSeiYC1XylEn55YedZwQ/dfjKyhJpoURn8aY0ZjZS+R24TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMh0aZGbtmP5HMwST6zSXCSlNxnTHKZ39DKPKg9pzuQ=;
 b=lTVswdacMHvL8Aakne5JKuTztBtS9oRtNSRJB9svStFIiYSo0Xvu/9x1TavGZ2zUiTKpLOExtT3RND960R/QAVuT6XxJuLmu6+NA8QSm2pM5GAQkXBxmiAEsymj4bPc1fk5LtqlZYKYfQpAFfdkkNMjThXJX2qrSZ+32WFHy5I+mfW2v5M0xwY23XUKNfd7SYKPuUvB4BCMwziemHpS5a7ymuPFMkQvowQT+4fUNhh+q+2kON+KiUtfXHQR7MQrFZ/SY6vbFAQUXkHVPpAJptD+mDqro54mcZpfcEkrzWIriJbPEQ7wznJWCV3mXv5WNU3nUuLO/9eedVnNCu1qwQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN6PR04MB0900.namprd04.prod.outlook.com (2603:10b6:405:3e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.17; Wed, 27 Jan
 2021 12:16:14 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%6]) with mapi id 15.20.3784.017; Wed, 27 Jan 2021
 12:16:14 +0000
Subject: Re: [PATCH] Cygwin: fchmodat: add limited support for
 AT_SYMLINK_NOFOLLOW
To: cygwin-patches@cygwin.com
References: <20210126213050.41241-1-kbrown@cornell.edu>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <474fd463-1540-d575-4192-157c9a840de8@cornell.edu>
Date: Wed, 27 Jan 2021 07:16:11 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20210126213050.41241-1-kbrown@cornell.edu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [65.112.130.200]
X-ClientProxiedBy: BN9PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:408:fa::29) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.13.22.4] (65.112.130.200) by
 BN9PR03CA0024.namprd03.prod.outlook.com (2603:10b6:408:fa::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.16 via Frontend Transport; Wed, 27 Jan 2021 12:16:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60cedb97-e1bd-4495-c77a-08d8c2bd570a
X-MS-TrafficTypeDiagnostic: BN6PR04MB0900:
X-Microsoft-Antispam-PRVS: <BN6PR04MB0900AEBF070F6347323FCE83D8BB9@BN6PR04MB0900.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jiyhiSOEqK8JVvyvwEJ91b6ssRTi9Z85fuVK2f64JkWQiGdHmpME0/dY3ibGoIPy1hAKxM6LiUn2FHO0nvniMH4Ko8Aot8IIHoy02cLhUe+zWtaROaHWeJ8rwFCughmWTJj2vsP/cwveoBRSvVqN9i/z793wapu5dwwy5T+HZH8RHaEeKFL5wyjwa5ii2gDR7laEwjXFsPdzRMWG9DE273n+WbZnWHjRflCbWkKblb6Q93FaKpR0ESvAC0075VI0/+GWDSzcm0AhmGx3Zua3QvhsJrssn1t0PtPo2DBpCAUk2ylpE1E38iw9SrpmhLmmcQ6CvhGBRHcnFypjLfIyYnh5iVzx23C+VuPQDqjR8bXqSFCBn8LiVJRgfXDBgTWNJtuVDCsnbWQgUQ3gABTyG0lUAX9MMtHXTcWxZawF5tSLDFaYGERb8hExhe0YxRRVn4raXvK4epcOL1ZLAaLBYWXm+OMJ1WxSW5kaV2kxVrCwUix1ZwTMNdK5sSwU207w6HW6re/Yll9xSWeCL2EbirZeJgYMTAwi6MG945EmfLk0IsxBkRV1JgnTo21n3ADVQfXSLAYEQSWxOe7gkhzpQ83EZoD3ewnMmHdWIMfFuMw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(8676002)(26005)(36756003)(66946007)(31696002)(6916009)(6486002)(83380400001)(31686004)(53546011)(86362001)(956004)(52116002)(66556008)(478600001)(786003)(8936002)(2906002)(16526019)(2616005)(66476007)(5660300002)(186003)(75432002)(316002)(16576012)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?NyA7dXb/uqGe1ERdBUMTe6XSjO0Um1GY9DH4YC45EQYvawXRoeR++DcV?=
 =?Windows-1252?Q?x0tvjQtqj3A84x3s38GkBGoXNdoObrRG/k2D+Yszwntkjqag1VlqyYnS?=
 =?Windows-1252?Q?ehKtqg7NKvuhI3tTpBBc1QFw2hIoPHzBTvQrvh4+YOgzokTCeZCgI3nR?=
 =?Windows-1252?Q?oaJiMYLxlxk4qhxoDuwa2ujcqO3Cxz49AodZt61jpB8GEyV1M/evoG1b?=
 =?Windows-1252?Q?+zEJ5y+SrmNjxMo3odhCP75oxQmkkcOsvsYR9HFJcjRHlm/El53D3Mvi?=
 =?Windows-1252?Q?ssTynBSUtjHFNyVf3+EnIJGDxRC5rW7rwG+eJFJj4u5KUAKkKlNICxVK?=
 =?Windows-1252?Q?iAkw0cL1S/TUgQW5FXvgdKDvODwZs80q9Eh3hIbuvI98MinPNQcrW8NU?=
 =?Windows-1252?Q?ycZh/EC6vF6+VbycNvBxiKUZDBglYKriooLw1dEBPG3i2dzHwWWLWAmz?=
 =?Windows-1252?Q?Q57zreAX4oqATPgKOHUKVKAYsuKXTHsbvQyiSXwPixTvXulJ6PDHi2MB?=
 =?Windows-1252?Q?dlZ8LPc7h4ZgfisSs2yyDOMkTQxQbMI7qdz4nzCjMcGkJTyOAL2FFfPn?=
 =?Windows-1252?Q?Wfe2fTkYiLG1uDetJfSpjVyF2ltbdyP6Fix2reneyhCZfTe/aPwI0pHD?=
 =?Windows-1252?Q?1M5khMrjvMiI5obmtF+KBn7qyovNcoEyHBxCkzeEm1f6U2G38DUReLZj?=
 =?Windows-1252?Q?Oa7dYV/K2QzCP1boYg/wRELQbfArM8xsN3zShimYWzLHFGsCdA21uvEC?=
 =?Windows-1252?Q?eQ0psi9sogPdIlC7gs3iERDAMASnGA2Jq8wpBhkcgwp1mQtSBDHx+qv4?=
 =?Windows-1252?Q?jQD20aLr5vHT5hubZVWfADPuv49JUxxHO68VxfI/vMABTLm1fCcaYL5/?=
 =?Windows-1252?Q?k1oW0UbV5C3Yja3PsXsUqd3XrVlUIhs6Y70mAJ6MbEf4yQ8xn9+3OE8q?=
 =?Windows-1252?Q?UsjO2TTWN/v4/uQmkBQctOkLWaLbzLGgEhBe9peFfviwjgnuFFu5FFXh?=
 =?Windows-1252?Q?MlMi9Dir1SOxJ0sMT5fnf9W5VqWgGk2FigpPSXuWIVNh8vw0WznOzbrt?=
 =?Windows-1252?Q?B5rBZXvfrnNmnySsBP9YSvyZ1eZajIFLGxol5S4X9iVbBYZuxiFYd+hL?=
 =?Windows-1252?Q?MU5TitGs7PR8Jbs/WxJOsHTT?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 60cedb97-e1bd-4495-c77a-08d8c2bd570a
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 12:16:14.1944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+69hbAEIlfee/AO81APfRNKDkfsVWUxvLcdqKN3QlxOR/hPGucn1Po4HT9VnkoAUVpj+PmPCQzVQCjsYd4gHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0900
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, MSGID_FROM_MTA_HEADER,
 NICE_REPLY_A, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Wed, 27 Jan 2021 12:16:18 -0000

On 1/26/2021 4:30 PM, Ken Brown via Cygwin-patches wrote:
> Allow fchmodat with the AT_SYMLINK_NOFOLLOW flag to succeed on
> non-symlinks.  Previously it always failed, as it does on Linux.  But
> POSIX permits it to succeed on non-symlinks even if it fails on
> symlinks.
> 
> The reason for following POSIX rather than Linux is to make gnulib
> report that fchmodat works on Cygwin.  This improves the efficiency of
> packages like GNU tar that use gnulib's fchmodat module.  Previously
> such packages would use a gnulib replacement for fchmodat on Cygwin.
> ---
>   winsup/cygwin/syscalls.cc | 20 +++++++++++++++-----
>   1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
> index 4cc8d07f5..0983cc76a 100644
> --- a/winsup/cygwin/syscalls.cc
> +++ b/winsup/cygwin/syscalls.cc
> @@ -4787,17 +4787,27 @@ fchmodat (int dirfd, const char *pathname, mode_t mode, int flags)
>     tmp_pathbuf tp;
>     __try
>       {
> -      if (flags)
> +      if (flags & ~AT_SYMLINK_NOFOLLOW)
>   	{
> -	  /* BSD has lchmod, but Linux does not.  POSIX says
> -	     AT_SYMLINK_NOFOLLOW is allowed to fail on symlinks; but Linux
> -	     blindly fails even for non-symlinks.  */
> -	  set_errno ((flags & ~AT_SYMLINK_NOFOLLOW) ? EINVAL : EOPNOTSUPP);
> +	  set_errno (EINVAL);
>   	  __leave;
>   	}
>         char *path = tp.c_get ();
>         if (gen_full_path_at (path, dirfd, pathname))
>   	__leave;
> +      if (flags)
> +	{
> +          /* BSD has lchmod, but Linux does not.  POSIX says
> +	     AT_SYMLINK_NOFOLLOW is allowed to fail on symlinks.
> +	     Linux blindly fails even for non-symlinks, but we allow
> +	     it to succeed. */
> +	  path_conv pc (path);
> +	  if (pc.issymlink ())
> +	    {
> +	      set_errno (EOPNOTSUPP);
> +	      __leave;
> +	    }
> +	}
>         return chmod (path, mode);
>       }
>     __except (EFAULT) {}

This is wrong.  Please ignore.  I'll send a revised patch.

Ken
