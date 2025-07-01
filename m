Return-Path: <SRS0=y+SQ=ZO=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c408::1])
	by sourceware.org (Postfix) with ESMTPS id 3B0543854A88
	for <cygwin-patches@cygwin.com>; Tue,  1 Jul 2025 09:25:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3B0543854A88
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3B0543854A88
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c408::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1751361927; cv=pass;
	b=QiUkiyEzdtGhTUlNfU3f1SQqDtaEIfeXPwaieJXzProCj/Y74KG/Z1a1fiiPSSENwNemCj1TibYW/7mVRA6++HrzfzeF7yhMmyacgcHvjtQEOfAzY4AejYR+nDEG/Qs9k9c+7iJvcA1h9SjSJ64I4Y8Gfn65ifacSHrTqZ8HUE4=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751361927; c=relaxed/simple;
	bh=OkS0N8sKwjU/B+r4AhlhUtoHl006Vvt+iTPQ+81AAYI=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=xkBVQfH9ZjAWgMXUCDQdG5ZouF/6SUrXoLK347c+Z7Wi60sxF09YX7rij5OAUQ9MUSqoxHDX46i58H9BzO4pJJIbq8uSm15bx4TpJHWny3hI/WF5OkzIqIvkIhRe1LN+QOfT+/WHLHWcKp+MTNlz+oynRxFztA+hjE2VJh9QTAo=
ARC-Authentication-Results: i=2; server2.sourceware.org
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D78WHGfblcDk1d3v7FH11IFX4Y6LwAxUQ0NFCfOdz4ofHtY3otUR4f2jVP+dVmC5Voj/USpI2uWvNIdqHOR2iXyp1OWj+4pB+a5e9C4Q7nevRlbEU1t/8Y2twgP4HAyJWs28kEm/5HncbAAq+A22xA1OZrd88arnn5m6Eh6tJkBGXpdTIXmYITJcqx4iTLG0puyMuOmy+M4wiJb+tGBPwGDAX9T1Pht4jxNKmkzwWW3ASXwkvcWO9oSNnycRauBnjp1oIySlJWV7k/WzI2cYOVIO6npNMlz8N2HLN9KN4eGouRu7feFT4zqo0C37WIlBBcjn2ct78K6I2tom7+/DOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMmOz8O+1o9n2VPSQc6OqM0gtpNkD/hqx6ml2L2dUlE=;
 b=ogEbk1cVbkAxexVe6d5j9MQqB6nWGrnHsPgA41/PjcqydqS4ElSC43P0VpYUl2ZefSYB5HzZ3jAggo++CybjoVzHf/EcUK6nIlRThTx+Zn0PK1vvrWktdEe33pzmfMHZBGAiIjy28V/Hloe3V7E8JKKQ+TR34dO1Pf6U38hRTnFgVNaFETxH7C1cyiE4Wi/eXKkEvhLK2IVaer24jEZUGeP1DOymTW/zzYWRNBr3ViArnqHvpsbb9OqUj44bQ4i4GgJfPddvHY9DLswJc0ESm/MFJKxXniyReC+6MMWKrH4rT0RMBb4h0k7W+PAR+msDuUuspWVs7JbnE935d/oJ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMmOz8O+1o9n2VPSQc6OqM0gtpNkD/hqx6ml2L2dUlE=;
 b=iPaf2ze2iwiUyGF0tP9G9D8Nb0/MbOO0DBBXvpd/dYveRuI7p0Cpmtb5lPw37zcFI+A6UR50vYRrZmpPjtSaFrgAUpSnrPLp24iPU+q2dQpoFimsjYUJvu2NB93l+fp/kakKZk5yzVbpRlkU/jiuNhuMPPFpcRpO1tgEiqrFvtqcpfnr1iG5y0aWfucEORZyy1MW5OCj8J5UyYre4fM+7XXCrpHdHoLkYgEnps5d+pDO3YQL10+g3uYwqSWGOmlq1Po0rwsKVsmISq8Aqk6sWz1Z3h8W2G4NbAK0DhPeQDP5TjMWGq9YIWUaaUXXFaC7996fLG2CHZpet7fecVtO1A==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by PN0P287MB0683.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:169::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Tue, 1 Jul
 2025 09:25:18 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362%3]) with mapi id 15.20.8880.029; Tue, 1 Jul 2025
 09:25:18 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: Jeremy Drake <cygwin@jdrake.com>
CC: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: RE: [PATCH] Aarch64: Fix register load order in `ldp` in commit
 f4ba145
Thread-Topic: [PATCH] Aarch64: Fix register load order in `ldp` in commit
 f4ba145
Thread-Index: Advl/GwKeLwEPPBoQJa3fUrayNfVSQAA8veAARpg6LA=
Date: Tue, 1 Jul 2025 09:25:17 +0000
Message-ID:
 <MA0P287MB308257317A27265A1520CAE39F41A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
References:
 <MA0P287MB3082CD4D85400059F59A3A449F7BA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
 <2d238391-3495-515a-2075-2d327508d793@jdrake.com>
In-Reply-To: <2d238391-3495-515a-2075-2d327508d793@jdrake.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|PN0P287MB0683:EE_
x-ms-office365-filtering-correlation-id: 6471b08b-61b3-429e-94c6-08ddb88131a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?mblRysRXOrh4cXIkyo66DowkwUhTvM/EzwJiNEjfmTQS317JADzoLGebj+sp?=
 =?us-ascii?Q?f6mxXB46dsN2TG2+PyjCHHmwpUWjjG/Aar8LsESV6KqvAxy1y0Zgp9182N5P?=
 =?us-ascii?Q?f/ACiImhmWHUgMV6p2TG2t3XG6neUmAebH7Z550D0m+I1iOOoQ2c5eTdtnj2?=
 =?us-ascii?Q?/ZFF/GfcjUc15bQc9gkWnj9qTjQmEAyoOn4F6Qf6ntNaQ8OCyS9nbgLqlesz?=
 =?us-ascii?Q?T8YOhIUMyQfvOtKweyh4lOWqQtHFRDYRnV9xfBRfKB6nQoAiS56aSrbC5TCh?=
 =?us-ascii?Q?x5C8trKNrnzHB+7M8aGEapZjJjK2+vOCK7Xm3oVzTk4Bsz8yVdhYLMMBm1k9?=
 =?us-ascii?Q?UsBC7SYlXIUKjU15kiN1IzGZDXvkCfpDCrGozgZa7QorQ62hNTsViGB7Hhfh?=
 =?us-ascii?Q?S0p5BQCPisJXcRZvyktaM/GV3M+J89S0l1Uzo3t6c2p6GqFB5IdyzBlY8zNf?=
 =?us-ascii?Q?UbQdNZRh+cC/GjYw6+i8p7EX8zw0iCwnxOyKLBLNFdDm3yv0o0N/N9ToL/1J?=
 =?us-ascii?Q?pogGVDZ78+n5AWNIuZI74DtXhZvSM4LHPDl0IoyZG4gJiubujlx94CB8fEua?=
 =?us-ascii?Q?qrCNzfwDfo+wQ8n6Xyqfug38pXkVe8gKIgyvDOcZWs4Cc/ccJElSF/7fF9qb?=
 =?us-ascii?Q?MEuuSJKSwyyHM4/ruThCulGpGwoAqU+mPMI64kUKIWSWkOPSzknf/4ePtDtq?=
 =?us-ascii?Q?ya3e4RUXRG+Xf/4gJFOTVyeYDGuayHfuk6gtZ3mzTfRCnRpY2Zf+KEc/tEJz?=
 =?us-ascii?Q?LffVnBt96wyeNWQCuvr5ladAyLG5z4W+TEe3Qo5aOhCQQaPdrKfooflhQNfO?=
 =?us-ascii?Q?Y1KwKRwqVMawfSgWeGTXZeY2eNmErujRYwO/Z3hprmPhguUVp5vvyBZwvpdC?=
 =?us-ascii?Q?kXEJ+qsYcFcznVVKYhALzC88lUsbjyDQ+TSCcoUCTVf0dOIkQqpbU7T8J5oT?=
 =?us-ascii?Q?ycwlDeOGMcx/toJUJjJntUlDiovFie0T3xXjKuf4PGHvEpmmcFjKGAr+5OY6?=
 =?us-ascii?Q?ITnYwgG8gnaNDAortTAygA9jl2poA1RYONuEd22SV84FDpQu4DhgQL39C6It?=
 =?us-ascii?Q?/QZSQLvzESiDIOQH20RetvYNdBgrHdeVVuC6tg6mEMeGg46HLLqXm1m/7/Wu?=
 =?us-ascii?Q?pTF1UE6jBlRrFihGt0B3hViSzyoh+lzp/WhBFg4Z6yBSTfiAIV6n84v8oHvw?=
 =?us-ascii?Q?33mC2j7w+erfbFddgKOB4uFL/Q28IY3BRFZBUFHe4s9vg4OcREdzefbjNPnm?=
 =?us-ascii?Q?lNb2A4DG2tVZAccdJGqR19c5UW1Xr3tE7L6OGFbGoM2dKZGsu/sklP65agoa?=
 =?us-ascii?Q?Jjizx3S1aMqJoyhZcamLu1PdJe6lm82nptkm6YcHtsQyWTRce9aAcb1ICRv0?=
 =?us-ascii?Q?HS9w6Vw452ftizCWWkiYcrWW4Ugnfep6ekEL3WST3bKvQdeNh2H30vSDHffK?=
 =?us-ascii?Q?ftoG7DOsVBjLErdYoUS5JgcWxbFj+HKKLOH9NOjorSREb7r2XKMqCw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?moUUhvoFn2JrzX05ZGw6Qj/63Av3LIxfed4GzvzexQYm8cEV5smhjPUFFgTA?=
 =?us-ascii?Q?Gga2aYnvqllMms3HzT/OOLc18/aAa5ub16SgVvE8Co4PmyK0/KxGuuPn2QZC?=
 =?us-ascii?Q?MKclVfa1p4zH9CcD3r94iApb6eGq1pt9GBYWMkxJ16JBbl7Acg8WOLQfB19D?=
 =?us-ascii?Q?zoZWKhr86hFmTHtXbVS1/PWxdlc64N3TzIzQanDcgvE1VHdgGoabsyiR+0rn?=
 =?us-ascii?Q?JCoqZwGACgbJiI0lFGFX00tNiY+CMo9dwnv+tq5ZdGUUj7eTBWhblm36L1+M?=
 =?us-ascii?Q?ZsZn+Vc/MBYqO77mbE8tGXeemp834gUzze7xuD5I/6YRoZEvMFyaiXtZl5MO?=
 =?us-ascii?Q?T8VjaRBNOVrDQyYPsJO+x4LIGIptQvn+l+EZVz2qjst+VGKkMplvdXXVoBX5?=
 =?us-ascii?Q?qy/qzLHHuUM/nA/HZVfAZUqigDRGQAFqz4ZMYxks0aEvnAk72SckTJ2VyLyZ?=
 =?us-ascii?Q?XwtqbWAkSZYFBdjPKhXqNAIjVeo9UuT2nPUhLlObIPSZ+ZjUB0ymTNqilS6h?=
 =?us-ascii?Q?Z3TPCMcZSZN66CD7alcSsc3sdKYW06NopFLx8a/TejJXjpkqtNtyJyShaEwB?=
 =?us-ascii?Q?5wCXUsRhDyZyx27TtEl4+a0xJ+/hHuaxruFjtOLg+wsDfoZ7PM9tDIA27oaL?=
 =?us-ascii?Q?PSxf9QBEaD/DJyrUhBqYiLd53Lk6nQiVtbEnqHSCXW5QO/GUv4ywdmiClPqt?=
 =?us-ascii?Q?Wa0DhqvkpgQZrZQvSKgUsG2rYDBxF57fjrQpFXy4CIiWplhOzwpCIRr1NWKb?=
 =?us-ascii?Q?v25aPaIMJ0OVgOrE9hDtQIhMnUfWeuLKhpOycHz7C2DB40GDH5lzYRCldu0M?=
 =?us-ascii?Q?FGot7a9GdEeWOa0QTrVshcRjCeeZ3KKO2lHkJdZFlynHaFxa0i3fS65jyybk?=
 =?us-ascii?Q?QxGmg8NY2ONfPY/dBxX2uzatPX601bzMtFxV+wzvyNa7dYdn4Y1semdmezoo?=
 =?us-ascii?Q?V9O+uZMX0hdEUTxc1LbVk8FUTrtiJZSm/abmu0b44TzM8wJ5a/hHmEMvYiok?=
 =?us-ascii?Q?m4ENwXERCDc2vjNswqTkAFc9kjOx+sx8uR2CJKnGxxaAQ16IMiJA24kcXuiy?=
 =?us-ascii?Q?rUIBJtDGE56pKvpowtmOXfVHBF/mnrNV97so17OCyKsR9gdIKTLLY7e4Ajdj?=
 =?us-ascii?Q?qtJAioqu+yGskcb3IaKbHmUcWKwDbVudiAJkJWA7MsSwvx8RbREeYZ0xpjsc?=
 =?us-ascii?Q?NNveeMwp3vRhzOs2PKhWetab3ITRa0eyM61XzurC5qPNoFJhbSx8SEeBBlkx?=
 =?us-ascii?Q?SH07uAGiPEoGPxdqJXwXo2zlTi/ORF5iS0yBQg4rqJo3KYy7J686gBnYIlbM?=
 =?us-ascii?Q?5WbCIFZMfpW8w0Rd2hTb53HcL8sLOd4ndxz01CKRLZSmvVk8F/2x0nOKMB9Z?=
 =?us-ascii?Q?v9REkkWWXk11/eI9XBE3j0f3pBwM892fE5qWL5Ei+13gkT3vu8ehzQm+EMnr?=
 =?us-ascii?Q?INGqz9DDQW3VDc5VpBKLUVuEyxcjIK7mQkdlgP7wQZWyktHetqFfwedNKUD9?=
 =?us-ascii?Q?5+HSLvsdoN+3/RU40aB+iJD0M6BCgB5dGSOffeBF04nLNWEFxCMTgjDJNL/O?=
 =?us-ascii?Q?3tQ3CiXUCfyy7qdEdLr81OjtrcKEXJ3FEUVpAy9MHQ054Guv7ZfT3PUfEB48?=
 =?us-ascii?Q?q5rvlbIpjZyDSM+l0Col0Lo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6471b08b-61b3-429e-94c6-08ddb88131a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2025 09:25:17.8969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QdnzZgNmQvkIojn/ERgyQBoh+/hzjzY1wnOpwx2rk3gI0ZGRLIFdSOPbaaG74EbnqVUK9EsrcEyFhjO470yXoUo2SW2eA3ekvsV+YQ5U3GOvZdMdL8aYNhNjASh2ZhYyV3F64MCOyUwBT142D62Fnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB0683
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hello,

Kindly accept my apologies, there was a misunderstanding regarding the earl=
ier patch, as we observed Cygwin tests failing in our arm64 environment, sp=
ecifically related to pthreads.
I request you to drop this patch. I will share a new patch that addresses t=
he pthread test failures on AArch64.

Thanks,
Thirumalai Nagalingam

-----Original Message-----
From: Jeremy Drake <cygwin@jdrake.com>=20
Sent: 26 June 2025 00:08
To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Aarch64: Fix register load order in `ldp` in commit f4=
ba145

On Wed, 25 Jun 2025, Thirumalai Nagalingam wrote:

> -      ldp     x0, x10, [x19, #16]  // x0 =3D stackaddr, x10 =3D stackbas=
e \n\
> +      ldp     x10, x0, [x19, #24]  // x0 =3D stackaddr, x10 =3D stackbas=
e \n\

I am very confused about this.

The struct layout:
struct pthread_wrapper_arg
{
  LPTHREAD_START_ROUTINE func; // +0
  PVOID arg;                   // +8
  PBYTE stackaddr;             // +16
  PBYTE stackbase;             // +24
  PBYTE stacklimit;            // +32
  ULONG guardsize;             // +40
};

below, you have
	   ldp     x19, x0, [x19]       // x19 =3D func, x0 =3D arg            \n\
	   blr     x19                  // call thread function            \n"

If this works (and it'd be really very obvious if it didn't), ldp loads 64-=
bits at the address given and puts it in the first register, and loads 64-b=
its at address+8 and puts it in the second register.  So wouldn't this real=
ly be

+      ldp     x10, x0, [x19, #24]  // x10 =3D stackbase, x0 =3D stacklimit=
 \n\

?

so now you're freeing stacklimit instead of stackbase?  I don't think that'=
s right.
