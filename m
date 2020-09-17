Return-Path: <kbrown@cornell.edu>
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2111.outbound.protection.outlook.com [40.107.93.111])
 by sourceware.org (Postfix) with ESMTPS id E5AF4393C843
 for <cygwin-patches@cygwin.com>; Thu, 17 Sep 2020 22:34:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E5AF4393C843
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oi9QvaaXkQXUrgIh5BKqHfF5dyDu5jYyXUVBB1+h0dSzi1qWQ5IW4e30kw9lJy54SWuOGJA8zyOHsSnFsFEe5yxTpgl4gYSwRSXZGTJt/nghcs+J1+h1TdvujBnJ3PP7WLQeNtN37zkSWBSezGzI9ER6vR+z9NgtEOH3QX72U0Ikop01S63gdNmU2aGazvFojeK1JwJZZmvR8pVPzUrndVrAGtsMGU7Zzvcegzhw8BqwFlivoW/7eTH9CmGOm4zHkdJfJempeZFwBEbi3iZVPr9m1V9YvxXJcjwF9mUvERilJMGTlncG+H97gbX5mr1JRycErArmtZzswpyQ2Qd+9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhxDJFUtvCuzzlFHMZ4XCZfFB5fLQtGw9zB9oAHAbOI=;
 b=FqM0hEix4YkgSUrvm3dPTdq9SIAhkGN6JspKLcij1kOBX/loCfX74/JDeTdticfgx05upwQVavpDn2AY6vXaeaKKPMeHDHiOg+rJOpMUL1SZE7UHUI493JWpuNivBU37vcSQID7I7aZDU8rTIe3jlkobbmIfuimsOicdLdY+DMEbOHuKgpyM8M71J/149Y40nQ2n/oCsjtN1IoxCWYJfztttcmnNMqZsD/ylTJqVIrilN0mlpBNt5HgeYqIV+3kMbaUu+h0ar2Hl3KSRNa6NGJllwjZsW2ODNGfG6cIp6RniUnHlXgoGRkEPkmFCLvDCJF0CnaW/2eHvGk07Gzs7Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5661.namprd04.prod.outlook.com (2603:10b6:208:a0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Thu, 17 Sep
 2020 22:34:17 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44%7]) with mapi id 15.20.3348.019; Thu, 17 Sep 2020
 22:34:17 +0000
Subject: Re: [PATCH] fhandler_proc.cc(format_proc_cpuinfo): add tsxldtrk,
 sev_es flags
To: cygwin-patches@cygwin.com
References: <20200917185125.6208-1-Brian.Inglis@SystematicSW.ab.ca>
From: Ken Brown <kbrown@cornell.edu>
Message-ID: <4c46b54d-e7d6-0e36-bc03-63b039decbe2@cornell.edu>
Date: Thu, 17 Sep 2020 18:34:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200917185125.6208-1-Brian.Inglis@SystematicSW.ab.ca>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR22CA0001.namprd22.prod.outlook.com
 (2603:10b6:208:238::6) To MN2PR04MB6176.namprd04.prod.outlook.com
 (2603:10b6:208:e3::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.17] (68.175.129.7) by
 MN2PR22CA0001.namprd22.prod.outlook.com (2603:10b6:208:238::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11 via Frontend Transport; Thu, 17 Sep 2020 22:34:16 +0000
X-Originating-IP: [68.175.129.7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afe2ccbd-187c-4e41-0ba5-08d85b59cfae
X-MS-TrafficTypeDiagnostic: MN2PR04MB5661:
X-Microsoft-Antispam-PRVS: <MN2PR04MB5661D1F3D15FC5FC31FD0F00D83E0@MN2PR04MB5661.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H5vHn0GwJsdhtMC1OvLIh2eS670Jne9IpqVcAjGUEdd2v7hAa1roiZJzuYZQhvYq9IUsWoil+V7uOSMjozGH+qgnLO2Zz9+eor361jlYYknCY8UgCzUAFHfS00iM6wp2gSWRw5xnpOldC168y4PZcgg40QCurr7BLty2hK6GxzQPiVsRa4Q3CXoq++YkbnCtWBNVoi31eVmVLyUeTPtPa9raWNnX5+FKvJxQWVe5efBbETxvAkvXXvDBy5KP4ze0RVR5Um6nYeIdl+cOKWIDEJ8B/o0BdVDvra33vPSDANiwCxvZouAiUJxkuW0oChOyMc8LGo/+WpyYzf4frCAVzEGNSPV4G63qbrb+v1ZIo9dOVj3x+1fhF/5BedWXbfpN9qdh7ZApe4x8amC3kx4OVzevgxmPMWK1xZXujkaINdYDR536aI5Stb7AWr/0hkUJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(26005)(66946007)(478600001)(2616005)(5660300002)(36756003)(53546011)(2906002)(52116002)(316002)(956004)(186003)(16526019)(6486002)(16576012)(786003)(8676002)(6916009)(66556008)(66476007)(8936002)(31696002)(75432002)(86362001)(31686004)(83380400001)(133343001)(121003001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: cj3127sSzuRrPWsxINj9yiGNKoZk6OmHxRJxy3TeT/YRSC5+RPxPzZannVp6X6FuRgwEGBDjle2w4cHtV8EalOvgNKusLa6OcuenEJbmjiJ6e5U5XrsSb7KrpLES26AjiEC1GQ+5e/bXgz68JRiOkQxmm1Q5JyiTCifc/XgMpSY2McCfJYXziZT8haAIMWjd0O+h+q8EMkUdES2N+SfrHVr5880aWbflFxFZnWgT6HwmyI1xZNcfPdOePvRM8VO3H3cGDG8nA474mcem3PAfZW4SyUVLCwajLQRHqonmjaF76ohdTEfivxkOTXViSyqvt95CyypBv9CjTO5n/STON3YHmD/3FVxZaXGbQMhKCrdQ1iJh0zE0YQhvlM2/GM3bFp5CFqVQhc+xI8vhAjkFfuNeGKTplJd9AmE0GK260ICYY/QMph7ioWKedbdkP/ZFljfbCD4q4Un9IJzzsTIjZ9bv5E8dEINNp3iWlLR2DGZQxxWj6Hj4TJAetxYoryeZzNRp4mgSdJNUbyrPNpC516BkyCB0HpbTBOJEsfiyJyQcI2Pm6fPgN2xyjKyORbieWtn9T8BMKUxk6udY2QtkL4BPv1X2xB5DfSApp4YO56t8+URg9U/+WG+OjyBiz7c79+faVsxX6WXUNVMRoPB89A==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: afe2ccbd-187c-4e41-0ba5-08d85b59cfae
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 22:34:16.9021 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z4X2Khbef3EB96cd+i3fR5Uu1+tXv3vn92sODVjzq+QwCqVOugu0+zdcWQ/y9XdluBFqICx1pdxi4uh1eLiteQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5661
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
X-List-Received-Date: Thu, 17 Sep 2020 22:34:19 -0000

On 9/17/2020 2:51 PM, Brian Inglis wrote:
> Add linux-next cpuinfo flags for Intel TSX suspend load address tracking
> instructions and AMD Secure Encrypted Virtualization with Encrypted State
> ---
>   winsup/cygwin/fhandler_proc.cc | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc.cc
> index 196bafd18993..6f6e8291a0ca 100644
> --- a/winsup/cygwin/fhandler_proc.cc
> +++ b/winsup/cygwin/fhandler_proc.cc
> @@ -1376,6 +1376,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
>   	  cpuid (&features2, &unused, &unused, &unused, 0x8000001f);
>   
>   	  ftcprint (features2,  1, "sev");	/* secure encrypted virt */
> +	/*ftcprint (features2,  3, "sev_es"); - print below */
>   	}
>         /* cpuid 0x80000008 ebx */
>         if (maxe >= 0x80000008)
> @@ -1400,6 +1401,12 @@ format_proc_cpuinfo (void *, char *&destbuf)
>   /*	  ftcprint (features1, 26, "ssb_no");	*//* ssb fixed in hardware */
>           }
>   
> +      /* cpuid 0x8000001f eax - set above */
> +      if (maxe >= 0x8000001f)
> +	{
> +	  ftcprint (features2,  3, "sev_es");	/* AMD SEV encrypted state */
> +	}
> +
>         /* cpuid 0x00000007 ebx */
>         if (maxf >= 0x00000007)
>   	{
> @@ -1579,6 +1586,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
>             ftcprint (features1,  8, "avx512_vp2intersect"); /* vec intcpt d/q */
>             ftcprint (features1, 10, "md_clear");            /* verw clear buf */
>             ftcprint (features1, 14, "serialize");           /* SERIALIZE instruction */
> +          ftcprint (features1, 16, "tsxldtrk");		   /* TSX Susp Ld Addr Track */
>             ftcprint (features1, 18, "pconfig");		   /* platform config */
>             ftcprint (features1, 19, "arch_lbr");		   /* last branch records */
>             ftcprint (features1, 28, "flush_l1d");	   /* flush l1d cache */

Pushed with a trivial change (added a period at the end of the commit message).

Thanks.

Ken
