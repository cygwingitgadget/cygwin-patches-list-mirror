Return-Path: <cygwin-patches-return-9920-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 120765 invoked by alias); 13 Jan 2020 16:53:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 120737 invoked by uid 89); 13 Jan 2020 16:53:49 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM11-DM6-obe.outbound.protection.outlook.com
Received: from mail-dm6nam11on2129.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) (40.107.223.129) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 13 Jan 2020 16:53:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=gs7XlOeFEsG72DkwvxyVT1bReAoLt3DAE5vkm226p3jjLPIqn6Q2sFbWnD1PG/i/5/kucrT9msFQTlg6rjDGu2d/oWOU31Nt22jc07Pkp8Ly/BbmfENJTLMSeBG3WmoKfgK08bzkVp4uJNXH7OuHgCys3F4dZN6ErVVEX/aCb33MLzAMniE71XRQ5aymNJuz5jvnwW5xQ5Dpt5L3/XP9AZRhy22SQooNeBM3CbkRw92ehdSe+KV9S8gIyu7szqnSm+Z4AwC7S+rvKRiSGL/qc2BPnLlE8uEjVvkPxoIhplodvwczV/Ju4rNLyONXWDIYfd70hozXpy8zD/WR4CvnXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=pd4yg4YkVZ60uXwxIQFwW+NH7t76U8ImvDu9M7Okqbw=; b=BY71IGolfU38M/RSBLpLljTw1PMM6blEo/vmX1UxFlSAOIMNybbVyI4qPCk+zKmUMW6bWLA3hSWtEk27DCn6+vcv/de59jHjiD9a8AVDGrbpm6jzMa7K/YRvmeaK21MfZt+laHoVZNlrGIwv7jBDVzfGjeWr+7aLRJna6Ytu/eyDmZbVzjVFpKb7JJzqL5h2O9qxLO9KbIctersa/lChZd42Qx8e82KHMGSkzDntpyfcfCox+EWLAo4nIA7QaP9utrhnx7xsTZd35rmP1WFmI6s+tKfSNdm5Yvtz1JtcHYkn4emTCe2QvfT8Y8Sx2Wjb6qfNqQ1fkd9KrbL9EbAg6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=pd4yg4YkVZ60uXwxIQFwW+NH7t76U8ImvDu9M7Okqbw=; b=aTWnoUIJ42vwrTgZ7V1ylS6xRDYFdw6Vi678aHwsKF4sESNgjAxij+2RitPb9lugfHGTrb8d8tleBuQcHVV1P3+sxlYOWmpbYL0HwLc+/nN7zSHUWKEjB3PMq5b+Uaoqhcw+YJ69vo/Yfrc+INOdIu8WRX+Abe9vqnVBlfHFNNs=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB6362.namprd04.prod.outlook.com (10.141.161.142) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.8; Mon, 13 Jan 2020 16:53:45 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831%7]) with mapi id 15.20.2623.017; Mon, 13 Jan 2020 16:53:45 +0000
Received: from [10.104.13.193] (63.148.235.187) by BL0PR0102CA0031.prod.exchangelabs.com (2603:10b6:207:18::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend Transport; Mon, 13 Jan 2020 16:53:44 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v2 0/3] Support opening a symlink with O_PATH | O_NOFOLLOW
Date: Mon, 13 Jan 2020 16:53:00 -0000
Message-ID: <9f83d272-2dad-f652-d0c8-f3eb3b425ac2@cornell.edu>
References: <20191229175637.1050-1-kbrown@cornell.edu> <20200113152809.GE5858@calimero.vinschen.de>
In-Reply-To: <20200113152809.GE5858@calimero.vinschen.de>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101 Thunderbird/68.3.1
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:9508;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <99DD148239C1404FAA51A2DF27B321FF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rbNVTtZBZuoDmx3CSZC5lZ/RyFJkHToO2hrzaIK8onVHoomnJCtgsRDeFxss0+vomc6qx1YCT5F5mSVXsNeJRw==
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00026.txt

T24gMS8xMy8yMDIwIDEwOjI4IEFNLCBDb3Jpbm5hIFZpbnNjaGVuIHdyb3Rl
Og0KPiBIaSBLZW4sDQo+IA0KPiBPbiBEZWMgMjkgMTc6NTYsIEtlbiBCcm93
biB3cm90ZToNCj4+IEN1cnJlbnRseSwgb3BlbmluZyBhIHN5bWxpbmsgd2l0
aCBPX05PRk9MTE9XIGZhaWxzIHdpdGggRUxPT1AuDQo+PiBGb2xsb3dpbmcg
TGludXgsIHRoZSBmaXJzdCBwYXRjaCBpbiB0aGlzIHNlcmllcyBhbGxvd3Mg
dGhlIGNhbGwgdG8NCj4+IHN1Y2NlZWQgaWYgT19QQVRIIGlzIGFsc28gc3Bl
Y2lmaWVkLg0KPj4NCj4+IEFjY29yZGluZyB0byB0aGUgTGludXggbWFuIHBh
Z2UgZm9yICdvcGVuJywgdGhlIGZpbGUgZGVzY3JpcHRvcg0KPj4gcmV0dXJu
ZWQgYnkgdGhlIGNhbGwgc2hvdWxkIGJlIHVzYWJsZSBhcyB0aGUgZGlyZmQg
YXJndW1lbnQgaW4gY2FsbHMNCj4+IHRvIGZzdGF0YXQgYW5kIHJlYWRsaW5r
YXQgd2l0aCBhbiBlbXB0eSBwYXRobmFtZSwgdG8gaGF2ZQ0KPj4gdGhlIGNh
bGxzIG9wZXJhdGUgb24gdGhlIHN5bWJvbGljIGxpbmsuICBUaGUgc2Vjb25k
IGFuZCB0aGlyZCBwYXRjaGVzDQo+PiBhY2hpZXZlIHRoaXMuICBGb3IgZnN0
YXRhdCwgd2UgZG8gdGhpcyBieSBhZGRpbmcgc3VwcG9ydA0KPj4gZm9yIHRo
ZSBBVF9FTVBUWV9QQVRIIGZsYWcuDQo+Pg0KPj4gTm90ZTogVGhlIG1hbiBw
YWdlIG1lbnRpb25zIGZjaG93bmF0IGFuZCBsaW5rYXQgYWxzby4gIGxpbmth
dCBhbHJlYWR5DQo+PiBzdXBwb3J0cyB0aGUgQVRfRU1QVFlfUEFUSCBmbGFn
LCBzbyBub3RoaW5nIG5lZWRzIHRvIGJlIGRvbmUuICBCdXQgSQ0KPj4gZG9u
J3QgdW5kZXJzdGFuZCBob3cgdGhpcyBjb3VsZCB3b3JrIGZvciBmY2hvd25h
dCwgYmVjYXVzZSBmY2hvd24NCj4+IGZhaWxzIHdpdGggRUJBREYgaWYgaXRz
IGZkIGFyZ3VtZW50IHdhcyBvcGVuZWQgd2l0aCBPX1BBVEguICBTbyBJDQo+
PiBoYXZlbid0IHRvdWNoZWQgZmNob3duYXQuDQo+IA0KPiBJdCB3YXMgbmV2
ZXIgc3VwcG9zZWQgdG8gd29yayB0aGF0IHdheS4gIFdlIGNhbiBtYWtlIGZj
aG93bmF0IHdvcmsNCj4gd2l0aCBBVF9FTVBUWV9QQVRILCBidXQgdXNpbmcg
aXQgb24gYSBmaWxlIG9wZW5lZCB3aXRoIE9fUEFUSA0KPiBjb250cmFkaWN0
cyB0aGUgTGludXggb3BlbigyKSBtYW4gcGFnZSwgYWZhaWNzOg0KPiANCj4g
ICBPX1BBVEggKHNpbmNlIExpbnV4IDIuNi4zOSkNCj4gICAgT2J0YWluIGEg
ZmlsZSBkZXNjcmlwdG9yIHRoYXQgY2FuIGJlIHVzZWQgZm9yIHR3byAgcHVy
cG9zZXM6ICB0bw0KPiAgICBpbmRpY2F0ZSBhIGxvY2F0aW9uIGluIHRoZSBm
aWxlc3lzdGVtIHRyZWUgYW5kIHRvIHBlcmZvcm0gb3BlcmHigJANCj4gICAg
dGlvbnMgdGhhdCBhY3QgcHVyZWx5IGF0IHRoZSBmaWxlIGRlc2NyaXB0b3Ig
IGxldmVsLiAgIFRoZSAgZmlsZQ0KPiAgICBpdHNlbGYgIGlzIG5vdCBvcGVu
ZWQsIGFuZCBvdGhlciBmaWxlIG9wZXJhdGlvbnMgKGUuZy4sIHJlYWQoMiks
DQo+ICAgIHdyaXRlKDIpLCBmY2htb2QoMiksIGZjaG93bigyKSwgZmdldHhh
dHRyKDIpLCBpb2N0bCgyKSwgbW1hcCgyKSkNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgXl5eXl5eXl5eDQo+ICAgIGZhaWwgd2l0aCB0aGUgZXJyb3Ig
RUJBREYuDQo+ICAgIF5eXl5eXl5eXiAgICAgICAgICAgXl5eXl4NCj4gDQo+
IFRoYXQnZCBmcm9tIHRoZSBjdXJyZW50IEYzMSBtYW4gcGFnZXMuDQo+IA0K
Pj4gQW0gSSBtaXNzaW5nIHNvbWV0aGluZz8NCj4gDQo+IEdvb2QgcXVlc3Rp
b24uICBMZXQgbWUgYXNrIGluIHJldHVybiwgZGlkICpJKiBub3cgbWlzcyBz
b21ldGhpbmc/DQoNCkkgZG9uJ3QgdGhpbmsgc28uICBJIHRoaW5rIHdlIGFn
cmVlLCBhbHRob3VnaCBtYXliZSBJIGRpZG4ndCBleHByZXNzIG15c2VsZiAN
CmNsZWFybHkgZW5vdWdoIGZvciB0aGF0IHRvIGJlIG9idmlvdXMuICBXaGF0
IGNvbmZ1c2VkIG1lIHdhcyB0aGUgZm9sbG93aW5nIA0KcGFyYWdyYXBoIGZ1
cnRoZXIgZG93biBpbiB0aGUgb3BlbigyKSBtYW4gcGFnZSAoc3RpbGwgZGlz
Y3Vzc2luZyBPX1BBVEgpOg0KDQogICBJZiBwYXRobmFtZSBpcyBhIHN5bWJv
bGljIGxpbmsgYW5kIHRoZSBPX05PRk9MTE9XIGZsYWcgaXMgYWxzbw0KICAg
c3BlY2lmaWVkLCB0aGVuIHRoZSBjYWxsIHJldHVybnMgYSBmaWxlIGRlc2Ny
aXB0b3IgcmVmZXJyaW5nDQogICB0byB0aGUgc3ltYm9saWMgbGluay4gIFRo
aXMgZmlsZSBkZXNjcmlwdG9yIGNhbiBiZSB1c2VkIGFzIHRoZQ0KICAgZGly
ZmQgYXJndW1lbnQgaW4gY2FsbHMgdG8gZmNob3duYXQoMiksIGZzdGF0YXQo
MiksIGxpbmthdCgyKSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IF5eXl5eXl5eXl5eDQogICBhbmQgcmVhZGxpbmthdCgyKSB3aXRoIGFuIGVt
cHR5IHBhdGhuYW1lIHRvIGhhdmUgdGhlIGNhbGxzDQogICBvcGVyYXRlIG9u
IHRoZSBzeW1ib2xpYyBsaW5rLg0KDQpJIGRvbid0IGtub3cgd2h5IHRoZXkg
aW5jbHVkZSBmY2hvd25hdCBoZXJlLCBzaW5jZSB0aGUgcmVzdWx0aW5nIGNh
bGwgd291bGQgZmFpbCANCndpdGggRUJBREYuICBTbyBJIGRpZG4ndCBpbXBs
ZW1lbnQgdGhhdCBpbiBteSBwYXRjaCBzZXJpZXMuDQoNCktlbg0K
