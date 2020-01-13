Return-Path: <cygwin-patches-return-9927-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 80360 invoked by alias); 13 Jan 2020 18:50:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 80347 invoked by uid 89); 13 Jan 2020 18:50:09 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.1 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM11-DM6-obe.outbound.protection.outlook.com
Received: from mail-dm6nam11on2139.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) (40.107.223.139) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 13 Jan 2020 18:50:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=hcN3kZkZrNXjTrT428gFpOybPBN5NWkFLx8Jd6iL60BLQHhpnK6mbZRIpy6V2tCRBZbXqucUa648NDH+SdRICJcHlstkeMdaqsC7ATSt3QzlgHthNoDdZ+CmSZeM676eWp9gBzVegs2mLI559+MmYv5WSYezJUE7sCKlhBg7kYBPGSXx/lT0AsXCSkew4MZ7bXGIpq3oULdx1469V2n3mJaJQQmu42Tpcpqz+tU9jU7odP+DDIKsm/aaKIKeq191M61yOntwyQCJJJDZtvG8CRTsmf7cWjcvgkTroshS4PdPwyTZaDKYsbcGomIvJBtCDG5/5MAHMNCqDNZc2u2jbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=g/wrX+pggYJ4RaU39eU80hT3SPArWupGhgcn1abaqF8=; b=iRL7wL8zSbw3MiDUClW7jAZ1QfJCz0bQPhwkxMZrsbqI9MWHvvxg7TaeEbnbnGGVXRLzY5NRdY2ykL74hNEYfW4+pGfSyJcvLDzQQN8xachH57JNMHXqYWxEaGoWxW170O+GvnF3TaGX6WvD8K/YXIaAZLMLVqBIQ3OXejN5CRm3bgEeTFZQG4Gbr2Gpna1VK2N2M3Vf3JDG04F4iVOncRcqotE3izj+skfBZx8VX46wn2l2ZnFtcRg5ptmdrz+biNQlrzC54Nbkvyp4pwYSrAQUeFa6xhdrRvZSEJZY/089xUw2uyxSqalVfPQuDVhS009ixLPCsSbqkh4mPRq1Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=g/wrX+pggYJ4RaU39eU80hT3SPArWupGhgcn1abaqF8=; b=hMSH47Lg1PJK5K/vtUf/1rHrEToRGUh3pXCQ+u88q1gq7EuMXTtOixVkM+j8n78r+TwvTZU0F56jZ/mSrZmihIt7r8r+rXcRx0fHzSJPcxJPKI9Ufm2PVI9QIb3pnrb3IAW65DjLRUP8K/ZWAZT12fTfEwLxUxr2hdwFsa8UTuI=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB7004.namprd04.prod.outlook.com (10.186.142.24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.10; Mon, 13 Jan 2020 18:50:05 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::cc3:c238:852e:5831%7]) with mapi id 15.20.2623.017; Mon, 13 Jan 2020 18:50:05 +0000
Received: from [10.104.13.193] (63.148.235.187) by BN8PR07CA0034.namprd07.prod.outlook.com (2603:10b6:408:ac::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend Transport; Mon, 13 Jan 2020 18:50:05 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v2 0/3] Support opening a symlink with O_PATH | O_NOFOLLOW
Date: Mon, 13 Jan 2020 18:50:00 -0000
Message-ID: <4f47501c-9a21-8ba0-79d6-6ddf18db20b0@cornell.edu>
References: <20191229175637.1050-1-kbrown@cornell.edu> <20200113152809.GE5858@calimero.vinschen.de> <9f83d272-2dad-f652-d0c8-f3eb3b425ac2@cornell.edu> <20200113183430.GR5858@calimero.vinschen.de> <20200113183952.GS5858@calimero.vinschen.de>
In-Reply-To: <20200113183952.GS5858@calimero.vinschen.de>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101 Thunderbird/68.3.1
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:9508;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <95CD16F08802904394F6C2CE56DD725E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MJN4UUsB1I+szqKTZ5F50NIoL2Yelp4ZDC+oJR2VbjYK5hqs3NeAlH9yRLV04bbjXiFcP21R0l3VygsZ+mN2pQ==
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00033.txt

T24gMS8xMy8yMDIwIDE6MzkgUE0sIENvcmlubmEgVmluc2NoZW4gd3JvdGU6
DQo+IE9uIEphbiAxMyAxOTozNCwgQ29yaW5uYSBWaW5zY2hlbiB3cm90ZToN
Cj4+IE9uIEphbiAxMyAxNjo1MywgS2VuIEJyb3duIHdyb3RlOg0KPj4+IE9u
IDEvMTMvMjAyMCAxMDoyOCBBTSwgQ29yaW5uYSBWaW5zY2hlbiB3cm90ZToN
Cj4+Pj4gT24gRGVjIDI5IDE3OjU2LCBLZW4gQnJvd24gd3JvdGU6DQo+Pj4+
PiBbLi4uXQ0KPj4+Pj4gTm90ZTogVGhlIG1hbiBwYWdlIG1lbnRpb25zIGZj
aG93bmF0IGFuZCBsaW5rYXQgYWxzby4gIGxpbmthdCBhbHJlYWR5DQo+Pj4+
PiBzdXBwb3J0cyB0aGUgQVRfRU1QVFlfUEFUSCBmbGFnLCBzbyBub3RoaW5n
IG5lZWRzIHRvIGJlIGRvbmUuICBCdXQgSQ0KPj4+Pj4gZG9uJ3QgdW5kZXJz
dGFuZCBob3cgdGhpcyBjb3VsZCB3b3JrIGZvciBmY2hvd25hdCwgYmVjYXVz
ZSBmY2hvd24NCj4+Pj4+IGZhaWxzIHdpdGggRUJBREYgaWYgaXRzIGZkIGFy
Z3VtZW50IHdhcyBvcGVuZWQgd2l0aCBPX1BBVEguICBTbyBJDQo+Pj4+PiBo
YXZlbid0IHRvdWNoZWQgZmNob3duYXQuDQo+Pj4+DQo+Pj4+IEl0IHdhcyBu
ZXZlciBzdXBwb3NlZCB0byB3b3JrIHRoYXQgd2F5LiAgV2UgY2FuIG1ha2Ug
ZmNob3duYXQgd29yaw0KPj4+PiB3aXRoIEFUX0VNUFRZX1BBVEgsIGJ1dCB1
c2luZyBpdCBvbiBhIGZpbGUgb3BlbmVkIHdpdGggT19QQVRIDQo+Pj4+IGNv
bnRyYWRpY3RzIHRoZSBMaW51eCBvcGVuKDIpIG1hbiBwYWdlLCBhZmFpY3M6
DQo+Pj4+DQo+Pj4+ICAgIE9fUEFUSCAoc2luY2UgTGludXggMi42LjM5KQ0K
Pj4+PiAgICAgT2J0YWluIGEgZmlsZSBkZXNjcmlwdG9yIHRoYXQgY2FuIGJl
IHVzZWQgZm9yIHR3byAgcHVycG9zZXM6ICB0bw0KPj4+PiAgICAgaW5kaWNh
dGUgYSBsb2NhdGlvbiBpbiB0aGUgZmlsZXN5c3RlbSB0cmVlIGFuZCB0byBw
ZXJmb3JtIG9wZXJh4oCQDQo+Pj4+ICAgICB0aW9ucyB0aGF0IGFjdCBwdXJl
bHkgYXQgdGhlIGZpbGUgZGVzY3JpcHRvciAgbGV2ZWwuICAgVGhlICBmaWxl
DQo+Pj4+ICAgICBpdHNlbGYgIGlzIG5vdCBvcGVuZWQsIGFuZCBvdGhlciBm
aWxlIG9wZXJhdGlvbnMgKGUuZy4sIHJlYWQoMiksDQo+Pj4+ICAgICB3cml0
ZSgyKSwgZmNobW9kKDIpLCBmY2hvd24oMiksIGZnZXR4YXR0cigyKSwgaW9j
dGwoMiksIG1tYXAoMikpDQo+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICBeXl5eXl5eXl4NCj4+Pj4gICAgIGZhaWwgd2l0aCB0aGUgZXJyb3IgRUJB
REYuDQo+Pj4+ICAgICBeXl5eXl5eXl4gICAgICAgICAgIF5eXl5eDQo+Pj4+
DQo+Pj4+IFRoYXQnZCBmcm9tIHRoZSBjdXJyZW50IEYzMSBtYW4gcGFnZXMu
DQo+Pj4+DQo+Pj4+PiBBbSBJIG1pc3Npbmcgc29tZXRoaW5nPw0KPj4+Pg0K
Pj4+PiBHb29kIHF1ZXN0aW9uLiAgTGV0IG1lIGFzayBpbiByZXR1cm4sIGRp
ZCAqSSogbm93IG1pc3Mgc29tZXRoaW5nPw0KPj4+DQo+Pj4gSSBkb24ndCB0
aGluayBzby4gIEkgdGhpbmsgd2UgYWdyZWUsIGFsdGhvdWdoIG1heWJlIEkg
ZGlkbid0IGV4cHJlc3MgbXlzZWxmDQo+Pj4gY2xlYXJseSBlbm91Z2ggZm9y
IHRoYXQgdG8gYmUgb2J2aW91cy4gIFdoYXQgY29uZnVzZWQgbWUgd2FzIHRo
ZSBmb2xsb3dpbmcNCj4+PiBwYXJhZ3JhcGggZnVydGhlciBkb3duIGluIHRo
ZSBvcGVuKDIpIG1hbiBwYWdlIChzdGlsbCBkaXNjdXNzaW5nIE9fUEFUSCk6
DQo+Pj4NCj4+PiAgICAgSWYgcGF0aG5hbWUgaXMgYSBzeW1ib2xpYyBsaW5r
IGFuZCB0aGUgT19OT0ZPTExPVyBmbGFnIGlzIGFsc28NCj4+PiAgICAgc3Bl
Y2lmaWVkLCB0aGVuIHRoZSBjYWxsIHJldHVybnMgYSBmaWxlIGRlc2NyaXB0
b3IgcmVmZXJyaW5nDQo+Pj4gICAgIHRvIHRoZSBzeW1ib2xpYyBsaW5rLiAg
VGhpcyBmaWxlIGRlc2NyaXB0b3IgY2FuIGJlIHVzZWQgYXMgdGhlDQo+Pj4g
ICAgIGRpcmZkIGFyZ3VtZW50IGluIGNhbGxzIHRvIGZjaG93bmF0KDIpLCBm
c3RhdGF0KDIpLCBsaW5rYXQoMiksDQo+Pj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIF5eXl5eXl5eXl5eDQo+Pj4gICAgIGFuZCByZWFkbGlu
a2F0KDIpIHdpdGggYW4gZW1wdHkgcGF0aG5hbWUgdG8gaGF2ZSB0aGUgY2Fs
bHMNCj4+PiAgICAgb3BlcmF0ZSBvbiB0aGUgc3ltYm9saWMgbGluay4NCj4+
DQo+PiBUaGF0J3MgdGhlIHBhcnQgSSBtaXNzZWQsIGFwcGFyZW50bHkuICBJ
bXBsZW1lbnRpbmcgZmNob3duYXQgbGlrZSB0aGlzDQo+PiBtYXkgYmUgYSBi
aXQgdXBzaWRlIGRvd24uICBUaGUgcHJvYmxlbSBpcyB0aGF0IG9wZW4oT19Q
QVRIKSBvcGVucyB0aGUNCj4+IGZpbGUgd2l0aCBxdWVyeV9yZWFkX2F0dHJp
YnV0ZXMgKGFrYSBSRUFEX0NPTlRST0wgfCBGSUxFX1JFQURfQVRUUklCVVRF
UyksDQo+PiB0byBtYWtlIHN1cmUgdGhlIGNhbGxzIG1lbnRpb25lZCBpbiB0
aGUgc25pcHBldCBJIHBhc3RlZCBkb24ndCBzdWNjZWVkLg0KPj4NCj4+IElm
IGZjaG93bmF0IGlzIHN1cHBvc2VkIHRvIHdvcmsgb24gYSBzeW1saW5rIGxp
a2UgdGhpcywgdGhlIGVhc2llc3QNCj4+IGFwcHJvYWNoIG1heSBiZSBjaGVj
a2luZyBmb3IgdGhpcyBzY2VuYXJpbyBpbiBmY2hvd25hdCBhbmQgY2FsbGlu
Zw0KPj4gbGNob3duIG9uIHRoZSBwYXRobmFtZSBpbnN0ZWFkLiAgT3Igc29t
ZXRoaW5nIGFsb25nIHRoZXNlIGxpbmVzLg0KPiANCj4gVGhlIGFsdGVybmF0
aXZlIHdvdWxkIGJlIHRvIG9wZW4gdGhlIHN5bGluayB3aXRoIG1vcmUgcGVy
bWlzc2lvbnMsIGkuZS4sDQo+IHF1ZXJ5X3dyaXRlX2NvbnRyb2wsIGFrYSBS
RUFEX0NPTlRST0wgfCBXUklURV9PV05FUiB8IFdSSVRFX0RBQyB8DQo+IEZJ
TEVfV1JJVEVfQVRUUklCVVRFUy4gIEknbSBqdXN0IGhlc2l0YW50IHRvIG9w
ZW4gdXAgdGhlIGRlc2NyaXB0b3INCj4gbGlrZSB0aGlzLiAgSXQgcHJvYmFi
bHkgYWxsb3dzIHRvbyBtYW55IGFjdGlvbnMgb24gdGhlIGRlc2NyaXB0b3IN
Cj4gZnJvbSB1c2VyIHNwYWNlLi4uDQoNCk9LLCBJJ2xsIGZvbGxvdyB5b3Vy
IGZpcnN0IHN1Z2dlc3Rpb24sIHRoZW4sIGFmdGVyIHZlcmlmeWluZyB0aGF0
IGZjaG93bmF0IA0KcmVhbGx5IGRvZXMgd29yayBvbiBhIHN5bWxpbmsgb3Bl
bmVkIHRoaXMgd2F5IG9uIExpbnV4LiAgSSBndWVzcyBJIHdhcyANCm1pc2lu
dGVycHJldGluZyB0aGUgbWFuIHBhZ2UuDQoNCktlbg0K
