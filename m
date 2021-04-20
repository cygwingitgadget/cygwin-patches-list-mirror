Return-Path: <bT.ug0yl43q30=cm3b6l3tmnzz=6hkgu0hlz9@return.smtpservice.net>
Received: from e2i632.smtp2go.com (e2i632.smtp2go.com [103.2.142.120])
 by sourceware.org (Postfix) with ESMTPS id C700C385043C
 for <cygwin-patches@cygwin.com>; Tue, 20 Apr 2021 12:34:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C700C385043C
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cl.cam.ac.uk
Authentication-Results: sourceware.org; spf=pass
 smtp.mailfrom=bT.ug0yl43q30=cm3b6l3tmnzz=6hkgu0hlz9@return.smtpservice.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=smtpservice.net; s=md6hz0.a1-4.dyn; x=1618922992; h=Feedback-ID:
 X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
 List-Unsubscribe; bh=a4ttuGLvDjrC7hGtkv5TTN9d0Ij9KgCHIT6PZUk7Mno=; b=agrJ+uTQ
 shy6CjfApZZIP3oUB+NT5B9prz37V6di2Shfalzy8H9HdUVB6hko7FXHxIotQSTPl3fBFxUWNRc8j
 A4cNSPsyB33cBHiKiRoG/1vSNfyClYlIFdAjOjZQP07eHdlMD0OFEDfRmKHBUmqbmJuqspc3Ehuz5
 pEgAC3QtW11c+2VbnLW7YN11CWB1V7Oou6ag71qjNW5jU+3A5YrSDpojyaca0NCR7IuH5UDE36iDT
 sF/csmT9Plbz2DLUfX/oJMLtQbnDyVNJcVzFlNzZvs+/Y6I2zzoSR9difLJkumdlUa854ghRXuica
 HL9JI2iMWTMmc2wh4TQIQfJdAQ==;
Received: from [10.139.162.187] (helo=SmtpCorp)
 by smtpcorp.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92-S2G) (envelope-from <David.Allsopp@cl.cam.ac.uk>)
 id 1lYpad-qt4GrX-1w
 for cygwin-patches@cygwin.com; Tue, 20 Apr 2021 12:34:51 +0000
Received: from [10.62.31.23] (helo=romulus.metastack.com)
 by smtpcorp.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.92-S2G) (envelope-from <David.Allsopp@cl.cam.ac.uk>)
 id 1lYpac-4XaBvM-P8
 for cygwin-patches@cygwin.com; Tue, 20 Apr 2021 12:34:50 +0000
Received: from remus.metastack.local (usr233-bra.static.cable.virginmedia.com
 [62.31.23.243] (may be forged))
 by romulus.metastack.com (8.14.2/8.14.2) with ESMTP id 13KCYmbP011176
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
 for <cygwin-patches@cygwin.com>; Tue, 20 Apr 2021 13:34:48 +0100
Received: from Hermes.metastack.local (172.16.0.8) by Hermes.metastack.local
 (172.16.0.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 20 Apr
 2021 13:35:15 +0100
Received: from Hermes.metastack.local ([fe80::210d:d258:cd04:7b5a]) by
 Hermes.metastack.local ([fe80::210d:d258:cd04:7b5a%3]) with mapi id
 15.01.2176.012; Tue, 20 Apr 2021 13:35:15 +0100
From: David Allsopp <David.Allsopp@cl.cam.ac.uk>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: RE: [PATCH 0/2] Fix race issues.
Thread-Topic: [PATCH 0/2] Fix race issues.
Thread-Index: AQHXNQc9EDmd9R2K10mMM7H0VsxPRKq9CLAAgABQDvA=
Date: Tue, 20 Apr 2021 12:35:14 +0000
Message-ID: <af0120f9f5a24adbbe7c582b7d1d3082@metastack.com>
References: <20210419103046.21838-1-takashi.yano@nifty.ne.jp>
 <YH6VEDovWFJ2y1pI@calimero.vinschen.de>
In-Reply-To: <YH6VEDovWFJ2y1pI@calimero.vinschen.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.0.125]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.65 on 62.31.23.242
X-Smtpcorp-Track: 1_Ypac4baUvue8.fnprd6hNRes_Q
Feedback-ID: 614951m:614951apMmpqs:614951sAQqrMbm_h
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_05, DKIMWL_WL_MED,
 DKIM_SIGNED, DKIM_VALID, DKIM_VALID_EF, HEADER_FROM_DIFFERENT_DOMAINS,
 SPF_HELO_PASS, SPF_PASS, TXREP autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 20 Apr 2021 12:35:03 -0000

Q29yaW5uYSBWaW5zY2hlbiB3cm90ZToNCj4gT24gQXByIDE5IDE5OjMwLCBUYWthc2hpIFlhbm8g
d3JvdGU6DQo+ID4gVGFrYXNoaSBZYW5vICgyKToNCj4gPiAgIEN5Z3dpbjogY29uc29sZTogRml4
IHJhY2UgaXNzdWUgcmVnYXJkaW5nIGNvbnNfbWFzdGVyX3RocmVhZCgpLg0KPiA+ICAgQ3lnd2lu
OiBwdHk6IEZpeCByYWNlIGlzc3VlIGluIGluaGVyaXRhbmNlIG9mIHBzZXVkbyBjb25zb2xlLg0K
PiA+DQo+ID4gIHdpbnN1cC9jeWd3aW4vZmhhbmRsZXJfY29uc29sZS5jYyB8ICAxMCArKy0NCj4g
PiAgd2luc3VwL2N5Z3dpbi9maGFuZGxlcl90dHkuY2MgICAgIHwgMTA4ICsrKysrKysrKysrKysr
KysrKy0tLS0tLS0tLS0tLQ0KPiA+ICB3aW5zdXAvY3lnd2luL3R0eS5jYyAgICAgICAgICAgICAg
fCAgMTUgKystLS0NCj4gPiAgd2luc3VwL2N5Z3dpbi90dHkuaCAgICAgICAgICAgICAgIHwgICAy
ICstDQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwgNzcgaW5zZXJ0aW9ucygrKSwgNTggZGVsZXRpb25z
KC0pDQo+ID4NCj4gPiAtLQ0KPiA+IDIuMzEuMQ0KPiANCj4gUHVzaGVkLg0KDQpBcm1lZCB3aXRo
IHRoaXMgbW9ybmluZydzIEN5Z3dpbiBzbmFwc2hvdCwgT0NhbWwgYnVpbGRzIGFnYWluIGFzIHdl
bGwuIE1hbnkgdGhhbmtzIQ0KDQoNCkRhdmlkDQo=
