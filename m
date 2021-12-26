Return-Path: <kbrown@cornell.edu>
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20720.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::720])
 by sourceware.org (Postfix) with ESMTPS id 4ECE83858D39
 for <cygwin-patches@cygwin.com>; Sun, 26 Dec 2021 16:04:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 4ECE83858D39
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVleO5vKXljyIlbQL8Y9DDyc3X3JFIId5ogox24siMBp5OXscCRrNreCf5iAAwMiKw0li9Td2+duyagx1r0Y0zvhuvLb9G2b5SF0ejVr4VAbL2zgLFd4ycxyl4MidcziV257W50EfNhXiMsem5/x3hzzCUhDfa4MaTpjsODtV9W9ZRuN3HeNrC1FVjOQf0jF2GXdBbC5YvyyCeGZihUgDdoBXUdUx9jwHC4nAgcqa3q2hDS7I/dW841bNPP6/BBME0sd9Rd/YVzMJO18xl9rchVKAVd6t1inChl4c7AULU1WYpd1uEHrw590C4ymzWiqfzr7ik9Uflu6C/IdW0lCqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zaka9bx5QQf0FRvFIeujajOilpvobXoJLd/9NFKuyvw=;
 b=nQjaiOys0YaedEgUg3f7XeuALFBGYekhsSwYjknJLoaLnAeodseqY7d+hRfE8bRIc/qZY8fZS/i9ySEPApgeTBqo4j9yb0n2++tlcxP29dLmd0yl5xXOK3cOYdQjGxtM/fnkeF32ElyVK+kcYTlbWRvLkJDQt7TJuFiFIEqKBQcToACWpQQx1XhGA2idKIIozcjGig7P1nSh1tdmaDcig99R1bkXkwoDfuiTi/zHOvHYqCoz9P94O18J1G9K7M+Gh6OKXfzNo7OHJrDxD37n/5sszR6rXp8EptslBZdahJafS9yrS0bN6gn9Q2KB+Jh+jO+TNhUrZFLn8tzhEBYyKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zaka9bx5QQf0FRvFIeujajOilpvobXoJLd/9NFKuyvw=;
 b=hx9jPONdEx7m7tNP36Wmgg0qJ0VomobiaWBsj4dEblRqu2pbLQcVjR/I2ssaGoT28EM2fmZLaUegboUyY8LMuW7JFj1GduY4JCvnv34mmJ2GvabuQ95AhjSmhNM2jbrOPUIJGtHGW8WN3z2u8VFCGQ8iuEoaXKGBLImCqLnocNk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN8PR04MB5825.namprd04.prod.outlook.com (2603:10b6:408:a5::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.16; Sun, 26 Dec
 2021 16:04:23 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::e53a:dc46:9edd:9142]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::e53a:dc46:9edd:9142%6]) with mapi id 15.20.4823.022; Sun, 26 Dec 2021
 16:04:23 +0000
Message-ID: <d2af0b22-666a-b820-acb0-afc835836372@cornell.edu>
Date: Sun, 26 Dec 2021 11:04:20 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] fhandler_pipe: add sanity limit to handle loops
Content-Language: en-US
From: Ken Brown <kbrown@cornell.edu>
To: Jeremy Drake <cygwin@jdrake.com>
Cc: cygwin-patches@cygwin.com
References: <alpine.BSO.2.21.2112231503400.11760@resin.csoft.net>
 <f97bba17-16ab-d7be-01f6-1c057fb5f1a5@cornell.edu>
 <alpine.BSO.2.21.2112231623490.11760@resin.csoft.net>
 <c5115e9b-6475-d30e-04d3-cb84cfa92b3a@cornell.edu>
 <alpine.BSO.2.21.2112241136160.11760@resin.csoft.net>
 <622d3ac6-fa5d-965c-52da-db7a4463fffd@cornell.edu>
 <alpine.BSO.2.21.2112241638280.11760@resin.csoft.net>
 <20211225121902.54b82f1bb0d4f958d34a8bb7@nifty.ne.jp>
 <alpine.BSO.2.21.2112241945060.11760@resin.csoft.net>
 <20211225131242.adef568db53d561a6b134612@nifty.ne.jp>
 <alpine.BSO.2.21.2112242101520.11760@resin.csoft.net>
 <20211226021010.a2b2ad28f12df9ffb25b6584@nifty.ne.jp>
 <alpine.BSO.2.21.2112251111580.11760@resin.csoft.net>
 <alpine.BSO.2.21.2112251457480.11760@resin.csoft.net>
 <8172019c-e048-4fe2-79c9-0b3262057d3e@cornell.edu>
 <alpine.BSO.2.21.2112252054310.11760@resin.csoft.net>
 <c7664703-0ec2-388f-64e3-8c46d4590b3e@cornell.edu>
In-Reply-To: <c7664703-0ec2-388f-64e3-8c46d4590b3e@cornell.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:208:c0::35) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8b6e005-82f9-477f-0759-08d9c8896214
X-MS-TrafficTypeDiagnostic: BN8PR04MB5825:EE_
X-Microsoft-Antispam-PRVS: <BN8PR04MB5825F497A0C8682E158483DAD8419@BN8PR04MB5825.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: omXdbImUUUQAt+A61dZbWG2MtJK9whDEFz0dzYP/PmzCrSMyxLVPffSwcc8qMVbC5JSFVCPpym0iAqAHQOkukOtAJ/9cEB/uqAwFUwymmJNlXx8ceJ8xvZS6mcUSIyGrpkTz0Bwq++WaA+m8Zoaosbjo5zRPjKfSKOVWcqqQY8EirQamG/gtViHohBl5h+tTkY5wKYXLjoic61+Ibkkkn6Wh4dXLVPyDmIDtF6UDbe9L2I52WYJMBqpMPnJZ57pxHkLfwlTmI5A56MUYz1i1080/Yl13LcDcd3vT/Vxr5RuQRNeUUWKdrzIS1BFmhv8SaPqOTfj9byMxjvR+rgzApeDp5jvl+hJP8tC7shY3l3QFTl5pVYSf+JrZaeG5RSdI5k5CwXEqXZwyBkZPc5WdOmC9Q0a5MeQfzFCHmzr6L8Lfjz2kztos/Dbrg5gIcK7fivf6vJ6NZW/jWg14nkEOH+WiNzJMWv/moicDATW1YufUsp/YhjcKi5KHUum+VfsozXUqKnqVlALBVKWiXuIPalCaeBfz54ZneodXhRtn2yxj7ByuattSaCX340lX8+1gzoft66oR3bchJ2roLkXzq2Gwdo3WoWo18nE580DAdQl34d3d9nbJJgm6hhsL3ZlzMC1Ai3YhUza5fQAV3rptMbQKtxfq9g6Zj/v0fgj8Ltbhu3pgKV+8KBS2oebDumWazD8nc5E3O1MoqW773iQ4l7yVBksS0Csmbhu4fAIKQvs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(75432002)(186003)(2906002)(4326008)(83380400001)(316002)(36756003)(31686004)(508600001)(5660300002)(786003)(53546011)(6506007)(66476007)(6486002)(8676002)(86362001)(8936002)(31696002)(38100700002)(6916009)(66946007)(66556008)(6512007)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkZ2M2hXTzlUbTZUbFFuUnNvUWNmUzh0S1c4K21EMDR6dlduU3d5Zk0xVHF3?=
 =?utf-8?B?WVN0RUJIaVljaEZuR1FmQ3doV0lrbjJpWCtlQ1VhTTkzTVNQeWJ6QkJKaUJk?=
 =?utf-8?B?MnlzOWkzUDlseDVBaEt0bUNwSWJSV0RvS0cyU2FXYnU0TDhGcmhoZUFmdXhz?=
 =?utf-8?B?NCtMVkUrQ2lIRjlKazdyOTMyVE9nRVJWbEFkeW5adjZkYjM0U0hnSjljRzRa?=
 =?utf-8?B?dEpwNTZsa0RCM0pVZklBR3VnNi9hczBoUVptcVJhWHJxQjhqUVVZRHd5WTBx?=
 =?utf-8?B?VWZHSXNPcWtNdnpzNHpZeFRaa0MvTmtLUVRiL01yNE5DRzh5d2hZWjRDVlFL?=
 =?utf-8?B?bFdjMFdTODhFaGlOM1NkMFZmK3VDTmRUdEFFRkxxQzRGaTRjOVBGbldPdEQ3?=
 =?utf-8?B?V0JwTjR4cmJMam1KU3BQa28xeG5kMW8xZWFReTB3bDFYanNxdUlOODFSNjB5?=
 =?utf-8?B?RzgyZXBFaVVuc0duY01CenR1N0hYMlV6NjFHYW9TaGNZUTdJeFFqYWFKR2NM?=
 =?utf-8?B?R3JNRzhwOTA5cWUyMGxLNE4wQVU1RnM5VEhIVFZoYTc1cGYwdFJMSFpFa3BL?=
 =?utf-8?B?a0JjTVl3K3NRR2RGWi9wS2N1cFd2L2Vuek5SbVJKZFpiMUNXMjZ4bVNRZHRQ?=
 =?utf-8?B?KzZlOFlDSWloYWJYY2VQVVJzV0FnQTd4bmtvRzlJT2Z6c0RWRlpHQ092VWxY?=
 =?utf-8?B?dVZtdGEvWm1Oa1pXdmQzZEROK1gvOU5lbGZ6YW5FREViTEJnSUxIK0ZQM2t5?=
 =?utf-8?B?ZVRBZjhaRWRUa2NlZFdhTXVHdWxEM3JoWm1qWUhmdlF0cEl1Uk1XZGI1YWpw?=
 =?utf-8?B?dHcrQzRTY21MemU4MW5oY3g0NHpoUTU2T0s3ZTZHMWxLNHExeUc3Vklubi9F?=
 =?utf-8?B?OUVVYytVRUtPc0pIK2VoR0g0VGU2UFAwTld3cHpYNE9PZk94ditJN0ptY1NU?=
 =?utf-8?B?Wm5vNE1sbkEwaGZwSnlVUkh6VkY1dndWVFNDWUlydFgyMGJ5YS81NmtkNVRj?=
 =?utf-8?B?eTVZSGw3eFdKZDQ0NUtzRWVNT25YS2Fid0wrc3BZU1dLLyszMHkxNXVLQWdI?=
 =?utf-8?B?RU03ZzU3U2d4Vk9RY2JrZytndTJBOWNQVFZHR0RZZTF1RFdaSTBKajFpeWVw?=
 =?utf-8?B?QjdSM2x3b2dKTzNtczl0RTdWQklXdEorY1lDaFRSUllLcW9KRGFpZFhkME1T?=
 =?utf-8?B?RFlJQUN5WnhXUG9WKzAzcEdrM0NSalQyM280TFlZWGp2R210dFVvSzFTNW5a?=
 =?utf-8?B?NUhzenljOHlYaVdUMWRodzRGU3dqdWdHNGdwVUZtSGovenU5TW5HZjJXLzVH?=
 =?utf-8?B?SDdPQWdwVFNBcE5hdER2alloSDBxa0RQMStEa0g4UElDemNaTFk0TUtoNHps?=
 =?utf-8?B?dDlVWVNDSE1yMEt4eEFMRkFOTWk2K0xublJRK1JWUlRHZ0tpQkZJaXJwdk5r?=
 =?utf-8?B?eVY5MVRGQXp2bkVUVUlUTDZGbHhaeE5nRUpFaEp6UGs2Rmgyc2ZOWEk0MCtT?=
 =?utf-8?B?WmwvL09jdm84Mno2U2VIZW1yTDByaFcrSXMzK0JkQ3ZpTE5tOGZrczgxT0pZ?=
 =?utf-8?B?WExPbTRHTEtvRkhDS0lrb1N3VkJZSTdyY3RadDk3SGhKZHYrWmE5Rk0yRnJl?=
 =?utf-8?B?UXJZUHJMQ1o0ZG9SSDZYVHFVOG1VMHNxZ0Y3b0R3M05vYXFTY1ByLzdZdGRv?=
 =?utf-8?B?bmVmSHNNdzFYdEwzZzRJTHgrSmJqQ3dZN1NKMHhOL2krYVZwM2JEYTFXUjMy?=
 =?utf-8?B?QzRianpPZ3RBS3VKTjZ6RkFrVkhseHZqYytDeFFGTUN5ZXJDSEtId0hnVHFI?=
 =?utf-8?B?dHhSOFNmZ09uVzFpMitiRXBieEtMVGxLOVRYQUU3V0NtYkY5NEJjcGR5K0cz?=
 =?utf-8?B?ZUZYSXhvczdJcnRlV2xNQlFCWGw2TVFJSGtZbjVHMFMycVNKMzdZTFFKU0VD?=
 =?utf-8?B?M1pUK0JLb1NEMTd5Z2k4OGdlT2tSQUJVLzk3LzhCeGRMQS9NSnZ1c1dzS2Er?=
 =?utf-8?B?SHJ4WHpFZUI0S242OFR0empaTXZLNlNUUDBCOXlBNitoZ01Cdnp5OHNISjl4?=
 =?utf-8?B?eVVDbEdrd29zQjNhdXRkMko2VmpQSFJqVmNmOFJtNDRBVlBqZEZQK0NUK2NB?=
 =?utf-8?B?TmtIVG9zcW1wblN6d05DZ2NxbGsxSkhHdkdDT3loWUNGUCtmYTloQW9vazMr?=
 =?utf-8?B?Q1RGdm5hbWMyWWMvSDFSRm9FTHp5aG9SS252Zmg1azArdStDVE9ncHBBMDFD?=
 =?utf-8?Q?DosFgZprZeAT9HKAYLnFO9b/WSvXjBBaVGRWmit4Fc=3D?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b6e005-82f9-477f-0759-08d9c8896214
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2021 16:04:23.2752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQRvS+MIaHOaee81upVb0x3s2BSg3gewBqhWU95ImL0Zc1hzNSXPoSnSBbcafgFNrAY5JFcKzdj1qyGbtqFikw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5825
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, NICE_REPLY_A,
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
X-List-Received-Date: Sun, 26 Dec 2021 16:04:30 -0000

On 12/26/2021 10:09 AM, Ken Brown wrote:
> 1. For some processes, NtQueryInformationProcess(ProcessHandleInformation) can 
> return STATUS_SUCCESS with invalid handle information.  See the comment starting 
> at line 5754, where it is shown how to detect this.

If I'm right, the following patch should fix the problem:

diff --git a/winsup/cygwin/fhandler_pipe.cc b/winsup/cygwin/fhandler_pipe.cc
index ba6b70f55..4cef3e4ca 100644
--- a/winsup/cygwin/fhandler_pipe.cc
+++ b/winsup/cygwin/fhandler_pipe.cc
@@ -1228,6 +1228,7 @@ fhandler_pipe::get_query_hdl_per_process (WCHAR *name,
             HeapAlloc (GetProcessHeap (), 0, nbytes);
           if (!phi)
             goto close_proc;
+         phi->NumberOfHandles = 0;
           status = NtQueryInformationProcess (proc, ProcessHandleInformation,
                                               phi, nbytes, &len);
           if (NT_SUCCESS (status))
@@ -1238,6 +1239,11 @@ fhandler_pipe::get_query_hdl_per_process (WCHAR *name,
        while (n_handle < (1L<<20) && status == STATUS_INFO_LENGTH_MISMATCH);
        if (!NT_SUCCESS (status))
         goto close_proc;
+      if (phi->NumberOfHandles == 0)
+       {
+         HeapFree (GetProcessHeap (), 0, phi);
+         goto close_proc;
+       }

        for (ULONG j = 0; j < phi->NumberOfHandles; j++)
         {

Jeremy, could you try this?

Ken
