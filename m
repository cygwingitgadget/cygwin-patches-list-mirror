Return-Path: <SRS0=8JuP=TU=cornell.edu=kbrown@sourceware.org>
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c105::7])
	by sourceware.org (Postfix) with ESMTPS id 04B763858CDB
	for <cygwin-patches@cygwin.com>; Fri, 27 Dec 2024 16:46:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 04B763858CDB
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 04B763858CDB
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c105::7
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1735317998; cv=pass;
	b=ap7HBLsxe+ku5/lH0fH7XUmcn8vI9zVvCxBUN7XkOLevOhHUdKp5qEJ+ESu+cu7HPmlmrmpV0rY9RpaZXnzJ4OQEF029j3HxIB7EYpU48yIjejLmcXhWUchKB8hlgrl9XwzOs6pdFjiidUTyAHoWhQZPH9WzGbtvf15cKSE+ejs=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1735317998; c=relaxed/simple;
	bh=OkVuDZYreL6GvprNzk3lCA9kaY4HgEFJNVuSVNNHdhI=;
	h=DKIM-Signature:Message-ID:Date:To:From:Subject:MIME-Version; b=QEd5nDhFuHnz/NfcaRiHRRMbZKajkQCycEm9FF2GAnuznXQ8GfHLbnkWDQEkJ7G8Q4RUX+aguV6gfhhnZzF1MVaCoRVc0i5c0in0TV93ek9iscfVsud3LQraZLSPFCXMHcbSs1IoHimBg6sHBMtGIOY4FYNE/hnw52bFNFBPxwo=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 04B763858CDB
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=cornell.edu header.i=@cornell.edu header.a=rsa-sha256 header.s=selector2 header.b=JzDy5MVJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jNWv9XkrBW2N6gk9fE4HXQOMN8kqQYfcPUalnpf+423nGGM6pgjibGMPxWQveas1tB/Qk4tjlT33PnOThMP/bW/stafBBlLM5zaNoVf92BoDbHJ+0El70cXtnh0cim1Vhlj4xCgqHDaQ7P3yaWRjJkkl3Luz5cbS/5ZP6hsZoo8PCRbVYFHG+mkt3JZNz3+y/SDX/IrtzrcD3mvYgVCaK4wmFV1wPDMgrBnJWX91B3DplZ/G+xixil7Ittc1VwaxfJxMSCZmCegGKrH78RDuYPCVq42yYfUw2+y41mUieTZ2hS6vIXeHueRLnflzGninZKUjtTGKw0dzHV54KNrPLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdvm/8EBVoCs0RShyRIG1aF8cOUDRBO2H9AhCeGdTy0=;
 b=ZVqitAxUaQwnDpn4m22NpcoIQCUYlX4mzPW9C0z9NpK7Jt9Kzg0RFX5q+4kCkP+niajn+gLDOFdjO51YuU7WUSESncDXOJHQIuhILt4vxcbUBT/shtlgLBto/YwVdWs5exP8PPbTLzz191cwd/1ZVSr8g6BCSRwBRirYFSNo/2I0XUDgf7he0QATynD3P2ewJFDl5AuWOuuunr7r8vsWbiyLJamdbG9MdVGi0dVipFZVUTOQoV/XHSiCOkMs8YDDRth4eQ2dGJTuIK3US7J0/QsGmQxJHJxn8ROVpNX11T0chQy+fAU4529VPZBPs6IptJZF14x322mUgXvh6ZzDqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdvm/8EBVoCs0RShyRIG1aF8cOUDRBO2H9AhCeGdTy0=;
 b=JzDy5MVJDer8Exaf5XqjeNHv/Gibd5172neaZpuVRzJd9WU63m1zFyEMSvjv7Vp388GQ203AoNzKPajz4Bbi9nNEZ3CKg7N+6GDGGQ2+oK3lVvVBIXyO0kvaWYkn45HFvLOMBSURnPumBSoT7MiLVp/Nl87cnGFjqBjamqKxcRs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from SN6PR04MB5151.namprd04.prod.outlook.com (2603:10b6:805:90::25)
 by DM6PR04MB6623.namprd04.prod.outlook.com (2603:10b6:5:1bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Fri, 27 Dec
 2024 16:46:31 +0000
Received: from SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd]) by SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd%6]) with mapi id 15.20.8272.013; Fri, 27 Dec 2024
 16:46:30 +0000
Content-Type: multipart/mixed; boundary="------------ATNoYVH33lo0pwYNbZzbYZnO"
Message-ID: <c1839ef1-b250-4316-8e00-a8e2d73fdcca@cornell.edu>
Date: Fri, 27 Dec 2024 11:46:26 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: cygwin-patches@cygwin.com
From: Ken Brown <kbrown@cornell.edu>
Subject: [PATCH v2] Cygwin: mmap: fix mmap_is_attached_or_noreserve
X-ClientProxiedBy: BLAP220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::9) To SN6PR04MB5151.namprd04.prod.outlook.com
 (2603:10b6:805:90::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB5151:EE_|DM6PR04MB6623:EE_
X-MS-Office365-Filtering-Correlation-Id: a0ec1a66-27cc-4518-fb68-08dd2696034d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aklBbG5yRTBPcHBFZmZhWkprZFF1NFBxRTFKTWwvSThtaXluLzlJa3BwYWcy?=
 =?utf-8?B?dng2SEpNSzVuRTNWTG5sUHVTVktBbzZld0ZjZExHUXJmMURNTUVuK3AwVFRM?=
 =?utf-8?B?K0FRRFdacjU2MzhieGh3Z3dKK2hHUDUwWUhRVzNnOFpLVlkzRzc1OFFMT1A4?=
 =?utf-8?B?QlZ0NTc5V2pVbnRJMzdzb0tMQi90eXZKK21HclNKL01PcUNJN1lEQ0JTeEsw?=
 =?utf-8?B?eVB6VjJoNU01c3dLNzd3cUtuSUQ3Q0dMQjlQVWVGUTJMdjFmcGcyeWxldTdR?=
 =?utf-8?B?L3RuUlpZQWhpY1orM1p0alBxMEtBTlN4Vm1aSGVPczM3SU9udzBzMXJPTmlE?=
 =?utf-8?B?SU44RHExSTIrZ2EvMXZQVXl4Snc4RDVkeEhsRit5WnJSVko4eXE2ZnNsQ1Vy?=
 =?utf-8?B?ZytCSjhQM3hXaEZCMkQxWjRWZ3FqNENmSWdiZ2l4VnlHN3lFMmtjTWNSNitO?=
 =?utf-8?B?SmN4U0k5SHJpeDAyWGZmeWY5cmY5WDJjWnhXNHN4NGgrQUdBWG55L1hXYkdK?=
 =?utf-8?B?NGZjRVFyWC81cWZPWGIvTng1bUxQV1dXcFZ2cHQ3c2xkL09MaXJFK3VCNmt4?=
 =?utf-8?B?SFM2Y1V3Q3l1dVhPTUpqeko0cTBNblZFakljVDBmUTNmQVRGN2lXTTlDR01j?=
 =?utf-8?B?T0lWaGUrRC9ZRndmZUs2eENBempsK05aODErZzJDdWpwZVpEVlZ4MHM4TEJ4?=
 =?utf-8?B?cFZXRGgxc0VMT3VWL0hQV2F5TWlRclFDM2drenFzWjlpZFE1aDFjSjNXNldB?=
 =?utf-8?B?bW5qa0EvSEYvK0NzUVZYV0xaYlhFcVB1UE9YUjZiL0NsUUJIRUh6SUNwbU1W?=
 =?utf-8?B?dExiYWdTLytyd1A2alZSUmZCOU5JYUY3OHdMWGZEcGlqNnRTS0tuQmtIYWRo?=
 =?utf-8?B?MnJlR0pIdnA4Tm85d1luL205RHE3b0w0M0FqV2w5T3pMZmJkeVJsUFNERHFx?=
 =?utf-8?B?dG5heFpDS09zamhrV3NUdi9pR0c5ZEYxUWtCR1FKMDllSStLNStiRy9vVDZl?=
 =?utf-8?B?WFAzVzhPeHlsZlVudGhNbWVNQzVzcmZqc2hZZ0hjeUxDQlpad3pwQTRrejh6?=
 =?utf-8?B?Y3hDNXBrcVJVSE12REk1cWZvc1FhWXZhanhlcVB3YlFzcE1FNm9VS3hmbE1D?=
 =?utf-8?B?UjhXVGl4YlZWbGVKcXpqcFhMVzMraUhlcU1ZSjdhSWswanZpZWRqUDVXajFv?=
 =?utf-8?B?UjF0ckVHeHlQaUVjRmxia2xkSEhZWGsxYmRDdkN3N3NQQVkrMmt2bmdOaWE2?=
 =?utf-8?B?a2dCUEJQZUIrMFphN1JiMlJRVlVjbTlQUkV3M3BIcTl6QWY1aEhyaVV1b0Y1?=
 =?utf-8?B?RFdLWDJyYW9Ed3o2aGNMUmdBSzlnUUJYMVdxZUcwK3oxeWdyZzZFYzFLTEdY?=
 =?utf-8?B?Vm5ITk5ZUEFDNDZlQTk3MjhrWHRZdjVGZ0hWdHNXOE94OEE5OUpuUW9HMzhG?=
 =?utf-8?B?eGVsdnF6bnJRbjVnbC82RUdyNHUrREgwb29KMVNWWUdqaEFGdzlXbFBuK2hZ?=
 =?utf-8?B?ak5pamNlNUljK3BqTUd5YWpjZ2FLRUlGZ2dmVUpSRkdJYmRHTHg2YlVBQVhF?=
 =?utf-8?B?TWU0MjZHcEN6ck1ZQjFJQVZ6ZU1JUFh1UWZSa0VHU1hjQ3B4MGxWcThrbldp?=
 =?utf-8?B?R3NEd0EwblkrbkZ4RmE1L1pZbEN6OXFpMHNiT0RxVEJpbU8xYWd5UDh1alk1?=
 =?utf-8?B?Y2VLL2l5R1JKSG16NGJzbjk4UFZDTzNudzI0U25SL3ZIeXhPWkJKMWEwVUE5?=
 =?utf-8?B?cWdESWhxNkJMVmFweVo1R1V6OFZqWXJZQmpxODJGSmlXWXhaelpUb04vMjZX?=
 =?utf-8?B?RnZRcmNCQ1dUSTE0SFdpZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB5151.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3ZRaUNFc054VEU5NzAzN2xqcHNaWklFd0pJbFpZQjZ1WERqUzRBd3ljamNW?=
 =?utf-8?B?U2tFVStYMXRkNVNybHVpOWE2MzBHczhtRVhoNm5palp5ekVPc1FOMUsySHVr?=
 =?utf-8?B?YVRBbEJNb1QzZUtZVWxmQzBCaDBiRzI2aGV0dVhTT0tPSmQ0WCtwVDFxLzBj?=
 =?utf-8?B?Q3l2cUtrMFJRRGh2aFE1cnpCMm1YUGZHUnZpMGpzZWw5dSttTm95eWc4ZG45?=
 =?utf-8?B?Zlc2bVFpaVNmeU9ENVYwbCtVVnZudGZtbG1QeXN6cmczc21qM3g1UHVSa1Z1?=
 =?utf-8?B?TnJxZGV1dk1XVThodUJZUHNTUVJTeTBFZGlqYWY0YVNQcENKQmJTUTcwMUlY?=
 =?utf-8?B?LzVxY1J1dzZwcHRmZm5hdy9MWFhCMk9xeVFoUm9paWRiczBRZXR5TUVqWUcz?=
 =?utf-8?B?RUZFQ05iTWVWRjBzV2lNKzF5VHFsU2JGaHp1SmR2YWNPZ2tMWFp4U2V4Um5F?=
 =?utf-8?B?VVZHTzFLMzByZXY3Nk9mcUx6REFZK3BqZjNMc24xUWcrbTRzdURJOU9NMHly?=
 =?utf-8?B?ZFBFK0xUcm5iSFVIV0dQWDI1TWxVSUdsM2dCYnZsYTJzbEI5QUZQaFQxbVVC?=
 =?utf-8?B?bzhPZ3NUcXc1VjAwWU1pZ3pjRzdRZzBGZnlKTUpjMVlDZy8rd3dYTEl3dGJV?=
 =?utf-8?B?OXdCYnJrN2JVZGlHcHV4eDBFMGZ1WkI2Qk5DNVRJWDZna1RTMEFTOXFQSys0?=
 =?utf-8?B?YUxvR0FTLzByYUhqM0FtcFEybUJNcFhCeDY2ZkRTU0N1WkdjUnFzSzBZSnBy?=
 =?utf-8?B?SVB5ZHRoYUd4MG9xcXI0eHFIc0FFOU9GSDAzN3lqT1NHbWhoSHZXMVo0MjdR?=
 =?utf-8?B?T2VoOFF1SGlmendoMkxrb3R2TnBRbFR2aEgySDN2K055NkdmMmc3d2s5L1Ba?=
 =?utf-8?B?MGNaOWZxNjUvV0N3dSttbUhSSlRNQlVoc2hMSlVQajJWTWg1aGwzWWRVcWNB?=
 =?utf-8?B?QzdudFVGTEttMjh2L1EzL2pXMC9HSXlFYm9sZHA5M2RJWHZHSTQxakhqZ2FR?=
 =?utf-8?B?QUQ3RjlZN01zK0hQWjIxSE1iaWZCa25qMURWOWJJdmpIelBLYnU3c1dvY3B1?=
 =?utf-8?B?ZXl0Y0lIaEROZ0lWbi9Ob0diNXNJUFEyT3VUTDkrcDVOV0cxTXVPbFRidHc1?=
 =?utf-8?B?eGd5Mjc2eDR4b1N6TVZaWlRIQlVNWGhlWkNEOW1NYkptS05qajNhSVBsekll?=
 =?utf-8?B?U1Q5cVlvT1F6dUlCNHp2anI3MFAwQjhYbjUvWmtjeU1qbFZvRkEwRUhxV1ZO?=
 =?utf-8?B?SGNUcjdrcytxc0ROZkpxR2NkOXdoYklOV04zeWwxZ3lKK1N2WGYwM3FPR1N1?=
 =?utf-8?B?VGxoc0xnVDlzQzNVbjdxeElOL1lDS3hyNWRnYTFXZVBHMUszZkdQV3QwSGJO?=
 =?utf-8?B?NUpOOURIZS9RMGhDL1hEbEdVd3FnbHJkeTFpVHk5eGlWMEtPRitCbUxOZVgx?=
 =?utf-8?B?UzRNZWJkbHRXMnJnMk1SaHE0K29JVTZTOWJSbStuL3lQaTNzNG5JeXlvazlj?=
 =?utf-8?B?VVY4MGo4cEkxZ1BGbjhEVUtjb2t1UkRzbjRpWTF6NXdmZHB4aWRLcTA5eVky?=
 =?utf-8?B?Vi9SUjRaSE5ZRk03aWU0QU4vS3hSUUdVM2MzRTdHSVVtK1Y0bFZ1NVFjUEFT?=
 =?utf-8?B?cFM2KzcxbFZwUDJQZU1PTU40aHNZTVc0U3N2YTBMVFR3bWRQdnRJekVBeWJx?=
 =?utf-8?B?TmFaZDNiQnN0bGovZnNKc1J4SHEzM05DS0FkVFp4Q3pybm9mWVFkODExK0Rn?=
 =?utf-8?B?a2RaOGl5V2h0aUJJaUdac3FVTng1VlJlWVFTNFhrT2Qvb01ZR0NCaHJUdmVr?=
 =?utf-8?B?TVZRY2NSRkZGcHNaMElHbjJkM0RaMURvMkFyY0UzZWMvZElsdXY4cVZuKzRv?=
 =?utf-8?B?NGJzMm9kSlNra1hENmh0a20rd1M0SERLWDg3U1JQOVFsWXVSV0NUNnBMZlBH?=
 =?utf-8?B?Z0hyTlNaUHlBalAxODVjRzlhc3JkZzc2aFd5ZmFDWVQyKytmc3B4Ty9GYmtK?=
 =?utf-8?B?Z1N6WFJzenhHMUNFSmQybXc0ODQ3aExibjJleGcwdC9hbUdQUVdLU3pYNzh1?=
 =?utf-8?B?Sy8vcm9RU0QvQUtJSEtxcE9GTTVwSFRjNXJ4a3ZtSmRSWTcxV2Q0SVBkOGpy?=
 =?utf-8?Q?ZStv/CU7ZkGUGcldw9G8jwttT?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ec1a66-27cc-4518-fb68-08dd2696034d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB5151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2024 16:46:30.0317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 78R60LPx+6pX1r/MQR6iGYE2wKOcM0yO4xDxkPnV0YEEve3pW9OEp153nN/hcol+SiszrFVm9CBTrew0It7Lyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6623
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,JMQ_SPF_NEUTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--------------ATNoYVH33lo0pwYNbZzbYZnO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Patch attached.  This version is much simpler and more efficient than 
the previous one because it doesn't require keeping an mmap_list in a 
specific order.

With this patch installed, the two test cases in

   https://cygwin.com/pipermail/cygwin-developers/2024-December/012725.html

both succeed.

I have a question about the "Fixes" line.  Since the commit in question 
was in the old CVS style, it doesn't have a good one-line summary.  I 
tried to choose the next-best thing, but I'm not sure about it.

Ken
--------------ATNoYVH33lo0pwYNbZzbYZnO
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-mmap-fix-mmap_is_attached_or_noreserve.patch"
Content-Disposition: attachment;
 filename="0001-Cygwin-mmap-fix-mmap_is_attached_or_noreserve.patch"
Content-Transfer-Encoding: base64

RnJvbSA2NTAxODI0MDAwYjRlMjFiZWM0ZDkzMmE2ZDg0OGJkODlkZDg3Y2EzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLZW4gQnJvd24gPGticm93bkBjb3JuZWxsLmVkdT4KRGF0ZTog
RnJpLCAyNyBEZWMgMjAyNCAxMDoxMDowNiAtMDUwMApTdWJqZWN0OiBbUEFUQ0ggdjJdIEN5Z3dp
bjogbW1hcDogZml4IG1tYXBfaXNfYXR0YWNoZWRfb3Jfbm9yZXNlcnZlCgpUaGlzIGNvbW1pdCBm
aXhlcyB0d28gcHJvYmxlbXMuICBUaGUgZmlyc3QgaXMgdGhhdAptbWFwX2lzX2F0dGFjaGVkX29y
X25vcmVzZXJ2ZSB3b3VsZCBzb21ldGltZXMgY2FsbCBWaXJ0dWFsQWxsb2Mgd2l0aApNRU1fQ09N
TUlUIG9uIGFkZHJlc3MgcmFuZ2VzIHRoYXQgd2VyZSBub3Qga25vd24gdG8gaGF2ZSBNRU1fUkVT
RVJWRQpzdGF0dXMuICBUaGVzZSBjYWxscyBjb3VsZCBmYWlsLCBjYXVzaW5nIFNJR0JVUyB0byBi
ZSByYWlzZWQKaW5jb3JyZWN0bHkuICBTZWUKCiAgaHR0cHM6Ly9jeWd3aW4uY29tL3BpcGVybWFp
bC9jeWd3aW4tZGV2ZWxvcGVycy8yMDI0LURlY2VtYmVyLzAxMjcyNS5odG1sCgpmb3IgZGV0YWls
cy4gIEZpeCB0aGlzIGJ5IGNhbGxpbmcgVmlydHVhbEFsbG9jIG9ubHkgb24gdGhlIHBhcnQgb2Yg
dGhlCmFkZHJlc3MgcmFuZ2UgdGhhdCdzIGNvbnRhaW5lZCBpbiB0aGUgY3VycmVudCBtbWFwX3Jl
Y29yZC4KClRoZSBzZWNvbmQgcHJvYmxlbSBpcyB0aGF0IHRoZSBjb2RlIHdvdWxkIHNvbWV0aW1l
cyBicmVhayBvdXQgb2YgdGhlCm1haW4gbG9vcCB3aXRob3V0IGtub3dpbmcgd2hldGhlciBhdHRh
Y2hlZCBtYXBwaW5ncyBzdGlsbCBvY2N1ciBsYXRlcgppbiB0aGUgbW1hcF9saXN0LiAgVGhpcyBj
b3VsZCBjYXVzZSBTSUdCVVMgdG8gbm90IGJlIHJhaXNlZCB3aGVuIGl0CnNob3VsZCBiZS4gIEZp
eCB0aGlzIGJ5IHVzaW5nICJjb250aW51ZSIgcmF0aGVyIHRoYW4gImJyZWFrIi4gIEZvcgplZmZp
Y2llbmN5LCBpbnRyb2R1Y2UgYSBib29sZWFuIHZhcmlhYmxlICJub2NvdmVyIiB0aGF0J3Mgc2V0
IHRvIHRydWUKaWYgd2UgZGlzY292ZXIgdGhhdCB0aGUgYWRkcmVzcyByYW5nZSBjYW5ub3QgYmUg
Y292ZXJlZCBieSBub3Jlc2VydmUKbW1hcCByZWdpb25zLgoKQWRkcmVzc2VzOgpodHRwczovL2N5
Z3dpbi5jb20vcGlwZXJtYWlsL2N5Z3dpbi1kZXZlbG9wZXJzLzIwMjQtRGVjZW1iZXIvMDEyNzI1
Lmh0bWwKRml4ZXM6IDcwZTQ3NmQyN2JlOCAoIiogaW5jbHVkZS9jeWd3aW4vdmVyc2lvbi5oOiBC
dW1wIERMTCB2ZXJzaW9uIHRvCjEuNy4wIikKU2lnbmVkLW9mZi1ieTogS2VuIEJyb3duIDxrYnJv
d25AY29ybmVsbC5lZHU+Ci0tLQogd2luc3VwL2N5Z3dpbi9tbS9tbWFwLmNjIHwgNTIgKysrKysr
KysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDMwIGlu
c2VydGlvbnMoKyksIDIyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4v
bW0vbW1hcC5jYyBiL3dpbnN1cC9jeWd3aW4vbW0vbW1hcC5jYwppbmRleCAxMzQxOGQ3ODJiYWYu
LmZjMTI2YTg3MDcyYSAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9tbS9tbWFwLmNjCisrKyBi
L3dpbnN1cC9jeWd3aW4vbW0vbW1hcC5jYwpAQCAtNzM4LDE4ICs3MzgsMTggQEAgaXNfbW1hcHBl
ZF9yZWdpb24gKGNhZGRyX3Qgc3RhcnRfYWRkciwgY2FkZHJfdCBlbmRfYWRkcmVzcykKIAogLyog
VGhpcyBmdW5jdGlvbiBpcyBjYWxsZWQgZnJvbSBleGNlcHRpb25faGFuZGxlciB3aGVuIGEgc2Vn
bWVudGF0aW9uCiAgICB2aW9sYXRpb24gaGFzIG9jY3VycmVkLiAgSXQgc2hvdWxkIGFsc28gYmUg
Y2FsbGVkIGZyb20gYWxsIEN5Z3dpbgotICAgZnVuY3Rpb25zIHRoYXQgd2FudCB0byBzdXBwb3J0
IHBhc3Npbmcgbm9yZXNlcnZlIG1tYXAgcGFnZSBhZGRyZXNzZXMKLSAgIHRvIFdpbmRvd3Mgc3lz
dGVtIGNhbGxzLiAgSW4gdGhhdCBjYXNlLCBpdCBzaG91bGQgYmUgY2FsbGVkIG9ubHkgYWZ0ZXIK
LSAgIGEgc3lzdGVtIGNhbGwgaW5kaWNhdGVzIHRoYXQgdGhlIGFwcGxpY2F0aW9uIGJ1ZmZlciBw
YXNzZWQgaGFkIGFuCi0gICBpbnZhbGlkIHZpcnR1YWwgYWRkcmVzcyB0byBhdm9pZCBhbnkgcGVy
Zm9ybWFuY2UgaW1wYWN0IGluIG5vbi1ub3Jlc2VydmUKLSAgIGNhc2VzLgorICAgZnVuY3Rpb25z
IHRoYXQgd2FudCB0byBzdXBwb3J0IHBhc3Npbmcgbm9yZXNlcnZlIChhbm9ueW1vdXMpIG1tYXAK
KyAgIHBhZ2UgYWRkcmVzc2VzIHRvIFdpbmRvd3Mgc3lzdGVtIGNhbGxzLiAgSW4gdGhhdCBjYXNl
LCBpdCBzaG91bGQgYmUKKyAgIGNhbGxlZCBvbmx5IGFmdGVyIGEgc3lzdGVtIGNhbGwgaW5kaWNh
dGVzIHRoYXQgdGhlIGFwcGxpY2F0aW9uCisgICBidWZmZXIgcGFzc2VkIGhhZCBhbiBpbnZhbGlk
IHZpcnR1YWwgYWRkcmVzcyB0byBhdm9pZCBhbnkKKyAgIHBlcmZvcm1hbmNlIGltcGFjdCBpbiBu
b24tbm9yZXNlcnZlIGNhc2VzLgogCiAgICBDaGVjayBpZiB0aGUgYWRkcmVzcyByYW5nZSBpcyBh
bGwgd2l0aGluIG5vcmVzZXJ2ZSBtbWFwIHJlZ2lvbnMuICBJZiBzbywKICAgIGNhbGwgVmlydHVh
bEFsbG9jIHRvIGNvbW1pdCB0aGUgcGFnZXMgYW5kIHJldHVybiBNTUFQX05PUkVTRVJWRV9DT01N
SVRFRAotICAgb24gc3VjY2Vzcy4gIElmIHRoZSBwYWdlIGhhcyBfX1BST1RfQVRUQUNIIChTVVN2
MyBtZW1vcnkgcHJvdGVjdGlvbgotICAgZXh0ZW5zaW9uKSwgb3IgaWYgVmlydHVhbEFsbG9jIGZh
aWxzLCByZXR1cm4gTU1BUF9SQUlTRV9TSUdCVVMuCi0gICBPdGhlcndpc2UsIHJldHVybiBNTUFQ
X05PTkUgaWYgdGhlIGFkZHJlc3MgcmFuZ2UgaXMgbm90IGNvdmVyZWQgYnkgYW4KLSAgIGF0dGFj
aGVkIG9yIG5vcmVzZXJ2ZSBtYXAuCisgICBvbiBzdWNjZXNzLiAgSWYgc29tZSBwYWdlIGluIHRo
ZSBhZGRyZXNzIHJhbmdlIGhhcyBfX1BST1RfQVRUQUNICisgICAoU1VTdjMgbWVtb3J5IHByb3Rl
Y3Rpb24gZXh0ZW5zaW9uKSwgb3IgaWYgVmlydHVhbEFsbG9jIGZhaWxzLAorICAgcmV0dXJuIE1N
QVBfUkFJU0VfU0lHQlVTLiAgT3RoZXJ3aXNlLCByZXR1cm4gTU1BUF9OT05FIGlmIHRoZQorICAg
YWRkcmVzcyByYW5nZSBpcyBub3QgY292ZXJlZCBieSBub3Jlc2VydmUgbWFwcy4KIAogICAgT24g
TUFQX05PUkVTRVJWRV9DT01NSVRFRCwgdGhlIGV4ZWNlcHRpb24gaGFuZGxlciBzaG91bGQgcmV0
dXJuIDAgdG8KICAgIGFsbG93IHRoZSBhcHBsaWNhdGlvbiB0byByZXRyeSB0aGUgbWVtb3J5IGFj
Y2Vzcywgb3IgdGhlIGNhbGxpbmcgQ3lnd2luCkBAIC03NjgsMTIgKzc2OCwxNiBAQCBtbWFwX2lz
X2F0dGFjaGVkX29yX25vcmVzZXJ2ZSAodm9pZCAqYWRkciwgc2l6ZV90IGxlbikKICAgbGVuICs9
ICgoY2FkZHJfdCkgYWRkciAtIHN0YXJ0X2FkZHIpOwogICBsZW4gPSByb3VuZHVwMiAobGVuLCBw
YWdlc2l6ZSk7CiAKLSAgaWYgKG1hcF9saXN0ID09IE5VTEwpCi0gICAgZ290byBvdXQ7Ci0KICAg
bW1hcF9yZWNvcmQgKnJlYzsKICAgY2FkZHJfdCB1X2FkZHI7CiAgIFNJWkVfVCB1X2xlbjsKKyAg
Lyogbm9jb3ZlciBpcyBzZXQgdG8gdHJ1ZSBpZiB3ZSBkaXNjb3ZlciB0aGF0IG91ciBhZGRyZXNz
IHJhbmdlCisgICAgIGNhbm5vdCBiZSBjb3ZlcmVkIGJ5IG5vcmVzZXJ2ZSBtbWFwIHJlZ2lvbnMu
ICovCisgIGJvb2wgbm9jb3ZlciA9IGZhbHNlOworICBzaXplX3QgcmVtYWluaW5nID0gbGVuOwor
CisgIGlmIChtYXBfbGlzdCA9PSBOVUxMKQorICAgIGdvdG8gb3V0OwogCiAgIExJU1RfRk9SRUFD
SCAocmVjLCAmbWFwX2xpc3QtPnJlY3MsIG1yX25leHQpCiAgICAgewpAQCAtNzg0LDIzICs3ODgs
MjcgQEAgbW1hcF9pc19hdHRhY2hlZF9vcl9ub3Jlc2VydmUgKHZvaWQgKmFkZHIsIHNpemVfdCBs
ZW4pCiAJICByZXQgPSBNTUFQX1JBSVNFX1NJR0JVUzsKIAkgIGJyZWFrOwogCX0KLSAgICAgIGlm
ICghcmVjLT5ub3Jlc2VydmUgKCkpCi0JYnJlYWs7CisgICAgICBpZiAobm9jb3ZlcikKKwkvKiBX
ZSBuZWVkIHRvIGNvbnRpbnVlIGluIGNhc2Ugd2UgZW5jb3VudGVyIGFuIGF0dGFjaGVkIG1tYXAK
KwkgICBsYXRlciBpbiB0aGUgbGlzdC4gKi8KKwljb250aW51ZTsKIAotICAgICAgc2l6ZV90IGNv
bW1pdF9sZW4gPSB1X2xlbiAtIChzdGFydF9hZGRyIC0gdV9hZGRyKTsKLSAgICAgIGlmIChjb21t
aXRfbGVuID4gbGVuKQotCWNvbW1pdF9sZW4gPSBsZW47CisgICAgICBpZiAoIXJlYy0+bm9yZXNl
cnZlICgpKQorCXsKKwkgIG5vY292ZXIgPSB0cnVlOworCSAgY29udGludWU7CisJfQogCi0gICAg
ICBpZiAoIVZpcnR1YWxBbGxvYyAoc3RhcnRfYWRkciwgY29tbWl0X2xlbiwgTUVNX0NPTU1JVCwK
LQkJCSByZWMtPmdlbl9wcm90ZWN0ICgpKSkKKyAgICAgIC8qIFRoZSBpbnRlcnZhbCBkZXRlcm1p
bmVkIGJ5IHVfYWRkciBhbmQgdV9sZW4gaXMgdGhlIHBhcnQgb2YKKwkgb3VyIGFkZHJlc3MgcmFu
Z2UgY29udGFpbmVkIGluIHRoZSBtbWFwIHJlZ2lvbiBvZiByZWMuICAqLworICAgICAgaWYgKCFW
aXJ0dWFsQWxsb2MgKHVfYWRkciwgdV9sZW4sIE1FTV9DT01NSVQsIHJlYy0+Z2VuX3Byb3RlY3Qg
KCkpKQogCXsKIAkgIHJldCA9IE1NQVBfUkFJU0VfU0lHQlVTOwogCSAgYnJlYWs7CiAJfQogCi0g
ICAgICBzdGFydF9hZGRyICs9IGNvbW1pdF9sZW47Ci0gICAgICBsZW4gLT0gY29tbWl0X2xlbjsK
LSAgICAgIGlmICghbGVuKQorICAgICAgcmVtYWluaW5nIC09IHVfbGVuOworICAgICAgaWYgKCFy
ZW1haW5pbmcpCiAJewogCSAgcmV0ID0gTU1BUF9OT1JFU0VSVkVfQ09NTUlURUQ7CiAJICBicmVh
azsKLS0gCjIuNDUuMQoK

--------------ATNoYVH33lo0pwYNbZzbYZnO--
