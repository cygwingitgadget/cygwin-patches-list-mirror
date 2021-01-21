Return-Path: <kbrown@cornell.edu>
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2112.outbound.protection.outlook.com [40.107.244.112])
 by sourceware.org (Postfix) with ESMTPS id 10381384A40A
 for <cygwin-patches@cygwin.com>; Thu, 21 Jan 2021 22:48:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 10381384A40A
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFNE3rYTRjbh4BNcgXWVAvz7R0ORwgE6fpKhQA6OAftv5DEhAFz/AFJYtntG784a2qly+/MtNtEnTGX5dYIr7QF/T7lYBS4DzL/qsaNOm6LuyDb1Rl8hU8UnXPqsZRV827WyT1X3FNjFXIO9o6/H0yIKtHJ7L0xUobDGVhiQ2E+tY9FwWHPv2Z3qW/BVrFd7yWcxM8ME9q8iDKF361k2OfpkA2TpZzQvNCVfPy0R5iqIMMS4sTD+NqJy+UsWCcj1n4TkDTJugrI8esA0gVd6mV2zjMNvFgz8tKIdZ7ZhZwNQyFZTRpR9VeIv7mr698fsPRuMRbXgNNA5tnEJ8kq2HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nsS144cSp/ohFRPtucYzLmPFeliyJRN/a62KUUUT5c=;
 b=Hg53JZiYZRm3Rla4yhdj37N+4KWoe0R57U+V3y/bq81h5QhUbO3Xo9SBcCu+XJWI+GBEzMIlDp2ngUw3ozzCld7TDDQsKKsBa9Ew5x0LJckpXMTGLUQ/Dvw8HRVAtm6hwiL4pne4BcRRoScnof++biPUND41Aa7esOd/hnQpYFLd+MNkXqZyyiGi940TKntIFsUIG4n7o85iw+gr+Thq4selhwFMH4a8yQvytO1G9cYeJZnqUuOqTOVnMCpJgIYbehB5kRV9YfWb9yn/+Sv3xkbV4SUx8GIk9yrbJ4+V9wBwxO63x1w0MAxzneBfB1t8mtv2k2WXmv5qJUN4y1Eibg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN7PR04MB3954.namprd04.prod.outlook.com (2603:10b6:406:be::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Thu, 21 Jan
 2021 22:48:57 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::f071:e174:ef12:375c%6]) with mapi id 15.20.3784.013; Thu, 21 Jan 2021
 22:48:57 +0000
Subject: Re: [PATCH] Cygwin: ptsname_r: always return an error number on
 failure
To: cygwin-patches@cygwin.com
References: <20210120180003.1458-1-kbrown@cornell.edu>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <b7ae5752-cfce-0be8-92b5-81515d5a57d0@cornell.edu>
Date: Thu, 21 Jan 2021 17:48:54 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20210120180003.1458-1-kbrown@cornell.edu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [65.112.130.200]
X-ClientProxiedBy: BN9PR03CA0772.namprd03.prod.outlook.com
 (2603:10b6:408:13a::27) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.13.22.4] (65.112.130.200) by
 BN9PR03CA0772.namprd03.prod.outlook.com (2603:10b6:408:13a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend
 Transport; Thu, 21 Jan 2021 22:48:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b396390-b91c-4a16-2a78-08d8be5ebc6e
X-MS-TrafficTypeDiagnostic: BN7PR04MB3954:
X-Microsoft-Antispam-PRVS: <BN7PR04MB3954AA45EA5C765AE50C16B0D8A19@BN7PR04MB3954.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: COePfsBIq80dF2oWc6geamlreWTUO1ICaWuTEQ+5JRNVyMugCjgVf2JMKcFNnPOCGSChpMKNNITtwue+c+UuJM1bbRu1VWTJloiG7fifVEJhtwz8Tp68pw8XVLtscALzzp1IpyzeNvzOCICJ8XCV3iH5ZZgNnXolV5bNNBJrKo1i1q6wbUStkME0XNWvvA7Wjuhiqp4fpD2c3yUye+dn2H57aZsodlTBXxST9AQblA7+uCZBNzMoPjvu9qN/vE4a1a7aFCB50QfOR2D66BW04TmsJZFrwBPPo9WQpoha5uKFzRkmS9BBwSaK12TDXkfG8ONlVHWy9R9yJlAkxYEUJW+CE/zntprHHJZwfXsg2b79QzpL5m5y2N+Mz5Nus1Ea7Un++juo2DiGzQPlC3znmlUSey+ZRMJQp4gT6euKg71GVkxfMWtSl5PvSVOS7/Y+G8voaNPmwYw3ZWs6mld/8QBBmrGAOEMeCrmosxh6R9AEG1oa25KGZFOeqimjcsCfcse/ix9jpHNLEK/f8Gf90rr9C2ZYNmFt7zOKurXOysCiQUh1cuRGrOvgI91DkIGmQlT+qkHqZub0FFOdtO3jhDWVd7Tlix2A46QT2A5pur1QqI362oOSoiLjy7E2pE1hhANmYRPsVMVuEFetTjEc65bR4/ZlQyt3ESFT7+WLFzwimfF0WcdDSOjHUcG/OP/S
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(6486002)(8676002)(786003)(26005)(53546011)(16576012)(31696002)(316002)(75432002)(86362001)(31686004)(478600001)(2906002)(66476007)(5660300002)(52116002)(83380400001)(8936002)(6916009)(66946007)(956004)(2616005)(36756003)(966005)(16526019)(66556008)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?MH0NVhYFtdbuOsbfQBDY3PrQzrwPVBRbg/ysqpRGIShOd32rEqqof9tg?=
 =?Windows-1252?Q?tOT6vCynbuaDjSlENeduBIETv2UVDPlOargtED7ZArWOD/aHlmtbLr+s?=
 =?Windows-1252?Q?4sRUfb6+IXVugzzWGTeWAnz25bTkEsC1m2WnYvBiBYsZs1tOZQw/zr6y?=
 =?Windows-1252?Q?xWoB5wB3LnzanID0EiHG7S4+YXd5AMnXlFWig+XQgHxOSYFc5tq+mr3N?=
 =?Windows-1252?Q?8AnUNH8cbltktENWz76f/UNEZHkKh+m4O3neLLwWKmS71DdbKUxoluZF?=
 =?Windows-1252?Q?rRsq3gubwAdja1JDR6V6Ra3bhIHPHS1zld+dL9dd2pkfoPzZj6DJ7FlJ?=
 =?Windows-1252?Q?BsfEtZm2mTDio7YMRt05igeXsjKURcumsslmmAvmSxar/oh0H5mnG8b5?=
 =?Windows-1252?Q?YWx1PyK2tzDgRoAaFpb1C5hd92V3c2SIi7wbFXARCGqGz8lXibjj1Bb5?=
 =?Windows-1252?Q?n4cfi3nMCuvRhyajLA5eEqcWr5wIKE3hGuW3zVnrHbwZ5sqDsBoyKHkh?=
 =?Windows-1252?Q?hxtHlZOtBoJfUJd60vlz0f1pyvi5JVVbx9EaQ8MM75gwQlqew6PnHpwP?=
 =?Windows-1252?Q?XDCc6idCLHw49+nT32VybB2lxGlFVLVDySZOBxeo7MB+ABinZrO8Uzb9?=
 =?Windows-1252?Q?4fP2OdixczYbi69Gu6RzhakMQFqxLZf6D+0ytJeqXRhpW9uBNEkzLty9?=
 =?Windows-1252?Q?KZ1NHTB5cIxQ/EU4AYfxmSqdXtdToEpRw/yzRO+SJSr8f7rbkJ/z0jHk?=
 =?Windows-1252?Q?SyLehtFckjSCzUs8PWtKWHqoWFU90YukMU1mUjtWyoroWIjXm/aKv+9K?=
 =?Windows-1252?Q?1w6hHB5sXXSfaDtY7WowIRKMED0jzI8DlvyL/7KqQpyTXM462iagDV4P?=
 =?Windows-1252?Q?HpqONsH2yy8clr3/8Jz2VeL7gjZ+6fDfxclWsbAXPNxHvXhmWG5U60xX?=
 =?Windows-1252?Q?QJUwExdtMfOupqPRDHtbesiskPqVq4R+9JAL+RRQCYrZIIb59QhtOHtA?=
 =?Windows-1252?Q?59xERoYRufirZFUDBfGsy7lfCQA16h+RNmDSdVo4J3sZA2CvHbUDlybD?=
 =?Windows-1252?Q?5ag8ScIRdAtt05Wa?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b396390-b91c-4a16-2a78-08d8be5ebc6e
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 22:48:57.2403 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5lRo7hRmzS0x/ZXW0QX24FRcTJwZhhltOLAL0YRu/3rF5hq/d06nbmG6eTPiePa7/60c2KpjDAY8LLLWCCbVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB3954
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, KAM_SHORT,
 MSGID_FROM_MTA_HEADER, NICE_REPLY_A, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2,
 SPF_HELO_PASS, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Thu, 21 Jan 2021 22:49:02 -0000

On 1/20/2021 1:00 PM, Ken Brown via Cygwin-patches wrote:
> Following Linux, return ENOTTY on a bad file descriptor and also set
> errno to ENOTTY.
> 
> Previously 0 was returned and errno was set to EBADF.  Returning 0
> violates the requirement in
> https://man7.org/linux/man-pages/man3/ptsname_r.3.html that an error
> number should be returned on failure.  (That man page doesn't specify
> setting errno.)
> 
> Addresses: https://lists.gnu.org/archive/html/bug-gnulib/2021-01/msg00245.html
> ---
>   winsup/cygwin/release/3.2.0 | 3 +++
>   winsup/cygwin/syscalls.cc   | 5 ++++-
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/release/3.2.0 b/winsup/cygwin/release/3.2.0
> index 43725cec2..f748a9bc8 100644
> --- a/winsup/cygwin/release/3.2.0
> +++ b/winsup/cygwin/release/3.2.0
> @@ -52,3 +52,6 @@ Bug Fixes
>   - Fix the errno when a path contains .. and the prefix exists but is
>     not a directory.
>     Addresses: https://lists.gnu.org/archive/html/bug-gnulib/2021-01/msg00214.html
> +
> +- Fix the return value when ptsname_r(3) is called with a bad file descriptor
> +  Addresses: https://lists.gnu.org/archive/html/bug-gnulib/2021-01/msg00245.html
> diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
> index 4742c6653..18d9e3f88 100644
> --- a/winsup/cygwin/syscalls.cc
> +++ b/winsup/cygwin/syscalls.cc
> @@ -3364,7 +3364,10 @@ ptsname_r (int fd, char *buf, size_t buflen)
>   
>     cygheap_fdget cfd (fd);
>     if (cfd < 0)
> -    return 0;
> +    {
> +      set_errno (ENOTTY);
> +      return ENOTTY;
> +    }
>     return cfd->ptsname_r (buf, buflen);
>   }
>   
> 

I'm not really convinced we should blindly follow Linux here, when EBADF would 
seem to make more sense.  See

   https://lists.gnu.org/archive/html/bug-gnulib/2021-01/msg00264.html

Corinna, what's your preference?

Ken
