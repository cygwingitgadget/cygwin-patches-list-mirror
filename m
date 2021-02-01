Return-Path: <lavr@ncbi.nlm.nih.gov>
Received: from nihcesxway3.hub.nih.gov (nihcesxway3.hub.nih.gov
 [128.231.90.125])
 by sourceware.org (Postfix) with ESMTPS id DA5B9384241F;
 Mon,  1 Feb 2021 14:23:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org DA5B9384241F
IronPort-SDR: fMvlY5/6BrY0vKZk9DSGl4SgwJ+FYFPodPsSFw/UerqXj5BWtEXONX8hLTyiGGXUkQq0+P73N/
 GenG3EggxMYQ==
X-SBRS-Extended: Low
X-IronPortListener: ces-out
X-IronPort-AV: E=Sophos;i="5.79,392,1602561600"; d="scan'208";a="273200231"
Received: from nihexs3.nih.gov (HELO mail.nih.gov) ([165.112.194.63])
 by nihcesxway3.hub.nih.gov with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Feb 2021 09:23:36 -0500
Received: from nihexs3.nih.gov (165.112.194.63) by nihexs3.nih.gov
 (165.112.194.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2106.2; Mon, 1 Feb 2021
 09:23:32 -0500
Received: from GCC02-BL0-obe.outbound.protection.outlook.com (165.112.194.6)
 by nihexs3.nih.gov (165.112.194.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2106.2
 via Frontend Transport; Mon, 1 Feb 2021 09:23:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgN3gxaMKTpcwqeTYsHiitYMxZrAfH6rxJYdktJ6z0pYDpb/zL1CCAWCW2Hq94eiOliUfvnq8gqqJD/5+4YQ6lwHxEgvlU3rUkPjTpWRIZa8Yq9+MKaWk5PWO7gNMjD9cPDhrWE1kvyvPMZslaOnHXKL6CXlE5d8LY3+qpo7dMcCVzcoX5bKuumjIBwZQq8OzpnSFaveSq6NekybUUOs24cM0QyApf5QxEp76iQroyDGEGcxQPoXv/3bRKAUOzXLOSzf4LR6KyE9eZh5qu9lqGf3ZRLi9WEoHHJQfND5P9k7b42GzWLgoznj1LOkrpydUxjNxI22nzhnlMY0XXGw7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpA1I8Q/em1SrczHG48QSgb06jVdEWYuawvqMyy8zec=;
 b=WtvBbDrzKrnifRmtZYDUFipr1naajSWxU5450iZJl1OWOqqiMkg7QfOy+DDI7EpeFQMlb/tLdlglTwYjCowHvv7cO0EKy/+UkpNLYdV2JRldTjUndhwwHHHqPyDDxoBc/gGyyHgMznRScJPsRkOr8xg7/Navr3uWkW5xzfZJHy+ARI1vn6Hs0l5BJYMQu1oc21J64gicc8tVgSFxZCRRCM7YRDImsjMc3bsNX5wq08OXG72OFwiMIIIWtDm8FoWxg4APz622/Z7jrJKPN1mCTh1DjSETYE/AW/kuAKxJ0yP8rHFu9JIH+MCLI6mcP/c0D/nOjPxyfnMITTLvGFBwPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ncbi.nlm.nih.gov; dmarc=pass action=none
 header.from=ncbi.nlm.nih.gov; dkim=pass header.d=ncbi.nlm.nih.gov; arc=none
Received: from DM8PR09MB7095.namprd09.prod.outlook.com (2603:10b6:5:2e3::14)
 by DM8PR09MB7032.namprd09.prod.outlook.com (2603:10b6:5:2f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Mon, 1 Feb
 2021 14:23:31 +0000
Received: from DM8PR09MB7095.namprd09.prod.outlook.com
 ([fe80::9487:e478:f84:99c3]) by DM8PR09MB7095.namprd09.prod.outlook.com
 ([fe80::9487:e478:f84:99c3%6]) with mapi id 15.20.3805.027; Mon, 1 Feb 2021
 14:23:31 +0000
From: "Lavrentiev, Anton (NIH/NLM/NCBI) [C]" <lavr@ncbi.nlm.nih.gov>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: Corinna Vinschen <corinna-cygwin@cygwin.com>, Pierre Humblet
 <phumblet@phumblet.no-ip.org>
Subject: RE: [PATCH] CYGWIN:  Fix resolver debugging output
Thread-Topic: [PATCH] CYGWIN:  Fix resolver debugging output
Thread-Index: AQHW9nUig9vBaGYORkSRoQCTG8kIIKpDHsyAgAA7BNA=
Date: Mon, 1 Feb 2021 14:23:31 +0000
Message-ID: <DM8PR09MB7095CE3228ED706E16BA0F16A5B69@DM8PR09MB7095.namprd09.prod.outlook.com>
References: <20210129192903.939-1-lavr@ncbi.nlm.nih.gov>
 <20210201103445.GK375565@calimero.vinschen.de>
In-Reply-To: <20210201103445.GK375565@calimero.vinschen.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [130.14.9.135]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e456b3fb-7a5a-444e-38e6-08d8c6bcf3c6
x-ms-traffictypediagnostic: DM8PR09MB7032:
x-microsoft-antispam-prvs: <DM8PR09MB7032CFA576ADA41B9A8E1E60A5B69@DM8PR09MB7032.namprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NgZ76rwqTZY2U+24w3iKgFdPTrAWFB9tzZaIMhx5Bhanc1yA8bLTMZDMyIiL/KOntOEhy7PT4za0Zn4PqKrHdIRttmtNP1QcWHMs5jJohMApeeGKKK50kREK/agUx/fsFhyKEbDXbtJ+GrbtQWo+ArBEt9TQm2L1ATW7dcdsI6wNh5UPj0qZuAwjDt8Vx8bqhuTnMey34KWXo1J7YuH56lesnaDld+iCzPKsZ7KVV5/k9IB0vquDVsFaswhzoj6rBvPKCYxN65Hn3oYoGlaln2JBbQI6Zk7LzjyM+PBO7N/HxbgSNGdN/WHuU6kMTqaTmsnmWThivdu9sl9lF4NX0VjFfuyBf5Z279ohr2gA0Ec0tFYpAEbx2E+CUxyWv9W285CHLkWF4xE/mO2YRxjEEeDjINOFxo7Lip5ClLoYg+MirH6vpPX0Rb8IlxcJ2qoMPSBuAREY0wIhpj9Uk66Iv5Go3icPBy63OyrhOabsQzso48UldFCOO53AM2cQatRh7GxuMtu9vDLCmQracaSZ3g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR09MB7095.namprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(4326008)(66446008)(76116006)(54906003)(83380400001)(7696005)(4744005)(8676002)(64756008)(6916009)(66556008)(66476007)(2906002)(66946007)(52536014)(478600001)(6506007)(55016002)(5660300002)(26005)(8936002)(9686003)(316002)(186003)(86362001)(71200400001)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?Qm1mMnhQZlFrT1VaZ21WZWx6VGlmVDBYdUVBRUxRVlZWaStnNzkxemhocFh0?=
 =?utf-8?B?cnZuL2RmbG9Pc1Qvd0FqK3VTN09TbmFXVUxKeEhyOWZERFpmYTdXSVlLK2FC?=
 =?utf-8?B?d1ZqNjl3SzVyaUp6a0pSMFVJWERLbzRRWkMyY0hheU9JTFFIMXhmOEZDR2Ft?=
 =?utf-8?B?WUdmSndxWWV5akNhcU1FZllDWnZtQ054ckhuY045NDFvQWxGTnZTT0lHWVF2?=
 =?utf-8?B?OEEzZUN2TURHMUprdGtjZDZWZzc0VGlESUp4UTZUOUVLL2xkS0hZUTEzUWxX?=
 =?utf-8?B?dEwwMW00Yit5U1hvSUhxakdqVHcwVlpNbi9PZ2YvWm51NGlCS1d4eVhrNk11?=
 =?utf-8?B?T2JlNG9NaENEZ2ZBS1RLVGpqd044cjBRNnRuQTg3VnhrUGY2ZDBheVdCMnpT?=
 =?utf-8?B?NEhZRGpCenBVZlAxaDFNNWkyU2svQkhsL1Z4aTVwQysyQ2UyOUtXUEJhL0xm?=
 =?utf-8?B?V3p4REJKWlNpL2JCK3doeG10c2VkMDJUT0diTFQyYldKcFdNMFVHK09sRkVr?=
 =?utf-8?B?ME1mMWNHMmtVZWo0UEZWVEdEWDhLUUFYRmJycW1Uc3BtWCtEZTlmMXozUi9x?=
 =?utf-8?B?akZoTHhFMEZ1dXY1TDYzdkRjSlNoeFcybXVLeXhlTkpMK2NYRDV2M1RuZFdP?=
 =?utf-8?B?NmRvbmpXeWJPeVJJclBZY1NKREVXdUFjQXJ1SWxaWmN2aGtQd2hBMi94UHhy?=
 =?utf-8?B?ZnBMU0dESW5mUTU0UytBNklWWXpVMHhkOWw3bE1zQ09KUkhQOEh1aUt5SE9O?=
 =?utf-8?B?SWdBWDNMdXEwZWZUdnpjNDl2R2ZINGo1TmZYZnJ1K1FTZ2dRVE04YTdBaUN2?=
 =?utf-8?B?U2VPYU9mT1dLMzdXRzJwZkh5UXpPMVFyYkwyQkJsU0xuZ3MvQ0JlOUkwRkgx?=
 =?utf-8?B?QkllRkNhMDhrazkyRnlSdFlGbG9tRHErUHROR2RCbWdDbnZVbzN6S1c1Z0t4?=
 =?utf-8?B?MTh6L3lsZWpwMzQ4ZjZSVUdJb0xNOWdYRDJBR2xXVHg0ZnJCZlB2WGRhOGFa?=
 =?utf-8?B?RjJrVGNxWWtBR0tqZ0ZMS1hwMlYxdHUxR0NqZnJlcW92SE1RU0twejZTL2F2?=
 =?utf-8?B?R01tZUM0QXFlMmlKcmFYTlpjd2RodnQ0ODNNNmM4Q2g2dzlFc1VKZjdLdU1a?=
 =?utf-8?B?akdqWUU2SEhZR1V2YVZod3hSOXVBQmRpSDdCR3FsaFIvUk9aaWtCalRuY2RC?=
 =?utf-8?B?NWx5Y05PR0lvaHR2RGxNdlFLSjVTWHptZnRUamZqU0YxUDF5aXphS2x4WVFm?=
 =?utf-8?B?R25BWHg5akF6QWI1bElnYlFjUE9PK0ZnMFk1OGhRZnp0UGhMV01DUzdTOVhN?=
 =?utf-8?B?Zjd1R0JRWk5tYTFiWFc3YXgreW9VNU82NWx0Sk9TOHdjaDl1SlVuc3kvSVJx?=
 =?utf-8?B?MFRRVXhvSmpyeFBxUkJEU3dDYTBVQk9RYnllVWdxSElXSGZGOFBzWlo1eDJF?=
 =?utf-8?Q?RDwHOZ1R?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR09MB7095.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e456b3fb-7a5a-444e-38e6-08d8c6bcf3c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2021 14:23:31.8034 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 14b77578-9773-42d5-8507-251ca2dc2b06
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uHDv38SKvaV0v2x/7hquJQanK1Ol+SxW9BVYj/Y2DT/cGgoZoa4Ak9sEYNxdEygw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR09MB7032
X-OriginatorOrg: ncbi.nlm.nih.gov
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_EF, SPF_HELO_PASS, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Mon, 01 Feb 2021 14:23:39 -0000

PiBQbGVhc2UgdXNlICVscywgJVMgaXMgbm9uLXN0YW5kYXJkLg0KDQpTdXJlLg0KDQo+IEZvciBp
bnN0YW5jZSwgd3JpdGVfcmVjb3JkIGFwcGVhcnMgdG8gaGFuZGxlIEROU19UWVBFX0EsDQo+IGJ1
dCBub3QgRE5TX1RZUEVfQUFBQS4NCg0KSSBjYW4gYWRkIHRoYXQsIGl0J3Mgbm90IGEgcHJvYmxl
bS4gIEJ1dCBpbmRlZWQsIHJlcGFyc2luZyBvZiBXaW5kb3dzIHBhY2tldHMsDQpkb2VzIG1pc3Mg
QUFBQSAoYXMgd2VsbCBhcyBzb21lIG90aGVyIHR5cGVzLCBzdWNoIGFzIFVSSSAtLSBub3Qgc3Vy
ZSBpZiBXaW5kb3dzDQpoYXMgaXQsIHRob3VnaCkuDQoNCj4gV291bGQgeW91IG1pbmQgdG8gc3Bs
aXQgdGhpcyBpbnRvIGEgcGF0Y2hzZXQgd2l0aCBwYXRjaGVzIGZvciBkaWZmZXJlbnQNCj4gdGFz
a3M/ICBBVE0gSSdtIGEgYml0IGNvbmNlcm5lZCBhYm91dCB0aGUgbnRvaHtzbH0gY2FsbHMsIGdp
dmVuIHRoZQ0KPiBub3RpY2FibGUgYWJzZW5jZSBvZiBJUHY2IHN1cHBvcnQuLi4NCg0KT2theS4g
IEJUVywgSSBhZGRlZCBudG9sL3Mgb25seSBmb3Igb3V0cHV0IG9mICpuYW1lc2VydmVyKidzIElQ
djQ6cG9ydCwgYmVjYXVzZQ0KbmFtZXNlcnZlcnMgYXJlIElQdjQgKGV2ZW4gaW4gZ2xpYmMsIEFG
QUlLKS4gIFRoZSBfcmVzIHN0cnVjdHVyZSAoc2FtZSBpbiBnbGliYykNCmhhcyB0aGVzZSBhZGRy
ZXNzZXMgYXMgInN0cnVjdCBpbl9hZGRyIiwgbWVhbmluZyB0aGV5IGFyZSBJUHY0LiAgQW5kIHNv
IHRoZXJlJ3MNCm5vIHJpc2sgb2YgcnVubmluZyBpbnRvIGFueSB0cm91YmxlcywgYnV0IHJlYWRp
bmcgdGhlIElQIGFkZHJlc3NlcyBpbiBkZWJ1ZyBvdXRwdXQNCmlzIG11Y2ggZWFzaWVyIGlmIHRo
ZXkgYXJlIGluIG5hdGl2ZSBvcmRlciAoYW5kIHNhbWUgZ29lcyBmb3IgcG9ydHMsIGV2ZW4gbW9y
ZSkuDQoNCg==
