Return-Path: <kbrown@cornell.edu>
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08hn2204.outbound.protection.outlook.com [52.100.161.204])
 by sourceware.org (Postfix) with ESMTPS id 6C34B385041B
 for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2020 13:18:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 6C34B385041B
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPHl2IxxrFCBWE6pywClmEpd5MsocoezOI7m8p/y/YVqOS9y9//F4+NbIxkNzI4csWRs4FHGLe5tHRNk89skXraJ8OcSEHU0VY38BDUDwLbvow6Gs1sgWDsxoGZkkdQ0ZxNzNhhx+Ko37M9UFWOcrCJbseekL7WRNLnRCg2ctUZUO1V7Ps00M9trWrvxs6wLq+JGpdfvsfwk719RWOqp6mnrtxexnUsMmC0GwS62kC+lREAuAcfrspBW3wfEH5u+4yE+yp65F9xxDJ8e3sWePLowy6n7/GVVkZ9NzQdNwJDeDQHVAiX0JbDVL5Vm2vBaSonM7sLzcPYT+//v9qYIDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZrRJyPjDN8foF+Tmt1OkT+5zRwxuNJzdsO5oGiwkrM=;
 b=mnDl2Ad5aNuVcqzQPQuQL2v3Qs9RTPS2ESO8AGNWttvzdDIhNSrXmpAm659KZuiHrrh1BB0cvO/GdmbvaVzt+Ot13nqf3yIaX5rhpJPPV60qIDpsU7CpICD2zdcXRJ2X0yuuQtoZnSGL4y3WoYFLpnsZvJ1DNu1Gdw7IVBoP8Atq1M36tqgXbY1sGwehrPDNzDuSIXWDVaOjFE1j57Fa7faFI0Pl1/9ZjAecu+M5uklbom/bVgJC6waj8JRw7wRbI3h1hj4pbcjiYJSXq5y0KofQZrNfFQEa6a0EOG3ktx5B4TgclcuwJcukdwGOPT7gDAvNbZV5AKgbIrI5PJ8V+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu;
 dkim=pass header.d=cornell.edu; arc=none
Received: from MN2PR04MB6176.namprd04.prod.outlook.com (2603:10b6:208:e3::13)
 by MN2PR04MB5630.namprd04.prod.outlook.com (2603:10b6:208:ff::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Tue, 13 Oct
 2020 13:18:29 +0000
Received: from MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44]) by MN2PR04MB6176.namprd04.prod.outlook.com
 ([fe80::c144:d206:c369:af44%7]) with mapi id 15.20.3455.031; Tue, 13 Oct 2020
 13:18:29 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v2 5/6] Cygwin: AF_UNIX: listen_pipe: check for
 STATUS_SUCCESS
Thread-Topic: [PATCH v2 5/6] Cygwin: AF_UNIX: listen_pipe: check for
 STATUS_SUCCESS
Thread-Index: AQHWmm5rtVN8IE7yhkOs9C9wYncRv6mVcxWA///ZwIA=
Date: Tue, 13 Oct 2020 13:18:28 +0000
Message-ID: <2a83e5b7-8dfb-5138-f8ef-99c62e7403ca@cornell.edu>
References: <20201004164948.48649-1-kbrown@cornell.edu>
 <20201004164948.48649-6-kbrown@cornell.edu>
 <20201013112829.GH26704@calimero.vinschen.de>
In-Reply-To: <20201013112829.GH26704@calimero.vinschen.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
x-mozilla-draft-info: internal/draft; vcard=0; receipt=0; DSN=0; uuencode=0;
 attachmentreminder=0; deliveryformat=4
x-account-key: account1
x-ms-exchange-imapappendstamp: MN2PR04MB6176.namprd04.prod.outlook.com
 (15.20.3455.031)
x-identity-key: id1
x-originating-ip: [2604:6000:b407:7f00:946b:663a:1a3:dfd2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45e9c9a2-2fa7-4ea3-2a69-08d86f7a79a7
x-ms-traffictypediagnostic: MN2PR04MB5630:
x-microsoft-antispam-prvs: <MN2PR04MB5630EAB53F0971D97603068AD8040@MN2PR04MB5630.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wo3Iyvf197c/eYIAX1QSYOs3rHSumI0YKaL5ynfh0E2fXVEl5ZXvl2EjdK9cDnfQZW9+CSIRUNvp85bTzWI08/54006UCShO4IcHmEqkgBJTr4nmFrjuPvFWVPx5rpHf+QJWWHqlDtC+TBpwPm5hH+yHMFWOBSHiShZo81rEmNC7UM56JVAew2bWfifJhuZAu9HGVz6jYLYOV+ol9SAcDxEvlx2KkF43dAcD23DBpNwGk6a5QXvRzE3Vt0zWoNx+5RqdrV97V3jimSjcqE+IdfpFd6ithHovCWUERoPIuA3NeyIgNcP+LJVqLmQuqunZtIR/N/KREVaekKt91Kg5lm/uEF7sNjsNw3DAcFPNCl0VL6r9iZUYHeZcaljq0+XIaXBPAFy/r2BnZpv5hOkgtbLMxJoeUnIgjyzYMVZRZEAkpIuOmGoawspJgE9End5sNUtoqNoNQyTM54mqO+w05KotSJOyB0zdrX94qNZDL3CReV5wU9asEwIdBtBq8ESQ4cxCSREDEoYxU9V22caQ/zJT8vGXaP99rQ/48tpV9bA/W6RFWUH676+YKkhtV6M0ECMHkm4q6JTMXDGiEVgErbSSmqHmLlF1NXpNHR0wAk0DUKg9D7BBPBOPcI3yDH/72ssXiquTVB7eGfDXvS36sfu3AZ+s2FJ+/uYFNYdK7sY+kFhdm34Z99xVfaGGWuu6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:5; SRV:;
 IPV:NLI; SFV:SPM; H:MN2PR04MB6176.namprd04.prod.outlook.com; PTR:; CAT:OSPM;
 SFS:(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(186003)(6916009)(86362001)(6512007)(53546011)(6486002)(5660300002)(66556008)(66476007)(64756008)(66446008)(8676002)(31686004)(6506007)(76116006)(66946007)(8936002)(316002)(786003)(4744005)(478600001)(75432002)(71200400001)(2906002)(31696002)(2616005)(83380400001)(36756003)(21030700004);
 DIR:OUT; SFP:1501; 
x-ms-exchange-antispam-messagedata: dZqfFxzli0K15qEa9zZX7d1wHEQc73ZZNPGG6sxmMIm+Fr3qXBRrCpwDQv5dYkxiwb/NV4vCSuTuzcQO4hnZRwA393JSiv1Kg+Clem2lHjh3y9USP42O5UgKAUsE6H9MVUbIUeFRD9OgQ6S2yysK0AgPcy8uL5mIMVh5YzgcTsrFO4Ru5w37K+V9+7d7+kRTZmAMeFUt8kpcbhv+zb7iqhkKrwX/PTr55f1+dVzj4zDIt2gAyWJk8Ynz6XrIig7jbwWEpqmFo/7zzLlSU9sgBJHv4FZoqGuR/Ze6VilHqfy9mkmzgkBJP4xQOMLdKZftXftgfS4TcetatWAlbFBvoBsYRAsQA65zYMZNb0vWwc3iSATACNGZmwIgpEP7alvDM2spuUigN1rDKXXDHxlvE6pDCz+jMjS0pgQC6YI4G8iEXCtISSV+7fOk00+WeCgWUFZaF70OiQ7qpIduwNgkcd1cEYIEd85ZFGUlyPHAJ6FyA183ZqkdoECXN4RlTlrmzsZ5ORzXUUDn5HDvBPKllf8du5jPc9jXh+zhIXKc/aRd6Bwh2315TvV2pn6EdTsXMmIBdjqz10Ar+6+G1uz8j2TIBWI0KkKPRb0MfpST2Dqb14jyJEZ8teOSfkjEl8ZrboCbVUus/nLHDTrszKI4ihGNu6abA8MWHy8UwF1EjJNrsHEFzaGskweOtYs16qr4RUj3CX3I32xWFDhmDwuj2g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <D6839A2342F8604A865ECF8FDC215486@cornellprod.onmicrosoft.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cornell.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6176.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e9c9a2-2fa7-4ea3-2a69-08d86f7a79a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2020 13:18:28.9697 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d7e4366-1b9b-45cf-8e79-b14b27df46e1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nAbEIYqMg7v8NQUpgCfxRf0Qs5iV2aCdpdozU2lJ91lMLqzK2WNPyfN4jJXpR/qPh5dF4lWiQLU7VNurBMqiJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5630
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, JMQ_SPF_NEUTRAL, NICE_REPLY_A,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Tue, 13 Oct 2020 13:18:31 -0000

On 10/13/2020 7:28 AM, Corinna Vinschen wrote:=0A=
> On Oct  4 12:49, Ken Brown via Cygwin-patches wrote:=0A=
>> A successful connection can be indicated by STATUS_SUCCESS or=0A=
>> STATUS_PIPE_CONNECTED.=0A=
> =0A=
> THanks for catching but... huh?  How does Windows generate two different=
=0A=
> status codes for the same result from the same function?=0A=
=0A=
I think (but I'd have to recheck) that if the pipe is already connected whe=
n =0A=
NtFsControlFile is called, then the latter returns STATUS_PIPE_CONNECTED.  =
But =0A=
if you first get STATUS_PENDING and then set status =3D io.Status after =0A=
completion, then the result is STATUS_SUCCESS.=0A=
=0A=
I might not have that exactly right.  All I remember for sure is that I was=
 =0A=
debugging a listen_pipe failure, and it turned out to be due to STATUS_SUCC=
ESS =0A=
being treated as an error condition.=0A=
=0A=
Ken=0A=
