Return-Path: <SRS0=nfBC=5H=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c408::3])
	by sourceware.org (Postfix) with ESMTPS id 5E64B3858C41
	for <cygwin-patches@cygwin.com>; Thu, 30 Oct 2025 17:32:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5E64B3858C41
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5E64B3858C41
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c408::3
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1761845574; cv=pass;
	b=Ebelk6WAdmwaD8vbXO9tTUvPEo1+vDM9rUEG/dtFxUwV8RQWCmHI7ds0aprna2LUlpqmYs8NBGmDys/tmyTJoOVGRr7g7Q/6jN+rUHOO6hm8K4zBaZvac7bR1gXPREvTVU7SWaXsK4d49HeihZNceGPZNJx14WHMBSMFXopg0po=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1761845574; c=relaxed/simple;
	bh=NzGR9RIbeeRJ8AN4SBRfaw0I9zFZC12al/WDnt+ASg8=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=RDdhRDjpwrXpX9JvE74qa1Lwa3fCOPdP9fj95tqOS8S7RHYGA0HJXLJJYkMX43waZ5u+SaoItDD+NUPnbG0dzRP8AgvA4matGChdk/iIOyf9a3kOFSjqs/idK9nq75OiXt7ERCgHTPZc1US6XfYo1E8RSyps8nkiLiofNXIODTc=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5E64B3858C41
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=CmI2tldg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFOIrLgBMeOz8Ew2oY3lSqpyF3gEwcajTwrFeDb/yL6AieeUa7e0DGIkVmUA6N4RFSWiGMsfTRRSNP8eeB1Xn01x02f2L+P4/d7IagWvw2PBmu6lfCG0vHHIOYYt6aWPCFqJIoi6yB+WRC02LLJ6TvTrXtUJgiDTvLzqPsPFdbO9CMd3f2QWEqiiKFoLer4Ka/16bi/AmqlhMfnIfds5I4NmLee3oZ0lZclMlruZbIl5pGj+6K3q9g9KhuNpWdGoiqwsD9SYNDVjGtpw3x6FIPhV/4hR4+noAzcXH+CIL4kEt69fFKJM7IGtKO+aSouof74x/kUxR2LcCgde/2zTEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzGR9RIbeeRJ8AN4SBRfaw0I9zFZC12al/WDnt+ASg8=;
 b=Yg57yzXd6LqluTFfnCVSVgba/tTGtmx7lfp4mbfb51d4CafuM2fvljaU9VS6XCsEgRSHIVG1fHsoS7n8VkKSjBjcOWCBBFbtq3rmhaIZLRqZTCHeSL6e8e+PJCBbD1IeLMmUy2JF2NgLAVV+Tf8396T5PjVnWTE69mMj8dDLQcFhjuhVOUQkJxDkWskqkhVkf/N17gWvxQuT8PWF+tOAtCPvdoVsq/qyPWElB6XRqffNvloVbBEyvaFrAM9tH7oyBxTlwph2lCANRNe0X1ayys/ffuhAxqdkRZ12STAyY0bJpxm+1jwstPR2Ugy+/FiBon1frcSz40qUlahQDpdolA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzGR9RIbeeRJ8AN4SBRfaw0I9zFZC12al/WDnt+ASg8=;
 b=CmI2tldgG/Gg+egs4b6yZJe2Z9bVWhiWt0avjkSrSr7Aq/4sYGzOvzba5B51iGeF/aCyMo4g70vLHPzCnjZCnxI6IjBYZbIEtwOAYOh/UQSSqQZ2CKCB+Gn43Rv8JYHIy315ZKj2YTNs06SEwbFAI/84qwjmyKIwEbN+F/77k0WWKsyCVYsOifDYq6XHM4mHCtoPCzgPvqwMM8hOkIuWVdsjfjPlaEnsuteU6wH/XHzHSZqhDqj9ORAFCaUFyEsRGI7+NS/syHwqkxUlyHJw7S6eQEqDtbjHbwL7wn8uaN+Q28j+lKo9cuyibPAhrGmL1xl0GPhxQ5GXhoOVQc1e4g==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by PN3P287MB1814.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:199::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 17:32:50 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362%6]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 17:32:50 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: Evgeny Karpov <evgeny@kmaps.co>
CC: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: RE: [PATCH] Cygwin: Testsuite: fixes for compatibility with GCC 15
Thread-Topic: [PATCH] Cygwin: Testsuite: fixes for compatibility with GCC 15
Thread-Index: AdxHGuOb8vQJdZ4xQ/2R+COfLuP+SwAWJXsAAJNVxAA=
Date: Thu, 30 Oct 2025 17:32:49 +0000
Message-ID:
 <MA0P287MB3082E4D3872F3D5139907F5A9FFBA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
References:
 <MA0P287MB3082B86D9A27A995509C8EAC9FFCA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
 <CABd5JDCuwH_TaT7pm=n9vG0-XoZPWF-bcOy=af3XAWrDSH+1KA@mail.gmail.com>
In-Reply-To:
 <CABd5JDCuwH_TaT7pm=n9vG0-XoZPWF-bcOy=af3XAWrDSH+1KA@mail.gmail.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|PN3P287MB1814:EE_
x-ms-office365-filtering-correlation-id: 8874c1fe-9774-48ee-bcdc-08de17da5936
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z1M0Z1g3QnNwVWRmRHE5Z2hBOXdVaUNwOCtVVmltN1VVdDhVc0lYNEVnTjFB?=
 =?utf-8?B?dDVYaWZIc0xRVUNwTXZhYUFMc1UwZ2hpLy92NHNtTjZxUmhNUHllT3Q4bkw1?=
 =?utf-8?B?TmVaMnRIdmlxZWQ5UWkrQm02Q3I1ZWVxVUgzRVEzVDVEMitBK1B1QVZnR0ZL?=
 =?utf-8?B?T1ZGY1pMUXZGWmkrQ29najV4WTVURVpSL1lwamtPd29seW04d1ZsU3NGSG90?=
 =?utf-8?B?djZINHZZR3pxdE1Jemp1dmMxS0dNaHRrcTVoN2J0bWd0dFQzNk8yZ05wdVFh?=
 =?utf-8?B?U3crUTRtSkFhMXgzbm5jaXloTU13NEl3cFdKSEZWcnd0YXVEQnVoalVkdmR0?=
 =?utf-8?B?dWJvZUlaRllGcXZjOGMxSFhOM3JyU3ZJdjBCcyt3Zm5RL3FxZnZTd21SME4z?=
 =?utf-8?B?M0hnNER3RUNlNDZwUjAvajBVZ0E1aUdZUnFFRmxuWm9PMkQyQWpzSitWVGxj?=
 =?utf-8?B?bVB2UHhlVDFpVmcvN0lBWkgyOGMxOG1yZTRONzhiSnJSNTk4dFRKTVp5bTNT?=
 =?utf-8?B?OFFVeGF2Y253RHA2Tnp0L2pKM3Z2Zm1Qd0JuMDV6WlZnc0pMZmFiK0pMeVE5?=
 =?utf-8?B?TXVidDlRdGg4UzdmcHpmbDhaY005K1RsUzJ5QWhoNytPK2xoZVJtaitoQ3k5?=
 =?utf-8?B?RGFISmZSSlhpM0t2bzBnRWZ5VmNzNC9iVzhRVTZSRkV1Y24xdEQxUUFETVB2?=
 =?utf-8?B?Wklhd1RIY3pPMHMzNC9wbTY0UmtrTmt2Y1ViSTduT2xwbDA0aDJvZitCUXJE?=
 =?utf-8?B?ODJJSiszSU5EZkpLNzBnQUgzSzFRR09sYVAzRGJINTFlN2Y1WXZoYUdpNTVk?=
 =?utf-8?B?N1hSOGh6eUl1NTZZQzROTVNDRitjNkMwRldXYlN6KzBGWkIxTE5zYUs3alZu?=
 =?utf-8?B?a1hLS3pQMzdwa0NRSHFDTGwwNHZsUHlVR1YyV1hMZVJZOUUzaDNkYXFKcWp5?=
 =?utf-8?B?UUhiV09RbEhXQnZkV20zaTJXb0l1NEdoTHBBSXlZVUFZc2tFMnNlT2ladDhr?=
 =?utf-8?B?QlkwM0FFWVljNm5SQXh3VGlXM2xkRWF4R1R2Ti9ZSUdmRkFFTk1pMkRlcUFk?=
 =?utf-8?B?NlIva0UyQTZCWkloNUZnK3c5WlhBTlhDWjFRS09QRHgxdWo0OUhMUzhPbFpx?=
 =?utf-8?B?V21rODQ1Wk1FY1JJMVZ2Z29Fbm9GS0VLV2w5Tm5FU0ZaUitjWXlxNURUd2xH?=
 =?utf-8?B?bUROa1FrSzN3YjRBUzhIdWJ6U1N4VWF0NTRXYnF0UjRXWDBxUVVHUkJOMVc2?=
 =?utf-8?B?WmdPeU0xWTladUtsQjNrK3BXdjNvSVNHcVZORU54dk1NaFNvQzdSK1I0K2JT?=
 =?utf-8?B?RFBuSm5aTzBvY1JoZURQQk1GYWRIRUFzR1BxcURGc0pyZzFscXlDNm5lWVFQ?=
 =?utf-8?B?S3pNTStwMVZHWWhTUDdGaGUva081ZlJDcE5ncklDSVBzZURRdzJvUE1lMEtE?=
 =?utf-8?B?SUFmUUd4ckxmMWNaYTFqYi8valovbjUrUlB2RTFGKzIzWkpXWFhCdTBxWWdS?=
 =?utf-8?B?dVdiQlgxODg0U01pNmVpbkNVeVNSbWwwOFNZa0o0eUxNeDFxVjNGa1FVWWJs?=
 =?utf-8?B?Y1VhZWQxblk2d2tvdk53VGZxTU5DMmMwQm45Z1lRMFp6N2FVWkR0MjZKMFZQ?=
 =?utf-8?B?dTZDZXFnYWVSTGpUdWg2ZGFBcFFVT3RXOFJLRHpzZ3R6VkpuaXJuUER4Yk5C?=
 =?utf-8?B?d2JkRGxnSVlOZDJnRzdIV3RtcjhwVzcxMXYyZER1c2RBbFRjZk1ucm16Qit1?=
 =?utf-8?B?TkRrZlVzVzJCeXNKMlBXa3FkNlBNVjlObVdQd1pGcHFSR1lBeFhMR3VuZ0Fw?=
 =?utf-8?B?NUtSWjJwZmIrUW1aVkphVzlQMC82MVdWbUlxRmptdnZLdHhtdVJ1aWpzS2RP?=
 =?utf-8?B?ajVDTUttd294dFZ3K1I2cW45NXFaVnJBaWw4ZVhsQUsvQmRqTVA5Ujl2MFF1?=
 =?utf-8?B?aGpZNVJPTGhjeExQcTFLOUxCa1llZS9DMjN4cWhsQ005OWt2TkpDQVNmSjFw?=
 =?utf-8?B?SEJGdWt3a1dBYnFqTW0yV1dEdG53dEtLWWdLc1dMdkVmNndBV2FvemNYSDhx?=
 =?utf-8?Q?shtIdL?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K1F1SXpESDBKeC9Fa0lsSzZ4ZzRaRitiaXptdlA1U3ZJcXBJQ21NeHNuODAr?=
 =?utf-8?B?VDFtalVPVkc1Vkd6Y2plSWJlckNkNmNsdURQZ1JVOUZOMm9EWFBHbzkvVGdO?=
 =?utf-8?B?N1VJcUlDQXRjWEVaZDhOOVFIY3JQaFExL0F3RStrVzJvTlhoUm5icmVZUEJF?=
 =?utf-8?B?QWNrK2pTMytBeC9WeWZNbkRPTTRsUFhWL2kxMmVoT0JSQVdNanJzL2pkeHFL?=
 =?utf-8?B?SG0rdEUrNGdEd2ZnMGxoZUFLR2V4emlkcFFJYjVMU0ZpSVRRa3R3YzNQUnp2?=
 =?utf-8?B?eWZNMVBDV2tmR0hQM0JRS1VVNTlpWnVpenVBTWtVaisrSDJiNStjaFAvSm54?=
 =?utf-8?B?Y3Eva01SL1dhMU9SOW9idzN5TlNtd0FhUEFhbGY1QXlUSTRXUlFjUEh2dDZY?=
 =?utf-8?B?VzFna0lDV1lJdmJFbmtsVWN6cXlMS0xjMDZYbnNoQk1EMmwxM2xqOGtzZjVL?=
 =?utf-8?B?bXJmcUZwRGJDUnE0TlErc0I3SFZpWllhN3c0amd5YlMwZTVSMk9oVnlGdnpt?=
 =?utf-8?B?ZHRTQm1nbFhVaFVLLzh1YUJyWEVrMGNTVXBod0tYTTc5dnozQk1xNU56WDhz?=
 =?utf-8?B?RVEzcU5QeDd0ZCtHZmlkL2xHajJRWjdiajNpWGFzY1dqeGtod0dhOHREMWtV?=
 =?utf-8?B?emhMVDdRYVB5TXk5Y25LVG8rZ3pHMmFTK05pOThOUEVVN1gxTlJuTG5HaUJt?=
 =?utf-8?B?VkhLYWpFTytzNGdTWFNIb0xPWEZnaTZDOXQyTkI4anFLMHJ1S1ZuM2hGcFcr?=
 =?utf-8?B?SEw1TFRqSVZ0em1CL2VQVTFOWllXNE5zS05sUFUxaG51R1ZHLzZGbmo4MGEw?=
 =?utf-8?B?eVFHSFNwUjRrZE9QRFV1azVndXZqQTM3RnVPVUp6UGYyRU45WE4xNWs1T2xG?=
 =?utf-8?B?RWJhNVh2dDU0NEthUFRVZFdvb1hFRWppTUtNSm5ZZkU3UlZhcWwwTkg4cHNH?=
 =?utf-8?B?aUYxdVhrc1ZFSjAvWDBIckVyaCs2QTZXK1lHSHZ2MzBpV21tNkN3UHB1Qmp3?=
 =?utf-8?B?R3MyZDNsYWhNMnFiLzRLNWdGZXliRXNRMXQ3Z2p0QWp0NzMzMzBiZllkZ2cw?=
 =?utf-8?B?K1Y3NWU4T0ZKWlZPOTVBbWpuM0hxaFRxbEtWK2JZMWw3c29jSDA5NGVuZndM?=
 =?utf-8?B?d3grNitiNzBTcFVmUEpVdEFxMnRMUUpZc0EweW1QUTcxZnBJRVd1NjA1RmxD?=
 =?utf-8?B?ajlOaDg0OWxEcVZQRXIvZkhIN09OQmpLRGZRYU9xazhCS084T0I5MlNSa0RS?=
 =?utf-8?B?bU9oaWNsMWMvTEFPRFp3dStXTHJoeG5IZkRMS1lHbDRTNzBTQW5GVkkxUXdO?=
 =?utf-8?B?RVI0TTNNR29MNzFJM0huY3RjMVNqZXlvcWZ4cTcyamRHRytYNUtaTmJDUFM0?=
 =?utf-8?B?djkrR1dsVno2Wk5CVE9LL2pLUEcwMGpaaUVHblEwZ2l0cmppQVpsbFNNQ09s?=
 =?utf-8?B?TGpKeVF2R3JPcmNsbWlaZllyMXRFRHRKS1FVejJYZXJmK2ZNeVNVVVl4YmY4?=
 =?utf-8?B?dzJSMkttTDJ1ZmpRMEk1ZkUwMFV1NmNzMFVHa1RVTW9TZXVDWUk3WWpYcHQ0?=
 =?utf-8?B?a05tR0dYcy93UW1VaVNobXZqc2N4VzBLTkFiVHVCZ1kyYWVqdlc0U1lrY0dJ?=
 =?utf-8?B?MlQxLzRkbTM0Zk1SQzlndVhGRXFuM1VHUGFXOHFWUzVwNDlRVG0rRGM0ei9S?=
 =?utf-8?B?c2ZYMDFISEpXYm1PRmxUcHlGVE0wQkZNTU9SajUzTGFhenhQOGFsK3B3Q1FM?=
 =?utf-8?B?MzN1NGxwZ2tKbjkrdGZVMWsvVXRqMERaNjhmSVFqV2dJckhhT3E0OUVQbXlV?=
 =?utf-8?B?YitTejZpUlZ4czhicVpyM0NDK2dha2ZwV3E2d0U3K2xwOFNVNjRRSENSN2Za?=
 =?utf-8?B?dXhYdWI1M2sxcWJNRG5MbWF1UXBIT3k1Q1Vqd1I1NTR4cFB4dWN6bmw4Q1FS?=
 =?utf-8?B?T01yczJZTHpSTXpHTjVORUdsV3JvTFlid1RrYzRxNVEwTG5zZGE0aUF3Vjd2?=
 =?utf-8?B?SjgwVUZ2T2JvQkI5WUd5MWdrb3RzUCt5OHpRVXNLa3ZNRkpKdDBtRkYrUldU?=
 =?utf-8?B?ZWFNdWhaZzBxanI1YmgzRFpMRTJCMTBsL1JrbDVIL2ZOOGNwcjBNRnB4SERH?=
 =?utf-8?B?MHVOcG9veXBEeTZZVGhFbGNDOG5VUlFlYlViSW13dDBxZk5Cbm0rUUJkNk1p?=
 =?utf-8?B?U0tFYnhLSllDd0pxbk1PTnNFTVRScjE5Q2tHNVo1QjJESHlqT2loOHV1QW5u?=
 =?utf-8?B?U0p1R2IxZU9ZR3B1YnplelhzRzM5VURkMnRPVCtlL1lhcExGVlBXSU1paDdT?=
 =?utf-8?Q?fLHyMTpR1H989UeYuR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8874c1fe-9774-48ee-bcdc-08de17da5936
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2025 17:32:49.9878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ov0oGN1RjrK/mH1DXedQ2jhPi88715X0aZFoAh9HycADIPNmR8rDPmO1CdvIvrzbMODbYczuPsM7mBMs6Thjm9vDaYizDr+UtVkesbs/uBKZjSLTpsJSt5HUtV/8UFaplt5Xi1rvCGWv7cwcdN1lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1814
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,KAM_NUMSUBJECT,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

PiAtaW50DQo+IC1tYWluKGFyZ2MsIGFyZ3YpDQo+IC0gICBpbnQgYXJnYzsNCj4gLSAgIGNoYXIg
KmFyZ3ZbXTsNCj4gK2ludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikNCg0KPj4+IFdoeSBu
b3QgdXNlIC1zdGQ9Z251ODk/DQoNCkhpIEV2Z2VueSwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJh
Y2suIA0KLXN0ZD1nbnU4OSB3b3JrcywgYnV0IGl0IGVmZmVjdGl2ZWx5IGxvY2tzIHRoZSBjb2Rl
IHRvIG9sZC1zdHlsZS4gVXBkYXRpbmcgdG8gQU5TSS1zdHlsZSBwcm90b3R5cGVzIGVuc3VyZXMg
YnVpbGRzIHdpdGhvdXQgcmVseWluZyBhZGRpdGlvbmFsIGZsYWdzLiANCkl0IGFsc28gaW1wcm92
ZXMgcmVhZGFiaWxpdHkgZm9yIG5ldyBjb250cmlidXRvcnMuIEFsc28sIGFsaWducyB3aXRoIHNp
bWlsYXIgcGF0Y2hlcyBhbHJlYWR5IG1lcmdlZCB1cHN0cmVhbS4gKGNjZTJmZmQzNzRlMmFiNDUw
N2NiOTczYzc0MzQ4Y2QxYmU0ZDEwNmUsIDM1NGFkNzg1NjcwMzFlZGIzYzRlNzBhNDllZDc4YTM0
NTRhNjYwMGYgYW5kIG1vcmUpDQoNClVzaW5nIGdudTg5IHdvdWxkIGp1c3QgbWFzayB0aGUgaXNz
dWUgZm9yIG5vdywgd2hpbGUgdGhpcyBjaGFuZ2UgbWFrZXMgdGhlIGNvZGUgYnVpbGQgY2xlYW5s
eSB3aXRoIG1vZGVybiBHQ0MgdmVyc2lvbnMuDQoNClRoYW5rcyAmIHJlZ2FyZHPCoA0KVGhpcnVt
YWxhaSBOYWdhbGluZ2FtDQoNCg0K
