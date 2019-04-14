Return-Path: <cygwin-patches-return-9348-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 130638 invoked by alias); 14 Apr 2019 19:16:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 130559 invoked by uid 89); 14 Apr 2019 19:16:10 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-22.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,MIME_BASE64_BLANKS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=periods, retry
X-HELO: NAM05-DM3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr730131.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) (40.107.73.131) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 14 Apr 2019 19:16:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=cJsP7fRY0nimtYljPYE2pVZR910PZHX6gPggGbYqbJc=; b=aNWyEifkevrWryAQg1qnVp/dpxgMhpTqW5zP5QdWcqZcW6+M3jbevQ+eQpK7S+Xt1qYgt+bk1FjTpPWdVYua1t85D61l4Ty5/gBL4AiqGjTEqH3cg9ByaYWeGz+uviEBPJwHPt/SzVH8HHDibVZZ2/O4VTgcPCHnG8h9MqKRkco=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB3963.namprd04.prod.outlook.com (20.176.87.20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1792.19; Sun, 14 Apr 2019 19:16:02 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c%2]) with mapi id 15.20.1792.018; Sun, 14 Apr 2019 19:16:02 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 10/14] Cygwin: FIFO: use a retry loop when opening a writer
Date: Sun, 14 Apr 2019 19:16:00 -0000
Message-ID: <20190414191543.3218-11-kbrown@cornell.edu>
References: <20190414191543.3218-1-kbrown@cornell.edu>
In-Reply-To: <20190414191543.3218-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00054.txt.bz2

VGhlcmUgbWF5IGJlIHNob3J0IHBlcmlvZHMgd2hlbiB0aGVyZSdzIG5vIHBp
cGUgaW5zdGFuY2UgYXZhaWxhYmxlLg0KS2VlcCB0cnlpbmcuDQotLS0NCiB3
aW5zdXAvY3lnd2luL2ZoYW5kbGVyX2ZpZm8uY2MgfCA1MiArKysrKysrKysr
KysrKysrKysrKy0tLS0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDMx
IGluc2VydGlvbnMoKyksIDIxIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0
IGEvd2luc3VwL2N5Z3dpbi9maGFuZGxlcl9maWZvLmNjIGIvd2luc3VwL2N5
Z3dpbi9maGFuZGxlcl9maWZvLmNjDQppbmRleCA0NzkwMjFlOGUuLmQ0ZDJi
Mzg4MyAxMDA2NDQNCi0tLSBhL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXJfZmlm
by5jYw0KKysrIGIvd2luc3VwL2N5Z3dpbi9maGFuZGxlcl9maWZvLmNjDQpA
QCAtMzAsNiArMzAsMTIgQEAgU1RBVFVTX1BJUEVfRU1QVFkgc2ltcGx5IG1l
YW5zIHRoZXJlJ3Mgbm8gZGF0YSB0byBiZSByZWFkLiAqLw0KIAkJICAgfHwg
X3MgPT0gU1RBVFVTX1BJUEVfQlJPS0VOIFwNCiAJCSAgIHx8IF9zID09IFNU
QVRVU19QSVBFX0VNUFRZOyB9KQ0KIA0KKyNkZWZpbmUgU1RBVFVTX1BJUEVf
Tk9fSU5TVEFOQ0VfQVZBSUxBQkxFKHN0YXR1cykJXA0KKwkJKHsgTlRTVEFU
VVMgX3MgPSAoc3RhdHVzKTsgXA0KKwkJICAgX3MgPT0gU1RBVFVTX0lOU1RB
TkNFX05PVF9BVkFJTEFCTEUgXA0KKwkJICAgfHwgX3MgPT0gU1RBVFVTX1BJ
UEVfTk9UX0FWQUlMQUJMRSBcDQorCQkgICB8fCBfcyA9PSBTVEFUVVNfUElQ
RV9CVVNZOyB9KQ0KKw0KIGZoYW5kbGVyX2ZpZm86OmZoYW5kbGVyX2ZpZm8g
KCk6DQogICBmaGFuZGxlcl9iYXNlICgpLCByZWFkX3JlYWR5IChOVUxMKSwg
d3JpdGVfcmVhZHkgKE5VTEwpLA0KICAgbGlzdGVuX2NsaWVudF90aHIgKE5V
TEwpLCBsY3RfdGVybWluYXRpb25fZXZ0IChOVUxMKSwgbmhhbmRsZXJzICgw
KSwNCkBAIC01NDMsMjggKzU0OSwzMiBAQCBmaGFuZGxlcl9maWZvOjpvcGVu
IChpbnQgZmxhZ3MsIG1vZGVfdCkNCiAgICAgIGxpc3Rlbl9jbGllbnQgdGhy
ZWFkIGlzIHJ1bm5pbmcuICBUaGVuIHNpZ25hbCB3cml0ZV9yZWFkeS4gICov
DQogICBpZiAod3JpdGVyKQ0KICAgICB7DQotICAgICAgaWYgKCF3YWl0IChy
ZWFkX3JlYWR5KSkNCi0Jew0KLQkgIHJlcyA9IGVycm9yX2Vycm5vX3NldDsN
Ci0JICBnb3RvIG91dDsNCi0JfQ0KLSAgICAgIE5UU1RBVFVTIHN0YXR1cyA9
IG9wZW5fcGlwZSAoKTsNCi0gICAgICBpZiAoIU5UX1NVQ0NFU1MgKHN0YXR1
cykpDQotCXsNCi0JICBkZWJ1Z19wcmludGYgKCJjcmVhdGUgb2Ygd3JpdGVy
IGZhaWxlZCIpOw0KLQkgIF9fc2V0ZXJybm9fZnJvbV9udF9zdGF0dXMgKHN0
YXR1cyk7DQotCSAgcmVzID0gZXJyb3JfZXJybm9fc2V0Ow0KLQkgIGdvdG8g
b3V0Ow0KLQl9DQotICAgICAgZWxzZSBpZiAoIWFybSAod3JpdGVfcmVhZHkp
KQ0KKyAgICAgIHdoaWxlICgxKQ0KIAl7DQotCSAgcmVzID0gZXJyb3Jfc2V0
X2Vycm5vOw0KLQkgIGdvdG8gb3V0Ow0KLQl9DQotICAgICAgZWxzZQ0KLQl7
DQotCSAgc2V0X3BpcGVfbm9uX2Jsb2NraW5nIChnZXRfaGFuZGxlICgpLCB0
cnVlKTsNCi0JICByZXMgPSBzdWNjZXNzOw0KKwkgIGlmICghd2FpdCAocmVh
ZF9yZWFkeSkpDQorCSAgICB7DQorCSAgICAgIHJlcyA9IGVycm9yX2Vycm5v
X3NldDsNCisJICAgICAgZ290byBvdXQ7DQorCSAgICB9DQorCSAgTlRTVEFU
VVMgc3RhdHVzID0gb3Blbl9waXBlICgpOw0KKwkgIGlmIChOVF9TVUNDRVNT
IChzdGF0dXMpKQ0KKwkgICAgew0KKwkgICAgICBzZXRfcGlwZV9ub25fYmxv
Y2tpbmcgKGdldF9oYW5kbGUgKCksIHRydWUpOw0KKwkgICAgICBpZiAoIWFy
bSAod3JpdGVfcmVhZHkpKQ0KKwkJcmVzID0gZXJyb3Jfc2V0X2Vycm5vOw0K
KwkgICAgICBlbHNlDQorCQlyZXMgPSBzdWNjZXNzOw0KKwkgICAgICBnb3Rv
IG91dDsNCisJICAgIH0NCisJICBlbHNlIGlmIChTVEFUVVNfUElQRV9OT19J
TlNUQU5DRV9BVkFJTEFCTEUgKHN0YXR1cykpDQorCSAgICBTbGVlcCAoMSk7
DQorCSAgZWxzZQ0KKwkgICAgew0KKwkgICAgICBkZWJ1Z19wcmludGYgKCJj
cmVhdGUgb2Ygd3JpdGVyIGZhaWxlZCIpOw0KKwkgICAgICBfX3NldGVycm5v
X2Zyb21fbnRfc3RhdHVzIChzdGF0dXMpOw0KKwkgICAgICByZXMgPSBlcnJv
cl9lcnJub19zZXQ7DQorCSAgICAgIGdvdG8gb3V0Ow0KKwkgICAgfQ0KIAl9
DQogICAgIH0NCiBvdXQ6DQotLSANCjIuMTcuMA0KDQo=
