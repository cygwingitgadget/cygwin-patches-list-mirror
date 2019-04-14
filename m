Return-Path: <cygwin-patches-return-9345-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 130094 invoked by alias); 14 Apr 2019 19:16:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 130003 invoked by uid 89); 14 Apr 2019 19:16:07 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,MIME_BASE64_BLANKS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM05-DM3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr730117.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) (40.107.73.117) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 14 Apr 2019 19:16:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=O0eeWdZbmf4BHgN2HL4T+pdP0eb4fq0bnzfKqKkebFg=; b=rWfaV/zc1gmJbXFju2DKFHAwcI8h0XGRITay3hgYVAstV6UqlOqaa5WAWKfopxTCvFahBdhkjg6DJ5TCEtTo3gTxUDne9xO4QvEr0Zg0Hw9MI6xOGKdyLtMD6vR2l4TKQxatlhy42yU+x8jnbaZefPnbTzt6sbIYAjR190+XRvo=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB3963.namprd04.prod.outlook.com (20.176.87.20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1792.19; Sun, 14 Apr 2019 19:16:00 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c%2]) with mapi id 15.20.1792.018; Sun, 14 Apr 2019 19:16:00 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 07/14] Cygwin: FIFO: code simplification: don't overload get_handle
Date: Sun, 14 Apr 2019 19:16:00 -0000
Message-ID: <20190414191543.3218-8-kbrown@cornell.edu>
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
X-SW-Source: 2019-q2/txt/msg00050.txt.bz2

UmVuYW1lIGZoYW5kbGVyX2ZpZm86OmdldF9oYW5kbGUoaW50KSB0byBnZXRf
ZmNfaGFuZGxlKGludCksIGFuZA0KcmVtb3ZlIGZoYW5kbGVyX2ZpZm86Omdl
dF9oYW5kbGUodm9pZCkuDQotLS0NCiB3aW5zdXAvY3lnd2luL2ZoYW5kbGVy
LmggfCA3ICsrKystLS0NCiB3aW5zdXAvY3lnd2luL3NlbGVjdC5jYyAgfCAy
ICstDQogMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDQgZGVs
ZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL2ZoYW5k
bGVyLmggYi93aW5zdXAvY3lnd2luL2ZoYW5kbGVyLmgNCmluZGV4IDU5ZDlk
YWQxNi4uMWUyNmM2NTFmIDEwMDY0NA0KLS0tIGEvd2luc3VwL2N5Z3dpbi9m
aGFuZGxlci5oDQorKysgYi93aW5zdXAvY3lnd2luL2ZoYW5kbGVyLmgNCkBA
IC0xMjg0LDkgKzEyODQsMTAgQEAgcHVibGljOg0KICAgZmhhbmRsZXJfZmlm
byAoKTsNCiAgIGJvb2wgaGl0X2VvZiAoKTsNCiAgIGludCBnZXRfbmhhbmRs
ZXJzICgpIGNvbnN0IHsgcmV0dXJuIG5oYW5kbGVyczsgfQ0KLSAgSEFORExF
JiBnZXRfaGFuZGxlICgpIHsgcmV0dXJuIGZoYW5kbGVyX2Jhc2U6OmdldF9o
YW5kbGUgKCk7IH0NCi0gIEhBTkRMRSBnZXRfaGFuZGxlIChpbnQgaSkgY29u
c3QgeyByZXR1cm4gZmNfaGFuZGxlcltpXS5maC0+Z2V0X2hhbmRsZSAoKTsg
fQ0KLSAgYm9vbCBpc19jb25uZWN0ZWQgKGludCBpKSBjb25zdCB7IHJldHVy
biBmY19oYW5kbGVyW2ldLnN0YXRlID09IGZjX2Nvbm5lY3RlZDsgfQ0KKyAg
SEFORExFIGdldF9mY19oYW5kbGUgKGludCBpKSBjb25zdA0KKyAgeyByZXR1
cm4gZmNfaGFuZGxlcltpXS5maC0+Z2V0X2hhbmRsZSAoKTsgfQ0KKyAgYm9v
bCBpc19jb25uZWN0ZWQgKGludCBpKSBjb25zdA0KKyAgeyByZXR1cm4gZmNf
aGFuZGxlcltpXS5zdGF0ZSA9PSBmY19jb25uZWN0ZWQ7IH0NCiAgIFBVTklD
T0RFX1NUUklORyBnZXRfcGlwZV9uYW1lICgpOw0KICAgRFdPUkQgbGlzdGVu
X2NsaWVudF90aHJlYWQgKCk7DQogICB2b2lkIGZpZm9fY2xpZW50X2xvY2sg
KCkgeyBfZmlmb19jbGllbnRfbG9jay5sb2NrICgpOyB9DQpkaWZmIC0tZ2l0
IGEvd2luc3VwL2N5Z3dpbi9zZWxlY3QuY2MgYi93aW5zdXAvY3lnd2luL3Nl
bGVjdC5jYw0KaW5kZXggZDI1N2NjNGVkLi45Y2Y4OTI4MDEgMTAwNjQ0DQot
LS0gYS93aW5zdXAvY3lnd2luL3NlbGVjdC5jYw0KKysrIGIvd2luc3VwL2N5
Z3dpbi9zZWxlY3QuY2MNCkBAIC04NzUsNyArODc1LDcgQEAgcGVla19maWZv
IChzZWxlY3RfcmVjb3JkICpzLCBib29sIGZyb21fc2VsZWN0KQ0KICAgICAg
IGZvciAoaW50IGkgPSAwOyBpIDwgZmgtPmdldF9uaGFuZGxlcnMgKCk7IGkr
KykNCiAJaWYgKGZoLT5pc19jb25uZWN0ZWQgKGkpKQ0KIAkgIHsNCi0JICAg
IGludCBuID0gcGlwZV9kYXRhX2F2YWlsYWJsZSAocy0+ZmQsIGZoLCBmaC0+
Z2V0X2hhbmRsZSAoaSksDQorCSAgICBpbnQgbiA9IHBpcGVfZGF0YV9hdmFp
bGFibGUgKHMtPmZkLCBmaCwgZmgtPmdldF9mY19oYW5kbGUgKGkpLA0KIAkJ
CQkJIGZhbHNlKTsNCiAJICAgIGlmIChuID4gMCkNCiAJICAgICAgew0KLS0g
DQoyLjE3LjANCg0K
