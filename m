Return-Path: <cygwin-patches-return-9923-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 38628 invoked by alias); 13 Jan 2020 17:44:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 38619 invoked by uid 89); 13 Jan 2020 17:44:21 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-8.2 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=so, H*i:sk:8361114, H*f:sk:8361114, H*MI:sk:8361114
X-HELO: NAM11-BN8-obe.outbound.protection.outlook.com
Received: from mail-bn8nam11on2119.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) (40.107.236.119) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 13 Jan 2020 17:44:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=blDsH7ZjsG0mxuo7ydSPqCNST+JFhjtv/yPgwAmVv3bMO//vsonEHcKCuQcrHEY31oQ+KNa8mrEO65Ug65rfMGZzgYtrkwAFwFQnTip0iO/36wWrgv4RwA4tNfdGcZ+d9zDGdPP2TtWkXV4DZr3STNN/poluGjmqU9Fj3rLl7PBzGdNgv0X+VX5CU42jwldFYGC0Nfl0bHzi7MVpMX313zHBmwdXDIQtCFHDzG50m+qSpKLZTXL+k75KgQOcZxWFpqHbKLfVsCQxUFiP6PCMOPjgeEcxPQiVQkpBmXEkEdmCpe8kQBFlAJ8sGqRgTLlUIiKVxn49Lm4mJVq64zGJ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=nFkn09AVXP68DFUSzeVLmoIsMulPKIbZ6h6M1hf0+SI=; b=YkA0hgGr1p4s/Sossy0/WJ9X77pGzZSYoanVDFoZ9x5dh1TRHZC//grxKR3ah9X9FwqpuSnON1eSfG0Kt3Si3NGw5ptyJnOXi0mR3vFC8m4Yrhum6z+ZmT/3YN6CUImoJhvckxsxT3wm+qdhcUIgBuCQjcZpMqALIyfm2zk4/b+X8CiYIZzXDcyxPMI3JbB55SVVOFdpKozJkDVXJgvEbo/lQy18pPdcQLyb28hv0ID5chw+hTSL+JQoDHvPawRkCymQUEeoNpb1SfOYAlXmavrrNTIggZRJnTT6AYujhxXvAQolbjn2gk1YYe/8ujwA0b/te/Zb+PJ93DRWpml8yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=nFkn09AVXP68DFUSzeVLmoIsMulPKIbZ6h6M1hf0+SI=; b=arNKX96F2Nl5x1JBy49kvf4kKSyTO3hhV74oOGGkE40aqFIwMhd3lcSMjrOap/vk9y1OCdo7KJ3/Nwqy2aXX+OpiAuNJFmVX5yLKQViZkOlbnsDB0YGKC0RKUUJK6GNw/nTOHMOnGdVDZqQGWJr7iJsJCvEZF9ISl5cGojNjSlM=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB6496.namprd04.prod.outlook.com (20.179.227.24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.10; Mon, 13 Jan 2020 17:44:17 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831%7]) with mapi id 15.20.2623.017; Mon, 13 Jan 2020 17:44:17 +0000
Received: from [10.104.13.193] (63.148.235.187) by BN6PR14CA0025.namprd14.prod.outlook.com (2603:10b6:404:13f::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend Transport; Mon, 13 Jan 2020 17:44:16 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v2 0/3] Support opening a symlink with O_PATH | O_NOFOLLOW
Date: Mon, 13 Jan 2020 17:44:00 -0000
Message-ID: <1552bbe6-986a-0006-7afd-028eb0655f15@cornell.edu>
References: <20191229175637.1050-1-kbrown@cornell.edu> <20200113152809.GE5858@calimero.vinschen.de> <9f83d272-2dad-f652-d0c8-f3eb3b425ac2@cornell.edu> <8361114f-0ca9-fe51-1c4c-382192582ded@redhat.com>
In-Reply-To: <8361114f-0ca9-fe51-1c4c-382192582ded@redhat.com>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101 Thunderbird/68.3.1
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:7691;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5704A1BC87294545BD676012ECFEE5F6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ElA7EJiNKliXf0Ft6e4OS3r2LUqM9J+P1BEQIio0PcrO6dux8695XiZv4Xwb2ujZmRTG3En/qI3dPgUvzRBo3A==
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00029.txt

T24gMS8xMy8yMDIwIDEyOjI0IFBNLCBFcmljIEJsYWtlIHdyb3RlOg0KPiBP
biAxLzEzLzIwIDEwOjUzIEFNLCBLZW4gQnJvd24gd3JvdGU6DQo+PiBPbiAx
LzEzLzIwMjAgMTA6MjggQU0sIENvcmlubmEgVmluc2NoZW4gd3JvdGU6DQo+
Pj4gSGkgS2VuLA0KPj4+DQo+Pj4gT24gRGVjIDI5IDE3OjU2LCBLZW4gQnJv
d24gd3JvdGU6DQo+Pj4+IEN1cnJlbnRseSwgb3BlbmluZyBhIHN5bWxpbmsg
d2l0aCBPX05PRk9MTE9XIGZhaWxzIHdpdGggRUxPT1AuDQo+Pj4+IEZvbGxv
d2luZyBMaW51eCwgdGhlIGZpcnN0IHBhdGNoIGluIHRoaXMgc2VyaWVzIGFs
bG93cyB0aGUgY2FsbCB0bw0KPj4+PiBzdWNjZWVkIGlmIE9fUEFUSCBpcyBh
bHNvIHNwZWNpZmllZC4NCj4+Pj4NCj4gDQo+Pj4NCj4+PiDCoMKgIE9fUEFU
SCAoc2luY2UgTGludXggMi42LjM5KQ0KPj4+IMKgwqDCoCBPYnRhaW4gYSBm
aWxlIGRlc2NyaXB0b3IgdGhhdCBjYW4gYmUgdXNlZCBmb3IgdHdvwqAgcHVy
cG9zZXM6wqAgdG8NCj4+PiDCoMKgwqAgaW5kaWNhdGUgYSBsb2NhdGlvbiBp
biB0aGUgZmlsZXN5c3RlbSB0cmVlIGFuZCB0byBwZXJmb3JtIG9wZXJh4oCQ
DQo+Pj4gwqDCoMKgIHRpb25zIHRoYXQgYWN0IHB1cmVseSBhdCB0aGUgZmls
ZSBkZXNjcmlwdG9ywqAgbGV2ZWwuwqDCoCBUaGXCoCBmaWxlDQo+Pj4gwqDC
oMKgIGl0c2VsZsKgIGlzIG5vdCBvcGVuZWQsIGFuZCBvdGhlciBmaWxlIG9w
ZXJhdGlvbnMgKGUuZy4sIHJlYWQoMiksDQo+Pj4gwqDCoMKgIHdyaXRlKDIp
LCBmY2htb2QoMiksIGZjaG93bigyKSwgZmdldHhhdHRyKDIpLCBpb2N0bCgy
KSwgbW1hcCgyKSkNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgXl5eXl5eXl5eDQo+Pj4gwqDCoMKgIGZh
aWwgd2l0aCB0aGUgZXJyb3IgRUJBREYuDQo+Pj4gwqDCoMKgIF5eXl5eXl5e
XsKgwqDCoMKgwqDCoMKgwqDCoMKgIF5eXl5eDQo+Pj4NCj4gDQo+IE9uIEJT
RCBzeXN0ZW1zLCB5b3UgYXJlIGFibGUgdG8gcnVuIGxjaG1vZCB0byBjaGFu
Z2UgcGVybWlzc2lvbnMgb24gYSBzeW1saW5rIA0KPiAod2l0aCBlZmZlY3Qg
b24gd2hvIGlzIGFibGUgdG8gZm9sbG93IHRoYXQgc3ltbGluayBkdXJpbmcg
cGF0aG5hbWUgcmVzb2x1dGlvbik7IA0KPiBMaW51eCBkb2VzIG5vdCBzdXBw
b3J0IHRoYXQsIGFuZCBQT1NJWCBkb2VzIG5vdCBtYW5kYXRlIHN1cHBvcnQg
Zm9yIHRoYXQsIHNvIA0KPiBmY2htb2RhdCgpIGlzIGFsbG93ZWQgdG8gZmFp
bCBvbiBzeW1saW5rcyBldmVuIHdoaWxlIGZjaG93bmF0KCkgaXMgcmVxdWly
ZWQgdG8gDQo+IHdvcmsgb24gc3ltbGlua3MuDQo+IA0KPj4+IFRoYXQnZCBm
cm9tIHRoZSBjdXJyZW50IEYzMSBtYW4gcGFnZXMuDQo+Pj4NCj4+Pj4gQW0g
SSBtaXNzaW5nIHNvbWV0aGluZz8NCj4+Pg0KPj4+IEdvb2QgcXVlc3Rpb24u
wqAgTGV0IG1lIGFzayBpbiByZXR1cm4sIGRpZCAqSSogbm93IG1pc3Mgc29t
ZXRoaW5nPw0KPj4NCj4+IEkgZG9uJ3QgdGhpbmsgc28uwqAgSSB0aGluayB3
ZSBhZ3JlZSwgYWx0aG91Z2ggbWF5YmUgSSBkaWRuJ3QgZXhwcmVzcyBteXNl
bGYNCj4+IGNsZWFybHkgZW5vdWdoIGZvciB0aGF0IHRvIGJlIG9idmlvdXMu
wqAgV2hhdCBjb25mdXNlZCBtZSB3YXMgdGhlIGZvbGxvd2luZw0KPj4gcGFy
YWdyYXBoIGZ1cnRoZXIgZG93biBpbiB0aGUgb3BlbigyKSBtYW4gcGFnZSAo
c3RpbGwgZGlzY3Vzc2luZyBPX1BBVEgpOg0KPj4NCj4+IMKgwqDCoCBJZiBw
YXRobmFtZSBpcyBhIHN5bWJvbGljIGxpbmsgYW5kIHRoZSBPX05PRk9MTE9X
IGZsYWcgaXMgYWxzbw0KPj4gwqDCoMKgIHNwZWNpZmllZCwgdGhlbiB0aGUg
Y2FsbCByZXR1cm5zIGEgZmlsZSBkZXNjcmlwdG9yIHJlZmVycmluZw0KPj4g
wqDCoMKgIHRvIHRoZSBzeW1ib2xpYyBsaW5rLsKgIFRoaXMgZmlsZSBkZXNj
cmlwdG9yIGNhbiBiZSB1c2VkIGFzIHRoZQ0KPj4gwqDCoMKgIGRpcmZkIGFy
Z3VtZW50IGluIGNhbGxzIHRvIGZjaG93bmF0KDIpLCBmc3RhdGF0KDIpLCBs
aW5rYXQoMiksDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXl5eXl5eXl5eXl4NCj4+
IMKgwqDCoCBhbmQgcmVhZGxpbmthdCgyKSB3aXRoIGFuIGVtcHR5IHBhdGhu
YW1lIHRvIGhhdmUgdGhlIGNhbGxzDQo+PiDCoMKgwqAgb3BlcmF0ZSBvbiB0
aGUgc3ltYm9saWMgbGluay4NCj4+DQo+PiBJIGRvbid0IGtub3cgd2h5IHRo
ZXkgaW5jbHVkZSBmY2hvd25hdCBoZXJlLCBzaW5jZSB0aGUgcmVzdWx0aW5n
IGNhbGwgd291bGQgZmFpbA0KPj4gd2l0aCBFQkFERi7CoCBTbyBJIGRpZG4n
dCBpbXBsZW1lbnQgdGhhdCBpbiBteSBwYXRjaCBzZXJpZXMuDQo+IA0KPiBJ
J20gbm90IHN1cmUgaWYgdGhlIHF1ZXN0aW9uIGhlcmUgaXMgYWJvdXQgZmNo
b3duYXQoKSAod2hlcmUgeW91IENBTiBjaGFuZ2UgDQo+IG93bmVyIG9mIGEg
c3ltbGluayBvbiBMaW51eCwgc2FtZSBhcyB3aXRoIGxjaG93bigpKQ0KDQpZ
ZXMsIHRoZSBxdWVzdGlvbiBpcyBhYm91dCBmY2hvd25hdC4gIEFyZSB5b3Ug
c2F5aW5nIHlvdSBjYW4gY2hhbmdlIHRoZSBvd25lciANCmV2ZW4gaWYgdGhl
IHN5bWxpbmsgd2FzIG9wZW5lZCB3aXRoIE9fUEFUSD8NCg0KS2VuDQo=
