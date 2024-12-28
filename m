Return-Path: <SRS0=tzZu=TV=cornell.edu=kbrown@sourceware.org>
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c112::7])
	by sourceware.org (Postfix) with ESMTPS id 7967D3858CDA
	for <cygwin-patches@cygwin.com>; Sat, 28 Dec 2024 21:41:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7967D3858CDA
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=cornell.edu
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=cornell.edu
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7967D3858CDA
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c112::7
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1735422060; cv=pass;
	b=CtX6lNdNuySe620iFII2iGvfhrXIQhDdQWUdwPKEHoWqmhiyob3kDC4WRTx4ruWwa3Fz6UKClO14Rb5Y1YTkR/345DwmFZ/BV3pFUtM80FGmiLTAf+0ppLPFwhdrYVZ7/TQtpjgcl7x4MUnBXGxsTTVR1S30u2u5f7w8SCdnESA=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1735422060; c=relaxed/simple;
	bh=t8gNgQrZ/fRmyzFEkIfYlQteMEio1NZIzZu9Fg/Lp4U=;
	h=DKIM-Signature:Message-ID:Date:To:From:Subject:MIME-Version; b=mziWZj10LCTAJ2flDaxLkTMD/OCqXlIXsrAabsyQWpOmIuuqJwtk7FP8IzgwKIhZNBcsY7vsdpC78E2/hM9ME6zcRrkkLwJ0zX8apkCJvKuRmZT9LadZ7GncFwewXxMQGWLlLT6LSEEmEIweg6oO4UXScTImriFAgumUK/REeMk=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7967D3858CDA
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=cornell.edu header.i=@cornell.edu header.a=rsa-sha256 header.s=selector2 header.b=fHv2cJKK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YS18v3o/OVDqflVll+8CQPq1RDHJ/rhkskUqumOmzyeQVNQA0V1/humozq1lKrpMImSUCIKuxZ0oy11KTKaQIk4AZfq+PBgaOwtcmrhYOXjBKr/+FNRN7DgoFAX+mBqZfNf5rw33qQVgVkDLp/H1vCdiFFuoWxxVffwJ38nPSQjBhYQRj87VzfZeh3ofTBCkwJFS83Jm+1qV77eBgJiqh6WgYvviBySa2zPXE2/TCjuVZaM2sjYvS1IBPn1b/Em2I3AnmV4Wj8BD6R5WiSKJxQU72KZmWCBWrTHmWyt4OqOF7Etvg+W6kHRyd6EzbnwofPK19Q44KxAHDsM7sHyO4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWWk2CTGL/FOvpEYcK2Be5B9HucMSdn0DyS5IlOQlTE=;
 b=bTBbiYVEGa2e8/oavytiEmbUtNYrd1m7zskcRyE1lBZM5u9LCSehCzvV0Xyk7vrskYIfrC+T8VjCOlx32NUvAdN72alzOQAA9uVrCE7/2RfJz9DVek5sIE3KRhM84+REyUc+Kw2+LVRgQCq42ee26SgUVwxDVoyonmdaE43/57HCspxwU1L8+SQO/HzzWvKQUmu0OZvPcF3N/lbuwpKUs/+0Pmeelh8LOki+7HYrhB915xQF75LDpx3mvC3Q0K+T9UIo5hpYpvjDRTfi5TYbvC/0QLEDeR9YUlKojfxRuG74U0ojl+5nxWM/gd17b9l/t+esaYoWEZXb1vi9qG4g/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWWk2CTGL/FOvpEYcK2Be5B9HucMSdn0DyS5IlOQlTE=;
 b=fHv2cJKKKgCqyh7kAAXJOnfcsle2GlgLEB7M683Gjw+oegbqQrMLzBjfXbMJzXVRfAAw6JwCDrT5QOrRG9HzaDIw9boudUYpY6icqhWklbzSF5XVFZrm7YmxlfUeWY41X71wCJJuTfTtqUo4a9KzpCqeJuzj210XD7x2Awql0M0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornell.edu;
Received: from SN6PR04MB5151.namprd04.prod.outlook.com (2603:10b6:805:90::25)
 by SJ0PR04MB7726.namprd04.prod.outlook.com (2603:10b6:a03:31b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.18; Sat, 28 Dec
 2024 21:40:52 +0000
Received: from SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd]) by SN6PR04MB5151.namprd04.prod.outlook.com
 ([fe80::5ff0:555f:8712:42dd%6]) with mapi id 15.20.8293.000; Sat, 28 Dec 2024
 21:40:50 +0000
Content-Type: multipart/mixed; boundary="------------0ygaF3v00mctbzGiBieri6nO"
Message-ID: <a9ebb720-13a9-4903-adfb-ca0ff9a4d82d@cornell.edu>
Date: Sat, 28 Dec 2024 16:40:47 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: cygwin-patches@cygwin.com
From: Ken Brown <kbrown@cornell.edu>
Subject: [PATCH] Cygwin: mmap: allow remapping part of an existing anonymous,
 mapping
X-ClientProxiedBy: BN0PR10CA0004.namprd10.prod.outlook.com
 (2603:10b6:408:143::18) To SN6PR04MB5151.namprd04.prod.outlook.com
 (2603:10b6:805:90::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB5151:EE_|SJ0PR04MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: 2122423b-933e-47de-75e8-08dd27884c4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0k2Y3pzRDc2Ti9RV21ndVRBeSsxZWRISEEzWHRjV1NGbWxHRkxQYjFhZ1Rm?=
 =?utf-8?B?UUNYODhqa3B3bTE2eEtSVE9YQm1EcHhEVWgvVEFrdU9oSXNXMk9md1Ixam9E?=
 =?utf-8?B?SkYzSGpDbnRERXBJaURkWVJZd3Rkakd3YVpzSDhybkxIMVN1U1dINk5UTktF?=
 =?utf-8?B?SXpqV21MdjJzelBXM3VzYVFQU3A5TGR6TnlMZGRJdDhYWU5iU2dZVk93blo3?=
 =?utf-8?B?MlB5ckRTbG42dUkxeCt1b2ZtWDBZU3RPWGk5YjBrazVQbkNMdXVWd1VVTUY2?=
 =?utf-8?B?Zk9LbTh2WWNmaGI5TG41SmVGQTlTZjIwRjE3YzdnTUNrTEVjbVBQY3ZGajZC?=
 =?utf-8?B?dGZ4STRxYWhMWFJ6Q3J0Y01TT09YQS9MMlNVemFzaHVmWTRFZ3gwQmwyOVhB?=
 =?utf-8?B?ckVkRXpRVktCaDhGenhHTTk2cWhJZmh6UnhneXhzNzd1V0N2VGhSaXFyMEQy?=
 =?utf-8?B?WUNaTlBsdzFTc2YrODhhdlVXcUp0ZWNQTWYwNTRTSkRTa05xRWZOUy83WWNa?=
 =?utf-8?B?cUF5MXlaRGRialdkTEc5VERwS1BBb2hEMUlQN0ZtVDhtbm9OQWVTTjJtN3Jy?=
 =?utf-8?B?NVNyRXBOZ3MyTEVndzl0RmlzMzFZczFtQ3lzK2VqcktyMlVtUWp5V3ZaNDcx?=
 =?utf-8?B?RFo3QWxvOXpJVndSVlgrNFNZZHUrRTZxdTZVa0lHOWVJOFBWQjNVVWZ4T25S?=
 =?utf-8?B?OGM2TUtrZlYxWmh5VGNQcUxWTXRzaUVmb1hKWjg0eGxZQkdhcEtmbHFBVkZa?=
 =?utf-8?B?Y0Jib1JGTWZYT0hxMWVaWXFBTHZOQ2gydkNDblZ3TnZwQ2hEdnFpZjgyYlBa?=
 =?utf-8?B?bWl6WE4welFnYW5ZcVJHUFJ2NURoUHc4UzFZVStpN0JVWlN1SCtRM01MYmFL?=
 =?utf-8?B?WDVMRU5RQ2ZsZ0srMURCK3p6bGExUTNrU2Y4RXJqL3AwQnhmSW9PUS81RC9O?=
 =?utf-8?B?QkVBdEZYQlJodk5USFplZWp0Uzk0MVZiYk1JRWdYZTZLb2JsdlRteHhZQjk1?=
 =?utf-8?B?YzVUWnFRQklhNFV1TFhMTlR6WW1GeTZUV0hjczA0cytDRlJwY01BNnlMS0hu?=
 =?utf-8?B?QUllcE00S3duWHlZTEpjRXcrakpPVzBBbllYWUV2dU14UVN0QW5FOEZDZ09z?=
 =?utf-8?B?VVV1NW43NmoySTN5TGUrTTVVNk05ODlrK3QxMHBRZkd1bWZ1bnhBL2lOOXh2?=
 =?utf-8?B?ekI4RU5OQ1NIdE9wOEJPTVNnUVZtZGJDOE94V003NXcxRUlURmd5aU04dUZQ?=
 =?utf-8?B?OEMra2pKOWxjNXI5eEgvbk05anh1Qk8xSzc0eTRwT28raDNFZlFQMithcDcv?=
 =?utf-8?B?SmtEK3R5YjFqQk95WndWS2NIYWpndiswZ2JmNzFxblYvZ2NobzVSL1NTeGor?=
 =?utf-8?B?WllFN0hsNGVMMlFkbmg5T3ZTMko4a1lHaE8yVk85UXh5RW9zWk5lT3k3dlFs?=
 =?utf-8?B?UFJwajkvbkY0YlpBaUUra0g4elc2NzA2VzgwZTY5YnpteG1XS1E2U0dLYnBw?=
 =?utf-8?B?N3Q2N09JMEhBbXNuU1RVY3Z4RUZVYVBEWDFyUG5zM3pCUWJHckxTOXA1blpJ?=
 =?utf-8?B?cFJ3UjZqSDJPTmpyUGJCeVB6V0hiMzFRRmxacUk1VEF5ZU11M2ZwL2s4WXh5?=
 =?utf-8?B?cnJvUGgvMEJnVW51WHdiRWt2VmFkRDd3WUFQaEtnMVp2WTNiOVViTVlMYk5k?=
 =?utf-8?B?QWtPMTZ4VEVXRnN3TjVwV3gveTlnbFBVOURkemM4QVJ4Y1d4ZzZoZUFESDRT?=
 =?utf-8?B?d3o2SCtkN3p3ek9jaGEyRlV6YTFsSmdvTVA1dnBCaXR6TWJEdU9qNlVzcEpO?=
 =?utf-8?B?N3NZY0pQNlFCL2EwNzBnZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB5151.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmFHY3dtdlB0bWdNbWU0dmVLblNjQmdEQWpUL2I5elVQTWZ2Mmt0RkE2SFFo?=
 =?utf-8?B?aEFTV2I1bi9Ic0lpQzdaNWhMcjJpWkxYOFZ1M1lwcnBGZTRFZUlhU01Gb1Ur?=
 =?utf-8?B?Y1UxYk9Dc1BFZU9COEdEQ2g4b1JhSk1ReTN5NENQQWNyVk0va1o2L2FtUmpk?=
 =?utf-8?B?cG90bXV1V2NidmFpK2t0OVl2bjN0Q0I1YjJYME8wejVjc1lyU2J0YWoraGN1?=
 =?utf-8?B?RTk3V3Y3cUkzQkFVRE9PbGlpR3F3MnprUnFJSWQyS0RGMjk3U2FnUnJ4SHQ0?=
 =?utf-8?B?U2xKUEVhdHVoeDJFQ2xiT0VxY1hvQi9UV1F1VW5sQTV2cHYvQ21YV0g0M3BB?=
 =?utf-8?B?SWE3WG5kQ1N6L29zZDhXS0UzL0JiaE1xTWhxUTdDdkMrK3VXK3QzbWZZaUtK?=
 =?utf-8?B?OTVqdzhwQmtoOVAyUzErRW0xYk8xNi9ZV0dwNGRxbk9oMzYxOFY5dXJyQ2My?=
 =?utf-8?B?UkxTTDNFVHpPdEdFWEZIMTFQSUZ1VGEzL1JURDJSZW5zQmxnNjQrNkZLWGIr?=
 =?utf-8?B?TFh4Q2tRLzZMLzc5UXZidDdKdlRydEZqQ1RNWGUwOUxBSkFKZWR2Vm9hZHYw?=
 =?utf-8?B?T250aFF6SlFQdVdNMnZrYXdxK1RVRlpabjZrME1hcVdHMmlPc2JrcFZ0NGcx?=
 =?utf-8?B?VUhGL0NBVHd1QUZ3Q3BYb1J4U0pLd2VMNnNRSnFOT0d3eWc3d1dBeWRGTlIv?=
 =?utf-8?B?MFIwQ1ZNTEFFWm90S3lZWUVwQW9BNnNaZ3Q0YnNYdGRkWlp5MExzWEF4UExl?=
 =?utf-8?B?QVV5dnBmd2hZblN4RlA1YVVnSVR1ZHphSlN3OUJRSUhQb0JWL3EvUkljZzln?=
 =?utf-8?B?U1ZJQ0VWTnIrWVlobEJORWx5QTNvRFRheUdTZjBMVUdGYThNZTE2d1hYTml5?=
 =?utf-8?B?SDBaLzRkZ3dNdkl6ZFRBSWg0SjlJclJPNnZtb05ENVpHaXhzaSthM1IzMDdN?=
 =?utf-8?B?cTN2Ly8vOUhERkxtSXJhcjJBekVhYksrbWg4NFpQWjJPTHpHeE1LZHJLWS90?=
 =?utf-8?B?LzNyNEYrZzdCV2J1SXVsamVxU0ZUdXRoeFlzb0JVNDFlYlVOMEdDbjJBeGt2?=
 =?utf-8?B?dWNLTG9tWU5XKzBLOHA3KzhtSzZKaVlOcEJkOTB4SFVnTTkyY01EeFluR2Iv?=
 =?utf-8?B?M2x4c2RrTWF3ajJ1QlE4YmxlUDBCamJQNnhLaWE2N2tPNmxGSTZkQVNERzF1?=
 =?utf-8?B?NTcySHkxQTBQNGhPU0ZwRXFId3gyL1ZlQ252Ni9OQmZLM2gvQ2JZenF2U0ZZ?=
 =?utf-8?B?TFoxZmRSOHdhb242NW5qZ0loKy9xQVRRM0NieXQ2eTBwbkZaMjJFWFBMbCsr?=
 =?utf-8?B?VTEzenNkbE4wencwNnh4M2kvTTljcDFKLzBxbnNhbjdnTGwwVGQ5RndEeUM0?=
 =?utf-8?B?UG9KK0hJcW5TYVlMVXdTMkFPV2JZOE5qSHQxQ0ZtYURFN2xGYmUyeFBGY1NW?=
 =?utf-8?B?U2laT09FaDRpUW1jYkhweHViQU5UTFkwNU82cHJ5OUdvNktHSGcybmVGVGVS?=
 =?utf-8?B?T2NHVGpjVCtrek00NTFhWjZhcHFOMU9EanFzUkx0UTFIVGppM3NkSWk2UmpH?=
 =?utf-8?B?ZmVPRTBhcnR2UjgwRHJXaEJCZnRFclhseGdTUktIMytQMTBtMERYeXZGNnJB?=
 =?utf-8?B?NENXN1pxRyt5Y3dSVU5SK0V5YUZyZWRDWnlVRXBabFVqdHM1TGx1V1NZeEJS?=
 =?utf-8?B?bHIyNnRMNUFBQjBYRG9mVjJUQ0ZjM2w5eVRqaDRxVERsRjdUVlhCRlNXdkYw?=
 =?utf-8?B?QWNqNXQwVyt6cW01MVc2R2l6bTFvUFNMOFV2NjE0SmVYYytKdFZ2Q0R3YnB0?=
 =?utf-8?B?NFJqRHFDNGVnR3NLd1MyS083UVIzNDFOZEhmb1p1OEMyTDRiSjh6REdyTGZZ?=
 =?utf-8?B?bTJOdFA4REF1TUNsMmhhRTJ6VkJLY01RTng4eUwybmE1dVhDOGpaWldPNE5j?=
 =?utf-8?B?N00zRUp5bG1ZUHc2MytVTWx0K3djLzUvclB6S0JGZkpsVEY1ckcwVjBMYUZ4?=
 =?utf-8?B?czFKNC9qd1k0UmtQRDZpUGpEVndSdmVsVjB6TWpIUTl0YWF1WXVXV2R3bVRp?=
 =?utf-8?B?eFpBeWpOQXI3NzJ4Y3NlQjg5RVJPdmcrOHlYbDRKTFdEQjNqQXc5bkJJMGtF?=
 =?utf-8?Q?N8mwdhfBcFH+ioISZAHBALzKR?=
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2122423b-933e-47de-75e8-08dd27884c4a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB5151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2024 21:40:50.6973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9a/T2zxrchGVVAt1QoJkv8vodss6VPfPPw1QzoFgSBBywR+QlTOiFu2/FNKHI+JyZ79jqr3eJQG6NSNduXQ4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7726
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,JMQ_SPF_NEUTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--------------0ygaF3v00mctbzGiBieri6nO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Patch attached.

I'm not sure I handled the noreserve case in the best possible way, but 
at least I didn't make it worse.  The behavior in that case after my 
patch is the same as before.

Ken

P.S. If no one has any comments in the next week or so, I might just go 
ahead and push it (to main only), so it can get some testing.  Corinna 
has already said that's OK in 
https://cygwin.com/pipermail/cygwin-developers/2024-December/012723.html
--------------0ygaF3v00mctbzGiBieri6nO
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-mmap-allow-remapping-part-of-an-existing-anon.patch"
Content-Disposition: attachment;
 filename*0="0001-Cygwin-mmap-allow-remapping-part-of-an-existing-anon.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAyMmYxMjQ0NTVkMTZkMmFmNTllZTE1NmRiNTU4NTUwNjg2ZmE4NzcwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLZW4gQnJvd24gPGticm93bkBjb3JuZWxsLmVkdT4KRGF0ZTog
RnJpLCAyNyBEZWMgMjAyNCAxNjowOTo0MCAtMDUwMApTdWJqZWN0OiBbUEFUQ0hdIEN5Z3dpbjog
bW1hcDogYWxsb3cgcmVtYXBwaW5nIHBhcnQgb2YgYW4gZXhpc3RpbmcgYW5vbnltb3VzCiBtYXBw
aW5nCgpQcmV2aW91c2x5IG1tYXAgd291bGQgZmFpbCB3aXRoIEVJTlZBTCBvbiBhbiBhdHRlbXB0
IHRvIG1hcCBhbiBhZGRyZXNzCnJhbmdlIGNvbnRhaW5lZCBpbiB0aGUgY2h1bmsgb2YgYW4gZXhp
c3RpbmcgbWFwcGluZy4gIFdpdGggdGhpcwpjb21taXQsIG1tYXAgd2lsbCBzdWNjZWVkLCBwcm92
aWRlZCB0aGUgbWFwcGluZ3MgYXJlIGFub255bW91cywgdGhlCk1BUF9TSEFSRUQvTUFQX1BSSVZB
VEUgZmxhZ3MgYWdyZWUsIGFuZCBNQVBfTk9SRVNFUlZFIGlzIG5vdCBzZXQgZm9yCmVpdGhlciBt
YXBwaW5nLgoKQWRkcmVzc2VzOiBodHRwczovL2N5Z3dpbi5jb20vcGlwZXJtYWlsL2N5Z3dpbi8y
MDI0LURlY2VtYmVyLzI1NjkwMS5odG1sClNpZ25lZC1vZmYtYnk6IEtlbiBCcm93biA8a2Jyb3du
QGNvcm5lbGwuZWR1PgotLS0KIHdpbnN1cC9jeWd3aW4vbW0vbW1hcC5jYyAgICB8IDQ1ICsrKysr
KysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0KIHdpbnN1cC9jeWd3aW4vcmVsZWFzZS8z
LjYuMCB8ICA1ICsrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKyksIDE4IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vbW0vbW1hcC5jYyBiL3dpbnN1
cC9jeWd3aW4vbW0vbW1hcC5jYwppbmRleCBmYzEyNmE4NzA3MmEuLjAyMjQ3Nzk0NThlZiAxMDA2
NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9tbS9tbWFwLmNjCisrKyBiL3dpbnN1cC9jeWd3aW4vbW0v
bW1hcC5jYwpAQCAtNDk0LDE4ICs0OTQsMjQgQEAgbW1hcF9yZWNvcmQ6Om1hcF9wYWdlcyAoY2Fk
ZHJfdCBhZGRyLCBTSVpFX1QgbGVuLCBpbnQgbmV3X3Byb3QpCiAgIG9mZl90IG9mZiA9IGFkZHIg
LSBnZXRfYWRkcmVzcyAoKTsKICAgb2ZmIC89IHdpbmNhcC5wYWdlX3NpemUgKCk7CiAgIGxlbiA9
IFBBR0VfQ05UIChsZW4pOwotICAvKiBGaXJzdCBjaGVjayBpZiB0aGUgYXJlYSBpcyB1bnVzZWQg
cmlnaHQgbm93LiAqLwotICBmb3IgKFNJWkVfVCBsID0gMDsgbCA8IGxlbjsgKytsKQotICAgIGlm
IChNQVBfSVNTRVQgKG9mZiArIGwpKQotICAgICAgewotCXNldF9lcnJubyAoRUlOVkFMKTsKLQly
ZXR1cm4gZmFsc2U7Ci0gICAgICB9Ci0gIGlmICghbm9yZXNlcnZlICgpCi0gICAgICAmJiAhVmly
dHVhbFByb3RlY3QgKGdldF9hZGRyZXNzICgpICsgb2ZmICogd2luY2FwLnBhZ2Vfc2l6ZSAoKSwK
LQkJCSAgbGVuICogd2luY2FwLnBhZ2Vfc2l6ZSAoKSwKLQkJCSAgOjpnZW5fcHJvdGVjdCAobmV3
X3Byb3QsIGdldF9mbGFncyAoKSksCi0JCQkgICZvbGRfcHJvdCkpCisgIC8qIFZpcnR1YWxQcm90
ZWN0IGNhbiBvbmx5IGJlIGNhbGxlZCBvbiBjb21taXR0ZWQgcGFnZXMsIHNvIGl0J3Mgbm90Cisg
ICAgIGNsZWFyIGhvdyB0byBjaGFuZ2UgcHJvdGVjdGlvbiBpbiB0aGUgbm9yZXNlcnZlIGNhc2Uu
ICBJbiB0aGlzCisgICAgIGNhc2Ugd2Ugd2lsbCB0aGVyZWZvcmUgcmVxdWlyZSB0aGF0IHRoZSBw
YWdlcyBhcmUgdW5tYXBwZWQsIGluCisgICAgIG9yZGVyIHRvIGtlZXAgdGhlIGJlaGF2aW9yIHRo
ZSBzYW1lIGFzIGl0IHdhcyBiZWZvcmUgbmV3X3Byb3Qgd2FzCisgICAgIGludHJvZHVjZWQuICBG
SVhNRTogSXMgdGhlcmUgYSBiZXR0ZXIgd2F5IHRvIGhhbmRsZSB0aGlzPyAqLworICBpZiAobm9y
ZXNlcnZlICgpKQorICAgIHsKKyAgICAgIGZvciAoU0laRV9UIGwgPSAwOyBsIDwgbGVuOyArK2wp
CisJaWYgKE1BUF9JU1NFVCAob2ZmICsgbCkpCisJICB7CisJICAgIHNldF9lcnJubyAoRUlOVkFM
KTsKKwkgICAgcmV0dXJuIGZhbHNlOworCSAgfQorICAgIH0KKyAgZWxzZSBpZiAoIVZpcnR1YWxQ
cm90ZWN0IChnZXRfYWRkcmVzcyAoKSArIG9mZiAqIHdpbmNhcC5wYWdlX3NpemUgKCksCisJCQkg
ICAgbGVuICogd2luY2FwLnBhZ2Vfc2l6ZSAoKSwKKwkJCSAgICA6Omdlbl9wcm90ZWN0IChuZXdf
cHJvdCwgZ2V0X2ZsYWdzICgpKSwKKwkJCSAgICAmb2xkX3Byb3QpKQogICAgIHsKICAgICAgIF9f
c2V0ZXJybm8gKCk7CiAgICAgICByZXR1cm4gZmFsc2U7CkBAIC02MjUsOCArNjMxLDkgQEAgbW1h
cF9saXN0Ojp0cnlfbWFwICh2b2lkICphZGRyLCBzaXplX3QgbGVuLCBpbnQgbmV3X3Byb3QsIGlu
dCBmbGFncywgb2ZmX3Qgb2ZmKQogCiAgIGlmIChvZmYgPT0gMCAmJiAhZml4ZWQgKGZsYWdzKSkK
ICAgICB7Ci0gICAgICAvKiBJZiBNQVBfRklYRUQgaXNuJ3QgZ2l2ZW4sIGNoZWNrIGlmIHRoaXMg
bWFwcGluZyBtYXRjaGVzIGludG8gdGhlCi0JIGNodW5rIG9mIGFub3RoZXIgYWxyZWFkeSBwZXJm
b3JtZWQgbWFwcGluZy4gKi8KKyAgICAgIC8qIElmIE1BUF9GSVhFRCBpc24ndCBnaXZlbiwgdHJ5
IHRvIHNhdGlzZnkgdGhpcyBtYXBwaW5nIHJlcXVlc3QKKwkgYnkgcmVjeWNsaW5nIHVubWFwcGVk
IHBhZ2VzIGluIHRoZSBjaHVuayBvZiBhbiBleGlzdGluZworCSBtYXBwaW5nLiAqLwogICAgICAg
U0laRV9UIHBsZW4gPSBQQUdFX0NOVCAobGVuKTsKICAgICAgIExJU1RfRk9SRUFDSCAocmVjLCAm
cmVjcywgbXJfbmV4dCkKIAlpZiAocmVjLT5maW5kX3VudXNlZF9wYWdlcyAocGxlbikgIT0gKFNJ
WkVfVCkgLTEpCkBAIC02NDAsOSArNjQ3LDEwIEBAIG1tYXBfbGlzdDo6dHJ5X21hcCAodm9pZCAq
YWRkciwgc2l6ZV90IGxlbiwgaW50IG5ld19wcm90LCBpbnQgZmxhZ3MsIG9mZl90IG9mZikKICAg
ICB9CiAgIGVsc2UgaWYgKGZpeGVkIChmbGFncykpCiAgICAgewotICAgICAgLyogSWYgTUFQX0ZJ
WEVEIGlzIGdpdmVuLCB0ZXN0IGlmIHRoZSByZXF1ZXN0ZWQgYXJlYSBpcyBpbiBhbgotCSB1bm1h
cHBlZCBwYXJ0IG9mIGFuIHN0aWxsIGFjdGl2ZSBtYXBwaW5nLiAgVGhpcyBjYW4gaGFwcGVuCi0J
IGlmIGEgbWVtb3J5IHJlZ2lvbiBpcyB1bm1hcHBlZCBhbmQgcmVtYXBwZWQgd2l0aCBNQVBfRklY
RUQuICovCisgICAgICAvKiBJZiBNQVBfRklYRUQgaXMgZ2l2ZW4sIHRlc3QgaWYgdGhlIHJlcXVl
c3RlZCBhcmVhIGlzCisJIGNvbnRhaW5lZCBpbiB0aGUgY2h1bmsgb2YgYW4gZXhpc3RpbmcgbWFw
cGluZy4gIElmIHNvLCBhbmQgaWYKKwkgdGhlIGZsYWdzIG9mIHRoYXQgbWFwcGluZyBhcmUgY29t
cGF0aWJsZSB3aXRoIHRob3NlIGluIHRoZQorCSByZXF1ZXN0LCB0cnkgdG8gcmVzZXQgdGhlIHBy
b3RlY3Rpb24gb24gdGhlIHJlcXVlc3RlZCBhcmVhLiAqLwogICAgICAgY2FkZHJfdCB1X2FkZHI7
CiAgICAgICBTSVpFX1QgdV9sZW47CiAKQEAgLTEwNjEsNyArMTA2OSw4IEBAIGdvX2FoZWFkOgog
ICBMSVNUX1dSSVRFX0xPQ0sgKCk7CiAgIG1hcF9saXN0ID0gbW1hcHBlZF9hcmVhcy5nZXRfbGlz
dF9ieV9mZCAoZmQsICZzdCk7CiAKLSAgLyogVGVzdCBpZiBhbiBleGlzdGluZyBhbm9ueW1vdXMg
bWFwcGluZyBjYW4gYmUgcmVjeWNsZWQuICovCisgIC8qIFRyeSB0byBzYXRpc2Z5IHRoZSByZXF1
ZXN0IGJ5IHJlc2V0dGluZyB0aGUgcHJvdGVjdGlvbiBvbiBwYXJ0IG9mCisgICAgIGFuIGV4aXN0
aW5nIGFub255bW91cyBtYXBwaW5nLiAqLwogICBpZiAobWFwX2xpc3QgJiYgYW5vbnltb3VzIChm
bGFncykpCiAgICAgewogICAgICAgY2FkZHJfdCB0cmllZCA9IG1hcF9saXN0LT50cnlfbWFwIChh
ZGRyLCBsZW4sIHByb3QsIGZsYWdzLCBvZmYpOwpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9y
ZWxlYXNlLzMuNi4wIGIvd2luc3VwL2N5Z3dpbi9yZWxlYXNlLzMuNi4wCmluZGV4IDRiNzYwNDkw
NzkwMi4uOTIyMzcyMDcwMzJlIDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL3JlbGVhc2UvMy42
LjAKKysrIGIvd2luc3VwL2N5Z3dpbi9yZWxlYXNlLzMuNi4wCkBAIC03OCwzICs3OCw4IEBAIFdo
YXQgY2hhbmdlZDoKIC0gUmFpc2UgbWF4aW11bSBwaWQgZnJvbSA2NTUzNiB0byA0MTk0MzA0IHRv
IGFjY291bnQgZm9yIHNjZW5hcmlvcwogICB3aXRoIGxvdHMgb2YgQ1BVcyBhbmQgbG90cyBvZiB0
YXNrcy4KICAgQWRkcmVzc2VzOiBodHRwczovL2N5Z3dpbi5jb20vcGlwZXJtYWlsL2N5Z3dpbi8y
MDI0LURlY2VtYmVyLzI1NjkyNy5odG1sCisKKy0gQWxsb3cgbW1hcCB0byBzdWNjZWVkIG9uIGFu
IGFkZHJlc3MgcmFuZ2UgY29udGFpbmVkIGluIHRoZSBjaHVuayBvZgorICBhbiBleGlzdGluZyBh
bm9ueW1vdXMgbWFwcGluZywgcHJvdmlkZWQgdGhlIE1BUF9TSEFSRUQvTUFQX1BSSVZBVEUKKyAg
ZmxhZ3MgYWdyZWUgYW5kIE1BUF9OT1JFU0VSVkUgaXMgbm90IHNldCBmb3IgZWl0aGVyIG1hcHBp
bmcuCisgIEFkZHJlc3NlczogaHR0cHM6Ly9jeWd3aW4uY29tL3BpcGVybWFpbC9jeWd3aW4vMjAy
NC1EZWNlbWJlci8yNTY5MDEuaHRtbAotLSAKMi40NS4xCgo=

--------------0ygaF3v00mctbzGiBieri6nO--
