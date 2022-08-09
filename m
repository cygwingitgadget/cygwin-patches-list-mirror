Return-Path: <kbrown@cornell.edu>
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2121.outbound.protection.outlook.com [40.107.93.121])
 by sourceware.org (Postfix) with ESMTPS id D02F83858419
 for <cygwin-patches@cygwin.com>; Tue,  9 Aug 2022 20:53:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org D02F83858419
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anWjGKW6VFCW8lXRuIrbzQi3dwIBxuriZ20xuHWFMDMKQ5VjUQs3aF14fvY9WGrFBjvAh4X+vrcKUPPELWAlacdvglWpJA0DyYy/QQUu3M0TpyQcnQNkmHkSsOkGsUVehJZ97QF1TF5ZDcaFstNlXwnVQA0mQ9OFg3FNW8NQQ29yLGWBir6QVEWyQ19RAmgHtHu8RYVfoQ6Rjs/6IQxRaylEbppKZZTL4X7C/ohGvt9zpLzz7/DqwsdEZ10fPZ3fpws4qTBosbsjfHI6ueJVja/WHodiDHuvtdGBGJo6gzrcJvtjvNstLfxvFwBr1ngyi19bwgGOxe8109KQhauFMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pp6Hue9Y2aKY6EASpzlRE1A1bMZK6sO18LNef6ltnrU=;
 b=Z3375HTxegaDIaNEZFAVxoZbm4xFps81LIv6VLGKUyfG8jakYNf8s1ugI0XhItNUssCjhgFqEcWdgMa3FvmvWFIYWo2PDy3qFv4lQhSDhQil4grhDVWob+ygGd/ZLMFkRLTDss6+JTKx7+ATFyeyFM33LYjqVchekt27uXVv+rd+EgGK54afr2cSixNdbjo70B0gxJ8hSE6tp+TxPBJ5FjrGmu5+wIIbpR7odrtHE+ptKLrzBQQ2rhc5Bnppvh/WJ0j6fEWbXU4UU43/Z/Zas9UBkB3AAufC3rXKuWRxqBTPi6IuKz2X7oFfkuOu0bQ6IEbOxyS1GGmB3Pene27Auw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pp6Hue9Y2aKY6EASpzlRE1A1bMZK6sO18LNef6ltnrU=;
 b=NhyiT1T/1uaEc9QHJ7wGa0MvLVsDSmCkoaC5Nykylsu4NxgtIszc48CaMKPJ2Djkq5sHoffFbZ63RUi749jHkRuRwIjfF18RSjTORzesO/QwLvO7e6fD/+42awLDolgk90UgzsAadZNCsKjzmZauZqaO9/2iwL+fxzK3bjHuTrQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by CH2PR04MB6492.namprd04.prod.outlook.com (2603:10b6:610:6e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 20:53:00 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::901f:a758:30f5:309d]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::901f:a758:30f5:309d%2]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 20:53:00 +0000
Content-Type: multipart/mixed; boundary="------------nS0yUnlJLgzXcdWGR2QETeVS"
Message-ID: <5bb753d7-a56a-d551-c675-26e4f822068e@cornell.edu>
Date: Tue, 9 Aug 2022 16:52:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] Cygwin: fix return value of symlink_info::check
Content-Language: en-US
To: cygwin-patches@cygwin.com
References: <ba223591-0c96-d61c-36df-4f450abb9957@cornell.edu>
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <ba223591-0c96-d61c-36df-4f450abb9957@cornell.edu>
X-ClientProxiedBy: BL0PR02CA0070.namprd02.prod.outlook.com
 (2603:10b6:207:3d::47) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c72ad43-e6df-4d04-a20f-08da7a4924f6
X-MS-TrafficTypeDiagnostic: CH2PR04MB6492:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /G2Vvx/d6x9k0pC4OF2RArN6HZdEiGI+hX6ROabkqPf4Bkw/d9sWc/PVTij18dR/+Yx1tBQ8w+heAjKK4tOSauiGiZqg0EfjiLqGkn9kUcuiIC4CFw1ceUgnZ7LoFB+6GdqAiqJarJUvb1LWgLRLbVJVDpxbiJtqFA22rUABpigw2Ol2hn+68z3GFFtuJGyEwW05fSvKUcxCTzwtp0QB9dU37/gnhp5Xb4GpTjLnvN4/t77izpQQoMAEFtSLDmvJnvSwAbRm5m+NAkXaoEelRmv3F1UwR2dukoRpjgaSOKqPH0F3sutc7YpRyUiE7+90menNjbrzITxLVB1YhHXmSFp7psA1/4JV+41m/iJ3BFp/iLu2rseBCwx4qPfep/Tgh9pXPr5dJw6GOrNEtICrv3aJ/5/5/hVdZ/2Zb/h0WJeILFMSdZPMhzj1dNyOt+v4+KRn00laO0iTED5iLj04ASFi94Jgm+QraObsLFu6vvjDka3ksyFlon1XaeKi7i6noaNAMFlp0+yQ9ixIOHCx/gM5kLvh4RUuB/PEBkwHdXx/HYHYUiLy/M3Pzyp1wuWpuynWQhfMVAp1CeXILnckIRc7+Duuo1oasN/0IPHT3WEwaCVXddM4R1XfcCTXw/Fb0tGPgm3CWHruoj6t/0lweZrkiTgZY8Lpr5Z35D4oY4ea7XyZ/S77/SMgEi3NR5DCPIuYRzwWYVfIEAuFiTR+tF3PSGoCa2W3a7Bd8RK4X0QDCKqWLjmmBbWjTbOA/DsTb9cguY8BnWpEErI3nc6bStFg3230N8HinPU4AXXQmjurqYNPkLMV9flgHzUgau3DMPTXxWmB84ASlzBUb5Uq2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(66946007)(66476007)(8936002)(66556008)(235185007)(8676002)(38100700002)(478600001)(5660300002)(33964004)(186003)(41300700001)(6512007)(6506007)(786003)(53546011)(2906002)(316002)(75432002)(41320700001)(6916009)(2616005)(6486002)(36756003)(83380400001)(31696002)(86362001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlNETldnY0JmZzNCY2lTckNlc1ZHWUNOQURjRUE2emlhUEpVMm5WT2lON1A0?=
 =?utf-8?B?SXlIWmdybFdjVno0TDFnNHBuSWp3YlU1bGl6WnNheGhXcEg2eWNTSjkxM01E?=
 =?utf-8?B?RnV0VVd0d0ZEdWV1c045ODZnREJxNHE3TDJYbVIvOG53TGh6UE5BbE9Gbkpa?=
 =?utf-8?B?dW5xZEFwNW5oWVdFbzlzczM4ZkdnL0hQczdnQkg4TXZtbXNoOTQ5TDJITHpn?=
 =?utf-8?B?WXR5YkJxSGpCSWZJNWs5Q0lHTWhjVVByVG5mWnVESTFTdFBFWVN4MFljQmY1?=
 =?utf-8?B?TGdMTm4wUUJuQXJZWCtWSTNHa29tUEZUeWVIL2c5Z0srNXZZRm5HdG1YTVRM?=
 =?utf-8?B?cVFnZ2tNUTdiNG5iWWlia1IzYXVvOG8vY25UWnZVTUNHRUlaWm9qVVg4alhi?=
 =?utf-8?B?eldxTWpWZ1hGSWlsaG9wcDhLTng2dWx6V05OelFaYTNrTVQraXRmRmxTUERi?=
 =?utf-8?B?QkRmSXpNcEl6bTdyelZaUVhrM1FCM0tUb3F5djduM3RDYlcyWXlOd3QxdUFY?=
 =?utf-8?B?Sms1SkZsMGsyT1kvZFR3VGR3SDh5czkvQ1p2V2xsK0FJOGdseEliTlpjWko4?=
 =?utf-8?B?VkQ1MzdXdFVWUjFNajhkcDlIdkNtbGVEazV2NEl3U1pIalJKd0RMVlpmeDBE?=
 =?utf-8?B?a2RKNUc1MzB0TytpYkVkRjJlU2g3ZkM1NXVLWkx2ektpUXV3MU5lQ1FyY21t?=
 =?utf-8?B?dzB4aHR5OXNDNWozZzRrVi9oZnVTN24renBHKzZrMkRNZUd1dVJvMzJuM01Z?=
 =?utf-8?B?NEVxbE1YaUVSNTlSZG1kdVZQa2UwVDljcnhFNlp1M3p2aHBFSjNibzFFSmYy?=
 =?utf-8?B?MVJ1K3VUUGVmSTd6M004ZzIxTjZxbGJRQnBROUJLNWc1UGRuZ3pXRmhuQ1hq?=
 =?utf-8?B?Umg0bUtQeU1xYy84d0dSc2pSL3lSMHMyZlVYQjE3cS9NbURzZXp1dkJKUUoy?=
 =?utf-8?B?T3cyWE1EL1o2bjdIL2xoSW1jTlYxM2EvZVlNbmdOaGdINHlOWnFqZ2ZOWmFy?=
 =?utf-8?B?SWdxMnBpVDhlVFppbnVwS0hXVjEyaHRUYjZ6c0htbFpYQzBsdmxRN0JBVytT?=
 =?utf-8?B?VS9jV3gvZllHNXBiemdJM1FjS1hOWUo4bUdaZGxnRWwrS3hpYnVJNzdRNCtR?=
 =?utf-8?B?U2wxMmk1cWc0YytEMWZQRHZtay9IczRBWkcyQ2N5akZ2YzNoSXV1Mm8zaXZj?=
 =?utf-8?B?SmJScmdWaHl3V3RBTVo3U0VYVE9vU1dIZWorWTFHQnNxNzkzNThKSUVMdmQ2?=
 =?utf-8?B?RS9QdGZWQTVaK3JPSTd2QXUyYWloU0JQeUNybitPOUdnZlc1ZFo0SGNMdjZB?=
 =?utf-8?B?am8vVUU1OVpLNmNaNUkveGMzN3Exd2NtcXY0b0tyeTBPNUtpL05pZlI2Y1FR?=
 =?utf-8?B?MnpSSGpxWnpHQS81NWFpUUlHd1ozNlllWk15YTZySUhXejdhT2w2R1o1bFpu?=
 =?utf-8?B?OElIRFNrT1R3MHN1bmFWSnNPdC9FOFltVE5KdERpd3ltaHZNZXcyS3BRY3F2?=
 =?utf-8?B?NjBmanZGZG1HN3RhMEJMUDUrWE1NL25CcTRZY1kwaS9NUVpweTBoajIwcCtJ?=
 =?utf-8?B?WWFKcDBBVlV4eHFDYm1VdE1TaDl0YUw4TGJkbStoVUF2QjZUbjRIZWd1aE9z?=
 =?utf-8?B?WTNLdG52QnNKdjJES2JxdHRLaFdWeVVFU0J5ZkR0U0tyWjY4RHRueUNscG5L?=
 =?utf-8?B?SUR1N3NGVE5qNC83ZE5obHpkUG9ZYXRqMnZHVTNrdmFTUUpVYWdUVWFCM2xW?=
 =?utf-8?B?WE1IWXNMdmI2LzRKY3hiUk0zbXZGZkhmZUR1ZHVYcWttSDdLN1c3ZXZ3b1JR?=
 =?utf-8?B?bmc3Zk15YXRiSTR3WW54dHFqZGxVUnQxc1MvWTR3VzZJeEZ0T09xR1NMSzVB?=
 =?utf-8?B?Wi9mdlQ4amVnc0NUYzRtc2RXbWR4eEF1eTdMc3AxRDRPRjR1LzhHbEEyMWh5?=
 =?utf-8?B?QVl5TUIyMVJ4VEVLME1NM085RjVDcmZQdHh6eVhkMDIyQWpwanZsZzA5NGR6?=
 =?utf-8?B?SEt5SmJxVTV6alVUV05lek5KTU51ekc0UFQ1aTRQQnV1U0VuSjJ2ZWVUVzRw?=
 =?utf-8?B?WGloNi82T0x6MFpsR09lck9BN1UrbUlvbGhodFpLK1RGcnVRVWdlWTJqdkR6?=
 =?utf-8?B?ZDVLQ1BsYjBSaXZpWmtRNURBdll4L0RkYlRqcVZFZGppeXVWTlFKdnVlZ01u?=
 =?utf-8?Q?JYPNVQ0gECgKmN3AZDqSJ1zYYJed3U7kpoePWfW7JS+g?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c72ad43-e6df-4d04-a20f-08da7a4924f6
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 20:53:00.2378 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ytmvH3CAqWS7Y6n4h3Qwhi+qQ8rK21yCev7UvH7l9ZbFxoz+WEpDyORVqCPLt4QsOgqgMB8hplqCZC6/0i1Kjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6492
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, JMQ_SPF_NEUTRAL,
 NICE_REPLY_A, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
 TXREP, T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
X-List-Received-Date: Tue, 09 Aug 2022 20:53:04 -0000

--------------nS0yUnlJLgzXcdWGR2QETeVS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

v2 attached with a more accurate commit message.

Ken

On 8/9/2022 3:52 PM, Ken Brown wrote:
> Patch attached.  Please check my changes to the commentary preceding 
> symlink_info::check to make sure I got it right.
> 
> I've written the patch against the master branch, but I think it should be 
> applied to cygwin-3_3-branch also.
> 
> Ken
--------------nS0yUnlJLgzXcdWGR2QETeVS
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-fix-return-value-of-symlink_info-check.patch"
Content-Disposition: attachment;
 filename="0001-Cygwin-fix-return-value-of-symlink_info-check.patch"
Content-Transfer-Encoding: base64

RnJvbSBkMWFlZTJmN2UwMjI0OTdkNTdkNTVmZmNkNjlkZGFhN2Q3YjEyM2IyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLZW4gQnJvd24gPGticm93bkBjb3JuZWxsLmVkdT4KRGF0ZTog
VHVlLCA5IEF1ZyAyMDIyIDE1OjE0OjA3IC0wNDAwClN1YmplY3Q6IFtQQVRDSCB2Ml0gQ3lnd2lu
OiBmaXggcmV0dXJuIHZhbHVlIG9mIHN5bWxpbmtfaW5mbzo6Y2hlY2sKCkN1cnJlbnRseSBpdCBp
cyBwb3NzaWJsZSBmb3Igc3ltbGlua19pbmZvOjpjaGVjayB0byByZXR1cm4gLTEgaW4gY2FzZQp3
ZSdyZSBzZWFyY2hpbmcgZm9yIGZvbyBhbmQgZmluZCBmb28ubG5rIHRoYXQgaXMgbm90IGEgQ3ln
d2luIHN5bWxpbmsuClRoaXMgY29udHJhZGljdHMgdGhlIG5ldyBtZWFuaW5nIGF0dGFjaGVkIHRv
IGEgbmVnYXRpdmUgcmV0dXJuIHZhbHVlCmluIGNvbW1pdCAxOWQ1OWNlNzVkLiAgRml4IHRoaXMg
Ynkgc2V0dGluZyAicmVzIiB0byAwIGF0IHRoZSBiZWdpbm5pbmcKb2YgdGhlIG1haW4gbG9vcCBh
bmQgbm90IHNldGluZyBpdCB0byAtMSBsYXRlci4KCkFsc28gZml4IHRoZSBjb21tZW50YXJ5IHBy
ZWNlZGluZyB0aGUgZnVuY3Rpb24gZGVmaW5pdGlvbiB0byByZWZsZWN0CnRoZSBjdXJyZW50IGJl
aGF2aW9yLgoKQWRkcmVzc2VzOiBodHRwczovL2N5Z3dpbi5jb20vcGlwZXJtYWlsL2N5Z3dpbi8y
MDIyLUF1Z3VzdC8yNTIwMzAuaHRtbAotLS0KIHdpbnN1cC9jeWd3aW4vcGF0aC5jYyAgICAgICB8
IDIyICsrKysrKysrKy0tLS0tLS0tLS0tLS0KIHdpbnN1cC9jeWd3aW4vcmVsZWFzZS8zLjMuNiB8
ICA0ICsrKysKIDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9wYXRoLmNjIGIvd2luc3VwL2N5Z3dpbi9w
YXRoLmNjCmluZGV4IDNlNDM2ZGM2NS4uMjI3Yjk5ZDBmIDEwMDY0NAotLS0gYS93aW5zdXAvY3ln
d2luL3BhdGguY2MKKysrIGIvd2luc3VwL2N5Z3dpbi9wYXRoLmNjCkBAIC0zMDI3LDE5ICszMDI3
LDE2IEBAIHN5bWxpbmtfaW5mbzo6cGFyc2VfZGV2aWNlIChjb25zdCBjaGFyICpjb250ZW50cykK
IC8qIENoZWNrIGlmIFBBVEggaXMgYSBzeW1saW5rLiAgUEFUSCBtdXN0IGJlIGEgdmFsaWQgV2lu
MzIgcGF0aCBuYW1lLgogCiAgICBJZiBQQVRIIGlzIGEgc3ltbGluaywgcHV0IHRoZSB2YWx1ZSBv
ZiB0aGUgc3ltbGluay0tdGhlIGZpbGUgdG8KLSAgIHdoaWNoIGl0IHBvaW50cy0taW50byBCVUYu
ICBUaGUgdmFsdWUgc3RvcmVkIGluIEJVRiBpcyBub3QKLSAgIG5lY2Vzc2FyaWx5IG51bGwgdGVy
bWluYXRlZC4gIEJVRkxFTiBpcyB0aGUgbGVuZ3RoIG9mIEJVRjsgb25seSB1cAotICAgdG8gQlVG
TEVOIGNoYXJhY3RlcnMgd2lsbCBiZSBzdG9yZWQgaW4gQlVGLiAgQlVGIG1heSBiZSBOVUxMLCBp
bgotICAgd2hpY2ggY2FzZSBub3RoaW5nIHdpbGwgYmUgc3RvcmVkLgorICAgd2hpY2ggaXQgcG9p
bnRzLS1pbnRvIENPTlRFTlRTLgogCi0gICBTZXQgKlNZTUwgaWYgUEFUSCBpcyBhIHN5bWxpbmsu
CisgICBTZXQgUEFUSF9TWU1MSU5LIGlmIFBBVEggaXMgYSBzeW1saW5rLgogCi0gICBTZXQgKkVY
RUMgaWYgUEFUSCBhcHBlYXJzIHRvIGJlIGV4ZWN1dGFibGUuICBUaGlzIGlzIGFuIGVmZmljaWVu
Y3kKLSAgIGhhY2sgYmVjYXVzZSB3ZSBzb21ldGltZXMgaGF2ZSB0byBvcGVuIHRoZSBmaWxlIGFu
eWhvdy4gICpFWEVDIHdpbGwKLSAgIG5vdCBiZSBzZXQgZm9yIGV2ZXJ5IGV4ZWN1dGFibGUgZmls
ZS4KLQotICAgUmV0dXJuIC0xIG9uIGVycm9yLCAwIGlmIFBBVEggaXMgbm90IGEgc3ltbGluaywg
b3IgdGhlIGxlbmd0aAotICAgc3RvcmVkIGludG8gQlVGIGlmIFBBVEggaXMgYSBzeW1saW5rLiAg
Ki8KKyAgIElmIFBBVEggaXMgYSBzeW1saW5rLCByZXR1cm4gdGhlIGxlbmd0aCBzdG9yZWQgaW50
byBDT05URU5UUy4gIElmCisgICB0aGUgaW5uZXIgY29tcG9uZW50cyBvZiBQQVRIIGNvbnRhaW4g
bmF0aXZlIHN5bWxpbmtzIG9yIGp1bmN0aW9ucywKKyAgIG9yIGlmIHRoZSBkcml2ZSBpcyBhIHZp
cnR1YWwgZHJpdmUsIGNvbXBhcmUgUEFUSCB3aXRoIHRoZSByZXN1bHQKKyAgIHJldHVybmVkIGJ5
IEdldEZpbmFsUGF0aE5hbWVCeUhhbmRsZUEuICBJZiB0aGV5IGRpZmZlciwgc3RvcmUgdGhlCisg
ICBmaW5hbCBwYXRoIGluIENPTlRFTlRTIGFuZCByZXR1cm4gdGhlIG5lZ2F0aXZlIG9mIGl0cyBs
ZW5ndGguICBJbgorICAgYWxsIG90aGVyIGNhc2VzLCByZXR1cm4gMC4gICovCiAKIGludAogc3lt
bGlua19pbmZvOjpjaGVjayAoY2hhciAqcGF0aCwgY29uc3Qgc3VmZml4X2luZm8gKnN1ZmZpeGVz
LCBmc19pbmZvICZmcywKQEAgLTMwOTQsNiArMzA5MSw3IEBAIHJlc3RhcnQ6CiAKICAgd2hpbGUg
KHN1ZmZpeC5uZXh0ICgpKQogICAgIHsKKyAgICAgIHJlcyA9IDA7CiAgICAgICBlcnJvciA9IDA7
CiAgICAgICBnZXRfbnRfbmF0aXZlX3BhdGggKHN1ZmZpeC5wYXRoLCB1cGF0aCwgbW91bnRfZmxh
Z3MgJiBNT1VOVF9ET1MpOwogICAgICAgaWYgKGgpCkBAIC0zMzQ1LDggKzMzNDMsNiBAQCByZXN0
YXJ0OgogCSAgY29udGludWU7CiAJfQogCi0gICAgICByZXMgPSAtMTsKLQogICAgICAgLyogUmVw
YXJzZSBwb2ludHMgYXJlIHBvdGVudGlhbGx5IHN5bWxpbmtzLiAgVGhpcyBjaGVjayBtdXN0IGJl
CiAJIHBlcmZvcm1lZCBiZWZvcmUgY2hlY2tpbmcgdGhlIFNZU1RFTSBhdHRyaWJ1dGUgZm9yIHN5
c2ZpbGUKIAkgc3ltbGlua3MsIHNpbmNlIHJlcGFyc2UgcG9pbnRzIGNhbiBoYXZlIHRoaXMgZmxh
ZyBzZXQsIHRvby4gKi8KZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vcmVsZWFzZS8zLjMuNiBi
L3dpbnN1cC9jeWd3aW4vcmVsZWFzZS8zLjMuNgppbmRleCAwNzhlNmU1MjAuLjM2NGUwY2IwZCAx
MDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9yZWxlYXNlLzMuMy42CisrKyBiL3dpbnN1cC9jeWd3
aW4vcmVsZWFzZS8zLjMuNgpAQCAtMzUsMyArMzUsNyBAQCBCdWcgRml4ZXMKIC0gRml4IGEgcHJv
YmxlbSB0aGF0IHByZXZlbnRlZCBzb21lIHN5bWJvbGljIGxpbmtzIHRvIC9jeWdkcml2ZS9DLAog
ICAvY3lnZHJpdmUvLi9jLCAvY3lnZHJpdmUvL2MsIGV0Yy4gZnJvbSB3b3JraW5nLgogICBBZGRy
ZXNzZXM6IGh0dHBzOi8vY3lnd2luLmNvbS9waXBlcm1haWwvY3lnd2luLzIwMjItSnVseS8yNTE5
OTQuaHRtbAorCistIEZpeCBhIHBhdGggaGFuZGxpbmcgYnVnIHRoYXQgY291bGQgY2F1c2UgYSBu
b24tZXhpc3RpbmcgZmlsZSB0byBiZQorICB0cmVhdGVkIGFzIHRoZSBjdXJyZW50IGRpcmVjdG9y
eS4KKyAgQWRkcmVzc2VzOiBodHRwczovL2N5Z3dpbi5jb20vcGlwZXJtYWlsL2N5Z3dpbi8yMDIy
LUF1Z3VzdC8yNTIwMzAuaHRtbAotLSAKMi4zNy4xCgo=

--------------nS0yUnlJLgzXcdWGR2QETeVS--
