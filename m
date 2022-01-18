Return-Path: <lavr@ncbi.nlm.nih.gov>
Received: from nihcesxwayst04.hub.nih.gov (nihcesxwayst04.hub.nih.gov
 [165.112.13.42])
 by sourceware.org (Postfix) with ESMTPS id AD6283857C64
 for <cygwin-patches@cygwin.com>; Tue, 18 Jan 2022 13:58:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org AD6283857C64
X-SBRS-Extended: Low
X-IronPortListener: ces-out
X-IronPort-AV: E=Sophos;i="5.88,297,1635220800"; d="scan'208";a="227283897"
Received: from unknown (HELO mail.nih.gov) ([165.112.194.63])
 by nihcesxwayst04.hub.nih.gov with ESMTP/TLS/AES256-GCM-SHA384;
 18 Jan 2022 08:58:25 -0500
Received: from NIHEXS4.nih.gov (165.112.194.64) by nihexs3.nih.gov
 (165.112.194.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 18 Jan
 2022 08:58:25 -0500
Received: from GCC02-BL0-obe.outbound.protection.outlook.com (165.112.194.6)
 by NIHEXS4.nih.gov (165.112.194.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18 via Frontend Transport; Tue, 18 Jan 2022 08:58:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGYYHgg/vdF1kCKU6JuZPuyCwSxB6iQiwa0B8oa/i9l+KOVwe7djNgDazK1hW01Hx+rExYO74iKglx1u+YS3XrEZXWGIAGU55rx+f+T1lcVOkSvkfBhvyBKUzOsQy5ITDEYFHk6ZTKeIv4TXIPu3UeoASk3W1LByob+YPcOCd2EoT8uNNYERA4bHIC97wdwxJmvf1S99H3iCrskLTSuouk1zk1q5uyjbGH4Gfv/+MvlVMgKAxC24zq0vmVXG+ux6J/MAAutlafoCpB/xa5gsoG+a2bZ6pFylNmGZPinFBapI0CQEeRSWZxCF7YflsfllvNsm1doNQRRnDlPVa4DOew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y134aLWE1C6xyNTJkmWOZTe5iPhKAs8lfW8YggyG3A4=;
 b=KfgbI0tbraYPL5nd8yAXmeqUiv+v42q9u9C+r41ipLAwn/LK8y9yH543oG0x/VAneL1MXHuWWKnhzodd5v+8MumK9k/7KgaTaF+nnCpHtoC6Iy8I0YPm9fbzPHTUqCzAtR4ZypQ+B23IL2r9H+0HR4HMoACo1CsZF4nYnbqB/KLjivKoC5/URSMIOQlZS7C3X78kZlrZURMThtSUfGXdY6UbsQzf6HJQamD7qH31HWduaALM41KLameD/kVYsn0nk8NYj18xgyz5ZWWXtCjX0wQ2b4/6PAmmY5IHzhYviFUuisjPHK9dW1uwuopUhCJfMeM0Ak0qO9DaRetXktxZqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ncbi.nlm.nih.gov; dmarc=pass action=none
 header.from=ncbi.nlm.nih.gov; dkim=pass header.d=ncbi.nlm.nih.gov; arc=none
Received: from DM8PR09MB7095.namprd09.prod.outlook.com (2603:10b6:5:2e3::14)
 by DM8PR09MB7381.namprd09.prod.outlook.com (2603:10b6:5:2e2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Tue, 18 Jan
 2022 13:58:25 +0000
Received: from DM8PR09MB7095.namprd09.prod.outlook.com
 ([fe80::d82c:2f49:8b4a:6d41]) by DM8PR09MB7095.namprd09.prod.outlook.com
 ([fe80::d82c:2f49:8b4a:6d41%4]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 13:58:25 +0000
From: "Lavrentiev, Anton (NIH/NLM/NCBI) [C]" <lavr@ncbi.nlm.nih.gov>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: RE: [EXTERNAL] Re: [PATCH 2/5] Cygwin: resolver: Process options
 forward (not backwards)
Thread-Topic: [EXTERNAL] Re: [PATCH 2/5] Cygwin: resolver: Process options
 forward (not backwards)
Thread-Index: AQHYC8yP95gPwiTVUEmTtLiQOgwY4axoleGAgAAyZLA=
Date: Tue, 18 Jan 2022 13:58:24 +0000
Message-ID: <DM8PR09MB70957B6BFEAE91059D1371A6A5589@DM8PR09MB7095.namprd09.prod.outlook.com>
References: <20220117180314.29064-1-lavr@ncbi.nlm.nih.gov>
 <20220117180314.29064-3-lavr@ncbi.nlm.nih.gov>
 <YeaXUdGyYg3uirHv@calimero.vinschen.de>
In-Reply-To: <YeaXUdGyYg3uirHv@calimero.vinschen.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e8ccb2a-2ee3-4f49-32b9-08d9da8a9899
x-ms-traffictypediagnostic: DM8PR09MB7381:EE_
x-microsoft-antispam-prvs: <DM8PR09MB738150E09AE2CAC63EA67537A5589@DM8PR09MB7381.namprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lh4xEhP2ZnBdBkN2410yn+ZqOMr3ds4jsIe8/ypjVPmoa2p4RuvNtIK1QCBBJ4Wbx5yxcpkt60xbB6pSE6p5Nk+/kXlxPM9K7xTzxL1Gc9QSA8Vrflyivmq6rZB4lcEiTWU2pgp2+mU8uINfWZbhi6ocoKm2QSPHbUE1HBcfPr+nURpZ0gVz3TcPW87RbxKYkjGyvNZPOINzJ+oHAt4v6usY5v0kyvPlEScXdnjVYI9Bp4y9LY7YK4tk403p4mfaXA33p7LM2ftxmoi2guzVfkWKgOQaWntFTtEXq+nAXPMiFKeBnO15W+CaUOKL8BMFGt4F9k6B0NprquVJ+B4IOO63bsvH/0a6OwP58/cK6dicsHKiu2STCiKlGJnm1fkrw/Dy80U7r0HbNhmYYG91I6RqOfbqHyxiCqNQr5XtEMW9XPhmFN9yB4dtEPTLpF0uJgOyE1oZKnwtPYqjPTCJNgzvmUoZe2wuN1lYkP1CJtlCX9Z0Xir14x+EBmJ6jueYPvj6OMRjnzorVcQslkGXYIYBVzBXqWMqX8PEDESWCqbUPaJK5KkW1leMS2itty8hihv2GwDTGJFHXcZk2NLO1wLj7v6+oWwQgmjRQFjIVR/Qv56J3YweuYndyvkmAAIJeTNMPXd9EhzUFqLVaxZ73nwQMgnEK27uvIyyIyzqMEs7s1oyFlZdZowVFDGbsJJI2DfTukPY+rGeb71xYWWIoA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR09MB7095.namprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38070700005)(186003)(55016003)(2906002)(86362001)(33656002)(316002)(38100700002)(122000001)(64756008)(52536014)(5660300002)(8936002)(66446008)(6916009)(26005)(66556008)(7696005)(8676002)(66476007)(76116006)(66946007)(6506007)(508600001)(9686003)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VC9UZ0twU3k4VU9LNm5jd1NTTW1SVnovd0xvY2VseG5PUVBBV0laTkh5UFVr?=
 =?utf-8?B?UjRxMXpYU24xM3gvUmoyNGx4eGFXeWZIZlA5NllURGtCUTNTbm9MVDVLMWZ6?=
 =?utf-8?B?eDZTL3hEaERPMkVZaEFoVnRmRDRCTGx0NVBvSUlES0VvS3JUQVVmbUxlTXRS?=
 =?utf-8?B?OFI2dzlpMEJPd0EySmtwNzJ2bDlldUZFUW5kRVZBcndYaldMTE1HclcvRzVs?=
 =?utf-8?B?eU9vVDVMazJFY0I0cncyM2xuTkJDSlZtQTkwUklZOXVjNWdJanhrUjQ4c1BR?=
 =?utf-8?B?OEEranJJTlMzbndEb0phVVI2T05QNlRiUUtiem95ZkhKeERTZkhpVVFaYVQw?=
 =?utf-8?B?SGdUUTVXOFI0K0U4RUpZd1JTZEVNa3RFbEptMDhvbUN3ZDJWOTZHbFFsZkN2?=
 =?utf-8?B?TFAwTFlUVU9QWW1yTUd5MFFwdnpaUVJoTjlMS1RIZThtTXYzVERTU3pJVzEv?=
 =?utf-8?B?TjkvOEl5UjVoYmJSOGVOR1k0SDg0RnJ4d2lYbGxEN3ZyZitnLzNUQ1pzNzlp?=
 =?utf-8?B?SjZXbVVPS1liRkxGZlJnWTRVaFM2aVNGNjZyanBxbVZsWG1TbzFlcEllUkQ2?=
 =?utf-8?B?OXpXUmF5TUJ6aGR1Y0Fvb0Q2cDE0THh6amd0V1J2ZDBnTlV6eFBkN0xGbTU4?=
 =?utf-8?B?YzZBNFZKQWp0R2Yya2I2cE5MejZQMEpZQlRtazAzT0xmdGZJNlA2bnVTT1px?=
 =?utf-8?B?bGVhcHkxYjlyaTFOL242aEdHUXAxWmhGWmNVUCtCR0FNLysrVW5hOERTWVJR?=
 =?utf-8?B?dVlvVFh0TDk4YUxiTzNTRjNGSDlTWWwvU3Z4SGJkQXNRT0pIbmVqanM3SFQx?=
 =?utf-8?B?R1RSM21xUnBVLzArYXluUmFjelBkS2VpUGVvZ1MxcGNnNE13Vy9taitUZkZH?=
 =?utf-8?B?Q2JNTG9UTHFJeGZ0Q25CcmFKMTZTcEVzaFRoaDhUZWRKWlNEbXlTZFd2aTF2?=
 =?utf-8?B?c3d6bVFwWTFGUFZqVDBobTZ4WjdpaGZJUkFJcXVOOTUvTDg1OTRnU3N5NVdZ?=
 =?utf-8?B?ZEpBOENkbHdDd2p4MmE0dkNxZTlLQ2x5R3VOcDQ3MVFKZWZZL3VxbG93cEVa?=
 =?utf-8?B?VFNlMHRnMUVubGhxazBsOHRrVHVuQ3YwU01TZnQzdGNTMHNibjllaGFJYlhu?=
 =?utf-8?B?Q1ZTK05Od0xWK09IUW1nYWwyNHFzY3V1Qi9EdTV3TWE5T2hHNE9JSXJ2aVkv?=
 =?utf-8?B?V2pzWW8rUkVBSkpWRzdPRk9YSG94MHNPbTlFQ0NEMzBUajR2bS9va293WHg5?=
 =?utf-8?B?L3RQWHFpN0YwY2ZGMzE1ZEgwZWhQazMvemtNbjNkMUJmdXg2Wm1pRmc4S3Q1?=
 =?utf-8?B?Ym9WN0V3UWdmRkw0bE9VVUdrQThSUVlJNlFUUVFPZVhmeW5LRXFnV1M0bkFz?=
 =?utf-8?B?SC9jWXJwM25QR3ByMG9JOGVZbWRKY2VMdndYRWdHOC80bUQ2ZzR2ZUQwaFN0?=
 =?utf-8?B?M0YxY0U1eVNOZWl2ZFpGWk9Eckh0MHA3NGxDSzZPOCt2a0xjV29xaWRFSEQ2?=
 =?utf-8?B?R0ZFakZ3bDFPK0NFWHZQUkRoc2JSZmFWOGFHRHJYZ2tVQWVtaThWTHd0MUNO?=
 =?utf-8?B?R0IvTWNQQWt1VzBJbkVydjQ4MlRDa0thZGpvWURwU2hreHJnSjIzV1ZkcFFJ?=
 =?utf-8?B?SUlRNTIxbVdNVlpQRXU4OTEvM0lsNFI4Mk9RVElvdmFQV3BsbC9yWVdmMnBN?=
 =?utf-8?B?OXFnblFUcW5Va1h6K1piYVgzeTZnUS9QVHdYMXN5c0ZBQUpqUUhlbDFpdVM3?=
 =?utf-8?Q?mXeDO+rOCgkEa5SGU8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR09MB7095.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8ccb2a-2ee3-4f49-32b9-08d9da8a9899
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 13:58:24.8810 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 14b77578-9773-42d5-8507-251ca2dc2b06
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR09MB7381
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
X-List-Received-Date: Tue, 18 Jan 2022 13:58:29 -0000

PiBJIHB1c2hlZCBwYXRjaGVzIDEgYW5kIDMgdG8gNS4gIEkgZml4ZWQgdGhlIGNvbnNpdGVuY3kg
dHlwbw0KPiB0aHJvdWdob3V0Lg0KDQpUaGFua3MhICAoYW5kIG9vcHMgOi0pDQoNCj4gUmlnaHQg
bm93LCB0aGUgZGVidWcgZmxhZyBnZXRzIHNldCBpbiBzZXZlcmFsIHBsYWNlcyB0aHJvdWdob3V0
IHRoZQ0KPiBjb2RlLiAgR2l2ZW4geW91IHNldCB0aGUgZGVidWcgZmxhZyBhYm92ZSwgZG9lc24n
dCB0aGF0IG1lYW4gc2V2ZXJhbA0KPiBjb2RlIHNuaXBwZXRzIHNldHRpbmcgdGhlIGRlYnVnIGZs
YWcgbGF0ZXIgaW4gdGhlIGNvZGUgY2FuIGdvIGF3YXk/DQoNCk5vLCB0aGV5IGNhbid0LiAgVGhl
IGZsYWcgY2FuIGJlIHByb3BhZ2F0ZWQgZnJvbSAicmVzX2luaXQoKSIgZnJvbSB0aGUgdXNlcg0K
bGFuZC4gIFdoZW4gL2V0Yy9yZXNvbHYuY29uZiBnZXRzIGxvYWRlZCwgaXRzICJvcHRpb25zIiBj
YW4gYWxzbyBzcGVjaWZ5IHRoZQ0KZGVidWcgc2V0dGluZyAoc28gaXQgc2hvdWxkIGJlY29tZSBh
Y3RpdmUgc2luY2UgdGhlbiksIGJ1dCBmb3JtZXJseSB0aGUgY29kZSB3YXMNCnVzaW5nIG9ubHkg
dGhlIGluaXQtcHJvdmlkZWQgdmFsdWUgaW4gImdldF9yZXNvbHYoKSIgeWV0IHRoZSBkZWJ1ZyBz
ZXR0aW5nIGZyb20NCiJvcHRpb25zIiAocGFyc2VkIGJ5ICJnZXRfb3B0aW9ucygpIikgb25seSBh
ZmZlY3RlZCB0aGUgb3B0aW9ucyB0aGVtc2VsdmVzLA0KYnV0IG5vdCB0aGUgY2FsbGluZyBjb2Rl
IGluICJnZXRfcmVzb2x2KCkiLCB3aGljaCBrZXB0IG9uIHVzaW5nIHRoZSBpbml0aWFsIHZhbHVl
Lg0KVGhhdCBtYWRlIHRoZSByZW1haW5kZXIgb2YgdGhlIGZpbGUgcGFyc2UgdG8gY29udGludWUg
InNpbGVudCIgdW5sZXNzICJyZXNfaW5pdCgpIg0Kd2FzIHByZXZpb3VzbHkgY2FsbGVkIHdpdGgg
UkVTX0RFQlVHLg0KDQpTbyB0aGF0IHdhcywgYWdhaW4sIGluY29uc2lzdGVudCEgKHNlZSwgSSBj
YW4gc3BlbGwgaXQgdGhpcyB0aW1lIGFyb3VuZCA6LSkNCg0KUG9zdC0iZ2V0X29wdGlvbnMoKSIg
YXNzaWdubWVudCBpcyBub3QgYW4gYWRkaXRpb25hbCBhc3NpZ25tZW50LCBpdCdzIGEgcmVmcmVz
aA0Kb2YgYSBwb3NzaWJseSBjaGFuZ2VkIHZhbHVlIChmb3IgYSBsb2NhbCAiZGVidWciIHZhcmlh
YmxlKS4gIEkgdGhpbmsgdGhlIHBhdGNoIGlzIGNvcnJlY3QsDQphbmQgaXQgd29ya3MsIGZvciB3
aGF0IEkgYW0gY29uY2VybmVkLCAtLSBJIGNoZWNrZWQgdGhhdCBhbmQgd2FzIHVzaW5nIGl0Lg0K
DQpBbnRvbiBMYXZyZW50aWV2DQpDb250cmFjdG9yIE5JSC9OTE0vTkNCSQ0KDQo=
