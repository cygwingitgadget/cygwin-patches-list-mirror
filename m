Return-Path: <kbrown@cornell.edu>
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by sourceware.org (Postfix) with ESMTPS id 0C8E73858292
 for <cygwin-patches@cygwin.com>; Mon,  4 Jul 2022 23:05:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 0C8E73858292
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nijLHy7147OFe4HqCoORJJia7283v5ZfAeGxa3444OCN3j+VtUD1WPZNIVme6lBKlDHRteSiD1OmXsY1BTasZkUYl7KIIjo0Mu0IAHRDwNRDioRDrwWwTsF1an04PNPP3Hbq8LQ1lGXZ/P1HwRDmdWjmSHPlbrGiIumQaVqHySSegAjTBGvvrQj21MpkQGY0GkyS+IVEFn737OctlLw6jSn5g9xOesEhnMFWbbpl+O6VKEWqT3DisGyKi2D/8bSnK2NjrmsLa+pRZfm9tqpy9jZawU3uWjJvQaybAeBgBtj8E8Zz59Az7mvvv1IVYORgtjmiDgtc+2sjD4H2l84/og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbXT3BoxX7x9Gpi1Ba6mWTKfYBexIs52a9HiMsugMLQ=;
 b=JAqQbFWWToMaR/iETJ9rtK+SCvNTJBXBOB9DIWAuzGAAocnKX4vdAoqrPTiVwcmO7C452T+VMvaPapL4RYTQgzgdZVPsmDWOZJbnd50dImQosuR59QOl+qgmjcRrxPzboHRhoC+Ar+BAYxB5bDgXY7a6tUgdKEWOhVXAkpaGTArmXGl7wDPfj3rgMQ71/n1ETVaF9o8XPb/wTcTypxJLmboIs+K1SPd5svqNmyk2Jgpsn3AtJj0MPgai+XU2Zic9pcw1NoqkPYCe53EhDGq8FxE7htQ+CbdUc1hFOtW65YRW2+6VU8djth7xojjTtybs4/bZnFRWzsuM1x0ujJI8Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbXT3BoxX7x9Gpi1Ba6mWTKfYBexIs52a9HiMsugMLQ=;
 b=OXc4EdMM6bQYviM6pINWBf0h262sFkCA/yEQhLhF/fne6jVCgem9fr/a4jiU9HqR9KZtG04hkWFEE+ZULukCjE0WzppeXSJbczdf4Oe4iZY/Ly0GbMeAobLMZOSHQfGkgsf0fShVuwLPSWNUHmByC8rAXEuvqKaCvhZHrLG5nWE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by SJ0PR04MB7296.namprd04.prod.outlook.com (2603:10b6:a03:295::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Mon, 4 Jul
 2022 23:05:22 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::901f:a758:30f5:309d]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::901f:a758:30f5:309d%2]) with mapi id 15.20.5395.021; Mon, 4 Jul 2022
 23:05:22 +0000
Message-ID: <4ba56b80-8faa-de1b-f3c4-f64106797106@cornell.edu>
Date: Mon, 4 Jul 2022 19:05:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] Cygwin: spawn: Treat empty path as the current directory.
Content-Language: en-US
To: cygwin-patches@cygwin.com
References: <20220627124427.184-1-takashi.yano@nifty.ne.jp>
 <c4a8d150-4d16-2af5-a7ac-26e42f9befb8@cornell.edu>
 <376762b9-6ef2-4415-b3e6-fbc9be48f183@cornell.edu>
 <20220702083107.8aa64b1046484ab41911d8dc@nifty.ne.jp>
 <ab1226ff-1236-67a0-a140-0f6826fd1778@cornell.edu>
 <YsKm4GDa5Zi3VHjK@calimero.vinschen.de>
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <YsKm4GDa5Zi3VHjK@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:208:2d::49) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b915c19-f33b-48a9-7052-08da5e11ac41
X-MS-TrafficTypeDiagnostic: SJ0PR04MB7296:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2CrouWPe0HICki/84UOdGdIoTdcjwl2yGCBDOUbtCvAGAHyhTzH93mA7A/YuwJt681sNse2kQTxIPICxZStEgs3rvznANYA9oTZpttn5hVi1mEGHzbPx7x0Z6Z78IY9h36p2XGhA4wl0iWqW4hDVeWNU/e4ZMgY9dbN4Dvl+dxik/zpxc+9e6lxalDPIYjwJAR4sGPnV69MZGiBdI7BMy7VbuoXRmUKB1zcEFk4fYD0tiRAUAnIhf5vVv3of8uI4YxC8bBvTKr8Q5vJDriR3v3vJna9lEdtR+2zuJxT1zeeStsUQfRJeS9K1zh8rdEgikt3qWycEfpAgGKZGdqV0uwm9zi79lfFfSqdwcWZkm68uSbH9w0dSMnwH9ZFhlpnO2NOyotKv/GK00ykVI0ghlg3XGuazVNsWYeXVwJReD2KKq9U3mGSi+cK3pH4PVVm6X7HNI3uvI4YpGB1VGSdAn27omTZ0sJz6WiTDwdcQ0885TPZpzhHIVnvg29TffTFbEPdItyj/OlY26tKo9oXcHoZVhqhDn0V4QRFex/k1ha/6kJpsFCyShjNl3Nn4nbRRPAHOqQYMWJgupTYFBPctkEaLXzCp77ly0YQB0xx7DXidxa3nOhWJYeKt7lahjWi8FMMj7LFTXtGybu6piOSljws9oWakDuL7JjKqcWSRyUy+EdI1MpAifVpalHG9gMyXKoLoMUFyHW0/P3fbiyABhfeUvAdHtjrSNhBNXz3b/YwOrMx9I/8GuaBXS4TaDh0YRCcPPbN8yT+DD+FaMA04evM/uDx4UKd0gbKwqnYVy7/kVYf4P7tt4gTIbf0HzjRVlHJBSozFQNqM6fAycCthTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(186003)(31686004)(6916009)(66946007)(66556008)(66476007)(8676002)(6512007)(53546011)(2616005)(36756003)(6506007)(86362001)(31696002)(75432002)(38100700002)(478600001)(6486002)(41300700001)(2906002)(6666004)(316002)(4744005)(786003)(8936002)(41320700001)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aERUeGlpYmNtM0NQWDBjNTZ0SE1hS21USXR5ZHZMMkdvRUtHTVFDMXFBODlG?=
 =?utf-8?B?VXVyaU5aS3ZGTGpQM2xwcGlQaWFIbVFCVzloK3MwaitaS04xdlI4QkxmaXRa?=
 =?utf-8?B?cDR4d1Uxb0ZONEEzaHB0aTdhVGozclBpb2dxcElGZWpTeVRrcnV6bDB1aklC?=
 =?utf-8?B?THpCd2pJdEtDL1h1Zm5yOUdTYnNOVUdCOXZXeDhRclpMbW4yTWJaQ3hmTFU4?=
 =?utf-8?B?WFVCTVBRd2ZqNTNoNHNNcnVmL1BMZjRwUmN4Um1HN0FBSTlrOEtZMDMrNjQz?=
 =?utf-8?B?eXR2NjJRUHcrK2JCRnR1VXk4dlBSQ2syb3k4Q1lncDlvVUt5a2Z0a2VJdFM3?=
 =?utf-8?B?R0JSM0hDelpmekdacUZaeUxjN1FRUWFkMFpsVHljOFA5UXp3YnhPN3VDTWVT?=
 =?utf-8?B?SGNoUFBvS0xoUmZvNDl1NFpVMkh3Tm50Vk5ob1k2YWdScUlJM0grMSsvNXFP?=
 =?utf-8?B?cXRTU1FMNXJEQU5MWWo4OCtmSFRyVzRjazVNNEt2aGJ6bVZwUzRlWTVHbVVS?=
 =?utf-8?B?eWVBWHlySWYrRHdzc2hpaGRVc2NOMG9Jb2hUMkVqeXE4VjFUcXVxYzVmVzBP?=
 =?utf-8?B?ZUloM2dCUHBrZmVmYWFJMGxKU0FhY2ZpeUNGM1VUMmVGK3RHSkZKWG9YVXha?=
 =?utf-8?B?Z3g3eUhrVUw2YnpvL1VoVjB6OXgrVEg0enBHOVFGMXEvRjgvdG5LU3pxbjBF?=
 =?utf-8?B?ZG5RT1dON0VoQmNaMGJvQXNRR0dCVXFOL21kZ2NMSW1JcEV0Mm43V0VxcCtK?=
 =?utf-8?B?RDlNdGMyanorMjQ3bllDdkRMMTBQNEhtU2VVeXF3WFNiQU1NUTkrZWJPS29X?=
 =?utf-8?B?RHRlVjdYRlpwanJESlVQZmZ4YlZSS3kvQUNBNlA2ZlBOV0JWUVlpL1Vodkcw?=
 =?utf-8?B?UGE1OTRDd1hUT3lnYW9WQm9CY09uSnVwZjdFNzVwb3cxNGRkWUhiR21UQUkw?=
 =?utf-8?B?ZmE3YXNlZmJ3MFFXcWhaVnFqZUhFU1Q3bXNRS0NlZk1mUVcycmVuZkxIVEhO?=
 =?utf-8?B?ZUx5d3Axd3U4THpNSVd2SitRYURjZTFSVHhHVEw5dFIya29XSTJNQW05cFF0?=
 =?utf-8?B?WnZpSnU3N0czUGtqU2Z4Z2ZBVjMzdnlMVjVraHdCMk9USUtIemJSdHpBd250?=
 =?utf-8?B?S3owVEo5K3QzcWN5UGVOSXgvajU5WEd5Y0Fmd3hyS0Vla1lpakZMekdxRCtP?=
 =?utf-8?B?eUNaZFppWW9yb3U1d0RmUW9tY2xnU3dRSkVJRUY0clRha1JPWWlwNDArdUp1?=
 =?utf-8?B?RTl1d0ZhSlIxNGVObiszSEVkb0k0NHppZlJ6M2l6eWJ3dmRWTjYwODc2SldV?=
 =?utf-8?B?djgxcFl6N1F6NjV5SDMwM2szWUxjZGxBSW9QSkRCRktuZU8zbjVWYncrVEZu?=
 =?utf-8?B?MC9ER0p4TFBxeWVRZVk3azhNVHppeXZ6TmtuOUgvcmtXRno2cGdlRTJqTE9D?=
 =?utf-8?B?S3RPdzVvS3VPejhqeW04ZzVUOVd5VVJxQWhybTB5L1Fod2N6QTRhakFXdzZ2?=
 =?utf-8?B?Q3UwcWxlZ1MrR3U1b0pDdnA5S2pLaUo2dEdCQm9aOUZpTEJlaE9yVXBmbzE4?=
 =?utf-8?B?b0ZLTTc3K2FPT0VaeE1VZjBkVHlsdmZlWDlkK2hzdVJWK0szV1c5KzlkT2RV?=
 =?utf-8?B?TlVQcjkvLzdqZkcrQ2lSc3AzbzdFeFpQV1BsdkIzbjhDQjJwZ29QbjlFbXlp?=
 =?utf-8?B?SXVOdm11Z1BpZ3NuanNiT0tkTVVaYmNieHlGdVF5aURvZVdlOTBBbElBakJM?=
 =?utf-8?B?SFpnTFl5Z00yWnpuL0dZRWpZZjVDNjM0MERHOFZaWlNYZ0U3cThQUG5BSXVv?=
 =?utf-8?B?OWtnUHlnSmxyNldVMHQrUjJzUDhoRTVKZWRwaFVPazVFTG5MSXZUTmI3T2My?=
 =?utf-8?B?TldqZS9KNXFONHQ4TTQ4OWN1VXBGSXZuR01BSjh5ci9OQjR5czdZV1BFaGpH?=
 =?utf-8?B?emFERHRucysxSEJXVXY2SXc4SThXSDJTbDRIeEtwTGh3KythZ0tzM1RpUDZB?=
 =?utf-8?B?VWRDWHdpUEtMVE4xOWZoMnVxWXY2RmlBMXAxdGdya091bk44bVczTGhvSzBa?=
 =?utf-8?B?WFVTOGM1dVYwZWJiR1VlYmFjcSt3VC84S1ZudTVwZGc5TnVOTkUyR3lPdFZ6?=
 =?utf-8?B?b3NESVNXdjZFeUo2ek9Eb1ZCNkpQaG9vemxuaGlzV2lVS2xGeEFQY1R3TWNE?=
 =?utf-8?Q?+x9+VWas951UJixemXDf7/cbE21Mt+47QzK1Wfr4UAdS?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b915c19-f33b-48a9-7052-08da5e11ac41
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 23:05:22.5802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cDpxaMbkxh5Dk6BcvqATE6bd5P0yDsOOQaj9ZKV7WwgU6p7YrMBTEO4Tb3Bw3v3Esh824X0TArjUA/lfSX6uTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7296
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, JMQ_SPF_NEUTRAL, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
X-List-Received-Date: Mon, 04 Jul 2022 23:05:27 -0000

On 7/4/2022 4:37 AM, Corinna Vinschen wrote:
> On Jul  1 21:32, Ken Brown wrote:
>> I interpreted the existing comment as meaning that a decision was already
>> made at some point to align with Linux.  But it can't hurt to wait for
>> Corinna to weigh in.
> 
> Personally I don't like this old crufty feature and I would rather keep
> this POSIX compatible, but in fact it was meant to work as on Linux, so,
> please go ahead, Takashi.
> 
> However, maybe this should go into the master branch only? WDYT?

I think so.  The bug has been around for a long time, and the code is tricky. 
So we probably shouldn't take a chance on de-stabilizing the 3.3 branch.

Ken
