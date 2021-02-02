Return-Path: <lavr@ncbi.nlm.nih.gov>
Received: from nihcesxwayst05.hub.nih.gov (nihcesxwayst05.hub.nih.gov
 [165.112.13.46])
 by sourceware.org (Postfix) with ESMTPS id A28493834423
 for <cygwin-patches@cygwin.com>; Tue,  2 Feb 2021 19:39:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A28493834423
IronPort-SDR: ROR+GLEmp9+A51bUqwqvXqiHOqx4I5WkZF65HVNN6o9IKzVzRda4uh35nJHC5Cg2wUIBKjC41z
 U9wSQMyyBD6w==
X-SBRS-Extended: Low
X-IronPortListener: ces-out
X-IronPort-AV: E=Sophos;i="5.79,396,1602561600"; d="scan'208";a="178365966"
Received: from nihexs4.nih.gov (HELO mail.nih.gov) ([165.112.194.64])
 by nihcesxwayst05.hub.nih.gov with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2021 14:39:00 -0500
Received: from nihexs1.nih.gov (165.112.194.61) by NIHEXS4.nih.gov
 (165.112.194.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2106.2; Tue, 2 Feb 2021
 14:39:00 -0500
Received: from GCC02-DM3-obe.outbound.protection.outlook.com (165.112.194.6)
 by nihexs1.nih.gov (165.112.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2106.2
 via Frontend Transport; Tue, 2 Feb 2021 14:39:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfX2IMRCgNYLMVPRXVYdd2ORLF0zhq+xNqaS3PYakf+B8MYzlwXFThLpegZKZJbnT4Gy7z4aJkH3kvg/3xix6YNCtu7SJxdN5h0wxu9VE5XapyWyA3pnrjhW1CIuEGQ7/L1Hmx2xNB4RGKGKvZ2cwlcafWnPUIBEgNRvyaL2BMsdHaa46BCsplb9cPdPPbN8tWbZH5VhbygnEioREAu2rdD9f7oJ9OYpy/TOKAh6dKTj1/FRrfgw5kNJUzuz9e5Ux3bHeFuJuEQtqYZlsb4P4S2ZP+gPxPgSWphVOOLWKAVetuSc8b1aPih9U+zLnaotZ4vmJpmLRL2fC1ePGFiFgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NHRd3z/IBZWpAHdPlD5+k0bg11WEgvje42X0A6Cr2M=;
 b=Gi1vVO6GiHms7QtOvfhlp1WGlUhoqL3r4bo/VVQkRdyWLNGXY1oi1JRwrlXIdxFzk/emma1P7h7X8lnjvNULaaVV4Anre8ZsehcHGJWwGHvvw7gwX8JPmV2If/cgFGN9m1ITWahR33JKsXg4Dkidkg3L6qI87nJNYBb0jITC43aW0jjZB5uARDjP1IHAXZfk3Q0h+s8zAlz2Zng9uQOY7fOa7fvq+0kLJZK5G6VaCBY/jpvKf52GLT/PrivfLuy5+XDz52GB7ydaZLRTJXwOwtlS+4Z/DDOKxbJEjXP6U9HlIAnWSdCs5nyOYRLExxqk2K7D+6ZKBB8tJf6xXdfLaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ncbi.nlm.nih.gov; dmarc=pass action=none
 header.from=ncbi.nlm.nih.gov; dkim=pass header.d=ncbi.nlm.nih.gov; arc=none
Received: from DM8PR09MB7095.namprd09.prod.outlook.com (2603:10b6:5:2e3::14)
 by DM8PR09MB6839.namprd09.prod.outlook.com (2603:10b6:5:2e1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.21; Tue, 2 Feb
 2021 19:38:59 +0000
Received: from DM8PR09MB7095.namprd09.prod.outlook.com
 ([fe80::9487:e478:f84:99c3]) by DM8PR09MB7095.namprd09.prod.outlook.com
 ([fe80::9487:e478:f84:99c3%6]) with mapi id 15.20.3805.027; Tue, 2 Feb 2021
 19:38:59 +0000
From: "Lavrentiev, Anton (NIH/NLM/NCBI) [C]" <lavr@ncbi.nlm.nih.gov>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: RE: [PATCH] CYGWIN: Fix resolver debugging output
Thread-Topic: [PATCH] CYGWIN: Fix resolver debugging output
Thread-Index: AQHW+Y26cRqnqpvnSU6DG8iUhfRkjapFP/wg
Date: Tue, 2 Feb 2021 19:38:58 +0000
Message-ID: <DM8PR09MB7095250510E486C082695609A5B59@DM8PR09MB7095.namprd09.prod.outlook.com>
References: <20210129192903.939-1-lavr@ncbi.nlm.nih.gov>
 <20210201103445.GK375565@calimero.vinschen.de>
 <DM8PR09MB7095CE3228ED706E16BA0F16A5B69@DM8PR09MB7095.namprd09.prod.outlook.com>
 <20210201150209.GP375565@calimero.vinschen.de>
 <DM8PR09MB70952B27AFDF02848ABB50C7A5B69@DM8PR09MB7095.namprd09.prod.outlook.com>
 <20210201190215.GA4251@calimero.vinschen.de>
 <9f964f14-4e8e-b36f-fa73-777c567f2f3b@SystematicSw.ab.ca>
In-Reply-To: <9f964f14-4e8e-b36f-fa73-777c567f2f3b@SystematicSw.ab.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [130.14.9.135]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6ac9759-f3ea-460b-d2ed-08d8c7b22fa0
x-ms-traffictypediagnostic: DM8PR09MB6839:
x-microsoft-antispam-prvs: <DM8PR09MB6839FBCFC8C5042A09400C6AA5B59@DM8PR09MB6839.namprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: si+7+EK0pxMGE+N7l+cMcseiZWVjkOUlx+v59eWPixj8NX1eVAxS7BXuHFTpuOhT+sYTgiECTvBAGHKew34dlWdLmN73tfm9n9JG39cERkUHRYEbEeQ6C4LZU+YGXji+b/QznvSdDPOZw2GWfqtrkKoV9L3pD0e6h99v85hATqdhtsNX8oJeu+claYPQi0mrkvWqmILrWVLyYXl1kOviiIsK0pYhN1ktmixD4EpQ4Sm1uDKG+FkbbaNnDbk9+umu5xR7WoCzQFBF1VPgMt4r4S+6N7v4vt32q5tark9SPEQiBIkad6eAdqp98bXaznOxmc0rytI8R/Nwtb0/xsTpz3O7Dby39DQxd7oBHy+Q7PZ8u+JVUYnUEyW6Yze0SIe1FVbsXv/wINqGcErvkAVzvuXZ8Ry2Tm7vrN5JM0ENe5lQj7stqixxzDujQ/NENd4VlCEn9CR4q1ozmu8HVtuA88TwZliy//BweE1x+qNf6aFtHz6+GYHD3QPLjgYZ14UFuy2MPF9O5Kl+x9kfjaOEHw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR09MB7095.namprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(83380400001)(478600001)(55016002)(8676002)(71200400001)(7696005)(9686003)(316002)(8936002)(4744005)(186003)(6506007)(5660300002)(66946007)(52536014)(6916009)(86362001)(66556008)(76116006)(33656002)(64756008)(26005)(66446008)(66476007)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?YVA5NFBRUUJYQTBiNWRMVWphN0s0OEw3Vy9RMnBGTC83dGdJbGZpSHNpVnps?=
 =?utf-8?B?c1VaWVRoWGtvQmlWY0NhZzNmOE1PRGhhM3N6dUUrMDdOTjJ0LzhLaEw0bWZ5?=
 =?utf-8?B?QUVPOWJNem9VZkN5blZtMXo5ZVhyVkRScVZVZWUvTFdBaHVZazA1bE1VZlFt?=
 =?utf-8?B?emd2dHZ1QUVDYTRRWmV2OXVXNDNSN3hnVVBxWGM0MWE4NC8vcW5OQjdVSlp3?=
 =?utf-8?B?bkRtZ0l5RXVSQXdOKzc1Vi9DU3h6bDFtUUNrdDRZKy9GL3pGZG9waThZa1Z5?=
 =?utf-8?B?MUdZSFZYSUdRZ1hIN1ZtbktxTGtYWDJBMExTR1l6R28xYUZjZVU2Zk5vUi92?=
 =?utf-8?B?b2RDVmZwa0gvc1NDUkJ5d2pkN0kvem1BRzQ4a25WYktjbDBQTlIzK1hTZEhP?=
 =?utf-8?B?a3hGYTBxcTkvV1k0V1F6eGh5SXNRMitJOWVSQnI0aE4wck0raWFxSVFSdHlT?=
 =?utf-8?B?Q2JiSXo5NnhGUUJobkI3QjZLZWtpd2lTajZud1dXc2ZLRDlBQVNHTG9XZnhv?=
 =?utf-8?B?Y24yTTFZYm9ESEZ5SEpZQXVFQm1GY241eEhXUVJlK1R3bkVuaVMxSG0rV3Rm?=
 =?utf-8?B?ZjZCanY0bXAveWIvTDVRaW1mQWtVeVlGR1FiOGw2K1lZNERKWE5IV2I2dXBl?=
 =?utf-8?B?dUJpa0ZTallLQ3VYdFpJUlNGQklpb0NiRG45K0tYM2dvaXRqRm40Mklzd3lQ?=
 =?utf-8?B?YTNxUjhrLzFXRm5MT3V1ak1vNWRiMDdwZitpeGhpSmNxOEhTa0grckc1Q1l4?=
 =?utf-8?B?d050S0lpNnBPMkp1bk81bmc0L3pBRFlIR1huNXNZbmt1cU5RZGNLMmd0b1RD?=
 =?utf-8?B?WVJtT2RDd1pPajhIbm9OVjJiSWtQc3ZwMjFGM0xuaEdmaXNkVFNwUlVOTzJm?=
 =?utf-8?B?d0FPd3ByS3d5ODJYN0F5R0c3dUNaa3hYbkhpVDN3WkZZTnpqY0dWQlVyandz?=
 =?utf-8?B?bFNxWFNSY25WMDFnNFhlM0oyRDB4dnpsTzcyU1gzMnh1dW5RSXEzcjlqSnUv?=
 =?utf-8?B?bzRzdEEwUVRUc1U4clI2Q3hOaWpQM3h2QjBmcnZVdkVOTVkxVUdjOTFSMjM4?=
 =?utf-8?B?b0lRbm9GZnZ1Z2lGRTdKMEpEemhMVFNCODBZb1NKcWxzdEtkTi9IVzRMcm5t?=
 =?utf-8?B?aG1FdGppZTJDcmVhZXJyTnJmMk85TDRpRWF2SVhVVmRnNGtTUU1PN2llY1ZH?=
 =?utf-8?B?QnBPUHNCTzRNRFJFUmd6bG56TzNsays0U0ZhZndvOVZLcms1U1BJRDNDQk9R?=
 =?utf-8?B?YXVEY1IxRWNVWEVEVjdCd05qbnpmYVljeFlObE5qSGhLS1FtaEFBMnpjSDFl?=
 =?utf-8?B?M3Z3aEl1MGYvR0dCN2RZWWtNMUQrK25nQ2UwdktvZlE2T1lKTC9QNVZyU1U3?=
 =?utf-8?B?MlJjT0x1blBOaHhIM0xCSU5VV2lBbVJLdEx2ejhGbU9TVXBFUUJXWlA5U042?=
 =?utf-8?Q?ZALRQs3x?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR09MB7095.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ac9759-f3ea-460b-d2ed-08d8c7b22fa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 19:38:58.9293 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 14b77578-9773-42d5-8507-251ca2dc2b06
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZguZLw6cGcdX/zmo8rMePswudrc1k22V7vJpdR7jQoCAxKdeHixfsqBXTtmCR8Qf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR09MB6839
X-OriginatorOrg: ncbi.nlm.nih.gov
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Tue, 02 Feb 2021 19:39:02 -0000

PiB3aXRoIHNvbWUgY3VzdG9taXphdGlvbnMsIGFuZCBub3Qgbm90aWNlZCBhbnkgaXNzdWVzIHNv
IGZhci4gU2hvdWxkIEkgYmUgd2FyeSBpbiBmdXR1cmU/DQoNCkhhdmUgeW91IHVzZWQgdGhlIDxy
ZXNvbHYuaD4vPGFycGEvbmFtZXNlci5oPiBBUElzLCBvciBsb3ctbGV2ZWwgRE5TIG90aGVyIHRo
YW4gd2l0aCBnZXRYYnlZKCksIG9yIG1heWJlIGRlYnVnZ2VkIEROUz8NCg0KVGhlIGNoYW5nZXMg
YXJlIG5vdCB0byByZW1vdmUgYW55IGV4aXN0aW5nIGZ1bmN0aW9uYWxpdHkgLS0gSSBkb24ndCBz
ZWUgaG93IHRoYXQgd2FzIG5vdCBjbGVhciAtLQ0KYnV0IHRvIG1ha2UgaXQgZWFzaWVyIHRvIHVz
ZSB0aGUgQVBJIHdoZW4geW91IGhhdmUgdG8gZG8gYSBsaXR0bGUgZXh0cmEsIGxpa2Ugc2VlaW5n
IHRoZSBuYW1lc2VydmVyDQpJUCBhZGRyZXNzZXMgaW4gYSBtb3JlIGh1bWFuLXJlYWRhYmxlIGZv
cm0uICBCdXQgVEJILCB1c2luZyBuYXRpdmUgQVBJIChpbiB0aGUgYWJzZW5jZSBvZiAvZXRjL3Jl
c29sdi5jb25mLA0Kb3IgYnkgdXNpbmcgIm9wdGlvbnMgb3NxdWVyeSIgaW4gaXQgLS0gYnV0IHRo
ZW4gbW9zdCBvZiB0aGUgc3R1ZmYgaW4gdGhhdCBmaWxlIGlzIGp1c3Qgc2ltcGx5IGlnbm9yZWQs
IEpGWUkpLA0KaXMgdGhlIGJlc3Qgd2F5IG9mIGRlYWxpbmcgd2l0aCBETlMgaW4gQ1lHV0lOLiAg
VGhlIG1pbmlyZXMuYyBpbXBsZW1lbnRhdGlvbiBpcyByYXRoZXIgc2ltcGxpc3RpYyAoYnV0IGl0
J3MNCmdvb2Qgd2hlbiBvbmUgbmVlZHMgdG8gc3RheSBpbiBmdWxsIGNvbnRyb2wgLyBvYnNlcnZl
IG9mIHdoYXQgdGhleSBhcmUgZG9pbmcgLS0gYW5kIGZvciBtZSBpcyB0aGUgZGV2ZWxvcG1lbnQN
CnN0YWdlLCBidXQgSSdsbCBkcm9wIHRoYXQgYW5kIHN3aXRjaCBiYWNrIHRvIHRoZSBPUyBBUEkg
b25jZSBldmVyeXRoaW5nIGlzIHdvcmtpbmcgYXMgaXQgc2hvdWxkLCBmb3IgdGhlIHByb2plY3QN
CnRoYXQgSSdtIGRlYWxpbmcgd2l0aCByaWdodCBub3cpLg0KDQpBbHNvLCB0aGVyZSB3YXMgYXQg
bGVhc3Qgb25lIGJ1Zy4NCg0K
