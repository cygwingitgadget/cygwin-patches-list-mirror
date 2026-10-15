Return-Path: <SRS0=Y364=IF=microsoft.com=Alexandre.Chohfi@sourceware.org>
Received: from CY3PR00CU001.outbound.protection.outlook.com (mail-westcentralusazlp17011000f.outbound.protection.outlook.com [IPv6:2a01:111:f403:c112::f])
	by sourceware.org (Postfix) with ESMTPS id 606A44BA2E3B
	for <cygwin-patches@cygwin.com>; Thu, 15 Oct 2026 18:14:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 606A44BA2E3B
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 606A44BA2E3B
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c112::f
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1792088061; cv=pass;
	b=HwGagNUYs1Oxtw8imNWXx/FbWp5R6/r2CrgH1kDzKZYeATmH0SwNoJgXOqI17IT4fuy97Bl6OxdBxwV30YNveQB6GXzg0pdhZwvbv0+6n4BepLB1GN4zF1qf12fkfPwSn5Opq8SjOEQYIvq9kNv0gNEwepxk90KwKN7hPcMkRcU=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792088061; c=relaxed/simple;
	bh=8SsBQ2xhBpuZshJ+W2faqLiJjjkGRxMS4Ln5mN9Rl1Q=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=A4XNQOgGLZSHgsEML6mABqMyJz7tHUeDxhcDr7rXu0JxhnAWLjb7lLPT9T+bswQraXhtDnvp8YQWTuRdgx5VJJeUVQnJMPIBgSeVQuZqJXGFgfQnfJny/Ch+CneRP8kOfwBsLXbuVeZNG5winEsLWErjJATfULhTimM5pc9rth8=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=Jo7Fuzxj
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 606A44BA2E3B
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=Jo7Fuzxj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTiGwjYZcRN1UGrDkZ5Q5OCOCWb5f0W6u2Uv1Laiy66SVrwIPb/wEu7p+y5At4qfCETu8PW7SUQXN8uXFaQIEhUcHuK8I8FtLSuSMQNkQA0cprh1IpfqP6Xe2igB8bTD+jy8H/N4U6VXtRCqTiQTScrHy+fvl17H1dgEZZDUhk8wDULtX/ym73c+dUAautEl/dit3pVoEKDpphKnx0LbDeIPxbQVodNzNEE8dTndntduo/UfE0pgvOLSnG7vjFtKj8YHRv88JKQc8opuWh+eoNQsy344tK7aPDdRrGe1CVBgF41Cx62L+gMKB+Bagt5YULGB9E8Uh3XcCtLQzmlfnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=EOgmgkgzCGgqAnEohydtBhYqDko/uf8TuxSwz4u0w9o=;
 b=cBpW/ArhKZw/QGbqOGW4W/dtPUwFJdYztf/3uhW5CNDQWf0GoluugGcV/Aer+PeX+VskgSmvrvyqFfxgk/cbT25F2pz8God13LsYyOWEyG77QZOgpcABDkGYT9TNvT+4Ullpp/12vWetaLSG/jJ0JM+5fenldHywwrWJre1p/NHdF5yOyUQs9UgLl4JSW5W7Ey/fSl12JO3VcZhCij6lLhIwf0aNGpK7gX2rAqzSfwwzgo3NppWH2mITpUKSMwvwak2rkZibSuhIcnHejxSW8g34eNP/F+nSDQwse19AoboaID8OY4UxGfxYAV9pSZ6XEnbOPc+Dx+dQ85wmcl7AbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOgmgkgzCGgqAnEohydtBhYqDko/uf8TuxSwz4u0w9o=;
 b=Jo7FuzxjcArNy/jk6pPzBNBUccHdeaOYNc6e0kk/oDXPNAMiXPsOAbvBWcdStHo/SX58dBz4rO5QbV7nG8F8zIqTPOp5Ulsx30lEBqghDtvohhskoqP8PYMn4Q0xRmDHPML4Lvpl6f19tiHQ/FiqK7WMJeRegx/a/TtZ68xUoIc=
Received: from DS0PR00MB3397.namprd00.prod.outlook.com (2603:10b6:8:396::24)
 by DS3PR00MB3484.namprd00.prod.outlook.com with HTTP via P2P; Thu, 15 Oct
 2026 18:14:13 +0000
Received: from DS0PR00MB3397.namprd00.prod.outlook.com
 ([fe80::12c5:2650:bb7b:aadd]) by DS0PR00MB3397.namprd00.prod.outlook.com
 ([fe80::12c5:2650:bb7b:aadd%6]) with mapi id 15.21.0568.000; Thu, 15 Oct 2026
 18:14:13 +0000
From: Alexandre Zollinger Chohfi <Alexandre.Chohfi@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: Mark Geisert <mark@maxrnd.com>
Subject: Re: [PATCH RESEND 0/2] Cygwin: avoid loading Winsock and iphlpapi at
 process startup
Thread-Topic: [PATCH RESEND 0/2] Cygwin: avoid loading Winsock and iphlpapi at
 process startup
Thread-Index: AQHdWrrfft1X79GziUm5HLUp1eiwm7b+OjGAgACx3Yw=
Date: Thu, 15 Oct 2026 18:14:13 +0000
Message-ID:
 <DS0PR00MB33978E175601650E15466932809C2@DS0PR00MB3397.namprd00.prod.outlook.com>
References:
 <PH0PR00MB338699008F36947D666826C5809E2@PH0PR00MB3386.namprd00.prod.outlook.com>
 <7a6afbac-5973-4606-a3e2-4e0cc7d9ac0f@maxrnd.com>
In-Reply-To: <7a6afbac-5973-4606-a3e2-4e0cc7d9ac0f@maxrnd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-traffictypediagnostic: DS0PR00MB3397:EE_|DS3PR00MB3484:EE_
x-ms-publictraffictype: Email
client-request-id: ad6d052a-df62-4bb4-ae6c-8da1332c584b
request-id: a069acd1-967c-4e4a-5517-08df2ae81e1b
x-ms-office365-filtering-correlation-id: a069acd1-967c-4e4a-5517-08df2ae81e1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|6049299003|23010399003|22082099003|18002099003|10067099003|7146999003|4053099003|11063799006|261009223027099003|4143699003|38070700021|56012099006;
x-microsoft-antispam-message-info:
 BlxIdzBxCcZ9TjktCkkBVK6mP+FYxFcWF7EDpEJ2ZwRVyI3gAaogNO7I98c7k7qLGY1dY9BkTlptZMClqpMH23R/uTW7I3hEwaL7Qxe+EmWMefZ2195DLI+SvwK916G71E/04zFSFGWHP0Zu6IB1EIitC/PYII33aBBY4qrZrLMVcnWGRB9L6BvCBlxpMSakJulYzHvTN/M9RanvLRqrlScQkLyqY+dquCCHNsoPASiiwMQK0KLEpMuoVvTaOUeWbcS6+JHx9ejrDTIPNPg5gkYaXUQa2MnneLhg8dGE6kUKrwSixDTjSEDgZKMLC1EM8uGO0c0fssocIOcUm7tRnhi2c4z0Nkk8p0jd7FQys92KKibm6fxA6kvQxTQxc0L2NMMsTCJfako2u83SyqGsERXB7nq1JyMqD1ycOafbEyXxcWfT87qUfE057iYPPstrb39gJgSrDpboxEpeEnAkaoFHi+azG4U+AVU0+/mzZ60uoANb/UNVN7aq1pztvGr+FlLOG+t+JYgXdQyQF1I6tzgbn2V+B1H4KCOvzlIuvkpam2DJeQshQ2hSgLNtExKhfqhGUUT6Udg/hwozEOCbRdPWPopSVP5F//1JJCISxvQFnCkJrYaBuLGhj1W1uHufEHk/OCQSkveHrHOGRk3tLp4SlqibA4N+dnl1BeUJf0M0fLe1V9RK6/XY4jtFjS7Cl69ooNdyc7La4ZTRsqGAn/yi/kaFWGBejYUdtyqTI3c=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(6049299003)(23010399003)(22082099003)(18002099003)(10067099003)(7146999003)(4053099003)(11063799006)(261009223027099003)(4143699003)(38070700021)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8I45TGbgwPhca3IAVWz+nBI8hqMhpDTs2x1HhUgdxvJ589FVFwcaqVxCqXkw?=
 =?us-ascii?Q?p73/jRGIBC2jcU8A25ffPa52S5DlvPz4sRfJbaDB+60FTnc8CAb1G7zFfZml?=
 =?us-ascii?Q?4VGBx5fxbSn+lBZ1bA8n+37TrRdDUnwCxFiZIU5magn3rWmIPDG/WcY9DI5V?=
 =?us-ascii?Q?HsTtXsYMQ3xeulfv8QqC6lLyPeS1XfSLKaqNQO+pVcWBsiSnEfST1tDZMFcf?=
 =?us-ascii?Q?YAxGxQQO0DFhfDVIKqykK2t4JTDTqdZpA16wUS+v4sRsAJQILLT2iC/fLu6E?=
 =?us-ascii?Q?sjhJIbAh0O8jFyRr7AVPMINwLkYPUsSKhYhomAkfA68hXzzgq89iAF/FTQcG?=
 =?us-ascii?Q?dCMqxo8S7uSdEAM/IKDRdZwMIpPBSjYjbH1YoNewo0+FBH6dBi/P//d6ci3r?=
 =?us-ascii?Q?bjsxTLMK9WQfJXwS7WWRCx9iM0lHxNWnEdEnqN8/nMsb8zc/3KxfE3pF69HR?=
 =?us-ascii?Q?zqR1J5vhTywzfPsERyPrkBuZPt5WdkfKBZN4gGZ3uDRw0fBEOVMb3IznTCDV?=
 =?us-ascii?Q?AbIJC/0ocrSKmi4YGn30yz0qLp7FbH/qFzfIW+sT5IanoX17S2RtYYcHtorM?=
 =?us-ascii?Q?F+LInNTKCFZB1GitQFGZHdxY6jxdCzHmU6cJ4qWN/rx9GfmcIPrh9kNmxJpk?=
 =?us-ascii?Q?xpi8ocyzNLXi4jKaFOkepRsoKBfdgWeA/l/ORcV6QCHw+nn57lLqaWeuXhzz?=
 =?us-ascii?Q?vX3XRa/KHUNbgCskCe2RJxV2OQV+fbCUR4X+137OL+hntaOHlTJjAsI5fxo+?=
 =?us-ascii?Q?QBSAe1glc992QVw2Dn3vqW1BAh7y7tV0pFzvtRqOQaRg75NNREVu48Im3ozG?=
 =?us-ascii?Q?gz37PDZ5KbNz4/9ION1w88v5tGAUxCm81QIhADZ6y1e0kc7Vn74SRTkBtUrJ?=
 =?us-ascii?Q?iiPKMLsBCU315MFOnOb3cNqqpjQ5yXwr8mFE2FR7qvANX5JcUDvGp5jkhPLU?=
 =?us-ascii?Q?WNEswwo+cfvCVYelfsN53S2iHQXOc7ADfmp05J1UC/1+PS+BLRR6wRjY01JU?=
 =?us-ascii?Q?q6IYzVLLfUgzyx/V5ZZijdwvztl1uVT5OxeU7AyRMbPrkyhIPu7+No2Ykmya?=
 =?us-ascii?Q?AzjKxGp0oLQ8iq0eT+zzcwZTeYMLnyO2xFAGriWuA6NhlRczdqlvkdymi75F?=
 =?us-ascii?Q?Rm0xtMn4NXVt3JFPEcFKYXP8GuKFlkyB/EnZRzi1oBrW0vTm70aa4ecs4PDT?=
 =?us-ascii?Q?05a+MEZwctDJw6IF5IM8oATVPYmjC0gAZOyXUJye4PCciFoJ521R+95SbxBc?=
 =?us-ascii?Q?BdIKTVyeQ+qyN+l2xsM4lM5BYkR7mYAVnLwxXP9eJtPyNn9gEbBhu1/VHZ3F?=
 =?us-ascii?Q?wdU8zLaCei9taLEqf+Uz2kN6fwKnPEpiJweGfBepiRNBa2w3oqBPQ0LnqTjI?=
 =?us-ascii?Q?TrIkD4lsuMeKsfo4oi97h3G3VQOduq2KjJvIYc5YfdqOa9B4yA1UdB1AJ5N0?=
 =?us-ascii?Q?eetVaprSL7Uk0KP9+qFu8yk5fxqG2NQH+o2DXCt4IXwulmGm+QAUFN3QRzEg?=
 =?us-ascii?Q?Fp0wp+Elp+UGjndUfyKQxyxOn9fx4gnJwmICwri0H9i5t1j3gnIuuyn3vLSI?=
 =?us-ascii?Q?7I1Ts7x63gVhTxi8GRI5WyH3XuIypMM4B1yvSioVf8olXFrTLGnjksj33UNx?=
 =?us-ascii?Q?ZC+e+BVY9MHmZZQCFnw/ZGzjIiYdGCOKDt66oYEpeMkL8RdNdJaOjRGdRwMK?=
 =?us-ascii?Q?4AffEP2bpjColUHQm1XyGHZteA9rbZewgGC1/gNosG0ipBZKmFhePGo0DAAm?=
 =?us-ascii?Q?+7OXfzD5Ag=3D=3D?=
Content-Type: multipart/mixed;
	boundary="_003_DS0PR00MB33978E175601650E15466932809C2DS0PR00MB3397namp_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR00MB3397.namprd00.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a069acd1-967c-4e4a-5517-08df2ae81e1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 18:14:13.5513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KPaUnNbbg0LoWDFCylpaOZFOt8BFFjv1X/N+TXXUa1tnPDSUWSygufh+kUCXjaUFU2K7jeKzM/tYTRBtLEdf5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR00MB3484
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GB_MSAUTHSOURCE_NORTHAM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_003_DS0PR00MB33978E175601650E15466932809C2DS0PR00MB3397namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

Thanks for looking at it.

On the first question, I found a case where they differ.  The
GetComputerNameEx documentation says that on a cluster node
ComputerNameDnsHostname returns the DNS host name of the cluster virtual
server, while ComputerNamePhysicalDnsHostname returns the node's own
name.  I can't test a cluster here, but that is reason enough not to
rely on ComputerNameDnsHostname.  sethostname in the same file already
uses ComputerNamePhysicalDnsHostname, so v2 of patch 2/2 asks for that
one instead.  Patch 1/2 is unchanged.

I rebuilt msys-2.0.dll with v2.  $HOSTNAME, `uname -n` and `hostname`
are the same as on the unpatched build, and `bash -c true` with
anonymous pipes as stdio still does not load iphlpapi or ws2_32.  Both
patches apply cleanly to the current main (80df0a2b5).

v2 is attached.

Regards,
Alexandre

--_003_DS0PR00MB33978E175601650E15466932809C2DS0PR00MB3397namp_
Content-Type: text/x-patch;
	name="v2-0002-Cygwin-gethostname-try-GetComputerNameExA-before-.patch"
Content-Description:
 v2-0002-Cygwin-gethostname-try-GetComputerNameExA-before-.patch
Content-Disposition: attachment;
	filename="v2-0002-Cygwin-gethostname-try-GetComputerNameExA-before-.patch";
	size=2262; creation-date="Thu, 15 Oct 2026 18:14:00 GMT";
	modification-date="Thu, 15 Oct 2026 18:14:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSA4OTk0MGExNTYwNDU4OGNhYWYxMjRhMzY5ZjQwNTQ4ZjgxNzcwOTMxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4YW5kcmUgWm9sbGluZ2VyIENob2hmaSA8YWx6b2xsaW5A
bWljcm9zb2Z0LmNvbT4KRGF0ZTogVHVlLCA2IE9jdCAyMDI2IDE2OjA2OjMyIC0wNzAwClN1Ympl
Y3Q6IFtQQVRDSCB2MiAyLzJdIEN5Z3dpbjogZ2V0aG9zdG5hbWU6IHRyeSBHZXRDb21wdXRlck5h
bWVFeEEgYmVmb3JlCiBHZXROZXR3b3JrUGFyYW1zCgpTaW5jZSBjb21taXQgMjE2NmY3ZGMwZDlh
ICgiQ3lnd2luOiBuZXQ6IHVuaWZ5IGdldGhvc3RuYW1lL2dldGRvbWFpbm5hbWUiKQpnZXRob3N0
bmFtZSByZWFkcyBGSVhFRF9JTkZPOjpIb3N0TmFtZSBmcm9tIEdldE5ldHdvcmtQYXJhbXMuICBU
aGF0CmxvYWRzIGlwaGxwYXBpLmRsbCwgYW5kIHdpdGggaXQgbnNpLmRsbCwgZG5zYXBpLmRsbCBh
bmQgZHNwYXJzZS5kbGwsCmludG8gZXZlcnkgcHJvY2VzcyB0aGF0IGNhbGxzIGl0LCBhbmQgYmFz
aCBjYWxscyBpdCB1bmNvbmRpdGlvbmFsbHkgYXQKc3RhcnR1cCB0byBzZXQgJEhPU1ROQU1FLgoK
R2V0Q29tcHV0ZXJOYW1lRXhBIChDb21wdXRlck5hbWVQaHlzaWNhbERuc0hvc3RuYW1lKSByZXR1
cm5zIHRoZSBzYW1lClRDUC9JUCBob3N0IG5hbWUgZnJvbSBrZXJuZWwzMi4gIFRyeSBpdCBmaXJz
dCBhbmQga2VlcCBHZXROZXR3b3JrUGFyYW1zCmFzIHRoZSBmYWxsYmFjay4gIEl0IGFza3MgZm9y
IHRoZSBwaHlzaWNhbCBuYW1lIGJlY2F1c2Ugb24gYSBjbHVzdGVyCm5vZGUgQ29tcHV0ZXJOYW1l
RG5zSG9zdG5hbWUgcmV0dXJucyB0aGUgY2x1c3RlcidzIHZpcnR1YWwgc2VydmVyIG5hbWUsCmFu
ZCBzZXRob3N0bmFtZSBhbHJlYWR5IHNldHMgQ29tcHV0ZXJOYW1lUGh5c2ljYWxEbnNIb3N0bmFt
ZS4KZ2V0ZG9tYWlubmFtZSBpcyB1bmNoYW5nZWQuCgpPbiBhIDMuNi4xMCBidWlsZCwgdG9nZXRo
ZXIgd2l0aCB0aGUgcHJldmlvdXMgcGF0Y2gsIGBiYXNoIC1jIHRydWVgCnN0YXJ0ZWQgd2l0aCBh
bm9ueW1vdXMgcGlwZXMgYXMgc3RkaW8gdGFrZXMgNC4xIG1zIGxlc3MgKDE5LjAgLT4gMTUuMCBt
cywKbWVkaWFuIG9mIDEwMCBpbnRlcmxlYXZlZCBydW5zKSBhbmQgbWFwcyAxOCBpbWFnZXMgaW5z
dGVhZCBvZiAyNC4KJEhPU1ROQU1FLCBgdW5hbWUgLW5gIGFuZCBgaG9zdG5hbWVgIGFyZSB1bmNo
YW5nZWQuCgpTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kcmUgWm9sbGluZ2VyIENob2hmaSA8YWx6b2xs
aW5AbWljcm9zb2Z0LmNvbT4KLS0tCiB3aW5zdXAvY3lnd2luL25ldC5jYyB8IDE2ICsrKysrKysr
KysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEv
d2luc3VwL2N5Z3dpbi9uZXQuY2MgYi93aW5zdXAvY3lnd2luL25ldC5jYwppbmRleCA1NzliMWE3
MGIuLmI5NzQ1MjcwYiAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9uZXQuY2MKKysrIGIvd2lu
c3VwL2N5Z3dpbi9uZXQuY2MKQEAgLTc1Niw2ICs3NTYsMjIgQEAgY3lnd2luX2dldGhvc3RuYW1l
IChjaGFyICpuYW1lLCBzaXplX3QgbGVuKQogewogICBfX3RyeQogICAgIHsKKyAgICAgIC8qIEdl
dENvbXB1dGVyTmFtZUV4QSByZXR1cm5zIHRoZSBzYW1lIFRDUC9JUCBob3N0IG5hbWUgYXMKKwkg
R2V0TmV0d29ya1BhcmFtcycgRklYRURfSU5GTzo6SG9zdE5hbWUsIHdpdGhvdXQgbG9hZGluZwor
CSBpcGhscGFwaS5kbGwgKGFuZCB3aXRoIGl0IG5zaSwgZG5zYXBpIGFuZCBkc3BhcnNlKSBpbnRv
IGV2ZXJ5CisJIHByb2Nlc3MgdGhhdCBhc2tzLiAgYmFzaCBhc2tzIGF0IGV2ZXJ5IHN0YXJ0LiAg
VXNlIHRoZSBwaHlzaWNhbAorCSBuYW1lOiBvbiBhIGNsdXN0ZXIgbm9kZSBDb21wdXRlck5hbWVE
bnNIb3N0bmFtZSByZXR1cm5zIHRoZQorCSBjbHVzdGVyJ3MgdmlydHVhbCBzZXJ2ZXIgbmFtZSBp
bnN0ZWFkLiAqLworICAgICAgY2hhciBob3N0WzI1Nl07CisgICAgICBEV09SRCBobGVuID0gc2l6
ZW9mIGhvc3Q7CisKKyAgICAgIGlmIChHZXRDb21wdXRlck5hbWVFeEEgKENvbXB1dGVyTmFtZVBo
eXNpY2FsRG5zSG9zdG5hbWUsIGhvc3QsICZobGVuKSkKKwl7CisJICBzdHJuY3B5IChuYW1lLCBo
b3N0LCBsZW4pOworCSAgZGVidWdfcHJpbnRmICgiZ2V0aG9zdG5hbWUgJXMiLCBuYW1lKTsKKwkg
IHJldHVybiAwOworCX0KKwogICAgICAgUEZJWEVEX0lORk8gaW5mbyA9IE5VTEw7CiAgICAgICBV
TE9ORyBzaXplID0gMDsKIAotLSAKMi41My4wLndpbmRvd3MuNAoK

--_003_DS0PR00MB33978E175601650E15466932809C2DS0PR00MB3397namp_
Content-Type: text/x-patch;
	name="v2-0001-Cygwin-dtable-don-t-load-Winsock-to-classify-an-a.patch"
Content-Description:
 v2-0001-Cygwin-dtable-don-t-load-Winsock-to-classify-an-a.patch
Content-Disposition: attachment;
	filename="v2-0001-Cygwin-dtable-don-t-load-Winsock-to-classify-an-a.patch";
	size=2825; creation-date="Thu, 15 Oct 2026 18:14:01 GMT";
	modification-date="Thu, 15 Oct 2026 18:14:01 GMT"
Content-Transfer-Encoding: base64

RnJvbSBmNDg0Nzk5MmVhODBlMjcxYzBmMTJmODA3MGRmZTJlNzJiNzRhNTY3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4YW5kcmUgWm9sbGluZ2VyIENob2hmaSA8YWx6b2xsaW5A
bWljcm9zb2Z0LmNvbT4KRGF0ZTogVHVlLCA2IE9jdCAyMDI2IDE2OjA2OjMyIC0wNzAwClN1Ympl
Y3Q6IFtQQVRDSCB2MiAxLzJdIEN5Z3dpbjogZHRhYmxlOiBkb24ndCBsb2FkIFdpbnNvY2sgdG8g
Y2xhc3NpZnkgYW4KIGFub255bW91cyBzdGRpbyBwaXBlCgpBbiBhbm9ueW1vdXMgcGlwZSAoQ3Jl
YXRlUGlwZSkgaGFzIG5vIG5hbWUsIHNvIE50UXVlcnlPYmplY3QgZmFpbHMgb24KaXQgd2l0aCBT
VEFUVVNfT0JKRUNUX1BBVEhfSU5WQUxJRCBhbmQgaGFuZGxlX3RvX2ZuIHJlcG9ydHMgaXQgYXMK
dW5rbm93bl9maWxlLCB0aGUgc2FtZSBhbnN3ZXIgaXQgZ2l2ZXMgZm9yIGFuIExTUCBzb2NrZXQu
CmluaXRfc3RkX2ZpbGVfZnJvbV9oYW5kbGUgdGhlbiBjYWxscyBnZXRzb2Nrb3B0IG9uIGl0LCB3
aGljaCBsb2Fkcwp3czJfMzIuZGxsIGFuZCBtc3dzb2NrLmRsbCBhbmQgY2FsbHMgV1NBU3RhcnR1
cCwgb25seSB0byBsZWFybiB0aGF0IHRoZQpwaXBlIGlzIG5vdCBhIHNvY2tldC4gIEV2ZXJ5IEN5
Z3dpbiBwcm9jZXNzIHN0YXJ0ZWQgYnkgYSBub24tQ3lnd2luCnBhcmVudCB3aXRoIGFub255bW91
cyBwaXBlcyBhcyBzdGRpbyBwYXlzIGZvciB0aGF0OiBjbWQuZXhlIHBpcGVsaW5lcywKYW5kIHRo
ZSBzdWJwcm9jZXNzIEFQSXMgb2YgUHl0aG9uLCAuTkVUIGFuZCBHbywgYW1vbmcgb3RoZXJzLgoK
QXNrIHRoZSBuYW1lZCBwaXBlIGZpbGUgc3lzdGVtIGZpcnN0LiAgTnRRdWVyeUluZm9ybWF0aW9u
RmlsZQooRmlsZVBpcGVMb2NhbEluZm9ybWF0aW9uKSBzdWNjZWVkcyBvbiBhbnkgTlBGUyBwaXBl
LCBuYW1lZCBvciBub3QsIGFuZApmYWlscyBvbiBBRkQgc29ja2V0IGhhbmRsZXMsIHNvIHNvY2tl
dHMgc3RpbGwgcmVhY2ggdGhlIGdldHNvY2tvcHQgcHJvYmUKYXMgYmVmb3JlLgoKT24gYSAzLjYu
MTAgYnVpbGQsIGEgbm8tb3AgcHJvY2VzcyBzdGFydGVkIHdpdGggYW5vbnltb3VzIHBpcGVzIGFz
CnN0ZGlvIHN0YXJ0cyAyLjEgbXMgZmFzdGVyICgxNC4yIC0+IDEyLjEgbXMsIG1lZGlhbiBvZiAx
MDAgaW50ZXJsZWF2ZWQKcnVucykgYW5kIG1hcHMgdGhyZWUgZmV3ZXIgRExMcy4gIEEgVENQIHNv
Y2tldCBoYW5kZWQgZG93biBhcyBzdGRpbiBpcwpzdGlsbCBjbGFzc2lmaWVkIGFzIGEgc29ja2V0
LgoKU2lnbmVkLW9mZi1ieTogQWxleGFuZHJlIFpvbGxpbmdlciBDaG9oZmkgPGFsem9sbGluQG1p
Y3Jvc29mdC5jb20+Ci0tLQogd2luc3VwL2N5Z3dpbi9kdGFibGUuY2MgfCAxNyArKysrKysrKysr
KysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS93
aW5zdXAvY3lnd2luL2R0YWJsZS5jYyBiL3dpbnN1cC9jeWd3aW4vZHRhYmxlLmNjCmluZGV4IDUz
MGM2NzkxMC4uYzk4ZWFkM2FjIDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL2R0YWJsZS5jYwor
KysgYi93aW5zdXAvY3lnd2luL2R0YWJsZS5jYwpAQCAtMjc4LDYgKzI3OCwyMiBAQCBjeWd3aW5f
YXR0YWNoX2hhbmRsZV90b19mZCAoY2hhciAqbmFtZSwgaW50IGZkLCBIQU5ETEUgaGFuZGxlLCBt
b2RlX3QgYmluLAogICByZXR1cm4gZmQ7CiB9CiAKKy8qIEFub255bW91cyBwaXBlcyAoQ3JlYXRl
UGlwZSkgaGF2ZSBubyBuYW1lLCBzbyBoYW5kbGVfdG9fZm4gcmVwb3J0cyB0aGVtCisgICBhcyB1
bmtub3duX2ZpbGUsIGp1c3QgbGlrZSBhbiBMU1Agc29ja2V0LiAgQXNrIHRoZSBuYW1lZCBwaXBl
IGZpbGUgc3lzdGVtCisgICBmaXJzdDogYSBzb2NrZXQgZmFpbHMgdGhpcyBxdWVyeSwgYSBwaXBl
IG9mIGFueSBraW5kIHN1Y2NlZWRzLiAgV2l0aG91dAorICAgaXQsIGV2ZXJ5IHByb2Nlc3Mgc3Rh
cnRlZCB3aXRoIGFub255bW91cyBwaXBlcyBhcyBzdGRpbyAoYnkgY21kLmV4ZQorICAgcGlwZWxp
bmVzLCBQeXRob24sIC5ORVQsIEdvLCAuLi4pIGNhbGxzIGdldHNvY2tvcHQsIHdoaWNoIGxvYWRz
IFdpbnNvY2sKKyAgIGFuZCBjYWxscyBXU0FTdGFydHVwIGp1c3QgdG8gbGVhcm4gdGhhdCBhIHBp
cGUgaXMgbm90IGEgc29ja2V0LiAqLworc3RhdGljIGJvb2wKK2lzX25wZnNfaGFuZGxlIChIQU5E
TEUgaCkKK3sKKyAgSU9fU1RBVFVTX0JMT0NLIGlvOworICBGSUxFX1BJUEVfTE9DQUxfSU5GT1JN
QVRJT04gZnBsaTsKKworICByZXR1cm4gTlRfU1VDQ0VTUyAoTnRRdWVyeUluZm9ybWF0aW9uRmls
ZSAoaCwgJmlvLCAmZnBsaSwgc2l6ZW9mIGZwbGksCisJCQkJCSAgICAgRmlsZVBpcGVMb2NhbElu
Zm9ybWF0aW9uKSk7Cit9CisKIHZvaWQKIGR0YWJsZTo6aW5pdF9zdGRfZmlsZV9mcm9tX2hhbmRs
ZSAoaW50IGZkLCBIQU5ETEUgaGFuZGxlKQogewpAQCAtMzEwLDYgKzMyNiw3IEBAIGR0YWJsZTo6
aW5pdF9zdGRfZmlsZV9mcm9tX2hhbmRsZSAoaW50IGZkLCBIQU5ETEUgaGFuZGxlKQogCQkgIGhh
bmRsZS4gIGZoYW5kbGVyX3NvY2tldDo6c2V0X3NvY2tldF9oYW5kbGUgdHJpZXMgdG8gZmV0Y2gK
IAkJICB0aGUgdW5kZXJseWluZyBiYXNlIHNvY2tldCwgYnV0IHRoaXMgbWlnaHQgZmFpbC4gKi8K
IAkgICAgICAgfHwgKHN0cmNtcCAobmFtZSwgdW5rbm93bl9maWxlKSA9PSAwCisJCSAgICYmICFp
c19ucGZzX2hhbmRsZSAoaGFuZGxlKQogCQkgICAmJiAhOjpnZXRzb2Nrb3B0ICgoU09DS0VUKSBo
YW5kbGUsIFNPTF9TT0NLRVQsIFNPX1JDVkJVRiwKIAkJCQkgICAgIChjaGFyICopICZyY3YsICZs
ZW4pKSkKIAl7Ci0tIAoyLjUzLjAud2luZG93cy40Cgo=

--_003_DS0PR00MB33978E175601650E15466932809C2DS0PR00MB3397namp_--
