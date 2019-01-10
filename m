Return-Path: <cygwin-patches-return-9194-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 79950 invoked by alias); 10 Jan 2019 23:20:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 79939 invoked by uid 89); 10 Jan 2019 23:20:54 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,MIME_BASE64_BLANKS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=
X-HELO: NAM05-DM3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr730127.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) (40.107.73.127) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 10 Jan 2019 23:20:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=cVL8qatG18SLq3hqQqqKTUsrcu+ZU/4nC03um82z1cc=; b=BVDcvVCq0mAviQdz3JhCvccSAAIcylduYVgIqiPC+cOipWVYwzKKQVjbhgbuTY88tRclah0BGNjk3e2Omouj+G1S01Dn2g3Pp+pMtUOiWYRf9jj1PuFA14x/Zi82KfDqi1D+dRTD7zvkjMxcH1Je/KDSbo2Sjmlax/cyI6rQpR8=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB4971.namprd04.prod.outlook.com (20.176.109.96) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1516.17; Thu, 10 Jan 2019 23:20:49 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::f04c:a357:7c28:14dc]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::f04c:a357:7c28:14dc%5]) with mapi id 15.20.1516.016; Thu, 10 Jan 2019 23:20:49 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: af_unix_spinlock_t: add initializer
Date: Thu, 10 Jan 2019 23:20:00 -0000
Message-ID: <bb133df2-d836-387e-6cd1-cbe6b6749e43@cornell.edu>
References: <20190110175635.16940-1-kbrown@cornell.edu> <20190110180253.GO593@calimero.vinschen.de> <3f1d89ac-a91a-e8c5-7fc2-61a8a30ecb3e@cornell.edu> <20190110201657.GP593@calimero.vinschen.de>
In-Reply-To: <20190110201657.GP593@calimero.vinschen.de>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.4.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1DBC453C1D0C148997204D2A883954D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-IsSubscribed: yes
X-SW-Source: 2019-q1/txt/msg00004.txt.bz2

T24gMS8xMC8yMDE5IDM6MTYgUE0sIENvcmlubmEgVmluc2NoZW4gd3JvdGU6
DQo+IE9uIEphbiAxMCAxODozNiwgS2VuIEJyb3duIHdyb3RlOg0KPj4gT24g
MS8xMC8yMDE5IDE6MDIgUE0sIENvcmlubmEgVmluc2NoZW4gd3JvdGU6DQo+
Pj4gT24gSmFuIDEwIDE3OjU2LCBLZW4gQnJvd24gd3JvdGU6DQo+Pj4+IEFs
c28gZml4IGEgdHlwby4NCj4+Pj4gLS0tDQo+Pj4+ICAgIHdpbnN1cC9jeWd3
aW4vZmhhbmRsZXIuaCB8IDMgKystDQo+Pj4+ICAgIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+Pj4NCj4+Pj4g
ZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXIuaCBiL3dpbnN1
cC9jeWd3aW4vZmhhbmRsZXIuaA0KPj4+PiBpbmRleCBkMDJiOWE5MTMuLjdl
NDYwNzAxYyAxMDA2NDQNCj4+Pj4gLS0tIGEvd2luc3VwL2N5Z3dpbi9maGFu
ZGxlci5oDQo+Pj4+ICsrKyBiL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXIuaA0K
Pj4+PiBAQCAtODMyLDkgKzgzMiwxMCBAQCBjbGFzcyBmaGFuZGxlcl9zb2Nr
ZXRfbG9jYWw6IHB1YmxpYyBmaGFuZGxlcl9zb2NrZXRfd3NvY2sNCj4+Pj4g
ICAgLyogU2hhcmFibGUgc3BpbmxvY2sgd2l0aCBsb3cgQ1BVIHByb2ZpbGUu
ICBUaGVzZSBsb2NrcyBhcmUgTk9UIHJlY3Vyc2l2ZSEgKi8NCj4+Pj4gICAg
Y2xhc3MgYWZfdW5peF9zcGlubG9ja190DQo+Pj4+ICAgIHsNCj4+Pj4gLSAg
TE9ORyAgbG9ja2VkOyAgICAgICAgICAvKiAwIG9kZXIgMSAqLw0KPj4+PiAr
ICBMT05HICBsb2NrZWQ7ICAgICAgICAgIC8qIDAgb3IgMSAqLw0KPj4+DQo+
Pj4gSHVoLg0KPj4+DQo+Pj4+ICAgIHB1YmxpYzoNCj4+Pj4gKyAgYWZfdW5p
eF9zcGlubG9ja190ICgpIDogbG9ja2VkICgwKSB7fQ0KPj4+DQo+Pj4gV2h5
IGRvIHdlIG5lZWQgdGhhdD8gIFRoZSBzcGlubG9jayBpcyBjcmVhdGVkIGFz
IHBhcnQgb2YgYSBzaGFyZWQgbWVtDQo+Pj4gcmVnaW9uIHdoaWNoIGdldHMg
aW5pdGlhbGl6ZWQgdG8gYWxsIHplcm8sIG5vPyAgT3IgZG8geW91IHBsYW4g
dG8gdXNlIGl0DQo+Pj4gb3V0c2lkZSBvZiB0aGlzIHNjZW5hcmlvPw0KPj4N
Cj4+IEF0IHRoZSBtb21lbnQgSSdtIHVzaW5nIGl0IGluIHRoZSBuZXcgRklG
TyBjb2RlLCBhbmQgSSdtIG5vdCBzdXJlIHlldCB3aGV0aGVyIGl0DQo+PiB3
aWxsIGV2ZW50dWFsbHkgYmUgaW4gc2hhcmVkIG1lbW9yeS4gIChVbnRpbCBJ
IGdldCB0aGluZ3Mgd29ya2luZywgSSdtDQo+PiBwb3N0cG9uaW5nIHRoaW5r
aW5nIGFib3V0IHdoZXRoZXIgSSBuZWVkIHNoYXJlZCBtZW1vcnkuKQ0KPj4N
Cj4+IFdvdWxkIGl0IGJlIGJldHRlciB0byB1c2Ugc29tZSBvdGhlciBraW5k
IG9mIHNwaW5sb2NrIHVudGlsIEkga25vdyBmb3Igc3VyZSB0aGF0DQo+PiBJ
IG5lZWQgc2hhcmVkIG1lbW9yeT8gIE15IG9ubHkgcmVhc29uIGZvciBjaG9v
c2luZyBhZl91bml4X3NwaW5sb2NrX3QgaXMgdGhhdCBJDQo+PiB3YXMgY29w
eWluZyBjb2RlIGZyb20gZmhhbmRsZXJfc29ja2V0X3VuaXgsIGFuZCB0aGlz
IHNhdmVkIG1lIHRoZSB0cm91YmxlIG9mDQo+PiBsZWFybmluZyBhYm91dCBv
dGhlciBraW5kcyBvZiBzcGlubG9ja3MuDQo+IA0KPiBUaGUgYWJvdmUgcGF0
Y2ggc2hvdWxkbid0IGh1cnQgaW4gdGhlIGxlYXN0IHNpbmNlIGl0J3Mgbm90
IHVzZWQgYW55d2F5DQo+IHdoZW4gYWxsb2NhdGluZyB0aGUgc2hhcmVkIG1l
bSByZWdpb24gdXNlZCBieSB0aGUgQUZfVU5JWCBzb2NrZXQgY29kZS4NCj4g
SWYgaXQgaGVscHMgeW91LCBJIGNhbiBwdXNoIGl0LCBubyBwcm9ibGVtLg0K
PiANCj4gSnVzdCBtYWtlIHN1cmUgdGhpcyBzcGlubG9jayBpcyB0aGUgcmln
aHQgdGhpbmcgZm9yIHlvdS4gIFRoZSBpZGVhIGhlcmUNCj4gd2FzIHRvIGhh
dmUgYSBmYXN0LCBzaGFyYWJsZSgqKSBsb2NrIHdpdGhvdXQgY29udGV4dCBz
d2l0Y2hpbmcsIG9ubHkNCj4gZ3VhcmRpbmcgc21hbGwgY29kZSBibG9ja3Mg
d2hpY2ggZG9uJ3QgaGFuZyBkdWUgdG8gcmVzb3VyY2Ugc3RhcnZpbmcuDQo+
IA0KPiBJZiB5b3UgaGF2ZSB0byBndWFyZCBtb3JlIGNvbXBsZXggY29kZSBj
aHVua3MsIGl0IG1pZ2h0IGJlIGJldHRlciB0bw0KPiB1c2UgYSBrZXJuZWwg
bG9ja2luZyBvYmplY3QgbGlrZSBtdXRleCBvciBzZW1hcGhvcmUuDQo+IA0K
PiANCj4gU28sIHB1c2ggb3Igbm8gcHVzaD8NCg0KUGxlYXNlIHB1c2guICBU
aGFua3MuDQoNCktlbg0K
