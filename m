Return-Path: <SRS0=H4g6=6Z=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11021111.outbound.protection.outlook.com [40.107.51.111])
	by sourceware.org (Postfix) with ESMTPS id C948C4BA2E05
	for <cygwin-patches@cygwin.com>; Fri, 19 Dec 2025 17:38:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C948C4BA2E05
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C948C4BA2E05
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=40.107.51.111
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1766165913; cv=pass;
	b=YRCt5ChNqYgVhT+8luSnVtn3E4TRDF2pVeiFY9cUiZfw9o+tjRHv4o7C2HkjEjgZOCmkpeNBG/rGgnrBUSj7/RLEGBqPX/C0lmESh+MAzHK6Ukz6DOliTD2pd7tEFXgLLhl1QDbBavRabOeHzwJIeyW5WDEjppS9mm3rEfH/IQg=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766165913; c=relaxed/simple;
	bh=cMXfNVB9Eu3ENhIQCL6ZV84GxgsQsh06mO50C6VUwvc=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=OhABhvPIyRK5uOQiFoN84lLvKSYhwwOYoblQ6PwlCl3cS/HU4/7705pGqXMPK4+RAPvsHSdsuVWwVq7DgWu+o3hD0hIrTfFUQf6D5w3IEEIjSXjlWZt2IrfHfsrrLwxyhVwt8drmbGVdyIusmtlXycRYbH9hqh9cUfv1x6MJEcg=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C948C4BA2E05
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=BnPZwz14
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=or+AxrT9kgBQgjrboqoV5RVLYHD/fcS1f1y6svbEB/oGEGMTZ1DcKGtiiYe5eT74rg8NkNsXSLfKEa/Y7oXhhurdQYmk7KViXSnBjWwzlLVDp25k0018NQmTHXP4B4GSspaZtro39RY9h7OXLkP4Xdz1+L3VphPAblCgkr1BP68l68QjjtEXUKGlJTuyGaB7aoGuqEkXSA4KsOgWAFrr4XTFR3RmR4fRrqYW3Se0zfxLqzW9bxYk3r7rOMOH6RcfrQKHSmKWlNXVe95ebETMCkqE2Y4P+kqf49b6t6sjMtF69jI6uzkqPVvPIqS/0wmzO/cDGzt3Unu0s37TTHQ5IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIpfuFpxjn7HwWbH+XSixtF8JKOHH8e4UhOrjipUjyk=;
 b=ybmAVWCR9Z08hBOwB7N2E6T2EE6idZvNp3H17avQOkYl4WRo7hJvDYsKGoSzgR6O4oYVLHzyahJCCeZljMA96qWYwI1sajYa9Diusvaz5ZR1QxVsJbOmeYtHX4Nm2tY7hdSu4DFKGOAmwbFbZNRlRgXpaPq9VGnhyM+TflkPaF9wp7UBzHqsw/wlNdd0MqiGYi58WZL+aOgHphTqk14VFqqlI5izTUeKcOQMRHtVEkZEoPlUEWK0RwtU9von5daCaI+zuHFJ3eXjLKNDtR7pYIcL+s+94yu0qYNzxkL4nBVH0k+umSHjKnfDx1Q+5OI3fq5rt9zfpT6Gm1j6S1eljA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIpfuFpxjn7HwWbH+XSixtF8JKOHH8e4UhOrjipUjyk=;
 b=BnPZwz14Yq9Wjv31R5qtvIJKVybmgi/vG7ECj3gSTxykz8owRjEkZADP3xOX9j56XE9/HviPLAG/WQNHtVNMBtFK+xw8ggLSFMvY3TTfM1ZKiTbKuiH8+Pmn4rNKESUcB1gzIK3ZF+RVfUJOHMzuzqp9C8WDR8M5OTEttEdX9RXYrrSi1bdXDAyuBgWI2HheZNIIfUE5A7XH3j+RemHFWaKW6yXUNV4uq4IS9syzkP8J3qxhheXvnR6v+/Azkm4DohX9YFmE0APxgjjLbXXMpzRzll+iMbvs7aCQ2rfX5ujYIRyTZIaN92gxK7pP6NVLD9hLbltgPD1VWNwNAH4HxQ==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by PN0P287MB0654.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:161::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 17:38:29 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362%6]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 17:38:29 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: gendef: Implement _sigbe function for TLS stack
 management on AArch64
Thread-Topic: [PATCH] Cygwin: gendef: Implement _sigbe function for TLS stack
 management on AArch64
Thread-Index: AdxxDeSTeAQcHTWWRjqsXI3nMNjeLg==
Date: Fri, 19 Dec 2025 17:38:29 +0000
Message-ID:
 <MA0P287MB308261C0D8BCD6FD5842A5039FA9A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|PN0P287MB0654:EE_
x-ms-office365-filtering-correlation-id: ca34d38e-ee35-4bbb-3490-08de3f256c3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|8096899003|4053099003|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2F8HrP9Jwhwculj49W+j+sa2ty3A7qu8AAJwjJq4JUgeXh9MfcrJCpjjJG//?=
 =?us-ascii?Q?ibwXFp+hh46iUX8i15XhO1gkQYa7I37KsyofS+FleAXUVBGzy+/App3By7cK?=
 =?us-ascii?Q?fjolqNEh/uqc6DPIcQ3rHTwUQTlFVlXjs3xEq+eSMknb8eWgha6kk6wdFr9m?=
 =?us-ascii?Q?V05+vaGis7iRiii89rrzUKdDoO7iBCmGuJrpEatROYLSbeOzwXUqY11aF+sT?=
 =?us-ascii?Q?6FX9e3cExeDv8b5VrkIi640YSAaPXbijbZm9JcbnpY5PG2bWDDXqTAZG//ko?=
 =?us-ascii?Q?KRNY0RdBxDUrJntwYPXIojYIPGAOgQ2+DhVVj8Oyd9yVzOQ+Ao7R7BLebMKz?=
 =?us-ascii?Q?4M8+2RWZQ15bUx5YWrX4SiUjwBFZCv5xLCC6lpsEWGMXuatNUw5cVJAe/X5k?=
 =?us-ascii?Q?5TAgEDNwTf/X3ZEmaKL85nOFg/G4xQ6zaqUw4XfQ6Sz+8jXXOWmW52G6OZMZ?=
 =?us-ascii?Q?NGHyQxXEnJaR9+Y0+r6LkysSGgn8bzOgr2q7ewAipXjUwy3jxqECuVPLSabY?=
 =?us-ascii?Q?SY3OJmHzuMpLnDqkBN6jK8duRChI6opYewbwsyl0TQtSLMroSVgX070d8L08?=
 =?us-ascii?Q?Fg1ZuARhHnR1UVurh1HBkJsADZHVvd6gquxhWAuumzhvfmNQQqixE2faQW5T?=
 =?us-ascii?Q?JKYPCmHeW0kUFKmN+pDiiMuLd42nDcP+4+PIhIOEyqMpFMGpinbv1bK+PYVc?=
 =?us-ascii?Q?J9SdCdn1KKs94i85w6IqQbj2ARTptOcr4W1mZNnmQKz8r0J7lgIR8iR1yX3m?=
 =?us-ascii?Q?GPTeBF71mkt0kLcAIxtAzYmVN6bQ8quH1JJXiYoTfxa13L8KdFE/4rcjh5Pr?=
 =?us-ascii?Q?CqFf/qcFF8KvCDs5lvKaK5dB82WVK31cAYNFTxZBhFcc6vpOBDv462czJUpr?=
 =?us-ascii?Q?q3Q+9bx0GWKL6JjAxJZlhCXk2KflfQGAdVeEwehtBO6W40nV/NsVZvQFBV0R?=
 =?us-ascii?Q?KjcpHyTfiQEMQA9/NYoQ1ENlymAX5R/iuLtHDu40c2Y46YG9hARA8pQuMNQz?=
 =?us-ascii?Q?JCkAqHvGI8eVv/MzoKUXLcUuwbuwUZ46a4a5oGwjlYr3B5gwSKtbiueS/chs?=
 =?us-ascii?Q?cTosveSZqKuQTj0BBEtYXG3/iH8uix9rznPmJE+XayWXjhE1zbu2ZTwEHb7z?=
 =?us-ascii?Q?BL3LlfBiWIMwMpleaJdLs2065shQ9xEznFtNQh71qcsbnZi7/jlrljEBohtx?=
 =?us-ascii?Q?FLyb+zlzym+OQkq0IXGyPPH1L1CI8r5X4sBvoGTxICgxlugxy2/qQNsf1hTk?=
 =?us-ascii?Q?FORdoVkXD//fGhHiVe5tHbDQj6VQsttzcgvFStI3viqb5szM5Xw51iiQ3kFo?=
 =?us-ascii?Q?Y9WMMLl9xJg10TaX4WyoY45A4y+uPE1kGt3puSPkKjI+PWlTSg+MWrC647T/?=
 =?us-ascii?Q?DSi+2a3KKKfOienW8kCpPrM7Uf+5jYqp2jAZR9enucv7BYjjPJPbPJjf9Rw1?=
 =?us-ascii?Q?g+yaHaq7uoBiSiP/toVEAIDtP8j5v+MHVyQrF96BY2i4WzbSmkYp9vf1+W0e?=
 =?us-ascii?Q?7fZHbVimk+4i83z90pqTSbFKGJntP+wOEObA?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(8096899003)(4053099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pDRzFazen4GY3Ad+ohEzmhrv1VsRkpi5kCmy2yk5RTCfPrXoPvEkkVXktWt4?=
 =?us-ascii?Q?9yYaTTB4HzVzndGYIBw7fK1wFpjZRk2b5vIEA+w9gaD2RgUAb8Z1hYdYCucb?=
 =?us-ascii?Q?QRk8pFkIgWX0D3sXWhYx+8hY8nMkCuK5xr0Qe8RpH4wvRNgKzpITngjMUPkg?=
 =?us-ascii?Q?ubyeP9oDDg9vwIpAvzcxNEy5+JxjOIfuSEYU8E1sfikJUWRI/ZDQwfnTvej5?=
 =?us-ascii?Q?kObaAeAdJZY8/lhsvTRt9/mRxeE31es4bHe4yBiOnX3/REmexQF+fSuVJrCu?=
 =?us-ascii?Q?428MqN+h5/ObGUGa6vykxmnHuQ1i/X0JjZnEw7qGIJsy+NU0iaS5F23nONRJ?=
 =?us-ascii?Q?BeSlK1n5y94MkD0udp2oYHXfnlNpG20M1r+pGubfMnIY9kDKUeddm+IIa1an?=
 =?us-ascii?Q?VuJoKGImtwucBPMsRRMKgO8d9H/x2xYEy4dJcguedv0RZ3ZVy4NysmAAqiCH?=
 =?us-ascii?Q?nEnYQAK2m/uRUErxYQLFOAk+u31IscCP0bG031RNFpPkKXy6/KEjbDPUXjN+?=
 =?us-ascii?Q?c+KlsQK24R92jRMf9j9R4veTTRDl1AS9sCizcmipl1SsrD9rb2LMQ2aZNvjR?=
 =?us-ascii?Q?LSR1uQY3Q4utVpbBFhHkS5oR5QS1HcmgSLmA/+CytOdi2d1/GSh9acQFYGQx?=
 =?us-ascii?Q?mfjB3C+L6TyB1CBXKXJxtTo5S1ahX61BViTGI+4IA1f2lSWq+4pOTO+yB1NU?=
 =?us-ascii?Q?gwRkyo8QVkKmrZZiTQNWpBG/qNMt1hecFGd7PQ3a/X+r7erceFzEDPckTzg7?=
 =?us-ascii?Q?NPSMDsEGydxLW39pydd+/IDzbpEkVkxJF99p1jsBuMLwmGuWjAvYeWWl4+cI?=
 =?us-ascii?Q?ukTjDSitSfUOP1wcdPh81QEQFOjSrGhVF9o26HcsSa/XLg3I/DYU04S8WvLM?=
 =?us-ascii?Q?P0a47k2KpLY87Seegfn0KhSFddVZELX36Uiubmw54OEpMmxwc7Oq82/Uf/h3?=
 =?us-ascii?Q?pm0VOVUct6KZBPpF0wmOLIxQDKfkVzC+uGF2SZkmBc8htnULgqlkI3tu4Qwo?=
 =?us-ascii?Q?txqLIQBMJVm0Q+nDVZPbmRQFnacydtmaMq6qRTlSsFUp6bVo3FV5zYNTjzJr?=
 =?us-ascii?Q?HFwZqtmhERtyPUWNHBEuZlm9N5rA9LneqQeRgUQyTYtYPywYaShXUAv3oLGr?=
 =?us-ascii?Q?G5oNvu5fj65KDMI5nUdzHBDpnj/chzz3hYrrMiZUs2vv5dNcPIgCX5NlVpHn?=
 =?us-ascii?Q?3+SHAyFqt3e9dA9g26SzKRBuywW7/Z6ZYhcltlM/x5wA+AoC8cZG67mZx3qt?=
 =?us-ascii?Q?YhU9vVEJ7B2OSZituBeo3JZh3A8x2P7xDvU5xEKcvT5Iaoz27Rj4VvIMlrXl?=
 =?us-ascii?Q?P4fb6cHEzRnA8iHVId4xC2QK8BdhrrRDUf6WVDx2jUKLJsHTDhFOi8fedYDC?=
 =?us-ascii?Q?5FjDCWlTYhK4gA0uNPM30rd7Cdp2ClZBSDvl+GiQIlB7dVHdQMn2fHDmU4lh?=
 =?us-ascii?Q?UYqMCw/ZBnqs/ZmHcxMrMOmJhyRnJ17i1uQxFgC3QBq/uZZHbU2vvi+16WD8?=
 =?us-ascii?Q?c57fYM0nEIpaKVwKY143M+72ymoRTPpdVOmzYEdlfH1955o4xzuV0AVihH/F?=
 =?us-ascii?Q?6cE1J9mpREw6RMWf6lg3Dml1yK+xiqBx8IUYKm8/LvLFhu2teTBML4KeUOm9?=
 =?us-ascii?Q?dgRCylBD9bigQ1MiX0vYpERoyHh0A1QqwqkY4/HhWZNnojApT6BMgJG7YpVJ?=
 =?us-ascii?Q?6h5SPJmx1kZAbL/dustjlZLT79TIcr7y0KZ3T0bQtXqjgqGTltqPv/qDPnc2?=
 =?us-ascii?Q?0fpjRG8oP93yy7EyGu//7R9DlAnyrH/SMKimvZ9o+m9Y8QnichD+qnslS6VX?=
x-ms-exchange-antispam-messagedata-1:
 RlHxYZjTGXZk4HMkVk2ZyfZe9vQo6l6hh0Z3XIdFTTLTWOkd67cM/u7O
Content-Type: multipart/mixed;
	boundary="_004_MA0P287MB308261C0D8BCD6FD5842A5039FA9AMA0P287MB3082INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ca34d38e-ee35-4bbb-3490-08de3f256c3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2025 17:38:29.5504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GvYoZIoQdELZMvRolRFYrvtGTykxI53LE7U1/zB/lzS3lntZvmh407ufJOoQQuvQRz1GBojVnaC2uiXNlH4f8URJRJBhgHvRorVdHrNwkO+iljKhis1IoDBLiJI7f3sBv/EAe/rTSpn34HJ5FbSkKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB0654
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_MA0P287MB308261C0D8BCD6FD5842A5039FA9AMA0P287MB3082INDP_
Content-Type: multipart/alternative;
	boundary="_000_MA0P287MB308261C0D8BCD6FD5842A5039FA9AMA0P287MB3082INDP_"

--_000_MA0P287MB308261C0D8BCD6FD5842A5039FA9AMA0P287MB3082INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

Please find the attached patch which adds an ARM64 stub for the `_sigbe` ro=
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
index 976e0f9f6..fdb970f6f 100755
--- a/winsup/cygwin/scripts/gendef
+++ b/winsup/cygwin/scripts/gendef
@@ -423,7 +423,43 @@ _sigfe:
     br      x9                         // Branch to real function
     .seh_endproc

+    .global _sigbe
+    .seh_proc _sigbe
 _sigbe:
+    .seh_endprologue
+    ldr     x10, [x18, #0x8]           // Load TLS base into x10
+    mov     w9, #1                     // Constant value 1 for lock acquis=
ition
+3:  ldr     x11, =3D_cygtls.stacklock    // Load offset of stacklock
+    add     x12, x10, x11              // Compute final address of stacklo=
ck
+    ldaxr   w13, [x12]                 // Load current stacklock value ato=
mically
+    stlxr   w14, w9, [x12]             // Attempt to set stacklock atomica=
lly
+    cbnz    w14, 3b                    // Retry if failed
+    cbz     w13, 4f                    // If lock was free, continue
+    yield
+    b       3b                         // Retry acquiring the lock
+4:
+    mov     x9, #-8                    // Set stack pointer decrement value
+5:  ldr     x11, =3D_cygtls.stackptr     // Load offset of stack pointer
+    add     x12, x10, x11              // Compute final address of stack p=
ointer
+    ldaxr   x13, [x12]                 // Load current stack pointer atomi=
cally
+    add     x14, x13, x9               // Compute new stack pointer value
+    stlxr   w15, x14, [x12]            // Attempt to update stack pointer =
atomically
+    cbnz    w15, 5b                    // Retry if atomic update failed
+    sub     x13, x13, #8               // Compute address where LR was sav=
ed
+    ldr     x30, [x13]                 // Restore saved LR
+    ldr     x11, =3D_cygtls.incyg        // Load offset of incyg
+    add     x12, x10, x11              // Compute final address of incyg
+    ldr     w9, [x12]                  // Load current incyg value
+    sub     w9, w9, #1                 // Decrement incyg
+    str     w9, [x12]                  // Store updated incyg value
+    ldr     x11, =3D_cygtls.stacklock    // Load offset of stacklock
+    add     x12, x10, x11              // Compute final address of stacklo=
ck
+    ldr     w9, [x12]                  // Load current stacklock value
+    sub     w9, w9, #1                 // Decrement stacklock (release loc=
k)
+    stlr    w9, [x12]                  // Store stacklock
+    ret                                // Return to caller using restored =
LR
+    .seh_endproc
+
        .global sigdelayed
        .seh_proc sigdelayed
 sigdelayed:



--_000_MA0P287MB308261C0D8BCD6FD5842A5039FA9AMA0P287MB3082INDP_--

--_004_MA0P287MB308261C0D8BCD6FD5842A5039FA9AMA0P287MB3082INDP_
Content-Type: application/octet-stream;
	name="Cygwin-gendef-Implement-_sigbe-function-for-TLS-stac.patch"
Content-Description:
 Cygwin-gendef-Implement-_sigbe-function-for-TLS-stac.patch
Content-Disposition: attachment;
	filename="Cygwin-gendef-Implement-_sigbe-function-for-TLS-stac.patch";
	size=2672; creation-date="Fri, 19 Dec 2025 17:37:01 GMT";
	modification-date="Fri, 19 Dec 2025 17:38:29 GMT"
Content-Transfer-Encoding: base64

RnJvbSBjYzFjZjlhMWI0M2YxN2VhZTQxOGU0MGU5OWZiMjEyMGFmM2JmNzE4
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5h
Z2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJl
aW5jLmNvbT4KRGF0ZTogU2F0LCA2IERlYyAyMDI1IDE5OjE3OjMxICswNTMw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBnZW5kZWY6IEltcGxlbWVudCBf
c2lnYmUgZnVuY3Rpb24gZm9yIFRMUyBzdGFjawogbWFuYWdlbWVudCBvbiBB
QXJjaDY0CgpTaWduZWQtb2ZmLWJ5OiBUaGlydW1hbGFpIE5hZ2FsaW5nYW0g
PHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJlaW5jLmNvbT4K
LS0tCiB3aW5zdXAvY3lnd2luL3NjcmlwdHMvZ2VuZGVmIHwgMzYgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdl
ZCwgMzYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3
aW4vc2NyaXB0cy9nZW5kZWYgYi93aW5zdXAvY3lnd2luL3NjcmlwdHMvZ2Vu
ZGVmCmluZGV4IDk3NmUwZjlmNi4uZmRiOTcwZjZmIDEwMDc1NQotLS0gYS93
aW5zdXAvY3lnd2luL3NjcmlwdHMvZ2VuZGVmCisrKyBiL3dpbnN1cC9jeWd3
aW4vc2NyaXB0cy9nZW5kZWYKQEAgLTQyMyw3ICs0MjMsNDMgQEAgX3NpZ2Zl
OgogICAgIGJyICAgICAgeDkJCQkJLy8gQnJhbmNoIHRvIHJlYWwgZnVuY3Rp
b24KICAgICAuc2VoX2VuZHByb2MKCisgICAgLmdsb2JhbCBfc2lnYmUKKyAg
ICAuc2VoX3Byb2MgX3NpZ2JlCiBfc2lnYmU6CisgICAgLnNlaF9lbmRwcm9s
b2d1ZQorICAgIGxkciAgICAgeDEwLCBbeDE4LCAjMHg4XQkJLy8gTG9hZCBU
TFMgYmFzZSBpbnRvIHgxMAorICAgIG1vdiAgICAgdzksICMxCQkJLy8gQ29u
c3RhbnQgdmFsdWUgMSBmb3IgbG9jayBhY3F1aXNpdGlvbgorMzogIGxkciAg
ICAgeDExLCA9X2N5Z3Rscy5zdGFja2xvY2sJLy8gTG9hZCBvZmZzZXQgb2Yg
c3RhY2tsb2NrCisgICAgYWRkICAgICB4MTIsIHgxMCwgeDExCQkvLyBDb21w
dXRlIGZpbmFsIGFkZHJlc3Mgb2Ygc3RhY2tsb2NrCisgICAgbGRheHIgICB3
MTMsIFt4MTJdCQkJLy8gTG9hZCBjdXJyZW50IHN0YWNrbG9jayB2YWx1ZSBh
dG9taWNhbGx5CisgICAgc3RseHIgICB3MTQsIHc5LCBbeDEyXQkJLy8gQXR0
ZW1wdCB0byBzZXQgc3RhY2tsb2NrIGF0b21pY2FsbHkKKyAgICBjYm56ICAg
IHcxNCwgM2IJCQkvLyBSZXRyeSBpZiBmYWlsZWQKKyAgICBjYnogICAgIHcx
MywgNGYJCQkvLyBJZiBsb2NrIHdhcyBmcmVlLCBjb250aW51ZQorICAgIHlp
ZWxkCisgICAgYiAgICAgICAzYgkJCQkvLyBSZXRyeSBhY3F1aXJpbmcgdGhl
IGxvY2sKKzQ6CisgICAgbW92ICAgICB4OSwgIy04CQkJLy8gU2V0IHN0YWNr
IHBvaW50ZXIgZGVjcmVtZW50IHZhbHVlCis1OiAgbGRyICAgICB4MTEsID1f
Y3lndGxzLnN0YWNrcHRyCS8vIExvYWQgb2Zmc2V0IG9mIHN0YWNrIHBvaW50
ZXIKKyAgICBhZGQgICAgIHgxMiwgeDEwLCB4MTEJCS8vIENvbXB1dGUgZmlu
YWwgYWRkcmVzcyBvZiBzdGFjayBwb2ludGVyCisgICAgbGRheHIgICB4MTMs
IFt4MTJdCQkJLy8gTG9hZCBjdXJyZW50IHN0YWNrIHBvaW50ZXIgYXRvbWlj
YWxseQorICAgIGFkZCAgICAgeDE0LCB4MTMsIHg5CQkvLyBDb21wdXRlIG5l
dyBzdGFjayBwb2ludGVyIHZhbHVlCisgICAgc3RseHIgICB3MTUsIHgxNCwg
W3gxMl0JCS8vIEF0dGVtcHQgdG8gdXBkYXRlIHN0YWNrIHBvaW50ZXIgYXRv
bWljYWxseQorICAgIGNibnogICAgdzE1LCA1YgkJCS8vIFJldHJ5IGlmIGF0
b21pYyB1cGRhdGUgZmFpbGVkCisgICAgc3ViICAgICB4MTMsIHgxMywgIzgg
ICAgICAgICAgICAgICAvLyBDb21wdXRlIGFkZHJlc3Mgd2hlcmUgTFIgd2Fz
IHNhdmVkCisgICAgbGRyICAgICB4MzAsIFt4MTNdICAgICAgICAgICAgICAg
ICAvLyBSZXN0b3JlIHNhdmVkIExSCisgICAgbGRyICAgICB4MTEsID1fY3ln
dGxzLmluY3lnCS8vIExvYWQgb2Zmc2V0IG9mIGluY3lnCisgICAgYWRkICAg
ICB4MTIsIHgxMCwgeDExCQkvLyBDb21wdXRlIGZpbmFsIGFkZHJlc3Mgb2Yg
aW5jeWcKKyAgICBsZHIgICAgIHc5LCBbeDEyXQkJCS8vIExvYWQgY3VycmVu
dCBpbmN5ZyB2YWx1ZQorICAgIHN1YiAgICAgdzksIHc5LCAjMQkJCS8vIERl
Y3JlbWVudCBpbmN5ZworICAgIHN0ciAgICAgdzksIFt4MTJdCQkJLy8gU3Rv
cmUgdXBkYXRlZCBpbmN5ZyB2YWx1ZQorICAgIGxkciAgICAgeDExLCA9X2N5
Z3Rscy5zdGFja2xvY2sJLy8gTG9hZCBvZmZzZXQgb2Ygc3RhY2tsb2NrCisg
ICAgYWRkICAgICB4MTIsIHgxMCwgeDExCQkvLyBDb21wdXRlIGZpbmFsIGFk
ZHJlc3Mgb2Ygc3RhY2tsb2NrCisgICAgbGRyICAgICB3OSwgW3gxMl0JCQkv
LyBMb2FkIGN1cnJlbnQgc3RhY2tsb2NrIHZhbHVlCisgICAgc3ViICAgICB3
OSwgdzksICMxCQkJLy8gRGVjcmVtZW50IHN0YWNrbG9jayAocmVsZWFzZSBs
b2NrKQorICAgIHN0bHIgICAgdzksIFt4MTJdCQkJLy8gU3RvcmUgc3RhY2ts
b2NrCisgICAgcmV0CQkJCS8vIFJldHVybiB0byBjYWxsZXIgdXNpbmcgcmVz
dG9yZWQgTFIKKyAgICAuc2VoX2VuZHByb2MKKwogCS5nbG9iYWwJc2lnZGVs
YXllZAogCS5zZWhfcHJvYyBzaWdkZWxheWVkCiBzaWdkZWxheWVkOgotLQoy
LjUyLjAud2luZG93cy4xCgo=

--_004_MA0P287MB308261C0D8BCD6FD5842A5039FA9AMA0P287MB3082INDP_--
