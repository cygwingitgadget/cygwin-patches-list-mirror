Return-Path: <SRS0=eWEp=AX=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c409::1])
	by sourceware.org (Postfix) with ESMTPS id 0090F4BA23CB;
	Thu, 19 Feb 2026 19:30:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0090F4BA23CB
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0090F4BA23CB
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c409::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1771529420; cv=pass;
	b=sAl3foooZ3CLYuhx6Ka4DmsXWRTOjkEnaxZFKkyVph2+S+IA4Ayh5SUSHWRhnWcJ1CvWG+YHone0w6/UxV9oP8aqkFQM6i1dfwRAXJl8w7N7jQzfZgIYFzSAunIPy1B56JZx8xS7wwu/zfJu8IQ3OwEx+G9kkOMCpyKTywbkGdo=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1771529420; c=relaxed/simple;
	bh=mDtcQts+g+VLkWebUgOnB7mQUXfVq0Y8Gw0piuPd/5o=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=gu/cQn9/YDCJjmrV2Cd2E9hoG6ZWa095xXLAGpX+42AVONZEIxZ/OLtyGZmVEGxIkbvYm/wWDtaFGrWdGT761m0RpsKnTTh/QUFcxbyyk7zERH9op0mJe478CYp9rMAd5gFePSizxpncofEo/SHi/5z771bHux48XzKjjG5xP6g=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0090F4BA23CB
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=mR5GkvdL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bhwjqmg4cOUQNsseq/WeoZ+6ToWICC+PcfApJky6AG0DI6KAOs3JPhE5wtsAUKwOuwKDKZxGR04U0dRNSyz58xvyifQQyzUixgTOEBAgmy5eupTisCD0a7SHnYVy+EJ+tZyg4zEs4fiVAWzeksTu2XdysoST1XTFVlY7RViOTMdiejAdKIEcbE+3BLSN0UFXr/tvKwQn5uSjotNBwO0B3j8Y8lvhaP9SnrJg4JkDNMY8D1dBi7c7qvcCLZewzeS718Zmwn7aldwn9kTaGYflkcVx0RcUBMxNl38ybDyEl+q/D1EfKhh/ffMdw2R+wi6rBBBqAurBAQkeCnE9cdIx6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHl/Iu2oMjaVhJqqE2HxY604pFXARTh4lSbc1qXdP78=;
 b=H0zpQI3qqeOZdqmliYOSneMPIi2f+7HvXtZasO3DabHhY2rH5Ciqw+FyYuluCsF6Uu+lIBvLO3cNX+s+pUuORqghdY03rGmgeQEZiFQrM1wsOgDKbJskwE+ooUmWNZ4aEeHupqaXRaTiWEBOzz0BWNgRJg3rubU8W9eWdNdN5Io7RaM/ojPe1djAR6fDmrzZeDS+fA7ET3eRicLOQ4DeXHeUvfyxD1w88S5Bxp6IY+lgbbM0qy38cqFEDw3scgFJDhZBCt5hDJdSgUcc6T2hApfHTndMbneomXCfSuCd80X+p1xJsoTZkOjPoyfQsSk2UnowDtDP3awKbqrowgnHpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHl/Iu2oMjaVhJqqE2HxY604pFXARTh4lSbc1qXdP78=;
 b=mR5GkvdL6lrlxywFZGw3dbi2GuPt+vWdGChRVG3PGBC3Zzqt2gMuMrhqwdgSqrPSZPVHSDn1XXEBFy+IqSTok/ipOQQm5OBnEr0MNbdlwym+aex4i1/RynLI+UoHrsB+FEE8BHb3+BblaL8STIxAZw5oWqr8g4dgDHuDtdwxNS1xmrUfhD6LHK3kauCe9KS/bcorXlSFqyDgOjIV7z+0rpTF4el2Xc6NEyXtnhC4fLxGJ7w6LtF7dhwD6UfMI8UqeDwBqeGDkmUHPuMLAn//qvxnftgEvWe0JF/3+0yhmf7CN9QzP1l4s+DoNpHKvJSl77O8KyoorPZjXqcQGaVq/w==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by MA0P287MB1563.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:107::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 19:30:16 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::f574:2c10:ce6:4682]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::f574:2c10:ce6:4682%4]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 19:30:16 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: Corinna Vinschen <corinna-cygwin@cygwin.com>
Subject: RE: [PATCH 2/2 V3] Cygwin: gendef: export _alloca only on x86_64
Thread-Topic: [PATCH 2/2 V3] Cygwin: gendef: export _alloca only on x86_64
Thread-Index: AQHcodYtsiatKRsqA06FUvT8WyNT2A==
Date: Thu, 19 Feb 2026 19:30:16 +0000
Message-ID:
 <MA0P287MB308238F12BC9D259C02CC7EC9F6BA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
References:
 <MA0P287MB3082B2BA4E9D476168C4DB919F65A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
 <aYpCJ6Tybk0mGTLa@calimero.vinschen.de>
 <MA0P287MB3082A6AAABBF6611C1B989349F62A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
In-Reply-To:
 <MA0P287MB3082A6AAABBF6611C1B989349F62A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|MA0P287MB1563:EE_
x-ms-office365-filtering-correlation-id: 1bd9dd48-7037-4e94-92f8-08de6fed4f9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|6049299003|1800799024|10070799003|366016|376014|38070700021|4053099003;
x-microsoft-antispam-message-info:
 =?utf-8?B?cHBKdU82dG5CMjNMWmIxbVgvbTVSMFlIMDNNZUZLcE5JMStvZS9MNTVNeHA2?=
 =?utf-8?B?NGsvODl6T3NSRjBuMjJFNjR3U2lJUXczVHM4SFQ1NG15UTJFeGpXRFZscWNq?=
 =?utf-8?B?NGFPZDVJNzZQSi9uMktMLzVJT2ZRdmQ3ZTZIVHRCdW05MGo4Y0VBYVhEYXkw?=
 =?utf-8?B?b1V2OVJqWW41MEI1Y0wveDlUZEl3OFQrL08zRnBqTjlVZ0dZY3pDOFpIaXpv?=
 =?utf-8?B?TWtVb0hGRTMvUFdyS1ZQSjJLZWhKSmpOaVZPL0ZTc29CblFCVFladlpndmFR?=
 =?utf-8?B?SEZRSDZKZW5QRmMxK2pTNmZKUWMzQXE3YUp2RlovR29OOVpjZDZXWE95RGor?=
 =?utf-8?B?cStNdFRZOVRDeEFLaVpMSmFpNmlhOXlOR0l3cWNKbDVybERDaHpmaVh1OEtp?=
 =?utf-8?B?cG03d1hsejhmdWphQzFnL3NYaW4wQTEyZnR1MTVuV0pRbHZXQ3JOMmhGajU0?=
 =?utf-8?B?djFuajhNQjJiNjNOTnNYWkxqOHptQldEL2lNWXc5UkNTd05qa0d4RXY1YUhJ?=
 =?utf-8?B?R3o3OUN0ZEFwVGhCdTNycVBnbWw4TUgyamRuWEwzaGU3ZEdFSVpPcFAvWnVa?=
 =?utf-8?B?UGhFSTM1bHpwdXdYbEllcUljZHBOc2RwUEVCU2xIQWp5Z2xHWU5SSW5saENV?=
 =?utf-8?B?TU5mZmFlakQwN2dLREtGbUZlc2pCaWVra2NBeWN0ZnRUa24zejBtby8wRU04?=
 =?utf-8?B?WlZiOGZDSjZKeHoxS2lEcExjS3VPRU1BQnZ5UWhzQnVGQUc5NU1jcmtXTzk3?=
 =?utf-8?B?MlRqRVNmY1BWaXVoL1ZqWWIwMDAyWlZjKzY4YzMwdjd5b3l5akkzOVg5YVhz?=
 =?utf-8?B?dGJTNEtjUklERkR1cjhmNHAzQkczTkRha0JkMWdwTnNFeWJiclpkTFlCTm9C?=
 =?utf-8?B?b3UyK214WE41MUlPSDhEc3FVSGsvRHIyNWtkVXczZE11THJueElEazhRa0M3?=
 =?utf-8?B?ekk5aEVmU1VHSGRJNEVZSi9NY09HM0tIMVBxWFZPKzZPdFF1MHpjRlFoMHU0?=
 =?utf-8?B?eHQ4WFFLMFVxNit2cko0NUlla21jSndUZlljL05DZTZFQU5pYzN5YkR3WmZV?=
 =?utf-8?B?VS9yczYrMHcrejlDUGxUaE5VYVFlZFJQdWMzRDBvS3phZU5xYXp6QktKUDV5?=
 =?utf-8?B?WmJBdUZYKzZtcnZYUVlCRlRRakpWTE4yQVhOQnJkS09Ma3BNWVlxT1RzNEhy?=
 =?utf-8?B?UVFRTjZBRURKQi85Q2E1c0hWY0ZTZHNNc0pGYm5PK3dXZm4xR3VWRHBMRG9X?=
 =?utf-8?B?NTBtZ3NaVFlBcE9SbWxNRThoekhjRDhySGxlbElsK1hta1pPNTdiUTJjbGhZ?=
 =?utf-8?B?bEdhSTlkWGFaQmpWY1VheFhjT0VnWCtGc2tLSFRUV3RJbytIbE5HTzJ4TTV4?=
 =?utf-8?B?cXFTV050UGVBdVhacFVNL0RlRDVxd29QY01PS2htUmhNY3lqWjk0blAxV1p6?=
 =?utf-8?B?RTkzVVlSM1g4N0ZMN3J0QVNoTGUyb040YmRIVEk0WXVhay8vaTVUcVVMNjlN?=
 =?utf-8?B?KzZES1h5SnA2eHkyT3IwK29nSmJRQVFOekpwcG5HWGFsL0FUVGs2V2NxMzRu?=
 =?utf-8?B?VHptdytQRWVFMTZOWUlUK0cvZlJXditiSDRTRG03TVdiQkhpV0tmcU5XS05T?=
 =?utf-8?B?UmluTWpsK1VWMGs4VDNGN3lZQ2lpaG1FblpCSnhraDJWKy9NamxDa3BjQm80?=
 =?utf-8?B?a2NzcU1tclJhL3VFT3BzWGEyV1REY05xWVFGZmRzbEFVQjBVQi9vVC9tVDdX?=
 =?utf-8?B?SWM1aXBsZTZWTzE2NmFYbnhKSXVzUmhtOGNpcUlvejErL09zMFR4TWd4Yms3?=
 =?utf-8?B?Q3NXN2x2Z0FubCt1M29FeFZwd3ZnWkR4TGM0TEdwM2JSem1iNXUrSnllc2JC?=
 =?utf-8?B?SDBrTFYzdlR2TktLb0hmdmRYMjBERHM2K0JDcGlWSnlWeWxnYlVMbnVLRHZv?=
 =?utf-8?B?dlhTRUZibjczRmxIWkpteFhEYVJScjQ2TmhVSDJ0SzRlaUFpY0RzM2VNN2VM?=
 =?utf-8?B?SCtManp6WkZFb3ozVENOQ1JVQzlrZzlyTWU3dWlYOWtpOTBvaGJiWkExTVN1?=
 =?utf-8?B?SFZXYWtxK0UvVmpCU0RNQW9nbk00c2tYWmVWYitsdVFCc1VJUC8xSWVsUmtr?=
 =?utf-8?B?am9VSDJyaU1BQ1FxaXBXU2ZBMnpYUTNsZTVTV1kzQWRuZ0h0enZBRDE4eGY3?=
 =?utf-8?Q?1wfPK9A47b8w3PaOD34GVr8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(6049299003)(1800799024)(10070799003)(366016)(376014)(38070700021)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TE1GVmRmbFVzeWxqMDJiNGgzalJZT1MrcDRPalFJN2dtQzJ5MkpNcGpoeXVi?=
 =?utf-8?B?M1h0bk5PaXBveWJ5RjBQTEVEdGtkaU1ETjhJV3pLVzNzTUtrd05sNjYzTXRw?=
 =?utf-8?B?NjBlNytPODVnNWt2dkx5U1pDbVJJUGhBSFJma1JZdDNBdkxMUUVsZ2pucDhi?=
 =?utf-8?B?VzRwV2Q2Wkl1R1g3dnNSR0ZQYWt2QVFGTjR3Sk5hNWdtSm5jU0dXUmFsalc0?=
 =?utf-8?B?UFp1L2hiSEV5MkVyUHhNYzBpMk9SWGkrcHpsdllnbHltcGJwQkRpdm5ldmlm?=
 =?utf-8?B?VW5EQ0RuVEFQeG1zaVNuWU01OHJxQnZxSktXenZ3WGlLSnRiSmtqTm9HU0Yz?=
 =?utf-8?B?Tnh1OThnbDBzdU1obDJ0R3k3YW9odUpGdXZvM1RsU2MvTmhjNWhzK3kxVmRx?=
 =?utf-8?B?ek16QUZUODRUbFN0TjlCMGRpM1FaOEp4SkxJbVdWbEhZaThPZmpneDdkOTVz?=
 =?utf-8?B?UDdEbVhwZDlTN05vclYxejFFejkyRkNMTVF4WHBpTHBzbnMzS201SlJUVGMv?=
 =?utf-8?B?ZEEwdytFbHJISGlMNWl0MWZyS1BHcWt0ZDI3NkdjUTdkL0pFZlFuKzh6eVlr?=
 =?utf-8?B?emFkQVhwdkY4ZTRRVm1ScDh6Tm9pODF3T1drb1p2OG1WamZFZGpWOWZJdXhj?=
 =?utf-8?B?aXh1bThxb01Cc1o2bE9lN2hGeU1aTWh3bGFTTW53T0R2cVAxR28wQVp6czNm?=
 =?utf-8?B?cUxUK2dlTlVONEMwdTJicHJDTGkxUDExRDVhZkovT2FGdFFyZS9SWDl5VDJG?=
 =?utf-8?B?aWVWK1JDaEZUazhpMW5RdnoyVUpqU0thQXpXbkRqZTV0ZTNzWk1HN3RaTnl6?=
 =?utf-8?B?Tmt3cEdYUVZ2OW5RT1RxZHBDZnRmM3Uza3dZYU93dHh0R1JDOXAwYmFKcHdQ?=
 =?utf-8?B?OTUrTk0wZHBBbnU4UnA1ei9yNUZFODFSWENWbmNzRzZ2ZnQ3Q3dEU0RoNlFI?=
 =?utf-8?B?SHNkODZBMlV1QVd2aGFHVEd4UVA1RDUvRUhzaWx4ZU1qYzNDZlFTcytFaGQ4?=
 =?utf-8?B?NWsyWjFWS1gvY3U0UmhnZXZ1WGtuWldQYTIwVUNKMVBjaUEvbm1sTGpPUU5D?=
 =?utf-8?B?VDR1VGd5eklGaXFLT0FWVVVORXpWV045MmcxbmEzMDlwOW9RdzhDMG8zc3JC?=
 =?utf-8?B?TDB6V2ZJcFBVaXRQa1ZhUXh1WUk5R3FjRmxzTGxyRFpIRVVLT3lUMCt2MWZw?=
 =?utf-8?B?T1lMM0tWU1lZRElPL1B4ZHNvanJQMUxFcUJZRWZ2YmVScEhmcmpLUzU1Sm83?=
 =?utf-8?B?UC9TTW5LVTJZeURqQ2lYTFBIVHpDRU9xcFZzS0pYQ2Zma2Z6azYrMDZQSnI5?=
 =?utf-8?B?MDRmTjlLR0tnRUJ2WFd1SUlxVGViQm9VUitKdUFhTXU0SkVCUXZtTWRHVGk3?=
 =?utf-8?B?NWZUOTNHR1FsVnJGeWhJSS9NbGh6K3BUaU95ekhrdFQ4NWhDa250Z1JpK05M?=
 =?utf-8?B?dHRXODloUlgyQjduYXkvR0dJZVgwVDZWQTRlN3hEdENUM2Q5cnZOQTlvSXFI?=
 =?utf-8?B?OTdBYW40R295N1ZqMlhuZ2lmaDJNRXAzK2dKN0wyaUR2ZXVCRzBkYVczNDRj?=
 =?utf-8?B?S0x5QU5ia3JwNnV0L3Z2bEVpb3ltckYzVGpPYnJRcG83L3Vhc1JreUYyK2VQ?=
 =?utf-8?B?ZUtqOUR0Vk0vbXhnVXQ0U0ZLclQrdlpoa2ZXV3dNMDArem9rY2h5RHNwWmlS?=
 =?utf-8?B?VkR2T3hFM2RkU2JtUHh1SUkwTDhoU21xWVU2eDFlOW4vRG9JQlZzQWJyMFJy?=
 =?utf-8?B?em9xd3RzKysrN3RkQm5RZ1dySkZDdDdFYXdwYUhyUzJRSHZrZzhNVk5LbE93?=
 =?utf-8?B?aXlPUzV6bitsS1p3YjFiR3dJU3o5eEVqRVNESVR5WVhQZDJESGNkTS9WN2l5?=
 =?utf-8?B?WmRmcnZ3SmtleHJZRGNocXNtMFk4dUVyVDIzTUEzR3hPNi9mS2dwbUFYZzN2?=
 =?utf-8?B?Qm9XV3FtRDRjYnhEQzJ2cXNRMHhwbzZPQkNQZG5EZGlSV2VzVUoyYVUycHNK?=
 =?utf-8?B?SnU1RmkwSzQxRmdVdFR4UHRKYU1qUVA2NzlZQUZyYytpZUhrdXJudkNlWWVG?=
 =?utf-8?B?T2orY05GVC9jcE9zYWYzMEtydzJ3R0dpZlFmTFF6NVIxWE9yWXVNWXljVmxN?=
 =?utf-8?B?MW1yL2lqMlRiTWYybkVHZ0VjTS9nOUZwQ3RUZzFjMUpZU1g2Mjd3b0F2eFBy?=
 =?utf-8?B?QVhHa2NFWWxLZmVMYk12cmJydmVya2RndTFwWkVYazRCUDRVekhpUmpwNGJL?=
 =?utf-8?B?Y3JlVkg1MURjTmkrc04rUHpZR1Qzd0UyUmJiV0IrTVF5RGIyeSt3Y3d0Nll6?=
 =?utf-8?B?dTJtTjdkOVIrVmlrbGNXNnlhYUtVMCtWYlIrQjVVbjJwT1grR1lUMXpldkhn?=
 =?utf-8?Q?iEjahpuQZcTYjwZVGasguweGlivXlWRhdLMkbNjL7nApO?=
x-ms-exchange-antispam-messagedata-1:
 6EH2DqxVs6BVIMH4Vq5TIGUFBGXS6g1JHoVneAc7Jv2UbaKXDaxJwfC2
Content-Type: multipart/mixed;
	boundary="_002_MA0P287MB308238F12BC9D259C02CC7EC9F6BAMA0P287MB3082INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd9dd48-7037-4e94-92f8-08de6fed4f9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2026 19:30:16.6605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i8bhMy9K1hs5p0sllrX9uVJ9gB34bUJNNJAbKbzbD6Y8RlnpsjKm7RxJwnzG04WlobxHPBRz9anwDYzQOsedpNL9Aj/May1GJdXu8l1IGerQhbk9rGcCv/Qt/x2IQ8xBm/QB4pZ1nhQWJA2fil0zlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1563
X-Spam-Status: No, score=-12.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_MA0P287MB308238F12BC9D259C02CC7EC9F6BAMA0P287MB3082INDP_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNClJlc2VuZGluZyB0aGlzIHBhdGNoIHRvIGFwcGx5IGNsZWFubHksIGFzIHRoZSBwcmV2
aW91cyB2ZXJzaW9uIG5vIGxvbmdlciBhcHBsaWVzIGR1ZSB0byBjaGFuZ2VzIGluIHRoZSBkZXBl
bmRlbnQgcGF0Y2ggKGh0dHBzOi8vY3lnd2luLmNvbS9waXBlcm1haWwvY3lnd2luLXBhdGNoZXMv
MjAyNnExLzAxNDY0Ny5odG1sKQ0KDQpUaGFua3MsDQpUaGlydQ0KDQpJbi1MaW5lZCBwYXRjaDoN
Cg0KZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vY3lnd2luLmRpbiBiL3dpbnN1cC9jeWd3aW4v
Y3lnd2luLmRpbg0KaW5kZXggYzM1MThmNDgwLi43NzA5YTA2NTMgMTAwNjQ0DQotLS0gYS93aW5z
dXAvY3lnd2luL2N5Z3dpbi5kaW4NCisrKyBiL3dpbnN1cC9jeWd3aW4vY3lnd2luLmRpbg0KQEAg
LTE0NCw3ICsxNDQsNiBAQCBfX3hkcnJlY19nZXRyZWMgU0lHRkUNCiBfX3hkcnJlY19zZXRub25i
bG9jayBTSUdGRQ0KIF9feHBnX3NpZ3BhdXNlIFNJR0ZFDQogX194cGdfc3RyZXJyb3JfciBTSUdG
RQ0KLV9hbGxvY2EgPSBfX2FsbG9jYSBOT1NJR0ZFDQogX2RsbF9jcnQwIE5PU0lHRkUNCiBfRXhp
dCBTSUdGRQ0KIF9leGl0IFNJR0ZFDQpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi94ODZfNjQv
Y3lnd2luLmRpbiBiL3dpbnN1cC9jeWd3aW4veDg2XzY0L2N5Z3dpbi5kaW4NCmluZGV4IDEyYTQ5
YjAwOS4uZjM1MmI1ZThjIDEwMDY0NA0KLS0tIGEvd2luc3VwL2N5Z3dpbi94ODZfNjQvY3lnd2lu
LmRpbg0KKysrIGIvd2luc3VwL2N5Z3dpbi94ODZfNjQvY3lnd2luLmRpbg0KQEAgLTQsMyArNCw0
IEBADQogTElCUkFSWSAiY3lnd2luMS5kbGwiIEJBU0U9MHgxODAwNDAwMDANCiANCiBFWFBPUlRT
DQorX2FsbG9jYSA9IF9fYWxsb2NhIE5PU0lHRkUNCi0tDQo=

--_002_MA0P287MB308238F12BC9D259C02CC7EC9F6BAMA0P287MB3082INDP_
Content-Type: application/octet-stream;
	name="0002-Cygwin-gendef-export-_alloca-only-on-x86_64.patch"
Content-Description: 0002-Cygwin-gendef-export-_alloca-only-on-x86_64.patch
Content-Disposition: attachment;
	filename="0002-Cygwin-gendef-export-_alloca-only-on-x86_64.patch"; size=1235;
	creation-date="Thu, 19 Feb 2026 19:28:53 GMT";
	modification-date="Thu, 19 Feb 2026 19:30:16 GMT"
Content-Transfer-Encoding: base64

RnJvbSA0MzM3MGQ5NGEyMjFjM2FjZWY3YWQxMjQ3MWM0Mzc5ZDdmNmMwNzQ1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5hZ2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFn
YWxpbmdhbUBtdWx0aWNvcmV3YXJlaW5jLmNvbT4KRGF0ZTogVGh1LCAxOSBGZWIgMjAyNiAyMjoz
MjoyNiArMDUzMApTdWJqZWN0OiBbUEFUQ0ggMi8yXSBDeWd3aW46IGdlbmRlZjogZXhwb3J0IF9h
bGxvY2Egb25seSBvbiB4ODZfNjQKClRoZSBfYWxsb2NhIHN5bWJvbCBpcyBleHBvcnRlZCBvbmx5
IG9uIHg4Nl82NCBhbmQgaXMgaW50ZW50aW9uYWxseQpvbWl0dGVkIG9uIEFBcmNoNjQgdG8gcHJl
dmVudCBsaW5rLXRpbWUgZXJyb3JzLgoKU2lnbmVkLW9mZi1ieTogVGhpcnVtYWxhaSBOYWdhbGlu
Z2FtIDx0aGlydW1hbGFpLm5hZ2FsaW5nYW1AbXVsdGljb3Jld2FyZWluYy5jb20+Ci0tLQogd2lu
c3VwL2N5Z3dpbi9jeWd3aW4uZGluICAgICAgICB8IDEgLQogd2luc3VwL2N5Z3dpbi94ODZfNjQv
Y3lnd2luLmRpbiB8IDEgKwogMiBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQoKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vY3lnd2luLmRpbiBiL3dpbnN1cC9j
eWd3aW4vY3lnd2luLmRpbgppbmRleCBjMzUxOGY0ODAuLjc3MDlhMDY1MyAxMDA2NDQKLS0tIGEv
d2luc3VwL2N5Z3dpbi9jeWd3aW4uZGluCisrKyBiL3dpbnN1cC9jeWd3aW4vY3lnd2luLmRpbgpA
QCAtMTQ0LDcgKzE0NCw2IEBAIF9feGRycmVjX2dldHJlYyBTSUdGRQogX194ZHJyZWNfc2V0bm9u
YmxvY2sgU0lHRkUKIF9feHBnX3NpZ3BhdXNlIFNJR0ZFCiBfX3hwZ19zdHJlcnJvcl9yIFNJR0ZF
Ci1fYWxsb2NhID0gX19hbGxvY2EgTk9TSUdGRQogX2RsbF9jcnQwIE5PU0lHRkUKIF9FeGl0IFNJ
R0ZFCiBfZXhpdCBTSUdGRQpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi94ODZfNjQvY3lnd2lu
LmRpbiBiL3dpbnN1cC9jeWd3aW4veDg2XzY0L2N5Z3dpbi5kaW4KaW5kZXggMTJhNDliMDA5Li5m
MzUyYjVlOGMgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4veDg2XzY0L2N5Z3dpbi5kaW4KKysr
IGIvd2luc3VwL2N5Z3dpbi94ODZfNjQvY3lnd2luLmRpbgpAQCAtNCwzICs0LDQgQEAKIExJQlJB
UlkgImN5Z3dpbjEuZGxsIiBCQVNFPTB4MTgwMDQwMDAwCiAKIEVYUE9SVFMKK19hbGxvY2EgPSBf
X2FsbG9jYSBOT1NJR0ZFCi0tIAoyLjUzLjAud2luZG93cy4xCgo=

--_002_MA0P287MB308238F12BC9D259C02CC7EC9F6BAMA0P287MB3082INDP_--
