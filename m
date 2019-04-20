Return-Path: <cygwin-patches-return-9372-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26302 invoked by alias); 20 Apr 2019 18:58:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 26238 invoked by uid 89); 20 Apr 2019 18:58:58 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-22.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,MIME_BASE64_BLANKS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=dup, 3716
X-HELO: NAM02-SN1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr770120.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) (40.107.77.120) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 20 Apr 2019 18:58:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=9+fGPJ03V+2snv790+R0UXxN+ZDhHqYSJwGr99ujvcE=; b=Ndohh/cVkDW6dxt9SxbzdTrGPl9zHEqY3tmCvFOf5Cad8aO2q5S0F2mkz+P2epUbDjyL3k4QfK+WQKFZ9AjvMHREUtyuIK6cT7NSksjMLC50qbIxFXLtZ6Zvx+YjGRkrA9ADWZ65prTbtiAxNOe5gM9bSDk5K8kfvQ6hdifaJd4=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB5113.namprd04.prod.outlook.com (20.176.111.158) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1813.16; Sat, 20 Apr 2019 18:58:50 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::21bb:c809:f459:845c%2]) with mapi id 15.20.1813.013; Sat, 20 Apr 2019 18:58:50 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 4/5] Cygwin: FIFO: close connect_evt handles as soon as possible
Date: Sat, 20 Apr 2019 18:58:00 -0000
Message-ID: <20190420185834.4228-5-kbrown@cornell.edu>
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
X-SW-Source: 2019-q2/txt/msg00079.txt.bz2

S2VlcGluZyB0aGVtIG9wZW4gdG9vIGxvbmcgY2FuIGNhdXNlIGFuIGF0dGVt
cHQgdG8gY2xvc2UgdGhlbSB0d2ljZQ0KYWZ0ZXIgYSBmb3JrIG9yIGV4ZWMu
DQotLS0NCiB3aW5zdXAvY3lnd2luL2ZoYW5kbGVyX2ZpZm8uY2MgfCAxNyAr
KysrKysrKysrLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRp
b25zKCspLCA3IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvd2luc3Vw
L2N5Z3dpbi9maGFuZGxlcl9maWZvLmNjIGIvd2luc3VwL2N5Z3dpbi9maGFu
ZGxlcl9maWZvLmNjDQppbmRleCAwZTRiZjNhZWUuLjNlZTMwN2JjYyAxMDA2
NDQNCi0tLSBhL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXJfZmlmby5jYw0KKysr
IGIvd2luc3VwL2N5Z3dpbi9maGFuZGxlcl9maWZvLmNjDQpAQCAtMzYzLDYg
KzM2Myw3IEBAIGZoYW5kbGVyX2ZpZm86Omxpc3Rlbl9jbGllbnRfdGhyZWFk
ICgpDQogCQkgIGJyZWFrOw0KIAkJfQ0KIAkgICAgfQ0KKwkgIEhBTkRMRSBl
dnQgPSBOVUxMOw0KIAkgIHN3aXRjaCAoc3RhdHVzKQ0KIAkgICAgew0KIAkg
ICAgY2FzZSBTVEFUVVNfU1VDQ0VTUzoNCkBAIC0zNzEsNiArMzcyLDkgQEAg
ZmhhbmRsZXJfZmlmbzo6bGlzdGVuX2NsaWVudF90aHJlYWQgKCkNCiAJICAg
ICAgZmMuc3RhdGUgPSBmY19jb25uZWN0ZWQ7DQogCSAgICAgIG5jb25uZWN0
ZWQrKzsNCiAJICAgICAgc2V0X3BpcGVfbm9uX2Jsb2NraW5nIChmYy5maC0+
Z2V0X2hhbmRsZSAoKSwgdHJ1ZSk7DQorCSAgICAgIGV2dCA9IEludGVybG9j
a2VkRXhjaGFuZ2VQb2ludGVyICgmZmMuY29ubmVjdF9ldnQsIE5VTEwpOw0K
KwkgICAgICBpZiAoZXZ0KQ0KKwkJQ2xvc2VIYW5kbGUgKGV2dCk7DQogCSAg
ICAgIGZpZm9fY2xpZW50X3VubG9jayAoKTsNCiAJICAgICAgYnJlYWs7DQog
CSAgICBjYXNlIFNUQVRVU19QSVBFX0xJU1RFTklORzoNCkBAIC00MDAsNiAr
NDA0LDggQEAgZmhhbmRsZXJfZmlmbzo6bGlzdGVuX2NsaWVudF90aHJlYWQg
KCkNCiAJfQ0KICAgICB9DQogb3V0Og0KKyAgaWYgKHJldCA8IDApDQorICAg
IGRlYnVnX3ByaW50ZiAoImV4aXRpbmcgbGN0IHdpdGggZXJyb3IsICVFIik7
DQogICBSZXNldEV2ZW50IChyZWFkX3JlYWR5KTsNCiAgIHJldHVybiByZXQ7
DQogfQ0KQEAgLTgyOSwxNCArODM1LDE1IEBAIGludA0KIGZpZm9fY2xpZW50
X2hhbmRsZXI6OmNsb3NlICgpDQogew0KICAgaW50IHJlcyA9IDA7DQorICBI
QU5ETEUgZXZ0ID0gSW50ZXJsb2NrZWRFeGNoYW5nZVBvaW50ZXIgKCZjb25u
ZWN0X2V2dCwgTlVMTCk7DQogDQorICBpZiAoZXZ0KQ0KKyAgICBDbG9zZUhh
bmRsZSAoZXZ0KTsNCiAgIGlmIChmaCkNCiAgICAgew0KICAgICAgIHJlcyA9
IGZoLT5maGFuZGxlcl9iYXNlOjpjbG9zZSAoKTsNCiAgICAgICBkZWxldGUg
Zmg7DQogICAgIH0NCi0gIGlmIChjb25uZWN0X2V2dCkNCi0gICAgQ2xvc2VI
YW5kbGUgKGNvbm5lY3RfZXZ0KTsNCiAgIHJldHVybiByZXM7DQogfQ0KIA0K
QEAgLTkxMywxMSArOTIwLDcgQEAgZmhhbmRsZXJfZmlmbzo6ZHVwIChmaGFu
ZGxlcl9iYXNlICpjaGlsZCwgaW50IGZsYWdzKQ0KICAgICAgIGlmICghRHVw
bGljYXRlSGFuZGxlIChHZXRDdXJyZW50UHJvY2VzcyAoKSwgZmNfaGFuZGxl
cltpXS5maC0+Z2V0X2hhbmRsZSAoKSwNCiAJCQkgICAgR2V0Q3VycmVudFBy
b2Nlc3MgKCksDQogCQkJICAgICZmaGYtPmZjX2hhbmRsZXJbaV0uZmgtPmdl
dF9oYW5kbGUgKCksDQotCQkJICAgIDAsIHRydWUsIERVUExJQ0FURV9TQU1F
X0FDQ0VTUykNCi0JICB8fCAhRHVwbGljYXRlSGFuZGxlIChHZXRDdXJyZW50
UHJvY2VzcyAoKSwgZmNfaGFuZGxlcltpXS5jb25uZWN0X2V2dCwNCi0JCQkg
ICAgICAgR2V0Q3VycmVudFByb2Nlc3MgKCksDQotCQkJICAgICAgICZmaGYt
PmZjX2hhbmRsZXJbaV0uY29ubmVjdF9ldnQsDQotCQkJICAgICAgIDAsIHRy
dWUsIERVUExJQ0FURV9TQU1FX0FDQ0VTUykpDQorCQkJICAgIDAsIHRydWUs
IERVUExJQ0FURV9TQU1FX0FDQ0VTUykpDQogCXsNCiAJICBDbG9zZUhhbmRs
ZSAoZmhmLT5yZWFkX3JlYWR5KTsNCiAJICBDbG9zZUhhbmRsZSAoZmhmLT53
cml0ZV9yZWFkeSk7DQotLSANCjIuMTcuMA0KDQo=
