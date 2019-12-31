Return-Path: <cygwin-patches-return-9893-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21831 invoked by alias); 31 Dec 2019 00:03:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 21821 invoked by uid 89); 31 Dec 2019 00:03:18 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.4 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=H*MI:sk:0dee006, H*f:sk:0dee006, H*i:sk:0dee006
X-HELO: NAM11-CO1-obe.outbound.protection.outlook.com
Received: from mail-co1nam11on2102.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) (40.107.220.102) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 31 Dec 2019 00:03:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=gWX5fh1RfzDeHbTL8lg23WDUSTRqJrGEI5x8+mx3Uymn+/oTr+PUBntsg++KUfs2dmtfSoZKqDopYN4VGb00QJ4A4wk9xYRDyDxESmftPukEVxyYdmRvAdUkFPh5/iUprPlOC9hoDh2YNMNyag6zUf/hCwNG9fT+wO3+m6StPtHnkyUxPjqfgrY1mggXl4Sd+gnn8Fs36E6cmExNYKumPjXXQyGE7/u1Tnf0308vaOXiF2x577ie3z7H+XTjEptlEtRVrnezmzHrwZNMdMGAZUUDN9JyFqyM/Hs2W+uKNIq+1kstCoO63WwFI1j7c95FmjyQ7Ilc6fraTSWWNIhzUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=U9d23Amz06OoJzE8KnIvyo0JCFdd/J9pxXIOOUl2YtU=; b=JIZQHA05kfxvD9tcI1ypp8+CoPnIlp2qQxZemtmi2QoDpBefBz74j5FHBkt92ykVo+2BAc1cKpiF+GAx2pB68qn5Bp3YlHbchKF//YqJhtAhCvT/ukscVSp4sIKKgeefGP4BgmVi2wVzwBZOfvJid5C4UmuyGbiydFlAtbsVbBJeBUHoWsu4/frjgqEo0Z+s9dAUWeHI4gSjib+MV5jx8TP+iAnzieENCxGy6FRpXxmvJZGPbxGCYDqUTf+mso3lklEMV3nrDwz4j7JuNFL4dTOHlXLLIZ40pySJddAEev4Jf5k1MYsY0VyCWkt+oJbdaXg3WR6Lvzroj3zbkbjLfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=U9d23Amz06OoJzE8KnIvyo0JCFdd/J9pxXIOOUl2YtU=; b=A0+UBHqi9OuOuGTM+LSWR7vp3n+nAq/LL78IONmHpp8590VY4sbYiyhL0d6X7ELU65Jr9dA+3e4JNaQnBTCpFrjCS2dU0NhlwwJXHeFWjqYg4vQHc3RX9tOKlPa+HEHMIz41C4JJo8BHaMoTAlR+1Ha6Si8ml9r8+fBE89HQadM=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB4266.namprd04.prod.outlook.com (20.176.76.31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.12; Tue, 31 Dec 2019 00:03:13 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::f894:edec:b80c:d524]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::f894:edec:b80c:d524%3]) with mapi id 15.20.2581.007; Tue, 31 Dec 2019 00:03:13 +0000
Received: from [192.168.0.19] (68.175.129.7) by CH2PR19CA0002.namprd19.prod.outlook.com (2603:10b6:610:4d::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend Transport; Tue, 31 Dec 2019 00:03:13 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v2 0/3] Support opening a symlink with O_PATH | O_NOFOLLOW
Date: Tue, 31 Dec 2019 00:03:00 -0000
Message-ID: <caf4f32c-640a-f520-9376-f7eae2e2c904@cornell.edu>
References: <20191229175637.1050-1-kbrown@cornell.edu> <d88c5dee-9457-3c39-960c-ea07842cd0c5@SystematicSw.ab.ca> <aafbc75d-11db-0faf-6e13-72681c5784a3@cornell.edu> <f964457b-9d33-a252-3cc9-e035a4fe1c1a@SystematicSw.ab.ca> <9d5d81ad-9692-1e4d-b693-ef5a287c1377@cornell.edu> <0dee006c-f675-2d4b-d497-6e69c797fcca@SystematicSw.ab.ca>
In-Reply-To: <0dee006c-f675-2d4b-d497-6e69c797fcca@SystematicSw.ab.ca>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.1
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:10000;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E27118CB8DE66F4099435F6CBDEED04B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bVMbRAq2+r1AnVNNe03D7X0l/voGoltO06opAmvdhgtPLAa0QQ69H75suhn/2dasJcGR7U1udvRFWHlORWjIlw==
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00164.txt.bz2

T24gMTIvMzAvMjAxOSA2OjA5IFBNLCBCcmlhbiBJbmdsaXMgd3JvdGU6DQo+
IE9uIDIwMTktMTItMzAgMTQ6NDcsIEtlbiBCcm93biB3cm90ZToNCj4+IE9u
IDEyLzMwLzIwMTkgMzo1NSBQTSwgQnJpYW4gSW5nbGlzIHdyb3RlOg0KPj4+
IE9uIDIwMTktMTItMzAgMTI6NTMsIEtlbiBCcm93biB3cm90ZToNCj4+Pj4g
T24gMTIvMzAvMjAxOSAyOjE4IFBNLCBCcmlhbiBJbmdsaXMgd3JvdGU6DQo+
Pj4+PiBPbiAyMDE5LTEyLTI5IDEwOjU2LCBLZW4gQnJvd24gd3JvdGU6DQo+
Pj4+Pj4gQ3VycmVudGx5LCBvcGVuaW5nIGEgc3ltbGluayB3aXRoIE9fTk9G
T0xMT1cgZmFpbHMgd2l0aCBFTE9PUC4NCj4+Pj4+PiBGb2xsb3dpbmcgTGlu
dXgsIHRoZSBmaXJzdCBwYXRjaCBpbiB0aGlzIHNlcmllcyBhbGxvd3MgdGhl
IGNhbGwgdG8NCj4+Pj4+PiBzdWNjZWVkIGlmIE9fUEFUSCBpcyBhbHNvIHNw
ZWNpZmllZC4NCj4+Pj4+Pg0KPj4+Pj4+IEFjY29yZGluZyB0byB0aGUgTGlu
dXggbWFuIHBhZ2UgZm9yICdvcGVuJywgdGhlIGZpbGUgZGVzY3JpcHRvcg0K
Pj4+Pj4+IHJldHVybmVkIGJ5IHRoZSBjYWxsIHNob3VsZCBiZSB1c2FibGUg
YXMgdGhlIGRpcmZkIGFyZ3VtZW50IGluIGNhbGxzDQo+Pj4+Pj4gdG8gZnN0
YXRhdCBhbmQgcmVhZGxpbmthdCB3aXRoIGFuIGVtcHR5IHBhdGhuYW1lLCB0
byBoYXZlDQo+Pj4+Pj4gdGhlIGNhbGxzIG9wZXJhdGUgb24gdGhlIHN5bWJv
bGljIGxpbmsuICBUaGUgc2Vjb25kIGFuZCB0aGlyZCBwYXRjaGVzDQo+Pj4+
Pj4gYWNoaWV2ZSB0aGlzLiAgRm9yIGZzdGF0YXQsIHdlIGRvIHRoaXMgYnkg
YWRkaW5nIHN1cHBvcnQNCj4+Pj4+PiBmb3IgdGhlIEFUX0VNUFRZX1BBVEgg
ZmxhZy4NCj4+Pj4+Pg0KPj4+Pj4+IE5vdGU6IFRoZSBtYW4gcGFnZSBtZW50
aW9ucyBmY2hvd25hdCBhbmQgbGlua2F0IGFsc28uICBsaW5rYXQgYWxyZWFk
eQ0KPj4+Pj4+IHN1cHBvcnRzIHRoZSBBVF9FTVBUWV9QQVRIIGZsYWcsIHNv
IG5vdGhpbmcgbmVlZHMgdG8gYmUgZG9uZS4gIEJ1dCBJDQo+Pj4+Pj4gZG9u
J3QgdW5kZXJzdGFuZCBob3cgdGhpcyBjb3VsZCB3b3JrIGZvciBmY2hvd25h
dCwgYmVjYXVzZSBmY2hvd24NCj4+Pj4+PiBmYWlscyB3aXRoIEVCQURGIGlm
IGl0cyBmZCBhcmd1bWVudCB3YXMgb3BlbmVkIHdpdGggT19QQVRILiAgU28g
SQ0KPj4+Pj4+IGhhdmVuJ3QgdG91Y2hlZCBmY2hvd25hdC4NCj4+Pj4+Pg0K
Pj4+Pj4+IEFtIEkgbWlzc2luZyBzb21ldGhpbmc/DQo+Pj4+Pg0KPj4+Pj4g
V1NMICQgbWFuIDIgY2hvd24NCj4+Pj4+IC4uLg0KPj4+Pj4gIkFUX0VNUFRZ
X1BBVEggKHNpbmNlIExpbnV4IDIuNi4zOSkNCj4+Pj4+IElmIHBhdGhuYW1l
IGlzIGFuIGVtcHR5IHN0cmluZywgb3BlcmF0ZSBvbiB0aGUgZmlsZSByZWZl
cnJlZCB0bw0KPj4+Pj4gYnkgZGlyZmQgKHdoaWNoIG1heSBoYXZlIGJlZW4g
b2J0YWluZWQgdXNpbmcgdGhlIG9wZW4oMikgT19QQVRIDQo+Pj4+PiBmbGFn
KS4gSW4gIHRoaXMgY2FzZSwgZGlyZmQgY2FuIHJlZmVyIHRvIGFueSB0eXBl
IG9mIGZpbGUsIG5vdA0KPj4+Pj4ganVzdCBhIGRpcmVjdG9yeS4gSWYgZGly
ZmQgaXMgQVRfRkRDV0QsIHRoZSAgY2FsbCBvcGVyYXRlcyBvbg0KPj4+Pj4g
dGhlIGN1cnJlbnQgd29ya2luZyBkaXJlY3RvcnkuIFRoaXMgZmxhZyBpcyBM
aW51eC1zcGVjaWZpYzsgZGXigJANCj4+Pj4+IGZpbmUgX0dOVV9TT1VSQ0Ug
dG8gb2J0YWluIGl0cyBkZWZpbml0aW9uLiINCj4+Pj4+DQo+Pj4+PiBzYXlz
IGNob3duIHRoZSBkaXJmZCwgcmVnYXJkbGVzcyBvZiB3aGF0IGl0IGlzLA0K
Pj4+Pj4gZXhjZXB0IGlmIEFUX0ZEQ1dELCBjaG93biB0aGUgQ1dELg0KPj4+
Pj4NCj4+Pj4+IFdTTCAkIG1hbiAyIG9wZW4NCj4+Pj4+ICJPX1BBVEggKHNp
bmNlIExpbnV4IDIuNi4zOSkNCj4+Pj4+IE9idGFpbiBhIGZpbGUgZGVzY3Jp
cHRvciB0aGF0IGNhbiBiZSB1c2VkIGZvciB0d28gcHVycG9zZXM6IHRvDQo+
Pj4+PiBpbmRpY2F0ZSBhIGxvY2F0aW9uIGluIHRoZSBmaWxlc3lzdGVtIHRy
ZWUgYW5kIHRvIHBlcmZvcm0NCj4+Pj4+IG9wZXJhdGlvbnMgdGhhdCBhY3Qg
cHVyZWx5IGF0IHRoZSBmaWxlIGRlc2NyaXB0b3IgbGV2ZWwuICBUaGUNCj4+
Pj4+IGZpbGUgaXRzZWxmIGlzIG5vdCBvcGVuZWQsIGFuZCBvdGhlciBmaWxl
IG9wZXJhdGlvbnMgKGUuZy4sDQo+Pj4+PiByZWFkKDIpLCB3cml0ZSgyKSwg
ZmNobW9kKDIpLCBmY2hvd24oMiksIGZnZXR4YXR0cigyKSwNCj4+Pj4+IGlv
Y3RsKDIpLCBtbWFwKDIpKSBmYWlsIHdpdGggdGhlIGVycm9yIEVCQURGLiIN
Cj4+Pj4+DQo+Pj4+PiBPX1BBVEggZG9lcyBub3Qgb3BlbiB0aGUgZmlsZSwg
c28gZmNob3duIHJldHVybnMgRUJBREYsDQo+Pj4+PiBhcyBpdCByZXF1aXJl
cyBhbiBmZCBvZiBhbiBvcGVuIGZpbGUuDQo+Pj4+DQo+Pj4+IEkgdGhpbmsg
eW91J3ZlIGp1c3QgY29uZmlybWVkIHdoYXQgSSBhbHJlYWR5IHNhaWQ6IElm
IGZjaG93bmF0IGlzIGNhbGxlZCB3aXRoDQo+Pj4+IEFUX0VNUFRZX1BBVEgs
IHdpdGggYW4gZW1wdHkgcGF0aG5hbWUsIGFuZCB3aXRoIGRpcmZkIHJlZmVy
cmluZyB0byBhIGZpbGUgdGhhdA0KPj4+PiB3YXMgb3BlbmVkIHdpdGggT19Q
QVRILCB0aGVuIGZjaG93bmF0IHdpbGwgZmFpbCB3aXRoIEVCQURGLg0KPj4+
Pg0KPj4+PiBTbyBmb3IgdGhlIHB1cnBvc2VzIG9mIHRoaXMgcGF0Y2ggc2Vy
aWVzLCBJIGRvbid0IHNlZSB0aGUgcG9pbnQgb2YgYWRkaW5nDQo+Pj4+IHN1
cHBvcnQgZm9yIEFUX0VNUFRZX1BBVEggaW4gZmNob3duYXQuDQo+Pj4+DQo+
Pj4+IEFtIEkgbWlzc2luZyBzb21ldGhpbmc/DQo+Pj4NCj4+PiBUaGF0IGlz
IHRoZSB1c2VyJ3MgcHJvYmxlbTogaXQgaXMgdGhlaXIgcmVzcG9uc2liaWxp
dHkgdG8gcGFzcyBhbiBmZCBvcGVuIGZvcg0KPj4+IHJlYWRpbmcgb3Igc2Vh
cmNoaW5nLCBub3Qgb25lIG9wZW5lZCB3aXRoIE9fUEFUSCAob24gTGludXgg
b3IgQ3lnd2luKSwgb3INCj4+PiBBVF9GRENXRDsgaXQgaXMgQ3lnd2luJ3Mg
cmVzcG9uc2liaWxpdHkgdG8gZW5zdXJlIHRoYXQgdmFsaWQgYXJncyBzdWNj
ZWVkIGFuZA0KPj4+IGludmFsaWQgYXJncyByZXR1cm4gdGhlIGV4cGVjdGVk
IGVycm5vLg0KPj4NCj4+IFllcywgYnV0IEN5Z3dpbiBkb2Vzbid0IGNsYWlt
IHRvIHN1cHBvcnQgdGhlIEFUX0VNUFRZX1BBVEggZmxhZyBleGNlcHQgaW4N
Cj4+IGxpbmthdC4gIFNvIHRoZXJlIGlzIG5vIGV4cGVjdGVkIGVycm5vLiAg
VGhlIG9ubHkgd2F5IHRoZXJlIHdvdWxkIGJlIGFuIGV4cGVjdGVkDQo+PiBl
cnJubyBpcyBpZiB3ZSBkZWNpZGUgdG8gYWRkIHN1cHBvcnQgZm9yIEFUX0VN
UFRZX1BBVEggdG8gZmNob3duYXQuICBJJ20gc2F5aW5nDQo+PiB0aGF0IEkg
ZG9uJ3Qgc2VlIHRoZSBwb2ludCBpbiBkb2luZyB0aGF0LCBhbmQgSSdtIGFz
a2luZyB3aGV0aGVyIEknbSBtaXNzaW5nDQo+PiBzb21ldGhpbmcuICBJZiB5
b3UgdGhpbmsgSSBzaG91bGQgYWRkIHRoYXQgc3VwcG9ydCwgcGxlYXNlIGV4
cGxhaW4gd2h5Lg0KPiANCj4gVG8gYWxsb3cgcGVybXMgY2hhbmdlZCBvbiB0
aGUgY3dkLCBkaXJlY3RvcmllcyBvciBmaWxlcyB3aXRoIGFuIG9wZW4gZmQs
IHRvDQo+IGF2b2lkIHJhY2UgY29uZGl0aW9ucywgbGlrZSB0aGUgb3RoZXIg
Li4uYXQgZnVuY3Rpb25zLg0KPiBJIGRvbid0IGdldCB3aHkgeW91IGRvbid0
IHNlZSB0aG9zZSBhcyB1c2VmdWwgY2FzZXMuDQoNCkkgdGhpbmsgd2UncmUg
bWlzLWNvbW11bmljYXRpbmcuICBUaGlzIGlzIGEgcGF0Y2ggc2VyaWVzIHdo
b3NlIHB1cnBvc2UgaXMgdG8gYWRkIA0Kc3VwcG9ydCBmb3Igb3BlbmluZyBh
IHN5bWxpbmsgd2l0aCBPX1BBVEggfCBPX05PRk9MTE9XLiAgSW4gdGhhdCBj
b25uZWN0aW9uIEkgDQptb2RpZmllZCByZWFkbGlua2F0IGFuZCBmc3RhdGF0
IHRvIGFsbG93IHRoZSByZXN1bHRpbmcgZmQgdG8gYmUgdXNlZCBhcyB0aGUg
DQpkaXJmZCBhcmd1bWVudCBpbiB0aG9zZSBjYWxscywgd2l0aCBhbiBlbXB0
eSBwYXRobmFtZS4gIEkgZGlkbid0IGRvIHRoZSBzYW1lIGZvciANCmZjaG93
bmF0IGJlY2F1c2UgaXQgc2VlbXMgdG8gbWUgdGhhdCBpdCB3b3VsZCBhbHdh
eXMgZmFpbCB3aXRoIEVCQURGIGluIHRoYXQgDQpzZXR0aW5nLg0KDQpJdCdz
IG5vdCByZWxldmFudCB0aGF0IEFUX0VNUFRZX1BBVEggbWlnaHQgYmUgdXNl
ZnVsIGZvciBmY2hvd25hdCBpbiBhIGRpZmZlcmVudCANCnNldHRpbmcuICBU
aGF0IGNvdWxkIGJlIHRoZSBzdWJqZWN0IG9mIGEgZGlmZmVyZW50IHBhdGNo
LiAgSWYgeW91IHRoaW5rIGl0IHdvdWxkIA0KYmUgdXNlZnVsICppbiB0aGUg
Y29udGV4dCBvZiB0aGlzIHBhdGNoIHNlcmllcyosIHBsZWFzZSBleHBsYWlu
IHdoeS4NCg0KS2VuDQo=
