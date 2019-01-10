Return-Path: <cygwin-patches-return-9192-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 92991 invoked by alias); 10 Jan 2019 18:36:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 92574 invoked by uid 89); 10 Jan 2019 18:36:26 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,MIME_BASE64_BLANKS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=H*M:7fc2, Hx-languages-length:1420, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: NAM05-DM3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr730111.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) (40.107.73.111) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 10 Jan 2019 18:36:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=S3Bk0yU2LoBAClmg5s7DoaXHv+KurqKz5h4pmxmGx3U=; b=mPh5cWdQTcMxkSLblqjXdsg3B5k9NnCOw15STDb1NOD1VYBo0gtLKwlu5Bx2zaZAQQn0z5UfpxyHmx1eE8R+FL1Jsd1fv/JQ69lOoWUH+qqleyzJ5AFlSnSVTBURgbGZ6iuhmJY/Ol3etsIgqjjt+Z9SUCCFbRQYDiB4qs1xmX8=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB3817.namprd04.prod.outlook.com (20.176.86.30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1516.15; Thu, 10 Jan 2019 18:36:21 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::f04c:a357:7c28:14dc]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::f04c:a357:7c28:14dc%5]) with mapi id 15.20.1516.016; Thu, 10 Jan 2019 18:36:21 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: af_unix_spinlock_t: add initializer
Date: Thu, 10 Jan 2019 18:36:00 -0000
Message-ID: <3f1d89ac-a91a-e8c5-7fc2-61a8a30ecb3e@cornell.edu>
References: <20190110175635.16940-1-kbrown@cornell.edu> <20190110180253.GO593@calimero.vinschen.de>
In-Reply-To: <20190110180253.GO593@calimero.vinschen.de>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.4.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E64D6795FF9254A983A8F6781A185C9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-IsSubscribed: yes
X-SW-Source: 2019-q1/txt/msg00002.txt.bz2

T24gMS8xMC8yMDE5IDE6MDIgUE0sIENvcmlubmEgVmluc2NoZW4gd3JvdGU6
DQo+IE9uIEphbiAxMCAxNzo1NiwgS2VuIEJyb3duIHdyb3RlOg0KPj4gQWxz
byBmaXggYSB0eXBvLg0KPj4gLS0tDQo+PiAgIHdpbnN1cC9jeWd3aW4vZmhh
bmRsZXIuaCB8IDMgKystDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEv
d2luc3VwL2N5Z3dpbi9maGFuZGxlci5oIGIvd2luc3VwL2N5Z3dpbi9maGFu
ZGxlci5oDQo+PiBpbmRleCBkMDJiOWE5MTMuLjdlNDYwNzAxYyAxMDA2NDQN
Cj4+IC0tLSBhL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXIuaA0KPj4gKysrIGIv
d2luc3VwL2N5Z3dpbi9maGFuZGxlci5oDQo+PiBAQCAtODMyLDkgKzgzMiwx
MCBAQCBjbGFzcyBmaGFuZGxlcl9zb2NrZXRfbG9jYWw6IHB1YmxpYyBmaGFu
ZGxlcl9zb2NrZXRfd3NvY2sNCj4+ICAgLyogU2hhcmFibGUgc3BpbmxvY2sg
d2l0aCBsb3cgQ1BVIHByb2ZpbGUuICBUaGVzZSBsb2NrcyBhcmUgTk9UIHJl
Y3Vyc2l2ZSEgKi8NCj4+ICAgY2xhc3MgYWZfdW5peF9zcGlubG9ja190DQo+
PiAgIHsNCj4+IC0gIExPTkcgIGxvY2tlZDsgICAgICAgICAgLyogMCBvZGVy
IDEgKi8NCj4+ICsgIExPTkcgIGxvY2tlZDsgICAgICAgICAgLyogMCBvciAx
ICovDQo+IA0KPiBIdWguDQo+IA0KPj4gICBwdWJsaWM6DQo+PiArICBhZl91
bml4X3NwaW5sb2NrX3QgKCkgOiBsb2NrZWQgKDApIHt9DQo+IA0KPiBXaHkg
ZG8gd2UgbmVlZCB0aGF0PyAgVGhlIHNwaW5sb2NrIGlzIGNyZWF0ZWQgYXMg
cGFydCBvZiBhIHNoYXJlZCBtZW0NCj4gcmVnaW9uIHdoaWNoIGdldHMgaW5p
dGlhbGl6ZWQgdG8gYWxsIHplcm8sIG5vPyAgT3IgZG8geW91IHBsYW4gdG8g
dXNlIGl0DQo+IG91dHNpZGUgb2YgdGhpcyBzY2VuYXJpbz8NCg0KQXQgdGhl
IG1vbWVudCBJJ20gdXNpbmcgaXQgaW4gdGhlIG5ldyBGSUZPIGNvZGUsIGFu
ZCBJJ20gbm90IHN1cmUgeWV0IHdoZXRoZXIgaXQgDQp3aWxsIGV2ZW50dWFs
bHkgYmUgaW4gc2hhcmVkIG1lbW9yeS4gIChVbnRpbCBJIGdldCB0aGluZ3Mg
d29ya2luZywgSSdtIA0KcG9zdHBvbmluZyB0aGlua2luZyBhYm91dCB3aGV0
aGVyIEkgbmVlZCBzaGFyZWQgbWVtb3J5LikNCg0KV291bGQgaXQgYmUgYmV0
dGVyIHRvIHVzZSBzb21lIG90aGVyIGtpbmQgb2Ygc3BpbmxvY2sgdW50aWwg
SSBrbm93IGZvciBzdXJlIHRoYXQgDQpJIG5lZWQgc2hhcmVkIG1lbW9yeT8g
IE15IG9ubHkgcmVhc29uIGZvciBjaG9vc2luZyBhZl91bml4X3NwaW5sb2Nr
X3QgaXMgdGhhdCBJIA0Kd2FzIGNvcHlpbmcgY29kZSBmcm9tIGZoYW5kbGVy
X3NvY2tldF91bml4LCBhbmQgdGhpcyBzYXZlZCBtZSB0aGUgdHJvdWJsZSBv
ZiANCmxlYXJuaW5nIGFib3V0IG90aGVyIGtpbmRzIG9mIHNwaW5sb2Nrcy4N
Cg0KS2VuDQo=
