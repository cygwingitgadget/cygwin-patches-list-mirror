Return-Path: <SRS0=A3bB=QX=cornell.edu=kbrown@sourceware.org>
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on20704.outbound.protection.outlook.com [IPv6:2a01:111:f403:240a::704])
	by sourceware.org (Postfix) with ESMTPS id 7A8123858D35
	for <cygwin-patches@cygwin.com>; Wed, 25 Sep 2024 20:11:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7A8123858D35
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7A8123858D35
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:240a::704
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1727295079; cv=pass;
	b=Wv4b+fF+Z5XEF3ofXKM1072poOoXVt7jSgO6WLIFfbKXolUs+DX0WanCLMbEnAfrmOOPZMvwucsVlDq9zttdttE/65PVkbQRFfLLB/sdYX2Qfu9UL1uv1MmWlmw977emXybPAH8XQhOtlc8ZQl8YxPBU4Ck+6Y70Pm5DgTO2Bew=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1727295079; c=relaxed/simple;
	bh=NGTwMkDMeaW1AwmQo8WuFt0u/NNTG/OiDJz2tS0vYz0=;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version; b=AqkbB2peCZffcfmuyiTMGUiFaaw8cE/POFDM71iALU23I6vFCbyg5dG9ceGPLEBJku+psLpCplqZwc9Oe89vLCmD8PFB1boM5sGaqVV0S06drBRVMy6ZMqATM8eD9zPXK4rilfrK+FBkTChWA0rXF7sMVeE+P9Zvhi4hZ98H0uY=
ARC-Authentication-Results: i=2; server2.sourceware.org
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qsMHayMibYNygqGOFYCOxs3NkuBgjoBFUNyZR8S0pkN2TQIhuk/TMmATOs3IHPDeMTiGcKSEUHATT9v+FQNnmHATR+CRJQomYrPIANOjSZxJeC0bxLRifLXOPiSEgiDqGeyFmQ/lyO9KW0OhQ/s/rl/xzKMpYWSEJxB3VfQfPu+FD7C4Uj76qpKALr4/boOzoCvOowyKQE4udqRjqcl9ylBx95ycG3rqb0vcipoDSTt4hYxTQMU7DjwP5h7Xw/tdMkbSP0biKWWAU8E+S60BR68t7xqPPmLqxcMzXLdHapzXwL7a1NlU1WawlETy0guhUiKSL3FOu06Heh/UGd1T9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atv3aRWvG8vQQkkuRi1TlJqHQeE64GSeTeN8F1eVe80=;
 b=eUP7f67tGjReGPj2YNxvOw4vChuGG4OgUW7eydBisfgyaa9scba23PXXWZkDGnW0xYKx3D3c93N40o8E2hPLKTKjaU4O31oJ2wAJMfHU4Zq7Pu8q68nBM4s3uDmG0WnvlU2bLkMOlHNqdZw5rj2e14Qdz7TpY9rd9FF5tdhLme0PsnhHSGqZgI6hIO0AOnM520gklyLRfw7YxjRZDTpFPO0dxM2W4Uo3zlXLX2Y4xcQOCzeMuufX9WDrC5A0/nC4SrzqzMt76ZUiHMwDZmwgsaaATbkbGadjxhugyMaaUol1DTTChutwckJd1O8n2oqIZhhUZ4G7mQocjaGE8x7DCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atv3aRWvG8vQQkkuRi1TlJqHQeE64GSeTeN8F1eVe80=;
 b=ZaFg0LG+saqxpGyW/tdWGZnvEpkDfBhwDogOHuG7r6rw5aAMvTDBlDiOsPbmCoq/ml+3XabEydswmXx8+C4l/PfLLLKsMWxoyUSw3wXE4/FqCodDOIKyVSlrW64+syTVolnZItcFrmV+ZQRjHBVsQ2+ue2bj0RaDeQ1/CBbnGdE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from SN6PR04MB5151.namprd04.prod.outlook.com (2603:10b6:805:90::25)
 by CO6PR04MB7748.namprd04.prod.outlook.com (2603:10b6:5:359::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Wed, 25 Sep
 2024 20:11:15 +0000
Received: from SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd]) by SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd%4]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 20:11:15 +0000
Message-ID: <0e6831d3-9c46-4467-af45-4f72555ea4ff@cornell.edu>
Date: Wed, 25 Sep 2024 16:11:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] Cygwin: pipe: Switch pipe mode to blocking mode by
 default
To: Takashi Yano <takashi.yano@nifty.ne.jp>, cygwin-patches@cygwin.com
Cc: isaacag@sourceware.org
References: <20240921211508.1196-1-takashi.yano@nifty.ne.jp>
Content-Language: en-US
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <20240921211508.1196-1-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0180.namprd03.prod.outlook.com
 (2603:10b6:208:32f::10) To SN6PR04MB5151.namprd04.prod.outlook.com
 (2603:10b6:805:90::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB5151:EE_|CO6PR04MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ba28ede-f56f-4b3a-0585-08dcdd9e354e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmRyUjl2NTV2eWI4SDBvLzJRYXF5ZEVGODhPUGp0Qytvd0NlUCtlLzEyaUww?=
 =?utf-8?B?Ny85WTRKS3RtZkhDVDMxbTNJVDM1ZmNudEFNUGE1c0E3bGZpb2U1cXgvUFJR?=
 =?utf-8?B?MjlQU0MyRmg0ekJHZGRxSENZK2FGTWVoeDM0MFFpWGZZbzU0OWdqakxoYWwr?=
 =?utf-8?B?VVpONUlubTY3bkhzblpzaWJ4cGlLNndNdzNYemRBanJyTFFNSGRtZzE5OGxG?=
 =?utf-8?B?cHlGU2dML1pxREV5RVBJUkR3dEF6M2lMM2M2d3dnNlBSL1FGdU1JZEEwSEM5?=
 =?utf-8?B?UThsdG1HTC9KSWRWL2RYTUpGcmNNRW5Ya2NaTEJaR3YvQW1XenhRWU1NNVpu?=
 =?utf-8?B?ckhvaDl2dWRla21CSnZEMTZLTzVtR3h4R2N5NiswM1ZPbzFDSkdQTFh2TWJm?=
 =?utf-8?B?cC92YmhWU3RIamRkZWFwYk01ZTVBN1BEZGhDRXUrd1pmMVBiT3JoeVdMQTgw?=
 =?utf-8?B?M1NBK1pDWWVjTVNPS0E4emZKak81ZGszVUNuQ0R1VktUNzNEMyt6eXl1RkVn?=
 =?utf-8?B?TExQQUh3OW1YdGdqR2pRd09sbStrY1htZTdqOWpxZmZYOWp6dU5rYXZzYWNm?=
 =?utf-8?B?c1R6NmVKNmtud0kwY2VKR2R4L0Z6Q3BVNkpsYXZ6ZkNPaCttUFVrVUJ5MEds?=
 =?utf-8?B?UWVPQ2xTUUhseVpZS2d1U0hTTTM1SWVsUFJIRVJhRGQ3TzA1R3NOaFFRZU8x?=
 =?utf-8?B?RGtyQlNSY0dKejlzVUg4YnZVeTlTejY5QmgzVGE1NWhrT3c2bzNjZVVrRFQ2?=
 =?utf-8?B?S29icTd0dVhxcVp1VHRWTlltTVY5anNVeE1Td2ZHbDh6ZDJwZHpzeTc4WjJN?=
 =?utf-8?B?NnZmTnRhSitWeEFPWTU0Z08zNUhOL0JsZm4rMFQ4bk5RcjB3dHRhcjRYOTZw?=
 =?utf-8?B?N21nTmtmVnp6ZE9rQlVITmhrMHVFMTFwVTNyaTRpWDFEV20zeXZIcWJZWXlG?=
 =?utf-8?B?cFNEaVFIUU8rODVmdUlkbjhUTklRWko3Vy92bGdNYTBWNDBtSUNYKzM3UW41?=
 =?utf-8?B?Rk1yR29OWXdUd1owbm9TcXQ3WklTWG00dFFzS2hYZ095RGlFMUJGQU4zN0Vm?=
 =?utf-8?B?dEFVU0NHZXJzcXk2RzFkREVvcDgzUEtwb3EraHNXL2NZbWY5Z0hteldPdGl4?=
 =?utf-8?B?UEVoejY4SUNmU3BPdUJWNUNQVE9FUEZuV0VLY3F4OG9ob0kxem5leS9uMW5x?=
 =?utf-8?B?UVVLZGtlYkVpeHh0ZHlCbDcvQzJXZlhBUTY5ZW1obmxVYjNjQ2dMbVVvOTIx?=
 =?utf-8?B?K3YrRVhKUDFrU1YwMlRpdXYxSm9SYTdkNEszWklDRFB1NmowdmlBc0FvWkJ5?=
 =?utf-8?B?NW82K1ZMWlpFT2xrM3lNRnVIaFZsWWVjRWVES3BTWDJHRlZkd0ZJelNBY1FJ?=
 =?utf-8?B?WENlV2JPNEZaSGMxT0FsSUtBTTRwTFNXR2ZVL05KcjRhdVRlRDFJOUF4eCti?=
 =?utf-8?B?cTRXNjFZVWpUM0tlNWVEY1Y4MHhYdXYwUWZaeXpsd2U4SzE4cXRvUHdnRlhH?=
 =?utf-8?B?NkxXZDlKVWQvVzRGSUlCeWVPcFltWTlPMlRtVFRESDZ4K2U2eTR2V2xLOWd3?=
 =?utf-8?B?bWRZUStSUXpzZWw4bWhlTUhhMVBVSXExWnZNZFNEYVVUdVE4NWNiL08yMGJL?=
 =?utf-8?B?UHhYMEY4NU8xZHdNTGI4YnBlVmxkejJkYjFod1IzdW9pZTZLYzQ0azlVVzly?=
 =?utf-8?B?QXljYUhneTVuV0pIaUk2clI2RXNHbVV4dVhZMmJPcUhGVWJ6WUVkeUR3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB5151.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mm5ucGNZR3R6Y3hGSjhsY2JXN0FrTnRVeWpFRzNGb2szbjFJTFYxMFRqSHpV?=
 =?utf-8?B?NW9xRnhXQW5iZ2RhWExheExxbE9YV1p5Qk9QTUxkY2NwVTZwUGs5VHl3SlV3?=
 =?utf-8?B?RUVNZEgwVTBYSkhzM0s3NXBoaWQ3RWI4ODM3TnoxMDNUY1c1eXlHTnBUSVZJ?=
 =?utf-8?B?WFhLOXZNditVaU1jTDZWbFh2QmpzK1NkbUk5eFkwWnVVRnRLS0NYWXc3czM2?=
 =?utf-8?B?OEZoTkJ5VHNybE5heEZ5eUNpT3BrS2p5R0pWaGxoYTFacEdMYmlNcDBZNnps?=
 =?utf-8?B?VnJ2anlld1VZOE9nU2VNMHJRU0dYQU1qRDNzMVZ0dWlsVVArdThWL1JKR1FE?=
 =?utf-8?B?MENEaWRRZDkrUkZnQzRmT3gwWWRwSUU2QmIybnFQVHpwcFArb0w1Z3ZhRDlv?=
 =?utf-8?B?L1pHeis2SFVIZ0ZkYW9lUWFKMEd4eFJoQmUreSsrL0JuWXJCc2FVN3h3VVg2?=
 =?utf-8?B?Mm1mbkN0QnpjUXpvNUtQbGJUMmZLVXFIQlhIeDArbTYzc293bHBjTFY0THdr?=
 =?utf-8?B?cXVYSDhjZy9KSzJJRHpZdGozcHU2TTEybm93RGNPN2tIdDI0bU5paGJVdHla?=
 =?utf-8?B?WTZFY09sSzcwVHNrVnY1TlovTHlUMThMUzloMHpXRTd6cDErRTNaT0c4OW03?=
 =?utf-8?B?SE10QW43YXBtSVVkQWtJWEZTaHphblFDSHVDdWlOckl3YWhOeW03ZnZOZDVm?=
 =?utf-8?B?eU0ydVA5SEhTYXVxTHlmbWhDaWhhaU1iWWNHaFc4YzZEZHREOCtwTitGaXJJ?=
 =?utf-8?B?ODNFR2JUOHhVYWp5WW5tbzRxNG1XLzl3Rjg5RlhlTXNucTdvcmdyaW5heVhS?=
 =?utf-8?B?Y2lYcU1BUHRWZTFlcWwxQUVpWWJPNG5MeVlyVGxtdGg0Q1MwaUR1bEZhdmQ4?=
 =?utf-8?B?dTFDeEFaUEdVVllORmhDd1ErNktZNU1oVG9IVE1hVXpXZ3pFYVllUWJpblJt?=
 =?utf-8?B?T1lDU1NoSkx0TnlDanBscHBwMG9zS25PbHYwenBKNkxxdmUyeUdLcW9UdXNQ?=
 =?utf-8?B?RXk5dVlFc3NzVHg5UC9TOHJUR3E0WTNaN1VxOGJLVjZuL3RzMjFOcmhyYkZ1?=
 =?utf-8?B?Tmh2M3VaZGJoU3hzSmZrWmZqOGVDeVN3bm93d0Nzb25JUUhxcFpWd3RCcmQ2?=
 =?utf-8?B?VVN1UFE0S0R2THJ6QXFuSHI4M3YrYVZqYVYwbmt1TWsxckNmdHFxSFd5b3p1?=
 =?utf-8?B?N3JKZndSV2dzdTFhYVpaTlMyVFkwOUxwZGJLNU92SlB5SFVUVTMrc0lsLy9t?=
 =?utf-8?B?eWUzK3BvK0FMVlMrTTl4NE1WT3NoNVF0ZTl3bGFvc2E5elFGMEp4WWpjY2dv?=
 =?utf-8?B?NVdBOTkxdzNjazBZeGE3L25FRFVBRXdrNU5JUVFoVzBTR0FZekRrd0pLYXh6?=
 =?utf-8?B?T0x2a3V2eGwzSWxValNBcVFqaGJYTkFheUsyRzZjbEZQeTFWSC9OZUFNS0oz?=
 =?utf-8?B?VjdzWGhLc2ZUNVBqZzN6UENqWVpRTnNtQnZzcjlyVnh0Vlk1OVJ1RjhLa3dE?=
 =?utf-8?B?T3BRT2VuOXBrYUkyVTRST1JjZlpVR2g4ZTZLOS81LzhGTng2dmxqUXlOR0Rx?=
 =?utf-8?B?OXMwc041SVBSZWpvdHR6M0RHdTF0OGRqUDZ2Q1hvVXA3R09XUHVabTB3Rk1n?=
 =?utf-8?B?NUJVbkZMZmxiaTA5WjM1Wng2NVFMWWFZRWdRalZtS3dyMEJEcHI2K1p1OEMw?=
 =?utf-8?B?ckVycW9rTmo0Z21QVjhDYzI1cnRFQWozTFoyK2JuTVM0cnVMSVZnSTBwMTlw?=
 =?utf-8?B?dzRGRWNnWXBUYXVCVkYvaTdHZjhPSEhKc1lwb3NqL3BFWldka2laRSt6bWY4?=
 =?utf-8?B?c25jM0k5UGttM0RjeU5RQTJzWjhqVkxmSG5kWHJiOTZaV1RJVmlpMHZabG1n?=
 =?utf-8?B?dVp2WHlOQVE0VTRsMDA1VU1nS1lJQWNxSjV0MUFKakdHUExMbnY3MGlZSDNH?=
 =?utf-8?B?cEVnOSs2SmsxL3ROS2ZuV3lmd3VOeUtWY1R1N3hpWmhzdHdrWnozQi8rY1lS?=
 =?utf-8?B?QVUwNzlFYk05bldzUTRjczhHTE5xNjJqS0pkTkRkcjYyT1N6RnljT3VSVXJL?=
 =?utf-8?B?bVJ3UERiVGdhaysxTVdrWjlOZEZPNENtOVBZYUY1V1prSWdIOWg5NTdaSWRu?=
 =?utf-8?Q?oJUrbx8YrnDxFKzc+aFkq8p7+?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba28ede-f56f-4b3a-0585-08dcdd9e354e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB5151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 20:11:15.0218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zIqoRUYAdRtk5xehXMQPLvDGvw38LA93YddYzAV6Cla2KsazK9h+XLN/7Ha71xENEQqHUGoUp95iK/394vBJJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7748
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,JMQ_SPF_NEUTRAL,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 9/21/2024 5:15 PM, Takashi Yano wrote:
> Previously, cygwin read pipe used non-blocking mode although non-
> cygwin app uses blocking-mode by default. Despite this requirement,
> if a cygwin app is executed from a non-cygwin app and the cygwin
> app exits, read pipe remains on non-blocking mode because of the
> commit fc691d0246b9. Due to this behaviour, the non-cygwin app
> cannot read the pipe correctly after that. Similarly, if a non-
> cygwin app is executed from a cygwin app and the non-cygwin app
> exits, the read pipe mode remains on blocking mode although cygwin
> read pipe should be non-blocking mode.
> 
> These bugs were provoked by pipe mode toggling between cygwin and
> non-cygwin apps. To make management of pipe mode simpler, this
> patch has re-designed the pipe implementation. In this new
> implementation, both read and write pipe basically use only blocking
> mode and the behaviour corresponding to the pipe mode is simulated
> in raw_read() and raw_write(). Only when NtQueryInformationFile
> (FilePipeLocalInformation) fails for some reasons, the raw_read()/
> raw_write() cannot simulate non-blocking access. Therefore, the pipe
> mode is temporarily changed to non-blocking mode.
> 
> Moreover, because the fact that NtSetInformationFile() in
> set_pipe_non_blocking(true) fails with STATUS_PIPE_BUSY if the pipe
> is not empty has been found, query handle is not necessary anymore.
> This allows the implementation much simpler than before.
> 
> Addresses: https://github.com/git-for-windows/git/issues/5115
> Fixes: fc691d0246b9 ("Cygwin: pipe: Make sure to set read pipe non-blocking for cygwin apps.");
> Reported-by: isaacag, Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Reviewed-by: Corinna Vinschen <corinna@vinschen.de>, Ken Brown <kbrown@cornell.edu>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>   winsup/cygwin/dtable.cc                 |   5 +-
>   winsup/cygwin/fhandler/pipe.cc          | 657 ++++++++----------------
>   winsup/cygwin/local_includes/fhandler.h |  44 +-
>   winsup/cygwin/local_includes/sigproc.h  |   1 -
>   winsup/cygwin/select.cc                 |  46 +-
>   winsup/cygwin/sigproc.cc                |  10 -
>   winsup/cygwin/spawn.cc                  |   4 -
>   7 files changed, 252 insertions(+), 515 deletions(-)
LGTM, but it's complicated enough that I could have missed something. 
It will clearly need lots of testing.

One trivial suggestion: For clarity, you should probably add the 
initialization of pipe_mtx to the fhandler_pipe_fifo constructor, 
although I think it's initialized to NULL by default.  Also, it wouldn't 
hurt to add a comment in fhandler.h that pipe_mtx is only used in the 
pipe case, i.e., it remains NULL for fifos.

Ken
