Return-Path: <lavr@ncbi.nlm.nih.gov>
Received: from nihcesxwayst06.hub.nih.gov (nihcesxwayst06.hub.nih.gov
 [165.112.13.54])
 by sourceware.org (Postfix) with ESMTPS id 1421A386188D;
 Mon,  1 Feb 2021 15:46:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 1421A386188D
IronPort-SDR: nESy2hRyWMJ28Jcjzou/n1lFqiVFFLRulORjA5OWQO5jP6K6MIocvWz1tG45ZPlS+iOA1J2kqL
 a5HbSWbEmMzw==
X-SBRS-Extended: Low
X-IronPortListener: ces-out
X-IronPort-AV: E=Sophos;i="5.79,392,1602561600"; d="scan'208";a="177860049"
Received: from nihexb4.nih.gov (HELO mail.nih.gov) ([156.40.79.164])
 by nihcesxwayst06.hub.nih.gov with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Feb 2021 10:46:51 -0500
Received: from nihexb2.nih.gov (156.40.79.162) by nihexb4.nih.gov
 (156.40.79.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2106.2; Mon, 1 Feb 2021
 10:46:51 -0500
Received: from GCC02-DM3-obe.outbound.protection.outlook.com (156.40.79.134)
 by nihexb2.nih.gov (156.40.79.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2106.2
 via Frontend Transport; Mon, 1 Feb 2021 10:46:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWEgC5ID0A9JgpFYAubkrVegLh33Ln5orTZjRybyXZiXgi6DQaHw0XEGQmYTRmJk0fXeA2I+1rDCErgSNLbZ7JOt0nEnr3LQ3BbKidG0uioB1V8/D8cztwSb2fLyq+8R4ORsLTyanZTCBt+OXUrOAC6jUArMkb8avUugVhf1o/duaSe5uYQxUDrs60BVIvAVl05Q8vGqa0P5FW+qv8mhnAiSZ5jrZs9gpvbjrdbC1XOLGYYMeF1alzt6RUET3m+dJ8pg42TeZcZRAX0rGztxHXVbvKSWHJy0kzhAfe3EVIjD1tcpPocqCxgJkmNW8rNPIUoIxOHjZOL8XTjcGqNjXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECkUt5ICD+DZJIO12JZA+TOHKCQzxhp8lj9loEOP01Q=;
 b=b7MqRp9ETiBNkh2u/NOa7hJpgrIGfY7GfXYjrG3Bj1Uw3UKvyrskIkRZa09ACz1XOcCmneWsBfr38JKWMsnxIq526VeEEAzqkZI8mu8Wku2yr2nTtCKZYiffxHlzw9f46aFB2Zaxx8s7Zv3ydG0IZmzdAx4OYC7xA1mf2MvAzcNqH93SeedT/xF1lRg3jgdN8TRQx0aoG7MZT0Jv3cGQ/taIE36iYyQNQEiA9kpG4lEmzBoSegpQlHkDPMeElvs/XBbiExKldVjHlKkVGt77MgogaHpnc4PqLFFRDJb3Rtw7WfN8kA3MgIyfN2C/oORfBY5CXeZMqZlTBzIIMSLoEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ncbi.nlm.nih.gov; dmarc=pass action=none
 header.from=ncbi.nlm.nih.gov; dkim=pass header.d=ncbi.nlm.nih.gov; arc=none
Received: from DM8PR09MB7095.namprd09.prod.outlook.com (2603:10b6:5:2e3::14)
 by DM6PR09MB5368.namprd09.prod.outlook.com (2603:10b6:5:26e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Mon, 1 Feb
 2021 15:46:50 +0000
Received: from DM8PR09MB7095.namprd09.prod.outlook.com
 ([fe80::9487:e478:f84:99c3]) by DM8PR09MB7095.namprd09.prod.outlook.com
 ([fe80::9487:e478:f84:99c3%6]) with mapi id 15.20.3805.027; Mon, 1 Feb 2021
 15:46:50 +0000
From: "Lavrentiev, Anton (NIH/NLM/NCBI) [C]" <lavr@ncbi.nlm.nih.gov>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: Corinna Vinschen <corinna-cygwin@cygwin.com>
Subject: RE: [PATCH] CYGWIN:  Fix resolver debugging output
Thread-Topic: [PATCH] CYGWIN:  Fix resolver debugging output
Thread-Index: AQHW9nUig9vBaGYORkSRoQCTG8kIIKpDHsyAgAA7BNCAAA+ygIAAB3UA
Date: Mon, 1 Feb 2021 15:46:50 +0000
Message-ID: <DM8PR09MB70952B27AFDF02848ABB50C7A5B69@DM8PR09MB7095.namprd09.prod.outlook.com>
References: <20210129192903.939-1-lavr@ncbi.nlm.nih.gov>
 <20210201103445.GK375565@calimero.vinschen.de>
 <DM8PR09MB7095CE3228ED706E16BA0F16A5B69@DM8PR09MB7095.namprd09.prod.outlook.com>
 <20210201150209.GP375565@calimero.vinschen.de>
In-Reply-To: <20210201150209.GP375565@calimero.vinschen.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [130.14.9.135]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c6229e0-57ce-4979-8cd0-08d8c6c89754
x-ms-traffictypediagnostic: DM6PR09MB5368:
x-microsoft-antispam-prvs: <DM6PR09MB5368E735B10643A7B6275B1CA5B69@DM6PR09MB5368.namprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 93DuoEou5BsEdE9sQyYOubba4fZQjKRs0blE96XM4AJOgQYltxAk4mhKH2R8vD29kbGzOzDjH18UhW4Bqv6+WrehyS88QKkU4MtKRZXXomH1iD+1Ej4ZTCkI1jjHow0nDtCgSLW6CZcm+eiJpVXfMYX3s5LUrM5rdR6DL3kAGLNBgnP7BHMGXAbNcZJJVW1XE8dr+uhcClnZfO2MvYDJnAZDFlHhV+DKvnXaiiQ/HqDKpJYANdUJskR4nKXDWmS0h+vY7w7nSja3dQCZQBbAZJQtZ49mR62vZwhmC2WHaEkqcAKf98GNK5W+AUVnZx4bOdD69G++wtTJvM8g9gcl6RlNdSt+0dcK6RD4ZGirP+a9/hUJdNY9EBGDwun9yVHNgiFuQ9fag/D/zh2BeS0uUaR7rIxQRaj5W/xOYBfYlqu4RBCay85gzc7D6Z1uJc7bnZ+alhdp4mgbR4MA5pqNo4mTaBR7+Le9ub+4CW7dKMbX8Aeo5SxvC4+RfhELinK0TPHEMvE4BfcKm7K5VGGWsA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR09MB7095.namprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(4744005)(478600001)(9686003)(2906002)(52536014)(26005)(6506007)(33656002)(8676002)(450100002)(7696005)(316002)(86362001)(4326008)(76116006)(66946007)(186003)(55016002)(71200400001)(66556008)(64756008)(6916009)(5660300002)(66476007)(8936002)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?d0NjMGNUZEJ4WTN0cUFVR1dCMjJxcjNkdnFaYjllbHlWdklnR21VUThFOGtF?=
 =?utf-8?B?RTc5eE84b2s3dDd2QzVmYWRvYmlzMkduNHA4UHdnVjM2Y2FVWWZTc0Y5Y21a?=
 =?utf-8?B?TnQzMTVKQnRWNDJnMEFVV0pweFA1V2YxUFl3aFQreFBRTzJMdExUMVIzVkdl?=
 =?utf-8?B?aUgzLzROZXFSbU15TTZIeXI2Y1QySmhRMkJadGRBVE40a1N4dkFPTkx6bHhI?=
 =?utf-8?B?Y2xPT2JpMDVWS3VKRHBWeE1lMkV2SUNyWElWaWt0dWNhMnRxbTNIWCtEcmw0?=
 =?utf-8?B?dDJlUjd4b0xOYzh6WnJKQTZRaW90QWhDMkNJZnh6Yi9uTXlLK0Y3dWlteUhF?=
 =?utf-8?B?U3kwQ2NKMFgxSy9wUE5qc0hOTUxTSnl3SVFiNUtxTXNwS0l1NjhPVjVuMGww?=
 =?utf-8?B?aWtCOWtRSzZvUVpRZzdDYTFEMmc3TlF2RnRUTG8veW42VGYza1ZMbzhzaDNm?=
 =?utf-8?B?K1JiWmZ1V2RNSmpTWVZWYzhYUkxSNWpOb0h2OEJmaW1MYW1ybFZXamVYaGZh?=
 =?utf-8?B?NjFGcTU5WUxPVFVXSzMvTEJiUytUZGxPMmZVQXNUK2JkN2tQeEhVbEdSY3Jy?=
 =?utf-8?B?L3A3NHltMWYrVlBPVWlQN0x0WEYwcmVHalI5NEdhc2UxZlpQNGRVMDRPZUJp?=
 =?utf-8?B?SVVyVjVKZWVVN3dnODdUWG9paEx1d3NiT0hHWXZaTDIxMGkzNEQxbXFvZFoz?=
 =?utf-8?B?MmFkOTFHVXNScGJ0UjZnc3BKSVJZQzZNL0s5T1dQYVhLNVhjOGRTSkRYWDNS?=
 =?utf-8?B?NCtEaWl3NVhaSFlpZWJIeXBERTRDVTJzN2ZIajlXaE93S3NQRVRLVXFJVW9U?=
 =?utf-8?B?Y2h6Q3dnNFBTY0FoYkM5eGo2RUx5anJEM2xSSlFRaDk4ay8wNlJXaFFMbm9Y?=
 =?utf-8?B?dGdrSTQzOTNFS3JlK0FPRSsyZ1RESmFlTGRuUTQ4eHZGZlF3RndvWmgwZ0xx?=
 =?utf-8?B?SVp0cHUrWVdiWjljcy9Wc0NsTlZvR3lVVUY1SGlKN1cvMEs4eTc0OEJQQ2N2?=
 =?utf-8?B?QnI2TGhHRll6eFpvaVFYY04rQzdpa2laN0RyNytPVVRaZXlsZm45S3BTLzdm?=
 =?utf-8?B?dFRldmx2R1lsL0VXWE90NFNQYmtCSHpRQk5lZk8zM1BKUFhPTmZsZW1GOUxB?=
 =?utf-8?B?Z0ZYMzNGSGNBSndPUGY0eURaRlBlRHpWRDdIU3l6SFdQa2VGMTZLaGxaeXRx?=
 =?utf-8?B?YXJqMHBXa0F2b1h4akJnQmJtYUI3UzBuYnZrQTAwZUJiR09aenRkRVY3UTJZ?=
 =?utf-8?B?eHRySisrakMrQWhmeFpyd0hSY0ozMjlVOFJwQzVLNHo3MnRVbExWcm91NkVR?=
 =?utf-8?B?UHBYNmlsbG0xdXpGRzA2anBFa1dpR2gra2Nmbm1LZ3F5SEljdU9qaG5EWWgv?=
 =?utf-8?B?Q1crbk9TbFlEb2k2SEx3SWxGRzhSTTdxU2ZKSHJISkdWWjA1M05Ja2JpRkp3?=
 =?utf-8?Q?PuBDQ1Nw?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR09MB7095.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c6229e0-57ce-4979-8cd0-08d8c6c89754
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2021 15:46:50.7096 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 14b77578-9773-42d5-8507-251ca2dc2b06
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rCCVKowy3FZXxeEXwoAZGtiybzHCJchmdruY//YFRZ3oM92IMndfBNU+qb+hjiO8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR09MB5368
X-OriginatorOrg: ncbi.nlm.nih.gov
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Mon, 01 Feb 2021 15:46:53 -0000

PiBFeGNlcHQsIHRoZSB2YWx1ZSBoYXMgbm8gbWVhbmluZyBmb3IgaXB2Ni4NCg0KSXQnbGwgcHJp
bnQgYWxsIDAncyA6LSkgIEJ1dDoNCg0KbWluaXJlcyBkb2VzIG5vdCBtYWtlIHVzZSBvZiB0aGUg
X2V4dCBmaWVsZC4gIEl0IGRvZXMgdXNlIHRoZSBjb252ZW50aW9uYWwgbnNhZGRyX2xpc3QgKHdo
aWNoIGlzIElQdjQpLA0KYnV0IG9ubHkgaWYgV2luZG93cyBuYXRpdmUgRE5TIEFQSSBpcyBub3Qg
dXNlZDogIm9zcXVlcnkiKGFrYSB1c2Vfb3MpPTAuDQoNCkZvciBkZWJ1Z2dpbmcgcHVycG9zZXMs
IHRoYXQgaXMgZW5vdWdoIGFuZCB2ZXJ5IGNvbnZlbmllbnQgKHlldCB0aGUgb3V0cHV0IG5lZWRl
ZCBzb21lIHR1bmUtdXAsIHdoaWNoIEkgc3VnZ2VzdGVkIGluIG15IHBhdGNoKS4NCkJ1dCBmb3Ig
cHJhY3RpY2FsIHB1cnBvc2VzLCBvbmx5IFdpbmRvd3MgQVBJIHNob3VsZCBiZSB1c2VkIGluIHJl
Z3VsYXIgYXBwbGljYXRpb25zICh3aGljaCBpcyB0aGUgZGVmYXVsdCwgYW55d2F5cywgc2luY2UN
Ci9ldGMvcmVzb2x2LmNvbmYgaXMgbm90IHJvdXRpbmVseSBwcm92aWRlZCwgc28gIm9zcXVlcnk9
MSIgaW1wbGljaXRseSkuDQoNCkknbSBub3Qgc3VyZSBpZiBpbXByb3ZlbWVudHMgdG8gdXNlIF9l
eHQgYnkgdGhlIG1pbmlyZXMgb3duIGNvZGUgd291bGQgYmUgYW55IGJlbmVmaWNpYWwuDQoNCkhh
dmluZyBzYWlkIHRoYXQsIEFBQUEgcmVwbGllcyBzaG91bGQgYmUgbWFkZSB1bmRlcnN0b29kIGJ5
IHRoZSBtaW5pcmVzLWlmLW9zIHNoaW0gY29kZQ0KKGFuZCBJIGNhbiBwcm92aWRlIGEgcGF0Y2gg
Zm9yIHRoYXQsIHRvbykuDQoNCg==
