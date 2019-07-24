Return-Path: <cygwin-patches-return-9523-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 90727 invoked by alias); 24 Jul 2019 19:11:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 90715 invoked by uid 89); 24 Jul 2019 19:11:15 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-23.4 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SEM_URI,SEM_URIRED,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM05-CO1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr720134.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) (40.107.72.134) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 24 Jul 2019 19:11:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=iJxCMJBAA/is6v83svvZ5v4iOeESNWB7K6IS56yim8W5CEcjcRiF+sjLZX9fNPELevBjlNZOwxC21ywwFPplRBWD8Vq9xFIFgazsTIPXc/6I3PsBJglogIdtMoK+/0FoWMgiyaBK58fx99wmBtnpmfcuo/1kFK4OsxWPL2NltLDpachK+nMo+GmKLrRgofDlD4NEDFXxy50uKm0EsYxdLxndsgOCKlHJWfat6S3kF7GONhUWN6ePXg2/k/YuLpJdBDlx1RV+IeSQ0vT0iOhMQt7wnzcBVt+jAi7MbY1f8er9jFnf5zklDG4hQDG/+S1XKrwCvS0PtADB9h4Lf3wgKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=eehjAB+Ifi7Xq2Op4gFCCuUqH1dHGStZIWf1RHEKvqg=; b=DmH0PvxmFg8yGnNhmTdwzQtB22qCpuEQfl7HybMxzKoDkQZd0apKbKKTNsy56+wtL+Wan54BAsAwgtNma6IEuXw+zWB0Zcti6/QK2Q0DZji7kUssfrFlKsYz+gBqy6RIGlP+p3tZYOjnejCDDh1qYNsGY7KrJCP9Q0VAUHDDqApScpjN1iiG3AOS7T5FSaipvZNYgRT5j9CmlGxA9IH8b6+1/kfywaabNUMkxLrsMXyXEInVZA1slM9AL+0Qb4AcghRbEvlIuG0bMHdCbRXiM7L4tuWzm9GG4h6Iu9F3SpSEsSQSSTpj6P+A86UfdY5O8OwaiINcJ7Hfsh0TqbEObg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass smtp.mailfrom=cornell.edu;dmarc=pass action=none header.from=cornell.edu;dkim=pass header.d=cornell.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=eehjAB+Ifi7Xq2Op4gFCCuUqH1dHGStZIWf1RHEKvqg=; b=QbvYokKbwx3Zg5ai3a81xkvN5653/uX3R32Rn7rZBD4F1Orl9PZovfI0d6iUVDr4qjCpwluOsUK6tCfruGW4j3g8TeHL2uc7ZPTeaSwxdgWalXGVFou6tMRph9DguP/5aJZllfnSTokRBqkMcflGJCHpnvS0yyCcSWzrKb2i6Lo=
Received: from CY1PR04MB2300.namprd04.prod.outlook.com (10.167.10.148) by CY1PR04MB2299.namprd04.prod.outlook.com (10.166.205.145) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2115.10; Wed, 24 Jul 2019 19:11:11 +0000
Received: from CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8]) by CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8%8]) with mapi id 15.20.2094.017; Wed, 24 Jul 2019 19:11:10 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: Jon Turney <jon.turney@dronecode.org.uk>
Subject: Re: [PATCH v2] Cygwin: Fix the address of myself
Date: Wed, 24 Jul 2019 19:11:00 -0000
Message-ID: <22d165b6-2b4b-4e94-7bbf-77449b662e8a@cornell.edu>
References: <20190724162524.5604-1-corinna-cygwin@cygwin.com> <20190724165447.28339-1-corinna-cygwin@cygwin.com>
In-Reply-To: <20190724165447.28339-1-corinna-cygwin@cygwin.com>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.8.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:6790;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB0DB377DA3D0E42B89E8F668AE2C6A1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00043.txt.bz2

T24gNy8yNC8yMDE5IDEyOjU0IFBNLCBDb3Jpbm5hIFZpbnNjaGVuIHdyb3Rl
Og0KPiBGcm9tOiBDb3Jpbm5hIFZpbnNjaGVuIDxjb3Jpbm5hQHZpbnNjaGVu
LmRlPg0KPiANCj4gdjI6IHJlcGhyYXNlIGNvbW1pdCBtZXNzYWdlDQo+IA0K
PiBJbnRyb2R1Y2luZyBhbiBpbmRlcGVuZGVudCBDeWd3aW4gUElEIGludHJv
ZHVjZWQgYSByZWdyZXNzaW9uOg0KPiANCj4gVGhlIGV4cGVjdGF0aW9uIGlz
IHRoYXQgdGhlIG15c2VsZiBwaW5mbyBwb2ludGVyIGFsd2F5cyBwb2ludHMg
dG8gYQ0KPiBzcGVjaWZpYyBhZGRyZXNzIHJpZ2h0IGluIGZyb250IG9mIHRo
ZSBsb2FkZWQgQ3lnd2luIERMTC4NCj4gDQo+IEhvd2V2ZXIsIHRoZSBpbmRl
cGVuZGVudCBDeWd3aW4gUElEIGNoYW5nZXMgYnJva2UgdGhpcy4gIFRvIGNy
ZWF0ZQ0KPiBteXNlbGYgYXQgdGhlIHJpZ2h0IGFkZHJlc3MgcmVxdWlyZXMg
dG8gY2FsbCBpbml0IHdpdGggaDAgc2V0IHRvDQo+IElOVkFMSURfSEFORExF
X1ZBTFVFIG9yIGFuIGV4aXN0aW5nIGFkZHJlc3M6DQo+IA0KPiB2b2lkDQo+
IHBpbmZvOjppbml0IChwaWRfdCBuLCBEV09SRCBmbGFnLCBIQU5ETEUgaDAp
DQo+IHsNCj4gICAgWy4uLl0NCj4gICAgaWYgKCFoMCB8fCBteXNlbGYuaCkN
Cj4gICAgICBbLi4uXQ0KPiAgICBlbHNlDQo+ICAgICAgew0KPiAgICAgICAg
c2hsb2MgPSBTSF9NWVNFTEY7DQo+ICAgICAgICBpZiAoaDAgPT0gSU5WQUxJ
RF9IQU5ETEVfVkFMVUUpICAgICAgIDwtLSAhISENCj4gICAgICAgICAgaDAg
PSBOVUxMOw0KPiAgICAgIH0NCj4gDQo+IFRoZSBhZm9yZW1lbnRpb25lZCBj
b21taXRzIGNoYW5nZWQgdGhhdCBzbyBoMCB3YXMgYWx3YXlzIE5VTEwsIHRo
aXMgd2F5DQo+IGNyZWF0aW5nIG15c2VsZiBhdCBhbiBhcmJpdHJhcnkgYWRk
cmVzcy4NCj4gDQo+IFRoaXMgcGF0Y2ggbWFrZXMgc3VyZSB0byBzZXQgdGhl
IGhhbmRsZSB0byBJTlZBTElEX0hBTkRMRV9WQUxVRSBhZ2Fpbg0KPiB3aGVu
IGNyZWF0aW5nIGEgbmV3IHByb2Nlc3MsIHNvIGluaXQga25vd3MgdGhhdCBt
eXNlbGYgaGFzIHRvIGJlIGNyZWF0ZWQNCj4gaW4gdGhlIHJpZ2h0IHNwb3Qu
ICBXaGlsZSBhdCBpdCwgZml4IGEgcG90ZW50aWFsIHVuaW5pdGlhbGl6ZWQg
aGFuZGxlDQo+IHZhbHVlIGluIGNoaWxkX2luZm9fc3Bhd246OmhhbmRsZV9z
cGF3bi4NCj4gDQo+IEZpeGVzOiBiNWUxMDAzNzIyY2IgKCJDeWd3aW46IHBy
b2Nlc3NlczogdXNlIGRlZGljYXRlZCBDeWd3aW4gUElEIHJhdGhlciB0aGFu
IFdpbmRvd3MgUElEIikNCj4gRml4ZXM6IDg4NjA1MjQzYTE5YiAoIkN5Z3dp
bjogZml4IGNoaWxkIGdldHRpbmcgYW5vdGhlciBwaWQgYWZ0ZXIgc3Bhd252
ZSIpDQo+IFNpZ25lZC1vZmYtYnk6IENvcmlubmEgVmluc2NoZW4gPGNvcmlu
bmFAdmluc2NoZW4uZGU+DQo+IC0tLQ0KPiAgIHdpbnN1cC9jeWd3aW4vZGNy
dDAuY2MgfCAyICstDQo+ICAgd2luc3VwL2N5Z3dpbi9waW5mby5jYyB8IDMg
Ky0tDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dp
bi9kY3J0MC5jYyBiL3dpbnN1cC9jeWd3aW4vZGNydDAuY2MNCj4gaW5kZXgg
ZmI3MjZhNzM5Y2NmLi44NmFiNzI1NjQ4NGMgMTAwNjQ0DQo+IC0tLSBhL3dp
bnN1cC9jeWd3aW4vZGNydDAuY2MNCj4gKysrIGIvd2luc3VwL2N5Z3dpbi9k
Y3J0MC5jYw0KPiBAQCAtNjUyLDcgKzY1Miw3IEBAIHZvaWQNCj4gICBjaGls
ZF9pbmZvX3NwYXduOjpoYW5kbGVfc3Bhd24gKCkNCj4gICB7DQo+ICAgICBl
eHRlcm4gdm9pZCBmaXh1cF9sb2NrZl9hZnRlcl9leGVjIChib29sKTsNCj4g
LSAgSEFORExFIGg7DQo+ICsgIEhBTkRMRSBoID0gSU5WQUxJRF9IQU5ETEVf
VkFMVUU7DQo+ICAgICBpZiAoIWR5bmFtaWNhbGx5X2xvYWRlZCB8fCBnZXRf
cGFyZW50X2hhbmRsZSAoKSkNCj4gICAgICAgICB7DQo+ICAgCWN5Z2hlYXBf
Zml4dXBfaW5fY2hpbGQgKHRydWUpOw0KPiBkaWZmIC0tZ2l0IGEvd2luc3Vw
L2N5Z3dpbi9waW5mby5jYyBiL3dpbnN1cC9jeWd3aW4vcGluZm8uY2MNCj4g
aW5kZXggY2RiZDhiZDdlYWYzLi5iNjdkNjYwYWUwNGQgMTAwNjQ0DQo+IC0t
LSBhL3dpbnN1cC9jeWd3aW4vcGluZm8uY2MNCj4gKysrIGIvd2luc3VwL2N5
Z3dpbi9waW5mby5jYw0KPiBAQCAtNjIsMTEgKzYyLDEwIEBAIHBpbmZvOjp0
aGlzcHJvYyAoSEFORExFIGgpDQo+ICAgICAgIHsNCj4gICAgICAgICBjeWdo
ZWFwLT5waWQgPSBjcmVhdGVfY3lnd2luX3BpZCAoKTsNCj4gICAgICAgICBm
bGFncyB8PSBQSURfTkVXOw0KPiArICAgICAgaCA9IElOVkFMSURfSEFORExF
X1ZBTFVFOw0KPiAgICAgICB9DQo+ICAgICAvKiBzcGF3bnZlJ2QgcHJvY2Vz
cyBnb3QgcGlkIGluIHBhcmVudCwgY3lnaGVhcC0+cGlkIGhhcyBiZWVuIHNl
dCBpbg0KPiAgICAgICAgY2hpbGRfaW5mb19zcGF3bjo6aGFuZGxlX3NwYXdu
LiAqLw0KPiAtICBlbHNlIGlmIChoID09IElOVkFMSURfSEFORExFX1ZBTFVF
KQ0KPiAtICAgIGggPSBOVUxMOw0KPiAgIA0KPiAgICAgaW5pdCAoY3lnaGVh
cC0+cGlkLCBmbGFncywgaCk7DQo+ICAgICBwcm9jaW5mby0+cHJvY2Vzc19z
dGF0ZSB8PSBQSURfSU5fVVNFOw0KPiANCg0KSSdsbCBiZSBnbGFkIHRvIHRh
a2UgYSBjbG9zZSBsb29rIGF0IHRoaXMgYXMgeW91IGFza2VkLiAgQnV0IEkn
bSBub3QgZmFtaWxpYXIgDQp3aXRoIHRoaXMgcGFydCBvZiB0aGUgY29kZSwg
c28gaXQgd2lsbCB0YWtlIG1lIGEgbGl0dGxlIHRpbWUuDQoNCktlbg0K
