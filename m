Return-Path: <cygwin-patches-return-9439-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 127961 invoked by alias); 7 Jun 2019 18:05:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 127865 invoked by uid 89); 7 Jun 2019 18:05:33 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-21.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,MIME_BASE64_BLANKS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=succeeds, HX-Languages-Length:2419
X-HELO: NAM04-SN1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr700115.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) (40.107.70.115) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 07 Jun 2019 18:05:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=vf27mvROqq7+v+W64vRspyxa536MmS6mAEvwBe0kz30=; b=Ef9J1HStscATcxZ6KoTLVpfSFVQgkeNZX0oMsTefWYw+E3GO6J6zuWhfLHq9O7qJfUfGF4l4tcrXID0Is5rHonSCT3R8tPUWASwNFXXgNkoltz+FxZ8H3DbHjAsd0ubRJlpPQlmFZmFbQiZeym8o1WeJdCc6fnvynjISeHXVax4=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB4313.namprd04.prod.outlook.com (20.176.77.22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.14; Fri, 7 Jun 2019 18:05:27 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::510a:3a42:f346:a4d8]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::510a:3a42:f346:a4d8%7]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019 18:05:27 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH draft v2 1/6] Cygwin: fhandler_pipe: derive from fhandler_base
Date: Fri, 07 Jun 2019 18:05:00 -0000
Message-ID: <20190607180511.46369-2-kbrown@cornell.edu>
References: <20190607180511.46369-1-kbrown@cornell.edu>
In-Reply-To: <20190607180511.46369-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:127;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00149.txt.bz2

UHJldmlvdXNseSBmaGFuZGxlcl9waXBlIHdhcyBkZXJpdmVkIGZyb20gZmhh
bmRsZXJfYmFzZV9vdmVybGFwcGVkLA0Kd2hpY2ggd2UgYXJlIGdvaW5nIHRv
IHJlbW92ZSBpbiBhIGZ1dHVyZSBjb21taXQuICBNYWtlIG1pbmltYWwgY2hh
bmdlcw0Kc28gdGhhdCB0aGUgYnVpbGQgc3RpbGwgc3VjY2VlZHMuDQotLS0N
CiB3aW5zdXAvY3lnd2luL2ZoYW5kbGVyLmggICAgICAgfCAgNSArKy0tLQ0K
IHdpbnN1cC9jeWd3aW4vZmhhbmRsZXJfcGlwZS5jYyB8IDExICsrKysrLS0t
LS0tDQogMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDkgZGVs
ZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL2ZoYW5k
bGVyLmggYi93aW5zdXAvY3lnd2luL2ZoYW5kbGVyLmgNCmluZGV4IGYyNDRm
MzQ4Ni4uYmRmZTRhMjcyIDEwMDY0NA0KLS0tIGEvd2luc3VwL2N5Z3dpbi9m
aGFuZGxlci5oDQorKysgYi93aW5zdXAvY3lnd2luL2ZoYW5kbGVyLmgNCkBA
IC0xMTg3LDE0ICsxMTg3LDE0IEBAIHB1YmxpYzoNCiAgIGZyaWVuZCBEV09S
RCBXSU5BUEkgZmx1c2hfYXN5bmNfaW8gKHZvaWQgKik7DQogfTsNCiANCi1j
bGFzcyBmaGFuZGxlcl9waXBlOiBwdWJsaWMgZmhhbmRsZXJfYmFzZV9vdmVy
bGFwcGVkDQorY2xhc3MgZmhhbmRsZXJfcGlwZTogcHVibGljIGZoYW5kbGVy
X2Jhc2UNCiB7DQogcHJpdmF0ZToNCiAgIHBpZF90IHBvcGVuX3BpZDsNCisg
IHNpemVfdCBtYXhfYXRvbWljX3dyaXRlOw0KIHB1YmxpYzoNCiAgIGZoYW5k
bGVyX3BpcGUgKCk7DQogDQotDQogICBib29sIGlzcGlwZSgpIGNvbnN0IHsg
cmV0dXJuIHRydWU7IH0NCiANCiAgIHZvaWQgc2V0X3BvcGVuX3BpZCAocGlk
X3QgcGlkKSB7cG9wZW5fcGlkID0gcGlkO30NCkBAIC0xMjIxLDcgKzEyMjEs
NiBAQCBwdWJsaWM6DQogICB7DQogICAgIHgtPnBjLmZyZWVfc3RyaW5ncyAo
KTsNCiAgICAgKnJlaW50ZXJwcmV0X2Nhc3Q8ZmhhbmRsZXJfcGlwZSAqPiAo
eCkgPSAqdGhpczsNCi0gICAgcmVpbnRlcnByZXRfY2FzdDxmaGFuZGxlcl9w
aXBlICo+ICh4KS0+YXRvbWljX3dyaXRlX2J1ZiA9IE5VTEw7DQogICAgIHgt
PnJlc2V0ICh0aGlzKTsNCiAgIH0NCiANCmRpZmYgLS1naXQgYS93aW5zdXAv
Y3lnd2luL2ZoYW5kbGVyX3BpcGUuY2MgYi93aW5zdXAvY3lnd2luL2ZoYW5k
bGVyX3BpcGUuY2MNCmluZGV4IGVkYmFkZWQ2OC4uMmVhNjlmOGVkIDEwMDY0
NA0KLS0tIGEvd2luc3VwL2N5Z3dpbi9maGFuZGxlcl9waXBlLmNjDQorKysg
Yi93aW5zdXAvY3lnd2luL2ZoYW5kbGVyX3BpcGUuY2MNCkBAIC0yMSw3ICsy
MSw3IEBAIGRldGFpbHMuICovDQogI2luY2x1ZGUgInNoYXJlZF9pbmZvLmgi
DQogDQogZmhhbmRsZXJfcGlwZTo6ZmhhbmRsZXJfcGlwZSAoKQ0KLSAgOiBm
aGFuZGxlcl9iYXNlX292ZXJsYXBwZWQgKCksIHBvcGVuX3BpZCAoMCkNCisg
IDogZmhhbmRsZXJfYmFzZSAoKSwgcG9wZW5fcGlkICgwKQ0KIHsNCiAgIG1h
eF9hdG9taWNfd3JpdGUgPSBERUZBVUxUX1BJUEVCVUZTSVpFOw0KICAgbmVl
ZF9mb3JrX2ZpeHVwICh0cnVlKTsNCkBAIC01NCw5ICs1NCw4IEBAIGZoYW5k
bGVyX3BpcGU6OmluaXQgKEhBTkRMRSBmLCBEV09SRCBhLCBtb2RlX3QgbW9k
ZSwgaW50NjRfdCB1bmlxX2lkKQ0KICAgc2V0X2lubyAodW5pcV9pZCk7DQog
ICBzZXRfdW5pcXVlX2lkICh1bmlxX2lkIHwgISEobW9kZSAmIEdFTkVSSUNf
V1JJVEUpKTsNCiAgIGlmIChvcGVuZWRfcHJvcGVybHkpDQotICAgIHNldHVw
X292ZXJsYXBwZWQgKCk7DQotICBlbHNlDQotICAgIGRlc3Ryb3lfb3Zlcmxh
cHBlZCAoKTsNCisgICAgLyogLi4uICovDQorICAgIDsNCiAgIHJldHVybiAx
Ow0KIH0NCiANCkBAIC0xOTIsNyArMTkxLDcgQEAgZmhhbmRsZXJfcGlwZTo6
ZHVwIChmaGFuZGxlcl9iYXNlICpjaGlsZCwgaW50IGZsYWdzKQ0KICAgZnRw
LT5zZXRfcG9wZW5fcGlkICgwKTsNCiANCiAgIGludCByZXM7DQotICBpZiAo
Z2V0X2hhbmRsZSAoKSAmJiBmaGFuZGxlcl9iYXNlX292ZXJsYXBwZWQ6OmR1
cCAoY2hpbGQsIGZsYWdzKSkNCisgIGlmIChnZXRfaGFuZGxlICgpICYmIGZo
YW5kbGVyX2Jhc2U6OmR1cCAoY2hpbGQsIGZsYWdzKSkNCiAgICAgcmVzID0g
LTE7DQogICBlbHNlDQogICAgIHJlcyA9IDA7DQpAQCAtMzU5LDcgKzM1OCw3
IEBAIGZoYW5kbGVyX3BpcGU6OmNyZWF0ZSAoZmhhbmRsZXJfcGlwZSAqZmhz
WzJdLCB1bnNpZ25lZCBwc2l6ZSwgaW50IG1vZGUpDQogICBpbnQgcmVzID0g
LTE7DQogICBpbnQ2NF90IHVuaXF1ZV9pZDsNCiANCi0gIGludCByZXQgPSBj
cmVhdGUgKHNhLCAmciwgJncsIHBzaXplLCBOVUxMLCBGSUxFX0ZMQUdfT1ZF
UkxBUFBFRCwgJnVuaXF1ZV9pZCk7DQorICBpbnQgcmV0ID0gY3JlYXRlIChz
YSwgJnIsICZ3LCBwc2l6ZSwgTlVMTCwgMCwgJnVuaXF1ZV9pZCk7DQogICBp
ZiAocmV0KQ0KICAgICBfX3NldGVycm5vX2Zyb21fd2luX2Vycm9yIChyZXQp
Ow0KICAgZWxzZSBpZiAoKGZoc1swXSA9IChmaGFuZGxlcl9waXBlICopIGJ1
aWxkX2ZoX2RldiAoKnBpcGVyX2RldikpID09IE5VTEwpDQotLSANCjIuMjEu
MA0KDQo=
