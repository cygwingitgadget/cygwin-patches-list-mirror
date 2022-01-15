Return-Path: <lavr@ncbi.nlm.nih.gov>
Received: from nihcesxway3.hub.nih.gov (nihcesxway3.hub.nih.gov
 [128.231.90.125])
 by sourceware.org (Postfix) with ESMTPS id 483773858D35
 for <cygwin-patches@cygwin.com>; Sat, 15 Jan 2022 19:04:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 483773858D35
X-SBRS-Extended: Low
X-IronPortListener: ces-out
X-IronPort-AV: E=Sophos;i="5.88,290,1635220800"; d="scan'208";a="331087904"
Received: from unknown (HELO mail.nih.gov) ([156.40.79.162])
 by nihcesxway3.hub.nih.gov with ESMTP/TLS/AES256-GCM-SHA384;
 15 Jan 2022 14:04:15 -0500
Received: from nihexb4.nih.gov (156.40.79.164) by nihexb2.nih.gov
 (156.40.79.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sat, 15 Jan
 2022 14:04:14 -0500
Received: from GCC02-DM3-obe.outbound.protection.outlook.com (156.40.79.133)
 by nihexb4.nih.gov (156.40.79.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18 via Frontend Transport; Sat, 15 Jan 2022 14:04:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtbXQAmYa4tmaRYFe9hmeNogPlFgH7U2tLnffUfnpVy1x7+vmIMZebokjGaaY7D7I7xSyxVcfVODAyv4Swdx/lJTHkTnnpr4Ai85FPEEUZ66Lj6ZCFRprQ/4JWzFwaFX1busmK20zLkgM9h0mWGqeXDxX4VTfwNIDY3JOPpwva7T3H++rhUf9a4Qp35dpPR+9BShPzW6szRy3fFs75rIgI6NNReFFu0fx1ITJHZmlnFc0eV4l79GuwWPhgfEnKQW9eYmaViuzSPVjL7+z24ogVR9tgW8merHiHJo0WvFaUi42wXiFVVcxpdHg+u4fmFTLsyoxNFPfFdDuuJGpbwxzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/0M33YwyTRJSqgp+UtBTjF5qyhnG6+eAUE4G3xHfkM=;
 b=gE575haWdMfZt9EmCD/lVoGBcksNtMN4lScXC+WhP9GS3Bi9cf7AFi+XZcA8OEdy8TPEYrLRlV+GIfdHVyumm2Goj7sLxxE2nHXo6dyk5o20TlMAht6tyX3EzsM4XsHK/B3ijgbRepO+Oal0kz0Zy61tabbdsfYiubxmybGWo+oMeOaQMk5qMZua8qD8hhFWoHYhpslEhQCAEug/wPvebqivTzynbRkJACJm7Y239WKOX2SPHQ1CniY6I6h7DtNLN/T1A9TeSNrtfCkmTCDpFv1OEyZNeg/PQy6c+cqLX7cfRzsrsnXzo4B5fTgwO9kyNT0Bbd8fzMfGAOWF2XCWzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ncbi.nlm.nih.gov; dmarc=pass action=none
 header.from=ncbi.nlm.nih.gov; dkim=pass header.d=ncbi.nlm.nih.gov; arc=none
Received: from DM8PR09MB7095.namprd09.prod.outlook.com (2603:10b6:5:2e3::14)
 by DM8PR09MB7285.namprd09.prod.outlook.com (2603:10b6:5:2e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Sat, 15 Jan
 2022 19:04:14 +0000
Received: from DM8PR09MB7095.namprd09.prod.outlook.com
 ([fe80::d82c:2f49:8b4a:6d41]) by DM8PR09MB7095.namprd09.prod.outlook.com
 ([fe80::d82c:2f49:8b4a:6d41%4]) with mapi id 15.20.4888.013; Sat, 15 Jan 2022
 19:04:13 +0000
From: "Lavrentiev, Anton (NIH/NLM/NCBI) [C]" <lavr@ncbi.nlm.nih.gov>
To: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
CC: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: RE: [EXTERNAL] Re: [PATCH 2/7] Use matching format for NTSTATUS
Thread-Topic: [EXTERNAL] Re: [PATCH 2/7] Use matching format for NTSTATUS
Thread-Index: AQHYCZOb/EPD6x6DwEC5G9thox2mbaxjgEMAgADwpwA=
Date: Sat, 15 Jan 2022 19:04:13 +0000
Message-ID: <DM8PR09MB7095F22ADD4B2CE55608084EA5559@DM8PR09MB7095.namprd09.prod.outlook.com>
References: <20220114221018.43941-1-lavr@ncbi.nlm.nih.gov>
 <20220114221018.43941-3-lavr@ncbi.nlm.nih.gov>
 <e79bbaae-e146-e4ad-b16b-0563c7768c33@SystematicSw.ab.ca>
In-Reply-To: <e79bbaae-e146-e4ad-b16b-0563c7768c33@SystematicSw.ab.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56399f1b-c8c9-45a5-f811-08d9d859d221
x-ms-traffictypediagnostic: DM8PR09MB7285:EE_
x-microsoft-antispam-prvs: <DM8PR09MB72855244EF63DEF328961CB7A5559@DM8PR09MB7285.namprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BsUL+Z+9pr9AFxeJfzTkHoRp631lW57D09Q2FRkNquMhNm5XaQWlsxGTFbyUV60vni9apqlUymhtrKXZ9N9N2S15YcmtkgW+ssCTpbRoq8klFrViCcQ7O8o7uE5mBYe05tVDFkXJ6MfsnImCS86Xz8ILTP4lcOV0RCIsIUkGjp/XKewRfuHSKyxKhiWHE0qi7zTWYVcgPfMnkq7f0JZfdi94Z5AO2HcPWtlmSC34J8IW/aZAD0qJ0MsuFQr2I06L4SiqqoSTXzqjZX5uieR/vyX9V6t6YLiYj1b8OJ7oAHI8U5TPh3KKZIn50Gs7HnQVufxvtSdtH5zSwa2bCIZWGCF00B3FF3MrRle5DP3KadygSYt6wesVCiY/yL9O092TEWUN+wbcoFyp180ozeeZFc1iL8JEME6Y8SZNqIaUY6gKKYYc+P8lV0UmYqwJCMIoLzfBc2u3RDmW4DK520SDj8sWv6gJRrXKH99ye0Gbml0E/QF1beTsgXtygrX8Qchq4nNSGSrHoflU7uh7er4gYXg3npv5PqFRM1p2XmV2zZLdl3ydvK2pps8j1RkrNJF9+hq9bAPri1oCSfClUrWKBtNLGlIsZDMf/okZcEN9RxCn/K9e5od0Dr0MYb6zMMVcZHiL8dTzvYAf60eXk+Mx4s7Ou6m6f3Ic6Pi1z6vcb/XG+S4/pJ9foTeEZZBAp0dvpHjeNPisx+2DdOSVC9vZkQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR09MB7095.namprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(122000001)(38100700002)(86362001)(508600001)(8936002)(186003)(6916009)(7696005)(53546011)(26005)(52536014)(316002)(76116006)(33656002)(9686003)(38070700005)(4326008)(6506007)(55016003)(5660300002)(8676002)(66476007)(66556008)(64756008)(66446008)(66946007)(71200400001)(83380400001)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UG5sYzZzMXczVTNUNDdNNGRqNXV2TjA1b2hlVHVmWEU1c0VWcmp0MTBmWjEr?=
 =?utf-8?B?SGlKcG1XcFc0NFB0YkxjdVVJL01KZUMxOFJKVjdRQ2xpazJxTWVXMEhMQjl3?=
 =?utf-8?B?SldLeVR2TlFQb1NRWUNPVTltUllKTkRDd2p2L3g1N0xOaEpFZ1hjbkxKaENi?=
 =?utf-8?B?K2MzeklrT1VMYjZzMk1HT2NtaElNMlFmbncrVUxIQkVGZEdLN2pOdGMreTAv?=
 =?utf-8?B?TytMaWI1M3M3R0dnNE9yUFlrRGdVd0Nib1VaS3FSRVRmbFdxcjUyS3ZhUG53?=
 =?utf-8?B?T0hrWkJINlprdXBkbkRYN1hzd0FOdXMzb3hCeW1idFJtU0hzM0JVdStOVjRO?=
 =?utf-8?B?S2hDNGJpbldMTjZvZHhuZ2J2ZHE4VlErWk5EOVFEcU1uTGlwM1ZCZElGN0pU?=
 =?utf-8?B?VTBMcWhxVFp5TkNqdXJrZlQ5Wll2Zjk0ZjVsSktKTWc4ZXRuZkxNMDN4bXdx?=
 =?utf-8?B?NUZ2Z09aSHYvSTRFaVpSdWRMbzlQcVdsTDQ0N3VWTjl4TUV2ekZrWjc4bGdK?=
 =?utf-8?B?ekJLR1I3endMRUlvLzN6QVdKR1M2bGlCR01zVlc1aENsd0RMaEhQVWlQSkZZ?=
 =?utf-8?B?Q0NWdU5jKzhPSzVzK1A4R1Y4UThmcFd5QURtKy9JRWIycFNpUFRMVEtXTFF0?=
 =?utf-8?B?Rk1KbmhvZ0UwdlZkMklEMXJlOWFwUnNhakhGYy9Ga3pvQ0d1RnAxSUdNSjd0?=
 =?utf-8?B?MlQrM1ZSRnh5WGduODdIQ0hhalVNeWdmSVpJbWlxOHpxaFJESGRCOVltd3Ay?=
 =?utf-8?B?S0ZFcXByL3E5eFkrWW10MjRoKy8zK0gwVzlJQzRCZ1RlZ2VUU2RsU1QrSVZ6?=
 =?utf-8?B?S3ZHanp3ZEs3Rkp0Q1pkNlBSaTgrYlFzLzZmTFJtWVU5cmtsSDNwOUlqQ3Uw?=
 =?utf-8?B?T3FHRGoxOUFkU1p0ZDFvdzdnanl0SzRJbjV6d205Y0xENmlTT0ZpZDJYaGtL?=
 =?utf-8?B?RDlCR053VnFqQ01rVTFFdFhmUDNidW1GMkQ0TlRHbUo1YWpRa2Fqei9wVVl6?=
 =?utf-8?B?N1ZVOWZ1akdjUG8wTVpYSS9GWGc1VGJaTEVIM0NqTzhqMUo3NVZ3VkpiVVc5?=
 =?utf-8?B?Z2lwbXY1UWFGNlczK2hJeUl0enVaSVdzWWt1R254V0M2M3FSTjIrVkx2ZVha?=
 =?utf-8?B?SXNCd2FzRzkzQUVCeU8rL2UxWHRXc2o0NkhlME5NV1BSRDBtT3JTbVlncFE4?=
 =?utf-8?B?ZUFJU3BRMTVuckViZHM0MkxpU0cxdG80UkFWd3lhWW5lT3htQ1UwOTVFL2My?=
 =?utf-8?B?SkhzZ2wyUzArNGtoVlZXYUdrWFRHbEh1WVAzaFRpalQ0RjNRZjBRcUJCOGNq?=
 =?utf-8?B?TUo0cEovTTBqcVNFVGFEWjBZVzBrWHZpVCtJZTRhb1pSR3dOOUpwL0hoZ3Ro?=
 =?utf-8?B?YzA2clJOSWF0Qk82dzRrQndqYnZUTDY5ZERLa2RwME90QXliMHhSeVNWZlZV?=
 =?utf-8?B?SHdDSDkxenIyRC9MeGw0NHd0R3BtQXE0NjNybkxTT2FCNi96UUlYcUhzUDFB?=
 =?utf-8?B?Z3dwOWdZVHEvOVlEdXlyU0pzR3I1QUR0bWs0eGFGTTQvU0NUbzI4Y2NVdUhk?=
 =?utf-8?B?UDRrclNta0t0WVd0TFBaaXJYOXhpR1hVYUJWeXViQ0RONUp6OWVNUTFGVXNn?=
 =?utf-8?B?c1hKSURUMW04OUVKQnZCYkNGVWhTanZrOW9SR0ExRUhIL1pDQitqekdOYmpi?=
 =?utf-8?B?VGZWb1hUVUNrSDVlTGRUMW9PK0pSU0J6MktxdmlvWE9nUlVRNno0VnhGRlhL?=
 =?utf-8?Q?Md/XggwyTQRlsBDZ04=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR09MB7095.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56399f1b-c8c9-45a5-f811-08d9d859d221
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2022 19:04:13.8069 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 14b77578-9773-42d5-8507-251ca2dc2b06
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR09MB7285
X-OriginatorOrg: ncbi.nlm.nih.gov
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_EF, GIT_PATCH_0, SPF_PASS, TXREP,
 T_SPF_HELO_PERMERROR autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sat, 15 Jan 2022 19:04:26 -0000

U28/ICBXaXRoICVYIChjYXBpdGFsIFgpIHRoZSBhbHRlcm5hdGUgZm9ybSBoYXMgdGhlIHByZWZp
eCAwWCBjYXBpdGFsLCB0b287IGFuZCBpdCdzIHJlYWxseSBoYXJkIHRvIHJlYWQuDQoNCklESyB3
aGF0IGlzIGV4YWN0bHkgeW91ciBwb2ludCB0aGF0IHlvdSBhcmUgdHJ5aW5nIHRvIG1ha2UsIGlz
IG15IHBhdGNoIHNvbWVob3cgaW5jb3JyZWN0LCBvciB3aGF0Pw0KDQpBbnRvbiBMYXZyZW50aWV2
DQpDb250cmFjdG9yIE5JSC9OTE0vTkNCSQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IEJyaWFuIEluZ2xpcyA8QnJpYW4uSW5nbGlzQFN5c3RlbWF0aWNTdy5hYi5jYT4N
Cj4gU2VudDogRnJpZGF5LCBKYW51YXJ5IDE0LCAyMDIyIDExOjM4IFBNDQo+IFRvOiBjeWd3aW4t
cGF0Y2hlc0BjeWd3aW4uY29tDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCAyLzdd
IFVzZSBtYXRjaGluZyBmb3JtYXQgZm9yIE5UU1RBVFVTDQo+IA0KPiBDQVVUSU9OOiBUaGlzIGVt
YWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6YXRpb24uIERvIG5vdCBj
bGljayBsaW5rcyBvcg0KPiBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXplIHRo
ZSBzZW5kZXIgYW5kIGFyZSBjb25maWRlbnQgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4gDQo+IA0K
PiBTZWUgZnByaW50ZigzcCkgUE9TSVg6DQo+ICMgICBTcGVjaWZpZXMgdGhhdCB0aGUgdmFsdWUg
aXMgdG8gYmUgY29udmVydGVkIHRvIGFuIGFsdGVybmF0aXZlIGZvcm0uDQo+IC4uLg0KPiAgICAg
IEZvciB4IG9yIFggIGNvbnZlcnNpb24gIHNwZWNpZmllcnMsIGEgbm9uLXplcm8gcmVzdWx0IHNo
YWxsIGhhdmUgMHgNCj4gKG9yIDBYKSBwcmVmaXhlZCB0byBpdC4NCj4gDQo+IE9uIDIwMjItMDEt
MTQgMTU6MTAsIEFudG9uIExhdnJlbnRpZXYgdmlhIEN5Z3dpbi1wYXRjaGVzIHdyb3RlOg0KPiA+
IC0tLQ0KPiA+ICAgd2luc3VwL2N5Z3dpbi9saWJjL21pbmlyZXMtb3MtaWYuYyB8IDQgKystLQ0K
PiA+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL2xpYmMvbWluaXJlcy1vcy1pZi5jIGIv
d2luc3VwL2N5Z3dpbi9saWJjL21pbmlyZXMtb3MtaWYuYw0KPiA+IGluZGV4IDY2NmEwMDhkZS4u
NmUxN2RlMGI4IDEwMDY0NA0KPiA+IC0tLSBhL3dpbnN1cC9jeWd3aW4vbGliYy9taW5pcmVzLW9z
LWlmLmMNCj4gPiArKysgYi93aW5zdXAvY3lnd2luL2xpYmMvbWluaXJlcy1vcy1pZi5jDQo+ID4g
QEAgLTM1OSw3ICszNTksNyBAQCBzdGF0aWMgdm9pZCBnZXRfcmVnaXN0cnlfZG5zKHJlc19zdGF0
ZSBzdGF0cCkNCj4gPiAgICAgc3RhdHVzID0gUnRsQ2hlY2tSZWdpc3RyeUtleSAoUlRMX1JFR0lT
VFJZX1NFUlZJQ0VTLCBrZXlOYW1lKTsNCj4gPiAgICAgaWYgKCFOVF9TVUNDRVNTIChzdGF0dXMp
KQ0KPiA+ICAgICAgIHsNCj4gPiAtICAgICAgRFBSSU5URiAoc3RhdHAtPm9wdGlvbnMgJiBSRVNf
REVCVUcsICJSdGxDaGVja1JlZ2lzdHJ5S2V5OiBzdGF0dXMgJXBcbiIsDQo+ID4gKyAgICAgIERQ
UklOVEYgKHN0YXRwLT5vcHRpb25zICYgUkVTX0RFQlVHLCAiUnRsQ2hlY2tSZWdpc3RyeUtleTog
c3RhdHVzIDB4JTA4WFxuIiwNCj4gICAgICAgICAgIERQUklOVEYgKHN0YXRwLT5vcHRpb25zICYg
UkVTX0RFQlVHLCAiUnRsQ2hlY2tSZWdpc3RyeUtleToNCj4gc3RhdHVzICUjMDh4XG4iLA0KPiA+
ICAgICAgICAgICAgICBzdGF0dXMpOw0KPiA+ICAgICAgICAgcmV0dXJuOw0KPiA+ICAgICAgIH0N
Cj4gPiBAQCAtMzgxLDcgKzM4MSw3IEBAIHN0YXRpYyB2b2lkIGdldF9yZWdpc3RyeV9kbnMocmVz
X3N0YXRlIHN0YXRwKQ0KPiA+ICAgICBpZiAoIU5UX1NVQ0NFU1MgKHN0YXR1cykpDQo+ID4gICAg
ICAgew0KPiA+ICAgICAgICAgRFBSSU5URiAoc3RhdHAtPm9wdGlvbnMgJiBSRVNfREVCVUcsDQo+
ID4gLSAgICAgICAgICAgICJSdGxRdWVyeVJlZ2lzdHJ5VmFsdWVzOiBzdGF0dXMgJXBcbiIsIHN0
YXR1cyk7DQo+ID4gKyAgICAgICAgICAgICJSdGxRdWVyeVJlZ2lzdHJ5VmFsdWVzOiBzdGF0dXMg
MHglMDh4XG4iLCBzdGF0dXMpOw0KPiAgICAgICAgICAgICAgICAiUnRsUXVlcnlSZWdpc3RyeVZh
bHVlczogc3RhdHVzICUjMDh4XG4iLCBzdGF0dXMpOw0KPiA+ICAgICAgICAgcmV0dXJuOw0KPiA+
ICAgICAgIH0NCj4gDQo+IC0tDQo+IFRha2UgY2FyZS4gVGhhbmtzLCBCcmlhbiBJbmdsaXMsIENh
bGdhcnksIEFsYmVydGEsIENhbmFkYQ0KPiANCj4gVGhpcyBlbWFpbCBtYXkgYmUgZGlzdHVyYmlu
ZyB0byBzb21lIHJlYWRlcnMgYXMgaXQgY29udGFpbnMNCj4gdG9vIG11Y2ggdGVjaG5pY2FsIGRl
dGFpbC4gUmVhZGVyIGRpc2NyZXRpb24gaXMgYWR2aXNlZC4NCj4gW0RhdGEgaW4gYmluYXJ5IHVu
aXRzIGFuZCBwcmVmaXhlcywgcGh5c2ljYWwgcXVhbnRpdGllcyBpbiBTSS5dDQo=
