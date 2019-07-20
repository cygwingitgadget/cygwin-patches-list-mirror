Return-Path: <cygwin-patches-return-9495-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 51753 invoked by alias); 20 Jul 2019 22:53:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 51743 invoked by uid 89); 20 Jul 2019 22:53:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.6 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SEM_URI,SEM_URIRED,SPF_HELO_PASS,SPF_PASS autolearn=no version=3.3.1 spammy=H*M:62b1, meaning
X-HELO: NAM02-CY1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr760115.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) (40.107.76.115) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 20 Jul 2019 22:53:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=KmhDuElhPn9MesyrJB423RQlBg15yqogtw5b7fHezJ1eYIU966pgUXKvYXhkD0J8GmIEQis9RpwguTuTsuGWd8it9ZOwS+sBCPlIV7+9bjloHCRUX79wBPC7lX9w14H6QVbXBNNa6IUZZrrAdXRkVgsn6sHrb1grU9vGGlZwVS7BhF9Be+sW+xC/aTePnNXJTokQm+R3ed/AfxexzZ05AnZmnC+aN31KKPG0C8CmS8PYEQSYcNEVjBSsbsURV9eluYQ7ikbVvrlrKx6cx2BXKE9JEO/FscaEWLqW4fFvjL0/NE5TbQVUoYjRAVuRmQ/SJhy+rPhXDTdlnmlH/2DhDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=cKwBOfh6XEhhOT9JsDvDxxFV11QsmNaTu1vZ+dIeRiU=; b=glHAgbSw56NwDxR9xUWkrgKIzn/AJnEe0CoTT9MXdwAKgoMnpmaWpKbY4/KGR7sDAfvvjrIqnKvpqzOr0INp/X+c00fE9pnoDCYck5tqJtXTzDgiQoSv/38NNJCdLw+w7Zv/z4/pyCj0ja0frn0+iCLrpwoNhVWs8MlR4sUALHV+ywIn5LuiA2AHfTDELXC1RvDB6rZzFzfjuhamrjWNHZD3gsMHWp9BB34S9T+O4tHD/Xigs+aXuhJJ3R//8NiUorqNc90f7cRFzFwmp+SKhJU5aQYtq4j5mbNTk0nA11VZljjY7lf/cbnnWBYqKpgoGgBwJNHHLNFGOljhI3+MUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass smtp.mailfrom=cornell.edu;dmarc=pass action=none header.from=cornell.edu;dkim=pass header.d=cornell.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=cKwBOfh6XEhhOT9JsDvDxxFV11QsmNaTu1vZ+dIeRiU=; b=Rc1d67VLTIiggZ/op+SJNrmEKA1QvhTMk/nQWqfnoq/qGvNqzR8R5kisesBdtno3/b1QTwRwQYoc+MaD4bQDPnMH2LDHz1Mwp+L7dGZNp8sc85bQmePI69Vj0iXMTXSIfdx8eJg+5J74tBnCAWpn7T9s6g96gdU1RU2NQFOHer0=
Received: from BN3PR04MB2289.namprd04.prod.outlook.com (10.167.2.14) by BN3PR04MB2212.namprd04.prod.outlook.com (10.166.75.146) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.16; Sat, 20 Jul 2019 22:53:09 +0000
Received: from BN3PR04MB2289.namprd04.prod.outlook.com ([fe80::5f6:25c2:3b1b:f8a7]) by BN3PR04MB2289.namprd04.prod.outlook.com ([fe80::5f6:25c2:3b1b:f8a7%3]) with mapi id 15.20.2094.013; Sat, 20 Jul 2019 22:53:09 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: make path_conv::isdevice() return false on socket files
Date: Sat, 20 Jul 2019 22:53:00 -0000
Message-ID: <8dce0946-6f7e-a3f4-62b1-98cdbbe277ef@cornell.edu>
References: <20190718200026.1377-1-kbrown@cornell.edu> <20190719082845.GO3772@calimero.vinschen.de>
In-Reply-To: <20190719082845.GO3772@calimero.vinschen.de>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.8.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:5797;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <37369F34576CD24AB95AF30BA51EF29C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00015.txt.bz2

T24gNy8xOS8yMDE5IDQ6MjggQU0sIENvcmlubmEgVmluc2NoZW4gd3JvdGU6
DQo+IEkgc2VlIHdoYXQgeW91J3JlIGRvaW5nIGhlcmUsIGJ1dCBpdCdzIHRv
dGFsbHkgbm9uLW9idmlvdXMgZnJvbSB0aGUNCj4gY29tbWl0IG1lc3NhZ2Ug
d2h5IHRoaXMgZml4ZXMgdGhlIHByb2JsZW0gYW5kIGRvZXNuJ3QgaW50cm9k
dWNlIHdlaXJkDQo+IHNpZGUtZWZmZWN0cy4NCg0KVGhhbmtzLiAgSSB3YXMg
cHJldHR5IGNhcmVsZXNzIHdpdGggdGhpcyBwYXRjaC4gIFRoZXJlJ3MgYSBu
ZXcgcGF0Y2ggc2VyaWVzIG9uIA0KdGhlIHdheSB0aGF0IChJIGhvcGUpIGRv
ZXMgaXQgcmlnaHQuDQoNCj4gQW4gZWRpdG9yaWFsIG5vdGU6IFdoaWxlIGxv
b2tpbmcgaW50byB5b3VyIHBhdGNoIGl0IG9jY3VyZWQgdG8gbWUgdGhhdA0K
PiBpdCB3b3VsZCBiZSBhYm91dCB0aW1lIHRvIGdvIG92ZXIgYWxsIHRoZSBp
cyoqKmRldmljZSgpIG1ldGhvZHMgYW5kDQo+IGNsZWFuIHVwIHRoZSBtZXNz
LiAgRS5nLiwgaXNfZnNfZGV2aWNlKCkgaXMgdXNlZCBieSBpc19sbmtfc3Bl
Y2lhbCgpDQo+IG9ubHksIGlzX2F1dG9fZGV2aWNlKCkgZG9lc24ndCBoYXZl
IG11Y2ggbWVhbmluZywNCg0KSSd2ZSByZW1vdmVkIGlzX2ZzX2RldmljZSgp
IGFuZCBpc19hdXRvX2RldmljZSgpDQoNCj4gc29tZSBmdW5jcyBoYXZlDQo+
IHVuZGVyc2NvcmVzLCBzb21lIGRvbid0Lg0KDQpUaGUgY29udmVudGlvbiBz
ZWVtcyB0byBiZSB0aGF0IGlzPHNvbWV0aGluZz4gdXNlcyB1bmRlcnNjb3Jl
cyBpZiBhbmQgb25seSBpZiANCiJzb21ldGhpbmciIGlzIGEgc2luZ2xlIHdv
cmQuICBUaGUgb25seSBleGNlcHRpb24gSSBzYXcgaXMgaXNjdHR5X2NhcGFi
bGUuICBJIA0KZGlkbid0IGJvdGhlciBjaGFuZ2luZyB0aGlzLCBidXQgSSBj
b3VsZCBpZiB5b3Ugd2FudCBtZSB0by4NCg0KS2VuDQo=
