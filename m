Return-Path: <kbrown@cornell.edu>
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2116.outbound.protection.outlook.com [40.107.243.116])
 by sourceware.org (Postfix) with ESMTPS id ECE043858D39
 for <cygwin-patches@cygwin.com>; Sun, 26 Dec 2021 15:10:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org ECE043858D39
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+i9ttdNkViCKo5SNYYMuIWNVGYZMR/P02RfP1kk4mdlvLSZ2MXTsCzW0ow1SaX4SbMQpZBuEc8VPfjOrzonLWZQ2kcLJfiQgWlnzkbbGAzuq1dEsEMZcZuTdOT7+jUoLr32EGIQoP0AEsYXH4zrRoBIk8OV4Vrn0b5ipd63reLrUtOmh4gSbs8pObcYirM9c30Ym503HHPK8mBmD5F8s40uxKWVyR7vf8l6r0AAX1zfRIRW6H0UQc4Ej9zjP52VortjKDzdajQoAPtjFl3E+VPJD6i8QfSNB47L6V8YyTzjvVwkLx4Hp52G61RxPwFVK2H6iJsjkl0rX/EtXt6/ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MboXWT2UpSMdBalq6jRIg6quEpOVN4blDDYpbICC8kk=;
 b=DFapMy/J9Mk51EEl0iwwrHSqyHJWH+nTWcNP0PgDj9zVL8ePitQXZt49A5pUwscQbUOOCPlPsETOSmBCIDsl9rZrk5AQEhObpTTfWyYhU5BJbNAlzGSi68u4kNE8VdUqMejnNOodvxrIVbiQbWLh7Cc1OU5jtGf9RE8MXMg7GlhMOCWgyllMfiA95l81d8Y7/O0rL9I/dxjqMg08fjhFOOSWq+BeR9Cai+xVzFOB1a+NB29LKFjhzvnw3SfQIrCjWw/TlecVcIdALscvuAt3uqJDwpyypkq5bL02fGs3ed1EkTTg+PJ4USl+fWWyYSK8g0D6rTYzHGrl2hnRuLpdDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MboXWT2UpSMdBalq6jRIg6quEpOVN4blDDYpbICC8kk=;
 b=GE1oVg1KEsu67Y4OiEcoGOOo5I2AlKFohNAyUDW2xLZtq93EZmgDcooG71wtRSHbaZzINDECPw3lipTKKFjPNXypRNB26I7ztcNJppWvWApfYRFhiIDvhRn4HUhWHKUnWBp6AZ006T5QdaSzWjgfEJNvXBJonEiX/iqm7YpYgUo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from BN7PR04MB4388.namprd04.prod.outlook.com (2603:10b6:406:f8::19)
 by BN7PR04MB4049.namprd04.prod.outlook.com (2603:10b6:406:c9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Sun, 26 Dec
 2021 15:10:01 +0000
Received: from BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::e53a:dc46:9edd:9142]) by BN7PR04MB4388.namprd04.prod.outlook.com
 ([fe80::e53a:dc46:9edd:9142%6]) with mapi id 15.20.4823.022; Sun, 26 Dec 2021
 15:10:00 +0000
Message-ID: <c7664703-0ec2-388f-64e3-8c46d4590b3e@cornell.edu>
Date: Sun, 26 Dec 2021 10:09:57 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] fhandler_pipe: add sanity limit to handle loops
Content-Language: en-US
To: Jeremy Drake <cygwin@jdrake.com>
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>, cygwin-patches@cygwin.com
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
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <alpine.BSO.2.21.2112252054310.11760@resin.csoft.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P222CA0011.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::16) To BN7PR04MB4388.namprd04.prod.outlook.com
 (2603:10b6:406:f8::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01833f80-aeae-4edf-df35-08d9c881c94e
X-MS-TrafficTypeDiagnostic: BN7PR04MB4049:EE_
X-Microsoft-Antispam-PRVS: <BN7PR04MB404929A3506A205162F8FD6DD8419@BN7PR04MB4049.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zUh9ABU8Vwb5OgwpfeQY395HE7uAgMhocHV+5tlr2HcvIjwBeZcU8RhizB6tx8dm+BdRCoT/sbV6HgVE4tCnngDwpyuj3mKu/07Ct39e5hRPcBzYU2UCgAw6ZjbZbrWhIO5yS52CuG78GEjGzs76sbtfwJY3SVtYVRk9TiUa+TtKembqprhffncsv7yl+2KC7GVuzMISHhMEssSmY0ke1yke4/GaLrkfWMTKhvzN+rLR2yuA4DfH/QzHC0DUeZdUE6QiysfZWnZiR6M0NebNO7u7bZh8H1WCjG3FtQ/ry5YOml26aart4grUeIg/NwvFlN4FgarJ80fq9+bvs1Chvhv94mzEsV4wP8OdOXJktS2MN2ecqLfyV7WMs8Mljk96/vF0VJGvQNcNHD/lC/AR2DRw9X0nql1qlcZDzXxOUojIrFwAEuRrvkxJ/DHIDKOE0GH9Jq6pLfNDFUKVyIv8nTDVflFc0EoeO6ehCN2I+tFWeyOCCcEKwbQqz8rALZdriy5UeFPW0mtLgd5+08LIDtpJiC7xX3cQvmw/fsgOpARQkk7fxHK19uKZ4SIgXtNYZC8vx/V3Xfd1p8E89kMv6YfufWLI8XmfYeiS18U23KT5y8ID/yIj4eO7q8gWYK6ZpZPLVF4ZdYKdvOk6QZyx2w3lBXBLiLUciNPSaz5bbmewHNcrfRRmPJOMAlFnph2Dr6c17igu9h7y+Ph+ozmCXHKPj/wpUZ5H8XwSNNTkhgOjNnmfLNCsabsilZIi9jzI7fPUOiFlhTiFtXEoblAM/Bj8DkHUpaMTBc3HGG5/gFGiqycX/mwesTyyfLhsjNZt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR04MB4388.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(36756003)(5660300002)(75432002)(66476007)(186003)(8676002)(6666004)(8936002)(2906002)(66946007)(31686004)(508600001)(83380400001)(6512007)(6486002)(786003)(2616005)(86362001)(316002)(31696002)(6916009)(4326008)(53546011)(6506007)(38100700002)(966005)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OC9lZHZXS0JhZ0FtY05RZ2FrZHJBdFFiOGRWUWhxY3ZkWmxUa1c1Q3F6ak5G?=
 =?utf-8?B?Q2RnWnBNVzJDTDZzVklEeFVUUTVtbjNXT05nWEtzU0hIakx4SGpLc3duRG5v?=
 =?utf-8?B?dWVKTWY1NDV1NmZ6UWFJWG16VGVPd1E0SFhuSTA4bU1qb0FrVWgwMGl1R2kz?=
 =?utf-8?B?bXpSTDRrN1J1TkNUQjFRTUJtMkE0YW1vSUxCeXVRb1EzeWU3Tlo2Q015K25R?=
 =?utf-8?B?S05Hc3E4SDVVd0dSRU5oNWpNaU5DeExWN3dveDcrY1FXM29RNTEveXdmdHNM?=
 =?utf-8?B?amlHdEZBbFVrQkZpZ2NnZEljZHMycUIrSDh0dEJYMHhxVW41T0JWUktEUWNX?=
 =?utf-8?B?TGdKMllTSUVNWi9hNXA4NG8yaTdyN2djemphc3VKc0p0Z0E0N05wWERhaVRw?=
 =?utf-8?B?SUxiSFhxSEFBU0tqekdZSFhDV3N4Ny8yREFiVnRVem9WdXJBeUFkdmVGd1Jk?=
 =?utf-8?B?VHFkMUd4YzN1dW9EcE1ZekY2b0Qzb3NZZHB6SS9jM2p0V0gxK2dyMVExOFhY?=
 =?utf-8?B?TG9WWHRzd2dtQVBsVmlWQndCUm1Mc0lFNXBRYnJqMisyZ3dRd3Q1bW9ibHpw?=
 =?utf-8?B?RUorNTRVNzlINVpUNGpRcnpaUnFURW15VGI4UmFERHFoZnBYQzk4R0llWEpS?=
 =?utf-8?B?VndvNVloNFJZeWMwQzFVVzdwMm9tTU83UUdKNDVwWXo4cEhVTmR5MjRZTWpO?=
 =?utf-8?B?OVd3WGh3SjJIcCtCU3B2Ums5WHJzVEtNaXhWdko0dSs3T3B5dVcrVkx3Zk5Q?=
 =?utf-8?B?ZmwwemhuL1MyRGZWRnJEa1VNRWNxMno4R2hzbjF5cDl4MXlSc2Zlc1ZQekdo?=
 =?utf-8?B?LzVscVBjUUxlRVUrQzFPZEhvY3NaK2hteCtYaStlWW9ZQXgrY2lxR3JWR0I0?=
 =?utf-8?B?UlZYMHlTNmdVVGFnWlI1RzIranNGMEhid2F5cCt0N0ErdVVEVGprSE1yMnVJ?=
 =?utf-8?B?VGZIVk5ONlByZ1ArYktkOGlHWkhQUVJsYnc1azh2aE1maXNkS2NLcERUMjd0?=
 =?utf-8?B?aGh1V3dUb2RQR3hSZU5ZaEkwMVptNFhWOWdtalBSeDlBTE1KNVNzN0NtcURa?=
 =?utf-8?B?b1V2Tll3djRpMFBUNW9VTnkvNVlOU1pnQkZHQ0crczdYaWxGV0xxTjJtSSt4?=
 =?utf-8?B?UW5kdHQzL05qalV4cVN0THFXcU40RVdRdUpudWRRYkNLMnUyTmR0ZjRFNUEz?=
 =?utf-8?B?cGVEeGJucHJyL2JQNjdaZ0UySVA2QjE5REQ0dUExZHBUVkxIUmVuVEQ4a2dr?=
 =?utf-8?B?enVUSVlNY01KR2xGS1lGRjl6M2NaZUtiN3B2RFBFTHo2QldtYlJTK0ZvN0o2?=
 =?utf-8?B?bmRZU2dmdHh1UWRDU0dHVTlNb3V6Nmt4N3lIdjFTQUNJSUljODZwZWdWN0Zj?=
 =?utf-8?B?YXRkOXdjSjZSa3Q4RlUrcGc0ZzlmUVMyMTdSOEh1c2ZPdG5TRDBaM0JxMDlT?=
 =?utf-8?B?WTRoQmN0UGpORVRDTW8yRWk2Tmo3MU1aSDFPanlJemYzakh6QWZMcGRnNjh4?=
 =?utf-8?B?NEVoZjRnQmtuVEovbjE4TENUM2VmVTMvWlhSSUZ4RVFkczNoNS9KWGVlQ3BY?=
 =?utf-8?B?MmZSVzhEcVdFQXpYbDFEM0NHaWFJZTZzSTZWQy9ZYWxjdXdqdjIwWnd5SGVj?=
 =?utf-8?B?NzViSDVWTUlZazRGYkluV0g2aTB2NkpzN0JZVVoyTjRvMmhSVzNmTjM0WHJ1?=
 =?utf-8?B?enFTOU5pM1FsWVo2V0FjOHlEODljVzNid05HSXhocUpuaTNCVU5KK2NJWERJ?=
 =?utf-8?B?ZWt5M29uVmZCQStSRExNRlFYRm91eHFIRk14U1BRcnBJTy8yaFN4MTdwVEQx?=
 =?utf-8?B?eUVZNnhNdVVFSmJBdVh0MUduV1BnbUZCN0ZoTWFOWWRicWYxT3I3TENoTHdP?=
 =?utf-8?B?VWtqVzkwR01MYkpyY2VIaDBOMVBBd2d3dzN2RDVRTUFpSEpxR0MyaVJnNjVQ?=
 =?utf-8?B?aHdmV1hPTnk1T2F6VjdUUVRVeXc5M2F0NHFmNkpZL0Jha1pGMmFrVXMxY1ZU?=
 =?utf-8?B?MUpvM0dzZ0pyWUo2aDFpak84TzJxTnNXcThORElMNXJRR1h6akJoYS9KZXN2?=
 =?utf-8?B?bk5xQmRmYWJvN1lwd3Y2QWVrNXZ6TXVPeEJQUWNjZkhFeUR6elVBa3pkWm43?=
 =?utf-8?B?YTRkb2tHcUIzUUh5eGUxSkhDTWxYTk1vYXZpbmdYMWZseTlPY1ZVN3FFQ1Rt?=
 =?utf-8?B?dVdiR0JmbXp5Vk9kM0tRbTFqTXFSeFBaZFNWVFI0L3NGUGtEa3NjZjl1Vzcz?=
 =?utf-8?Q?Y8hIPXbp9+32UNNey71WtDUfPvq/6rWfVT205QPchY=3D?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 01833f80-aeae-4edf-df35-08d9c881c94e
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB4388.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2021 15:10:00.4611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KoY2O0MJPAqRxzs8Zm/ZvpV9bmb/rR7P1CxE7Ujmg1T2vt+OuYN0jNk9Y1USI730XE0rqD7H3A4IOGlQvbA1xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4049
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, TXREP, T_SPF_HELO_TEMPERROR,
 T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Sun, 26 Dec 2021 15:10:28 -0000

On 12/25/2021 11:56 PM, Jeremy Drake wrote:
> I set up a windows server 2022 VM last night and went nuts stressing
> pacman/GPGME.  I was able to reproduce the issue there:
> 
> status = 0x00000000, phi->NumberOfHandles = 8261392, n_handle = 256
> [#####----------------------------------]  14%
> assertion "phi->NumberOfHandles <= n_handle" failed: file
> "../../.././winsup/cygwin/fhandler_pipe.cc", line 1281, function: void*
> fhandler_pipe::get_query_hdl_per_process(WCHAR*, OBJECT_NAME_INFORMATION*)
> 
> So it is not something inherent in the x86_64-on-ARM64 emulation but can
> happen on native x86_64 also.

A Google search led me to something that might explain what's going on.  Look at 
the function PhEnumHandlesEx2 starting at line 5713 in

  https://github.com/processhacker/processhacker/blob/master/phlib/native.c#L5152

Two interesting things:

1. For some processes, NtQueryInformationProcess(ProcessHandleInformation) can 
return STATUS_SUCCESS with invalid handle information.  See the comment starting 
at line 5754, where it is shown how to detect this.

2. You can use the ReturnLength parameter of NtQueryInformationProcess to see 
how big a buffer is needed.  This might be more efficient than repeatedly 
doubling the buffer size.

Ken
