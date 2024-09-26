Return-Path: <SRS0=G+UD=QY=cornell.edu=kbrown@sourceware.org>
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20702.outbound.protection.outlook.com [IPv6:2a01:111:f403:2009::702])
	by sourceware.org (Postfix) with ESMTPS id 22A6F3858D28
	for <cygwin-patches@cygwin.com>; Thu, 26 Sep 2024 14:33:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 22A6F3858D28
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 22A6F3858D28
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2009::702
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1727361226; cv=pass;
	b=DsIj3S8WSWHLy6xigGlHURNQKK+sXVvxkzOYsO4upCmudzkzu8dOqeTWbL/M5J6QobcYkftgDj+QiRoDbliNy6J5gOHBlWwW+/m0pL5NgIuP0sMa+AsbNAZx5V2bjsiKxK8DqNeqGgiy9IPYnrzrVPHmt0AuY02XIpwP6KzJYnY=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1727361226; c=relaxed/simple;
	bh=IR6YdAi8LKiS/IUOzYsmg4YNM0JK/xB2oiHNMxVvNxw=;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version; b=btqha54ZBf6EwAAmTfpMfrBNImJdRlrgKJDyq4XFIco12t5tzZAnqbzg3mS8vKQmise81+bf47a2MNqc+GpVciSWTPxOwVw6CQzvPXK5or68wK8uZT/r7Z+pvs2kQLzWk/TCyj76BKgdhTSkdbdkOP6Q2uMEm3NVblrwGF1epMc=
ARC-Authentication-Results: i=2; server2.sourceware.org
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=od1ctBUnJPOGJVOEOcaYDKhMUYUxOt54kmtudEcLZHdinkRd/R9zslwBi6z20+10rLiP3B1LH6bWMcJh8ljXiAmITAw7nH5vUp9jOfQfV5QPA30fq9nrUBe+fYpPNj61GPHUHOcbCg5f1eBfWx9glf1+y03l0rgZvuhr/SeWt8BCpWTkK/ztKVQMJDHq+2zXAsniSEHsj52tflpFBOFepAY5pXclsrRypvTolp8NRgrtZHpH7QBkuUZhOcFr1k0VdLuBMw521E5XweKaOsPZooOQwvw/Nc7ZqzINqHkmCuUa/Ixa0mYhvYl8WmFriibRWxvgfPTHQYOzmS1tF65u7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2u6YWvqX2kNbuBYmiJd/eRK6UnoOYbZV7Dep60Efq0=;
 b=AjXEFfxIMCMSyNSk4sP64D141vAjG+SRzeyrpwGc8TJQXQOhxlaPh1GnMC/NxS7OpxLqHyeS4VLYOmAnHi4ZsEawAkWK8O6jhEPq4sGPME8zrDOY0JcIoMolcpwbZgkwzd1sV/uuIvq/F4Hp3v/OlZUPyCmYygZnMMOevd6st/YtOkKA6T0lNuRLnb73/RwgLaKfuKRGuFx4CKOIVB+m2l2/cKYIzNJAPF5MSTGBVz5LCGL0JW5HvRfc+RCio3oCGaWOdv+10Kl4AEgJ6CNbDNoVFsGYn9meUY5G0W15ctyEFd3ZGVTS8+ly4guTQvb2BcLePMoulw7kZJT2m6EyYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2u6YWvqX2kNbuBYmiJd/eRK6UnoOYbZV7Dep60Efq0=;
 b=HObqmpPhd/7L/ZSYOj6KxVvTDy1Oftd11GQiUKo7COjmkEww6jL69m+vHU4TObsr1YUvF/2RcjTmBlQT6+fEPyz84tp+Hgk3lO1yQ3gquXVIxVvn2rU6BfI/8GpfFWYDPxqA30wF6w6BVYa2J/r4i66hlt5OcmSCM6e+SjpsdXM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from SN6PR04MB5151.namprd04.prod.outlook.com (2603:10b6:805:90::25)
 by PH0PR04MB8227.namprd04.prod.outlook.com (2603:10b6:510:106::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Thu, 26 Sep
 2024 14:33:42 +0000
Received: from SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd]) by SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 14:33:41 +0000
Message-ID: <fb406b93-7c42-42dd-97c7-7799ecae2d2e@cornell.edu>
Date: Thu, 26 Sep 2024 10:33:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] Cygwin: pipe: Switch pipe mode to blocking mode by
 default
To: cygwin-patches@cygwin.com
References: <20240921211508.1196-1-takashi.yano@nifty.ne.jp>
 <0e6831d3-9c46-4467-af45-4f72555ea4ff@cornell.edu>
 <20240926210923.e754c56dc508baeab53f7bd2@nifty.ne.jp>
 <5e5be0c4-a640-4c31-b35c-c3b7583f2388@cornell.edu>
Content-Language: en-US
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <5e5be0c4-a640-4c31-b35c-c3b7583f2388@cornell.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::21) To SN6PR04MB5151.namprd04.prod.outlook.com
 (2603:10b6:805:90::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB5151:EE_|PH0PR04MB8227:EE_
X-MS-Office365-Filtering-Correlation-Id: 856cf9c1-9376-49b4-a280-08dcde383791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0FjdHdaYjlmNFRIY0xrWnp6eThhZG9CWnF5Ky9Qc0JOUy9UejJqdjNyQk1a?=
 =?utf-8?B?L3ZjSW8xUFA1WFRFS25haGpOWi9SQitZaEFXUG10cmFQZERneHRwcUgvdjlu?=
 =?utf-8?B?YlRkdjVsNHFLNzMvaUQzYjdXZllEQmZERzhzOTIvVjVWZmQxQlBMWXdhWGZ5?=
 =?utf-8?B?TFBLTXN4K0U0VGhNK0dyOCt2MUpGNjJGUzZ5ek5xNVFqdC8yNzVyazdVYmtj?=
 =?utf-8?B?UnRZQmxPeXMwUytMSFZHdnFXL2diaFk4ZmhDS2ZMdWJtUUFzN1NBd3piNDVh?=
 =?utf-8?B?azBxZWhLdGYvYmY5eXF5K2RDcVhPMnh5MFFQRUE1NStBUThXQWJ6OVRCZzM1?=
 =?utf-8?B?OEg1RlRwTGxHcEd2Y09aUi9rMnlhT0lUaEpwWHJJV1JnQThZNHVTMnJaK2xN?=
 =?utf-8?B?V3hzZXZ6dW5pdlNZUlRNRWRHLzFnMk1GSXJoNXU3UmpCNlNyT20rcVlWTDhH?=
 =?utf-8?B?WG52QUpmdzhEbzFJMFRPYVYxT2F5bGVtYjBiQTM5UndQR0tUVURDSFd1MTlC?=
 =?utf-8?B?YzlZWDVRTUh3eStMMEUrU1VBUkp1OE5NczJKRTFvNTVnSGtjbVJTRVpGaTA3?=
 =?utf-8?B?WjdmQ2FvOVJJT0Vlckhod3hYNjBiREZjM05pNHdJZ1U1Y3FKc3FrdEQ3T0tV?=
 =?utf-8?B?MmlnMGthaGtJZWlXSUsrNGxFNVo3dktCdENCUWxqN3NmOGZ6cExOYmI1Z3pL?=
 =?utf-8?B?azlVOE1DdHFrckw5MkRwMUFvbFduQnBVaGlyeVdCMzRWZFFGcnVINnc0M0xM?=
 =?utf-8?B?ZE91RzdJU0l1NlpPM0dUaU5Od0EvZGdHVXMydUprVkpVYWs2SXZybkl1di9L?=
 =?utf-8?B?M2tUVTh0V3Z1YjVkUkV3Y21aeHdmOU9QZExabCs3aGxvbEgzOVNuTXdHbmky?=
 =?utf-8?B?UTJIQXM1dFJVdmM1b2szaTdJcnJlMzgwQWY0N3Q5RFdZdWtENmVoVWk3S1A3?=
 =?utf-8?B?OEJMb3RlNlQ4KzAxWTBqdDduRzQ0S2QyYTd5RXlTdUVvOFVzeUJpc3k3ajhP?=
 =?utf-8?B?bmdPRktwYTdRR0pOQWh1UnJQUVJxdVFMZ3dWWmhmRG1IU3RyV2xWY3lVS1lI?=
 =?utf-8?B?VFpLYlhjZEl4SjZNMkpPb2tiM0tTYTdnWDBHMnFwOEEzMElnSkFPMTc5Q1Zz?=
 =?utf-8?B?azZoYXlZSGlxVnd3MTI1UHJqMEsvc0NKcVpuRVdwTVhOV1AzdFdVVDY4T1FR?=
 =?utf-8?B?SWc0OFZUWkxjWWdxQUZ2Skh0aElUYUxDL3hEcmhXUmljdWxhS0E0cEoyc2o2?=
 =?utf-8?B?K1lwNEFnOWVuU2MrbHI3TnI2dTM2ZkhJazlTdXlMYnZlRU45OVJTNUhRU0hT?=
 =?utf-8?B?S0Y5dDIrUEVFVDNIY1hXdXpseU9yUlM2Z3FHVWhFQzdiUlVSYmxQYm9wV24w?=
 =?utf-8?B?SEp4NU5zV01IWEg3MFkrNUdlZGZnSWdRTnl2QmpONEliWXQ0SEI1S1E2dW9Q?=
 =?utf-8?B?R0l6MEVrdkJBQU1jOCtucGo2enB6bkVQS1NNcVlSZUFuRk5YTlFnald5M1pV?=
 =?utf-8?B?ZjZRRXRkR1NDcWhnOVlYNUZCM0R0R2hiYkRldjF4cFBpamNodVY2MUpseDVm?=
 =?utf-8?B?cTRPQWhkZmpjOFFIMU9vSGhuVFkxVUdPcGoxVjR4TG5BWm5WY1RxcTd1eEln?=
 =?utf-8?B?VVdvMmg1ZlQ5S2M3T09JQmJDZWFWQlAzeGlwcXJRZnJhNUIwdFlLVHhZSmFm?=
 =?utf-8?B?eGphaDB2Zm0xL212K2p5eHUwY2RHVWFnM0pTb3cyOFlwbWZJcTVqUElRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB5151.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzRVdXo1Wk1iUU1YdGNwTG14ZEM4amJnbk55ZXJlS1JnbGEyNmQ1Sjdkc1ZQ?=
 =?utf-8?B?bFVlZmsxckJmRExxSWVuMXNVM1Fta2l5VC9vUzg0cVZMTXJ4VjArd0U0d0Fn?=
 =?utf-8?B?czNZOFlWYTB3ZDVOd2dxV2VvYWdGSkxBR1Vtb3VqNmhjTU94RlVxeDF3aXln?=
 =?utf-8?B?S1pwdzZqa1J0dC8vclQrV1dnYm93K0VDVnpGM2lmZGpKcHdKbnlIcy85R3kw?=
 =?utf-8?B?WDFTWTJmR3AzeUJqV05Db0NWTUFWcEE0cktPZ25HYkNocGloUVdTVlRSOEwv?=
 =?utf-8?B?ZmE5UThVKzcxUkwyMnZURU5IN2d5aXh4b3c0bEc4eEl2dDhYZCtUYnkxa2RR?=
 =?utf-8?B?cndMZXJIeVVmalRWcXFkQm9vSmkrSVhsVDl5dUNtY0RjdXFSUnREWUxCMXI4?=
 =?utf-8?B?L05mdG0rZFdPeC83Sk80blltSEFHbDFRZXBlNjdkNnliT1VMSHp1SXhBRzd5?=
 =?utf-8?B?cTI5ZlNJYVJrYUtyTDNLbUVDT2U3bHJ5Q2Y1QWhiVVMva1FPcmhtSW1PVDMw?=
 =?utf-8?B?K0xhbS92b1NoeFZnV3YwTW5FZG5RUVMzSWFsdXd1UnUwMTNHWkZQcmI2RzB6?=
 =?utf-8?B?UlAycFYxWExKVG9JMkdXaU9pcFlHR3FXREpIQmxyUHhETmhlc0FEelRtT0tx?=
 =?utf-8?B?OWg3TzI5RE1CM2pOU0d6Qm1vLzBkMGhZOU9oRzI5RXRZMmpZMHFzb2FaTmNl?=
 =?utf-8?B?ZGUvRnNtSDV4WTl3VHY0aXErWlZrNXpDZWppeEJoNkNlVmFOd01oUVpFdkZT?=
 =?utf-8?B?STVEWW4rRWxBYytZQTRidG91blVVWFhhMWowdTZjeGhMZG1mY2ZOQWF3WVdU?=
 =?utf-8?B?ajVKaHBUMmw4OEFPZzRwUXI4MkJpMWZyVUNOK0FzM0lTSE1oSmJJS21YMkpF?=
 =?utf-8?B?eDBFK2daZS9ab2MyY2wrQ2dIeER5ZHB5aXQrMnZOaVY2RGxmRUlJeldmKzBN?=
 =?utf-8?B?dlNpYjFPUFNTUkZKWDhzeHFxMUdvWi9rRTlJaTNLM2ZVdDJPL1Y1VmUxY0dj?=
 =?utf-8?B?VVk4SDRHNmIyMU9PZjFrdzdnM1g2L2E1QklqWERCTFNIcUtONWxYbERjWExa?=
 =?utf-8?B?N2pGS05HbUluOG9lQmxQZkFEeTZ0aHFVSHNxWFZSWCtDZityVFFQYUFGbytF?=
 =?utf-8?B?QlRmTWFpOW80cXpLMzZHTkRRVkk3azhSTEdxQi9NZ0M1NTNKQSt1eWNxMExE?=
 =?utf-8?B?M3d6TFkzWUdOYy9QWGFxOFhVUFVweTN6SGgrWlFWZXgzRWsvenV4QVhONVdG?=
 =?utf-8?B?M1BISlFMMW9BK084SmRuMW5zbStTVW1BYkJOQWFaMnk1bVNFUWk1TVRLdFY3?=
 =?utf-8?B?M01kV2xPUlBoMWlHb0ViazFpR2VENU5NZkNwclNScENVbitWSFVWYWkrMUtl?=
 =?utf-8?B?Tkd1Y2dnbjh4UkFaY28rY1hlSkFTQkdjSVNHMG01S0pIcHZua1BwVHJsenRp?=
 =?utf-8?B?OGpKeEROOUEwYkFVUGpyU0NWSjlDdG96RkozWHNNYkVmTXoyMlBCLzFxWURn?=
 =?utf-8?B?OFF2c1dtRzlXajFNV2RCV0kzZk51cklqb29ITjdNazdCT3pTZ1dWWXFldTMr?=
 =?utf-8?B?UmxwWjg4aGFSY2VvTC9oNGV0T2hYck43SVhwTDZBYVh2MXhMT0t2NkI2L0ZV?=
 =?utf-8?B?Rlc5Y2RtL1RGb29WQTRhQ1ZMSHF6MzExaHQxWlhURWRWQURZZkNLVlZ1aG9n?=
 =?utf-8?B?bEI2WWRORklxYk9JMWZuc3dHdFZQaDZrOUw4TlJVaGYybHBWQitYR1dPNWVa?=
 =?utf-8?B?a0ZaTDF3NG1VbU1LZVJjb3B3TU9TOUhRZXBxVXlNemxUWkozUWJ0a1ZwdDR5?=
 =?utf-8?B?RFQzYkFCZEtrSzlLcExWeEF6MHpkaU5MbFE4S09FVTRzYXBEVldTOHZRdHJa?=
 =?utf-8?B?ZFBxNk1YN3RBZk56Rm5uMHlNZXN2bnJXajBNTnU4VUhNREVNNUJSSzlmRUI3?=
 =?utf-8?B?QXQreVIzZmdNaTU3UG44UDEwWTBTbmJIeU8wOVBHWStGNEhpbnliVGFCTXdK?=
 =?utf-8?B?MDhkcnZla09UMWRmeWpqOVMvelJ4NllGWWdEZzV4Q3lXMHI5eisxUWllRVph?=
 =?utf-8?B?R2lMMEpYaklULyt6UGttWGJtYmhCb1h5ci9ZRlZza1VlV0d2cDAzZERId1dr?=
 =?utf-8?Q?jj/nbTsxhR8qNWxY3MfAXx9XQ?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 856cf9c1-9376-49b4-a280-08dcde383791
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB5151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 14:33:41.2705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y9DGV5v8V3AuZzl/WJAhekkyydfsZfBUhY0wmtPGayiam8/Yrz/eQHDrqOJ8o8/1KYizEjy9WBaUZ8j95XL8aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8227
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,BODY_8BITS,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,JMQ_SPF_NEUTRAL,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 9/26/2024 10:32 AM, Ken Brown wrote:
> On 9/26/2024 8:09 AM, Takashi Yano wrote:
>> On Wed, 25 Sep 2024 16:11:12 -0400
>> Ken Brown wrote:
>>> On 9/21/2024 5:15 PM, Takashi Yano wrote:
>>>> Previously, cygwin read pipe used non-blocking mode although non-
>>>> cygwin app uses blocking-mode by default. Despite this requirement,
>>>> if a cygwin app is executed from a non-cygwin app and the cygwin
>>>> app exits, read pipe remains on non-blocking mode because of the
>>>> commit fc691d0246b9. Due to this behaviour, the non-cygwin app
>>>> cannot read the pipe correctly after that. Similarly, if a non-
>>>> cygwin app is executed from a cygwin app and the non-cygwin app
>>>> exits, the read pipe mode remains on blocking mode although cygwin
>>>> read pipe should be non-blocking mode.
>>>>
>>>> These bugs were provoked by pipe mode toggling between cygwin and
>>>> non-cygwin apps. To make management of pipe mode simpler, this
>>>> patch has re-designed the pipe implementation. In this new
>>>> implementation, both read and write pipe basically use only blocking
>>>> mode and the behaviour corresponding to the pipe mode is simulated
>>>> in raw_read() and raw_write(). Only when NtQueryInformationFile
>>>> (FilePipeLocalInformation) fails for some reasons, the raw_read()/
>>>> raw_write() cannot simulate non-blocking access. Therefore, the pipe
>>>> mode is temporarily changed to non-blocking mode.
>>>>
>>>> Moreover, because the fact that NtSetInformationFile() in
>>>> set_pipe_non_blocking(true) fails with STATUS_PIPE_BUSY if the pipe
>>>> is not empty has been found, query handle is not necessary anymore.
>>>> This allows the implementation much simpler than before.
>>>>
>>>> Addresses: https://github.com/git-for-windows/git/issues/5115
>>>> Fixes: fc691d0246b9 ("Cygwin: pipe: Make sure to set read pipe non- 
>>>> blocking for cygwin apps.");
>>>> Reported-by: isaacag, Johannes Schindelin <Johannes.Schindelin@gmx.de>
>>>> Reviewed-by: Corinna Vinschen <corinna@vinschen.de>, Ken Brown 
>>>> <kbrown@cornell.edu>
>>>> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
>>>> ---
>>>>    winsup/cygwin/dtable.cc                 |   5 +-
>>>>    winsup/cygwin/fhandler/pipe.cc          | 657 +++++++ 
>>>> +----------------
>>>>    winsup/cygwin/local_includes/fhandler.h |  44 +-
>>>>    winsup/cygwin/local_includes/sigproc.h  |   1 -
>>>>    winsup/cygwin/select.cc                 |  46 +-
>>>>    winsup/cygwin/sigproc.cc                |  10 -
>>>>    winsup/cygwin/spawn.cc                  |   4 -
>>>>    7 files changed, 252 insertions(+), 515 deletions(-)
>>> LGTM, but it's complicated enough that I could have missed something.
>>> It will clearly need lots of testing.
>>>
>>> One trivial suggestion: For clarity, you should probably add the
>>> initialization of pipe_mtx to the fhandler_pipe_fifo constructor,
>>> although I think it's initialized to NULL by default.  Also, it wouldn't
>>> hurt to add a comment in fhandler.h that pipe_mtx is only used in the
>>> pipe case, i.e., it remains NULL for fifos.
>>
>> Thank you for reviewing and advice.
>> Do you mean testing enough before push? Or testing in the 3.6 branch
>> before release?
> 
> I was thinking mainly about testing before pushing.

Sorry, I meant to say testing in the 3.6 branch after pushing.

>> Anyway, I'd like to wait corinna before push.
> Good idea.
> 
> Ken

