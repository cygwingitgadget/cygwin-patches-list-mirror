Return-Path: <cygwin-patches-return-9522-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22765 invoked by alias); 24 Jul 2019 19:01:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 22635 invoked by uid 89); 24 Jul 2019 19:01:25 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=1.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,SEM_URI,SEM_URIRED,SPF_HELO_PASS,SPF_PASS autolearn=no version=3.3.1 spammy=
X-HELO: NAM02-CY1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr760099.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) (40.107.76.99) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 24 Jul 2019 19:01:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=aKBvkM7cUv+LOl7Z1jCiALfKg+A3SFrmVk16JMFcKwJoXfVoBL2e0PygxgEu/iSj1vdlMvymiCd0DL3i0zkyDP/2qbMP1Q9m7S+zCP14tpreKbPBwSbyFxR1vJ8vwd4R+ww/FYDavPZrE33yFT9Qv3vULtEpWNrECb8Uw/3ERHjSMkxSrdlMn8oi2WGASFGJgzWhoHw+hDQ1qlhlEPWST4mbPbZ0k+y2MN1Ipk/oh2Uj/Y/gK2WPJxnzUzdN2PjqLs6bdWxSJodzx7cnP9jxQMW2HyXULTeIaCcK1suxe/h9aAEeiQxHu5WlTP9Q2yGS7sSc/L+aeSUwIpBcD6xyYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=+uGACYX6YyZHPARSbBpxDsjj1dS3m3jYhhJ8vD8kWj8=; b=ablDOb+MvT9Ovq13DUGSiGQ+IO8h6ix6wmiE8CuniIEIOrToxEu08AVuc6cRdqhXhebbYK8sP54cgPEKdBnObNxIBDg5YTt9Fnm38Myb2UOeNw7GnQ7ZyNNXqQjihQ7JEWw2jRgKuN2v8OWTtDR2O1SqawPVD9lr1tn7Clu/QKG86iksK2Y4HNCeGy9pQYV1cOUa7odiAFBwZn3/tElGzqADrOQTYjiYFXH9qPQnvSMaSlh+uQ8rY1SxHv0oxP0SFgeGjFLSsyav2AuloS8SO0aP7nTClyJ+fltiWZgIlA3lrlL5lXWRBlNCE7Jy6u1BG9CnVAuPzuON7MqMaJsavQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass smtp.mailfrom=cornell.edu;dmarc=pass action=none header.from=cornell.edu;dkim=pass header.d=cornell.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=+uGACYX6YyZHPARSbBpxDsjj1dS3m3jYhhJ8vD8kWj8=; b=T4+aDJZz+MkhYYqm025t5yBHNgd7wPwYfknxUtGHjZNpToRVKU5XUyWJyoTkdnP029MGkNLSHd9oB+3/0jQR+SD5FX4i4wREx0B9q/vpHwKZjXs2ZfUzNdhNO1tGgUIZKkz60wIv9fr2bNMJKHrXktjajvP/STF74sdGZkDtlZg=
Received: from CY1PR04MB2300.namprd04.prod.outlook.com (10.167.10.148) by CY1PR04MB2283.namprd04.prod.outlook.com (10.167.9.10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.16; Wed, 24 Jul 2019 19:01:21 +0000
Received: from CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8]) by CY1PR04MB2300.namprd04.prod.outlook.com ([fe80::b0bd:c5ef:93b1:2bc8%8]) with mapi id 15.20.2094.017; Wed, 24 Jul 2019 19:01:21 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH 1/1] Cygwin: don't allow getpgrp() to fail
Date: Wed, 24 Jul 2019 19:01:00 -0000
Message-ID: <992a50a7-05c0-3be0-01c3-da079c8f27e1@cornell.edu>
References: <20190723161100.1045-1-kbrown@cornell.edu> <20190723161100.1045-2-kbrown@cornell.edu> <20190723165458.GM21169@calimero.vinschen.de> <59c6529d-b411-fcf5-fa82-8a681d5b6378@dronecode.org.uk> <20190723191648.GP21169@calimero.vinschen.de> <03431b8b-22aa-d288-aa11-87a9feedfb44@cornell.edu>
In-Reply-To: <03431b8b-22aa-d288-aa11-87a9feedfb44@cornell.edu>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.8.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:1468;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7BD3A177BDC9249BBEE959903C094ED@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksb2@cornell.edu
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00042.txt.bz2

T24gNy8yNC8yMDE5IDExOjA0IEFNLCBLZW4gQnJvd24gd3JvdGU6DQo+IEJ1
dCBJIHN0aWxsIHRoaW5rIGdldHBncnAoKSBzaG91bGQgYmUgY2hhbmdlZA0K
DQpJJ3ZlIGRlY2lkZWQgbm90IHRvIHB1cnN1ZSB0aGlzLiAgSSBkb24ndCB0
aGluayBpdCdzIHZlcnkgaW1wb3J0YW50LCBhbmQgSSBkb24ndCANCmtub3cg
aG93IGl0IG1pZ2h0IGFmZmVjdCBhcHBsaWNhdGlvbnMuDQoNCktlbg0K
