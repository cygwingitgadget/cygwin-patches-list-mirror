Return-Path: <cygwin-patches-return-9547-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 107783 invoked by alias); 6 Aug 2019 12:09:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 107767 invoked by uid 89); 6 Aug 2019 12:09:21 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM02-SN1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr770095.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) (40.107.77.95) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 06 Aug 2019 12:09:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=UdabI+lPHE4NsBgGlOfcIOvJmVsPE6XLlJmfmYjrhmyrcz7c8XQwbQCCpID1HTaPNscvCu+mQj+r63ZnXqUSg7VqWf+gqm1dInrao+jSKwofYHzehDuivy5N9wSEsTlRNiUKcM5GykUFRMlCsp8+Z/Cn3LCWHBR30mXAHb42Ow+8Devs4M4TNQXPXvuhq7sekVg5UsntSSzKQRuzMFd2OD8HmARAYvMr4vH6flk7xlg6jSo5n8a0/W9aqnL21K1ptfM+GOQd4Boqmqvn5wrO6l1V0HVp6VhvgL8mMK8Fg1MGAdMBoEUMtedsQILDFz0DtiO5zJ8D8XDDDxbR1Rpatw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=nSQ4mpa2pBO+otZcUTU6lnUgM5FFd25dJgyKvCbtoLs=; b=aWAmDptwASFN4ATmAwAvMfcjov/ORWQMqyphuQ5N+mSHfCVxeLdRrAApxyKFQot1TgWkhejDtwHz4jppJGy3zmoIPIojWnBGIVylyCYG6vkYxrJslf2rNyAmbM5Tgag9omlr9cI/2KciehpXXSCavqriYnrifSfdWzH06fUEer8e00i9tD2bA3K2nLtKHmQlxuz92e/4ZtiTjOowfdjGj/YDcogBRVkhnjM8AbACc01KLv+kgIc/XqQ/jJkGrgq8OxC2PdVpZSqh3CwtXYsqZuogSrdqn+LhJ6pUnE54S4Z3LtWR68+caGaMFapj9DpCDtIlv1D/m9VUz9NdD17RKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass smtp.mailfrom=cornell.edu;dmarc=pass action=none header.from=cornell.edu;dkim=pass header.d=cornell.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=nSQ4mpa2pBO+otZcUTU6lnUgM5FFd25dJgyKvCbtoLs=; b=U0/6WRBi9NFnjC4ZOEk/BXD1pdb1/RDtsaOrOd6Kzii+wlUguyzHiDmYdWbpZxwpsPVObgS6aiQdsW9C0e0BeVmdMiECLPbn/2aitVvIw9AM4p3DVXKO8MWH6+3F9zV8l7+KK+KfkMCE5VXeJQ9w6eo+7TybN1GJ/gpd+6BATvY=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB5305.namprd04.prod.outlook.com (20.178.26.18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2136.13; Tue, 6 Aug 2019 12:09:17 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cdc1:727:b526:d28e]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cdc1:727:b526:d28e%7]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019 12:09:17 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: exec: check execute bit prior to evaluating script
Date: Tue, 06 Aug 2019 12:09:00 -0000
Message-ID: <b545f4f8-f890-7877-0a00-9634ad369e5f@cornell.edu>
References: <20190806085354.14996-1-corinna@vinschen.de>
In-Reply-To: <20190806085354.14996-1-corinna@vinschen.de>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.8.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-exchange-purlcount: 1
x-ms-oob-tlc-oobclassifiers: OLM:5797;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <D49E4EFDBD193A45A8D2C8CE4D5EF7A5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00067.txt.bz2

T24gOC82LzIwMTkgNDo1MyBBTSwgQ29yaW5uYSBWaW5zY2hlbiB3cm90ZToN
Cj4gRnJvbTogQ29yaW5uYSBWaW5zY2hlbiA8Y29yaW5uYS1jeWd3aW5AY3ln
d2luLmNvbT4NCj4gDQo+IFdoZW4gdGhlIGV4ZWMgZmFtaWx5IG9mIGZ1bmN0
aW9ucyBpcyBjYWxsZWQgZm9yIGEgc2NyaXB0LWxpa2UNCj4gZmlsZSwgdGhl
IGF2OjpzZXR1cCBmdW5jdGlvbiBoYW5kbGVzIHRoZSBleGVjW3ZsXXAgY2Fz
ZSBhcw0KPiB3ZWxsLiAgVGhlIGV4ZWN2ZSBjYXNlIGZvciBmaWxlcyBub3Qg
c3RhcnRpbmcgd2l0aCBhIHNoZS1iYW5nDQo+IGlzIGhhbmRsZWQgZmlyc3Qg
YnkgcmV0dXJuaW5nIEVOT0VYRUMuICBPbmx5IGFmdGVyIHRoYXQsIHRoZQ0K
PiBmaWxlJ3MgZXhlY3V0YWJpbGl0eSBpcyBjaGVja2VkLg0KPiANCj4gVGhp
cyBsZWFkcyB0byB0aGUgcHJvYmxlbSB0aGF0IEVOT0VYRUMgaXMgcmV0dXJu
ZWQgZm9yIG5vbi1leGVjdXRhYmxlDQo+IGZpbGVzIGFzIHdlbGwuICBBIGNh
bGxpbmcgc2hlbGwgaW50ZXJwcmV0cyB0aGlzIGFzIGEgZmlsZSBpdCBzaG91
bGQgdHJ5DQo+IHRvIHJ1biBhcyBzY3JpcHQuICBUaGlzIGlzIG5vdCBkZXNp
cmVkIGZvciBub24tZXhlY3V0YWJsZSBmaWxlcy4NCj4gDQo+IEZpeCB0aGlz
IHByb2JsZW0gYnkgY2hlY2tpbmcgdGhlIGZpbGUgZm9yIGV4ZWN1dGFiaWxp
dHkgZmlyc3QuICBPbmx5DQo+IGFmdGVyIHRoYXQsIGZvbGxvdyB0aGUgb3Ro
ZXIgcG90ZW50aWFsIGNvZGUgcGF0aHMuDQo+IC0tLQ0KPiAgIHdpbnN1cC9j
eWd3aW4vc3Bhd24uY2MgfCAxMiArKysrKystLS0tLS0NCj4gICAxIGZpbGUg
Y2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vc3Bhd24uY2MgYi93aW5z
dXAvY3lnd2luL3NwYXduLmNjDQo+IGluZGV4IDdmN2FmNDQ0OWRhMS4uZDk1
NzcyODAyZjhmIDEwMDY0NA0KPiAtLS0gYS93aW5zdXAvY3lnd2luL3NwYXdu
LmNjDQo+ICsrKyBiL3dpbnN1cC9jeWd3aW4vc3Bhd24uY2MNCj4gQEAgLTEx
NzIsNiArMTE3MiwxMiBAQCBhdjo6c2V0dXAgKGNvbnN0IGNoYXIgKnByb2df
YXJnLCBwYXRoX2NvbnYmIHJlYWxfcGF0aCwgY29uc3QgY2hhciAqZXh0LA0K
PiAgIAkgIH0NCj4gICAJVW5tYXBWaWV3T2ZGaWxlIChidWYpOw0KPiAgICAg
anVzdF9zaGVsbDoNCj4gKwkvKiBDaGVjayBpZiBzY3JpcHQgaXMgZXhlY3V0
YWJsZS4gIE90aGVyd2lzZSB3ZSBzdGFydCBub24tZXhlY3V0YWJsZQ0KPiAr
CSAgIHNjcmlwdHMgc3VjY2Vzc2Z1bGx5LCB3aGljaCBpcyBpbmNvcnJlY3Qg
YmVoYXZpb3VyLiAqLw0KPiArCWlmIChyZWFsX3BhdGguaGFzX2FjbHMgKCkN
Cj4gKwkgICAgJiYgY2hlY2tfZmlsZV9hY2Nlc3MgKHJlYWxfcGF0aCwgWF9P
SywgdHJ1ZSkgPCAwKQ0KPiArCSAgcmV0dXJuIC0xOwkvKiBlcnJubyBpcyBh
bHJlYWR5IHNldC4gKi8NCj4gKw0KPiAgIAlpZiAoIXBnbSkNCj4gICAJICB7
DQo+ICAgCSAgICBpZiAoIXBfdHlwZV9leGVjKQ0KPiBAQCAtMTE4OCwxMiAr
MTE5NCw2IEBAIGF2OjpzZXR1cCAoY29uc3QgY2hhciAqcHJvZ19hcmcsIHBh
dGhfY29udiYgcmVhbF9wYXRoLCBjb25zdCBjaGFyICpleHQsDQo+ICAgCSAg
ICBhcmcxID0gTlVMTDsNCj4gICAJICB9DQo+ICAgDQo+IC0JLyogQ2hlY2sg
aWYgc2NyaXB0IGlzIGV4ZWN1dGFibGUuICBPdGhlcndpc2Ugd2Ugc3RhcnQg
bm9uLWV4ZWN1dGFibGUNCj4gLQkgICBzY3JpcHRzIHN1Y2Nlc3NmdWxseSwg
d2hpY2ggaXMgaW5jb3JyZWN0IGJlaGF2aW91ci4gKi8NCj4gLQlpZiAocmVh
bF9wYXRoLmhhc19hY2xzICgpDQo+IC0JICAgICYmIGNoZWNrX2ZpbGVfYWNj
ZXNzIChyZWFsX3BhdGgsIFhfT0ssIHRydWUpIDwgMCkNCj4gLQkgIHJldHVy
biAtMTsJLyogZXJybm8gaXMgYWxyZWFkeSBzZXQuICovDQo+IC0NCj4gICAJ
LyogUmVwbGFjZSBhcmd2WzBdIHdpdGggdGhlIGZ1bGwgcGF0aCB0byB0aGUg
c2NyaXB0IGlmIHRoaXMgaXMgdGhlDQo+ICAgCSAgIGZpcnN0IHRpbWUgdGhy
b3VnaCB0aGUgbG9vcC4gKi8NCj4gICAJcmVwbGFjZTBfbWF5YmUgKHByb2df
YXJnKTsNCg0KTEdUTSwgYW5kIEkndmUgY29uZmlybWVkIHRoYXQgaXQgZml4
ZXMgdGhlIHByb2JsZW0gcmVwb3J0ZWQgaW4gDQpodHRwOi8vd3d3LmN5Z3dp
bi5vcmcvbWwvY3lnd2luLzIwMTktMDgvbXNnMDAwNTQuaHRtbC4NCg0KS2Vu
DQo=
