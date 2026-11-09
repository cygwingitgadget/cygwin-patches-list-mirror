Return-Path: <SRS0=MMaU=I6=outlook.com=luca.bacci@sourceware.org>
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010019.outbound.protection.outlook.com [52.103.33.19])
	by sourceware.org (Postfix) with ESMTPS id 6586B4B920BF
	for <cygwin-patches@cygwin.com>; Mon,  9 Nov 2026 18:11:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6586B4B920BF
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=outlook.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6586B4B920BF
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=52.103.33.19
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1794247877; cv=pass;
	b=aH7xUaS/igimhUu6ThObFbbw1FItXZqKdxCs7aczyrDCQX0LybUnkSRRYvX32Pb20rym6Cyz1i1o4FrJw9LHIMImX36SyHHKxmbMXOfeZFWRlQWo/W+ZHeLi6sMCTShitZyo0AazVQ0KPIZQX3NMk0Zlujvl+9hVIO7dLb3CbA4=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1794247877; c=relaxed/simple;
	bh=P73yK1vD0CBSMuPCCMPamrPR5P0lml3Z2i8/lFVkXlw=;
	h=DKIM-Signature:Message-ID:Date:Subject:From:To:MIME-Version; b=VutL7lYhaHM0RFh9XqBPW90O3TkJgzsooXaMseGOZCk+rB9U80RUTjf2TwXpYSvWOBBEBgbpjML6Z9LSEC9eLAEs55l5IjEGir6pykfgTpj4KMHDyscAW786UXIh1Z3YfJU+Uc9q0tzTX1TKa26DzSGmmpl/gsNxrSlLJK5oIGI=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=HuOkRwlu
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6586B4B920BF
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=HuOkRwlu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=svNUJyb/XQfOJLbRvuPzul2nsumADuAJQwLAgZA7iIKKCmQjaYmOat/eEev2SBGe7mCBawpi94zH/HcP5GzjKAyZOD7GbobW4jeLpTdH3EteU99iCv0NNKEuYMQ5SKMGjvElUDdwB4Pc+Zd/x/YGoxzTWZ4seHjPf+FHB9nM2j9R5O0j2EnzyJ6Njfdr+XAKXlie4Bkr4QDkF0gTiXQq6ZYwn6L156ENK0gnz8Ffrl5v1ivpcLOk6OIXSIYZ+D2vqFmZ2HKISu0xwRds0sPgujvJNZZRMxb07xAAmwQe0Ay2b3FcCZEPJnY8KLaZNztWOr2c9VAvbyiOgwdHBLJFCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXpt2Go3GRwYOVHb394YD2vhvqgxXFswIDXXD2zPyB0=;
 b=VffYlholvTdZ/7DpUpLZLjf0xUKzFYFAMsRrTdC6QJPWufxE/MeuicEjDBZrvFoBhUWZLS3yiP+eSLdI413+dvEm8apmZ4xn8p55+HAmCQsMG7ZQPgDM7LG8hUxDEp+9lxJvmm9FAE+n/ivDh4R2cmwWJy6QJ15nP5ynlEhp1PuSbI0R4Er+UoV9GcymlYXyxHoO8hupAQpaP+/HBnwU8ypyjGz7Pjnd72Yh7UUBxeq7NtPsXVdQmLWTHSrknw6wzYgevMDDSbuiq/qgBT73CLWCbmAxTUjMcwHBURAm7U5YqAXeqh8VlU0gs52d4Q+EvrmWBoOOHOtpMkmsPzrNqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXpt2Go3GRwYOVHb394YD2vhvqgxXFswIDXXD2zPyB0=;
 b=HuOkRwluKc1BPYjwNhq36P3b2Qspw67fGYIJP7ffAsjopX/5y7v+FM/Xpb6v5Y9JfQnhTZkMqZkM1hwCMHAuuFauV70UaodJKuWOl9RnCoIatNNzYZ9PzHFcvRzR+ALXVbWIINOPnHpS9BCLB70+fJzRRMkZg8gAVHS/UUf+ObxUy+YSh7SzHeIuZD45DL0WX24VnsdiLTGkeVEIwGusNGjP50rh+FgdrZ7tijVXNJUHC4qtcrRsNCDkRe0DfQmK/EwftlCXfTydWos1EwCZkA+0ovH7JRvTp4+q8fU8Ds6+QwRL02uPGnsJG/JkFhzso3uHEwbGoCVG7VgQ18LtvA==
Received: from AS4PR02MB7902.eurprd02.prod.outlook.com (2603:10a6:20b:4b2::9)
 by AM7PR02MB5971.eurprd02.prod.outlook.com (2603:10a6:20b:1a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 18:11:09 +0000
Received: from AS4PR02MB7902.eurprd02.prod.outlook.com
 ([fe80::2a24:bc25:8b55:3de8]) by AS4PR02MB7902.eurprd02.prod.outlook.com
 ([fe80::2a24:bc25:8b55:3de8%5]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 18:11:09 +0000
Message-ID:
 <AS4PR02MB7902FCCBF1CF70694E395C5483732@AS4PR02MB7902.eurprd02.prod.outlook.com>
Date: Mon, 9 Nov 2026 19:11:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] pthread_once: Use acquire semantics to load state
From: Luca Bacci <luca.bacci@outlook.com>
To: Jon Turney <jon.turney@dronecode.org.uk>
Cc: cygwin-patches@cygwin.com
References: <40aee3ba-beea-48b2-8408-db28b9cc6770@maxrnd.com>
 <AS4PR02MB7902F8DEBCC6972D8C6BF34183672@AS4PR02MB7902.eurprd02.prod.outlook.com>
 <ea4baf13-8720-4125-b7b3-0d7f589f1162@dronecode.org.uk>
 <AS4PR02MB79028BE3080D8BF92F94261483732@AS4PR02MB7902.eurprd02.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <AS4PR02MB79028BE3080D8BF92F94261483732@AS4PR02MB7902.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI1PEPF00000D5A.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::491) To AS4PR02MB7902.eurprd02.prod.outlook.com
 (2603:10a6:20b:4b2::9)
X-Microsoft-Original-Message-ID:
 <8b0867c4-077a-4e1e-9981-12c6bbc450e8@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR02MB7902:EE_|AM7PR02MB5971:EE_
X-MS-Office365-Filtering-Correlation-Id: e0bf6b16-bfa2-4475-defd-08df3e8cd461
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|25010399006|23021999003|15080799012|19110799012|8060799015|51005399006|5072599009|6090799003|1602099012|10035399007|40105399003|4302099013|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTZyOVAvUlZCbXFJdmcwU2drTlM3OEpCa0s1WUkyT0lmSFBJTDl4bnlBaWVY?=
 =?utf-8?B?MmdKb012NGJLSm9rRUdmc2hNMFNBQk1mYnkwR3dWZGc1L0dOYlR0S2NQVnBr?=
 =?utf-8?B?Z0VmR1l0RFhIelEydmhOa1pDTVhFUjR6US9XZDB5UzlPY2VCbDFqK09NYU5w?=
 =?utf-8?B?TERvMld0aU5kcjdmVXVsQm1rbTJ1VEl5S1ZVT0RoVG1PVHhhbmx6eitsMXEx?=
 =?utf-8?B?aXRpeGgvSzVLYXlYbGtDcStlaXhvODBSV1JjRHdlQUoyVTB4SENiKzFGaXpS?=
 =?utf-8?B?c1ZEQXdpU1kvbFpody9rdmxSckdoeEZHK084UWZNK0NnblI3NkNhMkhBa21Q?=
 =?utf-8?B?SzFoZEZRUDR3enl5aWRUek1BWXZ0UUlSZVJZWUxadlFRdFk0TzR5ZG9PYUdm?=
 =?utf-8?B?dW9ST3NObmFyZXM1eE1QSkcyb1RPZG9DZWN2QmU1Y0VuZUlwMDhLQ250NXEr?=
 =?utf-8?B?eEdsNjlPNGEwbHQ4eVJOYnRCS0s1M3AyUUFGZmRxK0I1UkVBV25WaTdMOEZQ?=
 =?utf-8?B?TGhWN21EWjFQWVVSVk81VnJaYlVjeDNWVVVSOU40Y2t4TjUyVm5LUzdnNFVN?=
 =?utf-8?B?RzVTRDNpTmI2NGdncFp0R1FhcWN3SjNFbXpFanVlUkpkNWFZK1JxV3hXQ1E2?=
 =?utf-8?B?UG8xNVZGUm9kcTl2ODhoSXVyZUlPUVA0TEttUEFWNkQyNWRiZjlQMHd4VG5O?=
 =?utf-8?B?SVAvc3dZZkdxdFdIdmp3N1l4d0hGMFNEN0s2bm5icFFPYkNyckxWTFJaZVpR?=
 =?utf-8?B?RlpTV3JyU3JHSXFleGZFNjJ4L2ptQVZoR3ZJcDZ3ZWN5cXh5QUZpNHhzVXpQ?=
 =?utf-8?B?djJvYStTMjZ2YmcxbTRBVERpSDdyTlYrU1loSXlyNTZ6Vi9KMWpmaEdZMmQz?=
 =?utf-8?B?VFN5WXk2MHZ0NTlyVmRaL011WUJ6RGRNdEJYbzZrRHY0Mm9RbDlZSFM2QTdt?=
 =?utf-8?B?TTBFanNQTFU0MzlYTisxWjhRZTQrZHI0dGRUbVEzQ205Ri9aRlZ3bm9HL1BT?=
 =?utf-8?B?K2pnWHFjRDh1OStFVjRmQVo4Uy9ybHByZDJleTJ3bE9HUC9RQnNLNVFtUE5O?=
 =?utf-8?B?Zm9rK2gwNWhYZkY4RVlLc1BLYmpsTEoycUZ1S3NTY1ZrUTdtMzVHaXRVbUVp?=
 =?utf-8?B?eGRVY29iNUQvcHdrbE1vMkNRUkdqWWxNaUViK1BtMjdFWEIvTDYxWWpHL2k3?=
 =?utf-8?B?VldtWWhYODNQeU05UlZnZ3MycnQrTXQ0ZHAxdExNd21XT0xyM25rZkdjYVhr?=
 =?utf-8?B?UVlrN3pFU1JWN3MyMUtCa2x3dkIvTXgxam96YllnVUp2dURrdERaMFV4WVNN?=
 =?utf-8?Q?czq2zEFVEPpyUubRMlSNpvgNy4Q/6Zo+vN?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFVMSnNZNEpOK3k2dE5oS3g0cmNtSFhDUUtXSFpRWUVGcWVMcmV5b2tUQ2hr?=
 =?utf-8?B?TVhBbkZvZzUxU0pGTXI0cWsySlVlK1hRS1V0VUxSMkRmU2JHMVlHTHhxTkJ6?=
 =?utf-8?B?NktvcFJqUDZIOWlrL01leVRFZEhWN01BNDFQRHJDTmNZSm5yREJpTmJ0c0JG?=
 =?utf-8?B?eFcyTVBLOHE0cmhmTlJqak1DbjBKR0RzRDZkQ1dqWC9EOTFOalEwMm4vNHk2?=
 =?utf-8?B?b0JKYnBjMHZxazlrS0FOTVNRYVB6VkdQeUZZOEVzdHc2RHpIVW9TU1dXMEUy?=
 =?utf-8?B?dk9uRmQ2a0VqNnYzMVZtaGhIbTdMejViTytrUUt4OWdmZld2R3ZwSGxYVGZi?=
 =?utf-8?B?Rm8waEN3ejBPOTNzQ2JKbEp2MCswOGQxaGZ3cGFjK3d4NUFQMHdLd3draFZv?=
 =?utf-8?B?RkpuVWEwa0VIak5jdVc2ZGVtZm5FWlpHWGlyOXdCdUFkbStKM0FsK0FVSWJw?=
 =?utf-8?B?SzVTTlFuUUFDaHpLTnhXdWUybkdBdWJ2ay9VTmVSbmlHUE9jVGtwRUVOeXZI?=
 =?utf-8?B?dlZ2ZjQveWV2cG0yOGk2bGpuUzIxSnFzMk9HWHc0MlFCNTFFTFdxZjZxdU9n?=
 =?utf-8?B?VFJyOVFqOE41THFCcklQMXBVVlI0OVoxZENUUEg0OGJiQ1duZENPbGV0aWp3?=
 =?utf-8?B?a3FXaS9hKysyeUNPUGduWlEvdzExeVpCSVlaOFQxNkJSQXhpeGZRbWhSNGJX?=
 =?utf-8?B?SGh6UHRLbXRVUGlzTmV0TmFHN1NzR1pNN3p2dDNpbExSb3lsL3Z3QmV1T3lF?=
 =?utf-8?B?WlJXRmJ4TXdJcCtMQU1XekdwalFqTXo2eUVBMlJGbG45UWR2QmpyRk03UVlu?=
 =?utf-8?B?cHh4RW9yd3UrQjBOZ2k3VVo0bHNSWUErS1VmWVRweFZ0ZVlEbTlZT0gvdFNB?=
 =?utf-8?B?NHppVCt2d3ljNkk0MzIyWlp6ZWF1U2pRckZ0c1lJNm5ONUhPczUxYm9PdUR6?=
 =?utf-8?B?NktnbkFWVGxpbi90MU0vMkxPcjJsdlUyTGNyVnhSQWVKdmkyUGZkdDRBU01x?=
 =?utf-8?B?MW5Ham9NMFJTcTl3SWhHb1pIYWZVWmJoUVpZQVFhWmVmYVJkNEdKQ29jSStY?=
 =?utf-8?B?THU2eWJFTlhkbXJFZVJjUnFmYkNOQ1RiVjZsZm5PTStYRnpqdmM2MS9ZRWtS?=
 =?utf-8?B?cWV0NXA5NGRUTXkzMzJ1d1ZONllEWnhZVExqOGFDTkxHb3JtRzBpRTJKN3Js?=
 =?utf-8?B?R21DMC9oZUs3T0M1VmZWbmFUZVBjQWVQVTd2RWpVU2lPelgxSjhGYzg2Tnlh?=
 =?utf-8?B?Q2oxWkUvWWZaeUp3TCsxU1V6bnQ2eEQ4WFoxRm5nZHJrdzdleEtTNmc1czNS?=
 =?utf-8?B?Tll5RlhoS3dXS3lZenkvZnJhOXhhVHNKZXBSRklRNkZpN2xVRWY5NmJmWjFV?=
 =?utf-8?B?M01YekZER2pvYTM5VEZpcENqZ21zRXpINHZ4SUFDUCtXMFVoSzBBYnNNZnM2?=
 =?utf-8?B?MGJ4U0huVFU0MitXMDVtbSt6T0hsS2t4ZWtmRWgwRm05QVpDQnduN0gxSlo4?=
 =?utf-8?B?aHZwRFRSTiswVWlpdkpESWk4ejdjaHI1MmE2VHBXcU53WExjV1VUZzgxcEhu?=
 =?utf-8?B?U3Jsbm9wRGVmMmpLZkx2NWd6b1diMklGQ0dFak4rWmI1QkgzNVRuYkticVRw?=
 =?utf-8?B?ZTVBU1paTnExV2VYKzUwZkFUZWNUNDExODVwVDNxU2p3K0tkOWMrK0JqdTls?=
 =?utf-8?B?Y1Rac1BhNmdOL1J1NEd6ZzhKaEVXcmJ6elZ0bGNSTW1ReHdxN3pDczF3ZWtR?=
 =?utf-8?B?eU51cFkweUgxRklDcy9kZTBoTmpHWFA5SFA0RkxqemV4di96NXhYVUZKNzRx?=
 =?utf-8?B?U2ZOdmJYNUo3YzJXYTBaK2kwbkdaVENZeEJoTjdaL0h5UFhmMWJKV2FLWG96?=
 =?utf-8?Q?owfeydcHA2iRj?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0bf6b16-bfa2-4475-defd-08df3e8cd461
X-MS-Exchange-CrossTenant-AuthSource: AS4PR02MB7902.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 18:11:09.1475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB5971
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GB_MSAUTHSOURCE_EUROPE,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

See also the implementations in:

* GLibc: 
https://github.com/bminor/glibc/blob/04e750e7/nptl/pthread_once.c#L139-L141
* FreeBSD: 
https://github.com/freebsd/freebsd-src/blob/897d3ae9/lib/libthr/thread/thr_once.c#L74

Best Regards,
Luca

On 11/9/2026 7:03 PM, Luca Bacci wrote:
> Hi Jon,
>
> Yes, looking back I should have added better explanations :)
>
> The change fixes a correctness issue on weakly-ordered architectures. 
> Considering the target platforms of Windows / Cygwin, that's ARM32 & 
> ARM64 [*]. The pthread_once implementation uses the famous 
> double-checked locking pattern (DCLP). The DCLP requires that the 
> first read uses acquire semantics and the write (publishing the "done" 
> value) uses release semantics. You can read more about it in several 
> guides:
>
> * https://preshing.com/20130930/double-checked-locking-is-fixed-in-cpp11/
> * https://en.wikipedia.org/wiki/Double-checked_locking
> * https://www.aristeia.com/Papers/DDJ_Jul_Aug_2004_revised.pdf
>
> Currently the pthread_once implementation correctly writes with 
> release semantics, it's just lacking the corresponding acquire-read. 
> Incidentally I fixed an analogous issue in Wine some time ago: 
> https://gitlab.winehq.org/wine/wine/-/merge_requests/9178.
>
> [*] Technically could be an issue also on Intel architectures due to 
> compiler reorderings, but in practice the generated code is OK there.
>
> Best Regards!
> Luca
>
> On 11/9/2026 6:42 PM, Jon Turney wrote:
>> On 20/10/2026 10:14, Luca Bacci wrote:
>>> Hello Mark,
>>>
>>>> Thanks for the patch.  Is this to solve a particular error that you've
>>>> run into, or is it the result of code inspection?  Either is OK, 
>>>> but the
>>>> answer helps us decide what priority to give the report, and whether
>>>> more code needs to be audited to find similar issues.
>>>
>>> This was found by visual inspection while reviewing the PThreads 
>>> implementation.
>>>
>> I'm sorry, but I find this patch very difficult to evaluate.
>>
>> At the moment the claim is "this is better", but the explanation as 
>> to how and why is very brief.
>>
>> It doesn't sound like you've built and run it and verified the code 
>> still works as expected afterwards. Assuming that... uh, has it's 
>> downsides.
>>
>> A microbenchmark that shows a performance improvement would be a 
>> convincing argument for this change.
>>
>> At this level, maybe you could show the generated code before and 
>> after, and explain why the change is an improvement.
>

