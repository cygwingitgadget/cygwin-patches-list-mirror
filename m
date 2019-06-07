Return-Path: <cygwin-patches-return-9447-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 128148 invoked by alias); 7 Jun 2019 21:43:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 128137 invoked by uid 89); 7 Jun 2019 21:43:08 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-9.3 required=5.0 tests=AWL,BAYES_00,MIME_BASE64_BLANKS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,UNSUBSCRIBE_BODY autolearn=no version=3.3.1 spammy=Ken, hour, *think*, H*f:sk:d3a6fca
X-HELO: NAM03-DM3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr800097.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) (40.107.80.97) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 07 Jun 2019 21:43:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=y3Wgcn2G5AqaVGGmAY6OVxIzLJTxALSjFu/yk3t3ZcA=; b=WftTRid6mqTNQ7m+CnTXNLT0sI0W1I/zrMWfUYFPamffzLC5pQDJ2YYJmcBQj6WXzk9XXOmq7VwjDfXW/wGm4wZ8EkcrnZDgOzDQafRFyp+Hnp650eLY7T3ZA+e0iuWwKHoLdluX+7+cJLB7JFUrXWLE5WGtR/+lscdyXmiES+k=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB5834.namprd04.prod.outlook.com (20.179.50.19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1943.22; Fri, 7 Jun 2019 21:43:04 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::510a:3a42:f346:a4d8]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::510a:3a42:f346:a4d8%7]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019 21:43:04 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH draft 0/6] Remove the fhandler_base_overlapped class
Date: Fri, 07 Jun 2019 21:43:00 -0000
Message-ID: <b5a2e878-0282-d94e-92de-c4605dea4000@cornell.edu>
References: <20190526151019.2187-1-kbrown@cornell.edu> <826b6cd3-2fbc-0d8c-b665-2c9a797a18f3@cornell.edu> <20190603163519.GJ3437@calimero.vinschen.de> <dac74739-7b66-56cb-ca8a-acbca7877eba@cornell.edu> <874l51p7rt.fsf@Rainer.invalid> <d3a6fcad-69c3-e6e6-07fa-3311ec833c69@cornell.edu>
In-Reply-To: <d3a6fcad-69c3-e6e6-07fa-3311ec833c69@cornell.edu>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.7.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:9508;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E8657DE3CA62549B8241D4F621A41B5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00154.txt.bz2

T24gNi83LzIwMTkgMzoxMyBQTSwgS2VuIEJyb3duIHdyb3RlOg0KPiBPbiA2
LzcvMjAxOSAyOjMxIFBNLCBBY2hpbSBHcmF0eiB3cm90ZToNCj4+IEtlbiBC
cm93biB3cml0ZXM6DQo+Pj4gSSB0aGluayBJJ3ZlIGZvdW5kIHRoZSBwcm9i
bGVtLiAgSSB3YXMgbWlzaGFuZGxpbmcgc2lnbmFscyB0aGF0IGFycml2ZWQg
ZHVyaW5nIGENCj4+PiByZWFkLiAgQnV0IGFmdGVyIEkgZml4IHRoYXQsIHRo
ZXJlJ3Mgc3RpbGwgb25lIG5hZ2dpbmcgaXNzdWUgaW52b2x2aW5nIHRpbWVy
ZmQNCj4+PiBjb2RlLiAgSSdsbCB3cml0ZSB0byB0aGUgbWFpbiBsaXN0IHdp
dGggZGV0YWlscy4gIEkgKnRoaW5rKiBpdCdzIGEgdGltZXJmZCBidWcsDQo+
Pj4gYnV0IGl0J3MgcHV6emxpbmcgdGhhdCBJIG9ubHkgc2VlIGl0IHdoZW4g
dGVzdGluZyBteSBuZXcgcGlwZSBpbXBsZW1lbnRhdGlvbi4NCj4+DQo+PiBB
bnl0aGluZyB0cmlnZ2VyaW5nIGEgcmFjZSBvciBkZWFkbG9jayB3aWxsIGRl
cGVuZCBvbiBzbyBtYW55IG90aGVyDQo+PiB0aGluZ3MgdGhhdCBpdCByZWFs
bHkgaXMgbm8gc3VycHJpc2UgdG8gc2VlIHNlZW1pbmdseSB1bnJlbGF0ZWQg
Y2hhbmdlcw0KPj4gbWFraW5nIHRoZSBidWcgYXBwZWFyIG9yIGRpc2FwcGVh
ci4gIFRoZXJlIGFyZSBjZXJ0YWlubHkgcmFjZXMgbGVmdCBpbg0KPj4gQ3ln
d2luLCBJIHNlZSB0aGVtIGZyb20gdGltZSB0byB0aW1lIGluIHZhcmlvdXMg
UGVybCBtb2R1bGVzLCBqdXN0IG5ldmVyDQo+PiByZXByb2R1Y2libGUgZW5v
dWdoIHRvIGdpdmUgYW55b25lIGFuIGlkZWEgb2Ygd2hlcmUgdG8gbG9vay4N
Cj4gDQo+IFRoYXQgbWFrZXMgc2Vuc2UuDQo+IA0KPiBJbiB0aGUgbWVhbnRp
bWUsIEkndmUgYWxyZWFkeSBkaXNjb3ZlcmVkIGFub3RoZXIgcHJvYmxlbSwg
d2l0aGluIGFuIGhvdXIgb2YNCj4gcG9zdGluZyBteSBjbGFpbSB0aGF0IGV2
ZXJ5dGhpbmcgd2FzIHdvcmtpbmcgZmluZTogSWYgSSBzdGFydCBlbWFjcy1Y
MTEgd2l0aA0KPiBjeWdzZXJ2ZXIgcnVubmluZywgSSBjYW4ndCBmb3JrIGFu
eSBzdWJwcm9jZXNzZXMgd2l0aGluIGVtYWNzLiAgSSBnZXQNCj4gDQo+IDAg
W21haW5dIGVtYWNzIDI2ODkgZG9mb3JrOiBjaGlsZCAyNjkzIC0gZGllZCB3
YWl0aW5nIGZvciBkbGwgbG9hZGluZywgZXJybm8gMTENCj4gDQo+IEJhY2sg
dG8gdGhlIGRyYXdpbmcgYm9hcmQuLi4uICBJJ3ZlIG5ldmVyIGxvb2tlZCBh
dCB0aGUgY3lnc2VydmVyIGNvZGUsIGJ1dA0KPiBtYXliZSBpdCB3aWxsIHR1
cm4gb3V0IHRvIGJlIHNvbWV0aGluZyBlYXN5Lg0KDQpHb29kIG5ld3MgKGZv
ciBtZSk6IFRoaXMgaXNuJ3QgcmVsYXRlZCB0byBteSBwaXBlIGNvZGUuICBU
aGUgc2FtZSBwcm9ibGVtIG9jY3VycyANCmlmIEkgYnVpbGQgdGhlIG1hc3Rl
ciBicmFuY2guICBJJ2xsIGJpc2VjdCB3aGVuIEkgZ2V0IGEgY2hhbmNlIChw
cm9iYWJseSANCnRvbW9ycm93KS4gIEluIHRoZSBtZWFudGltZSwgYWxsIEkg
Y2FuIHNheSBpcyB0aGF0IHN0cmFjZSBzaG93cyBhIA0KU1RBVFVTX0FDQ0VT
U19WSU9MQVRJT04gYXQgc2htLmNjOjEyNS4NCg0KS2VuDQo=
