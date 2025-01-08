Return-Path: <SRS0=+JKb=UA=cornell.edu=kbrown@sourceware.org>
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20731.outbound.protection.outlook.com [IPv6:2a01:111:f403:2412::731])
	by sourceware.org (Postfix) with ESMTPS id 6CA333858D35
	for <cygwin-patches@cygwin.com>; Wed,  8 Jan 2025 23:04:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6CA333858D35
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6CA333858D35
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2412::731
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1736377445; cv=pass;
	b=V3ULt63apWUCB4ttbYBhBSUO4+/tCnN8skpkU1AHJhiC68ip1dgH74A0pjIvRmiwo8ryGq1q3IlHJqYSiEfYzeQ0m9oM/nM2LwQwoHAfQrpmXwUllik2XC2TrwbRW+fopq/Hkohwj9+2VlTm5E9tVI6mO0GxAaIgKJl2SFtsubk=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736377445; c=relaxed/simple;
	bh=XJJ236nT7K4LMKToHpe+ZFW8WOOFfI6cXs1IJk4rz3U=;
	h=DKIM-Signature:Message-ID:Date:To:From:Subject:MIME-Version; b=VaXIcqyomp0Dn1jftglPQZs1bv0krPpGbcGRGUuC87O7StdjQIhjSi9ExxAJBEU/XSLuLlI8JOeB5JMFajoo2VgswxRNV/esSuNLQcKvxZYiqn19+fSx2OuNMnlCK2OZfWK1cqFYIa5epzM7K9K1Nuz213zJBX+q4Epeuh6wF/g=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6CA333858D35
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=cornell.edu header.i=@cornell.edu header.a=rsa-sha256 header.s=selector2 header.b=VQLWtBND
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SmY4umX/0p097owueSIo/E1fmyQ6eTs4L4QV7H2Xhf10JS4njppVMzDCxKTFwMk3jzm7ZZZL0SpRLDXoYFtqXbZrbKGuX/DD88eNxjnyUFlDJmtaFn9WVWBBODUkUX5vkWPXSCgEWpcG8U6t/FXJR4pkD3dKIVimINdOOFMxoDLDrIqW7bS+7H9s++letGw/ZgdEQ9PTUdWHOy6nRCfWj0AQ0qNa/vNpTmtzAPh0dYt3SlFSh2EDioUN1Lruo1Vwh8kyCYq+r1jhdXxLbxw99atVmwZRN1pmXUx8P9AgwuTnMrm9zNCEx9OHSq19Zerbs2ei47x7jjLkXRaS5ETcGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJJ236nT7K4LMKToHpe+ZFW8WOOFfI6cXs1IJk4rz3U=;
 b=GNvzpuIE3LlA5vMNJn5Ojp1J4+OGDvijf+qa1N5pYRJNsdEWiO6F5qdKEBLrUUr1tfXF6hG5sJmiYE0KlEdIz/tMiMymK0OqlGs/aoVchnb2afH4fc3O3J50Ca2Q+k7I9p0QfTdfGPLIoMZ0d49slUo3j8oKYe+otFmRRlnPvh5S8U4wvB9+4SRBTQThTEhw5+EMRBoSRCQd9otsjPihb0AQJw61cg063GkRcENkzna0hVfPyKsqZ8o6a30BaSF6EP0rbk00OLHyKz6Vy/DitWBn4LAyMIlGeqpGEJefcMNK7a9k0S6oR0GU3hs433IkkTZYr+ytcxBi/TpXlxaZOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJJ236nT7K4LMKToHpe+ZFW8WOOFfI6cXs1IJk4rz3U=;
 b=VQLWtBNDqtAVcKgwiJvCArVjdZdUwjbJakizW5/WI1hF0nUlGzH+9ynk1jxcqhE0fvGWeDFCgR7Q6Uz0Xife3pddDXVD8djYq2657swdz2I45i+1AYVax4hds96Gj2k4c4Q/swndGQgaHgHLFDT3B2dQdJX4OLh1oF1xIVARwYw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from SN6PR04MB5151.namprd04.prod.outlook.com (2603:10b6:805:90::25)
 by DS1PR04MB9654.namprd04.prod.outlook.com (2603:10b6:8:21d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Wed, 8 Jan
 2025 23:04:04 +0000
Received: from SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd]) by SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd%6]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 23:04:03 +0000
Content-Type: multipart/mixed; boundary="------------O90fi0UM3Hsvq00jkPMR0XGk"
Message-ID: <980ea390-abbd-4894-b80b-906ac1cca243@cornell.edu>
Date: Wed, 8 Jan 2025 18:04:01 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: cygwin-patches@cygwin.com
From: Ken Brown <kbrown@cornell.edu>
Subject: [PATCH 4/5] Cygwin: mmap_list::try_map: simplify
X-ClientProxiedBy: BN9PR03CA0973.namprd03.prod.outlook.com
 (2603:10b6:408:109::18) To SN6PR04MB5151.namprd04.prod.outlook.com
 (2603:10b6:805:90::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB5151:EE_|DS1PR04MB9654:EE_
X-MS-Office365-Filtering-Correlation-Id: e567b26b-1345-45d7-f874-08dd3038bf08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmFSM2s0R0lVdmJQOFpFQmpUU0dYNU00N1NIczJBUFA5STB6Q09LaTM4a3ds?=
 =?utf-8?B?QzZsYVJiVjQwTWRNS0N1UGlOOHBRY0tDazEzVnE2a2hQSEZGdXJ3dlFFOHUr?=
 =?utf-8?B?dE8rTzlDSy9hV0hOU2ZSU0trNEVRRTJFTG55UnNZVHFadC9FWFJ1NVdOWEk2?=
 =?utf-8?B?V01ibXpYSDVpckdaU1JrdlJjd0MzNGNiWHR1ZENRU0RXcXNJMjVyUEN3NDZO?=
 =?utf-8?B?VG9OL2tqVlQ5YW02bEltZFEzTExRVSt1VUVBeWIyNFJNK3VKUlBNVUpkamxP?=
 =?utf-8?B?WXQ1Vk9VblRaT0hISkgyVkx6a2EvRnhFTEhLSWFBMlBIcUpnSkcwTThvKzBk?=
 =?utf-8?B?Qks0WmRuYnhPaUJ6T0xJWU9wdm1GdzdLNkxZRTVYYkxmT1hpSmZxc3MzYXM2?=
 =?utf-8?B?eUVJMGlFcGN1RVFDNWI4RUg3Y1R5bm1vLytiUTJRdm00SHRpRzVyMFl1OFFy?=
 =?utf-8?B?Vml6MTdPYmp4MkQ3N0RSZ1N5UkI1Z3Rlb3JKQXZjL3duSXVlWEc1dVU4eHFR?=
 =?utf-8?B?aW53OXRGY1BaU3RIUXJrTEVOL1hjYTZpTWQ4N1dxSUtKZk8weWRjK1YwSTBh?=
 =?utf-8?B?T0I0QXRDMDhUYURTaGxHVDh3VFUyTGlJdkxlZTZTejFmTklVUVNmRFBZVXVn?=
 =?utf-8?B?K1IrK3JEUnVpL0VSQitmM2x5WGVMekdzVGFhdzVmZEpDaXd0UXBZVUdYb1Bs?=
 =?utf-8?B?TjEvOWdKTHNOS2RZK0RtcFd0M3VWTjdPb0pHek9IT3FSR0JWbjlNaUlNZHpY?=
 =?utf-8?B?RWIxSFl6Ti8waFF4NGFKbERMcFp5eTlySFZFdnRrYzdXKzJNQnYzcTZQZkp1?=
 =?utf-8?B?VUZSdllrenFkbFRodmYzd0c2eWJqei9TK1NSSnZBOXhFM0pBZkRmRnFHbStp?=
 =?utf-8?B?Titqek1Jcmxxdy9rWDQ1dnNTMVU2YldXQ20xNEhtV1V0d3lSVmNDSWZpTDlO?=
 =?utf-8?B?dzZrRTJZbXF5ZDRFWXQxNWFvNTkvQzNLM1NrVFZJUTgrZkEwSWhvR2tiaUtB?=
 =?utf-8?B?MFU5dGpIbUFSQlZmZ0NwUnJuSzlic1VQVks0RzlpSlJ0bEVFSmkxQzVHL2Fo?=
 =?utf-8?B?TGZtQmhxS3NuSHdHOVZlMlhRY3Q2aERDVDNHV3VJY053ckJOWlpPcCtoRkR4?=
 =?utf-8?B?QVdDUVE5NzAwR1YxSU93eWI0QmpROWFhMmxpT0x3aXR3RDczSDFHeGx1Rm5R?=
 =?utf-8?B?bVdaZDlRSmwvMm55RkhDWG4ySER1T1ViY2lnYnE4M0xsdVJmMm03MjBXbEdX?=
 =?utf-8?B?VUZjT2JSZFhJdjVVdzRpTWpBd1JJSjlxbGRDbVhJZGU1eG5MZW1YS25VNEpU?=
 =?utf-8?B?N29Ea2ozL0tKU0xuVXFJSW9yYW5Wb25mTVZOOFQvSWtpK29QUGxQR2JKenl5?=
 =?utf-8?B?ZUFGbE54THNnTFRPU3h2eGlnUHBkd1UzaDZ1MFhXUG9nRGI3ZkswdUVqdnRN?=
 =?utf-8?B?ellGUHhrdjNwRGtzWXQzaEZVbTNUZTlSa0RnMlBMY2xEeXNLLytkaEpmckR6?=
 =?utf-8?B?RkhsZlZnaWJqVzk3Y0pNWmwxYTlodllFMzJqOFFCelFZS0ZZRFBxcFh6cHhs?=
 =?utf-8?B?clhLVktHR0ZvZXE2OG8vRDVqMVp5Y2FBL1ZPczRjQVNaeG1ZMEI1dTZwSnBa?=
 =?utf-8?B?QXBaeUduTG9CT2VYd3VXckE2SUtleUxYRUNrRGxILzR3TG5NYmtZRjNYeWJa?=
 =?utf-8?B?aHlEdDBGWWtUR1NDQy9ic0ZEY3Q0MWJKbVlVaThMTWp3RHA2cCt1QkkwR2Jn?=
 =?utf-8?B?NUwxOTVNUGR3MW9GdFFHaFhPZTdkSXhNd0g4NUthVjMyRVdINDRCcWhFMDUz?=
 =?utf-8?B?aG9sZndBd3hrZy9CcUptRHFCRG55bXVGVlkrR0EzajB0MWJlbkluRWpwQzd1?=
 =?utf-8?Q?hl7GJhzdoUeQw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB5151.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHhSUWNzRm9oMk12V3NkVUZ0TTg3YUtEbDdoZTZaZVYrbk1QUHNVOTB4WmlK?=
 =?utf-8?B?Q09NK2p4ME9QTTJoa1MrRWd3bWRGRkg5ZHl6TW01UFNMUHhNSkRpQURtUU1i?=
 =?utf-8?B?a0x6WHJmUStHWC9WcFhPYngvS3V4K0Myb1NkNmxwSStML1Z0L25ISVdSTlNE?=
 =?utf-8?B?RFprbmVWbzVaRVZtMmdIb3RjdkFJczRJN2J3K2ZGM09YcEp4bFFKdGxOUmZW?=
 =?utf-8?B?Z0d0TTN1eUtIbDdMbkcya1BIdUZDVFVUZ3IzSTF4MFhRM1phb1NLdnFNek05?=
 =?utf-8?B?NUxnVVlacm9EZE1ubzNDU3hrK2lxSnNOZWdRc1RscjNLUkZsMmlYa3Buenk4?=
 =?utf-8?B?WThiWGRtZEFQTTBiaTZvL05WT3VhWnJkTXlHd2QvMk5Wa3c1eVBBenJKZ1FY?=
 =?utf-8?B?cW1qMzVrZW5KSkJKeVpxazNDMzhEYVFoenRHZkZWTGVaZWE2a2hwUWgrZVN3?=
 =?utf-8?B?R2haeFVlNHVSSW8vWDE4ckI3L0Q2b0kyUkRtZzFoYUpUcW5iSDdNTis0NTky?=
 =?utf-8?B?SXY2SjdOWDU4NUgxU2x5YnpMUkMvekZkcjJRNWduTk5RR296NzlrTCtWNkJP?=
 =?utf-8?B?b0tIcHRRSmRtbUdWMW54cXNIenV2MnJreWh5OWRLK0NhWnUzdkxleWJjNExp?=
 =?utf-8?B?cUI0Q1NKaXlsY0pTS2Q4Mlp3bklVOTJ5a3oyc0Rkc2Z5WXREZTh3dTJET0ph?=
 =?utf-8?B?RFYyWXVFZjZDWXpuOEdoSUZZUFZ2UHNXbHIyRHVKaGU1K0VUWUFLMWpZenhN?=
 =?utf-8?B?d1luazZhaGpNTzlzUTY3TklYUm1WSEZhZjhadjFGandMeVRhSW9aOXQvdUJ4?=
 =?utf-8?B?TmkwYjlqTFAyZTJNOGZjN3JNRzBSdkVDZ254dWhkTld2djNyWEoySEhnMFM1?=
 =?utf-8?B?Zk5OZHRYYWRQdTdWZXF5MjdIbFZjR3gvMC9xVWJsMmNYdUNaWVJDb0ltOWhL?=
 =?utf-8?B?YjRVSnRFZ2h3V2QvS1k3NzZIMlVMMmhhOHJJSGJKMXRQbWxoZUVwNENhNURF?=
 =?utf-8?B?eGZaRUp0YSt5QWp0aDd1RlNpTWVmVUJ6aGw2RXBmTkNQRlhoS2J2V0wzOGlF?=
 =?utf-8?B?R2FZN1plYjBOQVUxK0krMjNCbXRrMFlwV0VBcXVIcW5rNHlqYUlER3J2clhU?=
 =?utf-8?B?RkczUUFubG9tZkVJR3NCdVc0NFZEZW1iSGFmOEVEUGc5Vy9LbXVzWC9yVXVE?=
 =?utf-8?B?U2lRNUZIR3dWaVhxdUc0eXZ3aHQ4Wi9FbzNTaXJjb2s5N3BSM0NMcDNVVkgr?=
 =?utf-8?B?bkJISTlSbDlxZGZJQ1l0YzZPbEhIRWd0azdZNDk4MDhhcStJM2hBbUdaNi9S?=
 =?utf-8?B?L29OVExwanBaVnJHdHB4NzJsVDNiQ3VUWkFsYTU5THhjT2dFN05EbVlSWHRK?=
 =?utf-8?B?Y2VHTjE3d3RscjVrUmNsS0c1QnkybVdaU0ZFQUx3TU9PREJBRm5lMVVTb0pP?=
 =?utf-8?B?OERIeVA4YkF5eGIzUWt1b0cxRXcwYitHd3oraTgzcjY4emlkeEQyV2JmSlhM?=
 =?utf-8?B?RW9LaDFOc05wc3NUeXdrM1RUM3lQcjZYM2dVd3hHeGVxbjNzMWtPc1cyUjZr?=
 =?utf-8?B?ejVzOU5qMXVDS1pvVlhOVUZ6MFlYSEtweHhUSTJUYmRkeXNVeFNDaGt5bjZC?=
 =?utf-8?B?MjB4c1R6WHl3V1kvYUhZOUxOc1diTFNCb1JXNnd0QWd3bGQrU3ZVaDFhMVBU?=
 =?utf-8?B?bGZudmdyV3NURjYyb2svWm1xeVBLaTEwSlBsRVlvOHJQVklVMURTOVh3OFhX?=
 =?utf-8?B?cEhkK2VQM1p2MVZkWlBnTDRITXEyZUp1aWlmbDcydnhIdlNmRWhJaC9heVZ6?=
 =?utf-8?B?bHhFRzF5QVZBc1JwUjJhb0ZpZ3lqejFaY1M5VTByUzFzaFN3Z1VSc3FqMkZo?=
 =?utf-8?B?ZDR2R3k0S2sxV0kwZW0xNEZYS2J5cDh0VVV3MXBiN1E1SGplSy8vOE9iSFpv?=
 =?utf-8?B?cURZaHhoTGhhVUdjU2pOY3U5WjdPY3NBRlpYWjBKeUJrSEpHVXBFZmw3OXRO?=
 =?utf-8?B?Tk5EOFJRVlJOeUxBRlA3S1p6UDdyNUlzbXhOR0ZhQjBGaUY3WEpmQXJTWCtu?=
 =?utf-8?B?OFVpNUtEODdVaWZxbTlDdU42blFZaVpnUDlvNi9rcDhQRmV1alVjNG5mRzNS?=
 =?utf-8?Q?uOJ64p6rsfoa/5Qc393z7aDPA?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: e567b26b-1345-45d7-f874-08dd3038bf08
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB5151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 23:04:03.8864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jb3+u5hIX4J1THmKC00Pzl/4QEPsD+HoqJmfIoy7tlvX/isC/AvPs5DHXZvR8z/IgVAgd9nunlXGV7NGBaEMnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR04MB9654
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,JMQ_SPF_NEUTRAL,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--------------O90fi0UM3Hsvq00jkPMR0XGk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Patch attached.
--------------O90fi0UM3Hsvq00jkPMR0XGk
Content-Type: text/plain; charset=UTF-8;
 name="0004-Cygwin-mmap_list-try_map-simplify.patch"
Content-Disposition: attachment;
 filename="0004-Cygwin-mmap_list-try_map-simplify.patch"
Content-Transfer-Encoding: base64

RnJvbSBjMDFkYTlkYjFlNzY4Njk2MjFiNjNmODA3NTUwNWZhNDlhY2YwZDU2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLZW4gQnJvd24gPGticm93bkBjb3JuZWxsLmVkdT4KRGF0ZTog
U3VuLCAyOSBEZWMgMjAyNCAxODoyMDowNyAtMDUwMApTdWJqZWN0OiBbUEFUQ0ggNC81XSBDeWd3
aW46IG1tYXBfbGlzdDo6dHJ5X21hcDogc2ltcGxpZnkKClNhdmUgdGhlIHJlc3VsdCBvZiBtbWFw
X3JlY29yZDo6ZmluZF91bnVzZWQgcGFnZXMsIGFuZCB0aGVuIHBhc3MgdGhhdApyZXN1bHQgdG8g
dGhlIGFwcHJvcHJpYXRlIHZlcnNpb24gb2YgbW1hcF9yZWNvcmQ6Om1hcF9wYWdlcy4gIEFkZCBh
Cm5ldyBwYXJhbWV0ZXIgb2YgdHlwZSBvZmZfdCB0byB0aGUgbGF0dGVyIHRvIG1ha2UgdGhpcyBw
b3NzaWJsZSwgYW5kCmNoYW5nZSBpdHMgcmV0dXJuIGZyb20gb2ZmX3QgdG8gYm9vbC4gIFRoaXMg
c2F2ZXMgbWFwX3BhZ2VzIGZyb20KaGF2aW5nIHRvIGNhbGwgZmluZF91bnVzZWRfcGFnZXMgYWdh
aW4uCgpTaWduZWQtb2ZmLWJ5OiBLZW4gQnJvd24gPGticm93bkBjb3JuZWxsLmVkdT4KLS0tCiB3
aW5zdXAvY3lnd2luL21tL21tYXAuY2MgfCAzMCArKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0t
LS0KIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL21tL21tYXAuY2MgYi93aW5zdXAvY3lnd2luL21tL21t
YXAuY2MKaW5kZXggOWU2NDE1ZGU5OTUxLi45ZWQ5MTMxNzcxZDcgMTAwNjQ0Ci0tLSBhL3dpbnN1
cC9jeWd3aW4vbW0vbW1hcC5jYworKysgYi93aW5zdXAvY3lnd2luL21tL21tYXAuY2MKQEAgLTMy
Nyw3ICszMjcsNyBAQCBjbGFzcyBtbWFwX3JlY29yZAogICAgIFNJWkVfVCBmaW5kX3VudXNlZF9w
YWdlcyAoU0laRV9UIHBhZ2VzKSBjb25zdDsKICAgICBib29sIG1hdGNoIChjYWRkcl90IGFkZHIs
IFNJWkVfVCBsZW4sIGNhZGRyX3QgJm1fYWRkciwgU0laRV9UICZtX2xlbiwKICAgICAgICAgICAg
ICAgICBib29sICZjb250YWlucyk7Ci0gICAgb2ZmX3QgbWFwX3BhZ2VzIChTSVpFX1QgbGVuLCBp
bnQgbmV3X3Byb3QpOworICAgIGJvb2wgbWFwX3BhZ2VzIChTSVpFX1QgbGVuLCBpbnQgbmV3X3By
b3QsIG9mZl90IG9mZik7CiAgICAgYm9vbCBtYXBfcGFnZXMgKGNhZGRyX3QgYWRkciwgU0laRV9U
IGxlbiwgaW50IG5ld19wcm90KTsKICAgICBib29sIHVubWFwX3BhZ2VzIChjYWRkcl90IGFkZHIs
IFNJWkVfVCBsZW4pOwogICAgIGludCBhY2Nlc3MgKGNhZGRyX3QgYWRkcmVzcyk7CkBAIC00NDks
MjEgKzQ0OSwxOCBAQCBtbWFwX3JlY29yZDo6aW5pdF9wYWdlX21hcCAobW1hcF9yZWNvcmQgJnIp
CiAgICAgTUFQX1NFVCAobGVuKTsKIH0KIAotb2ZmX3QKLW1tYXBfcmVjb3JkOjptYXBfcGFnZXMg
KFNJWkVfVCBsZW4sIGludCBuZXdfcHJvdCkKK2Jvb2wKK21tYXBfcmVjb3JkOjptYXBfcGFnZXMg
KFNJWkVfVCBsZW4sIGludCBuZXdfcHJvdCwgb2ZmX3Qgb2ZmKQogewotICAvKiBVc2VkIE9OTFkg
aWYgdGhpcyBtYXBwaW5nIG1hdGNoZXMgaW50byB0aGUgY2h1bmsgb2YgYW5vdGhlciBhbHJlYWR5
Ci0gICAgIHBlcmZvcm1lZCBtYXBwaW5nIGluIGEgc3BlY2lhbCBjYXNlIG9mIE1BUF9BTk9OfE1B
UF9QUklWQVRFLgotCi0gICAgIE90aGVyd2lzZSBpdCdzIGpvYiBpcyBub3cgZG9uZSBieSBpbml0
X3BhZ2VfbWFwKCkuICovCisgIC8qIFVzZWQgb25seSBpbiBhIE1BUF9BTk9OfE1BUF9QUklWQVRF
IHJlcXVlc3QgZm9yIGxlbiBieXRlcywgd2l0aAorICAgICBNQVBfRklYRUQgbm90IGdpdmVuLiAg
TW9yZW92ZXIsIHdlIGtub3cgd2hlbiB0aGlzIGZ1bmN0aW9uIGlzCisgICAgIGNhbGxlZCB0aGF0
IHRoaXMgcmVjb3JkIGNvbnRhaW5zIGVub3VnaCB1bnVzZWQgcGFnZXMgc3RhcnRpbmcgYXQKKyAg
ICAgb2ZmIHRvIHNhdGlzZnkgdGhlIHJlcXVlc3QuICovCiAgIERXT1JEIG9sZF9wcm90OwogICBk
ZWJ1Z19wcmludGYgKCJtYXBfcGFnZXMgKGZkPSVkLCBsZW49JWx1LCBuZXdfcHJvdD0leSkiLCBn
ZXRfZmQgKCksIGxlbiwKIAkJbmV3X3Byb3QpOwogICBsZW4gPSBQQUdFX0NOVCAobGVuKTsKIAot
ICBvZmZfdCBvZmYgPSBmaW5kX3VudXNlZF9wYWdlcyAobGVuKTsKLSAgaWYgKG9mZiA9PSAob2Zm
X3QpIC0xKQotICAgIHJldHVybiAob2ZmX3QpIDA7CiAgIGlmICghbm9yZXNlcnZlICgpCiAgICAg
ICAmJiAhVmlydHVhbFByb3RlY3QgKGdldF9hZGRyZXNzICgpICsgb2ZmICogd2luY2FwLnBhZ2Vf
c2l6ZSAoKSwKIAkJCSAgbGVuICogd2luY2FwLnBhZ2Vfc2l6ZSAoKSwKQEAgLTQ3MSwxMiArNDY4
LDEyIEBAIG1tYXBfcmVjb3JkOjptYXBfcGFnZXMgKFNJWkVfVCBsZW4sIGludCBuZXdfcHJvdCkK
IAkJCSAgJm9sZF9wcm90KSkKICAgICB7CiAgICAgICBfX3NldGVycm5vICgpOwotICAgICAgcmV0
dXJuIChvZmZfdCkgLTE7CisgICAgICByZXR1cm4gZmFsc2U7CiAgICAgfQogCiAgIHdoaWxlIChs
ZW4tLSA+IDApCiAgICAgTUFQX1NFVCAob2ZmICsgbGVuKTsKLSAgcmV0dXJuIG9mZiAqIHdpbmNh
cC5wYWdlX3NpemUgKCk7CisgIHJldHVybiB0cnVlOwogfQogCiBib29sCkBAIC02MzAsMTMgKzYy
NywxNCBAQCBtbWFwX2xpc3Q6OnRyeV9tYXAgKHZvaWQgKmFkZHIsIHNpemVfdCBsZW4sIGludCBu
ZXdfcHJvdCwgaW50IGZsYWdzLCBvZmZfdCBvZmYpCiAJIG1hcHBpbmcuICovCiAgICAgICBTSVpF
X1QgcGxlbiA9IFBBR0VfQ05UIChsZW4pOwogICAgICAgTElTVF9GT1JFQUNIIChyZWMsICZyZWNz
LCBtcl9uZXh0KQotCWlmIChyZWMtPmZpbmRfdW51c2VkX3BhZ2VzIChwbGVuKSAhPSAoU0laRV9U
KSAtMSkKKwlpZiAoKG9mZiA9IHJlYy0+ZmluZF91bnVzZWRfcGFnZXMgKHBsZW4pKSAhPSAob2Zm
X3QpIC0xCisJICAgICYmIHJlYy0+Y29tcGF0aWJsZV9mbGFncyAoZmxhZ3MpKQogCSAgYnJlYWs7
Ci0gICAgICBpZiAocmVjICYmIHJlYy0+Y29tcGF0aWJsZV9mbGFncyAoZmxhZ3MpKQorICAgICAg
aWYgKHJlYykKIAl7Ci0JICBpZiAoKG9mZiA9IHJlYy0+bWFwX3BhZ2VzIChsZW4sIG5ld19wcm90
KSkgPT0gKG9mZl90KSAtMSkKKwkgIGlmICghcmVjLT5tYXBfcGFnZXMgKGxlbiwgbmV3X3Byb3Qs
IG9mZikpCiAJICAgIHJldHVybiAoY2FkZHJfdCkgTUFQX0ZBSUxFRDsKLQkgIHJldHVybiAoY2Fk
ZHJfdCkgcmVjLT5nZXRfYWRkcmVzcyAoKSArIG9mZjsKKwkgIHJldHVybiAoY2FkZHJfdCkgcmVj
LT5nZXRfYWRkcmVzcyAoKSArIG9mZiAqIHdpbmNhcC5wYWdlX3NpemUgKCk7CiAJfQogICAgIH0K
ICAgZWxzZSBpZiAoZml4ZWQgKGZsYWdzKSkKLS0gCjIuNDUuMQoK

--------------O90fi0UM3Hsvq00jkPMR0XGk--
