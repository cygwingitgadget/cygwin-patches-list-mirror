Return-Path: <SRS0=H4g6=6Z=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazon11020116.outbound.protection.outlook.com [52.101.227.116])
	by sourceware.org (Postfix) with ESMTPS id 749794BA2E04
	for <cygwin-patches@cygwin.com>; Fri, 19 Dec 2025 17:34:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 749794BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 749794BA2E04
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=52.101.227.116
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1766165649; cv=pass;
	b=HQ25pDY5OKb6Q1GQ4bIuO2eD/JWMn04pWdylae5NpFMOvfx4NiRsyX0CarhobGeAw714MfSB8bGHlqWNIxueJbXE7ZJAuiZc80GMwlXoveyEp1QmbHXwxb3RMVpZPQgG7Ohw8G+rhV8b+eNAPAQRl8gc9Gn6xWhMmUIh4ASh6T8=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766165649; c=relaxed/simple;
	bh=JG+c+XC1rGhbznmQBuc/12yUA4rRCuD+fXhsAdVOCug=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=c2mdy8Vd2rbgf1m2npZF1DvTLjwShHXI6PSyS0VXpHfn2x4ew0xIXcbkGxP/nVMHSi7GyWawb9t+d6nLkl6kMqvH3vPE2H7T0/meJ44Nqd/GzSQp6kuFarOhlFMSWGtMy6e2xATTwnduZe+e89NnoEWo4f7fRYPBwAQOWUpvSco=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 749794BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=YGPBOseI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dGSg4SBavNUeuCbob1Zc94dpI5NOzzbVnJxvngjO/yR/IS/v2s1aZAkFBpOH/RPzYfHs8qx18wBB2aOE7JZfkMyZVzwRHdy3GFLuZ9NE/9T2oZun0HHydWUwU7YNnXk5kLpbGc1gj4yVbbvJC7n9A8IknMBwR6HUAdOZ10P0w11N4WcSIlyWQxbmfEkuFRqDykkZtMLYI9hPFgExhH2UTS5CBa3kpVVIw64lYMdKscB+mhtCe0toHi2F/qYaYO69HgHBuru44+l7AmyIEgEksFTemu5JfINu/e6ky3zdUMjhe+rvMaV8SLyV3KT878t+LU7N2S+KqtBdPWEymGLqRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yihEwGRxWhi3jEzfDR3QeUbU/WMlC/BrwXgKCIcIk3g=;
 b=xWNPvRbUtl67jI0yMmrPITCYy9QT1DTh7zujCdGJnYqaVq6HnaHNiT/feUwOll97LM7YhD/eXiDXsllGeDK7AFQnFcB1r80qe2ziR8qmV9Ump7D6/lL6U+OTyaGzND61wwJsj9nL3WjENT29xx9kIZUaflCNTEQa7kpEO2tRjJiaA9leXLFmzmVF6+8RAdpWNbMRGVt8YPyBDy0kVKmHcQOp6pC5kIGRso/sCulwo8Fn/VPrzGqB9XUWZfK5D5RArfVcXIL+USgFoaByjO4cHYLfKstbKFcuwuEbQouNOu4nqOQGtPQkjbzYXCWT/dJPvfomEHC3p5+bsPBR/TcGNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yihEwGRxWhi3jEzfDR3QeUbU/WMlC/BrwXgKCIcIk3g=;
 b=YGPBOseIeSMYbQRAoEBYQtGRqJCVogWGoRBHSxZB98SRQW6xxjXSRhsiCn16nIbs6UI/bEJlI5Gjk3Rw00K9Y5cKaUNYztkGIn9ABCrjw/DTbMGGiQ0Qq5Ob9wLGzomxofgi7Z1qv3cybWj+T8QU85QRDm9xjW1ArlrwQ2be83k+1P1AjUmTEw9L0RRXeWOAPgQiprJYSNWK1KbvebvrbbqXqXIGlODQu9GNWBFETHrqFvdbuYPrGZbxP2YkeUuwq1Jold4PZ9P+XfhhUKRvyBA5kNiyjhdEicrR4FE09A428mF5LY6Y2MY18V/uEKdRrA5zVZCL85smYrKEbcCp1Q==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by PN0P287MB0654.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:161::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 17:34:05 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362%6]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 17:34:05 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: gendef: Implement _sigfe function for TLS handling on
 AArch64
Thread-Topic: [PATCH] Cygwin: gendef: Implement _sigfe function for TLS
 handling on AArch64
Thread-Index: AdxxDV9iXaJOiQXGR0K8Ri2dIlRTVQ==
Date: Fri, 19 Dec 2025 17:34:05 +0000
Message-ID:
 <MA0P287MB3082B91F52855CCC343FEEF99FA9A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|PN0P287MB0654:EE_
x-ms-office365-filtering-correlation-id: 5ff162ef-09d1-4653-7302-08de3f24cebc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|8096899003|4053099003|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?TiLvumbrPi2c+pHIYYzefxCxMhi81KiFQH7ZsHmAJzTSVhlPpxbQV+PxO9CY?=
 =?us-ascii?Q?HABUwakMjVuZUY9x4tWhTEE6YAVsjm6FhzOqwsPaTtZK6o2kyGQC4+RiUzOp?=
 =?us-ascii?Q?fTutmkXj2txpITW/6leEZTqQKoKmGA8AV3mx7Ay5VHAnMpD8EhU9foXoSqT0?=
 =?us-ascii?Q?rM0E4OWcPq6ClFIO/FWeJixkpxlOc9VJIlMPNOokacX7/7nnexPM7Zsxdzb+?=
 =?us-ascii?Q?gXjrOGmphOY0wgXTSyN1+o9rLpEmHJ0jFBIMZ+tMjLH91Hi7PW/Dxe9AbMbz?=
 =?us-ascii?Q?5ZZrS8efgue0NUunlm/rFeTymkikFC/syrDDOQQZoCx5lOObqfOKUvTCamkn?=
 =?us-ascii?Q?TZkREzVXzdybOxaFM/KYunEpISDJeIOvHuiS8X5HES+tcb0QVdnXDHxfXUNo?=
 =?us-ascii?Q?kVF6+VMF4XSLY9sQ9Uf+QjaYZWYN3vcFTFMvT9m05nKJVtLjclmFxk06jUUf?=
 =?us-ascii?Q?TcKswROWMrWJeO4qlCODOeSVdbVosv+DJm6g2x2nhvvGHPqNp1Ils99ukqIh?=
 =?us-ascii?Q?OomQ/vd1+GIj+p2Z4WCWhXT6E7zqpY5P8I3W/nU5UW67oEVKdPb3OrDvzslj?=
 =?us-ascii?Q?AUljaB0rO4N8EX9rISX2MQDhhfKAQ6rMyt4mMsAz3mGdR26N9g5dmlcfHU9O?=
 =?us-ascii?Q?VygTHH78OthrkTuWwUdwuywnn6wQEF5mbVRB6Qp+gI+3g9C9l44rQhSi7yVW?=
 =?us-ascii?Q?a1WONhL1BK/6PUhuaR6Tl/HG1eBdNeVaq1rcMcbLhLx/v2OztwyoqSRadgH7?=
 =?us-ascii?Q?sdeNoRsS6My8IA1NUvFOJ93bqYh0kp3zjBwM2LP4mEeaENragxCbswHP2E2k?=
 =?us-ascii?Q?VXcrU2hkO/qI3+Ahc7UYfHDE9vlouwJ/Rf4KFrsytF6g3GrrKyTfJc9dDzVj?=
 =?us-ascii?Q?RY2XX20L+Po5ZVQUvLAG3ZoRl1xcAJJhF6VjwtFtvmyBph3kw6HogMdkaeay?=
 =?us-ascii?Q?SwSJhn1uucJbcIlynG9HGDumBq4NQzVaC3MEKmyblVV6bgG0NsMc0BbGNgva?=
 =?us-ascii?Q?YRhF801++l6kUKoYBpCW32FJ92HqdyO62jUwmN3IQbATsr1fg/MGmDkjTx93?=
 =?us-ascii?Q?BWmB3xd5DvNKARFqFcTnNlsI3cgdJBeD6g4Fy6B6AIOhHlTymktMctq68R+H?=
 =?us-ascii?Q?3y6wMnryUk9Qcct7c1g1bsOKW1YdjuWbIRFi/flqwIXYkR8OEt4w/v6YV3+1?=
 =?us-ascii?Q?ompSrZdH0g4JtsuLrkUgUiQULsQB+o41NRuH5NoTGM3UFNWr7FWm0yH+Tvpq?=
 =?us-ascii?Q?xguZEAi66dQ1uMAltDW7xVqCaGtVPVawx5kwOge6fGcxgLw6zk7FkkMwGSUu?=
 =?us-ascii?Q?wcnGX7PVTYJgt2gS1KFc6KoaIaq3NHX1+BnIp3b106eGN12r/JIxvCT3PEUn?=
 =?us-ascii?Q?0lmZXoL2N9FlnCEdDcAI9gekQTApx9iP3IxwPjgTRZm5WqxvJWL82ryrnmRa?=
 =?us-ascii?Q?l5gGmNfMDArmUoE7SS4AagtxTCXJr0mLdoUAOrVKTy9Q4WvMlXkY9RZyOHSp?=
 =?us-ascii?Q?1+RI//P80AZ8WsO3lIawkphr6a5O2lwkhUPm?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(8096899003)(4053099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gUU19/iEkCzZbGfeJn7pLqT61CIx84Zw7uBGNlvndKevdjGXXt8jsX85q98z?=
 =?us-ascii?Q?+SLkP/0HGrALPrQl1WzbjPnTj3JeC2xDbPFO1BKv/KNUB78ugDFCouM/UBvW?=
 =?us-ascii?Q?xJrVUuJwkYeLpZTbY32itgBbu8jI/2faOyVlaC7oV+cyIP3fwemYCG07e+DY?=
 =?us-ascii?Q?JO529TKb8g/GJUv2MZg0oLFa53uGdynM4eHkuXmbCDZiH4giApMZi2CBeDA6?=
 =?us-ascii?Q?IAAwTQnl873WQneDb3p/ejot+5VMiLYAyuR5R2YkC7IVXd7wtTKBdM7ofGJl?=
 =?us-ascii?Q?DZCSRFP0rSsVHM7Y/phAJ4XhRanB1VHuA71opYd2TfsSiSPDA0UDWZDJZ3kF?=
 =?us-ascii?Q?L/NlY0bOqA/uNpCUSwkpV9xNQXbdiQIcfG0Z8vf+P+0I3Lp42czgI3FdGVO+?=
 =?us-ascii?Q?Pw74GrETUfVTcPqts2GMJ4YVAEpfni26QLcbCcOVbuyzHjX4Ao9aAOqpUPir?=
 =?us-ascii?Q?AywR2F65VmgERrnC/zfBINyMwiT6TkS1MrbH7mfvXfJC17bOWjfHGyUGIgbq?=
 =?us-ascii?Q?0e6gIak5JdlfAsCFup47vB2O1B5D1WKU3diMqYjLAhECB3A13fb4X2CAStwA?=
 =?us-ascii?Q?k1TESmX7G+74yXqrKZBfXNlMSbuT25JAJw6lIClbkJnlQeose3c2gICT46S6?=
 =?us-ascii?Q?Vmv+DZGBN8GXlSIzolbHk03rf8cCpszHX58AeKWYup1wetYEPMGuZSiDa2ca?=
 =?us-ascii?Q?hNDCYr15r5goJJrMFIpGjlFSHWYGbsxS/l58RbKFwiSwWZCARWcCXQm+b4sa?=
 =?us-ascii?Q?LCkad+J2cBjeSB/UzZ0Su3LlvmjYU8kUfW4VLHA0BOOl2zjKDJ3T7DfYZUIJ?=
 =?us-ascii?Q?JE9hv8y5pQhXZg9+I+qEWCcxSBwyAwCJBsNCwYvzXScSRwwrWSkJd+PTnTUv?=
 =?us-ascii?Q?7MbgrMpYz2T4VsiKyn4yCFq8DbFOlrMYe0WHje+go14PiATVp4cu+POsqB6I?=
 =?us-ascii?Q?0+olKVy3M7QLYxuKkSfmyoKfkwLvqk8W8Exm4JyrzoXEyYS9k5ZUv5D5jJzT?=
 =?us-ascii?Q?voSCjY8TcqwXD0I3lxH4YStVIedYYK93bXzLeda6FzsCsXWPPffVtqjfBoVy?=
 =?us-ascii?Q?pvhnqr+OJLJKJ1N5Br93298Et6PMqhZCjn/b9Uzf0Y4nrmHdGI5KHCpa5uaG?=
 =?us-ascii?Q?qM4xdZtT3elAoXpGoEibgdXgyZv/NsghucHpAnaQxDPcAf2Xpnh07Uq9tEPB?=
 =?us-ascii?Q?c6gkdYuEC+KxDWdLKYHi0IAS+rIPIXqnebZF2cJRbM0gmqaIE6QCgxiwWXcQ?=
 =?us-ascii?Q?AsMXXLMKg99VzZf+rLAhoRUnLPotfjWsF7V0JbUp23g/YCNbJv1Ur7o5qLcH?=
 =?us-ascii?Q?oQLC3GVioryY0yyGsfTg0cFK26l5RqZpTgVO5otSNwGDKZYgv0TqYALpXQ82?=
 =?us-ascii?Q?E5RPcuppKMor8NgGApzqxTMt4QwU8onoG7M06wj6Z+ufNETdo41lfiqJigMJ?=
 =?us-ascii?Q?jwv1etreYJvlme6o5xi3XM1Bp0aZ8BA0mfypvDRzhJq115ukpvMDcoBH/Y70?=
 =?us-ascii?Q?Qn82t5lE9oj0MAGjn47kTbDi++AR89aB/az3ilc3nIAeuOafIj20AmQa7+2k?=
 =?us-ascii?Q?KhLtC8/6hwpK2L3DGi+9ok6n8BWnv2ncPJYP4NMgy/aYQCAT4NBUg6XgoWUV?=
 =?us-ascii?Q?gcOxeozQbu17VFtq5e/4QI5sU2StKNIFHwZVmqLJFdQwEha5mdEWiWz17tWJ?=
 =?us-ascii?Q?ZhnUYm4Zs3u6lQmFEtRLJdGD+qjjdj+QLdHgHUExq/aEdtB8ZvzHTIkFpOwW?=
 =?us-ascii?Q?/2jWPqkrdp3SpeJxzJGmmaYwTlLL0PfYTTk8AL9sugX8gzS5N3RL60UhIVpp?=
x-ms-exchange-antispam-messagedata-1:
 f8vXzOgSQByfeRbt7HkQdpFn3rnpK0oJUe6BBsCKlV8jiLL6Q9qnEuEK
Content-Type: multipart/mixed;
	boundary="_004_MA0P287MB3082B91F52855CCC343FEEF99FA9AMA0P287MB3082INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff162ef-09d1-4653-7302-08de3f24cebc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2025 17:34:05.2621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: puF37nlEZc3ejzplyAjzSu8AG6OzP1fGWbEydIuaGBeNPczvkJxsa46FjRfT37M7utxGNh1dvnmGwoYvSCCeC5x2/eefxzCHlP5YzYO4kYRX6QpKjK//E+ZlExGVmyT1XLSOPJJmRH9Jhw2szKnNog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB0654
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_MA0P287MB3082B91F52855CCC343FEEF99FA9AMA0P287MB3082INDP_
Content-Type: multipart/alternative;
	boundary="_000_MA0P287MB3082B91F52855CCC343FEEF99FA9AMA0P287MB3082INDP_"

--_000_MA0P287MB3082B91F52855CCC343FEEF99FA9AMA0P287MB3082INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

Please find the attached patch which adds an ARM64 stub for the `_sigfe` ro=
utine
in the gendef script.

Any feedback or nits are very welcome. The changes are documented with inli=
ne
comments intended to be self-explanatory. please let me know if any part
of this patch should be adjusted.

Thanks for your time and review.

Thanks & regards
Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>

In-lined patch:

diff --git a/winsup/cygwin/scripts/gendef b/winsup/cygwin/scripts/gendef
index 52a5b77ca..976e0f9f6 100755
--- a/winsup/cygwin/scripts/gendef
+++ b/winsup/cygwin/scripts/gendef
@@ -385,7 +385,44 @@ _sigfe_maybe:                                      # s=
tack is aligned on entry!
        ret
        .seh_endproc

+    .seh_proc _sigfe
 _sigfe:
+    .seh_endprologue
+    ldr     x10, [x18, #0x8]           // Load TLS base into x10
+    mov     w9, #1                     // constant value for lock acquisit=
ion
+0:  ldr     x11, =3D_cygtls.stacklock    // Load offset of stacklock
+    add     x12, x10, x11              // Compute final address of stacklo=
ck
+    ldaxr   w13, [x12]                 // Load current stacklock value ato=
mically
+    stlxr   w14, w9, [x12]             // Attempt to store 1 to stacklock =
atomically
+    cbnz    w14, 0b                    // Retry if atomic store failed
+    cbz     w13, 1f                    // If lock was free, proceed
+    yield
+    b       0b                         // Retry acquiring the lock
+1:
+    ldr     x11, =3D_cygtls.incyg        // Load offset of incyg
+    add     x12, x10, x11              // Compute final address of incyg
+    ldr     w9, [x12]                  // Load current incyg value
+    add     w9, w9, #1                 // Increment incyg
+    str     w9, [x12]                  // Store updated incyg value
+    mov     x9, #8                     // Set stack frame size increment (=
8 bytes)
+2:  ldr     x11, =3D_cygtls.stackptr     // Load offset of stack pointer
+    add     x12, x10, x11              // Compute final address of stack p=
ointer
+    ldaxr   x13, [x12]                 // Atomically load current stack po=
inter
+    add     x14, x13, x9               // Compute new stack pointer value
+    stlxr   w15, x14, [x12]            // Attempt to update stack pointer =
atomically
+    cbnz    w15, 2b                    // Retry if atomic update failed
+    str     x30, [x13]                 // Save LR(return address) on stack
+    adr     x11, _sigbe                // Load address of _sigbe
+    mov     x30, x11                   // Set LR =3D _sigbe
+    ldr     x11, =3D_cygtls.stacklock    // Load offset of stacklock TLS v=
ariable
+    add     x12, x10, x11              // Compute final address of stacklo=
ck
+    ldr     w9, [x12]                  // Load current stacklock value
+    sub     w9, w9, #1                 // Decrement stacklock to release l=
ock
+    stlr    w9, [x12]                  // Store stacklock value (release l=
ock)
+    ldr     x9, [sp], #16              // Pop real func address from stack
+    br      x9                         // Branch to real function
+    .seh_endproc
+
 _sigbe:
        .global sigdelayed
        .seh_proc sigdelayed


--_000_MA0P287MB3082B91F52855CCC343FEEF99FA9AMA0P287MB3082INDP_--

--_004_MA0P287MB3082B91F52855CCC343FEEF99FA9AMA0P287MB3082INDP_
Content-Type: application/octet-stream;
	name="Cygwin-gendef-Implement-_sigfe-function-for-TLS-hand.patch"
Content-Description:
 Cygwin-gendef-Implement-_sigfe-function-for-TLS-hand.patch
Content-Disposition: attachment;
	filename="Cygwin-gendef-Implement-_sigfe-function-for-TLS-hand.patch";
	size=2815; creation-date="Fri, 19 Dec 2025 17:33:41 GMT";
	modification-date="Fri, 19 Dec 2025 17:34:05 GMT"
Content-Transfer-Encoding: base64

RnJvbSBmYmJkYWU1NmM3YTEwOGVmYWQwYmEzN2IyZjNkZTRiMGQxZmE2MjJj
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5h
Z2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJl
aW5jLmNvbT4KRGF0ZTogU2F0LCA2IERlYyAyMDI1IDE5OjE2OjIxICswNTMw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBnZW5kZWY6IEltcGxlbWVudCBf
c2lnZmUgZnVuY3Rpb24gZm9yIFRMUwogaGFuZGxpbmcgb24gQUFyY2g2NAoK
U2lnbmVkLW9mZi1ieTogVGhpcnVtYWxhaSBOYWdhbGluZ2FtIDx0aGlydW1h
bGFpLm5hZ2FsaW5nYW1AbXVsdGljb3Jld2FyZWluYy5jb20+Ci0tLQogd2lu
c3VwL2N5Z3dpbi9zY3JpcHRzL2dlbmRlZiB8IDM3ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDM3IGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL3Njcmlw
dHMvZ2VuZGVmIGIvd2luc3VwL2N5Z3dpbi9zY3JpcHRzL2dlbmRlZgppbmRl
eCA1MmE1Yjc3Y2EuLjk3NmUwZjlmNiAxMDA3NTUKLS0tIGEvd2luc3VwL2N5
Z3dpbi9zY3JpcHRzL2dlbmRlZgorKysgYi93aW5zdXAvY3lnd2luL3Njcmlw
dHMvZ2VuZGVmCkBAIC0zODUsNyArMzg1LDQ0IEBAIF9zaWdmZV9tYXliZToJ
CQkJCSMgc3RhY2sgaXMgYWxpZ25lZCBvbiBlbnRyeSEKIAlyZXQKIAkuc2Vo
X2VuZHByb2MKCisgICAgLnNlaF9wcm9jIF9zaWdmZQogX3NpZ2ZlOgorICAg
IC5zZWhfZW5kcHJvbG9ndWUKKyAgICBsZHIgICAgIHgxMCwgW3gxOCwgIzB4
OF0JCS8vIExvYWQgVExTIGJhc2UgaW50byB4MTAKKyAgICBtb3YgICAgIHc5
LCAjMQkJCS8vIGNvbnN0YW50IHZhbHVlIGZvciBsb2NrIGFjcXVpc2l0aW9u
CiswOiAgbGRyICAgICB4MTEsID1fY3lndGxzLnN0YWNrbG9jawkvLyBMb2Fk
IG9mZnNldCBvZiBzdGFja2xvY2sKKyAgICBhZGQgICAgIHgxMiwgeDEwLCB4
MTEJCS8vIENvbXB1dGUgZmluYWwgYWRkcmVzcyBvZiBzdGFja2xvY2sKKyAg
ICBsZGF4ciAgIHcxMywgW3gxMl0JCQkvLyBMb2FkIGN1cnJlbnQgc3RhY2ts
b2NrIHZhbHVlIGF0b21pY2FsbHkKKyAgICBzdGx4ciAgIHcxNCwgdzksIFt4
MTJdCQkvLyBBdHRlbXB0IHRvIHN0b3JlIDEgdG8gc3RhY2tsb2NrIGF0b21p
Y2FsbHkKKyAgICBjYm56ICAgIHcxNCwgMGIJCQkvLyBSZXRyeSBpZiBhdG9t
aWMgc3RvcmUgZmFpbGVkCisgICAgY2J6ICAgICB3MTMsIDFmCQkJLy8gSWYg
bG9jayB3YXMgZnJlZSwgcHJvY2VlZAorICAgIHlpZWxkCisgICAgYiAgICAg
ICAwYgkJCQkvLyBSZXRyeSBhY3F1aXJpbmcgdGhlIGxvY2sKKzE6CisgICAg
bGRyICAgICB4MTEsID1fY3lndGxzLmluY3lnCS8vIExvYWQgb2Zmc2V0IG9m
IGluY3lnCisgICAgYWRkICAgICB4MTIsIHgxMCwgeDExCQkvLyBDb21wdXRl
IGZpbmFsIGFkZHJlc3Mgb2YgaW5jeWcKKyAgICBsZHIgICAgIHc5LCBbeDEy
XQkJCS8vIExvYWQgY3VycmVudCBpbmN5ZyB2YWx1ZQorICAgIGFkZCAgICAg
dzksIHc5LCAjMQkJCS8vIEluY3JlbWVudCBpbmN5ZworICAgIHN0ciAgICAg
dzksIFt4MTJdCQkJLy8gU3RvcmUgdXBkYXRlZCBpbmN5ZyB2YWx1ZQorICAg
IG1vdiAgICAgeDksICM4CQkJLy8gU2V0IHN0YWNrIGZyYW1lIHNpemUgaW5j
cmVtZW50ICg4IGJ5dGVzKQorMjogIGxkciAgICAgeDExLCA9X2N5Z3Rscy5z
dGFja3B0cgkvLyBMb2FkIG9mZnNldCBvZiBzdGFjayBwb2ludGVyCisgICAg
YWRkICAgICB4MTIsIHgxMCwgeDExCQkvLyBDb21wdXRlIGZpbmFsIGFkZHJl
c3Mgb2Ygc3RhY2sgcG9pbnRlcgorICAgIGxkYXhyICAgeDEzLCBbeDEyXQkJ
CS8vIEF0b21pY2FsbHkgbG9hZCBjdXJyZW50IHN0YWNrIHBvaW50ZXIKKyAg
ICBhZGQgICAgIHgxNCwgeDEzLCB4OQkJLy8gQ29tcHV0ZSBuZXcgc3RhY2sg
cG9pbnRlciB2YWx1ZQorICAgIHN0bHhyICAgdzE1LCB4MTQsIFt4MTJdCQkv
LyBBdHRlbXB0IHRvIHVwZGF0ZSBzdGFjayBwb2ludGVyIGF0b21pY2FsbHkK
KyAgICBjYm56ICAgIHcxNSwgMmIJCQkvLyBSZXRyeSBpZiBhdG9taWMgdXBk
YXRlIGZhaWxlZAorICAgIHN0ciAgICAgeDMwLCBbeDEzXSAgICAgICAgICAg
ICAgICAgLy8gU2F2ZSBMUihyZXR1cm4gYWRkcmVzcykgb24gc3RhY2sKKyAg
ICBhZHIgICAgIHgxMSwgX3NpZ2JlCQkvLyBMb2FkIGFkZHJlc3Mgb2YgX3Np
Z2JlCisgICAgbW92ICAgICB4MzAsIHgxMSAgICAgICAgICAgICAgICAgICAv
LyBTZXQgTFIgPSBfc2lnYmUKKyAgICBsZHIgICAgIHgxMSwgPV9jeWd0bHMu
c3RhY2tsb2NrCS8vIExvYWQgb2Zmc2V0IG9mIHN0YWNrbG9jayBUTFMgdmFy
aWFibGUKKyAgICBhZGQgICAgIHgxMiwgeDEwLCB4MTEJCS8vIENvbXB1dGUg
ZmluYWwgYWRkcmVzcyBvZiBzdGFja2xvY2sKKyAgICBsZHIgICAgIHc5LCBb
eDEyXQkJCS8vIExvYWQgY3VycmVudCBzdGFja2xvY2sgdmFsdWUKKyAgICBz
dWIgICAgIHc5LCB3OSwgIzEJCQkvLyBEZWNyZW1lbnQgc3RhY2tsb2NrIHRv
IHJlbGVhc2UgbG9jaworICAgIHN0bHIgICAgdzksIFt4MTJdCQkJLy8gU3Rv
cmUgc3RhY2tsb2NrIHZhbHVlIChyZWxlYXNlIGxvY2spCisgICAgbGRyICAg
ICB4OSwgW3NwXSwgIzE2ICAgICAgICAgICAgICAvLyBQb3AgcmVhbCBmdW5j
IGFkZHJlc3MgZnJvbSBzdGFjaworICAgIGJyICAgICAgeDkJCQkJLy8gQnJh
bmNoIHRvIHJlYWwgZnVuY3Rpb24KKyAgICAuc2VoX2VuZHByb2MKKwogX3Np
Z2JlOgogCS5nbG9iYWwJc2lnZGVsYXllZAogCS5zZWhfcHJvYyBzaWdkZWxh
eWVkCi0tCjIuNTIuMC53aW5kb3dzLjEKCg==

--_004_MA0P287MB3082B91F52855CCC343FEEF99FA9AMA0P287MB3082INDP_--
