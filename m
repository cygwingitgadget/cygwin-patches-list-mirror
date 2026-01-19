Return-Path: <SRS0=F6Ph=7Y=analog.com=Ankush.Kumar@sourceware.org>
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	by sourceware.org (Postfix) with ESMTPS id A98B64BA900D
	for <cygwin-patches@cygwin.com>; Mon, 19 Jan 2026 13:27:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A98B64BA900D
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=analog.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A98B64BA900D
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1768829261; cv=pass;
	b=Ky42fp47EdkU6ofHxNcgDVrmACltYWc11QRdZ8cD1oqXAhQ4UuTOsNuKr5LlZTdoud0B3fgtUnenftJuI/sRlSMW45D4ScpDtUFJwYXZ5G6dsGwEuXbqcz1AwguHtWTjZI+b/7Cs5/N+SoKzEv3IGh80vkVp+Rrzwr0CUQpvlM8=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1768829261; c=relaxed/simple;
	bh=RbJKg1Ii0+6UD0QjDUt6v5xOlm2sPMioFNs0zhkcBK4=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=AXP8sccQinBtmlBVnewbSd5gkwyeMLlR3f3pd4yGoiECAKZoWsRgjWnm7qLWtwWUpsptZihiMBpa+tMpMxeleHHrJVpzo9zMdFTQGOLDoeUKTeAPwOESAoJMOy/7xAWPLFt7O5uJxwyHHl5/faz+dVSAqXaEFTKqSYPy0CGd2dI=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A98B64BA900D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=frBhMrfC
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JD8Qfl2897739;
	Mon, 19 Jan 2026 08:26:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-type:date:from:message-id:mime-version:subject:to; s=
	DKIM; bh=RbJKg1Ii0+6UD0QjDUt6v5xOlm2sPMioFNs0zhkcBK4=; b=frBhMrf
	CHi/bdOy2EPD85SRtqgnw6EuY7PDjpBaITlSmcmkRWWvKETqMFK4zeCYWliKkCgK
	CHEaai7P4O92yM+ALU7UTv7z/4stzrOQswuzo4m66Vsc0SXJqIJM+WYdBMDBiv+v
	klbN5O1qtBC/z+B5iIm+GTbCFvm5OsmD0/qiQqgeN8589OoQS4nNVFQGl/1yxjYN
	SsuTNzsRG30I9PqLv4bdhykcat2VL+y9aXE4ApToeKLhojOCBbT3sMaqL4NApnVc
	rDmzesnXK3ziacGnzmFMSWcwCbYyVIfVTiGIO0k+mIdJi/w871X1SugBBHLO2XcE
	mh+qopVrTFDhAAQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012052.outbound.protection.outlook.com [52.101.43.52])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4brsmgvnrd-3
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 08:26:53 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yH3VtcCdxK44LdCItJdnNsFpUA05VpgRDGN/J0KsfTxquh5NKAH7K4JsndIbcyGj/+lFVTvoEXpExUGbJfDiieb33QxgandiVeLN4KqRQgN89KABX1KFbxyPHXvOIR5evUpq0o6tHlhHXAelNVwuP4N4LqFwLev7FNA0NhN3iw/qJ9uslzKBvMeGwkVUDZHgF9Vd5Z+vf+BuJaCaBSN1Z5p3k4hTl+DnbbQmWd8hWZ/ZaLxxmmN1L+Qm2v2p0rcZCEtppF5fPR5zrsfGWo/2PSIGPkbjCeYn+gSn2WVZ4XL5YZ9CFmoOcseoSLgpqRuAjDluOz9f1Mgv9s8GXgai6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbJKg1Ii0+6UD0QjDUt6v5xOlm2sPMioFNs0zhkcBK4=;
 b=Ju+hh7VpCSLDTqwNL0TGFnagOuQ6/kWWy6zMlMWRmXNi9LUSw/TFlk7AZ+W0fyKTBmBwicBfd2iEXw9zx3D0sIBwIGwtsCMqmfRy4OtFF1qYHSZqj6cAKmp6ij2k64kd6Zlfj5PIQ5bxqt95e1z9A5lzQPdl4Y1xm04gfHSv5FehBnKhvpkX6g+SotM2+JzZhZLMOLTE5zsZHwrkNTs2jbK7muuRFqTLaIMPovVm6QRyGSMlVjTZ+gdLTFtszFyz6zW+CR+l/kx1DRMVX8/RyEnaca6o8vIfn2Bn44++iQ4pAvVbyf2YXetxYjOs1EBISi6culPR3+gcQvwg24/9wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CH8PR03MB8322.namprd03.prod.outlook.com (2603:10b6:610:2bf::11)
 by LV3PR03MB7730.namprd03.prod.outlook.com (2603:10b6:408:27f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 13:26:47 +0000
Received: from CH8PR03MB8322.namprd03.prod.outlook.com
 ([fe80::a581:e71e:4460:9cbe]) by CH8PR03MB8322.namprd03.prod.outlook.com
 ([fe80::a581:e71e:4460:9cbe%4]) with mapi id 15.20.9520.006; Mon, 19 Jan 2026
 13:26:47 +0000
From: "Kumar, Ankush" <Ankush.Kumar@analog.com>
To: "Kumar, Ankush" <Ankush.Kumar@analog.com>
Subject:
 =?utf-8?B?QUNUSU9OIFJFUVVJUkVEOiBCaXRidWNrZXQgUGVyc29uYWwgUmVwb3NpdG9y?=
 =?utf-8?B?aWVzIOKAkyBHaXRIdWIgTWlncmF0aW9u?=
Thread-Topic:
 =?utf-8?B?QUNUSU9OIFJFUVVJUkVEOiBCaXRidWNrZXQgUGVyc29uYWwgUmVwb3NpdG9y?=
 =?utf-8?B?aWVzIOKAkyBHaXRIdWIgTWlncmF0aW9u?=
Thread-Index: AdyJQyS+K8UoCwdBQGef8AAb4fJSLw==
Date: Mon, 19 Jan 2026 13:26:47 +0000
Message-ID:
 <CH8PR03MB832282C8067513749ABFBAD7FB88A@CH8PR03MB8322.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH8PR03MB8322:EE_|LV3PR03MB7730:EE_
x-ms-office365-filtering-correlation-id: 10ed4c1b-e599-40cf-f547-08de575e6569
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|8096899003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?QW5YbUZXV2FYbDRRQmd3Y1Z1dG1RMGJ1Q014eEVJMEh0ZnY4bXd0NmJkUUIx?=
 =?utf-8?B?aGEvdUtzd0RQb1hPemRRdEU1U0ZDRFhNVVU0VU9nSnd2dmNMQjNKWG1CY3p2?=
 =?utf-8?B?dTM5WEd3ek15Q0FmeGxTRWFkM3FnNDhPQ2d2MGhpU1NtdkxTdTA0anJ5MWQr?=
 =?utf-8?B?OFZrQ1RWeW9pS0RrbjJ1VUJEMVd0VHV0NERkUGZpZ1VNQitERkk3SVpwQ1gy?=
 =?utf-8?B?dmZoemlKYlB0NThFN2MyRmt4MTFvdlFQVE5PbjJWNjVFMzRabXNiZW15Ylp6?=
 =?utf-8?B?Sm5KMFZEVlRuVkl6c2FidUFkOGVsemd3Y3hUaiswUFpLb2NqYWdxcXhPV3hK?=
 =?utf-8?B?ZlJqZFNwWVlWbjZ2V3B5dE5oU0MrWUFvNldEd21oL1J3Z2JDU1ZhSlY2bUkv?=
 =?utf-8?B?ZjVVbGl0QW1HMyt3cit1K2R4UDBNTm1Ra29aSHNSN0YvZVE5L0w3dTRpNGll?=
 =?utf-8?B?d25VbGYwNVVwR1hWN29NRUprYUVpaWE2SThtbVJWMFNCZFdEbUtZdHlrZmZT?=
 =?utf-8?B?MUUrV0l2NHBTVjVWTWowWUU3Q2dnUWZ4bmowb1hUcDI3M2plN2xnN012eUI0?=
 =?utf-8?B?d2NaM0F5Tk9JajRQakhCV040VzJ4TXljTmdtYWhkbDg3bjVqUTQxci8xSGJK?=
 =?utf-8?B?Mm1mNjA0Z0ZZdEhNbHV2dzVqOG91cFArbDcxNmlWblNhbFRKdHJoQjd5S2ty?=
 =?utf-8?B?dHFpOUdQSFVKUkV5bFBhM1hmam5mWjhtUlM4VWhQMUZTZHdNTFBqK0h0M2d0?=
 =?utf-8?B?VzU5TGVrZzF2T1FxUTFsSHZzdkladEdmOE42eWNoU3hqRStZYUtvem9kK0Zo?=
 =?utf-8?B?SllabDhDd2xsMDFGa3hFSkNqVnlDS2pOWEM0bVdSaGMvRldTU0ZteU1MVUxO?=
 =?utf-8?B?MDczbHk0dmRZK2JyT2pVd0JFUEp0dXR2WFVpYmpKVTFSd1ZZQ09ydklwN3Bs?=
 =?utf-8?B?alYrOVNrMVZjckNhS1JrWTRkNnQyL0czR3h3dzBic1FZVHlJK2ZvaW8zT0pt?=
 =?utf-8?B?enNPZ25xTTcrd1FvM2R5SitFSHR6VG1EQ0dXY1hzelVTbUhmeVJUcEdFdThR?=
 =?utf-8?B?MTZ4K3orTUt2WUo3YkpqSlFDaDZITTY5YXpENnpCQ3QvK2p2NTZBNVFIV3Nw?=
 =?utf-8?B?d1V4a1JIZWJzZk5HVnJIZWJlckFKNkFLNUFCV1NPUEtUU1Zoa1VxcTNyWjNr?=
 =?utf-8?B?eGJBZFFKQ1lXekh4TEhBT2d6cDZVWTlmMDFVRG9yRk0xL0s0aGp6aklqTVF4?=
 =?utf-8?B?bjlWTGRBUHZubzZCYWR4Zm10T0dWNndaVERYdlpmVnVzbmVOOWMxNGhUcWRV?=
 =?utf-8?B?RU5FVFlBNzZsNGd2bXdocmN2akZDNHhoVjFjVEN1ZzhIV2hEWkVIR1plYW1Y?=
 =?utf-8?B?NDRNMDhwdzdZNnFpbTREQTBOdmdxVndWZys5NllPWkdXNnFPOFYxSTVJWE5O?=
 =?utf-8?B?NEJBZE1hN2R1cFJXaVBnM0g1VVpWbTByWFdqTE84UFlsM1JSUGNvTk9wdmpo?=
 =?utf-8?B?NUk2dTNjR0w4VlRFc2wwVFVhNzNOWDZtVVRvWEMxZ0FiWVdFSmFac1Q4dzdH?=
 =?utf-8?B?dC9DWlJlNjRjRG9Pc0FlWkZTUjZxY2VMU1NFVm5reTc5N0lZd3hPRzNoa0hn?=
 =?utf-8?B?YW9jeVp1Q3NweGVtNFJGRGVhZVlTZ1JOaVBpOGJtZmZhWWJIZU5yV2FzeXJB?=
 =?utf-8?B?aXBxWDIvOWtJVjY3SDJCcTBiR29MSnV6M1lhUmZnY3k0Y1owUjJFalJpa04v?=
 =?utf-8?B?N1l6RU5uSk9EbVgwR0RrWE5jQk0ramphRU5FekdodkxiL2hsN0RQOXJYcWhG?=
 =?utf-8?B?blVHTytSREJSSXBzL0VKY1RsRGxzMzRpRFdMN0k0YlNqRnpEUDVveTZ4MXJm?=
 =?utf-8?B?bXEzZld0NVpqamdnb042a09SWWhnWnByUDNlbXdqQmxOMlNBRldFSEV6M0R2?=
 =?utf-8?B?bGMzYjNxNyt6NDlPTWlTQzEwbDloT2tzUWgzMHo1WXluNEMxY2ZreGJxY21F?=
 =?utf-8?B?M0hMQTd1U3h3WXB4Ull0djJDZ2pIb1lERmcxNFdnMWZBd1JtYXpvOXFNc3cw?=
 =?utf-8?B?UDZDblpIa2ZwK3BKaVp0STR2NGdYNUtYdk9OY3Izb3M0Um9TQ1lNT0hwekVm?=
 =?utf-8?B?VmpIa2NMQW5nS1VkOHk1Rkt2aWF1V2E1MkYwNjJCL1JVM3oxcGtUYzhPZE5r?=
 =?utf-8?Q?aEFfjDyrwa6VvyLrmDXeroY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR03MB8322.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(8096899003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bmVYcElPdmNIUW5EeURuUlprTkNMZnQ5cDJLc09LT0gwUTVUdDg5NUF2K29h?=
 =?utf-8?B?Z004enFmZDVKb0ZQdzNERUFyb1Z1NGR2UG51akVpeURSakhNYjRBR3dydk9q?=
 =?utf-8?B?VDRrcVV6WDdXZDFheHRSUnJ3Skp3SnFHQTI1NGUxYkhGOHpycjJmaXJPNGJS?=
 =?utf-8?B?TjA1WlUrZVNDaU9RcGpka0VuR3hKL2FLWVdQOGJ4SG1mQU9HUlpYQ2JTa0Rn?=
 =?utf-8?B?Zm02RlFGeWdaRitxS3lpbCtOTGJaOU5uaVJWR2hZcWlZTTBDa0JpeUhrdjE2?=
 =?utf-8?B?MG5hTmVrOThoOHlXdldpaUNBdkh5SWNrRE1TWWZDOUdNaFQ5KzZFS2dUellH?=
 =?utf-8?B?ZUR6MzVMYU5rMS9zL2o3YWxrb2tudXlEQVpHNG56TWVWT2FuUmxnR2pkbWdR?=
 =?utf-8?B?Mk5lT0VlQVZGRkVvQWtkRUl1a1JyYzhuK1NreG1JWXA2YmE0UmlaUWZLUjFO?=
 =?utf-8?B?enpORk0rUUYrVk5KTVp1M0xGTHJKZ2Z5ajYzSzlSZCtQcUlhampJTnpMclpn?=
 =?utf-8?B?dlBScUZsZEp6KzkwcGpOazR4TFlaZnJYaGtyZ1NEbHJEaVlaN296UjdKWnRZ?=
 =?utf-8?B?NzNmV0hDMURZZDFBeW9EVjZ3Z3BiYlM2SStnOVhNQ3VEYkpEdnQ1T0JIazJR?=
 =?utf-8?B?eDEzckN1b3NhRFBadThENDhwWmhFUUVZdnRpMWltVG5CV0ZnVEZuS1cxekF1?=
 =?utf-8?B?RlZBdUhEUExzOWdDUURvSEZoUXhpaUlaMytEdVhZTW0yd2RjaDh5OGU2UUlO?=
 =?utf-8?B?L1hEelBDZEQ0SUFHZU15SWhxTmZhVnMyVHNhblR1S0NKbTFmNyswVTBPRUpV?=
 =?utf-8?B?bkN2T3ptYkV5bXowWDlCUUhWZVhyRVdnL29pVWV5YUdGTUdRb1NzdS9ERWVk?=
 =?utf-8?B?QThYdkFZYkI1YWsxUlhqN3NybnJoSm9zelVXUDB6SGNJcjJhYTR1dnJXU3F0?=
 =?utf-8?B?THBONHl5Zk1idjhsYWNLa2tIMDFCR1FkSlFsK1JJalFiK2crN0dFOG95cFJN?=
 =?utf-8?B?MElCRFcydVdPaG8vcDlnY2NNZmp4L2lGbHZTNndoRlBXbWF5ZGZCVGZWUW9B?=
 =?utf-8?B?a2gwZXkwTXJRcEI2eDZzVkZzNmd6cmY2QVRmNk5wQTYvNHB3NTNIb0c1SHQ5?=
 =?utf-8?B?THVjWFRpVE91aFJqZVoxeWxEenVsbUF1amJSYk9ucDZ6MHdFWit4b1paM0o0?=
 =?utf-8?B?bEFoRHFzOEhPdkgwcEZtWW1DeGFlTmxjUTMvRnNhQXpFd28yNlJXM24ySmZs?=
 =?utf-8?B?eXNqbWIvVGkxbGtjenZwN28wOGtwNWxQSXNXcFExSHR4OFN5TDBYMkcyRnJC?=
 =?utf-8?B?dE5DMGxqZmhlMk9Ub1p6OWN0ZHZuN1l5VzZWbHFEK2hmWm03c3JCQzBoUEcx?=
 =?utf-8?B?aVVwQ0ZacnpOb0M1ZU1KTHcvaUhmWTVTYXlVN3BzcDZISTJSZmVrSERGNkMr?=
 =?utf-8?B?eTU1QVZPNEVkSFA4MFJnRENQUm1tamFBWFR6aGJwdGMwRkhzUk1MR3RxKzF6?=
 =?utf-8?B?RC9HTGYycjQxR2NwUWdmWnI4by9vVUlnNXdLV2J4VVNncGhwTzY1UVlMWi9u?=
 =?utf-8?B?clF2S1VuR1VZRVRJcEcvanN3ckpMb01hOFp4c1lPT2JZZXNjN2Z2K1B4ZHlI?=
 =?utf-8?B?ODFOVW9pMy9qMFV2OTZzVzNoemtuNWZBM0JzN0FQY2xxVkVMUG9Cem9JZjh4?=
 =?utf-8?B?Y0t2ektLbWtQWmFjSklDMU5MNVE4Vys1UEZOSkNXWVlYZDJPS09WV3VkZ3Q5?=
 =?utf-8?B?ZVhDRnlYM0VKcldjaHFzYUtEYm4zNDlNQ1RITW9hSzdFMHFKWkhjY0VKais0?=
 =?utf-8?B?WEZRUElBRzVZTnhLTm9NUTVVejFHbUIreGNuSFlZWXBEYnBNYkJmdTRGTE1t?=
 =?utf-8?B?eWJDeVZGanpLQ2J3TzNFOUZLOS9hSUoyakJ5dEhLM2hKUVVlUDRqQytIVnBI?=
 =?utf-8?B?cVNzT3hTaG0zWU9YMGppLzNzTnNHS3RQV09DeHBkOHh5TE9qamdVNVhxaGNw?=
 =?utf-8?B?T0RsK0NsWU94ekxHa1A2RXo2Z3dybXh5eTkrK0JILzU3MldMSGoza2dtbjda?=
 =?utf-8?B?V0UrbUFvUkxzakFZZTBCS3BleDViT2UxM1lSM3pMV3R2Z0Nka1hydlNYOThO?=
 =?utf-8?B?N3Z2S3dnQ2xiWVNmVWhQOERBR2cvK0NLbFgxc1hPampNZjFmc21LRVRJTDBG?=
 =?utf-8?B?d2lNVDVhakU4OS96U0p0Zlp0RXJPbXRKZHFEQkRMR1BlU0IvcHF4cWxqL2d0?=
 =?utf-8?B?MnFxS051S2h5SHdsWEVHVUFob2Q4bmhKeHY4QWdPUkdGT1VCNktWQTBGVDRU?=
 =?utf-8?B?eDd2SldnV0dVRW90T0ovVFJ2clY1SEloSHoxQjlnUDhyQ01jNVM2dz09?=
Content-Type: multipart/alternative;
	boundary="_000_CH8PR03MB832282C8067513749ABFBAD7FB88ACH8PR03MB8322namp_"
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ed4c1b-e599-40cf-f547-08de575e6569
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2026 13:26:47.2555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B+wQ7q2xIDQHdSTAP5rvEZINOTEDqlCv0GUOHmqcmfHnkvEpBJVxDTFIAN7kUoPJqvK+FnnLwtnNrUkrBzXbNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7730
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: uqsZYqjkeT7phFliJVTW8AGp8XCmcKTw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDExMSBTYWx0ZWRfX3ayt3FDUQV1m
 auIrJsYnEhv8oiSS8nRyO5Iiacre7IGXZqxgBqHDuiySwFKAC0z+JF/UKUYhr6zu1EC0p8CJ3Ot
 K4N3IzEEypGNVFCiv/H2dmz6uUAG32GFf0SQtsA+ZLpV1qhG1bJrdr7zesGe0M/WbUpurGnKd3f
 Jnsw280Xn9ooTYBz4MFa4FAacGOlCK3WMlZff/sJUeIgUm6uLksRTH0hL5fe8xeuzkMgWkB2gFz
 Kpn/rKGPI4iodONKWUN8GcaPtrgN1J2b/eOn6hNi7kwR1MDgfsRLZZKR6U18jSKdAbv8Q3hVfRD
 LeNoWv9OWb22ulE0MqtRUzXi4exGuQvOxHZtmEuQl/Wr5CQ9cweDsxB/yP/KLJ9H/oBGVFh3w+2
 8iG2iShVDqVV/PYuT06RxB8vtWe0RKwisQ3Dt7Qqe/z5+bNjP82lypZyz4T9puqsN76It1NtrsX
 nmIGwEbHDV3LrIj+XPg==
X-Authority-Analysis: v=2.4 cv=fr7RpV4f c=1 sm=1 tr=0 ts=696e311d cx=c_pps
 a=PlHkPQd8QExaI989BnvVeQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=5KLPUuaC_9wA:10 a=sWKEhP36mHoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gAnH3GRIAAAA:8 a=mYwZfc-oHjdUWmC6CTsA:9 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10
 a=yMhMjlubAAAA:8 a=SSmOFEACAAAA:8 a=HKAx8LGjZn85qhdbFfUA:9
 a=BL9_PPvA8N_5hGiW:21 a=gKO2Hq4RSVkA:10 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10
 a=frz4AuCg-hUA:10
X-Proofpoint-GUID: NhMgKBzeSglPTEew8jq0us7HPnXACi-C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_03,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1011 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601190111
X-Spam-Status: No, score=2.4 required=5.0 tests=ACTION_REQUIRED_SUBJECT,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,LIKELY_SPAM_BODY,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_NONE,TXREP,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_000_CH8PR03MB832282C8067513749ABFBAD7FB88ACH8PR03MB8322namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

RGVhciBUZWFtLA0KDQpXZSBhcmUgbWlncmF0aW5nIGZyb20gQml0YnVja2V0
IHRvIEdpdEh1YiBhcyBwYXJ0IG9mIG91ciBwbGF0Zm9ybSBtb2Rlcm5pemF0
aW9uIGluaXRpYXRpdmUuDQpBY3Rpb24gaXMgcmVxdWlyZWQgb24geW91ciBw
ZXJzb25hbCByZXBvc2l0b3JpZXMgKHVuZGVyIH51c2VybmFtZSBuYW1lc3Bh
Y2VzKSBubyBsYXRlciB0aGFuIE1hcmNoIDMxLCAyMDI2Lg0KLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCvCfl5PvuI8gS2V5IERhdGVzDQoN
CiAgKiAgIEphbiAzMSwgMjAyNiDigJMgTmV3IHBlcnNvbmFsIHJlcG8gY3Jl
YXRpb24gZGlzYWJsZWQNCiAgKiAgIE1hciAzMSwgMjAyNiDigJMgRmluYWwg
bWlncmF0aW9uL2NsZWFudXAgZGVhZGxpbmUNCiAgKiAgIEFwciAxLCAyMDI2
IOKAkyBVbm1pZ3JhdGVkIHJlcG9zIEFyY2hpdmVkDQotLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0K8J+TiyBXaGF0IFlvdSBOZWVkIHRvIERv
DQoNCiAgKiAgIFJldmlldyB5b3VyIHBlcnNvbmFsIHJlcG9zaXRvcmllcyBp
biBCaXRidWNrZXQNCiAgKiAgIEluYWN0aXZlIHBlcnNvbmFsIHJlcG9zaXRv
cmllcyDihpIgV2Ugd2lsbCBub3QgbWlncmF0ZSBpbmFjdGl2ZSByZXBvc2l0
b3JpZXM7IHRoZXkgd2lsbCBiZSBhcmNoaXZlZA0KICAqICAgQWN0aXZlIHBl
cnNvbmFsIHJlcG9zaXRvcmllcyDihpINCiAgICAgKiAgIFBlcnNvbmFsIHJl
cG9zaXRvcmllcyB3aWxsIG5ldmVyIGJlIG1pZ3JhdGVkIGJ5IHRoaXMgcHJv
Z3JhbS4NCiAgICAgKiAgIElmIGFuIG93bmVyIHdhbnRzIGEgcGVyc29uYWwg
cmVwb3NpdG9yeSBtaWdyYXRlZCwgdGhleSBtdXN0IGZpcnN0IGNvbnZlcnQg
aXQgdG8gYSBwcm9qZWN0LW93bmVkIHJlcG9zaXRvcnkgYW5kIHRoZW4gcmFp
c2UgYSBKSVJBIG1pZ3JhdGlvbiByZXF1ZXN0PGh0dHBzOi8vamlyYS5hbmFs
b2cuY29tL3NlcnZpY2VkZXNrL2N1c3RvbWVyL3BvcnRhbC8xNS9jcmVhdGUv
MTQwMz4NCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K8J+O
qyBKSVJBIFJlcXVlc3QgTXVzdCBJbmNsdWRlDQoNCiAgKiAgIFJlcG8gbmFt
ZSAmIEJpdGJ1Y2tldCBVUkwNCiAgKiAgIFRhcmdldCBHaXRIdWIgb3JnDQog
ICogICBSZXBvIGRlc2NyaXB0aW9uDQoNCuKaoO+4jyBSZXBvcyBub3QgbWln
cmF0ZWQgYnkgTWFyY2ggMzEgd2lsbCBiZSBhcmNoaXZlZC4gUmVjb3Zlcnkg
d2lsbCByZXF1aXJlIEpJUkEgYXBwcm92YWwgd2l0aCBqdXN0aWZpY2F0aW9u
Lg0KDQpRdWVzdGlvbnM/IENvbnRhY3QgYW5rdXNoLmt1bWFyQGFuYWxvZy5j
b208bWFpbHRvOmFua3VzaC5rdW1hckBhbmFsb2cuY29tPg0KDQpUaGFuayB5
b3UsDQpBbmt1c2gNCg0KDQo=

--_000_CH8PR03MB832282C8067513749ABFBAD7FB88ACH8PR03MB8322namp_--
