Return-Path: <kbrown@cornell.edu>
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::71c])
 by sourceware.org (Postfix) with ESMTPS id 5F0B93856DF1
 for <cygwin-patches@cygwin.com>; Sat, 28 May 2022 15:23:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 5F0B93856DF1
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCZlr4KK48QDJqRPuyGs6HqO8PtrcjNwdiYExnCx3m0sXwvE7sjKQa5MyujdlEnGsrC1yvPb2362N/2FSjZoilSeWDNbGPrkq8gfKdQJYxunpXlHOA1rqc+xyrV+1GF4l5gzxabQ4V8SK2AlZh+xVw9Y2jmvPl26VmL78rtvCeJfeX2cbTu6wiKrz/wr8y/UEAIdmAwC9aLp8IoAurUUIJ8D9IJ8RVIEqN09stBCiO6ijByIXLl+lP7ATZkdYVHCTmHbnINvxF3lNXMPzq0t9OtK7f8Hlsc7jSwVMtog8JCGM01IZ0dX/jr6w3VJZOGu2USr3WtHJucPCjFT47habg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXCoU8oFv1NNxU3xu06uwIlrO/mgkd1aHNl4LfXBJwE=;
 b=JlHtjZLenfMegliyKp0des9u1BZyYTRB5MyvKSQdnOEK1mecOE33VdhGds/cDSeuboXmqMtp22x9AUjqNcdHWcgmohlumiZl+soOub6xXeRrGxau1DeZeLSYLe4ek9jImzZ0MDNvAFw0fwzmei63ei2SF5BmJeBmlyjCNKz01Cl9x2/dJHqHHsciaIYhm6fd0KhlGkwK3seOOAYktvKneMdg2SJ+io4+bi/WkLYyIp0p02EEy/TLSVxnetSMraGRGueMiHzhGcfHhFDCrsUoHoqlQNBiacIqn7Hbiop6YeaoAhTHHSoDAIEE1NhEOq/FZQmUFAua9+nuzm0shCo5Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXCoU8oFv1NNxU3xu06uwIlrO/mgkd1aHNl4LfXBJwE=;
 b=dbybU312u1zJ9Vsnd19fyliIry/6F3bCqKxMcAp1MLvaHfLYbuz2vRz6KHMNHbP00sSoCzyXlkJltPs8MsXBjXdBssFte7t6Jq8XdOmoYMLTaNbpmP6IKW9nfrzivk7pdSDiFCxQhs8K8Ex/ypYEft4/e3hbPPLaq0X/jsaXJ8g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from SN6PR04MB4399.namprd04.prod.outlook.com (2603:10b6:805:30::12)
 by BN7PR04MB5396.namprd04.prod.outlook.com (2603:10b6:408:3b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Sat, 28 May
 2022 15:23:18 +0000
Received: from SN6PR04MB4399.namprd04.prod.outlook.com
 ([fe80::a84e:4133:db83:1ce4]) by SN6PR04MB4399.namprd04.prod.outlook.com
 ([fe80::a84e:4133:db83:1ce4%6]) with mapi id 15.20.5293.016; Sat, 28 May 2022
 15:23:17 +0000
Message-ID: <6e88d941-fbc9-b0e7-1052-9cab1e3181e4@cornell.edu>
Date: Sat, 28 May 2022 11:23:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] Cygwin: cygheap: Fix the issue of cygwin1.dll in the root
 directory.
Content-Language: en-US
To: cygwin-patches@cygwin.com
References: <20220528142045.8402-1-takashi.yano@nifty.ne.jp>
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <20220528142045.8402-1-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0341.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::16) To SN6PR04MB4399.namprd04.prod.outlook.com
 (2603:10b6:805:30::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f66e075c-476f-419d-9ead-08da40bdfdc6
X-MS-TrafficTypeDiagnostic: BN7PR04MB5396:EE_
X-Microsoft-Antispam-PRVS: <BN7PR04MB539614815E8AB9CBA846432DD8DB9@BN7PR04MB5396.namprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MKjztOs9OSSJL3H8z1HXGanCqWQtiF9ysxtDjEvmQkiJDl3pgPDBA2sd880r3gFl09Ile8cOUv6567vcUWBDHrejrJDLmUktai3xwsgJf4kEX4IweThLsoEhV3Iv1StzkDRY1PVk2jAPaFTzK91zWI+ataNkgBlur/RwqUngM5jGmLCx3fye1VaWlWa4bAy41xLp3rqNNpoSAJxAEbgJugNbGzFn/z8n3OIobqpy1S1WdhB9Z5Jgwi7S+545Tn8RR0q43nshqjMLctSwsqd1qW2vaeSb7vVouWzCUGpFtT7Rp8ReSRzV3oCigsjwa6XFsdj3NZTbP1lYdvrl5rP5qpshIh1gVQROLrli8ALIc1LSYjDtZKlw3P3g6gCzsqtifDJTVbZKRLvLK5VM0lFbhAYqMMnYRHNrhqtGWSJORSDJwPZRk+Hp//JDQtiKLk3QFeoU9h7bHtVvBaCezMnwTTEF+MiXFHFeTcsatUmULcixa7E2v1V/pG6Q5bFdG4x0C56903zu7i259WBYDv+KmBs2mtzE1Zosdgp9YY3MtzkFZ0PLpLqhKq63QR14Rao3OAId6kMswqhBBWpimo0fvlQvKuhZUOO8KU598bm28YtRhWa1HzvZLtqwyJnUl0xLlyRBPAyYZVSXi3+c1NBv+cevSO+a1a4Ud9AZLsNjKd5pE6jyir9gpkD50nTi4i9NVabLJ+KDFv6stXdTeH8W8nq+e06AdLqZxbt/3kIWOgvEu+8wYmZ35vnuagYb6GBA5nnbYfe8szev0fjH8ryALdLtQaKduPTG9pq43l2IRISUWmbvx9TJCtJRX/Kgru4J
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR04MB4399.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4744005)(36756003)(5660300002)(8936002)(6512007)(2616005)(6916009)(186003)(6506007)(31686004)(53546011)(508600001)(2906002)(38100700002)(31696002)(786003)(8676002)(66556008)(66946007)(86362001)(66476007)(75432002)(316002)(966005)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWZXUVBmVHVKa0xQeUZNRzFiK251YWpxSHhPUkxHZWlrVklmZWlFTUFTRytM?=
 =?utf-8?B?WVpqSllITHV5alBnOGNLOGFMMSsyNkg3RE5kVUlYZlo0YlhJRlVrNk9HcVpt?=
 =?utf-8?B?WW5iY0krZW1FWDBTZzhCTkVzeEErS3g2dTRxUy9HZkpLMkc2Ujg4VEhyeWNh?=
 =?utf-8?B?VnRRVUdIRWh1L0loMzgzYnd0aWZ6MmNBSFZUWm1oUVIwOWRtaVUydU9JQ0NQ?=
 =?utf-8?B?MmhxUXQ4dDhib3pjK216b1RxYncvR3A0UUFwVDF4bEVlcHN3d1hHeXhZcWpY?=
 =?utf-8?B?Z0xPdmc3VGFRa1V2VW53cTF6L1liRlBoeUd3RzhpSER4MUhQY1gvN2IyK2hp?=
 =?utf-8?B?RXlXaEQwVERZUlhOY05hWm9sMklWM3Z3aWhkOG50NS9OVGJqWjdFYVFITWNh?=
 =?utf-8?B?enFBVzlGNXJnWHNQZDBaTE9pWFpRT29LQ3ppNTVBa2VUVlRTaFhPZDBycnJX?=
 =?utf-8?B?aUlXQWhRQjRYSml6OFpIYTNvQ1pJeFZnTE5CeTMxTlR0LzVHTjBYSGZVSU9r?=
 =?utf-8?B?Q2tYbDdXUlVUUkFnRFJ0S0UzL3ZmZmd5ZThlMmlKTWdFQWQ0U3Uzb21TNDJY?=
 =?utf-8?B?dHMxamVnTUovOTRFdlZDa2xGOW1GeWNVc0doek9kMkZYaEt4cGdHei9OZ05G?=
 =?utf-8?B?RHcrdmwxSnBOL3YwaElURUplSGR6ZXN2VXRMdUFLNUEzejFZNzdTR2RnWnFC?=
 =?utf-8?B?aThsSHBaZTVycnMwWCt6T1NiN092ZGZDdndDeTNqakVESGJJUXJRUVZIR3RL?=
 =?utf-8?B?a2RzRE1sWEhDRE0zNGNxSXczOEZNTFhnZkFSaTJzRTQ0NG1aRnBqK0lPU0xa?=
 =?utf-8?B?ejdyRFJtc2Q2TFYwaGJ0M2N5Qkp2TVliT0grSnpwR2xNWm02WWZUTVVQdnpC?=
 =?utf-8?B?UXhEcWtOOTRGQytlR1Y3cS92TjkyVDYzQStDQmxLSzIxMWFxVzFaNC9uZjhl?=
 =?utf-8?B?SzIzOVBDMVJsUGxMWlpncHUrZGtDNVJjeU9aSmt3VkJ4bEI3WGVjaXRkSnZG?=
 =?utf-8?B?Y0ZVV3E3MXJMRGVpTHc0WUhTQXc2dGticHhvT0p6ZnJpMnAvQzROZmk4TC9o?=
 =?utf-8?B?S3F2dnpRbDZ1bHM5eGpKcVMvRGJRNTNHaW80SVlWY0NiaHBmMHhtQmVEUTZx?=
 =?utf-8?B?V1hMSmUwa3owRnFsTVJibjA0UER2OCtRRkpMTjhpbUJnMWRTOTJvRm5MVWp4?=
 =?utf-8?B?RktEUmhzVjdjcEt6MVB1YkNlRW1LczNHaGFIeWhqQkRIMWNqekZMeGRoL2xJ?=
 =?utf-8?B?bTBPbk5LUGIvcDVLUGV2MzBLTkJ1TzAxYVFWdG5vTHoxQ0JZWlROUC80dTlC?=
 =?utf-8?B?b1FJazJGYmN3Q2pFd2RDOVNmUzlIOHRnOXRLcE5JbmZHWWduUFBGZEhBaHJR?=
 =?utf-8?B?YnZkOVFhOTJNQnBzSmFPa1BpeDZEUS9JcjFpbUM3anRnZnFTU291RjJmcXdZ?=
 =?utf-8?B?VlMvMGNwemxGZGJic3d3NVRxcmdHRzdGblA2Q1A1R203dkVqV25TWWhWeXRz?=
 =?utf-8?B?VWVzNnRjL0k4amMzWUU3NjNaZlhRZXltTHoyZ2tnektOZE14WkJpazMvVkgz?=
 =?utf-8?B?MXAyZzBvdXhmTWs2Q2VlMGhRZFBSTnk1REdob1NrSitaVXVtTm9QYzNXRi9T?=
 =?utf-8?B?RWRCMnI4VnQzUUVhTEcrVlBYMEpCZkQwb3R4WExqVjFyUXIxRHJmWmtLdzdF?=
 =?utf-8?B?YnFuL05USTFuMlo2VVpyWTdEc21idlFGRTBRL1l4ZjY4aG1IYlJ6LzJ2SFBj?=
 =?utf-8?B?NkhNL21NTHBNdWVyYTcrSENqMWRESzVGVDhZK2hUSmk2b2psdURsQ0dMVVJi?=
 =?utf-8?B?OE83TGdZSjFhWiszYzRYSHdVNk9GcGIwR0pJZWh1alZsYzlZd0F0dE5PcXFK?=
 =?utf-8?B?R1drRHVMaHhKc2dzU0ZXM3B2YVAxcU1OYUY2TkJMV2FXakQ0Z3dscWhjWWN2?=
 =?utf-8?B?TDJsZVdPcm1OMVlOdmx5S0pGZHg5U3ZzRlpPMlZnOUZYVFhjcFdJeTRiL2l4?=
 =?utf-8?B?M1dKWDZUUTcxdU5GY3lTVGVkcThjcnEwZnJ1QjFiTENwaGgxWlI3T0ZYNWFu?=
 =?utf-8?B?aDlTMkovL0V4OWNUelE1Mms0Sjlid1phc3Qyb2ZHbFN3UHh4UWFudXUrQXU5?=
 =?utf-8?B?NHpIdmV4YzNrWENGOG5vTHRTd3V6QXVMbnJ0aWhUNzZXclpBK0xocCt5amNS?=
 =?utf-8?B?MnVKbGsrbHIzLy9OVG16VEtpN3pEckxBUkFxTjhvVXFxV3lMc3FWTW1VSlVy?=
 =?utf-8?B?aUU5MHBWR2NWbDRTZTNSL25NK3drUVpEMHJZam5pYmdyZlVudm9taHRwUm9W?=
 =?utf-8?B?OUdVSTltQ2lvaVpqSnZSd0ZiekZYcmRsZFJDNThDeWxGY0ZRUXhMWDk2UTdP?=
 =?utf-8?Q?kwzLvt8f7Fj6iKUckXQX3CwQz1hJqet3D4ho0jKZbCbwm?=
X-MS-Exchange-AntiSpam-MessageData-1: zLNkIOXlCjdp+g==
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: f66e075c-476f-419d-9ead-08da40bdfdc6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4399.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2022 15:23:17.9026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FBuQ+W/BJM6ocbrCIV6EbjA0CBd/dFdVO2vpfKLUALTvcmwX7wTyK1biLtj7xdwDdGxCP7eLuSUPxSyTzNjl0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB5396
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, JMQ_SPF_NEUTRAL,
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
X-List-Received-Date: Sat, 28 May 2022 15:23:22 -0000

On 5/28/2022 10:20 AM, Takashi Yano wrote:
> - After the commit 6d898f43, cygwin fails to start if cygwin1.dll
>    is placed in the root directory. This patch fixes the issue.
> Addresses: https://cygwin.com/pipermail/cygwin/2022-May/251548.html
> ---
>   winsup/cygwin/cygheap.cc | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/winsup/cygwin/cygheap.cc b/winsup/cygwin/cygheap.cc
> index 01b49468e..1a817b743 100644
> --- a/winsup/cygwin/cygheap.cc
> +++ b/winsup/cygwin/cygheap.cc
> @@ -183,6 +183,11 @@ init_cygheap::init_installation_root ()
>   	  if (p)
>   	    p = wcschr (p + 1, L'\\');  /* Skip share name */
>   	}
> +      else /* Long path prefix followed by drive letter path */
> +	{
> +	  len = 4;
> +	  p += 4;
> +	}
>       }
>     installation_root_buf[1] = L'?';
>     RtlInitEmptyUnicodeString (&installation_key, installation_key_buf,

LGTM.

Ken
