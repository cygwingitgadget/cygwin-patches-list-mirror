Return-Path: <David.Allsopp@cl.cam.ac.uk>
Received: from outmail148099.authsmtp.net (outmail148099.authsmtp.net
 [62.13.148.99])
 by sourceware.org (Postfix) with ESMTPS id 6E095385700D
 for <cygwin-patches@cygwin.com>; Fri, 10 Jul 2020 15:22:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 6E095385700D
Received: from mail-c237.authsmtp.com (mail-c237.authsmtp.com [62.13.128.237])
 by punt16.authsmtp.com. (8.15.2/8.15.2) with ESMTP id 06AFMGFG013339
 for <cygwin-patches@cygwin.com>;
 Fri, 10 Jul 2020 16:22:16 +0100 (BST)
 (envelope-from David.Allsopp@cl.cam.ac.uk)
Received: from romulus.metastack.com
 (26.77-31-62.static.virginmediabusiness.co.uk [62.31.77.26])
 (authenticated bits=0)
 by mail.authsmtp.com (8.15.2/8.15.2) with ESMTPSA id 06AFMFEl086784
 (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
 for <cygwin-patches@cygwin.com>; Fri, 10 Jul 2020 16:22:15 +0100 (BST)
 (envelope-from David.Allsopp@cl.cam.ac.uk)
Received: from remus.metastack.local
 (27.77-31-62.static.virginmediabusiness.co.uk [62.31.77.27])
 by romulus.metastack.com (8.14.2/8.14.2) with ESMTP id 06AFMEVj020866
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
 for <cygwin-patches@cygwin.com>; Fri, 10 Jul 2020 16:22:14 +0100
Received: from Hermes.metastack.local (172.16.0.8) by Hermes.metastack.local
 (172.16.0.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 10 Jul
 2020 16:22:15 +0100
Received: from Hermes.metastack.local ([fe80::210d:d258:cd04:7b5a]) by
 Hermes.metastack.local ([fe80::210d:d258:cd04:7b5a%2]) with mapi id
 15.01.1979.003; Fri, 10 Jul 2020 16:22:15 +0100
From: David Allsopp <David.Allsopp@cl.cam.ac.uk>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: RE: [PATCH] Fix incorrect sign-extension of pointer in 32-bit acl
 __to_entry
Thread-Topic: [PATCH] Fix incorrect sign-extension of pointer in 32-bit acl
 __to_entry
Thread-Index: AdZWJQHHESV98qffT7qyu7zaVSI0DgAAgZpQABlPZQAAEDn7IA==
Date: Fri, 10 Jul 2020 15:22:14 +0000
Message-ID: <17ec8f4865d648ab80d259266f315de7@metastack.com>
References: <001101d65627$6b726260$42572720$@cl.cam.ac.uk>
 <20200710083232.GD514059@calimero.vinschen.de>
In-Reply-To: <20200710083232.GD514059@calimero.vinschen.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.0.125]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.65 on 62.31.77.26
X-Server-Quench: 22f51576-c2c1-11ea-8a6b-8434971169dc
X-AuthReport-Spam: If SPAM / abuse - report it at:
 http://www.authsmtp.com/abuse
X-AuthRoute: OCd1ZAARAlZ5RRob BmUtCCtbTh09DhZI RxQKKE1TKxwUVhJa
 I0lFL1wWKFQATlFU QBZYEgMTCQNvCjwo JQtRcn8YPlVMXwdq QElPSFBQHgRtTxoD
 GB0fTB51aQdAZ3x1 ekcsXnYqKjkMABp9 SkhTHWlIZ2FoaS4d UhZddgZTdh4ZfExE
 d1F+ASIQaTQBNGdo Q1Rvbm9oZGsOJC9D eCxfZWEqaHogPgt0 aRESVTQpFkofXSg4
 M1Q9K1EaWUsBLkg0 KlomXxofPVcKDQxY A0xXSC5fbwJbAiAq EUtTVkp8WApqXSBr Dxs0OA4g
X-Authentic-SMTP: 61633634383431.1024:7364
X-AuthFastPath: 0 (Was 255)
X-AuthSMTP-Origin: 62.31.77.26/25
X-AuthVirus-Status: No virus detected - but ensure you scan with your own
 anti-virus system.
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Fri, 10 Jul 2020 15:22:19 -0000

Q29yaW5uYSBWaW5zY2hlbiB3cm90ZToNCj4gT24gSnVsICA5IDIwOjMwLCBEYXZpZCBBbGxzb3Bw
IHZpYSBDeWd3aW4tcGF0Y2hlcyB3cm90ZToNCj4gPiBJIGhhdmUgc29tZSBjb2RlIHdoZXJlIHRo
ZSBhY2xfdCByZXR1cm5lZCBieSBnZXRfZmlsZV9hY2wgaXMgYWxsb2NhdGVkDQo+ID4gYXQgMHg4
MDAzODI0OC4gQXMgYSByZXN1bHQgdGhlIGFjbF9lbnRyeV90IGdlbmVyYXRlZCBieSBhY2xfZ2V0
X2VudHJ5DQo+ID4gaGFzIGFuICJpbmRleCIgb2YgLTEsIHNpbmNlIHRoZSBwb2ludGVyIHdhcyBz
aWduLWV4dGVuZGVkIHRvIDY0LWJpdHMuDQo+ID4NCj4gPiBNeSBmaXggaXMgdHJpdmlhbCBhbmQg
c2ltcGx5IGNhc3RzIHRoZSBwb2ludGVyIHRvIHVpbnRwdHJfdCBmaXJzdC4NCj4gDQo+IFB1c2hl
ZC4gIEkgc3RpbGwgZG9uJ3QgcXVpdGUgdW5kZXJzdGFuZCB3aGF0IHRoZSBjb21waWxlciBpcyB0
aGlua2luZw0KPiB0aGVyZSwgc2lnbi1leHRlbmRpbmcgYSBwb2ludGVyIHdoZW4gY2FzdGVkIHRv
IGFuIHVuc2lnZW5kIGludCB0eXBlLCBidXQNCj4geW91ciBwYXRjaCB3b3Jrcywgc28gYWxsIGlz
IHdlbGwsIEkgZ3Vlc3MuDQoNClRoYW5rIHlvdSAtIGl0IGlzIGluZGVlZCBoYXJkIHRvIGltYWdp
bmUgd2hlbiB5b3UnZCBldmVyIHdhbnQgdGhhdCBiZWhhdmlvdXIhDQoNCldvdWxkIGl0IGJlIHBv
c3NpYmxlIHRvIGhhdmUgYSBzbmFwc2hvdCB3aXRoIGl0LCBqdXN0IGZvciBjb250aW51b3VzIGlu
dGVncmF0aW9uIHNlcnZlcnMgd2hpY2ggbmVlZCB0aGUgZml4LCBwbGVhc2U/DQoNCg0KRGF2aWQN
Cg==
