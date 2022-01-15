Return-Path: <lavr@ncbi.nlm.nih.gov>
Received: from nihcesxway5.hub.nih.gov (nihcesxway5.hub.nih.gov
 [128.231.90.120])
 by sourceware.org (Postfix) with ESMTPS id 301803836419
 for <cygwin-patches@cygwin.com>; Sat, 15 Jan 2022 19:06:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 301803836419
X-SBRS-Extended: Low
X-IronPortListener: ces-out
X-IronPort-AV: E=Sophos;i="5.88,290,1635220800"; d="scan'208";a="315933510"
Received: from unknown (HELO mail.nih.gov) ([156.40.79.161])
 by nihcesxway5.hub.nih.gov with ESMTP/TLS/AES256-GCM-SHA384;
 15 Jan 2022 14:06:23 -0500
Received: from nihexb1.nih.gov (156.40.79.161) by nihexb1.nih.gov
 (156.40.79.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sat, 15 Jan
 2022 14:06:23 -0500
Received: from GCC02-DM3-obe.outbound.protection.outlook.com (156.40.79.133)
 by nihexb1.nih.gov (156.40.79.161) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18 via Frontend Transport; Sat, 15 Jan 2022 14:06:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itbODJzA1BEGA1n7RvnZX2ENtmgyq3xsVIKsTpEw9pjRe+oYyh4RBXIV3dLlDTF7o1DRn8KrnCO28W0YcBt+D2Zne6yWYmQyNo6+K0JjZaML7N+E1g+Tl0olvHZA2jf2rVdFhokXB6wkLZbgViRkFfffFwxYvy2d7K/P237OceZaOA4Uk9/D+unbysaz7OoyqtmPuSCcEKwfZ+ToCn/cTUw1awPMNXhx9d29+J0kAzgQL6T4Ns4YqNIWYzKrmwbajR11piWcN5mYZc4AhsKr1FPVvjJIb7y+r5cRYB4cHnzHSMuYhOiTmo56xX2gRew+AUUBIKpaxDqYEIjvqkM7zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuvaB8SgCJNM5hG3PEHdP9jQTk77yNYV/hXYwK8kDI0=;
 b=kFlKmKLeMTxjLG6imMHjdPfPQjR/rifRhCKfGamIQSY8IBxfkK1EZy68/AZhjhHTQbnsTlpOjn+2h3bPqm/zVk6nMdCyusDclLV2f1o7DkA+9cmsSoKZK5XR6zuZLWoczslXTpFnwbE0Dp6ZtMeizJgz65iZUetMf9DFLcA5O/wPMQlbdp/9ofyNK2urdNr+78+NC2ZKK+QbQTNGhO48LYoIpipfh1j0osE1FjaSTviiUY+W/Xh2bE2PrQtc31Lyul4dxgwhbhNnumvuMOBEZCHDHXayxSVVqOOoCfl3g0PlUidKp/rEazFSYgVqgr8lPwTUWCzPhMSLZE1RYqkDKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ncbi.nlm.nih.gov; dmarc=pass action=none
 header.from=ncbi.nlm.nih.gov; dkim=pass header.d=ncbi.nlm.nih.gov; arc=none
Received: from DM8PR09MB7095.namprd09.prod.outlook.com (2603:10b6:5:2e3::14)
 by DM8PR09MB7285.namprd09.prod.outlook.com (2603:10b6:5:2e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Sat, 15 Jan
 2022 19:06:22 +0000
Received: from DM8PR09MB7095.namprd09.prod.outlook.com
 ([fe80::d82c:2f49:8b4a:6d41]) by DM8PR09MB7095.namprd09.prod.outlook.com
 ([fe80::d82c:2f49:8b4a:6d41%4]) with mapi id 15.20.4888.013; Sat, 15 Jan 2022
 19:06:22 +0000
From: "Lavrentiev, Anton (NIH/NLM/NCBI) [C]" <lavr@ncbi.nlm.nih.gov>
To: Jon Turney <jon.turney@dronecode.org.uk>, "cygwin-patches@cygwin.com"
 <cygwin-patches@cygwin.com>
Subject: RE: [EXTERNAL] Re: [PATCH] Cygwin: Conditionally build documentation
Thread-Topic: [EXTERNAL] Re: [PATCH] Cygwin: Conditionally build documentation
Thread-Index: AdgJg/PT224S2+RWSqG7LmiiAzfcaAAnY5AAAAhUv/A=
Date: Sat, 15 Jan 2022 19:06:22 +0000
Message-ID: <DM8PR09MB70955355574135F9CB346D82A5559@DM8PR09MB7095.namprd09.prod.outlook.com>
References: <DM8PR09MB70950BB104F774E1F959F7BEA5549@DM8PR09MB7095.namprd09.prod.outlook.com>
 <06431ef7-3239-b2e7-06c1-b9b4e4090df1@dronecode.org.uk>
In-Reply-To: <06431ef7-3239-b2e7-06c1-b9b4e4090df1@dronecode.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f15af504-fc34-428a-e0e7-08d9d85a1edd
x-ms-traffictypediagnostic: DM8PR09MB7285:EE_
x-microsoft-antispam-prvs: <DM8PR09MB72855C0C35726B5AB019E0CCA5559@DM8PR09MB7285.namprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DTYGvgwXsLXOKhWKVRzjC6V+9nPmd6qhkpyZfm6ejYFmVw4D0RYFkHDNqCzteC6axL3G+ArNMEaxR8eDmKDCSk1Z2Q98i4OdKC8jSJX95MPrT6PBAE17bQTI5D/Pn6tM3NTJgKbSxV9RqB1y4DOu4PRyo4P5BSKW4VV4NQhxDXMF+8DyhdetIg+n0wTjIKlJXoR7qw5HDbfB1JD7eCoq2f/K5Kn3Q/I0tTG21YA3kCKB/LAhY6/0ABKVGQ5uvxgNWnkz9zD+f9l6DAYb9PvcNHv4HpIqY39fSqaXqdKYDKP2+dqPd9x9aUzC26rxMNmy+cob17qimr0qYu+bhmU8acQHd4gUhvd0LsdCwSuktWraLsjV0betRPNMmM0qoTLVp4/OBzTaz78k2GU68bsfrK4tEkoEqqhGDwDdmHQGsZ+zFKpF1yJNEJyQ8WYArF/dHJQ41UrwCsXK3WUrTfYjiW2FBmkZXmBvr2tP48P5bD7lSsnusIqzJ6YvLVCRQY3dKyPZwRHxbdGKRiW0jK5gh5A+Q631T8jFdFZ5w4IIN0rVz27u+ic16UM3EJJJAFLP2/NIFJOQcb1SicmzeF6DI9OIBwkOK+ytXicJAMxm5V49b9X45ytxDu8AotDyuh+MRYOzWdNvEdvUy+AlPpb5GIYW8IYJJLK7VynvqmQmfYvni1QC58IIpx7FZGdvrHEw4B1i/Liz40/cxNqHcBPfmA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR09MB7095.namprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(122000001)(38100700002)(86362001)(508600001)(110136005)(8936002)(4744005)(186003)(7696005)(26005)(52536014)(316002)(76116006)(33656002)(9686003)(38070700005)(6506007)(55016003)(5660300002)(8676002)(66476007)(66556008)(64756008)(66446008)(66946007)(71200400001)(83380400001)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clRiakZHRXh2SjRUVTdud2tNdFNXSEdYNEpaOUpvT01DZ1p1MWFRV2NTbkls?=
 =?utf-8?B?akU2TkwzT3Y3bWl5d2Y5NnFvS0pJK2VieitkWFZZNitDSXJhdTllbjRZYlJL?=
 =?utf-8?B?N1FXaUVRVjN5Q1dWaUkrN2Z6WFU1a2I5K0NFZW1qeXpWc2YvM3owOStTWTRp?=
 =?utf-8?B?WGJaRVlpczFxYXVKRnlwUmZjbEowRHVDa2NRVzNnQndFRHpJcnVUcWJ2dUVi?=
 =?utf-8?B?Y2F1RmlROGE4K0Q0QVVUR2V1emlJRlROM3BhMFdpSE5OaEkzSGlLUk9zY1Rx?=
 =?utf-8?B?RG1MT2hTekZuTU1Rc284eFExcmNjcm1hY1I1R3BaekRXKzc4UnZSa2t1U3Vy?=
 =?utf-8?B?RWRWdXBXcHhxWHNOd2k0UHNGRlk5RDloMmNQemUxV3EwSFBJb1RUN0V0cWdu?=
 =?utf-8?B?djJ2RGJPVkVwdDBlbWFab1VER3lQUEdaemlvQkJlVVdmWjl5cEFUaEt0cFZC?=
 =?utf-8?B?dDA3bUxBSFQ4cXc1L0NsUkVTVjdCTGdLVTQzN0dzSGxSZ0tKZld3Szlvdm9s?=
 =?utf-8?B?ZSt2N001a29hQmhqOFZnZmxuRStWNFFzQzhzdklIUHd2U2t3RVJ5a3p0Nlln?=
 =?utf-8?B?U25BdFJraFg3eURQV1cxbGllUkg4bFBnZDlVZlVEYUdjMGVrRGhRY1JiRnky?=
 =?utf-8?B?V0dRU3QyMEk5REZPcmxMVm55aDcwcEpLUEVaQjY5a0F0VkJPMVd6aHVRdUs5?=
 =?utf-8?B?TEpjZ2xOTy9NVVMxWFAwVGpIY05mcUE0QjZTWmhyVUs0S3ZPdG9SVC9Nb0Vs?=
 =?utf-8?B?cTZiNmFpdWZaS3pFUFRLa3NlMGtOSkN1bm9mc3BmeXpRWXRCclliUVVsa2U2?=
 =?utf-8?B?WUx3L3QyOW5jUEFkVVNjTitkdjhMdHhwQ2RvVU8yV1RHbmhRem92eDR3SVJH?=
 =?utf-8?B?a3VFSDZlc2J4bzJtTUt6L0luS0NzTkJRb3d4cmZYRjFSaHBmRDBYemg2Z2Ix?=
 =?utf-8?B?QkVHbXREY3B6b3NFNWtyNG4wREl0YTJhNG1BenQrMnhLWGc1Q0pkNlc4YnVI?=
 =?utf-8?B?YzJlWFRUZzhyaW1XdkFxb21FQS92aVJaYllyRXZTTnJtbmZOVXlHWERVeUVt?=
 =?utf-8?B?NXB3OFdoQlR3bHVYd0EvSW5Ba1JNM3E0RnZMNEU5R1FkYzJIbGErNytJZ0x6?=
 =?utf-8?B?aEZOKzYwRk0vQXk5NWF4a1FtNlAwZWpZTGt4dlFWTWdPUm5kcFpPc1F1QWl0?=
 =?utf-8?B?RGRUUy9FWVB2WHJOMzE4VW91TGN3K29ObkRtUzBhcGNyMEJnNkt2bGVWcnlP?=
 =?utf-8?B?bGZjTG9TQWNrUVVRNUllTVB4M2RHdVE4OTlwQ0pONWhVNzdpYTJxOEUzamF0?=
 =?utf-8?B?SzViaW9TYmtMaitWT3gwSUR5TW9iN1gxTVZ0TXRoeHBJTExydk00RHBaK0c5?=
 =?utf-8?B?WnZBVnhkN2dzVE9HaGxtUGJURFQrdUptWllkTk9OZmdmblRXZ2VPb2s1VmFW?=
 =?utf-8?B?V3RJVko5Zyt5Vm4raXBOSmRoN1BLKzZ6S05hNTdsd0tJZWQvMHNIVEREUy9l?=
 =?utf-8?B?SXlIZFNRZjFIRTg3VWJaOTVtWEJnaVdDM1RJSHg5eGp5Z1NhU1BVd3F0OHg3?=
 =?utf-8?B?RFFRZ0NPcmFVYVhjZG1rdWhpUHRKemFwaGJiNzMzMCtGMEtYMUswZk11NElZ?=
 =?utf-8?B?WXNGSHVxN2VlNDZhOTdrOWJSdkdZMHB6R0p3SHl1dDdVQnF2dkxIMkNHSDdk?=
 =?utf-8?B?WStEWkxoblp2VUF5RVEzcFRQSXN6Z01sRDQzZzFpbzUxMXJCNk5SMWg2ZDBs?=
 =?utf-8?Q?t9S5zcCc6y3IzdzzW0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR09MB7095.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f15af504-fc34-428a-e0e7-08d9d85a1edd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2022 19:06:22.4905 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 14b77578-9773-42d5-8507-251ca2dc2b06
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR09MB7285
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
X-List-Received-Date: Sat, 15 Jan 2022 19:06:25 -0000

PiBJdCBpcyByZXBvcnRlZCBieSAnY29uZmlndXJlIC0taGVscCcsIGF0IHRoZSBhcHByb3ByaWF0
ZSBsZXZlbCAoYWx0aG91Z2gNCj4gc2luY2UgZW5hYmxlIGlzIHRoZSBkZWZhdWx0LCBJIHByb2Jh
Ymx5IHNob3VsZCBoYXZlIHdyaXR0ZW4NCj4gJy0tZGlzYWJsZS1kb2MnIGhlcmUpLg0KDQpJJ20g
c29ycnkgaWYgSSdtIG1pc3NpbmcgYW55dGhpbmcsIGJ1dCBJIHVwZGF0ZWQgeSdkYXkgYW5kIHRo
aXMgaXMgd2hhdCBJIHNlZSByZWdhcmRpbmcgdGhlIGRvYyBpbiBjb25maWd1cmU6DQoNCiQgLi9j
b25maWd1cmUgLS1oZWxwIHwgZ3JlcCBkb2MNCiAgLS1pbmZvZGlyPURJUiAgICAgICAgICAgaW5m
byBkb2N1bWVudGF0aW9uIFtEQVRBUk9PVERJUi9pbmZvXQ0KICAtLW1hbmRpcj1ESVIgICAgICAg
ICAgICBtYW4gZG9jdW1lbnRhdGlvbiBbREFUQVJPT1RESVIvbWFuXQ0KICAtLWRvY2Rpcj1ESVIg
ICAgICAgICAgICBkb2N1bWVudGF0aW9uIHJvb3QgW0RBVEFST09URElSL2RvYy9QQUNLQUdFXQ0K
ICAtLWh0bWxkaXI9RElSICAgICAgICAgICBodG1sIGRvY3VtZW50YXRpb24gW0RPQ0RJUl0NCiAg
LS1kdmlkaXI9RElSICAgICAgICAgICAgZHZpIGRvY3VtZW50YXRpb24gW0RPQ0RJUl0NCiAgLS1w
ZGZkaXI9RElSICAgICAgICAgICAgcGRmIGRvY3VtZW50YXRpb24gW0RPQ0RJUl0NCiAgLS1wc2Rp
cj1ESVIgICAgICAgICAgICAgcHMgZG9jdW1lbnRhdGlvbiBbRE9DRElSXQ0KDQoNCkFudG9uIExh
dnJlbnRpZXYNCkNvbnRyYWN0b3IgTklIL05MTS9OQ0JJDQoNCg==
