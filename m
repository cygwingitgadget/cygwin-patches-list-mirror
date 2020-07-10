Return-Path: <David.Allsopp@cl.cam.ac.uk>
Received: from outmail149058.authsmtp.co.uk (outmail149058.authsmtp.co.uk
 [62.13.149.58])
 by sourceware.org (Postfix) with ESMTPS id 548F93857015
 for <cygwin-patches@cygwin.com>; Fri, 10 Jul 2020 18:31:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 548F93857015
Received: from mail-c237.authsmtp.com (mail-c237.authsmtp.com [62.13.128.237])
 by punt17.authsmtp.com. (8.15.2/8.15.2) with ESMTP id 06AIVFNk037526; 
 Fri, 10 Jul 2020 19:31:15 +0100 (BST)
 (envelope-from David.Allsopp@cl.cam.ac.uk)
Received: from romulus.metastack.com
 (26.77-31-62.static.virginmediabusiness.co.uk [62.31.77.26])
 (authenticated bits=0)
 by mail.authsmtp.com (8.15.2/8.15.2) with ESMTPSA id 06AIVDQT019601
 (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
 Fri, 10 Jul 2020 19:31:14 +0100 (BST)
 (envelope-from David.Allsopp@cl.cam.ac.uk)
Received: from remus.metastack.local
 (27.77-31-62.static.virginmediabusiness.co.uk [62.31.77.27])
 by romulus.metastack.com (8.14.2/8.14.2) with ESMTP id 06AIVCew002356
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
 Fri, 10 Jul 2020 19:31:12 +0100
Received: from Hermes.metastack.local (172.16.0.8) by Hermes.metastack.local
 (172.16.0.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 10 Jul
 2020 19:31:13 +0100
Received: from Hermes.metastack.local ([fe80::210d:d258:cd04:7b5a]) by
 Hermes.metastack.local ([fe80::210d:d258:cd04:7b5a%2]) with mapi id
 15.01.1979.003; Fri, 10 Jul 2020 19:31:13 +0100
From: David Allsopp <David.Allsopp@cl.cam.ac.uk>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: RE: [PATCH] Fix incorrect sign-extension of pointer in 32-bit acl
 __to_entry
Thread-Topic: [PATCH] Fix incorrect sign-extension of pointer in 32-bit acl
 __to_entry
Thread-Index: AdZWJQHHESV98qffT7qyu7zaVSI0DgAAgZpQABlPZQAAEDn7IP//+usA///fO7A=
Date: Fri, 10 Jul 2020 18:31:13 +0000
Message-ID: <9adcf190b395491da501825821366f52@metastack.com>
References: <001101d65627$6b726260$42572720$@cl.cam.ac.uk>
 <20200710083232.GD514059@calimero.vinschen.de>
 <17ec8f4865d648ab80d259266f315de7@metastack.com>
 <20200710155858.GG514059@calimero.vinschen.de>
In-Reply-To: <20200710155858.GG514059@calimero.vinschen.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.0.125]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.65 on 62.31.77.26
X-Server-Quench: 89414448-c2db-11ea-8a6b-8434971169dc
X-AuthReport-Spam: If SPAM / abuse - report it at:
 http://www.authsmtp.com/abuse
X-AuthRoute: OCd1ZAARAlZ5RRob BmUtCCtbTh09DhZI RxQKKE1TKxwUVhJU
 L0JGL0JXPR1GBEcA A3lxHghLUl1zWXN0 YgBSbA9cZgRIXRtp UVZORUxQEhpqBAMA
 SB4YI2AUA2QieH95 Y0ZjEHdeX0I0fU95 Q0pQEWUbNmU0On0e URUJagsFdlFXdhtG
 bll4VXILaDFUKBgV TUcABxkNFhVqYApU UkkMK1kVW1wGFSJ0 XBENG3AiDVEIQT4y
 KBpuLVBUBEEQNFk/ KxMgXxpDaVoYCxEW FkpJYmduEEUGcCct ERlLNQAA
X-Authentic-SMTP: 61633634383431.1024:7364
X-AuthFastPath: 0 (Was 255)
X-AuthSMTP-Origin: 62.31.77.26/25
X-AuthVirus-Status: No virus detected - but ensure you scan with your own
 anti-virus system.
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, KAM_SHORT, RCVD_IN_DNSWL_LOW, SPF_HELO_NONE,
 SPF_NONE, TXREP autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Fri, 10 Jul 2020 18:31:18 -0000

Q29yaW5uYSBWaW5zY2hlbiB3cm90ZToNCj4gT24gSnVsIDEwIDE1OjIyLCBEYXZpZCBBbGxzb3Bw
IHZpYSBDeWd3aW4tcGF0Y2hlcyB3cm90ZToNCj4gPiBDb3Jpbm5hIFZpbnNjaGVuIHdyb3RlOg0K
PiA+ID4gT24gSnVsICA5IDIwOjMwLCBEYXZpZCBBbGxzb3BwIHZpYSBDeWd3aW4tcGF0Y2hlcyB3
cm90ZToNCj4gPiA+ID4gSSBoYXZlIHNvbWUgY29kZSB3aGVyZSB0aGUgYWNsX3QgcmV0dXJuZWQg
YnkgZ2V0X2ZpbGVfYWNsIGlzDQo+ID4gPiA+IGFsbG9jYXRlZCBhdCAweDgwMDM4MjQ4LiBBcyBh
IHJlc3VsdCB0aGUgYWNsX2VudHJ5X3QgZ2VuZXJhdGVkIGJ5DQo+ID4gPiA+IGFjbF9nZXRfZW50
cnkgaGFzIGFuICJpbmRleCIgb2YgLTEsIHNpbmNlIHRoZSBwb2ludGVyIHdhcyBzaWduLQ0KPiBl
eHRlbmRlZCB0byA2NC1iaXRzLg0KPiA+ID4gPg0KPiA+ID4gPiBNeSBmaXggaXMgdHJpdmlhbCBh
bmQgc2ltcGx5IGNhc3RzIHRoZSBwb2ludGVyIHRvIHVpbnRwdHJfdCBmaXJzdC4NCj4gPiA+DQo+
ID4gPiBQdXNoZWQuICBJIHN0aWxsIGRvbid0IHF1aXRlIHVuZGVyc3RhbmQgd2hhdCB0aGUgY29t
cGlsZXIgaXMNCj4gPiA+IHRoaW5raW5nIHRoZXJlLCBzaWduLWV4dGVuZGluZyBhIHBvaW50ZXIg
d2hlbiBjYXN0ZWQgdG8gYW4gdW5zaWdlbmQNCj4gPiA+IGludCB0eXBlLCBidXQgeW91ciBwYXRj
aCB3b3Jrcywgc28gYWxsIGlzIHdlbGwsIEkgZ3Vlc3MuDQo+ID4NCj4gPiBUaGFuayB5b3UgLSBp
dCBpcyBpbmRlZWQgaGFyZCB0byBpbWFnaW5lIHdoZW4geW91J2QgZXZlciB3YW50IHRoYXQNCj4g
YmVoYXZpb3VyIQ0KPiANCj4gSSB3b25kZXIgaWYgdGhpcyBpcyBhIGJ1ZyBpbiB4ODYgZ2NjLi4u
IEpvbj8NCg0KSSBwdXQgaXQgdG8gb3VyIEMgZ3VydXMgaW4gdGhlIE9DYW1sIHRlYW0gLSBvbmUg
KHdobyBoYXMgYWxzbyB3cml0dGVuIGEgZm9ybWFsbHkgdmVyaWZpZWQgQyBjb21waWxlciB3aGlj
aCBvbiBwdXJwb3NlIDAtZXh0ZW5kcyBpbiB0aGlzIGNhc2UpIG9ic2VydmVkIHRoYXQgR0NDIGRv
ZXMgdGhlIHNhbWUgZm9yIEFSTTMyIGFuZCBhbm90aGVyICh3aG8gaGFzIG9jY2FzaW9uYWxseSBk
ZWxpZ2h0ZWQgaW4gYWJ1c2luZyBsYW5ndWFnZSBtZW1vcnkgbW9kZWxzIHRvIGNvbmNvY3QgaGln
aGx5IGJpemFycmUsIGJ1dCBsZWdhbCwgYWJ1c2VzIG9mIHVuZGVmaW5lZCBiZWhhdmlvdXIpIGZv
dW5kIGh0dHBzOi8vZ2NjLmdudS5vcmcvb25saW5lZG9jcy9nY2MvQXJyYXlzLWFuZC1wb2ludGVy
cy1pbXBsZW1lbnRhdGlvbi5odG1sLi4uIGFsdGhvdWdoIHRoZSBHaXQgaGlzdG9yeSBmb3IgR0ND
IG1ha2VzIGl0IGZhaXJseSBjbGVhciB0aGF0IHRoaXMgYmVoYXZpb3VyIGlzIHJldHJvc3BlY3Rp
dmVseSBkb2N1bWVudGVkWzFdWzJdIQ0KDQoNCkRhdmlkDQoNCg0KWzFdIGh0dHBzOi8vZ2l0aHVi
LmNvbS9nY2MtbWlycm9yL2djYy9jb21taXQvY2JmNGMzNmZhMzczDQpbMl0gaHR0cHM6Ly9naXRo
dWIuY29tL2djYy1taXJyb3IvZ2NjL2NvbW1pdC81OGY0ZGU0ZjI3MWMNCg==
