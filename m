Return-Path: <SRS0=VhY4=BY=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazlp170110002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c409::2])
	by sourceware.org (Postfix) with ESMTPS id 06BA54BA2E0B;
	Tue, 24 Mar 2026 12:59:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 06BA54BA2E0B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 06BA54BA2E0B
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c409::2
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1774357152; cv=pass;
	b=C6TDMZncaG+mREVvqTyqBF928dtkh/rDQvFBstzj5uB5ekJUtPRgs7LvCL6S+JPQ4EVDM484hiAGHo94rAdyd8mXjnMp20TLb0/4tuf/Vy4iBBgQU0rqZUwFHGdSW8TykpcGDZOB3vPAzOSaorXzfn6M2wBYNPrUbZHNiEIRKlI=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774357152; c=relaxed/simple;
	bh=rc0HvqIFTntJtji1s1VBnS0BaazmjwNMPPl5OqqMVzE=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=By/LwTbTYahsGqmpCeRw2pypj06qCkBzgqilGSSLZL+HGuQBHTISkCyXWXTnk5KJDtbWaW6bgm94PnkyL0tt5upmZiR2RffHdoJl1VyJ75hiFXYhlPQEOf/dGcvwB/JjkZVCx+wuXHcgzgiFot/3gi1VGcKgxTu9N7vtdoED5os=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 06BA54BA2E0B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=rPmbgd6m
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uSEx5W9+ijLsrNFYoAQasnLvwOjRWn5r2ryqkzaSnQ99FbroLP1yCvg35r8KGprNdMzRXTOhqdA15egYUdd4OdT5eDm0wrqdmDuIWMGU/LEw6mfB7ts1q6wD5faxzf6FNUBabi9G9xE52mOG/V+N9MvB+OFKc+sHVw77GaTxNl47uhltPsFZXCNHsek2rzZtvswS8d+FQO38N4u3h9SmUTaDjdAtwwzx2iiz/VbImqWdrk1uq2f8vmLN+FUqLb1MXE/Xm1QBDBKPWJoDL2vBN1v5YuQecBg39LiBmbTjLxVjZ2lS6Q3m//QjVnyBMeA1ILPo2CkLr+2anZ4kTvc2yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rc0HvqIFTntJtji1s1VBnS0BaazmjwNMPPl5OqqMVzE=;
 b=YSyzcUET0+c6GFkrHsMDe6jNoBhCP0j1p8e0OnUJIG9JwM8YAo7M7PqUv3EfwaUGTlWc1wIWCmPF+48m2Zs4KDP2UdMzs5qFLijqUanXDLXB58ixEDvRbc1mJQw80Fxp6S47xwN6Lm4dI40fgPalemwvXnMpRWxVDiWKLFMw6VSwbrx7x4jUoIgWuBpHfSHFw7+ungvKETfpSwWAZNdfJoGcNzm/3I6mrZomiIsr5P4Kp/12C8YbpmjSC64S1HVOSAIMV4Zzqw/VYRyt2Nd3cq8k28Xv4OwlJ0mZSnD9jxibGtqoTHWW2vCYhGsWOWeNlg2I3LbKXpRUu2q2a9oDUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rc0HvqIFTntJtji1s1VBnS0BaazmjwNMPPl5OqqMVzE=;
 b=rPmbgd6mETlTwlrL2fYN0RleqI8Rn4XT60teUaxFNq62B34+/JSOIGheCXgoVEslgObfCZmxzM3e5ISAk7Dr9vik03QvFbtJrrvNTioRslkifq2fc98krZ2RZ3j7qRAkldagbPjQFTW3zgvd4mT6q413t7fbpCmhwWMC4y5lPWt4c0q7RXxOlgnRvvyQSGBitUreoeIDzVUsEYJIIeNM3i0kEp4+PqiLDlHxmIuERaakv31CSagYVtTtVlpSYm2qLTVHVrJLk0I0frUjw2Q/x6RQcNhdBK5X8qOaJZmQHQpKtKoYUduPZgFaa4o+hwNIK7rxTP+8XxOIp5vBiHQ7eQ==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by MAYP287MB3738.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:14d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 24 Mar
 2026 12:59:06 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::f574:2c10:ce6:4682]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::f574:2c10:ce6:4682%4]) with mapi id 15.20.9723.022; Tue, 24 Mar 2026
 12:59:06 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: Corinna Vinschen <corinna-cygwin@cygwin.com>
Subject: RE: [PATCH] Cygwin: cpuid: add AArch64 build stubs
Thread-Topic: [PATCH] Cygwin: cpuid: add AArch64 build stubs
Thread-Index: AQHcmSwNzCN1h0nfgEK5iX3LfS3CtLV/jCuAgD5bHdA=
Date: Tue, 24 Mar 2026 12:59:06 +0000
Message-ID:
 <MA0P287MB30820F0F7E9D77363FF552549F48A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
References:
 <MA0P287MB30827D0112702D609C0D688A9F64A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
 <aY45yWYgGCvq5fhg@calimero.vinschen.de>
In-Reply-To: <aY45yWYgGCvq5fhg@calimero.vinschen.de>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|MAYP287MB3738:EE_
x-ms-office365-filtering-correlation-id: a34075f5-8b83-422b-c6f7-08de89a521f9
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|18002099003|55112099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 1ZVHnIX0XJuG4Ia7dYdLtp39tnKojP8UGjT45tBGxLV61B5Ka0u4gYUlwFSxB3hu7W0aH3f5RHt8BJy6xd/YyvQ3JS0RFFEFSO31qHKZNulMaVdWkQ5gSjV7LhkmiRw0h8Y6/m+LPBU3G4MNVJcmpzDOTkRKehuVuuoxF5Spq2jEFV6d9Q4ikGDGVWvTGQSiWNzT9Uk2U0b2Ek7AYRj44KQYROFi7q8KgVA3AyKfNglHmkWJba8vUNv+qivzxl1OE27Us6ccoPpyiOxwULCXdI5eMZGhfn0UMW/PFf6D7yQhtSqVNHIA13Uvlvmz8Z3TlKL4BaUtZuA4sUsN5gTsbRF1TtGxR9fBTT3OK6tU1A+45ZTP4Y+TA3V1Q9IeS16NlpHKmcTWIliu+W6sg5gBc8/T7kXb73N7uArRZP9mFdRNpYdf6j/K8KPUPmgwMgzjOf/teD8oVXk4tw6iDUyd7ouq7FbSsZcFjNJykWdrmibzAONr0UWPb/lA8J9qYybst7HZeqIQARcYuFKkV36eReMDqpo+XDbebO4LJxATshZBs4LSK9B/V13tJ3XaRkim5HTPBxwXvHErCHgl9kkU9qIaz1FN25xEOy9AHu84BDoX5kkloOHaZdShRtFRD4J4MtwhqFHfY1PPvBfEvkJcklo00QlbufoxlDq7Fn1V8VCTDXisCuYFi3MvK9cNXsZR09gu5qqmTF7n4ffUK3x9P8l4i5b2T+yuG8JYnuCDvbRTttHADrCKoTZk42hJsSqlCdtV2e5CeNSe8jmkVvoYDsCvM1MvU4h6o+F2Pu1+75Y=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(18002099003)(55112099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cW5BSXdzV0RZU3NxS1FYVlhhZmF2MHN2dHFaRWQ5MVE5SHowODhsY0h4NWl2?=
 =?utf-8?B?cnM1RkVuSXNlUml3bUVROThhZHNSamU5ZCtjSFBFZG5ma0pOR003eW5FR1pl?=
 =?utf-8?B?d2o2SE42bk9ZaDZPWnQxbW9XWU9XRlM0M0cwckRvY2NuVlVLczZST2pycDly?=
 =?utf-8?B?eHVqd2RNcUdsU0FBZEw1UlRhcFZYaWN4S0NDdDNXek1abDEydHpib1Zza0NW?=
 =?utf-8?B?dlRSU0JVZDZIbjhCeHVYdUw1R05wMVVycmFMMUN0ekFUNmZ2dndEWlpybXZz?=
 =?utf-8?B?eTJxWlRqNjNxTWpmK09IejRhRXdDN3dKYnFuOXk2T1RXWXBSQmR0c0hVR0ZT?=
 =?utf-8?B?NXBRcTZaL0tXWnA3eVNoWkJOK0JSQnM0WmF3WmZScWY0UTB5bFJtVTFpZjlW?=
 =?utf-8?B?L3hXNkc1TjdONFB6c2Q1L3cyblFGZUVBenRNZ2ZIWHYxZ3hDSkVQQnFZOXc4?=
 =?utf-8?B?R1JnNmhsV29PbFArU1VJVXZPZHdMd0tyWFlmWnBlNkVHYS9GQnU1Y3h4dmpN?=
 =?utf-8?B?TXVPNWR1dnJ2aFZXTXZpeEhtb0JEbDRlWG9IRHBLQU5zTitKcDU2ZmpsSC92?=
 =?utf-8?B?czBqRUxZOGFEbnllckNHdVN6bkVtZFdWMnJiZDlkWTQ5YkFjY2ErRjhUcW9y?=
 =?utf-8?B?VHMyK29heUNFWXRVVjBQSUhHRkpHeVBRRFBQRDdhTGEyMnQ3RVZUazZRaW1M?=
 =?utf-8?B?YmVOR2wweWV2SVYwSHduTTVhOTM2ZnRtd0p4c3hGNFRoem1wSWRZdnN0UTM4?=
 =?utf-8?B?Z1lDc09wNlhiSWJoZEozSWNwNTBDQTNNMVdRTzhZMFozQXpNSVVLZHI5bG41?=
 =?utf-8?B?L0JXSFRjR1AxUGF1aDloY2JFWlp4eXhnNExNbmV6dndDcTRjZHg5a2c0bHRp?=
 =?utf-8?B?VVNLUHFLSnN0M014UXdQeXpscUFHbGNqQWxwcVB3OEV2VTJMVXFSY3RDakI2?=
 =?utf-8?B?TEFPWXcvZzQ4d1hObmFtTCtVajhqSmNFeXJtcW9Vb1p5UWpHV1lVakJoVzNq?=
 =?utf-8?B?YkZ3QklRUFVBVFJPcVNFS05EWXROZGlURXJSZWQyUy9xUUdTVHZFTUJiUmY4?=
 =?utf-8?B?T1k2SHpMeTdXaVVlYzNIdGhzY2MwVGQ4d004S1MxTWJxY1RteFY5RTMyTHhu?=
 =?utf-8?B?TzNYZjR5MEpzTFBjZEtJQzc5SCt6V2dGSFJ3M2lrTWtQK3pZWWh3cTRCc3Zw?=
 =?utf-8?B?K3NDZVFKK0pYcE12RzFzMDBnK1pXUDNNaXVRamkzUUdHeHRwOFVsSlVPVFNS?=
 =?utf-8?B?SWtzZ1l2V3BibXZnRDc2NWs3T1lEZjRKdHZZejFuR0IrTytEd2FEdlJHRFBu?=
 =?utf-8?B?M2xlaTRZRkZ1aTA3VTVLYmJzZWNiRWQ5YlVvMXVWYzkvUGFiU21Ya2NiYkZ0?=
 =?utf-8?B?VVFqVFZpRDliWEVhVmc2dldYWXRJY0IvNFN4eWNWZWZnVzFNRUkwS2VpaENR?=
 =?utf-8?B?T3BrazBlNEZUTGxOT09HV1c2c2tlQmxoc25mRHExVWp4RzdyRDdzYnlkMEpU?=
 =?utf-8?B?UTdVZ2xqODZKVDJrNCtzeU9sTlFpTGtOZEJzTjRtSWFrUGtwS1MySmlobzlr?=
 =?utf-8?B?NkZsa2Q5ZEhCYUZWMHBWT09BbnNsTXlVOWRZMWc0UTNuWm5pYTlUQzQ4aUYy?=
 =?utf-8?B?V1plWjU4QnRqeUFxYjhOaHQ5bjNCK24xTlNIZzR4VFJhYUJyVHduVXlybzhH?=
 =?utf-8?B?ZTljZmVYRU9CU3FZa2x4dUFWMUcwcE9TM3JuRzJiK2VFYW5yOXg0UVNQNWxO?=
 =?utf-8?B?TWdlNVc5TjBmT2ZoS3ZyaVVBY0gyVlZlM1kwMTk0dWVydlNET0Fyd0ppbXJ2?=
 =?utf-8?B?cXY5bCt3TkdleXZXbnJUSTVIR0xTd1g2T0NMRVpGOTd5SU9La3dka0VVN3N1?=
 =?utf-8?B?QWFJUVFBbkxmTEk1VkdLQUZ0V1lacit4UTFZVGUxUzZya3pEYXZTU1poWTRp?=
 =?utf-8?B?ZEc4SG1nOEo5d1YyL1c2bGJJMnBPUlBrNFN3cXBWeERvWDViY216bitabjNI?=
 =?utf-8?B?QW14dVlJSGRvS1pZQjVVU2VxeDkxc2VKT013bDVXSVk2TUJzTGc0dkRkaDFj?=
 =?utf-8?B?NEc0bXJ2bDJSUHNRVHVieXY1NVVxWCtjZWFsMHVpbzA5RnlRZGIxMW1TdHhY?=
 =?utf-8?B?SkFFNjlBOEdScjAybFZ1NGdCYmVZaTNBZENCK0VOT25iVmZjRWJiZVJ3TXhy?=
 =?utf-8?B?VXkvaVN1SmFFS2pRdXk3ckoxWUtORjBRcUprVlJaelZNVWNGdDVuUnF3cnFj?=
 =?utf-8?B?blNWRjBoUCtqYmRzcCtFTG1RSC9jVUkzdTRZUlJmVUZMQkF2aFFxOHpEcDNG?=
 =?utf-8?B?ZHhXd3Byb0RwbUdUVllVdUwyRDFaT0dtaHd2dVl3bmliUERNSEo2Vmk4NFdU?=
 =?utf-8?Q?rNKsdTh6K/gSr8LTwkeNof4xjb4oYzAEN7tSvHLgnLh49?=
x-ms-exchange-antispam-messagedata-1:
 HB5aHzF/nXsX7YnO/rhhlwn/HxJkNBwzMoQQIhEDl2tbNl5dfDG4D8rb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a34075f5-8b83-422b-c6f7-08de89a521f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 12:59:06.5744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: raNKdY1sJb28vE90daMjLlSSM97ObTJ7/Wl5EnN9m1rrKJAGmHCEXM82+SwaCQA6h4GKiN9bTtErMivrv2KL2c21aTrpJGPGse/m2QD84cXl/9bfHMHqx0o1mPhhMMlp9RErrTbSytviLOStq60T1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAYP287MB3738
X-Spam-Status: No, score=-12.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

SGkgQ29yaW5uYSwNCg0KPmluIHRlcm1zIG9mIGFsbCB0aHJlZSBwYXRjaGVzIHlvdSBzZW50IG9u
IEZlYiA4LCBJIHdvbmRlciBpZiB0aGlzIGlzIHRoZSByaWdodCB0aGluZyB0byBkby4gIA0KPkkg
a25vdyB5b3UganVzdCB3YW50IHRvIGdldCBpdCBidWlsdCwgYnV0IGRvZXNuJ3QgdGhpcyBvcGVu
IHVwIGEgY2FuIG9mIHdvcm1zPyAgSG93IGVhc3kgd2lsbCBpdCBiZSB0byBtaXNzIG9uZSBvZiB0
aGVzZSBwbGFjZXMgd2hlcmUgdGhlIGNvbXBpbGVyIHdhcm5pbmcgZG9lc24ndCBvY2N1ciBhbnlt
b3JlLg0KPldvdWxkbid0IGl0IGJlIGJldHRlciB0byB3YWl0IHVudGlsIHlvdSBjYW4gZmlsbCB0
aGVzZSBwbGFjZXMgd2l0aCBhY3R1YWwgY29kZSwgZXZlbiBpZiBpdCdzIGEgYml0IGhhcmRlciBp
biB0aGUgaW50ZXJpbT8NCg0KWWVzLCBJIGFncmVlIHdpdGggeW91LCB0aGlzIGlzbuKAmXQgYW4g
aWRlYWwgYXBwcm9hY2guDQoNCkF0IHRoZSBtb21lbnQsIHdl4oCZcmUgd29ya2luZyB0b3dhcmQg
cmVwbGFjaW5nIHRoZXNlIHN0dWJzIHdpdGggcHJvcGVyIGltcGxlbWVudGF0aW9ucy4gDQpPdXIg
Y3VycmVudCBmb2N1cyBpcyBvbiBTU1AgYW5kIGF1dG9sb2FkIHN1cHBvcnQgZm9yIGFhcmNoNjQs
IGFuZCBJ4oCZbGwgYmUgc2VuZGluZyByZWFkeS10by1yZXZpZXcgcGF0Y2hlcyBmb3IgdGhvc2Ug
c2hvcnRseS4NCg0KV2XigJlyZSBhbHNvIGluIHRoZSBlYXJseSBzdGFnZXMgb2YgZXhwbG9yaW5n
IENQVUlELXJlbGF0ZWQgZnVuY3Rpb25hbGl0eSBvbiBhYXJjaDY0LiANClNvIGZhciwgSSBoYXZl
buKAmXQgZm91bmQgYSBjbGVhbiBvciBzdHJhaWdodGZvcndhcmQgc29sdXRpb24sIHNvIGFueSBz
dWdnZXN0aW9ucyBvciBwb2ludGVycyBpbiB0aGlzIGFyZWEgd291bGQgYmUgdmVyeSB2YWx1YWJs
ZSBmb3IgdXMuDQoNClRoYW5rcyAmIHJlZ2FyZHMgDQpUaGlydW1hbGFpIE4NCg0KPg0KPiBJbi1s
aW5lZCBwYXRjaDoNCj4NCj4gZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vbG9jYWxfaW5jbHVk
ZXMvY3B1aWQuaCANCj4gYi93aW5zdXAvY3lnd2luL2xvY2FsX2luY2x1ZGVzL2NwdWlkLmgNCj4g
aW5kZXggNmRiYjFiZGRmLi4yMzhjODg3NzcgMTAwNjQ0DQo+IC0tLSBhL3dpbnN1cC9jeWd3aW4v
bG9jYWxfaW5jbHVkZXMvY3B1aWQuaA0KPiArKysgYi93aW5zdXAvY3lnd2luL2xvY2FsX2luY2x1
ZGVzL2NwdWlkLmgNCj4gQEAgLTEzLDE3ICsxMywyMyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgX19h
dHRyaWJ1dGUgKChhbHdheXNfaW5saW5lKSkgIA0KPiBjcHVpZCAodWludDMyX3QgKmEsIHVpbnQz
Ml90ICpiLCB1aW50MzJfdCAqYywgdWludDMyX3QgKmQsIHVpbnQzMl90IGFpbiwNCj4gICAgICAg
ICB1aW50MzJfdCBjaW4gPSAwKQ0KPiAgew0KPiArI2lmIGRlZmluZWQoX194ODZfNjRfXykNCj4g
ICAgYXNtIHZvbGF0aWxlICgiY3B1aWQiDQo+ICAgICAgICAgICAgICAgICA6ICI9YSIgKCphKSwg
Ij1iIiAoKmIpLCAiPWMiICgqYyksICI9ZCIgKCpkKQ0KPiAgICAgICAgICAgICAgICAgOiAiYSIg
KGFpbiksICJjIiAoY2luKSk7DQo+ICsjZWxpZiBkZWZpbmVkKF9fYWFyY2g2NF9fKQ0KPiArICAv
LyBUT0RPDQo+ICsgICphID0gKmIgPSAqYyA9ICpkID0gMDsNCj4gKyNlbmRpZg0KPiAgfQ0KPg0K
PiAtI2lmZGVmIF9feDg2XzY0X18NCj4gKyNpZiBkZWZpbmVkKF9feDg2XzY0X18pIHx8IGRlZmlu
ZWQoX19hYXJjaDY0X18pDQo+ICBzdGF0aWMgaW5saW5lIGJvb2wgX19hdHRyaWJ1dGUgKChhbHdh
eXNfaW5saW5lKSkgIGNhbl9zZXRfZmxhZyANCj4gKHVpbnQzMl90IGxvbmcgZmxhZykgIHsNCj4g
ICAgdWludDMyX3QgbG9uZyByMSwgcjI7DQo+DQo+ICsjaWYgZGVmaW5lZChfX3g4Nl82NF9fKQ0K
PiAgICBhc20gdm9sYXRpbGUgKCJwdXNoZnFcbiINCj4gICAgICAgICAgICAgICAgICJwb3BxICUw
XG4iDQo+ICAgICAgICAgICAgICAgICAibW92cSAlMCwgJTFcbiINCj4gQEAgLTM3LDYgKzQzLDkg
QEAgY2FuX3NldF9mbGFnICh1aW50MzJfdCBsb25nIGZsYWcpDQo+ICAgICAgICAgICAgICAgICA6
ICI9JnIiIChyMSksICI9JnIiIChyMikNCj4gICAgICAgICAgICAgICAgIDogImlyIiAoZmxhZykN
Cj4gICAgKTsNCj4gKyNlbGlmIGRlZmluZWQoX19hYXJjaDY0X18pDQo+ICsgIC8vIFRPRE8NCj4g
KyNlbmRpZg0KPiAgICByZXR1cm4gKChyMSBeIHIyKSAmIGZsYWcpICE9IDA7DQo+ICB9DQo+ICAj
ZWxzZQ0KPiAtLQ0KPg0KDQo=
