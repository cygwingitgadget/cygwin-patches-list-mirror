Return-Path: <cygwin-patches-return-9237-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 117596 invoked by alias); 26 Mar 2019 17:24:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 117585 invoked by uid 89); 26 Mar 2019 17:24:58 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.9 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=terminal, H*c:HHH
X-HELO: NAM03-BY2-obe.outbound.protection.outlook.com
Received: from mail-eopbgr780104.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) (40.107.78.104) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 26 Mar 2019 17:24:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=RhUW/pgY/DpxwpI8sRMtW4fQix+tAYFaxXE5vvLYnYc=; b=HZ0jUX7mABcY2BKBAz0XoRFfzAHB3HipzQsKRs8YKYYuYGhOTHKPzAyB/uR1thi+fXMGaZkbMW9gTWwx9YCgj4GluqD6+pvH3gq3ag7O+RGTxhFhnYsoPz6YthS21Q8UCG563yIVOtpN7DzsrfAFdR9b2HF4Zy9/oiff93SNZp4=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB5371.namprd04.prod.outlook.com (20.178.26.220) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1730.15; Tue, 26 Mar 2019 17:24:53 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::14fd:138e:c16b:52d]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::14fd:138e:c16b:52d%4]) with mapi id 15.20.1730.019; Tue, 26 Mar 2019 17:24:53 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH fifo 0/2] Add support for duplex FIFOs
Date: Tue, 26 Mar 2019 17:24:00 -0000
Message-ID: <1fc7ff06-38cf-6c89-03f4-e741f871b936@cornell.edu>
References: <20190325230556.2219-1-kbrown@cornell.edu> <20190326083620.GI3471@calimero.vinschen.de>
In-Reply-To: <20190326083620.GI3471@calimero.vinschen.de>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: multipart/mixed;	boundary="_003_1fc7ff0638cf6c8903f4e741f871b936cornelledu_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-IsSubscribed: yes
X-SW-Source: 2019-q1/txt/msg00047.txt.bz2


--_003_1fc7ff0638cf6c8903f4e741f871b936cornelledu_
Content-Type: text/plain; charset="utf-8"
Content-ID: <F436E2B8F24E1D4C9CF61E26153D0522@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Content-length: 1436

SGkgQ29yaW5uYSwNCg0KT24gMy8yNi8yMDE5IDQ6MzYgQU0sIENvcmlubmEg
Vmluc2NoZW4gd3JvdGU6DQo+IEhpIEtlbiwNCj4gDQo+IE9uIE1hciAyNSAy
MzowNiwgS2VuIEJyb3duIHdyb3RlOg0KPj4gVGhlIHNlY29uZCBwYXRjaCBp
biB0aGlzIHNlcmllcyBlbmFibGVzIG9wZW5pbmcgYSBGSUZPIHdpdGggT19S
RFdSDQo+PiBhY2Nlc3MuICBUaGUgdW5kZXJseWluZyBXaW5kb3dzIG5hbWVk
IHBpcGUgaXMgY3JldGVkIHdpdGggZHVwbGV4DQo+PiBhY2Nlc3MsIGFuZCBp
dHMgaGFuZGxlIGlzIG1hZGUgdGhlIEkvTyBoYW5kbGUgb2YgdGhlIGZpcnN0
IGNsaWVudC4NCj4+DQo+PiBXaGlsZSB0ZXN0aW5nIHRoaXMsIEkgaGFkIHNv
bWUgbXlzdGVyaW91cyBjcmFzaGVzLCB3aGljaCBhcmUgZml4ZWQgYnkNCj4+
IHRoZSBmaXJzdCBwYXRjaC4NCj4gDQo+IEkgcmViYXNlZCB0aGUgdG9waWMv
ZmlmbyBicmFuY2ggb24gdG9wIG9mIG1hc3RlciBhbmQgZm9yY2UtcHVzaGVk
IHdpdGgNCj4geW91ciBwYXRjaGVzLiAgTWFrZSBzdXJlIHRvIHJlc2V0IHlv
dXIgd29ya2luZyB0cmVlIHRvIG9yaWdpbi90b3BpYy9maWZvDQo+IGFuZCBh
ZGQgYW55IGZ1cnRoZXIgcGF0Y2hlcyBvbiB0b3AuDQoNCkknbSBjb21mb3J0
YWJsZSBub3cgd2l0aCBtZXJnaW5nIHRvcGljL2ZpZm8gaW50byBtYXN0ZXIu
ICBJJ3ZlIHRlc3RlZCB0aGUgbmV3IA0Kc2VsZWN0IGFuZCBmb3JrIGNvZGUg
WypdLCBhbmQgdGhleSBzZWVtIHRvIHdvcmsgYXMgZXhwZWN0ZWQuICBUaGF0
IHdhcyB0aGUgbGFzdCANCnRoaW5nIGhvbGRpbmcgbWUgdXAuDQoNCkFzIHNv
b24gYXMgdGhlIG1lcmdlIGlzIGRvbmUsIEknbGwgc2VuZCBhIHBhdGNoIHdp
dGggcmVsZWFzZSBub3Rlcy4NCg0KS2VuDQoNClsqXSBGb3IgdGhlIHJlY29y
ZCwgSSdtIGF0dGFjaGluZyB0aGUgdHdvIHRlc3QgcHJvZ3JhbXMgSSB1c2Vk
LiAgSW4gZWFjaCBjYXNlIEkgDQpyYW4gdGhlIHByb2dyYW0gaW4gb25lIHRl
cm1pbmFsIGFuZCB0eXBlZCAiZWNobyBibGFoID4gL3RtcC9teWZpZm8iIGlu
IGEgc2Vjb25kIA0KdGVybWluYWwuDQo=

--_003_1fc7ff0638cf6c8903f4e741f871b936cornelledu_
Content-Type: text/plain; name="fifo_fork_test.c"
Content-Description: fifo_fork_test.c
Content-Disposition: attachment; filename="fifo_fork_test.c"; size=1016;
	creation-date="Tue, 26 Mar 2019 17:24:53 GMT";
	modification-date="Tue, 26 Mar 2019 17:24:53 GMT"
Content-ID: <04A3EC7969DDDE4A811573E8A769E5FC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Content-length: 1379

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2luY2x1
ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8c3lzL3N0YXQuaD4KI2luY2x1ZGUg
PGZjbnRsLmg+CiNpbmNsdWRlIDxlcnJuby5oPgojaW5jbHVkZSA8c3lzL3dh
aXQuaD4KCmludAptYWluICgpCnsKICBpbnQgZmQ7CiAgc3NpemVfdCBuYnl0
ZXM7CiAgY2hhciBidWZbNV07CgogIGlmIChta2ZpZm8gKCIvdG1wL215Zmlm
byIsIFNfSVJVU1IgfCBTX0lXVVNSIHwgU19JV0dSUCkgPCAwCiAgICAgICYm
IGVycm5vICE9IEVFWElTVCkKICAgIHsKICAgICAgcGVycm9yICgibWtmaWZv
Iik7CiAgICAgIGV4aXQgKC0xKTsKICAgIH0KCiAgaWYgKChmZCA9IG9wZW4g
KCIvdG1wL215ZmlmbyIsIE9fUkRXUikpIDwgMCkKICAgIHsKICAgICAgcGVy
cm9yICgib3BlbiIpOwogICAgICBleGl0ICgtMSk7CiAgICB9CgogIHN3aXRj
aCAoZm9yayAoKSkKICAgIHsKICAgIGNhc2UgLTE6CiAgICAgIHBlcnJvciAo
ImZvcmsiKTsKICAgICAgZXhpdCAoLTEpOwogICAgY2FzZSAwOgkJCS8qIENo
aWxkLiAqLwogICAgICBuYnl0ZXMgPSByZWFkIChmZCwgYnVmLCA0KTsKICAg
ICAgaWYgKG5ieXRlcyAhPSA0KQoJewoJICBwZXJyb3IgKCJyZWFkIik7Cgkg
IGV4aXQgKC0xKTsKCX0KICAgICAgYnVmWzRdID0gJ1wwJzsKICAgICAgcHJp
bnRmICgiY2hpbGQgcmVhZCAlZCBieXRlczogJXNcbiIsIG5ieXRlcywgYnVm
KTsKICAgICAgaWYgKGNsb3NlIChmZCkgPCAwKQoJewoJICBwZXJyb3IgKCJj
aGlsZCBjbG9zZSIpOwoJICBleGl0ICgtMSk7Cgl9CiAgICAgIGV4aXQgKDAp
OwogICAgZGVmYXVsdDoJCQkvKiBQYXJlbnQuICovCiAgICAgIGlmIChjbG9z
ZSAoZmQpIDwgMCkKCXsKCSAgcGVycm9yICgicGFyZW50IGNsb3NlIik7Cgkg
IGV4aXQgKC0xKTsKCX0KICAgICAgcHJpbnRmICgicGFyZW50IHdhaXRpbmcg
Zm9yIGNoaWxkIHRvIHJlYWRcbiIpOwogICAgICB3YWl0IChOVUxMKTsKICAg
ICAgYnJlYWs7CiAgICB9Cn0KCiAgICAgIAo=

--_003_1fc7ff0638cf6c8903f4e741f871b936cornelledu_
Content-Type: text/plain; name="fifo_select_test.c"
Content-Description: fifo_select_test.c
Content-Disposition: attachment; filename="fifo_select_test.c"; size=1005;
	creation-date="Tue, 26 Mar 2019 17:24:53 GMT";
	modification-date="Tue, 26 Mar 2019 17:24:53 GMT"
Content-ID: <7A4B2E00E8A0E047ACAC3FC2CFA2434A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Content-length: 1363

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2luY2x1
ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8c3lzL3NlbGVjdC5oPgojaW5jbHVk
ZSA8c3lzL3N0YXQuaD4KI2luY2x1ZGUgPGZjbnRsLmg+CiNpbmNsdWRlIDxl
cnJuby5oPgoKaW50Cm1haW4gKCkKewogIGludCBmZCwgbmZkczsKICBmZF9z
ZXQgcmVhZGZkczsKICBzc2l6ZV90IG5ieXRlczsKICBjaGFyIGJ1Zls1XTsK
CiAgaWYgKG1rZmlmbyAoIi90bXAvbXlmaWZvIiwgU19JUlVTUiB8IFNfSVdV
U1IgfCBTX0lXR1JQKSA8IDAKICAgICAgJiYgZXJybm8gIT0gRUVYSVNUKQog
ICAgewogICAgICBwZXJyb3IgKCJta2ZpZm8iKTsKICAgICAgZXhpdCAoLTEp
OwogICAgfQoKICBpZiAoKGZkID0gb3BlbiAoIi90bXAvbXlmaWZvIiwgT19S
RE9OTFkpKSA8IDApCiAgICB7CiAgICAgIHBlcnJvciAoIm9wZW4iKTsKICAg
ICAgZXhpdCAoLTEpOwogICAgfQoKICBGRF9aRVJPICgmcmVhZGZkcyk7CiAg
RkRfU0VUIChmZCwgJnJlYWRmZHMpOwoKICBpZiAoKG5mZHMgPSBzZWxlY3Qg
KGZkICsgMSwgJnJlYWRmZHMsIE5VTEwsIE5VTEwsIE5VTEwpKSA8IDApCiAg
ICB7CiAgICAgIHBlcnJvciAoInNlbGVjdCIpOwogICAgICBleGl0ICgtMSk7
CiAgICB9CgogIGlmIChGRF9JU1NFVCAoZmQsICZyZWFkZmRzKSkKICAgIHBy
aW50ZiAoIi90bXAvbXlmaWZvIGlzIHJlYWR5IGZvciByZWFkaW5nXG4iKTsK
ICBlbHNlCiAgICBwcmludGYgKCJzb21ldGhpbmcncyB3cm9uZ1xuIik7CiAg
bmJ5dGVzID0gcmVhZCAoZmQsIGJ1ZiwgNCk7CiAgaWYgKG5ieXRlcyAhPSA0
KQogICAgewogICAgICBwZXJyb3IgKCJyZWFkIik7CiAgICAgIGV4aXQgKC0x
KTsKICAgIH0KICBidWZbNF0gPSAnXDAnOwogIHByaW50ZiAoInJlYWQgJWQg
Ynl0ZXM6ICVzXG4iLCBuYnl0ZXMsIGJ1Zik7CiAgaWYgKGNsb3NlIChmZCkg
PCAwKQogICAgewogICAgICBwZXJyb3IgKCJjbG9zZSIpOwogICAgICBleGl0
ICgtMSk7CiAgICB9Cn0K

--_003_1fc7ff0638cf6c8903f4e741f871b936cornelledu_--
