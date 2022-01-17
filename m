Return-Path: <lavr@ncbi.nlm.nih.gov>
Received: from nihcesxwayst03.hub.nih.gov (nihcesxwayst03.hub.nih.gov
 [165.112.13.34])
 by sourceware.org (Postfix) with ESMTPS id C553E3858D3C
 for <cygwin-patches@cygwin.com>; Mon, 17 Jan 2022 19:39:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org C553E3858D3C
X-SBRS-Extended: Low
X-IronPortListener: ces-out
X-IronPort-AV: E=Sophos;i="5.88,296,1635220800"; d="scan'208";a="229475011"
Received: from unknown (HELO mail.nih.gov) ([156.40.79.162])
 by nihcesxwayst03.hub.nih.gov with ESMTP/TLS/AES256-GCM-SHA384;
 17 Jan 2022 14:39:09 -0500
Received: from nihexb4.nih.gov (156.40.79.164) by nihexb2.nih.gov
 (156.40.79.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 17 Jan
 2022 14:39:09 -0500
Received: from GCC02-BL0-obe.outbound.protection.outlook.com (156.40.79.133)
 by nihexb4.nih.gov (156.40.79.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18 via Frontend Transport; Mon, 17 Jan 2022 14:39:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKoaUViwIIAOD0Xxipl8pLxtl9xvUiOTYIOlp46/CEowhFWSpEB2rRT76oLnBzi1xrLPfFGeq/py0kNdPo3ZeB423fe1mAvKhHcO5WbCCOflUmWw4Go5NPt9hgFA1vvR2i9gJ2wkISGFrX/opDWZiZDpRfXuE/ujFhGfcZibe48wnLXRVxlZKm+AAntklki4OBf3e1wKmx1CUNRjXZ1SN/Hffbc7F+zYQsBOzF+O45X7RqWLzWSMBgBZDva6TeZweS9JljtCeLFwV4wfqBxEjUKC//sTRnD3nFtPhaENN8Nm3d8S8kDXzXfJ1z20t9Jw7R2EW3w/WOm+o9gsyYO4/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6n0Qd+QI+bvFW+e6diEQ2sVuXaz5ZABnwjL6uWNxUF4=;
 b=R331yj2NJ6CFK06qr5+TCGOjuU7NRg/9B0G/t+K1JTlRabcBn6s+U19x600v8MqwwI7LnXgJ2tjrWf0LqGEdyLsIfdn7LBK7Ibw2eyV00H8cLnnZRa3GXJft3Osw1L366INUP3wGhTElcdDv9YAbRlHdXx32lPFTQOUVXggS0Zj3OC3Dm5S+YIqgSwbgxHhzsGPhfU9pcwyVpxGBHka3BKV72bgRb/ZJML4LDyGFaNfMmxLnOtg7as/YSKt6z6GXhKZoSACFxAxCKNXD70GhF//eUKHHj2ONK2N7b+7MHAc0BdvmwpexjZOJOuHc1lEuyuUgi8lUbRx2SkyckvrDxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ncbi.nlm.nih.gov; dmarc=pass action=none
 header.from=ncbi.nlm.nih.gov; dkim=pass header.d=ncbi.nlm.nih.gov; arc=none
Received: from DM8PR09MB7095.namprd09.prod.outlook.com (2603:10b6:5:2e3::14)
 by DM8PR09MB6278.namprd09.prod.outlook.com (2603:10b6:5:2e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Mon, 17 Jan
 2022 19:39:07 +0000
Received: from DM8PR09MB7095.namprd09.prod.outlook.com
 ([fe80::d82c:2f49:8b4a:6d41]) by DM8PR09MB7095.namprd09.prod.outlook.com
 ([fe80::d82c:2f49:8b4a:6d41%4]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 19:39:07 +0000
From: "Lavrentiev, Anton (NIH/NLM/NCBI) [C]" <lavr@ncbi.nlm.nih.gov>
To: Jon Turney <jon.turney@dronecode.org.uk>, "cygwin-patches@cygwin.com"
 <cygwin-patches@cygwin.com>
Subject: RE: [EXTERNAL] Re: [PATCH] Cygwin: Conditionally build documentation
Thread-Topic: [EXTERNAL] Re: [PATCH] Cygwin: Conditionally build documentation
Thread-Index: AdgJg/PT224S2+RWSqG7LmiiAzfcaAAnY5AAAG4LQ5A=
Date: Mon, 17 Jan 2022 19:39:06 +0000
Message-ID: <DM8PR09MB70951B6B94A1F6CC911BAFFCA5579@DM8PR09MB7095.namprd09.prod.outlook.com>
References: <DM8PR09MB70950BB104F774E1F959F7BEA5549@DM8PR09MB7095.namprd09.prod.outlook.com>
 <06431ef7-3239-b2e7-06c1-b9b4e4090df1@dronecode.org.uk>
In-Reply-To: <06431ef7-3239-b2e7-06c1-b9b4e4090df1@dronecode.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e12f7b8a-f2c2-4b67-c6c8-08d9d9f10690
x-ms-traffictypediagnostic: DM8PR09MB6278:EE_
x-microsoft-antispam-prvs: <DM8PR09MB62781236EAA820F0EC006B56A5579@DM8PR09MB6278.namprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WNtli0vOr+y3gOIuh+cgb3AvLhurqd70ebSJZ5NAm91dVoqIPpGN7d1XrtXN/XrbFCh9prUzUtk0kaO/2WtAoThHMEi2IJwRxkyGSE/k58ZpnRerjoIjjbig7gDwGo1KYROztPu8O7tNipaOlo2gaPEHyk7EusbN8+OKngg12ZcZc1ULrnrhWJzE1rfdo9rofYrIvIisgBhdF2yNj69fNSePgYSCX++1cqSd3eV1aQW3bvASMUkTVjMTmcHV+5z80IZpHfPAfItUqRiUx9pWClqLKTqIyhxo77E43aZNUYZcDAklrebObaXhbrNZ6/36NSHFN/eHsKCzyMjpgs5rHq/dtdAxn3aC5auBjuICIBxIj7K/4/9GWIMXUfoXCcyRvtZfzw6Yy59ZmTLhZHMWTQRDEkv1xaLSpbphQ6gEs3j7n77nCFztRaR2dikpxODFJCzhZwy7+72J9JJCnFsQsWkisKgjp2jBocouxOGu1UcCAR27dNwMwOveB1yCWbuR8qLTI+0gy0TaylYO/uvKEjLue/V6uzUCyBmqYtSY21jA0rn6qJTy87s+ka/EtT/L+EwTQciUIga7RA0un4CvOXq5bHixeL/f/Yfizp7Hi2zr/TSQmClWoxy3l0vLZnKk9wldwTGRw+gCuqX1KQaN5BNoCdEiz5oSpHgo3Y+HtXbX45UxUOSbf9zLa2YOyOqVN7amgrs4s61KlB66UtZAKA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR09MB7095.namprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(9686003)(6506007)(26005)(38070700005)(2906002)(508600001)(316002)(55016003)(71200400001)(110136005)(5660300002)(66476007)(7696005)(76116006)(66446008)(4744005)(186003)(66946007)(64756008)(66556008)(52536014)(8676002)(38100700002)(8936002)(86362001)(122000001)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkdxMFNrcEJ1OENxYmtHWjMyRmxkNFJBZmM5R3l2RC9aM2F3aXNXRGl1ZkVO?=
 =?utf-8?B?QjN5TEdFQXVXUkRXVG5zQUVSRnJxMGVwdjFXS01tVzJxRUt3NktrOXFkYkRo?=
 =?utf-8?B?TE5LYlE5VklRVkJRd0lJM09xdGxLSkFXWXJmQkJ5YWZFaFYrblZKejNsNS9K?=
 =?utf-8?B?UGFzMFg0RmRDTzk5b2hYbjJaU1h0cWVVUXIrZG91Nk82ZEo0cFEvNE83dW9B?=
 =?utf-8?B?QXdFTnVZcVdVbk9kcW9wLzNhNS9FQnVoemtsUzIvbXhFUUtPY3BNajFKbEVU?=
 =?utf-8?B?LzhqWXUxN1VnN2lHbHRUYlp6Z1lMMElJWmsvaDk4cXVFS0c5eGNETGlHTE1m?=
 =?utf-8?B?ZlJQSVZicFhjVUpwanZrMFpDempjNkd2aUNka3JGZTY1dUlERWpHSSttWk8r?=
 =?utf-8?B?dTdZU1VUQ3VFNVhiRG0yM21Rc0J1cEFMYjFxNDllNThrbytHdEkzTnRBdktN?=
 =?utf-8?B?K3IvU04zMGY5RmtPVGVRTCtmcGJVaDJzQWs3Z1V2ckNsdFNkL2laOWlZZFdW?=
 =?utf-8?B?eGlVaTJ5Y0p5b284bzBwalIva3RDc3hQdUtORFZaN3JhN2I1VUZmZGMwa3Rh?=
 =?utf-8?B?YVNxa1FjQVJTU0YwVllVaUI2NTUzc0ZyWDdyUXpTdmxGcUZHNFQ1bzRrUmlT?=
 =?utf-8?B?eThUZnV5d0lQUkdNdUtTYi9KaEsyRFVDVkNxbFJHUnBJeFplVEhyaXFSUDBk?=
 =?utf-8?B?VWFVdUtIclRrT3EwYVR4aEFyWmFpVWZ2bXN4Y0tCdHl4L2xvVHJrbngzVlhi?=
 =?utf-8?B?V2ZSY0dGWWRsSHVRdlJsK25SY1d5MFFGUUs3NWozY3FoUnRKaS9uNGZqajh3?=
 =?utf-8?B?T2ROSkNSbmhPSmlEc1dsQzZ3d3pIVEVIelJnSmRmbXNjcWthSitBT3hMK1Vv?=
 =?utf-8?B?aXJuMDArTkJ3VE1KRHdpcjI3WHJEaTBOUlF6NHh4Qm81UDd2RFVFcnBxUFZW?=
 =?utf-8?B?Q3NHcWFYT2RUeDVUNjdRREQrMmxTajNvdy80L1V0emZBZ1RCOG12N21pdHNR?=
 =?utf-8?B?VEdFcTNDdWlQNi9XUXRpcHpBZmorZmd2OFIrMmNNY3FUMzdOQUZoYlp2NHV2?=
 =?utf-8?B?RWE3ZVQyQ25KRlBsbEkwM3VjUkhGSUZ6ZEdwbE10TXoyM2xMNVQyUWtHNmNE?=
 =?utf-8?B?OFc1dGNOVHlnV0dhTS9OS0dvT1pHL3YrcTBCSitXT3pHMTNZT0IzQW52WVZP?=
 =?utf-8?B?NlFuSW44ZDEwSU1pOExaMVA3TDVsdjVnc1pnUlcyVFNqNDBtUHB0dnRnMjAx?=
 =?utf-8?B?NjdtMHl5OUdRc1hEc1M5UjgrcUkvc0gzVHU4bVJjbG5oMi9sVllWbjZ5Zm9W?=
 =?utf-8?B?d3FqN2xMWHIrZEYyK1lsUWxlcXJSV2JSa25jb3lHbjdtKzZzZ0RuQlVnbi96?=
 =?utf-8?B?NEs3N2Q5VXVGbG9LT0hubWt0eXF1RzVwZG11YkVmL1dsNVF3QmFSNW9WKzAy?=
 =?utf-8?B?ckppUlR2SGlaaUhiTjgwWmdPaDV6OEx0cDcrZUJXRjUxVkNVWTVRa2RFUDJW?=
 =?utf-8?B?aXJseEtzWlVrbGpNZ05PRTBMRHBZdFArTnd1Y3JWY283RHUrM1BxanpnY1Jz?=
 =?utf-8?B?eHpUalo3YjNpWGtuRm5kZHVkbVFZcERicEttTzJlZFFjdzRjUlJ5WmYwa0dC?=
 =?utf-8?B?VmdzYkRkeTJZeFBZa2l1VHJUMEtxT0pyY1M2cWE4N2ZFSlNhWnR6MTMxNDRF?=
 =?utf-8?B?WlZyUVMvQVVqZGo4RmJPT1lGeGdzdDltWEpLVkwzUlcvYWpMd1o0ZngxRXpy?=
 =?utf-8?Q?0EI8wwOThj/lqBToKw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR09MB7095.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e12f7b8a-f2c2-4b67-c6c8-08d9d9f10690
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2022 19:39:06.9147 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 14b77578-9773-42d5-8507-251ca2dc2b06
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR09MB6278
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
X-List-Received-Date: Mon, 17 Jan 2022 19:39:10 -0000

PiBJdCBpcyByZXBvcnRlZCBieSAnY29uZmlndXJlIC0taGVscCcsIGF0IHRoZSBhcHByb3ByaWF0
ZSBsZXZlbCAoYWx0aG91Z2gNCj4gc2luY2UgZW5hYmxlIGlzIHRoZSBkZWZhdWx0LCBJIHByb2Jh
Ymx5IHNob3VsZCBoYXZlIHdyaXR0ZW4NCj4gJy0tZGlzYWJsZS1kb2MnIGhlcmUpLg0KDQpDYW4g
eW91IHBsZWFzZSBtYWtlIGl0IHNob3cgYXMgLS1kaXNhYmxlLWRvYyA/DQoNCkFsc28sIGNhbiB5
b3UgcGxlYXNlIG1ha2UgaXQgdmlzaWJsZSBpbiB0aGUgdG9wLWxldmVsIGNvbmZpZ3VyZT8NCg0K
VGhhbmtzLA0KDQpBbnRvbiBMYXZyZW50aWV2DQpDb250cmFjdG9yIE5JSC9OTE0vTkNCSQ0KDQo=
