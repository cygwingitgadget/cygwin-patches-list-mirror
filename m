Return-Path: <SRS0=CTcB=TL=cornell.edu=kbrown@sourceware.org>
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c000::1])
	by sourceware.org (Postfix) with ESMTPS id 1B7D03858D20
	for <cygwin-patches@cygwin.com>; Wed, 18 Dec 2024 17:45:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1B7D03858D20
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1B7D03858D20
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c000::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1734543929; cv=pass;
	b=keXPIv//mH2LY/RHZsgl+TGrsTvznmO/xD6E553URWRcVh80QjLUOX6LCVqwn+5vaZOWIPhSJzn6G7V67BLVP2n3aKX0M89Zit1HTfnv6CF0oJDcOA8QYkeTu44b4BljzL3NOvL03LQFycosbBjGcdZu127yDfv7LJKtHOlUS+M=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1734543929; c=relaxed/simple;
	bh=4RDZyQ2RXk7GDfra54t9YuO9gd2oVCJcBslkdS2zlek=;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version; b=ZQf2s2yPOVJ9mUdLy/crtTdg46sAdhalt/YxJEkIos9Jb0eq2qzu2nwzbSyl1iaMvVUVThccpqOej3F8BnTyJ70TJDFQy2uOtCltrQy7QgTqF5KRbINooZhsk3JqoXNyLrwcxFoRSeDfPJcM2U4+hjYbh1RatujrEdy1yFyksBI=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1B7D03858D20
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=cornell.edu header.i=@cornell.edu header.a=rsa-sha256 header.s=selector2 header.b=YRx2b4nb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVlvJNKKu0dSdqtO+9NKdOX4l2Ng63TiMFeuMT5vscT31KHOou16knGmaDdYuaw7ifyw1t7OaphHiysvW0d8XH/21o+N6Zy/wyne7AK09BuNkuc2iv7IOTw1Jl8DxPtaWKzzYexADlRgSs891qVkxUx89vSbOrMxiI1a83kenIoUC92wVms/r99HuwBED7Bkyqxo5qNEExYZJIEqiQ2ZMPxme5hVwZzHPccnrEmlfLY28+4xnrrcHWTuiX7qa1PoXsvP+c9Yu1rvOAJeZtyrjmC08CB+trFZUorwWRB0tbNRkmnDCcOiU5ncPXkHdsNymeRb4KO9wq9Vd+WLTfPvRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ps4pP/je1ouxT4cFv0+t2oEehPaD4mYFplaX+g6QXQ=;
 b=XURgAcubnS7VL1Uy4UV5AyJo1DgI0OzGg4AnuVHoMQtwOEaVzhENJniYF7XWUw0z61XTLlUjRgKjj2T+azLAx8fgajAUz8Ghj7CumcGWYpcz/1kBcDKY2SxEvCiYbfqHdj2EH1EwbyJy/gMmzlTLJRSRgzR/M/CU1mxwzNqszicSifUhq9AT+y9msEIkraYKzBnSe7WrxkaLQjcQrTtNPFZtfcsqwsb2ufhqRocrLG7TKFFZZW/Eih35YpZlZDIASISy7+J0/9KQqcZklOrroGap7zb0Jjxzq9lwZD+uYOxs4xqdem4+yGr97KG/WsNQeuC/boF7AVPtnXp+Dcu67w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ps4pP/je1ouxT4cFv0+t2oEehPaD4mYFplaX+g6QXQ=;
 b=YRx2b4nbp40K3cporUzOqxNN6cGOmu58xOW3qk51G+NwqBOogk+n538/OyVYipAhLVD/6teGi6ngRvrRdtqLQXxznOjtRtjVhV+JSsMfATKCK/gVOhbWwIe73Fz2moCJ9lCEPt0KGKGzy+gaXGONl+rRbPSzIhcTHx9g1Up49Ns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from SN6PR04MB5151.namprd04.prod.outlook.com (2603:10b6:805:90::25)
 by SA6PR04MB9590.namprd04.prod.outlook.com (2603:10b6:806:42d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 17:45:27 +0000
Received: from SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd]) by SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd%6]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 17:45:26 +0000
Message-ID: <c5fdd371-7101-407e-99c7-b899c0eaeaa3@cornell.edu>
Date: Wed, 18 Dec 2024 12:45:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: mmap fixes
To: cygwin-patches@cygwin.com
References: <3c4f732a-52de-42d3-a6d3-7fea99a343ff@cornell.edu>
Content-Language: en-US
From: Ken Brown <kbrown@cornell.edu>
In-Reply-To: <3c4f732a-52de-42d3-a6d3-7fea99a343ff@cornell.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::15) To SN6PR04MB5151.namprd04.prod.outlook.com
 (2603:10b6:805:90::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB5151:EE_|SA6PR04MB9590:EE_
X-MS-Office365-Filtering-Correlation-Id: e2504b72-e947-4f09-6572-08dd1f8bc1ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTJzTkNrRmV3ajA1RVpYdXRGQlkzMy9YbHc2c2J2YkNmcDkvY2xMWi9JbDhn?=
 =?utf-8?B?LzVFR2FEdTdvTk5oSjY5ZnZwcEJCWDRxWVg2TUg0dk84TVFBbnN0WHEvR3V4?=
 =?utf-8?B?ZFpna01GdzVWY2lzdm5pTTJaKzU0Q2ZBNnpJTXcxOHQyZjk5TWlRUGRlS0FX?=
 =?utf-8?B?MWZoMzFnc1k4S3lNYWplNU9RRXQ5V3FzdVY2SGVtZUFrRkNKUERZVXpqaTRx?=
 =?utf-8?B?ZVY3Q2hZSjlSZ1lwanR2TlZoRStsL2EzWnArRTlZUGZNWkZETkJEcEthMjZT?=
 =?utf-8?B?SC9zTlJmSUxWUEk4TXZsUzdvMERmYTBEOWF6NHIydERlSGhEUVZ4ekFpanQ1?=
 =?utf-8?B?NnZrMnphQldGTUl5SGNVeGg2bzZ1ek1TOVJmS2FoT0R2Q1p1RzNKbDQva1Av?=
 =?utf-8?B?d0FZLzlUZkwxLzJEMW5RZzRaOEg0TFdsYmlEcWZ6L2F1bHd6RWo4bXM4MTlo?=
 =?utf-8?B?YXdtYUxER0E2a0pkZlo1ZjVxcHZnbzZxTlZzT3plb05xOFFrSTA5K25PMFlr?=
 =?utf-8?B?Z2NnUUp3aGJLWDZtKzd1STV0OFZEMHoxMHJoQzFHdW1wbEFCOTJPdWpzNnd2?=
 =?utf-8?B?NkxGaXBWM0VCQmVKaGlsTEpkREw3NFpaWUlRSlIvdUZjZ0oydUR4aDJQTWY2?=
 =?utf-8?B?REVPZ1Fsak0xTnB4RWVkdDYwZmZJdWtrbHlMNWp2Z2NZT0lzRHhTdWlFZ0dn?=
 =?utf-8?B?VGNLSXA1YWxpWnYyV2l3QWsxbFhKZHhBRzFISDhtak1ZQXFkd0xTdytXb2lV?=
 =?utf-8?B?S2xtS1k2dGk3QlRtV1huOHc4K1RhTGptazUxNk1jYzkxdkpmTklDQUUrMWdK?=
 =?utf-8?B?L3pHeEcySFhsOFVyWDA2NHEyeGp2UEI4aWxGb3lhK1hTTXRsZjJoQXBoTlh1?=
 =?utf-8?B?UlVjVHNtdlg2aWwxdDFmUWwvcWF4UHBBVW5sNnoxckhpQUdKYVh2bUtKNXEr?=
 =?utf-8?B?Znk4Q1V6MkFueE5zbkg5NXFjMnRYeGZGUFpGRWpFRlhmRS9uSkx2SW95N2pF?=
 =?utf-8?B?WjJPbzkyQVhxZS94L1dPQmNFdmVrWGE5ZXp0VzA3RlhGa1VxUnF5ajdUa2Ir?=
 =?utf-8?B?dUNZWUEzQWZiNmxKYVhOYzlRMVpnVFptREgybWpnL0pLUVROZGRTd0tTK0tT?=
 =?utf-8?B?dWx3OEdOUzZtcEVReC9BaXFNeFpoVGR6b3B5ME54cGhHaTYvVEliUnczaTZH?=
 =?utf-8?B?M0RyRzB1WXJma0dleFRVMUozcmw0MVA3cndQeVNGTGE1NFNJOTdOT24xTGhw?=
 =?utf-8?B?Z3NORVFhZ1AzR0FnbkhUZjg1Y0IyTkRIekNyWFR3QldaQUNndFQ5azl3NWNE?=
 =?utf-8?B?dkpyS05HdWlCZTBCRmpPZk5lNTBDRkZkek9oM3MwdldiclBJSlJkaGNjcGE1?=
 =?utf-8?B?QUFhNkJmVFlFYTFzVktzM3F2UDBKZXF2SzZwMU4xMUJJcy9lMGR2cnhXMHk4?=
 =?utf-8?B?RXJuWldMMTRGVG83eEozakNiQmVvTDZvWmxTejBDNjdBS3dNcUFHREY1Tno1?=
 =?utf-8?B?bFBualAzUU4zN3pYeWhDMjUvTFZSbVZSWjhrak1IOHJXZDZFNmtLajh6RWMx?=
 =?utf-8?B?OFZyU0ZUb0s3VVp0UUgvVnBQUkY0MjVPMDFVaEZqdTlmOTlQeE9uWUwwSXhy?=
 =?utf-8?B?WnpmTXNVWUpFNVdYaFZvcHFJQ1hUQkRFTi9jRHpMS3BhSTVtY0RXbDFzc3lO?=
 =?utf-8?B?a0NjVTN3VEZybkplVnQxQVNXdWpqcmx1TWZrWTVHeURvckVTeENaemRzVFh2?=
 =?utf-8?Q?MR+xVocRKfLI/4qQjubxp3mYu3Ov7aCmIJMmHuN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB5151.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UG90VFlLd2cwT1p1VEtrdS9CdG5OQ05hejF2TFA4RlowTDNkZmpwTEdVTXlP?=
 =?utf-8?B?ZEtpOGFmYUpkaWxVTUZsaUgyNzhaZjQzVEVBTEluRDJYcHl5WWtEV000a3dt?=
 =?utf-8?B?QmM2d2JvQ3h0VHk0NFZXZFJWUFBrQXBVdTNBSXlWQ2dZM0dyNFd5bUNzdnpx?=
 =?utf-8?B?amo1VzVwL3FZRjFjT3NFYWJzdW1lS3B1aE5SdnYrMm5UMFhEeHBka21HRUxM?=
 =?utf-8?B?TmZwT0pZWWdDT1Zrc3VmOEtZSnFQcGJ4MWl2Y0crRGpnUUgxNlRscWViYXBj?=
 =?utf-8?B?amtyeElneDNrT0tkbDRqUVdhSUJoUURGdnlTYVAyYmN1dkhud2p0dzRBcWM3?=
 =?utf-8?B?SUExWFY4UExIZGZrZ2pIaWg5elZwSjN6dEZTNnFPNE5xVnRKQSs4YU1YclJF?=
 =?utf-8?B?VXROWFp3dHp4OS9aZEVlODNaU0VEbGJ0OEtXYWtHcDVxVTc3aE5FZGdGYVFx?=
 =?utf-8?B?MnJUdnhWS1BFdW1kMlhCcHFnTGEzcUd1YjNDWmZsL0NTeDFsektRajdVWGh0?=
 =?utf-8?B?OEhqOTBHcFNENTBJUXRCY1lHaVJvV2dwWnVhMHhMT3ZwZ2twUEhhTUZPanpY?=
 =?utf-8?B?RUR0MUpqZlUzNEhMNU5DUTAvdk5LUEZuTEdGSCtrZEwzK2lZcXVxVExnd2RZ?=
 =?utf-8?B?RnpzZTJRM1l6QW9iQ2RLVS9GeDUzck1NQmRRNkJJWTdCNjRIQnRQMHlKS0Y2?=
 =?utf-8?B?ZlE5a3picmxGdUZOMVFMNFdaZ3BCejlnU0xNN3VuVi9VTkFmaEVMTG01RXhx?=
 =?utf-8?B?NEtNa2xGVDZhSjlCMFM5UkRMNWJmZjhPakRyWjk2bWdVL1diTXBDMW11NlRu?=
 =?utf-8?B?ajZYT1psSVUxdkx6dEEzSWR5aHoyZkdjY3pPVEhDVmk2UkJMWXJ4N01OUEZH?=
 =?utf-8?B?aWw3amFEUkhmQjV2Z09mZzlaRDl5SjRpUFl0aGlhc0pSWndkU3A0TFg5aXYx?=
 =?utf-8?B?aUN1SmRVUUlSc2tSbFJGK0cyOHJtZmNhclRscnk5aEpSSjZZK3Y2WHI2WGxC?=
 =?utf-8?B?MU9HVGdzbFhDKzNWUUNYbEwyVmNLNlBTVitsWkxIK2psbWNlQU5XSW9FRUpm?=
 =?utf-8?B?REdtMUxDZTZQdHhaeStWblB3QVhlaGhEa05PWTBtZTQvNUtKTmpSUVdpU0VS?=
 =?utf-8?B?dHNwUXpRL0J1NWVCMWZ2VTZhY0hGL2QrWTZTMjh0SzFrSGhyRHNETE95c2E5?=
 =?utf-8?B?dHZpSHA1SkJ1MHlKeW1hWEhYam52NG1WN0xlODJhaElFTmlVTzI4ei84V3c2?=
 =?utf-8?B?M1BzMCs3NFBEV3FsWVF2T0x3VlJqaGdrVWNEQmxVeEZnakZhTU8zTFRhZ0dX?=
 =?utf-8?B?djVpcTBkYlZ4cytteGRaMUYrRlFjdUhDMzM4bzh1Nk5ORE9PMXlEMExwREZG?=
 =?utf-8?B?cUpPZmZhdFNhRkpxcmJSYUYwSnlGQ1BNV0FObUNvNmxEYlUreG1GWnNPR2xu?=
 =?utf-8?B?NWpOSGJsRjZIcmZRejhyOVkwWE5JRHlCYlFXNGlTclVyRVp1SVR6alVqbG9U?=
 =?utf-8?B?QlQzQWI3NEtOeC9YWldPRnpnaEhOSEdTb0FXeDJSRXpsVjAwaVdnUlVMclR0?=
 =?utf-8?B?UGx4RE5aTE9JbjhCYlliYSs1dWlwOTl1dWV2VjV3M3o3Y21tN0RRbStIcy8y?=
 =?utf-8?B?bVQ4REdHanpXTVowa1ZKc0V6SnRrUUJNYWw0YzVWTzc4aHhkQitZdG5rNnBY?=
 =?utf-8?B?MmFERkFmZnZMbnFVNStGSzVZcFlJckxNOEhXaW1jazhTempRVWwyck5VRmtq?=
 =?utf-8?B?QWoxQ2xTeDFuT05TVVBmVGI2ejIzc1dxdU4yRzFDQyt3MzRGekFrWkh0MC9Z?=
 =?utf-8?B?Y09KSTR6MEpoZUczUnIyOXFobUpPQy85SGVYQll1NVNJZ0J5dlpidzgrTUha?=
 =?utf-8?B?Y0JXR091bnA5RGs4MHJFRU85em5GRGRnWmVWc0FpNHl1SjN0ejNQUmR2aGVT?=
 =?utf-8?B?bFRMZU85R3VhOVlpMmlMeGx5cEN1enFxUmtZNStxK1hnM25rMzNsc1o5aVA2?=
 =?utf-8?B?MWY0VmJtRzMvNm81c0dSWjJodEo2L0Z3eEF2bFRDa01VbTJvVUdOcTRESjZa?=
 =?utf-8?B?elBkN1pndWszYk10Z3BTVnZEcTI4N2tRdlI1VlRLOUJ2WDRVQzJySTNxaUhX?=
 =?utf-8?Q?lSdjwyRzwO3HDOe1M8OVNuZTO?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: e2504b72-e947-4f09-6572-08dd1f8bc1ac
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB5151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 17:45:26.8349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03TyUXLf9XiQSdc5qmDUb/BUX/JAOL1049hPEOsj3gyKdOBw6LUQ8wnTDV9okDfnamm+Uz9JXGhh4oW8a/TqEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9590
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,JMQ_SPF_NEUTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 12/18/2024 12:16 PM, Ken Brown wrote:
> The two attached patches fix the bugs reported in
> 
>   https://cygwin.com/pipermail/cygwin/2024-December/256911.html
> 
> and
> 
>    https://cygwin.com/pipermail/cygwin/2024-December/256913.html
> 
> The second one is still under discussion on the cygwin list and may turn 
> out to be wrong.
I forgot to say that I was unable to determine when the bugs were 
introduced.  They seem to go way back.  Can I just omit the "Fixes" line?

Ken
