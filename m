Return-Path: <j_mcnickle@hotmail.com>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-oln040092066015.outbound.protection.outlook.com [40.92.66.15])
 by sourceware.org (Postfix) with ESMTPS id A993D3858411
 for <cygwin-patches@cygwin.com>; Wed,  1 Sep 2021 14:08:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org A993D3858411
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRrubFClQp00dszjFD3tIRdM+qFXnpuEBQGm0F2aRZCL4nRymnqVSBS0q09zF8UZ3lXroYgObwWAcsdOWPZFck3rMBJ6IQUdFRUELnUF3YjLhYU9iY+oYNYtwhjYQhM2a3Cvfg9O4k0niRCVTsm/XY8OQe0kpBFnE1kDjw5tILVPO+1Cr0VX35W6uXxflpyxGyN+wBrn6qXCnbwjxUjIgTPszrlPlmbPlQj8QQElifYSdPRAlLZcBY9xZ8rX3G75Via4rbAKYSuk9xeIqJkjLchtS80y/Fabz11f/oVl0Cq2FK6FeUoJN4y4lP+dbRiEMNY1cDvBFw4RlDf0eYre9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=qpXY+FgZpZO9tODNs9j3FarGTrT8jP0ZUr5clBRwu9I=;
 b=CJ9SkuQql042ZNVOj2SdAwN/RK0KEKoqu1wZs4d89p2oJB9SKjRAurid+sdRfgyEK+AbcjtAbipGcETNKGHVfdzg7xAAU1OrUGBPj+6tts8S4BjADSr7E36fQ9DjbNyLa9ekb8WAdyBZ8DbyzNAatP8fP+0Q6dYvxAtRYs4YDVR1eZuo0a+AUIPkzhdiN6GvCDOMurJBubo85/MdJAxnbivWhviCPi3h6073owWDkZPAYfpy71Nma8tNQw5aGMW08TJeFOWswR7HGN27/YR5PJyJNDh1ZEbS5INjwj/5xBNPkrF94jVe7F9T/IccTh1QMYPM71U6WLDBf6yNyF51AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpXY+FgZpZO9tODNs9j3FarGTrT8jP0ZUr5clBRwu9I=;
 b=AbhAGN4JPjJlZibVRK5RTYXaX/w6NNAoizXCVzOFiAO++nNKopNNqzzPmajT2guHCHGKgVIdt6lzz8qpL3YH5UzWHjgINFRvAcSHqrtD6YcTNe0qy6xSBjj08CJAR9pz46+6p4/3xcsUPmsPGYLCE+jSgxkXHruLdn500B1sVp4HtQGQWJu1iK7Lesb1Z2/Mjq02C4OfO8kVCnL6wimG/MCIWowrjLHCxEYOX5QwYJ+F+tlV3x3BvsmORb5NtYryn8IZoI6xcl4uqKhYifb+s5913CQl9Fyn8bqEInTai6kiQayLv0P0/4iHTI5F5RiRvZqHzAPPAdWKmEgVcP4nhA==
Received: from VI1PR06MB5918.eurprd06.prod.outlook.com (2603:10a6:803:d3::10)
 by VI1PR06MB6704.eurprd06.prod.outlook.com (2603:10a6:800:183::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Wed, 1 Sep
 2021 14:08:37 +0000
Received: from VI1PR06MB5918.eurprd06.prod.outlook.com
 ([fe80::e173:d95a:67de:691c]) by VI1PR06MB5918.eurprd06.prod.outlook.com
 ([fe80::e173:d95a:67de:691c%7]) with mapi id 15.20.4457.024; Wed, 1 Sep 2021
 14:08:37 +0000
From: Jonathan McNickle <j_mcnickle@hotmail.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: OpenSSL Patching
Thread-Topic: OpenSSL Patching
Thread-Index: AQHXnzp1Algfn3nLcUG2uayfnS/WHw==
Date: Wed, 1 Sep 2021 14:08:37 +0000
Message-ID: <VI1PR06MB5918473FFC0A05EAD0002798F2CD9@VI1PR06MB5918.eurprd06.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 918918f0-9a8d-6328-662f-e89c9522f3bc
x-tmn: [K+E4U6i3JNrGqrD+MedLbEUkcSluzChz]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a07d9d65-80b2-4d06-1e5b-08d96d51fe23
x-ms-traffictypediagnostic: VI1PR06MB6704:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iNfLJ2jtOzzdp+kQhkUhmeIvJBBhZtkn34gPS+bbJZ903K0vtbAr/03T2h2Q53F4odMsLVpsvxkJeDWv8B2r5QFFVv0yZsJt+h5B7jUoRuITCP0ZE8+TCaA8AwjDyeLlnH/lIczmSU5uXH1wXLao5kcJbuOp47Ggx32Hs5xV5wKZETbDy0nuVJIGAKVX5nJ/pvwez1y4B/alpXzXy+eyY5FvKaSnUU87hkxlFivmAglT1LTi2b1nPMhDXPY/EPyn5mtpiP3S3WaM9+wUo7RTyRrR168d9sedFy5jN2h0iSbRv9TF0i9NjlCT1NZd9RNRnokHYsqIjg0M2QgkFR2Tgj5uxiXo4xJ4HeUyO0uBY6IHyMmF3YyXR8JN3Bu2X+jBKCoKSALI3v/atoT9dThcUN6rkFV9QOaFj0XchPy2GnsskDriaeRtX22IZIXJBfd/httAeksCNzxkmtJF4HbvPGniACIfgVkwla8iJzjdnco=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: y2nt0aeigmYtzrT7SuXVd7hJ41ropge2P6ReDd5p9OV8LRHbOcSZ5OcUtA70EJEBA2zWCTPoUoSq998YeKK4raAcgWaWhLUW9xb2PZtQFgtRKMtfivONmP43nlU9akgrXu9uBhmVkmDwEFWtlI7SGw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-3174-20-msonline-outlook-eb2c2.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR06MB5918.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a07d9d65-80b2-4d06-1e5b-08d96d51fe23
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2021 14:08:37.2069 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB6704
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, FREEMAIL_FROM, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Wed, 01 Sep 2021 14:08:49 -0000

Hi=0A=
I was wondering if plans were in place to update OpenSSL to=A0version 1.1.1=
l to fix the latest high sev security issue?=0A=
=0A=
https://www.openssl.org/news/secadv/20210824.txt=0A=
=0A=
Thanks =0A=
=0A=
Jonny=0A=
