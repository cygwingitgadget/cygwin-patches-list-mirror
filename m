Return-Path: <SRS0=Wwyh=FQ=multicorewareinc.com=aswin.kalies@sourceware.org>
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazlp170110002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c409::2])
	by sourceware.org (Postfix) with ESMTPS id 23D424BA2E0B
	for <cygwin-patches@cygwin.com>; Wed, 22 Jul 2026 12:51:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 23D424BA2E0B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 23D424BA2E0B
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c409::2
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1784724695; cv=pass;
	b=MlSuhVJ04wo2CiuEgYdRIi9icHme+dm6VH/QRaafikfXJazsBL1laNqNs9LqcgZAxyY6Bb0RulBhs4Gh7VZkX36LgZbJHhz8gWnqTES5MeCIBH9bsHI63az8yluYeI3tSE3GgUt8gjB0krpd3XVcAAMnc+Xi7s+3uVN3//aDrJ8=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1784724695; c=relaxed/simple;
	bh=VwBar80Ixkbzw4uJXRnrEkgJ6LD4C00Vxy3iX7ys44Y=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=clybu+OJ0cajCDRA6pMa4SEgjmu85ettt1UFlWKNMqHXy/cJLTPbKFWE6LRyl3Hur3yDqQus8sbQrr5yIHto1zbUAqgNnmMStOiGTa3L2VXqG7R/tRi7PFb0wa11YxhewTtVOtR3XzKRyvCA6384b12ixKeLXa576QL4uxBuzHw=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=Sd+1u5qz
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 23D424BA2E0B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=Sd+1u5qz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wNKDNFjxTHDl6iF8bTRwdzck7KTrJFQLASeoioZgRLbmxedZ12u7VV0l0xJxqVBQkE5AD/iuUF8yrFYkk8ltpNHNujtssnVfahMhBSvPelSPG3X7iVFeGtGcbpUGVm4WekIP7Kowg9qW4dg2dxTg4DtuAaXRJVyXCL6V5acp+cQRNQldSJ3UhfUNnXZo25lvKx7FtTTXgLRGxuuERj5O5Ot8K6jA8LQsmY+v4WqVwr+0FR0wAvYrXJzQcPjk8f5gtQTXDqajXbXU/gG8RaBB2hijsjOtU37aQ5uT1k1E5tN0LVdc2E4Qa9lPizIpOktOB2AYbU8OI0rIR6SUphDmeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ms/c2Z23uouKWMiaSHBq9os824Z5haCJILFGrJnVdLI=;
 b=nimrfUu+jpdne2iCKoGJAWizzjWRRKnRAuLPE6vYmbsXfXGu8lN0OnCJmS3x/7Xm/YzW0Uyax19FrQWQsFOXkKjO5cV3S6a6fma/Fz95S1hgzeFLW9vqF9pcUXnwYVvI5XzkJtj7ww8PAPgAqbcb/GRMP7w4p8rvDf44rfnc5d5Tuw0hkVT3Tj8EqOmzqcH75I1Dd4Z81ZYEZQ3ckdw0/fSh3oTFrOV48457/uCCc7r/1VCrvNphfn1Qi3q1jb8tq8c57sgxHLI/xJo7LGdt4cbqv5rt5/EhYPpU+sIRHgh9Tg0uEIV411XgYwOvCfBEb203n1eiRTJeeIsZLkXAEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ms/c2Z23uouKWMiaSHBq9os824Z5haCJILFGrJnVdLI=;
 b=Sd+1u5qzt9zfD1Zyc0ntgIrxDiketnn2bhFI2NTo15DU2rgsGG8/XUQVS38/oQKMpq08ygtZK/L3B1wSdHN/WmNwgJVWqrreg7pml5YTO4G7yeJkFDckltXgaBvzic/wNV8V83rrwuI5Kx4lqogSWuzp3ro4RZMw9FdJGZsjvO8NSaKI1QJPapeEH1njkIZvMeSzaeFszH8//7tivAZz12vRXVWW0kstG7CEhf5Fbv/vcbRqwZFA2jfSzesL+NPLrt/P5kgy883C8qzn+QkfPts1YJygFtO4oyLQDBEN+ZVEZ2un8oo3wpl5DLecZXsnL2J6QZEGq2b3oUpCJaFfSw==
Received: from PN3P287MB1320.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:193::14)
 by PN2P287MB2061.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1c6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 12:51:27 +0000
Received: from PN3P287MB1320.INDP287.PROD.OUTLOOK.COM
 ([fe80::8f7c:54ae:2172:b97b]) by PN3P287MB1320.INDP287.PROD.OUTLOOK.COM
 ([fe80::8f7c:54ae:2172:b97b%4]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 12:51:27 +0000
From: Aswin Kalies Ramkumar Mangayarkarasi <aswin.kalies@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: "jon.turney@dronecode.org.uk" <jon.turney@dronecode.org.uk>
Subject: [PATCH v3] Cygwin: Add AArch64 support for signal handling and
 ucontext
Thread-Topic: [PATCH v3] Cygwin: Add AArch64 support for signal handling and
 ucontext
Thread-Index: AQHdGdeoP3pUUoxnHkyMiLqRAGaGsg==
Date: Wed, 22 Jul 2026 12:51:27 +0000
Message-ID:
 <PN3P287MB132037F714481EAD3C475C65F7C12@PN3P287MB1320.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-GB, en-US
Content-Language: en-IN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB1320:EE_|PN2P287MB2061:EE_
x-ms-office365-filtering-correlation-id: b5848f74-4e25-4ee3-0374-08dee7eff1a2
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|39142699007|31052699007|6049299003|18002099003|55112099003|3023799007|8096899003|4053099003|13003099007|38070700021|10067099003|56012099006|5023799004|6133799003;
x-microsoft-antispam-message-info:
 eHNc7UYZVXgKV4IVir7jidxTDz7XBnyaM/eM8dT5HI3O67nRQh7OQSTpbz0z3+zT11KAlMYOChJGLr/badVWAm9YuMzuxeamzkLS7jVS0kp/5AjSr/TuuNYoaisg2zXhRvz6maFiL3lnk0VriExJVnwN3xEQ9pkK08x6FtDmtmR1F+KVIQBCybigiNIOg1UXZ+d3oVgOpVfjGG0FO5mmu5Y/BtWcA6ysVOjVfeyXwOIAQAwFYFMWK3JViCfST9oE28T8nTXKJWJdXV2F6L7RlTeG6/gzAbJu2rA2+1bUqeDlzSxHHt7Duwx04qQMuPsmKqXpe/NT05sa8hIRg8ydsojxL8180+jJYQ8Z1buikyATA3q2Sy2n/lyRwKcxr1iHdCuKGF5fTmAA4Cnwrel4cOK1MNHINwWeA/MpraP4jYudbcte+GvNdaqMZcPSlZ4STfJeH+JU9ZecrWk2yzpADRDUvvtK73axLZ8KzKJoj+jxrLAIQbRT1ruvljH0nDMNc80MSG/Bb2LoMXBR5uDSmoeQi0JTBI0TtVspHm4LJlplHTfoJ0mktjkoRT7uRLPI21LfAASEg39ilEmOYZHJJklswqQhXVGh2rszGcVOILbLmTlFArR774m8+bNxwgGCxtCY9uKv4VZpdHSaJjmq6+0U88h4yUKYDY+aOwvgsz4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1320.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(39142699007)(31052699007)(6049299003)(18002099003)(55112099003)(3023799007)(8096899003)(4053099003)(13003099007)(38070700021)(10067099003)(56012099006)(5023799004)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?rjo74QFJfGkuXUnDWLqI8rVZ/PMtInDtNz0gov2VL40Pb44NU9SGpvzx?=
 =?Windows-1252?Q?s0e+gkNurVhPCWUYw0Z1CWPirKV+qSSs6kazZ3MVKjCv4Bg0DvKFCgg2?=
 =?Windows-1252?Q?baL9xCLPJUdtmG1T5CxxipUzwzUd78Io7olWAITMLm8ClK/D11KVhpHA?=
 =?Windows-1252?Q?2JE0hxd8Hz44raWUfTvvUA/4/n9kkIsumoKCuSH3pSv3PHEeuUhme02Q?=
 =?Windows-1252?Q?U0R5Py7+KjAMqe/W6ZfKNn82XjiSvJ+qCGO1JHUfAhYzsF/Cd8cDeV8g?=
 =?Windows-1252?Q?Yptpwo8DnVp+y4XaeqqBnjhSXCwQeefrn48HZhH1uH6kuszEASBbUZ0A?=
 =?Windows-1252?Q?pDLX6TotS2MeqNuZ5Iddy6Bqk1cqnOXn2kTrjJV8SiuRqg9eDqWil4tS?=
 =?Windows-1252?Q?OOn4zyAAwVNOL/uqndzfzSZh9M/IddysOT8ps7KDGvk11XEc97/TPKwT?=
 =?Windows-1252?Q?us0vas9+hjjVWhvj6M4IrkcasxhQbQGdfXFB9f7tzYW4fOVodJHlCkXg?=
 =?Windows-1252?Q?H944BJnCwiP7yGW5PyupI3M4DZ7aHY8Nu7p9RmRi+IFoo33u8yvaoKdS?=
 =?Windows-1252?Q?VGupMWc32OJgQKAUqwzs8Ri3FSC0p7YE8uSqELnnk+XnWsRFZWriYVsC?=
 =?Windows-1252?Q?spNPmjRzca/mjWpE9wuIYqeQuU7x1k0DMLNs/zM9oJ4dGuuc3Dl81CB8?=
 =?Windows-1252?Q?4a5pHhxo49wBqqRJTK8x4C9wMF7OnBXbuGtnfBqOY73cK9agbGKVepAf?=
 =?Windows-1252?Q?Zd3xQCEbj6z8BhHee76TfSAed2yCQWjPT3JSToJB9urybvuIP/Ac+egV?=
 =?Windows-1252?Q?0GGkRPrVMS1D3kzo6ijmYXxTatdbuEFkEFwxWhIRRBXvwJJeYKy+raWQ?=
 =?Windows-1252?Q?+URpUiZHyLkHbR+r21lxylUZh6xU81KMi9JJu2YoOr+TXnPB0C5HdyE6?=
 =?Windows-1252?Q?RvG5YBrMDUyLSjVa1kqOqdymkoArrAO0AawD1la5NfxWnNrBD/9PKSJT?=
 =?Windows-1252?Q?CTeTeUtchlYKDOlibIsIfNod9PF4K9jMeyntmV8vgwzsADx8aB48zm7Q?=
 =?Windows-1252?Q?A6ZyFeqgKjtW+DKWPRTvS2qh4k+V8gszCEl6XVlKxRhz9UxJmVcIv7+2?=
 =?Windows-1252?Q?aNs3NK7J+3No+6b32ux9fxQ0AvjmNdauHIUJlYoWH/uZoDsQQz0quuI2?=
 =?Windows-1252?Q?cqsUgQleJ/IWQOkx/SbUvusthL7u6T1NiIr8Pgqbs070C7jN5v6oD8Gf?=
 =?Windows-1252?Q?Cuk8oPoYCBMZCevVU6xyq4IQuIDy9fNBQ7I5I+CEyPQPtk3yQCCX9396?=
 =?Windows-1252?Q?1RDs8BwswKJDv2kXZ1YlvgMtqd6lIzEH5S6fsV6NI4asJHNBuhuF+hwe?=
 =?Windows-1252?Q?5hNpjJ+DjO3UPAM3IZtPbBO44SevAEwTT6rcntdPBrDId6LpiBqwFSbZ?=
 =?Windows-1252?Q?ajeqBfF0/YKbUBDg3UXxDihp2JlBTCBEG3E8SrtZKtnu7KSuCnRbT/yH?=
 =?Windows-1252?Q?Uj3Ru4X/b+tPyFjyiZu1TnKNUGGuSm6dCs5mVnzOEvHEZ3IcMXurCcW6?=
 =?Windows-1252?Q?vARVaHkgLDhENt2nso5VvCXOLcEr3XAQlPG65zCjwV4L8isq32LZfWKi?=
 =?Windows-1252?Q?rLiAwQ8HMFsdE3t8kcZC8dWgQIkeN5vpBBPvcd/hK5AcLM39zu4IGaIE?=
 =?Windows-1252?Q?e4AuvWU7ndlhZE07w4j/GNW+1rdBFcbRM72G0vA0loEHoVWK85SVQ5aV?=
 =?Windows-1252?Q?0vBiU5NUEczeS2Z43Na3D61AVOzIW7Z/RyVebFR+bN41HVCC0eZ88GCl?=
 =?Windows-1252?Q?nsEd5l9+i90EO8iM8/iYaEdXbtzbhV8AFup9WLiZCmpGmGavW0tWizYF?=
 =?Windows-1252?Q?qZZhCWAKwDt8JeF7HirYd4NIMjOilfT2RM0=3D?=
Content-Type: multipart/mixed;
	boundary="_004_PN3P287MB132037F714481EAD3C475C65F7C12PN3P287MB1320INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1320.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b5848f74-4e25-4ee3-0374-08dee7eff1a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2026 12:51:27.0215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TTqPzie9NgZuDztiojJ8vYUi+ChwV1t3Ba+ni+4WKCkjwqOqed9iDFwR+h1WNkGEeMQWQqrRNCpZ1ffY6Hz3CP5SBz8dyPEhN1W5z6UkIyNbHFBj9rzI/212bUdAybfF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB2061
X-Spam-Status: No, score=-13.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,SCC_10_SHORT_WORD_LINES,SCC_5_SHORT_WORD_LINES,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_PN3P287MB132037F714481EAD3C475C65F7C12PN3P287MB1320INDP_
Content-Type: multipart/alternative;
	boundary="_000_PN3P287MB132037F714481EAD3C475C65F7C12PN3P287MB1320INDP_"

--_000_PN3P287MB132037F714481EAD3C475C65F7C12PN3P287MB1320INDP_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi Jon,
Thanks for the review.
This is a follow-up patch to: https://cygwin.com/pipermail/cygwin-patches/2=
026q3/015206.html
Responses inline below; v3 addresses all of the review points.
For testing, we built a standalone ucontext/altstack test suite and ran it =
against a freshly built cygwin1.dll on Windows ARM64. The tests cover getco=
ntext/setcontext/swapcontext/makecontext round-trips, odd argument counts (=
9=9613), NULL uc_link exit behaviour, a 5000-iteration swapcontext loop, an=
d an SA_ONSTACK signal handler.
We also ran a four-way isolation matrix where each branch reverted exactly =
one of the three fixes to verify that each change is independently required=
. Reverting the setcontext hand-restore causes every makecontext/swapcontex=
t test to crash with STATUS_STACK_BUFFER_OVERRUN, matching the pre-port bas=
eline. Reverting the trampoline (including the sp,x19 fix and mov w0,#0xff)=
 causes the odd-argc tests to fail with STATUS_DATATYPE_MISALIGNMENT, and t=
he NULL uc_link test exits with 0 instead of 0xff.
I agree there's nothing in the upstream testsuite covering this yet. I'm ha=
ppy to contribute these tests as a follow-up if that would be useful.
Regarding the clobber list in call_signal_handler, the previous comment was=
 misleading. The clobber list is serving two distinct purposes, and I've re=
written the comment to explain that. x0-x7, x9, x10, and x29 are explicitly=
 used by the assembly as scratch/argument registers and are listed as clobb=
ers to prevent GCC from allocating "r" input operands into registers that t=
he assembly overwrites before reading. The x86_64 version doesn't need this=
 because its inputs are "o" memory operands. x8, x11-x17, x30 (clobbered by=
 blr), and v0-v7/v16-v31 are the normal caller-saved registers clobbered by=
 the C call to altstack_wrapper. x18 (TEB) and v8-v15 (callee-saved on Wind=
ows) are preserved and therefore omitted.
 So the registers you pointed out aren't redundant with the explicit save/r=
estore sequence. Removing them would allow GCC to place an input operand in=
to a register that the assembly overwrites before reading it. That said, I'=
m also happy to convert this path to "o" memory operands like the x86_64 im=
plementation if you think that's the cleaner approach. I kept "r" operands =
simply to minimise churn in the already-tested assembly.
 For RtlRestoreContext, unfortunately I haven't found any Microsoft documen=
tation describing this behaviour. The STATUS_ILLEGAL_INSTRUCTION failure on=
 a synthetic context was discovered empirically. I also tried setting Conte=
xtFlags =3D CONTEXT_FULL on the makecontext-generated context in case RtlRe=
storeContext required a particular flag mask, but it made no difference. Th=
e hand-restore is genuinely required. I've added a comment noting this.
 For the 272 constant, I've added a comment explaining that it's the byte o=
ffset of the V-register array within struct __mcontext, whose layout mirror=
s the Windows ARM64 CONTEXT structure. The comment now also documents all o=
ffsets used by the routine.
 Regarding x17 and CPSR not being restored in setcontext, this is the same =
asymmetry as in the earlier incyg fix, but you're right that it should be d=
ocumented explicitly rather than left implicit. The omission is intentional=
. x16 (IP0) and x17 (IP1) are the ABI-defined intra-procedure-call scratch =
registers. This implementation uses x16 as the base register and x17 as the=
 branch target, and the ABI already permits linker-inserted veneers to clob=
ber both registers, so a ucontext consumer cannot rely on either surviving =
a setcontext() regardless. Their saved values are therefore intentionally n=
ot restored. CPSR is likewise not restored because there is no EL0 instruct=
ion that restores the entire register, and the only architecturally visible=
 state that user code could reasonably care about (NZCV) is caller-clobbere=
d across the makecontext()/swapcontext() boundary that this code serves. gl=
ibc and musl take the same approach on AArch64. I've added comments explain=
ing this.
 Finally, I've fixed both the "return address on the stack" comment and the=
 missing makecontext #error cases. The header comment now states that the c=
ontinuation trampoline is reached via a stack return slot on x86_64 but via=
 lr on AArch64. I also added the missing #else / #error unimplemented for t=
his target to each of the four #if defined(x86_64) / #elif defined(aarch64)=
 blocks in makecontext.
Inline patch
---
 winsup/cygwin/exceptions.cc | 345 +++++++++++++++++++++++++++++++-----
 1 file changed, 304 insertions(+), 41 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 1e129b319..4224cdfcf 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -1892,7 +1892,7 @@ _cygtls::call_signal_handler ()

     /* In assembler: Save regs on new stack, move to alternate stack,
        call thisfunc, revert stack regs. */
-#ifdef __x86_64__
+#if defined(__x86_64__)
     /* Clobbered regs: rcx, rdx, r8, r9, r10, r11, rbp, rsp */
     __asm__ ("\n\
         movq  %[NEW_SP], %%rax  # Load alt stack into rax  \n\
@@ -1930,6 +1930,66 @@ _cygtls::call_signal_handler ()
             [FUNC]  "o" (thisfunc),
             [WRAPPER] "o" (altstack_wrapper)
         : "memory");
+#elif defined(__aarch64__)
+    __asm__ ("\n\
+        mov   x9, %[NEW_SP]     // Load alt stack into x9  \n\
+        sub   x9, x9, #0x60     // Make room on alt stack  \n\
+                 // for clobbered regs      \n\
+        str   x0, [x9, #0x00]      // Save clobbered regs     \n\
+        str   x1, [x9, #0x08]                  \n\
+        str   x2, [x9, #0x10]                  \n\
+        str   x3, [x9, #0x18]                  \n\
+        str   x4, [x9, #0x20]                  \n\
+        str   x5, [x9, #0x28]                  \n\
+        str   x6, [x9, #0x30]                  \n\
+        str   x7, [x9, #0x38]                  \n\
+        str   fp, [x9, #0x40]                  \n\
+        mov   x10, sp        // Copy sp into x10 for saving   \n\
+        str   x10, [x9, #0x48]              \n\
+        str   x30, [x9, #0x50]  // Save link register      \n\
+        mov   x0, %[SIG]     // thissig to 1st arg reg  \n\
+        mov   x1, %[SI]      // &thissi to 2nd arg reg  \n\
+        mov   x2, %[CTX]     // thiscontext to 3rd arg reg \n\
+        mov   x3, %[FUNC]    // thisfunc to x3    \n\
+        mov   x4, %[WRAPPER]    // wrapper address to x4   \n\
+        mov   sp, x9         // Move alt stack into sp  \n\
+        blr   x4       // Call wrapper         \n\
+        mov   x9, sp         // Restore clobbered regs  \n\
+        ldr   x30, [x9, #0x50]  // Restore link register   \n\
+        ldr   x10, [x9, #0x48]              \n\
+        ldr   fp,  [x9, #0x40]              \n\
+        ldr   x7,  [x9, #0x38]              \n\
+        ldr   x6,  [x9, #0x30]              \n\
+        ldr   x5,  [x9, #0x28]              \n\
+        ldr   x4,  [x9, #0x20]              \n\
+        ldr   x3,  [x9, #0x18]              \n\
+        ldr   x2,  [x9, #0x10]              \n\
+        ldr   x1,  [x9, #0x08]              \n\
+        ldr   x0,  [x9, #0x00]              \n\
+        mov   sp,  x10    // Restore stack pointer   \n"
+        : : [NEW_SP]    "r" (new_sp),
+            [SIG]    "r" (thissig),
+            [SI]  "r" (&thissi),
+            [CTX]    "r" (thiscontext),
+            [FUNC]   "r" (thisfunc),
+            [WRAPPER] "r" (altstack_wrapper)
+        /* The clobber list serves two roles here.  x0-x7, x9, x10
+           and x29 are hardcoded by this asm as scratch/argument
+           registers, so they are listed to stop gcc allocating the
+           "r" inputs into them.  (The x86_64 path above needs no
+           such guard because its inputs are "o" memory operands.)
+           The remaining registers - x8, x11-x17, x30 (trampled by
+           the blr) and v0-v7/v16-v31 - are caller-saved and clobbered
+           by the ordinary C call to altstack_wrapper.  x18 (the
+           Windows TEB pointer) and v8-v15 (callee-saved on Windows)
+           survive the call and are omitted.  */
+        : "memory", "cc",
+          "x0", "x1", "x2", "x3", "x4", "x5", "x6", "x7",
+          "x8", "x9", "x10", "x11", "x12", "x13", "x14", "x15",
+          "x16", "x17", "x29", "x30",
+          "v0", "v1", "v2", "v3", "v4", "v5", "v6", "v7",
+          "v16", "v17", "v18", "v19", "v20", "v21", "v22", "v23",
+          "v24", "v25", "v26", "v27", "v28", "v29", "v30", "v31");
 #else
 #error unimplemented for this target
 #endif
@@ -2009,10 +2069,89 @@ setcontext (const ucontext_t *ucp)
 {
   PCONTEXT ctx =3D (PCONTEXT) &ucp->uc_mcontext;
   set_signal_mask (_my_tls.sigmask, ucp->uc_sigmask);
+#if defined(__aarch64__)
+  /* On ARM64, RtlRestoreContext raises STATUS_ILLEGAL_INSTRUCTION when as=
ked
+     to restore a synthetic context built by makecontext rather than one
+     captured by RtlCaptureContext/GetThreadContext: it rejects an arbitra=
ry
+     PC and a stack outside the thread's registered range.  Restore the
+     registers by hand and branch to the saved PC instead, as glibc/musl do
+     for aarch64.
+
+     The numeric offsets below are byte offsets into struct __mcontext, wh=
ose
+     layout mirrors the Windows ARM64 CONTEXT: x0/x1 @8, x2-x15 @24-120,
+     x18-x28/fp @152-232, lr @248, sp @256, pc @264, v[0..31] @272 (16 byt=
es
+     each), fpcr @784, fpsr @788.
+
+     x16 (IP0) and x17 (IP1) are the ABI intra-procedure-call scratch
+     registers: their values in the context are deliberately not restored.
+     We reuse x16 as the base pointer and x17 as the branch target, and the
+     ABI permits the linker to clobber x16/x17 in any call/branch veneer, =
so a
+     ucontext consumer may not rely on them surviving a setcontext.  CPSR =
is
+     likewise not restored: it cannot be written from EL0 with a plain msr,
+     the only flags of interest (NZCV) are caller-clobbered across the
+     makecontext/swapcontext boundary this path serves, and glibc/musl take
+     the same approach for aarch64.  */
+  register PCONTEXT base __asm__ ("x16") =3D ctx;
+  __asm__ __volatile__ ("\n\
+  add   x17, x16, #272             \n\
+  ldp   q0, q1, [x17, #0]          \n\
+  ldp   q2, q3, [x17, #32]            \n\
+  ldp   q4, q5, [x17, #64]            \n\
+  ldp   q6, q7, [x17, #96]            \n\
+  ldp   q8, q9, [x17, #128]           \n\
+  ldp   q10, q11, [x17, #160]            \n\
+  ldp   q12, q13, [x17, #192]            \n\
+  ldp   q14, q15, [x17, #224]            \n\
+  ldp   q16, q17, [x17, #256]            \n\
+  ldp   q18, q19, [x17, #288]            \n\
+  ldp   q20, q21, [x17, #320]            \n\
+  ldp   q22, q23, [x17, #352]            \n\
+  ldp   q24, q25, [x17, #384]            \n\
+  ldp   q26, q27, [x17, #416]            \n\
+  ldp   q28, q29, [x17, #448]            \n\
+  ldp   q30, q31, [x17, #480]            \n\
+  /* Restore FPCR and FPSR */            \n\
+  ldr   w17, [x16, #784]           \n\
+  msr   fpcr, x17               \n\
+  ldr   w17, [x16, #788]           \n\
+  msr   fpsr, x17               \n\
+  /* Load PC into x17 (branch target, offset 264) */ \n\
+  ldr   x17, [x16, #264]           \n\
+  /* Restore callee-saved GPRs x18..x28, fp, lr */   \n\
+  ldp   x18, x19, [x16, #152]            \n\
+  ldp   x20, x21, [x16, #168]            \n\
+  ldp   x22, x23, [x16, #184]            \n\
+  ldp   x24, x25, [x16, #200]            \n\
+  ldp   x26, x27, [x16, #216]            \n\
+  ldp   x28, x29, [x16, #232]            \n\
+  ldr   x30, [x16, #248]           \n\
+  /* Restore caller-saved GPRs x2..x15 */         \n\
+  ldp   x2, x3, [x16, #24]            \n\
+  ldp   x4, x5, [x16, #40]            \n\
+  ldp   x6, x7, [x16, #56]            \n\
+  ldp   x8, x9, [x16, #72]            \n\
+  ldp   x10, x11, [x16, #88]          \n\
+  ldp   x12, x13, [x16, #104]            \n\
+  ldp   x14, x15, [x16, #120]            \n\
+  /* Restore x0, x1 */             \n\
+  ldp   x0, x1, [x16, #8]          \n\
+  /* Set SP from context (last use of x16 as base) */   \n\
+  ldr   x16, [x16, #256]           \n\
+  mov   sp, x16                 \n\
+  /* Branch to saved PC */            \n\
+  br x17                  \n\
+"
+  : /* no outputs (noreturn) */
+  : "r" (base)
+  : "memory"
+  );
+  __builtin_unreachable ();
+#else
   RtlRestoreContext (ctx, NULL);
   /* If we got here, something was wrong. */
   set_errno (EINVAL);
   return -1;
+#endif
 }

 extern "C" int
@@ -2049,7 +2188,7 @@ swapcontext (ucontext_t *oucp, const ucontext_t *ucp)
 /* Trampoline function to set the context to uc_link.  The pointer to the
    address of uc_link is stored in a callee-saved register, referenced by
    _MC_uclinkReg from the C code.  If uc_link is NULL, call exit. */
-#ifdef __x86_64__
+#if defined(__x86_64__)
 /* _MC_uclinkReg =3D=3D %rbx */
 __asm__ ("          \n\
   .global  __cont_link_context  \n\
@@ -2070,19 +2209,50 @@ __cont_link_context:       \n\
   nop            \n\
   .seh_endproc         \n\
   ");
-
+#elif defined(__aarch64__)
+/*   _MC_uclinkReg =3D=3D x19.  x19 holds the address of the uc_link slot =
but is
+  only 8-byte aligned, so read through it and mask into SP in one step
+  rather than moving the unaligned value into SP first.  setcontext and
+  cygwin_exit are noreturn, so tail-call them with 'b': this leaves x30
+  untouched and keeps the frame leaf, matching the empty SEH prologue. */
+__asm__ ("             \n\
+  .global  __cont_link_context     \n\
+  .seh_proc __cont_link_context    \n\
+__cont_link_context:            \n\
+  .seh_endprologue        \n\
+  ldr   x0, [x19]         \n\
+  and   sp, x19, #~0xf       \n\
+  cbnz  x0, 1f            \n\
+  mov   w0, #0xff         \n\
+  b  cygwin_exit       \n\
+1:                  \n\
+  b  setcontext        \n\
+  .seh_endproc            \n"
+  );
 #else
 #error unimplemented for this target
 #endif

 /* makecontext is modelled after GLibc's makecontext.  The stack from uc_s=
tack
    is prepared so that it starts with a pointer to the linked context uc_l=
ink,
-   followed by the arguments to func, and finally at the bottom the "retur=
n"
-   address set to __cont_link_context.  In the ucp context, rbx/ebx is set=
 to
-   point to the stack address where the pointer to uc_link is stored.  The
-   requirement to make this work is that rbx/ebx are callee-saved registers
-   per the ABI.  If any function is called which doesn't follow the ABI
-   conventions, e.g. assembler code, this method will break.  But that's o=
k. */
+   followed by the arguments to func.
+
+   The trampoline __cont_link_context is reached differently per target: on
+   x86_64 its address is written at the bottom of the stack as the "return"
+   address, whereas on aarch64 it is placed in lr (see below), since the
+   AArch64 ABI returns through the link register rather than the stack.
+
+   x86_64: In the ucp context, rbx is set to point to the stack address wh=
ere
+   the pointer to uc_link is stored.  The requirement to make this work is=
 that
+   rbx is a callee-saved register per the ABI.
+
+   ARM64: In the ucp context, x19 is set to point to the stack address whe=
re
+   the pointer to uc_link is stored.  The requirement is that x19 is a
+   callee-saved register per the ARM64 ABI.
+
+   If any function is called which doesn't follow the ABI conventions, e.g.
+   assembler code, this method will break.  But that's ok. */
+
 extern "C" void
 makecontext (ucontext_t *ucp, void (*func) (void), int argc, ...)
 {
@@ -2090,65 +2260,158 @@ makecontext (ucontext_t *ucp, void (*func) (void),=
 int argc, ...)
   uintptr_t *sp;
   va_list ap;

+#if defined(__x86_64__)
+  /* x86_64: Arguments beyond the first 4 go on the stack.
+     However, we allocate shadow space for all args including register arg=
s. */
+  int stack_args =3D argc;
+
+#elif defined(__aarch64__)
+  /* ARM64: Arguments beyond the first 8 go on the stack.
+     We only allocate stack space for args beyond registers. */
+  int stack_args =3D (argc > 8) ? (argc - 8) : 0;
+
+#else
+#error unimplemented for this target
+#endif
+
   /* Initialize sp to the top of the stack. */
   sp =3D (uintptr_t *) ((uintptr_t) ucp->uc_stack.ss_sp + ucp->uc_stack.ss=
_size);
-  /* Subtract slots required for arguments and the pointer to uc_link. */
-  sp -=3D (argc + 1);
-  /* Align. */
-  sp =3D (uintptr_t *) ((uintptr_t) sp & ~0xf);
-  /* Subtract one slot for setting the return address. */
+
+#if defined(__x86_64__)
+  /* x86_64: Subtract slots for all arguments + uc_link pointer
+     and return address.  */
+  sp -=3D (stack_args + 1);  /* argc + 1 for uc_link */
+  /* Align to 16 bytes. */
+  sp =3D (uintptr_t *) ((uintptr_t) sp & ~0xfUL);
+  /* Subtract one more slot for the return address. */
   --sp;
-  /* Set return address to the trampolin function __cont_link_context. */
+  /* Set return address to the trampoline function __cont_link_context. */
   sp[0] =3D (uintptr_t) __cont_link_context;
-  /* Fetch arguments and store them on the stack.

-     x86_64:
+#elif defined(__aarch64__)
+  /* ARM64: Subtract slots for stack arguments + uc_link pointer. */
+  sp -=3D (stack_args + 1);  /* stack_args + 1 for uc_link */
+  /* ARM64 requires 16-byte alignment at public interfaces. */
+  sp =3D (uintptr_t *) ((uintptr_t) sp & ~0xfUL);

-     - Store first four args in the AMD64 ABI arg registers.
+#else
+#error unimplemented for this target
+#endif

+  /* Fetch arguments and store them.
+     x86_64:
+     - Store first four args in the AMD64 ABI arg registers (rcx, rdx, r8,=
 r9).
      - Note that the stack is not short by these four register args.  The
        reason is the shadow space for these regs required by the AMD64 ABI.
-
      - The definition of makecontext only allows for "int" sized arguments=
 to
        func, 32 bit, likely for historical reasons.  However, the argument
        slots on x86_64 are 64 bit anyway, so we can fetch and store the ar=
gs
        as 64 bit values, and func can request 64 bit args without violating
        the definition.  This potentially allows porting 32 bit applications
-       providing pointer values to func without additional porting effort.=
 */
+       providing pointer values to func without additional porting effort.
+
+     ARM64:
+     - Store first eight args in ARM64 ABI arg registers (x0-x7).
+     - Arguments beyond 8 go on the stack.
+     - Similar to x86_64, we store as uintptr_t for pointer compatibility.=
 */
+
   va_start (ap, argc);
   for (int i =3D 0; i < argc; ++i)
-#ifdef __x86_64__
-    switch (i)
-      {
-      case 0:
-  ucp->uc_mcontext.rcx =3D va_arg (ap, uintptr_t);
-  break;
-      case 1:
-  ucp->uc_mcontext.rdx =3D va_arg (ap, uintptr_t);
-  break;
-      case 2:
-  ucp->uc_mcontext.r8 =3D va_arg (ap, uintptr_t);
-  break;
-      case 3:
-  ucp->uc_mcontext.r9 =3D va_arg (ap, uintptr_t);
-  break;
-      default:
-  sp[i + 1] =3D va_arg (ap, uintptr_t);
-  break;
-      }
+    {
+#if defined(__x86_64__)
+      switch (i)
+        {
+        case 0:
+          ucp->uc_mcontext.rcx =3D va_arg (ap, uintptr_t);
+          break;
+        case 1:
+          ucp->uc_mcontext.rdx =3D va_arg (ap, uintptr_t);
+          break;
+        case 2:
+          ucp->uc_mcontext.r8 =3D va_arg (ap, uintptr_t);
+          break;
+        case 3:
+          ucp->uc_mcontext.r9 =3D va_arg (ap, uintptr_t);
+          break;
+        default:
+          /* Stack arguments start at sp[i + 1] because sp[0] is return ad=
dress */
+          sp[i + 1] =3D va_arg (ap, uintptr_t);
+          break;
+        }
+
+#elif defined(__aarch64__)
+      switch (i)
+        {
+        case 0:
+          ucp->uc_mcontext.x0 =3D va_arg (ap, uintptr_t);
+          break;
+        case 1:
+          ucp->uc_mcontext.x1 =3D va_arg (ap, uintptr_t);
+          break;
+        case 2:
+          ucp->uc_mcontext.x2 =3D va_arg (ap, uintptr_t);
+          break;
+        case 3:
+          ucp->uc_mcontext.x3 =3D va_arg (ap, uintptr_t);
+          break;
+        case 4:
+          ucp->uc_mcontext.x4 =3D va_arg (ap, uintptr_t);
+          break;
+        case 5:
+          ucp->uc_mcontext.x5 =3D va_arg (ap, uintptr_t);
+          break;
+        case 6:
+          ucp->uc_mcontext.x6 =3D va_arg (ap, uintptr_t);
+          break;
+        case 7:
+          ucp->uc_mcontext.x7 =3D va_arg (ap, uintptr_t);
+          break;
+        default:
+          /* Stack arguments beyond the first 8 registers. */
+          sp[i - 8] =3D va_arg (ap, uintptr_t);
+          break;
+        }
 #else
 #error unimplemented for this target
 #endif
+    }
   va_end (ap);
-  /* Store pointer to uc_link at the top of the stack. */
+
+#if defined(__x86_64__)
+  /* Store pointer to uc_link at sp[argc + 1], after return address
+     and args.  */
   sp[argc + 1] =3D (uintptr_t) ucp->uc_link;
+
+#elif defined(__aarch64__)
+  /* Store pointer to uc_link at the top of our allocated area. */
+  sp[stack_args] =3D (uintptr_t) ucp->uc_link;
+
+#else
+#error unimplemented for this target
+#endif
+
   /* Last but not least set the register in the context at ucp so that a
      subsequent setcontext or swapcontext picks up the right values:
      - Set instruction pointer to the target function.
      - Set stack pointer to the just computed stack pointer value.
      - Set Cygwin-specific uclink register to the address of the pointer
-       to uc_link. */
+       to uc_link.
+
+     x86_64: uclink register is rbx (callee-saved)
+     ARM64:  uclink register is x19 (callee-saved) */
+
   ucp->uc_mcontext._MC_instPtr =3D (uint64_t) func;
   ucp->uc_mcontext._MC_stackPtr =3D (uint64_t) sp;
+
+#if defined(__x86_64__)
   ucp->uc_mcontext._MC_uclinkReg =3D (uint64_t) (sp + argc + 1);
+
+#elif defined(__aarch64__)
+  /* Set LR to __cont_link_context for ARM64 (used as return address). */
+  ucp->uc_mcontext.lr =3D (uint64_t) __cont_link_context;
+  ucp->uc_mcontext._MC_uclinkReg =3D (uint64_t) (sp + stack_args);
+
+#else
+#error unimplemented for this target
+#endif
 }
--
2.50.1.windows.1






--_000_PN3P287MB132037F714481EAD3C475C65F7C12PN3P287MB1320INDP_--

--_004_PN3P287MB132037F714481EAD3C475C65F7C12PN3P287MB1320INDP_
Content-Type: application/octet-stream;
	name="Cygwin-Add-AArch64-support-for-signal-handling-and-u.patch"
Content-Description:
 Cygwin-Add-AArch64-support-for-signal-handling-and-u.patch
Content-Disposition: attachment;
	filename="Cygwin-Add-AArch64-support-for-signal-handling-and-u.patch";
	size=17091; creation-date="Wed, 22 Jul 2026 12:50:33 GMT";
	modification-date="Wed, 22 Jul 2026 12:51:26 GMT"
Content-Transfer-Encoding: base64

RnJvbSBmNWIwM2ZlNWE3ZGM4MWM2MGNlZDYxYjUxZDVkYmI0ODkyNTgxODk5
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBBc3dpbiBLYWxpZXMg
UmFta3VtYXIgTWFuZ2F5YXJrYXJhc2kgPGFzd2luLmthbGllc0BtdWx0aWNv
cmV3YXJlaW5jLmNvbT4KRGF0ZTogV2VkLCAyMiBKdWwgMjAyNiAxNzo1NTo0
NCArMDUzMApTdWJqZWN0OiBbUEFUQ0ggdjNdIEN5Z3dpbjogQWRkIEFBcmNo
NjQgc3VwcG9ydCBmb3Igc2lnbmFsIGhhbmRsaW5nIGFuZAogdWNvbnRleHQK
CkFkZCB0aGUgQUFyY2g2NCBpbXBsZW1lbnRhdGlvbnMgdGhhdCB3ZXJlIHBy
ZXZpb3VzbHkgI2Vycm9yIHN0dWJzOgogIC0gdGhlIGFsdGVybmF0ZS1zaWdu
YWwtc3RhY2sgKFNBX09OU1RBQ0spIGFzbSBpbiBjYWxsX3NpZ25hbF9oYW5k
bGVyLAogIC0gdGhlIF9fY29udF9saW5rX2NvbnRleHQgdHJhbXBvbGluZSwg
YW5kCiAgLSBzZXRjb250ZXh0L21ha2Vjb250ZXh0IGZvciBhYXJjaDY0LgpT
aWduYWwgZGVsaXZlcnkgaXRzZWxmIGFscmVhZHkgd29ya2VkOyB0aGlzIGZp
bGxzIGluIHRoZSBTQV9PTlNUQUNLIGFuZAp1Y29udGV4dCBwYXRocy4KClNp
Z25lZC1vZmYtYnk6IENoYW5kcnUgS3VtYXJlc2FuIDxjaGFuZHJ1Lmt1bWFy
ZXNhbkBtdWx0aWNvcmV3YXJlaW5jLmNvbT4KU2lnbmVkLW9mZi1ieTogQXN3
aW4gS2FsaWVzIDxhc3dpbi5rYWxpZXNAbXVsdGljb3Jld2FyZWluYy5jb20+
Ci0tLQogd2luc3VwL2N5Z3dpbi9leGNlcHRpb25zLmNjIHwgMzQ1ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLQogMSBmaWxlIGNoYW5n
ZWQsIDMwNCBpbnNlcnRpb25zKCspLCA0MSBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS93aW5zdXAvY3lnd2luL2V4Y2VwdGlvbnMuY2MgYi93aW5zdXAv
Y3lnd2luL2V4Y2VwdGlvbnMuY2MKaW5kZXggMWUxMjliMzE5Li40MjI0Y2Rm
Y2YgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vZXhjZXB0aW9ucy5jYwor
KysgYi93aW5zdXAvY3lnd2luL2V4Y2VwdGlvbnMuY2MKQEAgLTE4OTIsNyAr
MTg5Miw3IEBAIF9jeWd0bHM6OmNhbGxfc2lnbmFsX2hhbmRsZXIgKCkKIAog
CSAgLyogSW4gYXNzZW1ibGVyOiBTYXZlIHJlZ3Mgb24gbmV3IHN0YWNrLCBt
b3ZlIHRvIGFsdGVybmF0ZSBzdGFjaywKIAkgICAgIGNhbGwgdGhpc2Z1bmMs
IHJldmVydCBzdGFjayByZWdzLiAqLwotI2lmZGVmIF9feDg2XzY0X18KKyNp
ZiBkZWZpbmVkKF9feDg2XzY0X18pCiAJICAvKiBDbG9iYmVyZWQgcmVnczog
cmN4LCByZHgsIHI4LCByOSwgcjEwLCByMTEsIHJicCwgcnNwICovCiAJICBf
X2FzbV9fICgiXG5cCiAJCSAgIG1vdnEgICVbTkVXX1NQXSwgJSVyYXggICMg
TG9hZCBhbHQgc3RhY2sgaW50byByYXgJXG5cCkBAIC0xOTMwLDYgKzE5MzAs
NjYgQEAgX2N5Z3Rsczo6Y2FsbF9zaWduYWxfaGFuZGxlciAoKQogCQkgICAg
ICAgW0ZVTkNdCSJvIiAodGhpc2Z1bmMpLAogCQkgICAgICAgW1dSQVBQRVJd
ICJvIiAoYWx0c3RhY2tfd3JhcHBlcikKIAkJICAgOiAibWVtb3J5Iik7Cisj
ZWxpZiBkZWZpbmVkKF9fYWFyY2g2NF9fKQorCSAgX19hc21fXyAoIlxuXAor
CQkgICBtb3YJeDksICVbTkVXX1NQXQkJLy8gTG9hZCBhbHQgc3RhY2sgaW50
byB4OQlcblwKKwkJICAgc3ViCXg5LCB4OSwgIzB4NjAJCS8vIE1ha2Ugcm9v
bSBvbiBhbHQgc3RhY2sJXG5cCisJCQkJCQkvLyBmb3IgY2xvYmJlcmVkIHJl
Z3MJCVxuXAorCQkgICBzdHIJeDAsIFt4OSwgIzB4MDBdCQkvLyBTYXZlIGNs
b2JiZXJlZCByZWdzCQlcblwKKwkJICAgc3RyCXgxLCBbeDksICMweDA4XQkJ
CQkJCVxuXAorCQkgICBzdHIJeDIsIFt4OSwgIzB4MTBdCQkJCQkJXG5cCisJ
CSAgIHN0cgl4MywgW3g5LCAjMHgxOF0JCQkJCQlcblwKKwkJICAgc3RyCXg0
LCBbeDksICMweDIwXQkJCQkJCVxuXAorCQkgICBzdHIJeDUsIFt4OSwgIzB4
MjhdCQkJCQkJXG5cCisJCSAgIHN0cgl4NiwgW3g5LCAjMHgzMF0JCQkJCQlc
blwKKwkJICAgc3RyCXg3LCBbeDksICMweDM4XQkJCQkJCVxuXAorCQkgICBz
dHIJZnAsIFt4OSwgIzB4NDBdCQkJCQkJXG5cCisJCSAgIG1vdgl4MTAsIHNw
CQkJLy8gQ29weSBzcCBpbnRvIHgxMCBmb3Igc2F2aW5nCVxuXAorCQkgICBz
dHIJeDEwLCBbeDksICMweDQ4XQkJCQkJXG5cCisJCSAgIHN0cgl4MzAsIFt4
OSwgIzB4NTBdCS8vIFNhdmUgbGluayByZWdpc3RlcgkJXG5cCisJCSAgIG1v
dgl4MCwgJVtTSUddCQkvLyB0aGlzc2lnIHRvIDFzdCBhcmcgcmVnCVxuXAor
CQkgICBtb3YJeDEsICVbU0ldCQkvLyAmdGhpc3NpIHRvIDJuZCBhcmcgcmVn
CVxuXAorCQkgICBtb3YJeDIsICVbQ1RYXQkJLy8gdGhpc2NvbnRleHQgdG8g
M3JkIGFyZyByZWcJXG5cCisJCSAgIG1vdgl4MywgJVtGVU5DXQkJLy8gdGhp
c2Z1bmMgdG8geDMJCVxuXAorCQkgICBtb3YJeDQsICVbV1JBUFBFUl0JCS8v
IHdyYXBwZXIgYWRkcmVzcyB0byB4NAlcblwKKwkJICAgbW92CXNwLCB4OQkJ
CS8vIE1vdmUgYWx0IHN0YWNrIGludG8gc3AJXG5cCisJCSAgIGJscgl4NAkJ
CS8vIENhbGwgd3JhcHBlcgkJCVxuXAorCQkgICBtb3YJeDksIHNwCQkJLy8g
UmVzdG9yZSBjbG9iYmVyZWQgcmVncwlcblwKKwkJICAgbGRyCXgzMCwgW3g5
LCAjMHg1MF0JLy8gUmVzdG9yZSBsaW5rIHJlZ2lzdGVyCVxuXAorCQkgICBs
ZHIJeDEwLCBbeDksICMweDQ4XQkJCQkJXG5cCisJCSAgIGxkcglmcCwgIFt4
OSwgIzB4NDBdCQkJCQlcblwKKwkJICAgbGRyCXg3LCAgW3g5LCAjMHgzOF0J
CQkJCVxuXAorCQkgICBsZHIJeDYsICBbeDksICMweDMwXQkJCQkJXG5cCisJ
CSAgIGxkcgl4NSwgIFt4OSwgIzB4MjhdCQkJCQlcblwKKwkJICAgbGRyCXg0
LCAgW3g5LCAjMHgyMF0JCQkJCVxuXAorCQkgICBsZHIJeDMsICBbeDksICMw
eDE4XQkJCQkJXG5cCisJCSAgIGxkcgl4MiwgIFt4OSwgIzB4MTBdCQkJCQlc
blwKKwkJICAgbGRyCXgxLCAgW3g5LCAjMHgwOF0JCQkJCVxuXAorCQkgICBs
ZHIJeDAsICBbeDksICMweDAwXQkJCQkJXG5cCisJCSAgIG1vdglzcCwgIHgx
MAkJLy8gUmVzdG9yZSBzdGFjayBwb2ludGVyCVxuIgorCQkgICA6IDogW05F
V19TUF0JICJyIiAobmV3X3NwKSwKKwkJICAgICAgIFtTSUddCSAiciIgKHRo
aXNzaWcpLAorCQkgICAgICAgW1NJXQkgInIiICgmdGhpc3NpKSwKKwkJICAg
ICAgIFtDVFhdCSAiciIgKHRoaXNjb250ZXh0KSwKKwkJICAgICAgIFtGVU5D
XQkgInIiICh0aGlzZnVuYyksCisJCSAgICAgICBbV1JBUFBFUl0gInIiIChh
bHRzdGFja193cmFwcGVyKQorCQkgICAvKiBUaGUgY2xvYmJlciBsaXN0IHNl
cnZlcyB0d28gcm9sZXMgaGVyZS4gIHgwLXg3LCB4OSwgeDEwCisJCSAgICAg
IGFuZCB4MjkgYXJlIGhhcmRjb2RlZCBieSB0aGlzIGFzbSBhcyBzY3JhdGNo
L2FyZ3VtZW50CisJCSAgICAgIHJlZ2lzdGVycywgc28gdGhleSBhcmUgbGlz
dGVkIHRvIHN0b3AgZ2NjIGFsbG9jYXRpbmcgdGhlCisJCSAgICAgICJyIiBp
bnB1dHMgaW50byB0aGVtLiAgKFRoZSB4ODZfNjQgcGF0aCBhYm92ZSBuZWVk
cyBubworCQkgICAgICBzdWNoIGd1YXJkIGJlY2F1c2UgaXRzIGlucHV0cyBh
cmUgIm8iIG1lbW9yeSBvcGVyYW5kcy4pCisJCSAgICAgIFRoZSByZW1haW5p
bmcgcmVnaXN0ZXJzIC0geDgsIHgxMS14MTcsIHgzMCAodHJhbXBsZWQgYnkK
KwkJICAgICAgdGhlIGJscikgYW5kIHYwLXY3L3YxNi12MzEgLSBhcmUgY2Fs
bGVyLXNhdmVkIGFuZCBjbG9iYmVyZWQKKwkJICAgICAgYnkgdGhlIG9yZGlu
YXJ5IEMgY2FsbCB0byBhbHRzdGFja193cmFwcGVyLiAgeDE4ICh0aGUKKwkJ
ICAgICAgV2luZG93cyBURUIgcG9pbnRlcikgYW5kIHY4LXYxNSAoY2FsbGVl
LXNhdmVkIG9uIFdpbmRvd3MpCisJCSAgICAgIHN1cnZpdmUgdGhlIGNhbGwg
YW5kIGFyZSBvbWl0dGVkLiAgKi8KKwkJICAgOiAibWVtb3J5IiwgImNjIiwK
KwkJICAgICAieDAiLCAieDEiLCAieDIiLCAieDMiLCAieDQiLCAieDUiLCAi
eDYiLCAieDciLAorCQkgICAgICJ4OCIsICJ4OSIsICJ4MTAiLCAieDExIiwg
IngxMiIsICJ4MTMiLCAieDE0IiwgIngxNSIsCisJCSAgICAgIngxNiIsICJ4
MTciLCAieDI5IiwgIngzMCIsCisJCSAgICAgInYwIiwgInYxIiwgInYyIiwg
InYzIiwgInY0IiwgInY1IiwgInY2IiwgInY3IiwKKwkJICAgICAidjE2Iiwg
InYxNyIsICJ2MTgiLCAidjE5IiwgInYyMCIsICJ2MjEiLCAidjIyIiwgInYy
MyIsCisJCSAgICAgInYyNCIsICJ2MjUiLCAidjI2IiwgInYyNyIsICJ2Mjgi
LCAidjI5IiwgInYzMCIsICJ2MzEiKTsKICNlbHNlCiAjZXJyb3IgdW5pbXBs
ZW1lbnRlZCBmb3IgdGhpcyB0YXJnZXQKICNlbmRpZgpAQCAtMjAwOSwxMCAr
MjA2OSw4OSBAQCBzZXRjb250ZXh0IChjb25zdCB1Y29udGV4dF90ICp1Y3Ap
CiB7CiAgIFBDT05URVhUIGN0eCA9IChQQ09OVEVYVCkgJnVjcC0+dWNfbWNv
bnRleHQ7CiAgIHNldF9zaWduYWxfbWFzayAoX215X3Rscy5zaWdtYXNrLCB1
Y3AtPnVjX3NpZ21hc2spOworI2lmIGRlZmluZWQoX19hYXJjaDY0X18pCisg
IC8qIE9uIEFSTTY0LCBSdGxSZXN0b3JlQ29udGV4dCByYWlzZXMgU1RBVFVT
X0lMTEVHQUxfSU5TVFJVQ1RJT04gd2hlbiBhc2tlZAorICAgICB0byByZXN0
b3JlIGEgc3ludGhldGljIGNvbnRleHQgYnVpbHQgYnkgbWFrZWNvbnRleHQg
cmF0aGVyIHRoYW4gb25lCisgICAgIGNhcHR1cmVkIGJ5IFJ0bENhcHR1cmVD
b250ZXh0L0dldFRocmVhZENvbnRleHQ6IGl0IHJlamVjdHMgYW4gYXJiaXRy
YXJ5CisgICAgIFBDIGFuZCBhIHN0YWNrIG91dHNpZGUgdGhlIHRocmVhZCdz
IHJlZ2lzdGVyZWQgcmFuZ2UuICBSZXN0b3JlIHRoZQorICAgICByZWdpc3Rl
cnMgYnkgaGFuZCBhbmQgYnJhbmNoIHRvIHRoZSBzYXZlZCBQQyBpbnN0ZWFk
LCBhcyBnbGliYy9tdXNsIGRvCisgICAgIGZvciBhYXJjaDY0LgorCisgICAg
IFRoZSBudW1lcmljIG9mZnNldHMgYmVsb3cgYXJlIGJ5dGUgb2Zmc2V0cyBp
bnRvIHN0cnVjdCBfX21jb250ZXh0LCB3aG9zZQorICAgICBsYXlvdXQgbWly
cm9ycyB0aGUgV2luZG93cyBBUk02NCBDT05URVhUOiB4MC94MSBAOCwgeDIt
eDE1IEAyNC0xMjAsCisgICAgIHgxOC14MjgvZnAgQDE1Mi0yMzIsIGxyIEAy
NDgsIHNwIEAyNTYsIHBjIEAyNjQsIHZbMC4uMzFdIEAyNzIgKDE2IGJ5dGVz
CisgICAgIGVhY2gpLCBmcGNyIEA3ODQsIGZwc3IgQDc4OC4KKworICAgICB4
MTYgKElQMCkgYW5kIHgxNyAoSVAxKSBhcmUgdGhlIEFCSSBpbnRyYS1wcm9j
ZWR1cmUtY2FsbCBzY3JhdGNoCisgICAgIHJlZ2lzdGVyczogdGhlaXIgdmFs
dWVzIGluIHRoZSBjb250ZXh0IGFyZSBkZWxpYmVyYXRlbHkgbm90IHJlc3Rv
cmVkLgorICAgICBXZSByZXVzZSB4MTYgYXMgdGhlIGJhc2UgcG9pbnRlciBh
bmQgeDE3IGFzIHRoZSBicmFuY2ggdGFyZ2V0LCBhbmQgdGhlCisgICAgIEFC
SSBwZXJtaXRzIHRoZSBsaW5rZXIgdG8gY2xvYmJlciB4MTYveDE3IGluIGFu
eSBjYWxsL2JyYW5jaCB2ZW5lZXIsIHNvIGEKKyAgICAgdWNvbnRleHQgY29u
c3VtZXIgbWF5IG5vdCByZWx5IG9uIHRoZW0gc3Vydml2aW5nIGEgc2V0Y29u
dGV4dC4gIENQU1IgaXMKKyAgICAgbGlrZXdpc2Ugbm90IHJlc3RvcmVkOiBp
dCBjYW5ub3QgYmUgd3JpdHRlbiBmcm9tIEVMMCB3aXRoIGEgcGxhaW4gbXNy
LAorICAgICB0aGUgb25seSBmbGFncyBvZiBpbnRlcmVzdCAoTlpDVikgYXJl
IGNhbGxlci1jbG9iYmVyZWQgYWNyb3NzIHRoZQorICAgICBtYWtlY29udGV4
dC9zd2FwY29udGV4dCBib3VuZGFyeSB0aGlzIHBhdGggc2VydmVzLCBhbmQg
Z2xpYmMvbXVzbCB0YWtlCisgICAgIHRoZSBzYW1lIGFwcHJvYWNoIGZvciBh
YXJjaDY0LiAgKi8KKyAgcmVnaXN0ZXIgUENPTlRFWFQgYmFzZSBfX2FzbV9f
ICgieDE2IikgPSBjdHg7CisgIF9fYXNtX18gX192b2xhdGlsZV9fICgiXG5c
CisJYWRkCXgxNywgeDE2LCAjMjcyCQkJCQlcblwKKwlsZHAJcTAsIHExLCBb
eDE3LCAjMF0JCQkJXG5cCisJbGRwCXEyLCBxMywgW3gxNywgIzMyXQkJCQlc
blwKKwlsZHAJcTQsIHE1LCBbeDE3LCAjNjRdCQkJCVxuXAorCWxkcAlxNiwg
cTcsIFt4MTcsICM5Nl0JCQkJXG5cCisJbGRwCXE4LCBxOSwgW3gxNywgIzEy
OF0JCQkJXG5cCisJbGRwCXExMCwgcTExLCBbeDE3LCAjMTYwXQkJCQlcblwK
KwlsZHAJcTEyLCBxMTMsIFt4MTcsICMxOTJdCQkJCVxuXAorCWxkcAlxMTQs
IHExNSwgW3gxNywgIzIyNF0JCQkJXG5cCisJbGRwCXExNiwgcTE3LCBbeDE3
LCAjMjU2XQkJCQlcblwKKwlsZHAJcTE4LCBxMTksIFt4MTcsICMyODhdCQkJ
CVxuXAorCWxkcAlxMjAsIHEyMSwgW3gxNywgIzMyMF0JCQkJXG5cCisJbGRw
CXEyMiwgcTIzLCBbeDE3LCAjMzUyXQkJCQlcblwKKwlsZHAJcTI0LCBxMjUs
IFt4MTcsICMzODRdCQkJCVxuXAorCWxkcAlxMjYsIHEyNywgW3gxNywgIzQx
Nl0JCQkJXG5cCisJbGRwCXEyOCwgcTI5LCBbeDE3LCAjNDQ4XQkJCQlcblwK
KwlsZHAJcTMwLCBxMzEsIFt4MTcsICM0ODBdCQkJCVxuXAorCS8qIFJlc3Rv
cmUgRlBDUiBhbmQgRlBTUiAqLwkJCQlcblwKKwlsZHIJdzE3LCBbeDE2LCAj
Nzg0XQkJCQlcblwKKwltc3IJZnBjciwgeDE3CQkJCQlcblwKKwlsZHIJdzE3
LCBbeDE2LCAjNzg4XQkJCQlcblwKKwltc3IJZnBzciwgeDE3CQkJCQlcblwK
KwkvKiBMb2FkIFBDIGludG8geDE3IChicmFuY2ggdGFyZ2V0LCBvZmZzZXQg
MjY0KSAqLwlcblwKKwlsZHIJeDE3LCBbeDE2LCAjMjY0XQkJCQlcblwKKwkv
KiBSZXN0b3JlIGNhbGxlZS1zYXZlZCBHUFJzIHgxOC4ueDI4LCBmcCwgbHIg
Ki8JXG5cCisJbGRwCXgxOCwgeDE5LCBbeDE2LCAjMTUyXQkJCQlcblwKKwls
ZHAJeDIwLCB4MjEsIFt4MTYsICMxNjhdCQkJCVxuXAorCWxkcAl4MjIsIHgy
MywgW3gxNiwgIzE4NF0JCQkJXG5cCisJbGRwCXgyNCwgeDI1LCBbeDE2LCAj
MjAwXQkJCQlcblwKKwlsZHAJeDI2LCB4MjcsIFt4MTYsICMyMTZdCQkJCVxu
XAorCWxkcAl4MjgsIHgyOSwgW3gxNiwgIzIzMl0JCQkJXG5cCisJbGRyCXgz
MCwgW3gxNiwgIzI0OF0JCQkJXG5cCisJLyogUmVzdG9yZSBjYWxsZXItc2F2
ZWQgR1BScyB4Mi4ueDE1ICovCQkJXG5cCisJbGRwCXgyLCB4MywgW3gxNiwg
IzI0XQkJCQlcblwKKwlsZHAJeDQsIHg1LCBbeDE2LCAjNDBdCQkJCVxuXAor
CWxkcAl4NiwgeDcsIFt4MTYsICM1Nl0JCQkJXG5cCisJbGRwCXg4LCB4OSwg
W3gxNiwgIzcyXQkJCQlcblwKKwlsZHAJeDEwLCB4MTEsIFt4MTYsICM4OF0J
CQkJXG5cCisJbGRwCXgxMiwgeDEzLCBbeDE2LCAjMTA0XQkJCQlcblwKKwls
ZHAJeDE0LCB4MTUsIFt4MTYsICMxMjBdCQkJCVxuXAorCS8qIFJlc3RvcmUg
eDAsIHgxICovCQkJCQlcblwKKwlsZHAJeDAsIHgxLCBbeDE2LCAjOF0JCQkJ
XG5cCisJLyogU2V0IFNQIGZyb20gY29udGV4dCAobGFzdCB1c2Ugb2YgeDE2
IGFzIGJhc2UpICovCVxuXAorCWxkcgl4MTYsIFt4MTYsICMyNTZdCQkJCVxu
XAorCW1vdglzcCwgeDE2CQkJCQkJXG5cCisJLyogQnJhbmNoIHRvIHNhdmVk
IFBDICovCQkJCVxuXAorCWJyCXgxNwkJCQkJCVxuXAorIgorCTogLyogbm8g
b3V0cHV0cyAobm9yZXR1cm4pICovCisJOiAiciIgKGJhc2UpCisJOiAibWVt
b3J5IgorICApOworICBfX2J1aWx0aW5fdW5yZWFjaGFibGUgKCk7CisjZWxz
ZQogICBSdGxSZXN0b3JlQ29udGV4dCAoY3R4LCBOVUxMKTsKICAgLyogSWYg
d2UgZ290IGhlcmUsIHNvbWV0aGluZyB3YXMgd3JvbmcuICovCiAgIHNldF9l
cnJubyAoRUlOVkFMKTsKICAgcmV0dXJuIC0xOworI2VuZGlmCiB9CiAKIGV4
dGVybiAiQyIgaW50CkBAIC0yMDQ5LDcgKzIxODgsNyBAQCBzd2FwY29udGV4
dCAodWNvbnRleHRfdCAqb3VjcCwgY29uc3QgdWNvbnRleHRfdCAqdWNwKQog
LyogVHJhbXBvbGluZSBmdW5jdGlvbiB0byBzZXQgdGhlIGNvbnRleHQgdG8g
dWNfbGluay4gIFRoZSBwb2ludGVyIHRvIHRoZQogICAgYWRkcmVzcyBvZiB1
Y19saW5rIGlzIHN0b3JlZCBpbiBhIGNhbGxlZS1zYXZlZCByZWdpc3Rlciwg
cmVmZXJlbmNlZCBieQogICAgX01DX3VjbGlua1JlZyBmcm9tIHRoZSBDIGNv
ZGUuICBJZiB1Y19saW5rIGlzIE5VTEwsIGNhbGwgZXhpdC4gKi8KLSNpZmRl
ZiBfX3g4Nl82NF9fCisjaWYgZGVmaW5lZChfX3g4Nl82NF9fKQogLyogX01D
X3VjbGlua1JlZyA9PSAlcmJ4ICovCiBfX2FzbV9fICgiCQkJCVxuXAogCS5n
bG9iYWwJX19jb250X2xpbmtfY29udGV4dAlcblwKQEAgLTIwNzAsMTkgKzIy
MDksNTAgQEAgX19jb250X2xpbmtfY29udGV4dDoJCQlcblwKIAlub3AJCQkJ
XG5cCiAJLnNlaF9lbmRwcm9jCQkJXG5cCiAJIik7Ci0KKyNlbGlmIGRlZmlu
ZWQoX19hYXJjaDY0X18pCisvKglfTUNfdWNsaW5rUmVnID09IHgxOS4gIHgx
OSBob2xkcyB0aGUgYWRkcmVzcyBvZiB0aGUgdWNfbGluayBzbG90IGJ1dCBp
cworCW9ubHkgOC1ieXRlIGFsaWduZWQsIHNvIHJlYWQgdGhyb3VnaCBpdCBh
bmQgbWFzayBpbnRvIFNQIGluIG9uZSBzdGVwCisJcmF0aGVyIHRoYW4gbW92
aW5nIHRoZSB1bmFsaWduZWQgdmFsdWUgaW50byBTUCBmaXJzdC4gIHNldGNv
bnRleHQgYW5kCisJY3lnd2luX2V4aXQgYXJlIG5vcmV0dXJuLCBzbyB0YWls
LWNhbGwgdGhlbSB3aXRoICdiJzogdGhpcyBsZWF2ZXMgeDMwCisJdW50b3Vj
aGVkIGFuZCBrZWVwcyB0aGUgZnJhbWUgbGVhZiwgbWF0Y2hpbmcgdGhlIGVt
cHR5IFNFSCBwcm9sb2d1ZS4gKi8KK19fYXNtX18gKCIJCQkJCVxuXAorCS5n
bG9iYWwJX19jb250X2xpbmtfY29udGV4dAkJXG5cCisJLnNlaF9wcm9jIF9f
Y29udF9saW5rX2NvbnRleHQJCVxuXAorX19jb250X2xpbmtfY29udGV4dDoJ
CQkJXG5cCisJLnNlaF9lbmRwcm9sb2d1ZQkJCVxuXAorCWxkcgl4MCwgW3gx
OV0JCQlcblwKKwlhbmQJc3AsIHgxOSwgI34weGYJCQlcblwKKwljYm56CXgw
LCAxZgkJCQlcblwKKwltb3YJdzAsICMweGZmCQkJXG5cCisJYgljeWd3aW5f
ZXhpdAkJCVxuXAorMToJCQkJCQlcblwKKwliCXNldGNvbnRleHQJCQlcblwK
Kwkuc2VoX2VuZHByb2MJCQkJXG4iCisJKTsKICNlbHNlCiAjZXJyb3IgdW5p
bXBsZW1lbnRlZCBmb3IgdGhpcyB0YXJnZXQKICNlbmRpZgogCiAvKiBtYWtl
Y29udGV4dCBpcyBtb2RlbGxlZCBhZnRlciBHTGliYydzIG1ha2Vjb250ZXh0
LiAgVGhlIHN0YWNrIGZyb20gdWNfc3RhY2sKICAgIGlzIHByZXBhcmVkIHNv
IHRoYXQgaXQgc3RhcnRzIHdpdGggYSBwb2ludGVyIHRvIHRoZSBsaW5rZWQg
Y29udGV4dCB1Y19saW5rLAotICAgZm9sbG93ZWQgYnkgdGhlIGFyZ3VtZW50
cyB0byBmdW5jLCBhbmQgZmluYWxseSBhdCB0aGUgYm90dG9tIHRoZSAicmV0
dXJuIgotICAgYWRkcmVzcyBzZXQgdG8gX19jb250X2xpbmtfY29udGV4dC4g
IEluIHRoZSB1Y3AgY29udGV4dCwgcmJ4L2VieCBpcyBzZXQgdG8KLSAgIHBv
aW50IHRvIHRoZSBzdGFjayBhZGRyZXNzIHdoZXJlIHRoZSBwb2ludGVyIHRv
IHVjX2xpbmsgaXMgc3RvcmVkLiAgVGhlCi0gICByZXF1aXJlbWVudCB0byBt
YWtlIHRoaXMgd29yayBpcyB0aGF0IHJieC9lYnggYXJlIGNhbGxlZS1zYXZl
ZCByZWdpc3RlcnMKLSAgIHBlciB0aGUgQUJJLiAgSWYgYW55IGZ1bmN0aW9u
IGlzIGNhbGxlZCB3aGljaCBkb2Vzbid0IGZvbGxvdyB0aGUgQUJJCi0gICBj
b252ZW50aW9ucywgZS5nLiBhc3NlbWJsZXIgY29kZSwgdGhpcyBtZXRob2Qg
d2lsbCBicmVhay4gIEJ1dCB0aGF0J3Mgb2suICovCisgICBmb2xsb3dlZCBi
eSB0aGUgYXJndW1lbnRzIHRvIGZ1bmMuCisKKyAgIFRoZSB0cmFtcG9saW5l
IF9fY29udF9saW5rX2NvbnRleHQgaXMgcmVhY2hlZCBkaWZmZXJlbnRseSBw
ZXIgdGFyZ2V0OiBvbgorICAgeDg2XzY0IGl0cyBhZGRyZXNzIGlzIHdyaXR0
ZW4gYXQgdGhlIGJvdHRvbSBvZiB0aGUgc3RhY2sgYXMgdGhlICJyZXR1cm4i
CisgICBhZGRyZXNzLCB3aGVyZWFzIG9uIGFhcmNoNjQgaXQgaXMgcGxhY2Vk
IGluIGxyIChzZWUgYmVsb3cpLCBzaW5jZSB0aGUKKyAgIEFBcmNoNjQgQUJJ
IHJldHVybnMgdGhyb3VnaCB0aGUgbGluayByZWdpc3RlciByYXRoZXIgdGhh
biB0aGUgc3RhY2suCisKKyAgIHg4Nl82NDogSW4gdGhlIHVjcCBjb250ZXh0
LCByYnggaXMgc2V0IHRvIHBvaW50IHRvIHRoZSBzdGFjayBhZGRyZXNzIHdo
ZXJlCisgICB0aGUgcG9pbnRlciB0byB1Y19saW5rIGlzIHN0b3JlZC4gIFRo
ZSByZXF1aXJlbWVudCB0byBtYWtlIHRoaXMgd29yayBpcyB0aGF0CisgICBy
YnggaXMgYSBjYWxsZWUtc2F2ZWQgcmVnaXN0ZXIgcGVyIHRoZSBBQkkuCisK
KyAgIEFSTTY0OiBJbiB0aGUgdWNwIGNvbnRleHQsIHgxOSBpcyBzZXQgdG8g
cG9pbnQgdG8gdGhlIHN0YWNrIGFkZHJlc3Mgd2hlcmUKKyAgIHRoZSBwb2lu
dGVyIHRvIHVjX2xpbmsgaXMgc3RvcmVkLiAgVGhlIHJlcXVpcmVtZW50IGlz
IHRoYXQgeDE5IGlzIGEKKyAgIGNhbGxlZS1zYXZlZCByZWdpc3RlciBwZXIg
dGhlIEFSTTY0IEFCSS4KKworICAgSWYgYW55IGZ1bmN0aW9uIGlzIGNhbGxl
ZCB3aGljaCBkb2Vzbid0IGZvbGxvdyB0aGUgQUJJIGNvbnZlbnRpb25zLCBl
LmcuCisgICBhc3NlbWJsZXIgY29kZSwgdGhpcyBtZXRob2Qgd2lsbCBicmVh
ay4gIEJ1dCB0aGF0J3Mgb2suICovCisKIGV4dGVybiAiQyIgdm9pZAogbWFr
ZWNvbnRleHQgKHVjb250ZXh0X3QgKnVjcCwgdm9pZCAoKmZ1bmMpICh2b2lk
KSwgaW50IGFyZ2MsIC4uLikKIHsKQEAgLTIwOTAsNjUgKzIyNjAsMTU4IEBA
IG1ha2Vjb250ZXh0ICh1Y29udGV4dF90ICp1Y3AsIHZvaWQgKCpmdW5jKSAo
dm9pZCksIGludCBhcmdjLCAuLi4pCiAgIHVpbnRwdHJfdCAqc3A7CiAgIHZh
X2xpc3QgYXA7CiAKKyNpZiBkZWZpbmVkKF9feDg2XzY0X18pCisgIC8qIHg4
Nl82NDogQXJndW1lbnRzIGJleW9uZCB0aGUgZmlyc3QgNCBnbyBvbiB0aGUg
c3RhY2suCisgICAgIEhvd2V2ZXIsIHdlIGFsbG9jYXRlIHNoYWRvdyBzcGFj
ZSBmb3IgYWxsIGFyZ3MgaW5jbHVkaW5nIHJlZ2lzdGVyIGFyZ3MuICovCisg
IGludCBzdGFja19hcmdzID0gYXJnYzsKKworI2VsaWYgZGVmaW5lZChfX2Fh
cmNoNjRfXykKKyAgLyogQVJNNjQ6IEFyZ3VtZW50cyBiZXlvbmQgdGhlIGZp
cnN0IDggZ28gb24gdGhlIHN0YWNrLgorICAgICBXZSBvbmx5IGFsbG9jYXRl
IHN0YWNrIHNwYWNlIGZvciBhcmdzIGJleW9uZCByZWdpc3RlcnMuICovCisg
IGludCBzdGFja19hcmdzID0gKGFyZ2MgPiA4KSA/IChhcmdjIC0gOCkgOiAw
OworCisjZWxzZQorI2Vycm9yIHVuaW1wbGVtZW50ZWQgZm9yIHRoaXMgdGFy
Z2V0CisjZW5kaWYKKwogICAvKiBJbml0aWFsaXplIHNwIHRvIHRoZSB0b3Ag
b2YgdGhlIHN0YWNrLiAqLwogICBzcCA9ICh1aW50cHRyX3QgKikgKCh1aW50
cHRyX3QpIHVjcC0+dWNfc3RhY2suc3Nfc3AgKyB1Y3AtPnVjX3N0YWNrLnNz
X3NpemUpOwotICAvKiBTdWJ0cmFjdCBzbG90cyByZXF1aXJlZCBmb3IgYXJn
dW1lbnRzIGFuZCB0aGUgcG9pbnRlciB0byB1Y19saW5rLiAqLwotICBzcCAt
PSAoYXJnYyArIDEpOwotICAvKiBBbGlnbi4gKi8KLSAgc3AgPSAodWludHB0
cl90ICopICgodWludHB0cl90KSBzcCAmIH4weGYpOwotICAvKiBTdWJ0cmFj
dCBvbmUgc2xvdCBmb3Igc2V0dGluZyB0aGUgcmV0dXJuIGFkZHJlc3MuICov
CisKKyNpZiBkZWZpbmVkKF9feDg2XzY0X18pCisgIC8qIHg4Nl82NDogU3Vi
dHJhY3Qgc2xvdHMgZm9yIGFsbCBhcmd1bWVudHMgKyB1Y19saW5rIHBvaW50
ZXIKKyAgICAgYW5kIHJldHVybiBhZGRyZXNzLiAgKi8KKyAgc3AgLT0gKHN0
YWNrX2FyZ3MgKyAxKTsgIC8qIGFyZ2MgKyAxIGZvciB1Y19saW5rICovCisg
IC8qIEFsaWduIHRvIDE2IGJ5dGVzLiAqLworICBzcCA9ICh1aW50cHRyX3Qg
KikgKCh1aW50cHRyX3QpIHNwICYgfjB4ZlVMKTsKKyAgLyogU3VidHJhY3Qg
b25lIG1vcmUgc2xvdCBmb3IgdGhlIHJldHVybiBhZGRyZXNzLiAqLwogICAt
LXNwOwotICAvKiBTZXQgcmV0dXJuIGFkZHJlc3MgdG8gdGhlIHRyYW1wb2xp
biBmdW5jdGlvbiBfX2NvbnRfbGlua19jb250ZXh0LiAqLworICAvKiBTZXQg
cmV0dXJuIGFkZHJlc3MgdG8gdGhlIHRyYW1wb2xpbmUgZnVuY3Rpb24gX19j
b250X2xpbmtfY29udGV4dC4gKi8KICAgc3BbMF0gPSAodWludHB0cl90KSBf
X2NvbnRfbGlua19jb250ZXh0OwotICAvKiBGZXRjaCBhcmd1bWVudHMgYW5k
IHN0b3JlIHRoZW0gb24gdGhlIHN0YWNrLgogCi0gICAgIHg4Nl82NDoKKyNl
bGlmIGRlZmluZWQoX19hYXJjaDY0X18pCisgIC8qIEFSTTY0OiBTdWJ0cmFj
dCBzbG90cyBmb3Igc3RhY2sgYXJndW1lbnRzICsgdWNfbGluayBwb2ludGVy
LiAqLworICBzcCAtPSAoc3RhY2tfYXJncyArIDEpOyAgLyogc3RhY2tfYXJn
cyArIDEgZm9yIHVjX2xpbmsgKi8KKyAgLyogQVJNNjQgcmVxdWlyZXMgMTYt
Ynl0ZSBhbGlnbm1lbnQgYXQgcHVibGljIGludGVyZmFjZXMuICovCisgIHNw
ID0gKHVpbnRwdHJfdCAqKSAoKHVpbnRwdHJfdCkgc3AgJiB+MHhmVUwpOwog
Ci0gICAgIC0gU3RvcmUgZmlyc3QgZm91ciBhcmdzIGluIHRoZSBBTUQ2NCBB
QkkgYXJnIHJlZ2lzdGVycy4KKyNlbHNlCisjZXJyb3IgdW5pbXBsZW1lbnRl
ZCBmb3IgdGhpcyB0YXJnZXQKKyNlbmRpZgogCisgIC8qIEZldGNoIGFyZ3Vt
ZW50cyBhbmQgc3RvcmUgdGhlbS4KKyAgICAgeDg2XzY0OgorICAgICAtIFN0
b3JlIGZpcnN0IGZvdXIgYXJncyBpbiB0aGUgQU1ENjQgQUJJIGFyZyByZWdp
c3RlcnMgKHJjeCwgcmR4LCByOCwgcjkpLgogICAgICAtIE5vdGUgdGhhdCB0
aGUgc3RhY2sgaXMgbm90IHNob3J0IGJ5IHRoZXNlIGZvdXIgcmVnaXN0ZXIg
YXJncy4gIFRoZQogICAgICAgIHJlYXNvbiBpcyB0aGUgc2hhZG93IHNwYWNl
IGZvciB0aGVzZSByZWdzIHJlcXVpcmVkIGJ5IHRoZSBBTUQ2NCBBQkkuCi0K
ICAgICAgLSBUaGUgZGVmaW5pdGlvbiBvZiBtYWtlY29udGV4dCBvbmx5IGFs
bG93cyBmb3IgImludCIgc2l6ZWQgYXJndW1lbnRzIHRvCiAgICAgICAgZnVu
YywgMzIgYml0LCBsaWtlbHkgZm9yIGhpc3RvcmljYWwgcmVhc29ucy4gIEhv
d2V2ZXIsIHRoZSBhcmd1bWVudAogICAgICAgIHNsb3RzIG9uIHg4Nl82NCBh
cmUgNjQgYml0IGFueXdheSwgc28gd2UgY2FuIGZldGNoIGFuZCBzdG9yZSB0
aGUgYXJncwogICAgICAgIGFzIDY0IGJpdCB2YWx1ZXMsIGFuZCBmdW5jIGNh
biByZXF1ZXN0IDY0IGJpdCBhcmdzIHdpdGhvdXQgdmlvbGF0aW5nCiAgICAg
ICAgdGhlIGRlZmluaXRpb24uICBUaGlzIHBvdGVudGlhbGx5IGFsbG93cyBw
b3J0aW5nIDMyIGJpdCBhcHBsaWNhdGlvbnMKLSAgICAgICBwcm92aWRpbmcg
cG9pbnRlciB2YWx1ZXMgdG8gZnVuYyB3aXRob3V0IGFkZGl0aW9uYWwgcG9y
dGluZyBlZmZvcnQuICovCisgICAgICAgcHJvdmlkaW5nIHBvaW50ZXIgdmFs
dWVzIHRvIGZ1bmMgd2l0aG91dCBhZGRpdGlvbmFsIHBvcnRpbmcgZWZmb3J0
LgorCisgICAgIEFSTTY0OgorICAgICAtIFN0b3JlIGZpcnN0IGVpZ2h0IGFy
Z3MgaW4gQVJNNjQgQUJJIGFyZyByZWdpc3RlcnMgKHgwLXg3KS4KKyAgICAg
LSBBcmd1bWVudHMgYmV5b25kIDggZ28gb24gdGhlIHN0YWNrLgorICAgICAt
IFNpbWlsYXIgdG8geDg2XzY0LCB3ZSBzdG9yZSBhcyB1aW50cHRyX3QgZm9y
IHBvaW50ZXIgY29tcGF0aWJpbGl0eS4gKi8KKwogICB2YV9zdGFydCAoYXAs
IGFyZ2MpOwogICBmb3IgKGludCBpID0gMDsgaSA8IGFyZ2M7ICsraSkKLSNp
ZmRlZiBfX3g4Nl82NF9fCi0gICAgc3dpdGNoIChpKQotICAgICAgewotICAg
ICAgY2FzZSAwOgotCXVjcC0+dWNfbWNvbnRleHQucmN4ID0gdmFfYXJnIChh
cCwgdWludHB0cl90KTsKLQlicmVhazsKLSAgICAgIGNhc2UgMToKLQl1Y3At
PnVjX21jb250ZXh0LnJkeCA9IHZhX2FyZyAoYXAsIHVpbnRwdHJfdCk7Ci0J
YnJlYWs7Ci0gICAgICBjYXNlIDI6Ci0JdWNwLT51Y19tY29udGV4dC5yOCA9
IHZhX2FyZyAoYXAsIHVpbnRwdHJfdCk7Ci0JYnJlYWs7Ci0gICAgICBjYXNl
IDM6Ci0JdWNwLT51Y19tY29udGV4dC5yOSA9IHZhX2FyZyAoYXAsIHVpbnRw
dHJfdCk7Ci0JYnJlYWs7Ci0gICAgICBkZWZhdWx0OgotCXNwW2kgKyAxXSA9
IHZhX2FyZyAoYXAsIHVpbnRwdHJfdCk7Ci0JYnJlYWs7Ci0gICAgICB9Cisg
ICAgeworI2lmIGRlZmluZWQoX194ODZfNjRfXykKKyAgICAgIHN3aXRjaCAo
aSkKKyAgICAgICAgeworICAgICAgICBjYXNlIDA6CisgICAgICAgICAgdWNw
LT51Y19tY29udGV4dC5yY3ggPSB2YV9hcmcgKGFwLCB1aW50cHRyX3QpOwor
ICAgICAgICAgIGJyZWFrOworICAgICAgICBjYXNlIDE6CisgICAgICAgICAg
dWNwLT51Y19tY29udGV4dC5yZHggPSB2YV9hcmcgKGFwLCB1aW50cHRyX3Qp
OworICAgICAgICAgIGJyZWFrOworICAgICAgICBjYXNlIDI6CisgICAgICAg
ICAgdWNwLT51Y19tY29udGV4dC5yOCA9IHZhX2FyZyAoYXAsIHVpbnRwdHJf
dCk7CisgICAgICAgICAgYnJlYWs7CisgICAgICAgIGNhc2UgMzoKKyAgICAg
ICAgICB1Y3AtPnVjX21jb250ZXh0LnI5ID0gdmFfYXJnIChhcCwgdWludHB0
cl90KTsKKyAgICAgICAgICBicmVhazsKKyAgICAgICAgZGVmYXVsdDoKKyAg
ICAgICAgICAvKiBTdGFjayBhcmd1bWVudHMgc3RhcnQgYXQgc3BbaSArIDFd
IGJlY2F1c2Ugc3BbMF0gaXMgcmV0dXJuIGFkZHJlc3MgKi8KKyAgICAgICAg
ICBzcFtpICsgMV0gPSB2YV9hcmcgKGFwLCB1aW50cHRyX3QpOworICAgICAg
ICAgIGJyZWFrOworICAgICAgICB9CisKKyNlbGlmIGRlZmluZWQoX19hYXJj
aDY0X18pCisgICAgICBzd2l0Y2ggKGkpCisgICAgICAgIHsKKyAgICAgICAg
Y2FzZSAwOgorICAgICAgICAgIHVjcC0+dWNfbWNvbnRleHQueDAgPSB2YV9h
cmcgKGFwLCB1aW50cHRyX3QpOworICAgICAgICAgIGJyZWFrOworICAgICAg
ICBjYXNlIDE6CisgICAgICAgICAgdWNwLT51Y19tY29udGV4dC54MSA9IHZh
X2FyZyAoYXAsIHVpbnRwdHJfdCk7CisgICAgICAgICAgYnJlYWs7CisgICAg
ICAgIGNhc2UgMjoKKyAgICAgICAgICB1Y3AtPnVjX21jb250ZXh0LngyID0g
dmFfYXJnIChhcCwgdWludHB0cl90KTsKKyAgICAgICAgICBicmVhazsKKyAg
ICAgICAgY2FzZSAzOgorICAgICAgICAgIHVjcC0+dWNfbWNvbnRleHQueDMg
PSB2YV9hcmcgKGFwLCB1aW50cHRyX3QpOworICAgICAgICAgIGJyZWFrOwor
ICAgICAgICBjYXNlIDQ6CisgICAgICAgICAgdWNwLT51Y19tY29udGV4dC54
NCA9IHZhX2FyZyAoYXAsIHVpbnRwdHJfdCk7CisgICAgICAgICAgYnJlYWs7
CisgICAgICAgIGNhc2UgNToKKyAgICAgICAgICB1Y3AtPnVjX21jb250ZXh0
Lng1ID0gdmFfYXJnIChhcCwgdWludHB0cl90KTsKKyAgICAgICAgICBicmVh
azsKKyAgICAgICAgY2FzZSA2OgorICAgICAgICAgIHVjcC0+dWNfbWNvbnRl
eHQueDYgPSB2YV9hcmcgKGFwLCB1aW50cHRyX3QpOworICAgICAgICAgIGJy
ZWFrOworICAgICAgICBjYXNlIDc6CisgICAgICAgICAgdWNwLT51Y19tY29u
dGV4dC54NyA9IHZhX2FyZyAoYXAsIHVpbnRwdHJfdCk7CisgICAgICAgICAg
YnJlYWs7CisgICAgICAgIGRlZmF1bHQ6CisgICAgICAgICAgLyogU3RhY2sg
YXJndW1lbnRzIGJleW9uZCB0aGUgZmlyc3QgOCByZWdpc3RlcnMuICovCisg
ICAgICAgICAgc3BbaSAtIDhdID0gdmFfYXJnIChhcCwgdWludHB0cl90KTsK
KyAgICAgICAgICBicmVhazsKKyAgICAgICAgfQogI2Vsc2UKICNlcnJvciB1
bmltcGxlbWVudGVkIGZvciB0aGlzIHRhcmdldAogI2VuZGlmCisgICAgfQog
ICB2YV9lbmQgKGFwKTsKLSAgLyogU3RvcmUgcG9pbnRlciB0byB1Y19saW5r
IGF0IHRoZSB0b3Agb2YgdGhlIHN0YWNrLiAqLworCisjaWYgZGVmaW5lZChf
X3g4Nl82NF9fKQorICAvKiBTdG9yZSBwb2ludGVyIHRvIHVjX2xpbmsgYXQg
c3BbYXJnYyArIDFdLCBhZnRlciByZXR1cm4gYWRkcmVzcworICAgICBhbmQg
YXJncy4gICovCiAgIHNwW2FyZ2MgKyAxXSA9ICh1aW50cHRyX3QpIHVjcC0+
dWNfbGluazsKKworI2VsaWYgZGVmaW5lZChfX2FhcmNoNjRfXykKKyAgLyog
U3RvcmUgcG9pbnRlciB0byB1Y19saW5rIGF0IHRoZSB0b3Agb2Ygb3VyIGFs
bG9jYXRlZCBhcmVhLiAqLworICBzcFtzdGFja19hcmdzXSA9ICh1aW50cHRy
X3QpIHVjcC0+dWNfbGluazsKKworI2Vsc2UKKyNlcnJvciB1bmltcGxlbWVu
dGVkIGZvciB0aGlzIHRhcmdldAorI2VuZGlmCisKICAgLyogTGFzdCBidXQg
bm90IGxlYXN0IHNldCB0aGUgcmVnaXN0ZXIgaW4gdGhlIGNvbnRleHQgYXQg
dWNwIHNvIHRoYXQgYQogICAgICBzdWJzZXF1ZW50IHNldGNvbnRleHQgb3Ig
c3dhcGNvbnRleHQgcGlja3MgdXAgdGhlIHJpZ2h0IHZhbHVlczoKICAgICAg
LSBTZXQgaW5zdHJ1Y3Rpb24gcG9pbnRlciB0byB0aGUgdGFyZ2V0IGZ1bmN0
aW9uLgogICAgICAtIFNldCBzdGFjayBwb2ludGVyIHRvIHRoZSBqdXN0IGNv
bXB1dGVkIHN0YWNrIHBvaW50ZXIgdmFsdWUuCiAgICAgIC0gU2V0IEN5Z3dp
bi1zcGVjaWZpYyB1Y2xpbmsgcmVnaXN0ZXIgdG8gdGhlIGFkZHJlc3Mgb2Yg
dGhlIHBvaW50ZXIKLSAgICAgICB0byB1Y19saW5rLiAqLworICAgICAgIHRv
IHVjX2xpbmsuCisKKyAgICAgeDg2XzY0OiB1Y2xpbmsgcmVnaXN0ZXIgaXMg
cmJ4IChjYWxsZWUtc2F2ZWQpCisgICAgIEFSTTY0OiAgdWNsaW5rIHJlZ2lz
dGVyIGlzIHgxOSAoY2FsbGVlLXNhdmVkKSAqLworCiAgIHVjcC0+dWNfbWNv
bnRleHQuX01DX2luc3RQdHIgPSAodWludDY0X3QpIGZ1bmM7CiAgIHVjcC0+
dWNfbWNvbnRleHQuX01DX3N0YWNrUHRyID0gKHVpbnQ2NF90KSBzcDsKKwor
I2lmIGRlZmluZWQoX194ODZfNjRfXykKICAgdWNwLT51Y19tY29udGV4dC5f
TUNfdWNsaW5rUmVnID0gKHVpbnQ2NF90KSAoc3AgKyBhcmdjICsgMSk7CisK
KyNlbGlmIGRlZmluZWQoX19hYXJjaDY0X18pCisgIC8qIFNldCBMUiB0byBf
X2NvbnRfbGlua19jb250ZXh0IGZvciBBUk02NCAodXNlZCBhcyByZXR1cm4g
YWRkcmVzcykuICovCisgIHVjcC0+dWNfbWNvbnRleHQubHIgPSAodWludDY0
X3QpIF9fY29udF9saW5rX2NvbnRleHQ7CisgIHVjcC0+dWNfbWNvbnRleHQu
X01DX3VjbGlua1JlZyA9ICh1aW50NjRfdCkgKHNwICsgc3RhY2tfYXJncyk7
CisKKyNlbHNlCisjZXJyb3IgdW5pbXBsZW1lbnRlZCBmb3IgdGhpcyB0YXJn
ZXQKKyNlbmRpZgogfQotLSAKMi41MC4xLndpbmRvd3MuMQoK

--_004_PN3P287MB132037F714481EAD3C475C65F7C12PN3P287MB1320INDP_--
