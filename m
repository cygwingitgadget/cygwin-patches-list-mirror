Return-Path: <cygwin-patches-return-9889-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 127666 invoked by alias); 30 Dec 2019 19:53:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 127657 invoked by uid 89); 30 Dec 2019 19:53:28 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.8 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=H*MI:sk:d88c5de, H*f:sk:d88c5de, H*r:120, H*i:sk:d88c5de
X-HELO: NAM10-MW2-obe.outbound.protection.outlook.com
Received: from mail-mw2nam10on2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) (40.107.94.103) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 30 Dec 2019 19:53:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=CfzV1gUii6e8iDm82QD1EooGX0tRoCN3M2/S5rY9rB3gFz5GDnuBgp4xim8ZbRGZBAur4n3uGnkfXCUWpaQQbF9RqmOfCZH0v4/OorawS3kpN9DBWZxSpLBYg2n+8uMCAoGiqUZ3aFY49HJuPJVsX9oE3e2eHz2SJisP9J+uJkMBsDTp5rXlln8ga57bRUgEi7ahaF1D6KsvOMs9YtjhhfvJgEUbsR4bngZyE3AF0IjOmUlzVPvaRsds82xXOPkNR3SWdN8vPJ4Z0zPdTXON9+hpfcmzRJTo4Qc1ArfFYBsFXkILst5YnHgkUe3NM09hMGK4ne9Io8t0PEp6Uxt/ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=eX35+WUxQWPDQIKKAr6Q1ebgqDCP93O3f8JA44Kf97A=; b=L01zxlo/tLZsu8WDyCnv2C4QYepVDlkX1VnabYHAKTsyGMudAz41RjznAalVua71XiQsizLhOMC4tL/EIDk4bWIppgnmT9fei7Dr/40RrFxJY/I3IaLSaCXG9wZNqF8rsag+p0mHndwuYME4vXzCdLXWxzCxkmZDM9hAA+n2bkRnDbY0C97QtHfnjx+8foD3eTCMRbJ7vqCCRuYgdVfuWinGdrQ1HMDPMBfvpwq+SgJTmERg8aMmy7ktClwzD8hME2KwED7iuWvfRuOeQGDIDZQKHz5NQzUyXFfpzAmiGb9kjKY/MR+EcbJBTJ0j7/oxUnn8ZLynfMcvg+oj/7Ag6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=eX35+WUxQWPDQIKKAr6Q1ebgqDCP93O3f8JA44Kf97A=; b=eEqtNAPW7cz3eRZPRx7h2Grw3J0Z6tIxVELXv94K52FnvI/WmGaTbBkIZQtFmMjjEKqOovZqmFyGlwKmBnwmvzvp9ZX2To3b8jkzyB13e3BQX6SgNd9OqZkHo8pyidzupZRR53w/8ZudrkNZxJQxOtJ4S8O/DTH4tyPfdkDMgFA=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB5691.namprd04.prod.outlook.com (20.179.50.26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.12; Mon, 30 Dec 2019 19:53:23 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::f894:edec:b80c:d524]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::f894:edec:b80c:d524%3]) with mapi id 15.20.2581.007; Mon, 30 Dec 2019 19:53:23 +0000
Received: from [192.168.0.19] (68.175.129.7) by MN2PR10CA0020.namprd10.prod.outlook.com (2603:10b6:208:120::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.12 via Frontend Transport; Mon, 30 Dec 2019 19:53:23 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v2 0/3] Support opening a symlink with O_PATH | O_NOFOLLOW
Date: Mon, 30 Dec 2019 19:53:00 -0000
Message-ID: <aafbc75d-11db-0faf-6e13-72681c5784a3@cornell.edu>
References: <20191229175637.1050-1-kbrown@cornell.edu> <d88c5dee-9457-3c39-960c-ea07842cd0c5@SystematicSw.ab.ca>
In-Reply-To: <d88c5dee-9457-3c39-960c-ea07842cd0c5@SystematicSw.ab.ca>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.1
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:10000;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E287B0C03A0E746A8BA82E16F1D6435@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P//SxljBEHXk6F9PB9ODWvBM7qX55+LIYycXaSFsWsY4gvt40AQzEq86xy/DHqoMHbAGaYHlCgEIiijlZE8bJg==
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00160.txt.bz2

T24gMTIvMzAvMjAxOSAyOjE4IFBNLCBCcmlhbiBJbmdsaXMgd3JvdGU6DQo+
IE9uIDIwMTktMTItMjkgMTA6NTYsIEtlbiBCcm93biB3cm90ZToNCj4+IEN1
cnJlbnRseSwgb3BlbmluZyBhIHN5bWxpbmsgd2l0aCBPX05PRk9MTE9XIGZh
aWxzIHdpdGggRUxPT1AuDQo+PiBGb2xsb3dpbmcgTGludXgsIHRoZSBmaXJz
dCBwYXRjaCBpbiB0aGlzIHNlcmllcyBhbGxvd3MgdGhlIGNhbGwgdG8NCj4+
IHN1Y2NlZWQgaWYgT19QQVRIIGlzIGFsc28gc3BlY2lmaWVkLg0KPj4NCj4+
IEFjY29yZGluZyB0byB0aGUgTGludXggbWFuIHBhZ2UgZm9yICdvcGVuJywg
dGhlIGZpbGUgZGVzY3JpcHRvcg0KPj4gcmV0dXJuZWQgYnkgdGhlIGNhbGwg
c2hvdWxkIGJlIHVzYWJsZSBhcyB0aGUgZGlyZmQgYXJndW1lbnQgaW4gY2Fs
bHMNCj4+IHRvIGZzdGF0YXQgYW5kIHJlYWRsaW5rYXQgd2l0aCBhbiBlbXB0
eSBwYXRobmFtZSwgdG8gaGF2ZQ0KPj4gdGhlIGNhbGxzIG9wZXJhdGUgb24g
dGhlIHN5bWJvbGljIGxpbmsuICBUaGUgc2Vjb25kIGFuZCB0aGlyZCBwYXRj
aGVzDQo+PiBhY2hpZXZlIHRoaXMuICBGb3IgZnN0YXRhdCwgd2UgZG8gdGhp
cyBieSBhZGRpbmcgc3VwcG9ydA0KPj4gZm9yIHRoZSBBVF9FTVBUWV9QQVRI
IGZsYWcuDQo+Pg0KPj4gTm90ZTogVGhlIG1hbiBwYWdlIG1lbnRpb25zIGZj
aG93bmF0IGFuZCBsaW5rYXQgYWxzby4gIGxpbmthdCBhbHJlYWR5DQo+PiBz
dXBwb3J0cyB0aGUgQVRfRU1QVFlfUEFUSCBmbGFnLCBzbyBub3RoaW5nIG5l
ZWRzIHRvIGJlIGRvbmUuICBCdXQgSQ0KPj4gZG9uJ3QgdW5kZXJzdGFuZCBo
b3cgdGhpcyBjb3VsZCB3b3JrIGZvciBmY2hvd25hdCwgYmVjYXVzZSBmY2hv
d24NCj4+IGZhaWxzIHdpdGggRUJBREYgaWYgaXRzIGZkIGFyZ3VtZW50IHdh
cyBvcGVuZWQgd2l0aCBPX1BBVEguICBTbyBJDQo+PiBoYXZlbid0IHRvdWNo
ZWQgZmNob3duYXQuDQo+Pg0KPj4gQW0gSSBtaXNzaW5nIHNvbWV0aGluZz8N
Cj4gDQo+IFdTTCAkIG1hbiAyIGNob3duDQo+IC4uLg0KPiAiQVRfRU1QVFlf
UEFUSCAoc2luY2UgTGludXggMi42LjM5KQ0KPiBJZiBwYXRobmFtZSBpcyBh
biBlbXB0eSBzdHJpbmcsIG9wZXJhdGUgb24gdGhlIGZpbGUgcmVmZXJyZWQg
dG8NCj4gYnkgZGlyZmQgKHdoaWNoIG1heSBoYXZlIGJlZW4gb2J0YWluZWQg
dXNpbmcgdGhlIG9wZW4oMikgT19QQVRIDQo+IGZsYWcpLiBJbiAgdGhpcyBj
YXNlLCBkaXJmZCBjYW4gcmVmZXIgdG8gYW55IHR5cGUgb2YgZmlsZSwgbm90
DQo+IGp1c3QgYSBkaXJlY3RvcnkuIElmIGRpcmZkIGlzIEFUX0ZEQ1dELCB0
aGUgIGNhbGwgb3BlcmF0ZXMgb24NCj4gdGhlIGN1cnJlbnQgd29ya2luZyBk
aXJlY3RvcnkuIFRoaXMgZmxhZyBpcyBMaW51eC1zcGVjaWZpYzsgZGXigJAN
Cj4gZmluZSBfR05VX1NPVVJDRSB0byBvYnRhaW4gaXRzIGRlZmluaXRpb24u
Ig0KPiANCj4gc2F5cyBjaG93biB0aGUgZGlyZmQsIHJlZ2FyZGxlc3Mgb2Yg
d2hhdCBpdCBpcywNCj4gZXhjZXB0IGlmIEFUX0ZEQ1dELCBjaG93biB0aGUg
Q1dELg0KPiANCj4gV1NMICQgbWFuIDIgb3Blbg0KPiAiT19QQVRIIChzaW5j
ZSBMaW51eCAyLjYuMzkpDQo+IE9idGFpbiBhIGZpbGUgZGVzY3JpcHRvciB0
aGF0IGNhbiBiZSB1c2VkIGZvciB0d28gcHVycG9zZXM6IHRvDQo+IGluZGlj
YXRlIGEgbG9jYXRpb24gaW4gdGhlIGZpbGVzeXN0ZW0gdHJlZSBhbmQgdG8g
cGVyZm9ybQ0KPiBvcGVyYXRpb25zIHRoYXQgYWN0IHB1cmVseSBhdCB0aGUg
ZmlsZSBkZXNjcmlwdG9yIGxldmVsLiAgVGhlDQo+IGZpbGUgaXRzZWxmIGlz
IG5vdCBvcGVuZWQsIGFuZCBvdGhlciBmaWxlIG9wZXJhdGlvbnMgKGUuZy4s
DQo+IHJlYWQoMiksIHdyaXRlKDIpLCBmY2htb2QoMiksIGZjaG93bigyKSwg
ZmdldHhhdHRyKDIpLA0KPiBpb2N0bCgyKSwgbW1hcCgyKSkgZmFpbCB3aXRo
IHRoZSBlcnJvciBFQkFERi4iDQo+IA0KPiBPX1BBVEggZG9lcyBub3Qgb3Bl
biB0aGUgZmlsZSwgc28gZmNob3duIHJldHVybnMgRUJBREYsDQo+IGFzIGl0
IHJlcXVpcmVzIGFuIGZkIG9mIGFuIG9wZW4gZmlsZS4NCg0KSSB0aGluayB5
b3UndmUganVzdCBjb25maXJtZWQgd2hhdCBJIGFscmVhZHkgc2FpZDogSWYg
ZmNob3duYXQgaXMgY2FsbGVkIHdpdGggDQpBVF9FTVBUWV9QQVRILCB3aXRo
IGFuIGVtcHR5IHBhdGhuYW1lLCBhbmQgd2l0aCBkaXJmZCByZWZlcnJpbmcg
dG8gYSBmaWxlIHRoYXQgDQp3YXMgb3BlbmVkIHdpdGggT19QQVRILCB0aGVu
IGZjaG93bmF0IHdpbGwgZmFpbCB3aXRoIEVCQURGLg0KDQpTbyBmb3IgdGhl
IHB1cnBvc2VzIG9mIHRoaXMgcGF0Y2ggc2VyaWVzLCBJIGRvbid0IHNlZSB0
aGUgcG9pbnQgb2YgYWRkaW5nIA0Kc3VwcG9ydCBmb3IgQVRfRU1QVFlfUEFU
SCBpbiBmY2hvd25hdC4NCg0KQW0gSSBtaXNzaW5nIHNvbWV0aGluZz8NCg0K
S2VuDQo=
