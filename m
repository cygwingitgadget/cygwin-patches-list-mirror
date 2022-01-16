Return-Path: <lavr@ncbi.nlm.nih.gov>
Received: from nihcesxwayst06.hub.nih.gov (nihcesxwayst06.hub.nih.gov
 [165.112.13.54])
 by sourceware.org (Postfix) with ESMTPS id 0C9DA3858D3C
 for <cygwin-patches@cygwin.com>; Sun, 16 Jan 2022 00:20:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 0C9DA3858D3C
X-SBRS-Extended: Low
X-IronPortListener: ces-out
X-IronPort-AV: E=Sophos;i="5.88,292,1635220800"; d="scan'208";a="228944468"
Received: from unknown (HELO mail.nih.gov) ([165.112.194.61])
 by nihcesxwayst06.hub.nih.gov with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2022 19:20:05 -0500
Received: from nihexs1.nih.gov (165.112.194.61) by nihexs1.nih.gov
 (165.112.194.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.18; Sat, 15 Jan
 2022 19:20:05 -0500
Received: from GCC02-DM3-obe.outbound.protection.outlook.com (165.112.194.6)
 by nihexs1.nih.gov (165.112.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.18 via Frontend Transport; Sat, 15 Jan 2022 19:20:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wr3cT3XaC7/FGNQ0m8ceWk3AyOjqWmw+IaNTARsantq8RYLdINfv02JSMhDp9LhAioY5H1H5yxJPIOPDmoEi+YnKWRZ1eW6PRuNBnJFQN04OSZgDqU0Lmaqp86JC0H0P9mBD229CBTWBhcYc+18hIxhj2QAU6iahDbckr4k2Hh5Zxl+EHqsiT+Twd/PQHJMhrMzIA4G/YjP22HdH9wnP0Sl/Zp3bozCdKPvBsNLgKQWx4g3oflT4788ziqtWVcuAclvqQg2S4HdQmqPrlPgTljpOS8r5EaB++K53JxyY7d9S0v9aYtlkIEYwN8/ZMCj9zu6Gcq3etXikEfpS71yX6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Rdfy8mYUT3gM8er4guae7rTr4tnU8xJwRuexpcQL20=;
 b=SR1P8PV0y1z0agfQ2jE6hI5+sNP4AuIl8hEAUdnJSSPuL5q2Ys6aS6EYqdpupfIJB8gseLUk8di7qCscimEKVImkMSJxJEQCVXAB71mWbopWvNP+V42zv8kW3c+kZv9Zrf9fQqEgWp7/U8t58Rnrf/b6bbpJB2aTMF08/MGv8kR/TyKmJf90ds8HNQgq45c1x2poewwMJu9UF//SkWPGHfGp3MvHWC9oKgW8/u9CcuWkijjcnqgAaW9Umo8HwHSQtp25bpmGO2MJCRuOH9wgmD4gj+/H2RcW5jbXORBMk6o952eRW6Mrh0A62ecDHsauwJPZYzJLveCfBB52ib4yAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ncbi.nlm.nih.gov; dmarc=pass action=none
 header.from=ncbi.nlm.nih.gov; dkim=pass header.d=ncbi.nlm.nih.gov; arc=none
Received: from DM8PR09MB7095.namprd09.prod.outlook.com (2603:10b6:5:2e3::14)
 by DM8PR09MB6360.namprd09.prod.outlook.com (2603:10b6:5:2ee::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Sun, 16 Jan
 2022 00:20:03 +0000
Received: from DM8PR09MB7095.namprd09.prod.outlook.com
 ([fe80::d82c:2f49:8b4a:6d41]) by DM8PR09MB7095.namprd09.prod.outlook.com
 ([fe80::d82c:2f49:8b4a:6d41%4]) with mapi id 15.20.4888.013; Sun, 16 Jan 2022
 00:20:03 +0000
From: "Lavrentiev, Anton (NIH/NLM/NCBI) [C]" <lavr@ncbi.nlm.nih.gov>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: RE: [EXTERNAL] Re: [PATCH 2/7] Use matching format for NTSTATUS
Thread-Topic: [EXTERNAL] Re: [PATCH 2/7] Use matching format for NTSTATUS
Thread-Index: AQHYCZOb/EPD6x6DwEC5G9thox2mbaxjgEMAgADwpwCAAD0jgIAAGhTg
Date: Sun, 16 Jan 2022 00:20:03 +0000
Message-ID: <DM8PR09MB709574F631E56D5A9C02DA2EA5569@DM8PR09MB7095.namprd09.prod.outlook.com>
References: <20220114221018.43941-1-lavr@ncbi.nlm.nih.gov>
 <20220114221018.43941-3-lavr@ncbi.nlm.nih.gov>
 <e79bbaae-e146-e4ad-b16b-0563c7768c33@SystematicSw.ab.ca>
 <DM8PR09MB7095F22ADD4B2CE55608084EA5559@DM8PR09MB7095.namprd09.prod.outlook.com>
 <5331131e-7f49-1fef-4279-54b231df5022@SystematicSw.ab.ca>
In-Reply-To: <5331131e-7f49-1fef-4279-54b231df5022@SystematicSw.ab.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 341d3f94-7408-4076-1e86-08d9d885f0d9
x-ms-traffictypediagnostic: DM8PR09MB6360:EE_
x-microsoft-antispam-prvs: <DM8PR09MB6360C799652501A372CD0B3EA5569@DM8PR09MB6360.namprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WDaFQJHQiZG4AkIjRTt1WogFyz55TmFnWv0uOePmA6jETCvFOODknNtkoDv+JHDTt2PEZi6Tb9PMgKZBDMybFfllTk+BbJH4Qb2wpG0tjYfVaFBefPfJYuHmTbBuBaGA/Nmekhh8ayNSpBawZeECVVaKVhDrFIimhz1dPrKm+IJY8rhDzl0NT/6kUSRE+PU/8Z4mLW5iCiuqcjSIWHzn1Z5mHT8AUkMmFLbgcIIDFZ9EfS85BhiYU/SXORnK3V/fy+cEXCxsMig8AOXOCeJkZHO8Uoi4xCackEJJhlUhOA0vPoO5z/YW39HU4uV48tEaht7bM6egQuMEjxcwwJ8muVBcJoG6E5PTTeX7P8tP0i3pdDM+LK2wui4xmSltTAjUiOyLsoXwMeiQN0mA0Nt/DInv2MvDkr8WDlzyKlkuhS3ur5Fu9pIWyCiqiPErj55VXdQXQr9sDV5AWekCrPm5RVvKIk4Ym/7KzGf7p0uSfKk9ZOVlGcVrE5dG0pk983AdszXjEs2gc4a460fDToSxpBHn+hGotVmmhLjuIvPY0NgFzYdInGBR8EiHQKmGjuht2vgXGDr5u8K7n5jVaJn9n4ahyD8HYTvLjHSBJn597SCGLXdjIZO3H2RBuSFOwTDGCKrHLe0A1ykpkkIGYUFUvtvaDkNtOn0uXPGx0SgA2uWOlFhMxQQY5yV3aEBOLiy/8/41nMUhq6JFFxaEJfkANg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR09MB7095.namprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(52536014)(66946007)(2906002)(26005)(5660300002)(64756008)(66476007)(316002)(8676002)(508600001)(66446008)(76116006)(8936002)(71200400001)(66556008)(9686003)(38070700005)(6506007)(55016003)(122000001)(186003)(7696005)(38100700002)(6916009)(86362001)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlFMTkZsUjJmRkpKNjlwbnZXMC9qZXlUWXFKSVNRTmFSMG12K2F6VDd4UWZ6?=
 =?utf-8?B?UXVVSWVyV3ZrZXFpQVFXS2xXY3BjRWlpUGdXeWFnTzMxV2wxZlVWSEFreWxB?=
 =?utf-8?B?UTV5NXZYcDlpNnRkeVNJNWgxZEhHVVdNWU5YOW9wdW5PYmRSNzFYRWdRUmpl?=
 =?utf-8?B?clVSWis4UzZ2bFV2RTljd29wQWZ1T0xXRWhLdUhRMWc4VjdYdHVDTyt1MnAr?=
 =?utf-8?B?M3c0NzN3ek1LTWtUNWNpbXEzbjJraHB3Qm0vZzUvdnBsTnlkOFNDVk41aFNH?=
 =?utf-8?B?cHpObnVob2pWcUVaUUo2Z0Y0NEhPYWQwT1hscDgzT3lqdGFhNDE1N2Y2cFZN?=
 =?utf-8?B?VHh4Q1R2MDVtNEhZdXcyNnF3TDZlT29STyt2VkQycG9kQ2FNTVgvbFloQ2Rt?=
 =?utf-8?B?TnFRb3ArTGNpZmJjTVIrdlZHMVV1aHhPMDJXM0dpcEJhQ1I4YTdDTCtjTFZw?=
 =?utf-8?B?WXkxNkR6SzdwVU12YnNXVjZXNmZPUXlGVjJxTGFpTWlFNlhtek92eENLV1BF?=
 =?utf-8?B?dVRTTCtYZzcvaE5vNytsKzRBOHZkT05nWkRVT0d4S0tqWlFmQXEybXNOSjBS?=
 =?utf-8?B?cXIzanZhdnVubHBoejA1ZDkxeExoSHc4VC8wNGRYbC9PczZjaE9QYnAwb0dv?=
 =?utf-8?B?T3gvRW1JQS83YTVaajkwSmIwaFFncnhFdmp5dGo2ZWpId0FxV1RrS0VHbmVV?=
 =?utf-8?B?UWlTZXUwVlZNcGlRSUtUblo2ZlAwRFV0blZ3SHJhbnFlOEpHWnJOcFBhQWtD?=
 =?utf-8?B?bzRyaFdVV1dhV1hQTlY2M2Y1dHRCNlhIYUluNTFJYzFva2RuRHBNWFo5QmRQ?=
 =?utf-8?B?Y2hZM00yRDJnSXdMLzV1VzFSdXgyU3lJaFVpTDlMdjFuVlpsV2lTZ3ZGbjdq?=
 =?utf-8?B?aHhLT281WHh4MThEdzBsMWxJd1NiYmt0cEZnQVVpWWlVS1UxcFBpNjBIakxS?=
 =?utf-8?B?YUpvVGx3VFVLSzFHWmNqVXRvUnI4c1JxZEtCdm5YbWRmZVlKaFV0V3kwQmsx?=
 =?utf-8?B?QjJjNTNPWGhsaXNGQlB5TTVUdUg2WHhuSWp3OGIvdHptRVhTVUpQVGlKd2FO?=
 =?utf-8?B?UzA2K2svMk5tZnNQWWtRN2JkVDBTaGliU28vaTlXQTVwY0U5WHpiSU9URVhM?=
 =?utf-8?B?d1I2VHVacytYZlB0RHJ3bkEyNmFuRitXWERMc1NENUJRSkM0WUFUeG5VLzZY?=
 =?utf-8?B?eXIzWGxnOU9tZzA4WmdBM29yYnl1UXh5cWh5ZDZVNDl4SDNobjdpNm5zblR6?=
 =?utf-8?B?eE5VcXBJSTBYV05RWDZsWFJyVDVvMi85QllsWXZ6MFB5enpGSVkyUjlpWXBu?=
 =?utf-8?B?YXAwVlZ1TGVHUDUweE1rb3lpSlduZU1pM09DWVg1Sm1SSU5WbGUvclhqMlZn?=
 =?utf-8?B?UnpRb1V1bVBXQkhqTzVPeUJ4djhrNnByWit5cWFGVmFiQ1pWWCs4L0U0OFd2?=
 =?utf-8?B?SXpyRUN5ci8xaUMxMmN0NEI4MDNneHkyYlRTby9LUEhPREdlUzZmcTI5NE52?=
 =?utf-8?B?bkR6ZEdPVEJ4SUlnK1BTT2h0bDRSTTBxNEpubnJhc0t0bm5RRUNPeFBoSTVV?=
 =?utf-8?B?NmFsdUpYZHNPYnFpdDZVSTdkODZzRHM1TUswVngzcjkrencyRkdRMG9MODlq?=
 =?utf-8?B?RjNyTmlvazBCN2dUTVE1NmUwMzlPM3V4ek1UV0FmamU5RStJaGNtRjlnQlkr?=
 =?utf-8?B?TlQvZUo3TE5DUjJrS0g4bWxkN0JieDR1UHNVM0VtNGZ6MXNhQklqa0kzTWVD?=
 =?utf-8?Q?qd9aFbPgJo5NRtAl44=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR09MB7095.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 341d3f94-7408-4076-1e86-08d9d885f0d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2022 00:20:03.1591 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 14b77578-9773-42d5-8507-251ca2dc2b06
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR09MB6360
X-OriginatorOrg: ncbi.nlm.nih.gov
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_EF, SPF_PASS, TXREP,
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
X-List-Received-Date: Sun, 16 Jan 2022 00:20:07 -0000

PiBKdXN0IHRoZSBzdWdnZXN0aW9uIHRoYXQgYXMgYWxsIHN0YW5kYXJkcyBzdXBwb3J0IHVzaW5n
ICUjMDh4IHRvIHByZWZpeA0KPiB3aXRoIDB4IChwcmVmaXggb3V0cHV0IGNhcGl0YWxpemF0aW9u
IGZvbGxvd3MgZm9ybWF0IGxldHRlcg0KPiBjYXBpdGFsaXphdGlvbikgYW5kIHdvdWxkIGJlIHBy
ZWZlcmFibGUgdG8gaGFja2luZyB0aGUgdGV4dCAweCBvbnRvIHRoZQ0KPiBmb3JtYXQgJTA4WCwg
ZG9pbmcgYWxsIG9mIHRoZSBmb3JtYXR0aW5nIHdvcmsgd2l0aCB0aGUgZm9ybWF0IGZsYWdzLg0K
DQpGaXJzdCBvZmYsIEkgYW0gcGVyZmVjdGx5IGF3YXJlIG9mIHRoZSAiYWx0ZXJuYXRlIiBmb3Jt
LCBhbmQgSSBkb24ndCBsaWtlIGl0DQpiZWNhdXNlIGl0IGVpdGhlciBjcmVhdGVzIGFsbC1jYXBz
IHJlcHJlc2VudGF0aW9uICh3aGljaCBJIGZpbmQgaGFyZCB0byByZWFkLA0KYW5kIEkgbWVudGlv
bmVkIHRoYXQpLCBvciBpdCBjcmVhdGVzIGEgImNhbWVsLWNhc2UiIHJlcHJlc2VudGF0aW9uIChh
bGwgIm5vcm1hbCINCmRpZ2l0cyBhcmUgImNhcGl0YWwiIGxldHRlcnMsIHdoaWxlIGEtZiBhcmUg
bm90LCBhbmQgSSBkbyBub3QgbGlrZSB0aGF0LA0KZWl0aGVyKS4NCg0KPiBNeSBhd2FyZW5lc3Mg
YW5kIGF0dGl0dWRlIHRvIG1vZGlmeWluZyBvdXRwdXQgcHJlc2VudGF0aW9uIHVzaW5nIG9ubHkN
Cj4gZm9ybWF0cyB3YXMgaGFyZGVuZWQgYnkgdGhvc2Ugbm90IHVzaW5nIGRhdGUgZm9ybWF0cyB0
byBtb2RpZnkgZGF0ZQ0KPiBwcmVzZW50YXRpb24gZHVyaW5nIHByb2plY3RzIHByaW9yIHRvIFky
SyENCg0KSXQgbWF5IGJlIHNvIGJ1dCBpdCBoYXMgbm90aGluZyB0byBkbyB3aXRoIHRoZSBvdXRw
dXQgb2YgTlQgc3RhdHVzIGhlcmUuDQoNCkFsc28sIGEgbGl0dGxlIHRvbGVyYW5jZSBvZiBob3cg
c29tZXRoaW5nIGNhbiBiZSBkb25lIG5vdCBleGFjdGx5IHRoZSB3YXkNCnlvdSB3b3VsZCBkbyBp
dCwgZ29lcyBhIGxvbmcgd2F5Lg0KDQpUaGFuayB5b3UgZm9yIG5vdCB0cm9sbGluZywNCg0KQW50
b24gTGF2cmVudGlldg0KQ29udHJhY3RvciBOSUgvTkxNL05DQkkNCg0K
