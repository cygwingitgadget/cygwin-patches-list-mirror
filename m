Return-Path: <cygwin-patches-return-9373-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26584 invoked by alias); 20 Apr 2019 18:59:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 26539 invoked by uid 89); 20 Apr 2019 18:59:00 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-22.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,MIME_BASE64_BLANKS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=execing, connect
X-HELO: NAM02-SN1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr770120.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) (40.107.77.120) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 20 Apr 2019 18:58:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=b5bXiB6bYElkzoqQ9FKMZUB+c+az4LiRTMYM2scgHQs=; b=Prlfsb5Izw3bXDW5OaWOCQAuiHXd5nou7gIosZNUx1b4mbU0sloW4vLDxTwtzy9B5JiNhHWH7Y5rxVvYan2C/OiCdSL3GYJhMQCjnyB6qxhBmuyQs6CWObLgD1SQm0McYi1hJzdUMvULrQu9j9bzqyJR9UD7bt1K68JK83fnGqg=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB5113.namprd04.prod.outlook.com (20.176.111.158) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1813.16; Sat, 20 Apr 2019 18:58:51 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c%2]) with mapi id 15.20.1813.013; Sat, 20 Apr 2019 18:58:51 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 5/5] Cygwin: FIFO: stop the listen_client thread before fork/exec
Date: Sat, 20 Apr 2019 18:59:00 -0000
Message-ID: <20190420185834.4228-6-kbrown@cornell.edu>
References: <20190420185834.4228-1-kbrown@cornell.edu>
In-Reply-To: <20190420185834.4228-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00080.txt.bz2

QWRkIG1ldGhvZHMgbmVlZF9maXh1cF9iZWZvcmUsIGluaXRfZml4dXBfYmVm
b3JlLCBhbmQNCmZpeHVwX2JlZm9yZV9mb3JrX2V4ZWMgdG8gYWNjb21wbGlz
aCB0aGlzLiAgU3RvcHBpbmcgdGhlIHRocmVhZCBtYWtlcw0Kc3VyZSB0aGF0
IHRoZSBjbGllbnQgaGFuZGxlciBsaXN0cyBvZiB0aGUgcGFyZW50IGFuZCBj
aGlsZCByZW1haW4gaW4NCnN5bmMgd2hpbGUgdGhlIGZvcmtpbmcvZXhlY2lu
ZyBpcyBpbiBwcm9ncmVzcy4NCi0tLQ0KIHdpbnN1cC9jeWd3aW4vZmhhbmRs
ZXIuaCAgICAgICB8ICAzICsrKw0KIHdpbnN1cC9jeWd3aW4vZmhhbmRsZXJf
Zmlmby5jYyB8IDE1ICsrKysrKysrKysrKystLQ0KIDIgZmlsZXMgY2hhbmdl
ZCwgMTYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAt
LWdpdCBhL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXIuaCBiL3dpbnN1cC9jeWd3
aW4vZmhhbmRsZXIuaA0KaW5kZXggZGEwMDdlZTQ1Li4wZGYyNWFhNDAgMTAw
NjQ0DQotLS0gYS93aW5zdXAvY3lnd2luL2ZoYW5kbGVyLmgNCisrKyBiL3dp
bnN1cC9jeWd3aW4vZmhhbmRsZXIuaA0KQEAgLTEzMDAsNiArMTMwMCw5IEBA
IHB1YmxpYzoNCiAgIHZvaWQgX19yZWczIHJhd19yZWFkICh2b2lkICpwdHIs
IHNpemVfdCYgdWxlbik7DQogICBzc2l6ZV90IF9fcmVnMyByYXdfd3JpdGUg
KGNvbnN0IHZvaWQgKnB0ciwgc2l6ZV90IHVsZW4pOw0KICAgYm9vbCBhcm0g
KEhBTkRMRSBoKTsNCisgIGJvb2wgbmVlZF9maXh1cF9iZWZvcmUgKCkgY29u
c3QgeyByZXR1cm4gcmVhZGVyOyB9DQorICBpbnQgZml4dXBfYmVmb3JlX2Zv
cmtfZXhlYyAoRFdPUkQpIHsgcmV0dXJuIHN0b3BfbGlzdGVuX2NsaWVudCAo
KTsgfQ0KKyAgdm9pZCBpbml0X2ZpeHVwX2JlZm9yZSAoKTsNCiAgIHZvaWQg
Zml4dXBfYWZ0ZXJfZm9yayAoSEFORExFKTsNCiAgIHZvaWQgZml4dXBfYWZ0
ZXJfZXhlYyAoKTsNCiAgIGludCBfX3JlZzIgZnN0YXR2ZnMgKHN0cnVjdCBz
dGF0dmZzICpidWYpOw0KZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vZmhh
bmRsZXJfZmlmby5jYyBiL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXJfZmlmby5j
Yw0KaW5kZXggM2VlMzA3YmNjLi45Yjk0YTZkYTkgMTAwNjQ0DQotLS0gYS93
aW5zdXAvY3lnd2luL2ZoYW5kbGVyX2ZpZm8uY2MNCisrKyBiL3dpbnN1cC9j
eWd3aW4vZmhhbmRsZXJfZmlmby5jYw0KQEAgLTUyMiw3ICs1MjIsMTAgQEAg
ZmhhbmRsZXJfZmlmbzo6b3BlbiAoaW50IGZsYWdzLCBtb2RlX3QpDQogCSAg
Z290byBvdXQ7DQogCX0NCiAgICAgICBlbHNlDQotCXJlcyA9IHN1Y2Nlc3M7
DQorCXsNCisJICBpbml0X2ZpeHVwX2JlZm9yZSAoKTsNCisJICByZXMgPSBz
dWNjZXNzOw0KKwl9DQogICAgIH0NCiANCiAgIC8qIElmIHdlJ3JlIHdyaXRp
bmcsIHdhaXQgZm9yIHJlYWRfcmVhZHkgYW5kIHRoZW4gY29ubmVjdCB0byB0
aGUNCkBAIC03NTIsNyArNzU1LDcgQEAgZmhhbmRsZXJfZmlmbzo6cmF3X3Jl
YWQgKHZvaWQgKmluX3B0ciwgc2l6ZV90JiBsZW4pDQogew0KICAgc2l6ZV90
IG9yaWdfbGVuID0gbGVuOw0KIA0KLSAgLyogU3RhcnQgdGhlIGxpc3Rlbl9j
bGllbnQgdGhyZWFkIGlmIG5lY2Vzc2FyeSAoZS5nLiwgYWZ0ZXIgZHVwIG9y
IGZvcmspLiAqLw0KKyAgLyogU3RhcnQgdGhlIGxpc3Rlbl9jbGllbnQgdGhy
ZWFkIGlmIG5lY2Vzc2FyeSAoZS5nLiwgYWZ0ZXIgZm9yayBvciBleGVjKS4g
Ki8NCiAgIGlmICghbGlzdGVuX2NsaWVudF90aHIgJiYgIWxpc3Rlbl9jbGll
bnQgKCkpDQogICAgIGdvdG8gZXJyb3V0Ow0KIA0KQEAgLTkzNCwxMCArOTM3
LDE4IEBAIGZoYW5kbGVyX2ZpZm86OmR1cCAoZmhhbmRsZXJfYmFzZSAqY2hp
bGQsIGludCBmbGFncykNCiAgIGZoZi0+Zmlmb19jbGllbnRfdW5sb2NrICgp
Ow0KICAgaWYgKCFyZWFkZXIgfHwgZmhmLT5saXN0ZW5fY2xpZW50ICgpKQ0K
ICAgICByZXQgPSAwOw0KKyAgaWYgKHJlYWRlcikNCisgICAgZmhmLT5pbml0
X2ZpeHVwX2JlZm9yZSAoKTsNCiBvdXQ6DQogICByZXR1cm4gcmV0Ow0KIH0N
CiANCit2b2lkDQorZmhhbmRsZXJfZmlmbzo6aW5pdF9maXh1cF9iZWZvcmUg
KCkNCit7DQorICBjeWdoZWFwLT5mZHRhYi5pbmNfbmVlZF9maXh1cF9iZWZv
cmUgKCk7DQorfQ0KKw0KIHZvaWQNCiBmaGFuZGxlcl9maWZvOjpmaXh1cF9h
ZnRlcl9mb3JrIChIQU5ETEUgcGFyZW50KQ0KIHsNCi0tIA0KMi4xNy4wDQoN
Cg==
