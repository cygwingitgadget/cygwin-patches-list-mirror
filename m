Return-Path: <kbrown@cornell.edu>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2103.outbound.protection.outlook.com [40.107.96.103])
 by sourceware.org (Postfix) with ESMTPS id CF17C3858D35
 for <cygwin-patches@cygwin.com>; Fri, 24 Dec 2021 00:06:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org CF17C3858D35
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQZriq26lAbxwuiPJ7jN9q0enNdjtOvUhgSdR0O7U6ybiAhJC/rI1l28ieHIjADUxQ6YDUmOv3jw0Nt9NQ9vaLfS2l3IsAidebdRvCCzF2FVighLZYpMSCOSKOeWqGT4VYRLLgHyB/Hmcc3IdY9jHN4Gh5Vok47jg21sHiuE5l2k+MC+f58CJFxQ6uZMb8Xxpxy0P0u04RBAF7PIsaMSyaMXAao/OyFtApLovC2w5RtB7+2JASwCgk0Cr9422oiFVM06V34iQBckCGqWP66B3LH90CihBBoOcEtuAQOkvuE0zc7xsgJaAJ3lnUeYCvcHtKTq+r9vfyxWZiv1AI1JSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+q//QGyqsvNNmcOtEFf/8+e9DIo+7rNjUZ12KsokPo=;
 b=dkHgF0OWsUef1Oka2jG+jJTbEY42gDwpS3wzwXNGaHa/4qzRydeNiZHQ3De7FVtbJnqsvCPZGK6Km3YL8b8wbwKtJbyDMPF6nUGg9ZgH+/4s1r82JropF1sTRvcoHUd7gufgMlb8itvi/gz+/9HDppjB7ODP6fzY6v/Q+7MFgbCHiK4j1kFkP80hLwkOJ01MBV1NhMrNChrfhrfMhSOVqGN75KDox5MMX8pBJt7U31HU+mwwJr+MGkIauter56curHaIzJgphycdocKx+g5ZDgtkLas11GmcYIS9k3NzNtpN/GcFMeHskgjSrJYe8ongKfmWtYtCbgB43iabZDfREw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+q//QGyqsvNNmcOtEFf/8+e9DIo+7rNjUZ12KsokPo=;
 b=IJJJ3ORn/OFzfQL+e8DeshDvVxOE2SuJ8KO5yj5HR45R43zWXxvXpvZNB0J06V7DRylXHRf3treWi5nP939n3Vz4TbQeinuZ/ck/Bvu8wmrIiNtxiidQdeCYAbAnM7cF7Vlmpi25sqZvHQFSvPRkhSG3gpGerCy1AZvMyoal/Bo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN8PR04MB6372.namprd04.prod.outlook.com (2603:10b6:408:dd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Fri, 24 Dec
 2021 00:06:58 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::e53a:dc46:9edd:9142]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::e53a:dc46:9edd:9142%6]) with mapi id 15.20.4823.019; Fri, 24 Dec 2021
 00:06:58 +0000
Message-ID: <f97bba17-16ab-d7be-01f6-1c057fb5f1a5@cornell.edu>
Date: Thu, 23 Dec 2021 19:06:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] fhandler_pipe: add sanity limit to handle loops
Content-Language: en-US
To: cygwin-patches@cygwin.com
References: <alpine.BSO.2.21.2112231503400.11760@resin.csoft.net>
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <alpine.BSO.2.21.2112231503400.11760@resin.csoft.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR19CA0032.namprd19.prod.outlook.com
 (2603:10b6:208:178::45) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea22bacc-def5-4754-8e14-08d9c6714d2f
X-MS-TrafficTypeDiagnostic: BN8PR04MB6372:EE_
X-Microsoft-Antispam-PRVS: <BN8PR04MB6372A9621754CE41AC2B62C8D87F9@BN8PR04MB6372.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ArCAuGJhXQXZLlrskAARCiBP7YBAdoTaeKqCwlZ1jbfJOtvGIkW2QJh7n9/9b4l1obflo+H0q1bkEojcai00VvHZB1cwwFj5nodrW+bkmq0ueBGVH+YvrfvD3Jf2Tqn58xi4lMQCSgUhbluZFzPIZYR3x2CVSJ5YiPmuCQzpznuVQgrgmpeW4SAnVxQzpvk9Fj93tk+Jx1UL7i5dTGniGkLnxt9nwfxQPhVNUwZIxf9YdjMKh2sS0OxPVBmPDc4GB7flnu7zsq+PqVfyvt1qvmnvgT0AXe21wwt91gDKI+fjJTLrmkYPKmUjoP16BPRrlGS/aVCDHxjWxSYpQJKpMn/arorPg20FQJlTr+tUpwf+7SAYbM0ILltTMjcfD4JNja1R78VLDu8R8oAFALUk/4IlWZUaLhZn34rinZV1rqyf+C+BqpyTZ8ppwCkid/yCRKUs/Q9N1WbP4rTrry0DlofNc+ajmptMajc3h9+wtJikKhYFbVZSHH16z1Fhfr+GgMYJNjoSJfD62Viu6vJH7SmUttWjp9ifAPLz2nJOAyVqyyj2gNTbK4oADDC7p6QH1h2X0qYGzqLo9oRHIqnbovSg99Pbwjk/45dUEQMEPGNMcaQELE1w7MGOrS1X/QZuA6mO+TyvTWfT2Qz9vj7r5HFc4aSlsRg55n5ai2FHHDhgfEJvwe4kMmwytglj7kQe2PFR+RdxEdPQPnXsyu8p5KVzPQD73l29UfQsTbfDj5I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(31696002)(83380400001)(66946007)(38100700002)(8676002)(8936002)(6486002)(53546011)(6666004)(66556008)(66476007)(31686004)(6512007)(6506007)(186003)(2616005)(6916009)(36756003)(2906002)(5660300002)(75432002)(86362001)(316002)(786003)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkNCN0o3MVBBZU1PYWE5dUV0RjZ2OEhOc3VpTkVKcElxNWt2aEVqaFVTcSto?=
 =?utf-8?B?cmZpU09YOG8wbTNGOW02ZkxiVFhnTW52TlNvcWJqeUhpQmxYZWZJSFRLWkZK?=
 =?utf-8?B?aUI0eUxPNTBtWkt4QWNwZGNmd05paHpoYTJPV0tNSktOY2YwUlVjdUJYc21K?=
 =?utf-8?B?YXJzWWhlSmV0Ky9TNWk2WWZwdUp5QnM2dUpMekFnRnBaa3ZKdmZoK2N6aGF2?=
 =?utf-8?B?T2ttb28wTEJ0NnVqeFp1TmtZNFFsejUzakpkZWJaeE9ISHdQbWJXL0FRc21K?=
 =?utf-8?B?UVVxa1dSMnBjTHRtN3dMMEZoeStua05DdDNYU3NNSnRFM0swYm14YTlndWVU?=
 =?utf-8?B?N3RpQTZYUWdiNDdHUDVxOWZJYUU4TkRncjVkMUFnaEc5dGZ4NkdtQ0VWS2U0?=
 =?utf-8?B?R0FiNk9oRXhKYjg4cUlDSXdZUE1HdlViaU5zdlozUXpoVWJvZ0RyamVLa1dL?=
 =?utf-8?B?dERGQmJ0UklLcmxrNkVPd0FXNjFwbzgvaFhzQUhIQmZQUEg5MDFsaTd3NlZM?=
 =?utf-8?B?YlRBZ0VyUjI2UGNVUTBqcGVsSnBIWjM2djZDTFRZd1UwazZCWEEvNnpzOVFL?=
 =?utf-8?B?aDBNQWQ0UU15UGJIYnJjUFBTRC9zYnlZUS9QNGFWZERxNEs4VDd6cDN0OFkr?=
 =?utf-8?B?azZGa0U5ZWZNRmRsS0hRMUpRNWdyaEo3WmdxeWRVZzRHd0NNTkN3QUl1UVlL?=
 =?utf-8?B?UTlyQTdwZS9vTEZlQjFib2ViZ21vUEtMa2NoYTlocGsydWU0N3BJUDErL0V4?=
 =?utf-8?B?L3dtZDc1QzIrUU5mdWh6UU1CeHFlMDFJQW5MTG5kYWNYaEpKbWtFaTc5bW8y?=
 =?utf-8?B?VFczcDdWZXpDMWlVano2aHl6Y2cyTVJxRkw2R245UjBRSUd3V3VrWXlpZk0x?=
 =?utf-8?B?aElZT043RVVoM2diTW92aWpxU2prZnJMSFpRTzJDelE4OXhybFJmRWZQWWVj?=
 =?utf-8?B?Nk0xeThDc0RHM01USGV0RHRyTHBKTUI2d2NuN09xUjduc29Za3NEQ3hodGZP?=
 =?utf-8?B?aXZVMWVpWm9zb2EwRnVJQWdvZTJObzVKZnJiM0VIZlR3aXV3L0NtRUFLVnlX?=
 =?utf-8?B?YzRYM08veEJJTWVGWFJwSUpnSnU3Skp0cmZSNWd0eVE2T3BiNVp5WndsOE9Y?=
 =?utf-8?B?YVRaWU5zUVRDNDhOSDI2REFWd0V6WXdPcDVMQUorYm55Tit5MDRkc2VHTEVl?=
 =?utf-8?B?emdkMk9GRXB3TVorTnNHdEtISHc3RHBBL0JoaTVTN3JiSGhUZzQ2MWlZeUJ5?=
 =?utf-8?B?NXJvVTZmRU50WUpLRDJjbC92RDZkYmhMdXlxSjZyRXZ3NVRzODB3VXN5S012?=
 =?utf-8?B?QXFOWDEzRHd4SlFSMXZncjBGZEo4RXBXTVgvTldFTmhKR2lSZzMxYlo2OUdM?=
 =?utf-8?B?Z3JQVUhpSi9VTjdrU1diTk1LSjIwRUYwekJwdFZFSUVEdnJpZW0yZlNGYzI5?=
 =?utf-8?B?dDZRYzBnejU2MWVKSzBtem1SUmZSQkg1ZUVabDZlU3EzT1dwUXRidmZMcmNv?=
 =?utf-8?B?a1gyN25WRHJLejN3OXZmbnNLd2thaHBjZTE4VVZ6MXFhZHRwa2ZBVEQ2emNy?=
 =?utf-8?B?S1hRb3JmRlcweEFtSlVJV2FneGhMcVpmRGpGYjd0ZHFadjVEdXpyTFlUZCt0?=
 =?utf-8?B?Nk5CUEdzakIxa0RZZFBTaU9QSGxzajlMOFB0M1RHSkN3djFMc3hVMVdkRWJ5?=
 =?utf-8?B?bTFkSGk4NDI3bTU0amc0V3M2R0ZERjBCdzYyS0lEbXE5L3Q0dDdJd2hIcmxU?=
 =?utf-8?B?cjZzWDAvblpxOFNzQWxuMFMreENKVXloQmM2YXZMb2duMUZMdlpkU2Z4Z3Rs?=
 =?utf-8?B?dFJzVzJGODhxYUN2dVNtUHU4QjVZUGhZZWhUSkd1eHN6WUMwWmZsN2E3T1Jr?=
 =?utf-8?B?L1MxdmZkK0poL2hOOUZ1ZGk5WmEvNkNLTUFOUzFiL1RKY3dESEFkV0pmeDhj?=
 =?utf-8?B?dmszMGExOS90UGtYWmV4eGxPZlhKNlFHYXlDaENIUUlQTUl1aW45Z2dCNXhh?=
 =?utf-8?B?cTlRZENLYjZra3h2R0pHODZZVEl5VnZCT2Z0US9jcDh5OWNDODlhOGZyVmlP?=
 =?utf-8?B?RDBmcjZ4aG5CWTA4Y29GMUp0dVlKRUYzQi9oeEFSelNzYTRqNTBVdGhIcEVW?=
 =?utf-8?B?QWRYak1WdEExbzRWQldFdWp1SkI1UUhmdXdGVHdWTmQzM2hjNEZiMUlQUklF?=
 =?utf-8?B?dlRLc2YrL3g2bkhObGFKSXNXd0QyV2lvYVgzODJkOU1kMlBWNUlZcFF5RGpJ?=
 =?utf-8?Q?jUErhyi/ThmXKEOfS2q1Mk6hN/ijuinltVzeCfRMIQ=3D?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: ea22bacc-def5-4754-8e14-08d9c6714d2f
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2021 00:06:57.9608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RrKT44ZASQF/taGBq6XoSjFQAFRseBGKSkLV0w3sQhvGNI7822ZzIFKh4kb6WO8Csy90Znnn4w0hqWildyqKkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6372
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Fri, 24 Dec 2021 00:07:01 -0000

On 12/23/2021 6:10 PM, Jeremy Drake via Cygwin-patches wrote:
> diff --git a/winsup/cygwin/fhandler_pipe.cc
> b/winsup/cygwin/fhandler_pipe.cc
> index ba6b70f55..48713a38d 100644
> --- a/winsup/cygwin/fhandler_pipe.cc
> +++ b/winsup/cygwin/fhandler_pipe.cc
> @@ -1239,7 +1239,7 @@ fhandler_pipe::get_query_hdl_per_process (WCHAR *name,
>         if (!NT_SUCCESS (status))
>          goto close_proc;
> 
> -      for (ULONG j = 0; j < phi->NumberOfHandles; j++)
> +      for (ULONG j = 0; j < min(phi->NumberOfHandles, n_handle); j++)

Reading the preceding code, I don't see how n_handle could be less than 
phi->NumberOfHandles.  Can you explain?

>          {
>            /* Check for the peculiarity of cygwin read pipe */
>            const ULONG access = FILE_READ_DATA | FILE_READ_EA
> @@ -1309,7 +1309,7 @@ fhandler_pipe::get_query_hdl_per_system (WCHAR *name,
>     if (!NT_SUCCESS (status))
>       return NULL;
> 
> -  for (LONG i = (LONG) shi->NumberOfHandles - 1; i >= 0; i--)
> +  for (LONG i = (LONG) min(shi->NumberOfHandles, n_handle) - 1; i >= 0; i--)

Same comment.

Ken
