Return-Path: <cygwin-patches-return-9555-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 40407 invoked by alias); 8 Aug 2019 16:06:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 40397 invoked by uid 89); 8 Aug 2019 16:06:35 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.8 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=PS, P.S, UD:P.S, p.s
X-HELO: NAM03-BY2-obe.outbound.protection.outlook.com
Received: from mail-eopbgr780128.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) (40.107.78.128) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 08 Aug 2019 16:06:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=Jhq/5BUQwOVAcOHde5yDCr8gEEJ3IAoSDRJN7KPW/O+FwZOgXfDPFX0SZpeIidgiRJR0iDMXrCfnn1HX1pec7yyBAWM5ir3/TBB+a6yfdwKfuu40GmZZCJCwFMUinIdSaFlnRJPnNdKrWHyJf8Mq/pyXnH3UAUkXoaajkZHMVs0yjvmd0UFLY71sgVB2e9fSqQ7IGWTbSB+xw52+OKDeGknFqkc/zW5AxZfdmA24/L8AWHdeLsZaLNPA9PY0Sz2UAJMwMjaE0+GsynVSzpXmqZ70IDhHyzkGuxfcmF2oGGiOuely66viihNUywc/3Q7GYhBszBfWyv6MJvUjYgNmYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=/0lrasYzbO/vUs4K/TZnBEbljATefsDmEKPDlMy6Otw=; b=RjyXXSoIZYEcXt9SDI6m8iPWeqGl+I8LLrCuomy2c/xgd9Nxb5AuWAUXzfe8MMkxk+bWzGHVTNGg6va2Qg8YCQmjSa8hy6UB3+Whuzb/If2Mrkyj0QmogLwq/FBkAoeDZz1l8tB+xnx2tLpZ6sku7V7HrbPw2zn+TbZD+i0fZ6FwyCTFE8qz86da6FUT6cbGUtmhrZms1wMsk5UGzmQs+S/Es957R3Nxt2evJjFC58euiTa9L07IvYkijscI8B/M8rC05wTy9M2efHbCvcz45JORyYrs4TXER2sqAN1T0roTNmSGM8H2agG4AfmOS+HLAKnSTMFCFfm9VNSmpepLxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass smtp.mailfrom=cornell.edu;dmarc=pass action=none header.from=cornell.edu;dkim=pass header.d=cornell.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=/0lrasYzbO/vUs4K/TZnBEbljATefsDmEKPDlMy6Otw=; b=Z50YL+BlC2bJHq+++7gxjlJ37ZAd0/Wu1hZDuW53MMIbqMo+dVL3J4AxJB1IeoQeVgQG1pUoCiIqaAVg3ap4eVZwbEHKcZNoz+SmF/kDjT13+czWOoSn39spzePMkJZ7iKR7lDCVYNd7fHRpXXocv7VlmMuR2htp6TMMnF6CdqQ=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB5450.namprd04.prod.outlook.com (20.178.27.147) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2136.14; Thu, 8 Aug 2019 16:06:31 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cdc1:727:b526:d28e]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cdc1:727:b526:d28e%7]) with mapi id 15.20.2136.018; Thu, 8 Aug 2019 16:06:31 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Subject: Re: [PATCH] Cygwin: shmat: use mmap allocator strategy on 64 bit
Date: Thu, 08 Aug 2019 16:06:00 -0000
Message-ID: <b5b5bbaf-2bbe-b500-5c4b-9afca3eaf093@cornell.edu>
References: <20190808085527.29002-1-corinna-cygwin@cygwin.com>
In-Reply-To: <20190808085527.29002-1-corinna-cygwin@cygwin.com>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.8.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:4303;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <D470D3A184F0AE43B9DE2BC22437D53F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00075.txt.bz2

T24gOC84LzIwMTkgNDo1NSBBTSwgY29yaW5uYS1jeWd3aW5AY3lnd2luLmNv
bSB3cm90ZToNCj4gRnJvbTogQ29yaW5uYSBWaW5zY2hlbiA8Y29yaW5uYS1j
eWd3aW5AY3lnd2luLmNvbT4NCj4gDQo+IFRoaXMgYXZvaWRzIGNvbGxpc2lv
bnMgb2Ygc2htYXQgbWFwcyB3aXRoIFdpbmRvd3Mgb3duIGRhdGFzdHJ1Y3R1
cmVzDQo+IHdoZW4gYWxsb2NhdGluZyB0b3AtZG93bi4NCj4gDQo+IFRoaXMg
cGF0Y2ggbW92ZXMgdGhlIG1tYXBfYWxsb2NhdG9yIGNsYXNzIGRlZmluaXRp
b24gaW50byBpdHMNCj4gb3duIGZpbGVzIGFuZCBqdXN0IHVzZXMgaXQgZnJv
bSBtbWFwIGFuZCBzaG1hdC4NCg0KVGhpcyBtYWtlcyBzZW5zZSB0byBtZSwg
YW5kIGl0IGZpeGVzIHRoZSBoZXhjaGF0IGZvcmsgcHJvYmxlbS4gIFRoYW5r
cyENCg0KS2VuDQoNClAuUy4gSSBnb3QgYSB3aGl0ZXNwYWNlIHdhcm5pbmcg
ZnJvbSBnaXQgd2hlbiBJIGFwcGxpZWQgdGhlIHBhdGNoLiAgVGhlcmUncyBh
IA0KYmxhbmsgbGluZSBhdCB0aGUgZW5kIG9mIG1tYXBfYWxsb2MuY2MuDQo=
