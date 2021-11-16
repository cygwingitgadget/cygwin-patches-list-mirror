Return-Path: <kbrown@cornell.edu>
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on20712.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::712])
 by sourceware.org (Postfix) with ESMTPS id 2322A385781A
 for <cygwin-patches@cygwin.com>; Tue, 16 Nov 2021 20:28:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 2322A385781A
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnSd5A/8mGyAUlEDCQOP+egg2q9ptYxfzXPquGT8QMYqwtA5cDCdzbeQxOFzSQ3wjTjr4LzaHc12mFbI8c0ORY2O3iyxL58PkOIK6I81XwWyd8cMKPnEI+m46WGBuJKS/Z7ssJWJHbVQebweKlhiwej41GeADDjLIhCDW9Y9XKB4hwEpCg5j8AYR+NZZL0QSrmZqdcV2XV9xq49n++nmt7GJd+lGO4vsjnk1Seuan/gpJswMd1myXCjXKgjERps1CI95g9WRMBaoJf4g7d5ejmzTWSPVzHgAskYqRo9MZxHRnhc29ZfoqhMlWNPgfuv8HTqCCHNx2u59B8EwA07rQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPbYv00ASRQB9BCUg+9DTYIa5Q27roCf+kPOn7pYiV8=;
 b=QSeju/i4TyfU+pe1GuO4b4mpLNzBHrxSiPl03CtezXPEXM+o4yYeiwe4KHOZLTKclMEsaZw/GI95m/nWrFwtL6JpoiFydqiLVrEjVUy3SKM9H1cUbM9dpiHYn40VxpgBqUaY56iZ2b8euDC9DPiiqj3oKFF2VIthtaUw849jZFESsfprNnHm7ufTgKM5jqnNWVl6oMw1bBBRXejnGCDR0ZYhbFxpVT3JICp2Yw88C7k2CbNI5UfzYsQaC7+yQq+i+bCyZ3KUQN0dQ194eQ9qN9755SSvsOX+tMkIc8858NZ1Ks37Ty0/x1+l07IdKrCR5CdINDKl/K49baJsxrtVvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPbYv00ASRQB9BCUg+9DTYIa5Q27roCf+kPOn7pYiV8=;
 b=hgsxyDxiyZ0MxBM4KF8m+4L+JitMMMnfzhf6FDCfjXMOjFRNGQYfYr04ykAz4ka08JvJ3XbdUELcOSHc21VU1rd6y4+o1EkLIASlmTSEFQmeF0t42wSmfA/AWKb8cDYTIFDk2BkDvsiUz2LpqijWqslbh/rg3u5g/zFf/GSCuJs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN7PR04MB5170.namprd04.prod.outlook.com (2603:10b6:408:8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.25; Tue, 16 Nov
 2021 20:28:05 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::88c4:79c5:1eb1:b969]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::88c4:79c5:1eb1:b969%7]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 20:28:05 +0000
Message-ID: <15fefdbd-8b35-21a5-a4af-fa98e6e47cf6@cornell.edu>
Date: Tue, 16 Nov 2021 15:28:03 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v3] Cygwin: pipe: Handle STATUS_PENDING even for
 nonblocking mode.
Content-Language: en-US
To: cygwin-patches@cygwin.com
References: <20211116143328.1160-1-takashi.yano@nifty.ne.jp>
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <20211116143328.1160-1-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR07CA0003.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::13) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
Received: from [IPV6:2603:7081:7e3f:3419:1c5d:e1a9:7b:59ab]
 (2603:7081:7e3f:3419:1c5d:e1a9:7b:59ab) by
 MN2PR07CA0003.namprd07.prod.outlook.com (2603:10b6:208:1a0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27 via Frontend
 Transport; Tue, 16 Nov 2021 20:28:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d76a9054-fe18-4fc9-41df-08d9a93f981e
X-MS-TrafficTypeDiagnostic: BN7PR04MB5170:
X-Microsoft-Antispam-PRVS: <BN7PR04MB5170E3B237A6D8BD8287BACFD8999@BN7PR04MB5170.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:165;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vByglNwlRGAv02FN75p66wxq1F5ENxmGf+PnFMqegcC6cpUMvdKGpJa1krwBkJcAXEYJcvy2FftBG0eNTRN0hEXC4cCY9QA9vxRAlQk1kMyIe0GJ0qFzR/vwnkwUJZkilIkFU4nCvQOHJQccADIGKADWoBFCuXLaQCuulSoPRa5RrEcEvij3kd5iaymbwZ1PEg62dQkb0stv5CPtOnLwdEcHLUR8YgVHh3UZzAMmTulmv57gwQ3SyVMYBGwlsK7hyMZpuFZZTj2JZgtjKhBsH4K9ZRPqO+AjiYrcWG5wS1LULG65GPAUsXqweTSoHJ0rNh7WuWGMb1j6sZTKlOTpRn9qOJJccYrEdh1K4wX+e5WeJddUyjIDY6+WfPyJMHJ6knK3obud+7uInDoF9b3Uuq9+mSgLq3nZLuLFFP6Hzee+CoNZtbdbqb8t1eaBUha1zNlP8LEbsFHW6SNxIdr/lMLzvi8FyRUPHOCD67yVHQksQEONo0OEaeMNIYR8+vn3tHQmjFJFBgfYuusUEDkI0zaio4CST65uvcFDtrvGcH+009qNi5lvm0mV+XhhqQ/enKh6yJiqgIeUh+1ZpYIDudomVaQFnvvDPrWe84BwGKuyrgmbpckmVqQk5t9VmZWLRlQ6OMB4bCaZaFjryHuBxAheWYgdyxNpXXFnSCbrr8jv2dknQwRA079H0HU30yAarcm3lFDBETw0TuPreBBtPr37Qoq4OIxH0ZEfH0sOn2U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(6916009)(6486002)(83380400001)(53546011)(4744005)(38100700002)(5660300002)(36756003)(66556008)(2906002)(66476007)(786003)(316002)(66946007)(8676002)(186003)(86362001)(31696002)(508600001)(2616005)(31686004)(75432002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHo4aSs1S1RVcDd0Y3dhUER3N05JclFQbFZlaWVhUDg2ajBBaWJBZEZONFlY?=
 =?utf-8?B?YVpla09iUkVIRnRtZEsrVnB2NFZacXR4dkZUMzNOa0RCTkwyQTFuY0lJK2J0?=
 =?utf-8?B?K0VkRDdPRXByVzUvQjZVZjJZYlVKNFNNYWxHclNkdGpQZjJTSEV5UzdKVEhX?=
 =?utf-8?B?bXNndGdheUVXcURxaEtGQjdnYTRtZ3JwV0kxL1pxR2QxTXlhMkVOQmlIUnZB?=
 =?utf-8?B?K3VIQUUyVzBhdUlHYjR0MG5tNTZDZk8rRW1GZWxxSW45c2cra1ZoV1Fqb3ZX?=
 =?utf-8?B?UjhoTStFckdDL1UzdFlvcDhHZ3VvMUN5d0syQnpqVnZ4VlFzOEdYV3ZPdStT?=
 =?utf-8?B?YXNHZWo1QzRWdXB1TUROUTlCdm11WE1tNVUxY0o1cml0bldQYmdNZUNqQ05p?=
 =?utf-8?B?WUFqSktpWjd3UnRTQXlkakUvdGFJZEVpZUc0NEF0bXJ3d1JOZGxQb0FJanRH?=
 =?utf-8?B?NlEwU202RjlFZGF4andjRWVDKzFIVHpSOEt0ZUtlemRTU2c4UXFLbTI2VWZ3?=
 =?utf-8?B?b3dUV2JQZzEzaStGZlJSYnNNRU1BMGtsRFBsQURmVHM3UnRaZ3VoYmpyTWd2?=
 =?utf-8?B?UGxLSUZpTDNpcXVJNmcyQ3RtZjZSZG9zS3gwam9FVWNOTzZxMkU3Q1VGNkNC?=
 =?utf-8?B?OU1XaUhDemEwV3B4c1VkeXErZXJhRzlqbnJjOUkxcmZYWjkxaCtNNndTMHVa?=
 =?utf-8?B?eHR6WjM5MWtvd2pQSEJqV3FTZ0Q5Z3FsaGJKNUlNM0UrNDE4dnlXWUVFWWhG?=
 =?utf-8?B?UUFhOERRUy93M1lmOGl0VndHOVdCRjhtWlRQUFloczZveExFOGxRK0JHVmR0?=
 =?utf-8?B?SnlRVU9xbnBNMnY4bWJhUmE0b0xpMXRMSm1kZVA4OTd2QU83MlE2U0J3ZTZ6?=
 =?utf-8?B?ODd1SlF1RVZ5aHM4Z3JHNnIzbUtpcDV6ZUE3YzFTdnh4eWlmeklpTFBpTWcr?=
 =?utf-8?B?bnVZL09PQ0JyNTFleTlUM2hwdEd1djRvZjhHUVZ2NVZud2FpYnl2dmNQTkVK?=
 =?utf-8?B?Tnh2d1ppOUVLYVFwUU9OU0FCTFNYOVpwaHBjYnI0THl5blp5M0RlQjFnVytz?=
 =?utf-8?B?ZmJFTXJVelFrdWR3M2lCUTliSVF6MGVXbWIzNTc2OTluemNHUGVFaWZlTTVW?=
 =?utf-8?B?a1BCWVgzWEYxM3MyTTcyRXBFdnVteURDTTN2WFRheHBSSWpSMnBVVGhEcjlk?=
 =?utf-8?B?UFFWdUNWWFBCQlJFeVltcGRpSkVVMHNNWVgwcDM5b3ZxWlMvL3ZPWmZnTHlN?=
 =?utf-8?B?UHJtZVFKcmF2Sjg5Q2RmeUhVRXpxbjBhYzFBNmZpUUgvMW9KcFlOMnlhYWF3?=
 =?utf-8?B?UmRWZTJPdXlWaW1XY1ViY01CUnJOSDRNRk5RUS92Z0psVG5LR1RLMXplTmJo?=
 =?utf-8?B?S3hXS2R1WlRCQjMzZ05DU1FXZmRQR1kxM3pCaE1WZzVneTBxbjhDVFpQclBX?=
 =?utf-8?B?Y0xKUER4V3NTelBFV3Rlb2puYVRWVkdSWDFqTXpYM1ZCdWdqZkZ5K1pvbTd0?=
 =?utf-8?B?K2pBWlhrMWtiOWtDTjZvSGJPUzlPN0JEdlRMSm4yd3VUS2JpWUloWmZ5Qmpj?=
 =?utf-8?B?dzdzQThuYVNsU1BSYlNPdjRaSERmTUsxSFFJOFFYanY2Szh4SlBmcmFRN1Js?=
 =?utf-8?B?Rkp5SlhRLy8zVzhJZm5hOTZuRWtuRzBqOFJpUFdIYWpCRU1sOXI4SW1tdXpR?=
 =?utf-8?B?T3ByS0VPaWZ0WmlnaTNuajV4N1k4VHVNb1MydjZGeXJwUFZydXJQcEhwNklo?=
 =?utf-8?B?T0FVbzhIdW9XWlB6MHVmWWl5SDJOeDYwQnlpbzRxZTRzV0xiMUJHMXAzTERF?=
 =?utf-8?B?bDlvaHZGUWVYWE11TmhiZGV2UnM3RGhJZG9tZ2hacmE4QzRHclZTaFFnK2hJ?=
 =?utf-8?B?RWVpNG83bzVnSFNRS3BnK1F3N2xkdGJqS1Y4ZjQzS1hpWEVBQVZjR1lRdDNK?=
 =?utf-8?B?T05VMlVsQURHcFN0WnAzcGpxY3FmRG1jay8wZ3JjYlVqQUYraTdjN01uRC9s?=
 =?utf-8?B?L2V2akw5blNNWGx6TFpPUkk2UXRpT2ExTVZ1UENQTmZhbjVVR2VsREJSMnds?=
 =?utf-8?B?WWkrc2ZXTFdmdDkyRSt1NDJTcHU4N2Q2N00yZWZCSEVUMU5vdHhZTmU5bkZE?=
 =?utf-8?B?QkE2U3ZpUlhzSk94Zys4QUVpTWJUT0VEbmtHdUQwdjl6Z2I4ZXFTUDB2eThO?=
 =?utf-8?B?VU1ENlRIaENUZ3UvRG1JUnJobTJVYVR4bkpvRkxDalVJWWp0blZPTjlzM0VY?=
 =?utf-8?Q?MorZcsMY7oE+fahtEcTmZJKXlSXHj7ud/wgbqTgpWY=3D?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: d76a9054-fe18-4fc9-41df-08d9a93f981e
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 20:28:05.1118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fCBysp6XMICpJabMCiwyUInG70NiMPDC4XA83yOMUSlBf4k0uU4Tui0zARFOhw3P1+EfOEzLi3uAnEosjZxJGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB5170
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, MSGID_FROM_MTA_HEADER, NICE_REPLY_A,
 SPF_HELO_PASS, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Tue, 16 Nov 2021 20:28:12 -0000

On 11/16/2021 9:33 AM, Takashi Yano wrote:
> - NtReadFile() and NtWriteFile() seems to return STATUS_PENDING
>    occasionally even in nonblocking mode. This patch adds handling
>    for STATUS_PENDING in nonblocking mode.

I haven't tested (I assume you have), but LGTM except for two typos below.

> +- Fix issue that pipe read()/write() occationally returns a garnage
                                        occasionally           garbage

Ken
