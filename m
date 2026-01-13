Return-Path: <SRS0=rko2=7S=originalsshirts.com=Spencer@sourceware.org>
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazlp170130001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10c::1])
	by sourceware.org (Postfix) with ESMTPS id BF91A4BA2E29
	for <cygwin-patches@cygwin.com>; Tue, 13 Jan 2026 06:40:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BF91A4BA2E29
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=originalsshirts.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=originalsshirts.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org BF91A4BA2E29
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c10c::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1768286415; cv=pass;
	b=haEF9oyYpc6TswpZL8tIwbhZ4poKPvr9agMKEr6IruNBLgU5fh/RCzfarBbVYMQ0rMqRYgE5r30k2EckfDBGf0XWpLlRvVvmjfKcyVadX9HdBLwxhOBPRTpKPun0Rx4cqyhDFOpudu/izwvH65u3ScOIFOzIDJZjDjE6AeIPMXY=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1768286415; c=relaxed/simple;
	bh=1SIzsG3usGln1BYYI0+ZetPd4uP6MNlJM5+J+NAoKLo=;
	h=DKIM-Signature:From:To:Subject:Message-ID:Date:MIME-Version; b=hir602yXDv1ttM/gk7xTP3JuCUb6djuov9WKRU2RrjJXPb1QsxzqX1uDwsFEjVjqZLN8hZXTnisEpT/9lcunIoUy1FkzetP1hPz8/9JB1tPOuMtlMkdGoY5SDf3Wwj6KKWUOaMgKzpZ3zKFFo5F1unNwPG3GDCYsr4dkSnLbJ0k=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BF91A4BA2E29
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=originalsshirts.com header.i=@originalsshirts.com header.a=rsa-sha256 header.s=selector1 header.b=lrFYOKsy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9EOuPOMDOIRxLOQmpp1Wz4E6op1AKwHQZ5ZniqiobP6v/upPPnQFTfXH2aN6lTnQv1+D9MaFMucDg+jlnSmv/aOwOjr3dz/ElZ+gdkl7yTQzpTxjmmZ7415cxYXmRwFOGYpuZhCz1D8e0xtrDa/6X1qKteS9TZEKEG95wY34GbVjdN/GPkgwNHUevfUFkY9PmLAMwrJes06QTqXCVKrPqx8fVGZmIHllX3eG8CroAxUTTvxlAb507ca1/zE0ytQFQJOfMn4Gg3ghaEdGign6an8lXzwjJPxLFFtrT+ku7QM04zY04+SpWeOyGyfj7fRPWVxM/ebUocMEKtRFtTcyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exaqWqTwN19Byknt0ly4EENExbB0p0G/3p1cLJv1NYI=;
 b=iZ1U+RQ8hGhQx1JqiqQbb1WYwNm8ZOu6GF1a5EClpbI4nCPPcrv1R6/58heO24/MdfxgFaaFfyvQEohZ+dPwIR5mEbY5+9qV/UGo1srDEvDtPUoIvrA3aRxARDZV8/2GS4/MlbljuGNL93z8Ko10bjmY2xyCt+0R5M3vAKtbl/4tPXeEjD9CYtpg4+yVyEvSxmB8X+2wcoLnk/Q5malLeuF7kswySAmECZyY3gyIXjTqahW0FK+oKVTAcDvaMk3o3k7N3mAQUtl8TOIPe//lxTo97XJr4EqQRW4ft2c3t1/UXE7Z2s700Ea7IchktzpO7f3LnDlLpoXM46kYVnoJew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=originalsshirts.com; dmarc=pass action=none
 header.from=originalsshirts.com; dkim=pass header.d=originalsshirts.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=originalsshirts.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exaqWqTwN19Byknt0ly4EENExbB0p0G/3p1cLJv1NYI=;
 b=lrFYOKsyrCjdzvxUIIHoPPHHvkuSAqrNoi6E7ytYsjklOSYuFOIfgXpjIGpKD9gQARV44FUTp0kjt8yMZJU4v0ivvjsQygJrXMcB2og5HIbv8WN6yu4PZZFHNPOAaUGFphhF/RDIOkTP0qFBHG32eXBAcebcFD6gorc2CU0kNcEDsJg10DzEwkaKYfjG1NVAAfKYKQGyW/oy2lnVgGwVE6bBZRwbfxQzjwcfas4ddLR/Cz0twDtw8TuLD6RifUOOezVdFgOa+MxixRgNSQLOcChKSTT5zrgrwJUatXlLhrSo45504sUW/6ikH8fdJ1D4r1NZcJZ0uZr3ld8ZAve2Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=originalsshirts.com;
Received: from SJ2PR10MB7707.namprd10.prod.outlook.com (2603:10b6:a03:578::8)
 by IA0PR10MB6841.namprd10.prod.outlook.com (2603:10b6:208:437::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 06:40:14 +0000
Received: from SJ2PR10MB7707.namprd10.prod.outlook.com
 ([fe80::a28a:1dbd:e1bd:e678]) by SJ2PR10MB7707.namprd10.prod.outlook.com
 ([fe80::a28a:1dbd:e1bd:e678%3]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 06:40:14 +0000
Reply-To: <originalshirts044@gmail.com>
From: "Spencer" <Spencer@originalsshirts.com>
To: "cygwin-patches" <cygwin-patches@cygwin.com> 
Subject: Great Original Shirts
Message-ID: <d5ea8aa301f6fe438ddf0d95f45acde7@192.168.6.158>
Date: Tue, 13 Jan 2026 01:35:06 -0500
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0001_7D4591F9.6961494D"
X-ClientProxiedBy: MN2PR19CA0024.namprd19.prod.outlook.com
 (2603:10b6:208:178::37) To SJ2PR10MB7707.namprd10.prod.outlook.com
 (2603:10b6:a03:578::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR10MB7707:EE_|IA0PR10MB6841:EE_
X-MS-Office365-Filtering-Correlation-Id: dcb1cc87-8958-45c6-5f32-08de526e9b5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014|8096899003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sy8zcGZYOXByT29aU1FpbTlZSE1oRlB4cEJiNGRSMHlyZkQzalFpb2h4VHNp?=
 =?utf-8?B?TlMyUWVuUWRtYUE4STRTUTdOL1FHbk04L0MyNEp1aWJ0aGR2TmxWYUlEKzBG?=
 =?utf-8?B?MzBWSDZjQlpWVEZHZTBacm9sUDFaRWtVY1VhNmVHQmxpU1FWZTRwelhTTkIz?=
 =?utf-8?B?MTZPRnJjS3I2Z0d3TkdmQnVwRUtoSEdwR2QwYWRCbktzblJCMkJheFdpUjBm?=
 =?utf-8?B?Z2kwbFc5azk5MmYxYnRkZU4xVGZUclp5eVZxZjdaMGFPQzBkckdWMVFtcHBZ?=
 =?utf-8?B?QUVNK3owZm5oOXMxZHpXb2dqaDFtaEdXTDZmaXVUcEs5QzFOYVRicTJueDk4?=
 =?utf-8?B?N3ZtQm5qS3FFQVAyS2ttOFl1M1V3SktHTkh5VHFUbU55Y29tQ01CQ1Z5dWNJ?=
 =?utf-8?B?VFhUdXl4ajBJRmlPTytGcDJ6TWJtL0FWZU5xYlBqWHFZbFFIb1RqK2k1U1dN?=
 =?utf-8?B?d3h0cWFxSndidy82V1ZMeUJJUU84UWJnbi9tNFloeEUvTHJ5Zng2LzlrTm5E?=
 =?utf-8?B?WklnTEl0ZmhRVGlIR0xjTkxWb2NWditXVFUrczBqd2lzNnhyZnltUU9DOC9L?=
 =?utf-8?B?ZDFFNFlXYk9BZHl0U1RSVndCeE5aWjU0a3Q1ZElIVndaM3BaSWgyQ1J3UWZW?=
 =?utf-8?B?dkdBbFM4RzdRRktKWjVpNmRtWVhsZW1vZ1BHeGtTMVpBM0ZjZFI5dUovQU51?=
 =?utf-8?B?bkpKWmtXUkxxdWVUTlVyL1BhenAvQy9jV3JOQWhDd0VVNldNN1JPWTRDQVFr?=
 =?utf-8?B?eGw3SFc1ZkdWNzBod2FCaVJPcElyclQ2L001OWxSWHE2Tm5weUtoNVJuK2U2?=
 =?utf-8?B?OUVvRHF4bGlibW5HVC80QndOUXJqTVMvVEtQdG9EWG5QdCt2K096MHpPcFVi?=
 =?utf-8?B?eTJ3WFEzSkV0aThyRUFsVjVFY3pJSnJqcFFENXFEb0xBRWNkYjh4UVNxZldx?=
 =?utf-8?B?ZUE1S1pCYkg5MnpxWEVuUW9CbTdoeGJkUStiNk0rK0hiZTNBYlZzVzhZUHBS?=
 =?utf-8?B?K2VmZjdqWmNFQ20xL3dWc0J4NXhqd2x4NE1YMlFTQjNLbnJqdEpNNzdQNUJH?=
 =?utf-8?B?TFQ5bDRrN2ZlTlNBU3Q4RGNKQTkvaHRMR0F0SzFhNWVEbENsS3dYWmF0TkRS?=
 =?utf-8?B?OXIvUHdlaTJ0N0xQVzhaNzd1WTQzSWVCYWpSaHUySVVZdk4xc2hxdm9Sc25l?=
 =?utf-8?B?aCtidHVHK1hta1prUlZTajNJdXhXRlRUQWJ1eHc0Mk5CUEZadGhONWQvWXNk?=
 =?utf-8?B?cU5UclpzQzNQMjBLdTVleVJ0c1FDNThXeHo0TEFhcDQ2bzhsZVZHWlVkVHZ2?=
 =?utf-8?B?YThCdEF6eFFkekcrS0FRMm5DLyt1N1NVTDBhMk1UYXlvQ0xxWjlBSVcyVU5G?=
 =?utf-8?B?QTVZbWdneGw0dlIwN1l1b2hTaVBNOXVXYVd3SzdBdnpHTEc3TnpoNSthcFlr?=
 =?utf-8?B?NUJOQktGOUd4U0UrZnlPVFN4OEVraVlBQnBibzZGRnJKN1BIZ0RjdFJBN0lp?=
 =?utf-8?B?dDlEYTBmZ0puSFFyeVdmelpoeXhuNHVqQm12UWxXcDVYcEZMbGFndmx5QVZa?=
 =?utf-8?B?dkxHaENRODBHTDRKNmkyVjBLWjFmekFnNER3Z2hUenZNWEc0QiszQi95bC9a?=
 =?utf-8?B?TlV2bEhkRnZRMFlTYlQzOUdMbXJ3V0w2RWUyWElFSUhGNXRnN3JsRjYwY1ZZ?=
 =?utf-8?B?RW80b1c0V25NYW9OVVExWm1DSEZQT1duK1BxMlZNQjVkMjJlSlF4bUQzWlA0?=
 =?utf-8?B?eXpaYTRkalF0bkRDSzJoVmtoeVU4OGNyVWQyNW9zWGdZNk90VHJ1NlNUSGtM?=
 =?utf-8?B?MEdLQnBGUXJqR2ZWcitGRmM5ZU50a1NrUEJoeXJObm5LbldhT01rcFhaR1RP?=
 =?utf-8?B?S21zUllhdFlWdXhoMitHRFlhUTNCMldaYkNHVXV6YmJta1hZM2tXSUN4MjZu?=
 =?utf-8?B?NG1RZnp3WlFFcVJwQUdoaUFGTmRCUy9qOS9DRUM2cktheG5vLzlvQ25iK29z?=
 =?utf-8?B?WGxsMy9OQWV4cndEZUhyUmhHWjR3UVk5SUhVa0poNlFYc0k0SjcxRFJPRTha?=
 =?utf-8?Q?MoKQU6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR10MB7707.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014)(8096899003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXN5OHoxY2dvUzhmNnp4Zlkrb3Q2RURTOXVTekZyR3QxWnVqTFV4NDloQ29S?=
 =?utf-8?B?dTFJdnhuNDMwcXgzczVMeFAyUm1INWZQalM5cUpoUTlBdStRTks4YjVjUmRr?=
 =?utf-8?B?MVAwWmZXeFZ1R2VEalR4dmVRKzNmTmtLQ0l4d2pyWDhsTXgxdzlacHdrYm82?=
 =?utf-8?B?TTVnTDlLcFBkNlJPVUJXT1VlNVcvK25qR2RKaEhuQ1kzU1MrMm1DM3dFZWw4?=
 =?utf-8?B?SXc4QTlaQ0V2OEtMeGRDcldWYXRlK2tDZ3VJZ3VVOU93NXdEcTluRU9aTHA1?=
 =?utf-8?B?Njk0eGdXMmtpVldxTEpwaGh0MXM3M3VnRnkwSzFMVmdHTy9wRXRyZmNLbnF1?=
 =?utf-8?B?UHcweFowc2NsS1ZFSFY0SkNWeXcxSW9DN2JLbFl2ZXYzd3FMS1V5S1Z6ZnFE?=
 =?utf-8?B?RG1BdjZ0QXI1MXJkSVdwQ3JMT0pjWnhYYm9xeElaaW5Yc2FHQjZkZWNhU0Er?=
 =?utf-8?B?YTlNNTZzcnZicXJpZ25wY2hwWWlXcE9EQjFnNzNaZisrSjBMZm9xMXp1NEZa?=
 =?utf-8?B?dVB2L3RBZlNOZGZCTUdVUFNNVlZIRnJQYkdFZTdnUW95L3RRSzU3SXh3R3I2?=
 =?utf-8?B?MzdMeDZjSGZpOHJLWGFsWENvUm0rNmVyUTNkUWNZY2pjVXpRUFBEWFN4V0My?=
 =?utf-8?B?UEVVWXVRZXVIQjNrK0RpZVNZMnJpL0R4TE1Fak1kazJYTDdGeWtVdjV6SDlK?=
 =?utf-8?B?dkJmU3daNEZYTmR2K3Nkejl4Y2RPaEV3MmxXeis1SEQzeUhOZzBHb25uUHhP?=
 =?utf-8?B?bTNYbnJ4Z0hHcjhaSTE0R0Y2M1lsam1EZXdwelhuc3RsenFnZFlPeFBtNlI3?=
 =?utf-8?B?QkhydGwvLzVwVENhVXc3bHJ2Sk54ZmNJTG1ZNFd6Y1pOMDRGWGhpL2ZDVk1K?=
 =?utf-8?B?YVZqdUp0T21lcDVwNVdUODNsbm1nanJRQWhjT2RDT055c1pQb1RWNHN5YzBK?=
 =?utf-8?B?REdVbFlaeTlvL0ZkQ0hLZVhjNU52VnlQQVNZTGMvQ3o5Qjd5VEtUdkwzR3Zn?=
 =?utf-8?B?MUpFTzAwQzNXTnFiZzFyT3RYNUlMKzFyOFI0YVlnQ0dpVHNpa25DT0x1UEpk?=
 =?utf-8?B?N3h4K0JYK2RXdHVRQUs5N1J5RFQ0blZIcFZnb2xiViswL3FKeXdpdDdnSGZr?=
 =?utf-8?B?MWlSMGtWZ1JzelNtTTdJazNNbG0wTlc4ejhoZkFyc1BvQ0FUSnNlakNMVTFI?=
 =?utf-8?B?aS9mSTR1V1Z5b1VBSXhEWksvVEc1aEJyYUtML2h5ZjdCaHZ5ZEhnN2IveVhz?=
 =?utf-8?B?UWw0bUV6MkN1VmtKRmNDekRpVStlNjVNMGNJbG5WdGVuK1BYQ2ZDUG5IdC9k?=
 =?utf-8?B?Z2NWVlU4N0xlVFNmUFdpeitsV2dTaGM5Y2xhU0NsSGxLd3ZDUGE2MDFGdTVh?=
 =?utf-8?B?cmxkczhXbnNYNnNIalNDUzRaWGdyV2tRdzlWR3o3QjE5d3Blc00yVVoyS29Q?=
 =?utf-8?B?d0xCUS82bnB5WnVBeTBXMlFNWWs3eUE1NkMxajAweGUyYnNXWW9CclZ2ZkNw?=
 =?utf-8?B?RldmTVU2bWtaZ3hnczNseUpWVzZidklhVWs1bzV0QnhrKzAybXk3WmJUT1NG?=
 =?utf-8?B?b1dnVHNLam1sSHEzWXRUNzUzcUlvcU05SGU5Z0F4MUVpbzduVGZLaGZLRE5R?=
 =?utf-8?B?amxkRjJia1lSWlU3MVg3MVNYdXNSbWRpWWFZV0Z6UlZwY0cvV2d2R1U2cmlD?=
 =?utf-8?B?MXZBZnlJZ0hCVTJsNHZISEVpQzlneC9oeDRQVmlQdVU0RHJSSUtQa0FZYTkr?=
 =?utf-8?B?QWxlaGZzNDVBa281Mnd0QU80cFZZczlrYjFaZU9nSjA3ZUh4c2F2QWZyd2tH?=
 =?utf-8?B?a3BQSGMyM2o1RlBteXZQZHdCdElCUG0vUUMyaFdOWmFvTzVGZEFneWVYWVBk?=
 =?utf-8?B?VmZzdmtLS3hQNmw0R3dRc0UyQUo3Z2FuT0sxOGl1NktlNVdqaTRpK0JKUlFD?=
 =?utf-8?B?alplUjVGRVBaSmhkV1owRjZTUTVIL2JUMUNHdkM1akxxME9wWFBlRjJHYmlp?=
 =?utf-8?B?S0YwVEVBRktSZS8ySG9NSDRrUHVpVVVHdyswM09xajJ0UjlySC9DY2JwVGdP?=
 =?utf-8?B?NlBHcTd0U09QTHMyN3A3VE5FWFkvUVNTeEwrNVB3VHZGaTNTU3BoNjlxN0Vv?=
 =?utf-8?B?VVBkVWtESlliWXROU3cxd0sxTHZESjk1eWtTUTYyMFFmOTc5MldYQ3BxOFVn?=
 =?utf-8?B?dU1pdG1XcCsvRXRVSmVhWXRSSFlybHBXTzMrNTdoZi95NXI3YjlIaXV2eGNv?=
 =?utf-8?B?YjNtLy9NbjI3dVcxcTU4YlBMZXJPRkJIbTNYVjh2bHc4UWZUVXZCUmNiRWlD?=
 =?utf-8?B?UWlIY2Q1SHRUNVJGNFNSUkJRSyt3TjA0THJ2cXA2ZERuY2FwbnNQc2k2K3pF?=
 =?utf-8?Q?eUR+XTNOP9d8JIQg=3D?=
X-OriginatorOrg: originalsshirts.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb1cc87-8958-45c6-5f32-08de526e9b5c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR10MB7707.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 06:40:14.1006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 9ccde56f-c691-406f-a699-cd6c83293588
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5EFyzyfO8T1P22DFRn01NIuOnNu8pTSqmRhL4gGBqvOWI0XYYSCbuIU+GYrrq4z6JJEPub5RzT1Qmq+N1147OdMTCcUj+Sb+h0q9Up2DPns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6841
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_40,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,HTML_MESSAGE,MIME_HTML_MOSTLY,MPART_ALT_DIFF,PDS_TONAME_EQ_TOLOCAL_FREEM_FORGE,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

------=_NextPart_000_0001_7D4591F9.6961494D
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable



------=_NextPart_000_0001_7D4591F9.6961494D--
