Return-Path: <cygwin-patches-return-9871-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 79002 invoked by alias); 19 Dec 2019 15:50:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 78941 invoked by uid 89); 19 Dec 2019 15:50:13 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-16.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: nihcesxway5.hub.nih.gov
Received: from nihcesxway5.hub.nih.gov (HELO nihcesxway5.hub.nih.gov) (128.231.90.120) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 19 Dec 2019 15:50:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;  d=nih.gov; i=@nih.gov; q=dns/txt; s=NIH; t=1576770611;  x=1608306611;  h=from:to:subject:date:message-id:references:in-reply-to:   content-transfer-encoding:mime-version;  bh=QxMSCD3wklNyyMHnOG7yINoXlz3roGXDKlixPRcaDU8=;  b=Tt8+YmXhSHKNwYtnFQE0mtauT0UKUdtRyIlSZUKR7uc9UVWJLhSwi0QL   EfT4ZJyxVYNno4CpCmxoo7x26wATvciwg/mY+4cL4TaM5E1JcvINOSpde   +2MKlvQOHDC7wycd8klLFS2rbPJBQXk/sYKPfaIy2YlhtbVIoMNCErSdu   b/XH+iekO7XiQVNn7FtFQ35iUs7q6GF5vLPKI9Dusl5vRmrMt2QGKVPbn   pyL3MyE1w9Fsj+4JKWFcYAMLMqKluNOEc1W5pvkGH4BF/+uv74nIiEuBy   KZ5K/bOa3XyPIen7EWLTBADhrnfiQSGnY3pn6dKaCLJyOR2lR90Q54UQN   Q==;
IronPort-SDR: 35Z+l/5wQ5/owaSx2U5nsVsG+pOgxXoS7e44Gzg2lU2lxg9Qkm1ZYLTBVR28az7wz5WNKhWLOX 7dhA/pdSnTBA==
Received: from uccsx01.nih.gov (HELO ces.nih.gov) ([165.112.194.91])  by nihcesxway5.hub.nih.gov with ESMTP/TLS/ECDHE-RSA-AES256-SHA384; 19 Dec 2019 10:50:08 -0500
Received: from uccsX02.nih.gov (165.112.194.92) by uccsX01.nih.gov (165.112.194.91) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 19 Dec 2019 10:50:08 -0500
Received: from GCC02-BL0-obe.outbound.protection.outlook.com (165.112.194.6) by uccsX02.nih.gov (165.112.194.92) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend Transport; Thu, 19 Dec 2019 10:50:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=E+krRtS6GsKwGUX1DCbO6NuPJ7Ez/7FHop4Il5Fop6aA7itvRqFBqsN0xqUxmmEB31nt2+sp84kAT9yeRBY3+TtQlO/4azW39JNZxhjViKLmeTktTaN0S9zbU77AIr8qOdAphCK/Y/67RkWutiWgFlIPG/t3Osi9xN4gm0PllUMhm7Rr4jypDpEgcdV2anmF0cpZBJscnza4FbrgPMUCCV4z5TDbe/646y5YVjTE+qi2NxdYgHDIk+KqN83obnfHvsXB8Ews8xczBK+dXUEYXO+dI3M+jwjqLI4CoXoQG/DYfQ+PbCGXb4zw3+k3KMQoW1vCsROORQVgyUZ9GtlUNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=QxMSCD3wklNyyMHnOG7yINoXlz3roGXDKlixPRcaDU8=; b=eo6k7D852YLTtlKpVpwB1bJHyA0GGax99/aESy2yq8XYDiEaruOvKDU7jtnIHzc65ZrHJci9fDKqOFIjoFIfroyPEeKH/t52panZikFK7k92Izf5b2gOhP2cmopFCvKRBZXw9mpXoMUPGQxsye8gtSr/u0y8aA2ucCz5/wYqtFakprH1gQWiZXLkyC1AbCjnHweF3sA62W+OkHuL5OF7P6p7rhXVGx/a+Uik3aIhrMirD/ogBYrCK5rDUDLJqBf/0M2Ck9Nwm+/I9YyuG+q7ujaSH2HfRglsWYRu9ypSE1m0J1uLs57nmSBi7jChY5zqO0rnfrvmqntfbMViuZ8UXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=ncbi.nlm.nih.gov; dmarc=pass action=none header.from=ncbi.nlm.nih.gov; dkim=pass header.d=ncbi.nlm.nih.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nih.onmicrosoft.com; s=selector2-nih-onmicrosoft-com; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=QxMSCD3wklNyyMHnOG7yINoXlz3roGXDKlixPRcaDU8=; b=JTPWM9sOy4IYBZFIZXD5RuvawijLzAck4F2Ws+yhCBS2w4JZQXEAXYnF9/VvhchO877eZ1dMgju41GYl6WQBIpJdktcOmy8cqxG77NepSBlTwJm8Ee1/jbTsUVUKROQ01kZNY2M4s8SYHZTu5YI/eR+ED1cQOj92yJF9cC54JFU=
Received: from BN7PR09MB2739.namprd09.prod.outlook.com (52.135.242.141) by BN7PR09MB2689.namprd09.prod.outlook.com (52.135.247.144) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15; Thu, 19 Dec 2019 15:50:07 +0000
Received: from BN7PR09MB2739.namprd09.prod.outlook.com ([fe80::8093:1a73:db00:6151]) by BN7PR09MB2739.namprd09.prod.outlook.com ([fe80::8093:1a73:db00:6151%3]) with mapi id 15.20.2559.015; Thu, 19 Dec 2019 15:50:07 +0000
From: "Lavrentiev, Anton (NIH/NLM/NCBI) [C] via cygwin-patches" <cygwin-patches@cygwin.com>
Reply-To: "Lavrentiev, Anton (NIH/NLM/NCBI) [C]" <lavr@ncbi.nlm.nih.gov>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: RE: [PATCH] Cygwin: pty: Fix ESC[?3h and ESC[?3l handling again.
Date: Thu, 19 Dec 2019 15:50:00 -0000
Message-ID: <BN7PR09MB2739C6A79C748A5FD044D69EA5520@BN7PR09MB2739.namprd09.prod.outlook.com>
References: <20191219110330.1902-1-takashi.yano@nifty.ne.jp> <20191219112924.GT10310@calimero.vinschen.de>
In-Reply-To: <20191219112924.GT10310@calimero.vinschen.de>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=lavr@ncbi.nlm.nih.gov;
x-ms-oob-tlc-oobclassifiers: OLM:849;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WybZubFVJWRwmy2K+BpIcoBQaro5Nxh6LH+gVAG172RlzABBNkItbKPKJh9O+R5J
Return-Path: lavr@ncbi.nlm.nih.gov
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00142.txt.bz2

SnVzdCBub3RpY2VkIHRoYXQgaW4gdGhlIHBhdGNoIGJlbG93IGFuZCBjb3Vs
ZG4ndCBoZWxwIGl0LCBzb3JyeS4uDQoNClRoaW5ncyBsaWtlDQoNCmNoYXIq
IHAwOw0KDQphbmQgbGF0ZXI6DQoNCmlzZGlnaXQoKnAwKSkgIG9yICBpc2Fs
cGhhKCpwMCkNCg0KYXJlIHVzdWFsbHkgbm90IGEgZ29vZCAoY29ycmVjdCkg
d2F5IG9mIGNvZGluZywgYmVjYXVzZSBvZiBwb3NzaWJsZSBzaWduIGV4dGVu
c2lvbiBvZiAqcDANCndoaWNoIHlvdSBub3JtYWxseSB3b3VsZG4ndCB3YW50
IHRvIGhhdmUgKHJlbWVtYmVyIHRoZSBjdHlwZSBjYWxscy9tYWNyb3MgYWN0
dWFsbHkgZXhwZWN0DQphbiAiaW50Iiwgbm90IGEgY2hhcmFjdGVyLCBpbnB1
dCkuICBTbyBpdCBzaG91bGQgYmUgZWl0aGVyICJ1bnNpZ25lZCBjaGFyKiBw
MCIgb3INCiJpc2RpZ2l0KCh1bnNpZ25lZCBjaGFyKSgqcDApKSIsIGdlbmVy
YWxseS4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9t
OiBjeWd3aW4tcGF0Y2hlcy1vd25lckBjeWd3aW4uY29tIDxjeWd3aW4tcGF0
Y2hlcy1vd25lckBjeWd3aW4uY29tPiBPbg0KPiBCZWhhbGYgT2YgQ29yaW5u
YSBWaW5zY2hlbg0KPiBTZW50OiBUaHVyc2RheSwgRGVjZW1iZXIgMTksIDIw
MTkgNjoyOSBBTQ0KPiBUbzogY3lnd2luLXBhdGNoZXNAY3lnd2luLmNvbQ0K
PiBTdWJqZWN0OiBSZTogW1BBVENIXSBDeWd3aW46IHB0eTogRml4IEVTQ1s/
M2ggYW5kIEVTQ1s/M2wgaGFuZGxpbmcgYWdhaW4uDQo+IA0KPiBPbiBEZWMg
MTkgMjA6MDMsIFRha2FzaGkgWWFubyB3cm90ZToNCj4gPiAtIEV2ZW4gd2l0
aCBjb21taXQgZmU1MTJiMmIxMmEyY2VhODM5M2QxNGYwMzhkYzM5MTRiMWJm
M2Y2MCwgcHR5DQo+ID4gICBzdGlsbCBoYXMgYSBwcm9ibGVtIGluIEVTQ1s/
M2ggYW5kIEVTQ1s/M2wgaGFuZGxpbmcgaWYgaW52YWxpZA0KPiA+ICAgc2Vx
dWVuY2Ugc3VjaCBhcyBFU0NbPyQgaXMgc2VudC4gVGhpcyBwYXRjaCBmaXhl
cyB0aGUgaXNzdWUuDQo+ID4gLS0tDQo+ID4gIHdpbnN1cC9jeWd3aW4vZmhh
bmRsZXJfdHR5LmNjIHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS93aW5zdXAvY3lnd2luL2ZoYW5kbGVyX3R0eS5jYyBiL3dpbnN1cC9j
eWd3aW4vZmhhbmRsZXJfdHR5LmNjDQo+ID4gaW5kZXggOGMzYTZlNzJlLi5m
MTBmMGZjNjEgMTAwNjQ0DQo+ID4gLS0tIGEvd2luc3VwL2N5Z3dpbi9maGFu
ZGxlcl90dHkuY2MNCj4gPiArKysgYi93aW5zdXAvY3lnd2luL2ZoYW5kbGVy
X3R0eS5jYw0KPiA+IEBAIC0xMjYzLDcgKzEyNjMsNyBAQCBmaGFuZGxlcl9w
dHlfc2xhdmU6OnB1c2hfdG9fcGNvbl9zY3JlZW5idWZmZXIgKGNvbnN0DQo+
IGNoYXIgKnB0ciwgc2l6ZV90IGxlbikNCj4gPiAgICAgIHsNCj4gPiAgICAg
ICAgcDAgKz0gMzsNCj4gPiAgICAgICAgYm9vbCBleGlzdF9hcmdfMyA9IGZh
bHNlOw0KPiA+IC0gICAgICB3aGlsZSAocDAgPCBidWYgKyBubGVuICYmICFp
c2FscGhhICgqcDApKQ0KPiA+ICsgICAgICB3aGlsZSAocDAgPCBidWYgKyBu
bGVuICYmIChpc2RpZ2l0ICgqcDApIHx8ICpwMCA9PSAnOycpKQ0KPiA+ICAJ
ew0KPiA+ICAJICBpbnQgYXJnID0gMDsNCj4gPiAgCSAgd2hpbGUgKHAwIDwg
YnVmICsgbmxlbiAmJiBpc2RpZ2l0ICgqcDApKQ0KPiA+IC0tDQo+ID4gMi4y
MS4wDQo+IA0KPiBQdXNoZWQuDQo+IA0KPiANCj4gVGhhbmtzLA0KPiBDb3Jp
bm5hDQo+IA0KPiAtLQ0KPiBDb3Jpbm5hIFZpbnNjaGVuDQo+IEN5Z3dpbiBN
YWludGFpbmVyDQo=
