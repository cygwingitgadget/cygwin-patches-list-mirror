Return-Path: <kbrown@cornell.edu>
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::700])
 by sourceware.org (Postfix) with ESMTPS id CF4C93857BA3
 for <cygwin-patches@cygwin.com>; Sun, 29 May 2022 21:26:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org CF4C93857BA3
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJcQAuLEvffolwCs31PvpDsmllOasaEox6bWM6lj3qXpShU6ILsXmWRh5miYXEHvI9X3ZkCzMadenkieeJK7XNRN0VOW5g1pyWva5claoEg8FEsNZJg9Ds7l0wBH469Jg1e3MN+RUHckY7T9X7lCVGYRiuZgyu85Gi+c3mCKUYP3lyx3W2v6NNTgHMbrFxe+3vIR2MhjXehFP51VT3zDFVAc3vSuV66wEN/QEDPTWxCWhNTUsTVEpUL0QnmEN1UD6xpkOsrQ7FKR5Pg5F/WCIFpux+3ehy0dr/41gYRBgZmXBlBDomifCiypW3r+YRxP7vOypF3eoelT9h5fa6TuhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQqZfdgL8upuXRncBoQD31ji+7jV43RdSjUht3wMiNo=;
 b=c/BDFyMb2ccThIAxzsUNNqAI5WInsZO8zFwGGCzXKbZJETwsjNEoYv8UEBKKpCkfAXWj7RmCMOQaj+zD4cePNWEAo3qJzfm/xFJhghdchsTMwgtcM9bq0o1Q3wwJh8ySuV1m6gvDammiyc5+ByOYsEbCf5/Qvpk4ef3JHEFx9StpXkWNjeA5Dvv8lNeXhuP4ct+qXONd3LbjJmfCFSAaPoe/kqqzcu95k5gNq7HqDJLMAGPtsECKvOU7Xja63PCYjks8Ehq1+4sQY72fz0DkPjg5rr+MPICVFp+1p7ZGPziFmOvgLzVwsjzsuwT10kD6sG5GaDnWIaRvgISFkTdZ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQqZfdgL8upuXRncBoQD31ji+7jV43RdSjUht3wMiNo=;
 b=MDM2HJq3D4oZca4YCelWDqlvaszm921DI6SobeOLYbP2HHmwvrG3Wc5Vo98Q7saA3CqwCjNDWTy8s17AKCLRyoIg2Q47kCUTPXHHnllv4ITWIpTKGCyvOORa4yrx3ItEYkEV2tweUT1RhCqEW94bSrcxZiu8LIOxHBOm/9Hho0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by DM6PR04MB5001.namprd04.prod.outlook.com (2603:10b6:5:fe::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Sun, 29 May
 2022 21:26:22 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::e48c:b440:3098:a050]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::e48c:b440:3098:a050%6]) with mapi id 15.20.5293.018; Sun, 29 May 2022
 21:26:22 +0000
Message-ID: <c5bec956-6e71-083e-f3bf-f6b52726b218@cornell.edu>
Date: Sun, 29 May 2022 17:26:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 7/7] Cygwin: remove miscellaneous 32-bit code
Content-Language: en-US
To: cygwin-patches@cygwin.com
References: <2de3539b-efc2-b6f1-b9e3-8429ecb24c0b@cornell.edu>
 <ce7de251-14d1-e54d-e2ef-5b67ad256a64@dronecode.org.uk>
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <ce7de251-14d1-e54d-e2ef-5b67ad256a64@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR20CA0062.namprd20.prod.outlook.com
 (2603:10b6:208:235::31) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5eeb389-6e70-4359-cfab-08da41b9e04f
X-MS-TrafficTypeDiagnostic: DM6PR04MB5001:EE_
X-Microsoft-Antispam-PRVS: <DM6PR04MB50019BF6649674C1D18AAA00D8DA9@DM6PR04MB5001.namprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vurAGzUWjTuS14Vpv2Ep6EcSwxXV+0UsP1qiUcWfDJPtSyyVEY3a2yGNJDKu2LIOVQsYyeGwmIjqmYE/7PI7agGWf3qc1Hz9izMVXbcy6uUmzpxQXYBO4H2vd53/WQRNR+WCfLwwN3n1V71Ki8HPSwRd4qjr1dzLIUXReaQDyReWqQymD0UysSZUeYQ9+qCzUSIesRE1DgVfGwKB8jL7Jpv9tcAwGiRJRPE3y8PalC06+qTqa7bmUxcMYssIMrf6kADss4Lthi3vYJyuay6aDYbn2VxA+DyDFQ/D2n98S+qlFiBm1jhnU5YQhNc2GYfaTwfAzfoGOo0he0g/+V0td4OzeERW2+CUT3vOnbACZOzNaIdn0zA8wVTCFIRXQjFIm2u/9BHx92si31sUQ5QoqbA/rZ7mSZzDWuDnXUQX0beohOkqQu//k+rx3IqKjZKGU+uNaM7vz1x+FpvX9zNXDfRIPcUMiXaczKCh+rVywIWvdFs8iohsAQynTs3lrKS0qOVGJZwnkUojjbCHxwP1xGz6P8zwFdf5aoNB71aNDTLXeE6LxHVtBSzot5skixQN2i1yiGBJC7ZkJD+K3Dityjko1M7RZpSAPRyoy1FJRJUf/Xl6VMozHbfgmbkzMk4d1kizSQBhJvXynPFyvtkrCh/zfzOOYnST17dXeSipeDZNOIbVHMLwVNLxA2A17gMuD/GEwZeOvA+UmuZhA0pyG6tO0Iwr1MJYClkV6BN7D5I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2616005)(8936002)(66476007)(66556008)(6916009)(2906002)(66946007)(8676002)(31696002)(316002)(786003)(4744005)(6506007)(86362001)(6512007)(36756003)(31686004)(75432002)(53546011)(5660300002)(6486002)(508600001)(6666004)(186003)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3ZUMUlDZWZTYUlJUFNUWXVzYW1CM2htMTNyKzEwUzdBRnQwRjhXZWRDaU9w?=
 =?utf-8?B?T0x0Nm14UE96aWJ5cGRBMEF6UmRtRkFncFB0SnlOSkhHTy9xS1JxeEJkdkM2?=
 =?utf-8?B?eEVXcFJvWTZJRnBld1diay9odVk1ZW5kS1JnK0VMaGVxYXpHY0ZWcklDUWV2?=
 =?utf-8?B?bjNpZzFjN0xpSU9yeXl5S2MxV1RqeTdOS2g3NXhFQlJ1S0F3Q0NIdmdNOGdj?=
 =?utf-8?B?b3pTcnRNVTZhZVp1VnY1NWszcWJkbFBXNTIzR1V5QWFRSHlPYVBPNExxcDhD?=
 =?utf-8?B?d0xSM3VOYk1Ga3Q0N2xicG9mSlFhM2Jod3dxNFNtbmY2a0cwODZMcTRmMzhB?=
 =?utf-8?B?bVM2VE9oQXpsZkw1aVhYUFVySTJvQjRXNmNNa2RiYmxnOHBKR25PcEVENEpy?=
 =?utf-8?B?alZLNzkrYTFRQmVjR3RWMm5jZ2I0ejg1Q0c0Mit4cy9CRFhCMjBNVjVPWklW?=
 =?utf-8?B?MlJQSXNPc1RLeEt1cVhkZFpGRUdDQTdDaThBamJmejAxZEVsQUk4dU9KdVEr?=
 =?utf-8?B?Zm5KdldnSURHT2x0Qkl1Skl2bXkyU3ErMEJsb1BNMFBHekw2RUlrdnhuRzly?=
 =?utf-8?B?MlV6WDYrM0pRYk43dVlRUElvMEpQR1lMUENrcVFuNHBwejMwVUl2elhUaS9O?=
 =?utf-8?B?aHlreG1OLzNFSElMbnI5QXlOdnBqS0NqR1FsSlhFSDBzeHpXZ09ZZFY1c0pS?=
 =?utf-8?B?SUo0V0xybnhlcm1SY2dUY2Nab3F4blFuTFdrWUJkWWxBWENEaTF2WkJNYnpT?=
 =?utf-8?B?ekdFNVY3VVpaVFVISTduMGJYOTZSczdVdDVCblU3NjZpTUVsaUlHOStiaHIw?=
 =?utf-8?B?ZzJJWllmQjIra0FZMENUTDZIVmt2YnkrN2dkV3FIQnhiMjlVblRWL0NYc3FB?=
 =?utf-8?B?bStjSDd5R3drOEp5eW1VOW1QN3dJWXFUZEt4cDBpT0tJUmJyWnJpYUZpQ2dH?=
 =?utf-8?B?S0kxZHRQNjlMZ0hQdTY3bWpJazJJS0ozSDVPTk40enVKZ1lYUm9CVFQrTG5S?=
 =?utf-8?B?UDJqTmFJRDFOcDlmMU9SQmZ4SU5EWE93L3B5RHN0NzdQd1NvcVlxd1FOUjZ0?=
 =?utf-8?B?RHV4OVFwdXJ3bktuSysvTWdqWUVEcnN1RXlpdjF1UGh6WnJTS05STnRjOU5i?=
 =?utf-8?B?ZWxRRVVpMkRUbGloWTZnd1I3c2Z4RC96L0MyMVdoemNOa1JnUUtJaVpKSXkw?=
 =?utf-8?B?Nnp1dG5xckhVTjltcS9Hd2MvNFBXOXVlMWJkellPV1B6SDUrRFJ0anh1a29t?=
 =?utf-8?B?cEJXcGJsWWJEa2s0K1JqNzdhM1VWRjFBemZVb2R3VmxWblh6ZkJsbTNOYjlS?=
 =?utf-8?B?eUM1VmNHN21HMjdVVXJmWThMTXd4bVVhUC92bkMzR0U3WG9qaEgzZHV2SUxr?=
 =?utf-8?B?eWU0SEFicXE1TmM4UkE3ckpaTGNJL3RBZGFZTGZyYi9yVmo5eGJOQjZ0VXhs?=
 =?utf-8?B?d0J4M1EyY09aZ3dVSnhLUnRUT3BzMmlFcnkvMnlsS0pER0tROHZMOU9CUXNh?=
 =?utf-8?B?Q2xrem80eHpaRG8wMjJoTFp2eFFCNG1kbUpHSDFMdUE2TUtDQ3loTnNpSS8w?=
 =?utf-8?B?ZHYyNlhJYjNnWXpzTUJLVHpHT3FDTzhidERkVmR6ZHhsank5UUpnZlo2RElR?=
 =?utf-8?B?ekRDVFIwdnh2NVlNNFl4U0RHd0I4WEFCbDAyRk5QK0pXM2k3STBYV1I5RnBH?=
 =?utf-8?B?REJ3UXh4QWJ5MFpMRXB5THliMjFaSHc2dWlxSkdUcmNlakNiUEFVa2t6eXg4?=
 =?utf-8?B?d1hha29lakVWd2l3N3pQNlY2WkN2U3dFQzdJcGV6Qk9qUi9zQ09UZENtNmJh?=
 =?utf-8?B?VjBCSkpjTW90bGpWK1JMZ0QzeFpVMWdHWFdGd0FpV1RFSFpOblRLd3kxMzBJ?=
 =?utf-8?B?elpwNlpCTE03YjR5aUtwb2NManB2YVduVUI2MlA2bUxSNGpYc0hLYnIwOWxV?=
 =?utf-8?B?N0NRNVFvTFYrNWczTUNRZy9zeDdPVDZNaG4rTEVmSTZrNklwUVlrbjArUTlv?=
 =?utf-8?B?S3lXVUdzcEt5UVZtbEFVcDkwRnhsZFBtdVVnU1JKSVU0ZzlZMDZVUnBWeEQ1?=
 =?utf-8?B?aXVrdXZJV2JwUnZ5S1hmWkttcVpPQllmYUVtUS9CNmZRM0Y2OEF3WGR3SVpM?=
 =?utf-8?B?SkdxUHB2Y2ZhTERFVCtkV2YyWmMrZkg2c3VUVDRVc0FHNE1qelc1SXBraTJz?=
 =?utf-8?B?UjZoQ0RpZVRNMGJhQVc5VzcxM01VQVNkMjVRWllzRWpGaHMwQjd2SWxuS3ZH?=
 =?utf-8?B?bUkvdTBnUmxibjJSQnVRTHEyQXpVWHIzQVdBenBCY3RpQXVnMEVKaWxPb0Jr?=
 =?utf-8?B?aVp2VmUrRUl6TmxkL2gydXFOTHVQQzFHQllyT3ZvR0RqZFplM2t2Q0xNOWxt?=
 =?utf-8?Q?/YeonZF7U20UEMtJwfHz7TfOsguwo1oXiWYflKtyr+Gel?=
X-MS-Exchange-AntiSpam-MessageData-1: S8NXJa4psBSpxQ==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: c5eeb389-6e70-4359-cfab-08da41b9e04f
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2022 21:26:21.6615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vivRT05o1YQywdKysD9FBzZCnqVldnNxOwmhfEoWfMknX1WtIpnE9vlQiheQzsnvTIccMPmagyaoGTw8mpzULA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5001
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00, BODY_8BITS,
 DKIM_SIGNED, DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, JMQ_SPF_NEUTRAL,
 NICE_REPLY_A, SPF_HELO_PASS, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Sun, 29 May 2022 21:26:28 -0000

On 5/29/2022 9:39 AM, Jon Turney wrote:
> On 26/05/2022 20:17, Ken Brown wrote:
>>   winsup/cygwin/autoload.cc                | 136 -----------------------
> 
> Looks good.
> 
> I think that perhaps the stdcall decoration number n is unused on x86_64, so can 
> be removed also in a followup?

Thanks, I missed that.

Also, I guess most or all of the uses of __stdcall and __cdecl can be removed 
from the code.

Ken
