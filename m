Return-Path: <SRS0=H4g6=6Z=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazon11020120.outbound.protection.outlook.com [52.101.227.120])
	by sourceware.org (Postfix) with ESMTPS id 5D6914BA2E24
	for <cygwin-patches@cygwin.com>; Fri, 19 Dec 2025 17:30:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5D6914BA2E24
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5D6914BA2E24
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=52.101.227.120
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1766165412; cv=pass;
	b=mMQn2Z1jGDl5pMsXYhewsx35OFQJ/vC/juPCZo8YRFz/iPP/uYL8lYWHM0dgbO6T8LBW/iBGQ2f2B2QwnqQrU/wZPcur8p1ovQGo6gbe2ZkAqU55LMZX03H2moSekY4+fx5qidMoI4nJWMCptSCYsbW3tMSsSpCqh+PsqZEKatY=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766165412; c=relaxed/simple;
	bh=b8Tg2znEZyA6vnXvzqG0G7HOoaOQ1Ez1ii9x2gqIENU=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=fzS/albxqAjPEFidR3p8ghJigPBm+g4pqab8A4hf0zap8Jg6OgoWTJpRATk9mfpeY174o3VN8y2vQi74Dl0JmDQWFcV8OT//5+yV3MvbUVQHmxSISJLLIgRf3zJ1O5OwBf7Ckik2awBbA9b+r3Q9434hGLM+WS543GBREc283II=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5D6914BA2E24
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=My9O/8Ie
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZK5z9s8diaAR+838NYNuDligBpUqUrjrLUvtkTgTO7P6Nt/UaDLX+wZiw/UQnGpc9nXzP2p18Vzu8vqctZqmAvsaYRAuHTcfPxpv9AZisOng/pt/2Qp2fpojLcA2CMsoQQ9L8yv4r+G6Ne+JDLJn2495OEE417uOcKpmDucbKwYUZCikaDhynKE5jt7DgeFhWVoX146HysQDTC4iSa+vbicgzDcFDtj4Qwli71BFtOBHKvMcGlxFiV8MIAyRbbAEt+/nEm7BhV5kzLa7dTu9AThsTTMyy8IyynmapIZwsft1Fh4catol+Pekk766gtAkHo7zc8ODB1WJRYWN9WtBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOmJVNL7ohv/CtZUnDKV26pzo1KywmgyPXQuEb3GgaY=;
 b=kKCD9iOyYv94FzV/A4++0rgpjFH95CPq3rRdC5qRbw1hYr/a5pgsqOTr8soQwUnH59ENmYqTl20uehreqcsGGry1z5DtSGtQ3N2l6jmca0iwFbYtZmWvjgzvoQCdT18IzA0TMvnRbYnosFSJwD6j6krK5JZaE/cLqpv7P4VlskAEeo/aoaDOlX3uutpyoV3IgMq1MmLqsLl9PdYokZGajzEeCy2W9uGCrwVCxZ+QLVjo2CrzrLFfdLf4GXupurrGVn+1laAtcgXgm9JXyaNdT823xddQja6sAhQv3ILJMseaOlHRO0ZkEvtJNKJuMpHGA5l7zs6B/J7ww5dtM7Q02A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOmJVNL7ohv/CtZUnDKV26pzo1KywmgyPXQuEb3GgaY=;
 b=My9O/8Iei0qeU9S6rHqOTRxAGd2B6J3EUZylLLKBm1R7iulkAIdUrCD7Bbsw8vhZGcTfJ2iND6grr+GsvflICZXf253VoYdfhqauNrP2QXHT9wwsc2HnRNyD5/KNBwqca80RbKwDUmmQME+Dqa0OWAzgd0RPuhZfvsHACmn6PfvmuZsvYAwtaLC75t/jc9lPXl5/4nlK/Xnf/bYk/zXnBdOM4O5LVYfTwgbM3xpnjAPwhZdglx22JGzvHoG8x/KpD4EoBZSQnlRhD7/6Rnv67WTJstCyj0oCMGDmfKHXAaMrLDmMA/h+fR4KVDumFUCMCVLLrZ8lvcugT8UauTfSJg==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by PN0P287MB0704.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:160::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 17:30:08 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362%6]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 17:30:08 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: gendef: add _sigfe_maybe for TLS initialization
Thread-Topic: [PATCH] Cygwin: gendef: add _sigfe_maybe for TLS initialization
Thread-Index: AdxxC5rL1YEI68fkR6yzNJ2cppgO0A==
Date: Fri, 19 Dec 2025 17:30:00 +0000
Message-ID:
 <MA0P287MB3082181CE402F12F043C3A0B9FA9A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|PN0P287MB0704:EE_
x-ms-office365-filtering-correlation-id: 972f6c4d-52b6-471f-877b-08de3f2441ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|4053099003|38070700021|8096899003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?VtING7wtrZ3EYYlRzwrqfa8EXf5Hj0WpDiAde7kQgh4x14b1CgXn6uk1KKEB?=
 =?us-ascii?Q?W+n6ZjW8GkFt5YlKYw5HTxuFeI1Wj2Cv68KSppWIe1RAppuPGOi0euX+XGwP?=
 =?us-ascii?Q?cflw3Gv694rIBLB9QmZElObAP6GVZl4wq6ZeyXU5nY2qFN8ICFWSYN1Lwn2D?=
 =?us-ascii?Q?PQSl9HMP+NUIkKYPFASsh13pl4NlnVC7r6hc+dzpwTSqVp8U15lIoMQaDhPY?=
 =?us-ascii?Q?al/BSmEI6oOqHAJVWsg81liHKsVgqSkfdqyKzo00fDYnPZJmwuFS7vM9MQNE?=
 =?us-ascii?Q?3Dda0RrXlZ7NNgkTeHjjtrjVydD4yAwb3jrLWlfKf6zfHXoeGp8hsc0PQt2h?=
 =?us-ascii?Q?y7IVxNDxNNyC5xIcnBMEmRrlPHTXDfjp5suDP+deX0zbFrbqm+3s2NYBJASw?=
 =?us-ascii?Q?52tqoU5gDVrE8HuhN+d9eT2IhzrAeHg+N2dTjOSTKehZGEoRV73IJAc0lv/W?=
 =?us-ascii?Q?CedOe0RBFgUp68TnIysWpx4prsoIPvCR/dJJ+C/zJlLezTwxQazjmIQ+m5vI?=
 =?us-ascii?Q?LENnOybFSDScioQiGp8f8G2R1jlPa+4NYao7FarME+R58OgDAv9ccKkKwazb?=
 =?us-ascii?Q?VNko73mOfoD7POD2+UsId8NJTn4yIdJPiKSbwW+vd+hHN0aezaHatutRUOIQ?=
 =?us-ascii?Q?/FHBqPFnD7oSyVjWIbOIaWe3azoECMOBWsOQLxkoNMv2IE9cbnzsCYiwJu73?=
 =?us-ascii?Q?KIj2Oyo6FYF2R26lOWOKEJ0BcY62sVarcXeWKtq+PbggVV6t5ahOe6UvxxPQ?=
 =?us-ascii?Q?uc1bIYqlOALglklSbsB83ohNhYCQparZspDWLdTlL/DTVah8vlkjKILY+FZX?=
 =?us-ascii?Q?+WeRJAmwYXwvX6Gpy1MUtLAElZNCzxQ0i8oIEKscVxHqIjC20eRC6jMjF3/a?=
 =?us-ascii?Q?oDWaCNVKdnMPtxZ0qwb3hlubW/zMZHq0foizqR3Ox/iw0Jmn7kGsF54yujXw?=
 =?us-ascii?Q?z0eHfsE00ucUv057/blWdpOmzEHNQUItzhDedw7Dq43uuy+nGapoFA2MCzcf?=
 =?us-ascii?Q?2IUqoTdIlWDXDnQ1mBUt2EK+ndjdYJNGdDiA7/mggKzriurC7M9p/c9gq+rW?=
 =?us-ascii?Q?8ilNtWKJPqxUx9EZRsjle/+NpoGJFyW+c9xleFwzN5mogG/YniMyVtxoArzu?=
 =?us-ascii?Q?rXBo03ah1HzUPGfQUyH+vNsv3TzRP9+I8dgysi90jf+f+xej/uvZ9KXD0YAk?=
 =?us-ascii?Q?yYb2yvHdVvRvWCtAvDsdwVomFm5rMobUKcLIAYm1u5rmLuzKAKaMVNv+FAvG?=
 =?us-ascii?Q?B/1SqG52OGRfWuxpKYmYtyUQqOghzaMcyFuOx4bP2Nv1eGQGL6/5LEB42u/k?=
 =?us-ascii?Q?mlzdD//KIxrdB5RVDRDXZENCbCRNv9rMJeMlUgogsfGb13cWsphHNFaQJ5Tt?=
 =?us-ascii?Q?S6bcu+j1GWqLNbsJz5IW1pKUp4i7PdbpWdvG244Tq/217l9nn7KgiZ49VoWG?=
 =?us-ascii?Q?VFZxLf6h8CL/z4Bk62oTTxjyEO7UjfNl0CGgIUU0oNvb8Xuht6mY567BIg90?=
 =?us-ascii?Q?1Ap8waKVMIiuHmQ5yaBLyfY48p/K961qYzYG?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(4053099003)(38070700021)(8096899003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jj/v6G2nPorXwHajUy8k9MlYxnT62cziOr61fPYA+rRCw62Q+IEebFcZU1Vh?=
 =?us-ascii?Q?PokJSM+aWwmhc+Gv7K4RlyqB6IIaUdjtwhqJ1yY4vJ1OdL/K7mY+sVgSKfaj?=
 =?us-ascii?Q?jOHsqPG5hDjM5bPjob1/zgg4aiuqvlzrJERipxo1gKJtDrsnLbG7qWaOTjMG?=
 =?us-ascii?Q?RE54Q9ZkhYqafjRMNxri2qGO38hPBd/SN7Qgp9QgJ5s6xQZXPhSlUrtUNSXT?=
 =?us-ascii?Q?lBkvBkkzKYwfqI/NiuustgjXUS5N8pJVGxa1om9GI1OurNuuaxvYMKYvo3Hn?=
 =?us-ascii?Q?JD0v72V7WeUSBtPbCI7qV9s2c8TnH9VYfVrIakCRaa1Ea7D5oaJb1XxsL1Xo?=
 =?us-ascii?Q?uOeKlfd/L92JY7N7O4KUPYVC9dO52Oa9jTrg1cIfPcIHV71mUH18wN7cEc3B?=
 =?us-ascii?Q?tSWapiCHkkcwKaj9VjdhKoB+iJ/jS6cw/p3Hk0Ad/ErNDZ64LSzvUvhMXkX4?=
 =?us-ascii?Q?MFnarczR+Xp5+gU/cfI1ZuRFBfgSGDY1RpKElUwwnRwnx1hyKPjc3x8IR8tg?=
 =?us-ascii?Q?HVznsSjTRO5QdeySy4K+yqAam1rRvfNcKQPMXPmxb+6XTusayRXp41ec6bOP?=
 =?us-ascii?Q?kBb/Vij23pnotYAC68Xk3zKbbKRM/w0t15F1O06NX0fVrPjEqlNBuyQPlqKU?=
 =?us-ascii?Q?vgroQ94pP8VRMUb99RX4Y/VA3QuYHBCGwvNi2dd7bVWJv4x/i7XfLiNdQgn4?=
 =?us-ascii?Q?qJCPHdj7kL1auPgQyjwpIjEVFFfZ5tPqZrX+EftIkxp5oXSRCu7FoGAYz6WX?=
 =?us-ascii?Q?3/KUftujgYO5lv3mJNBjhea0yl4GGe4EPX4r/8M8wjIA7te4Mv5Vk4x0bZPm?=
 =?us-ascii?Q?P/aipKGTQTuMQmbSQXjE0IsBd9GNKwV9EvF6XOGBf6/6ynTCquT+/s9pqxvE?=
 =?us-ascii?Q?me2aLrONTYFfO4GgsIangyO2mo4JDBn9uIcxzPCjRib2jNSQeKg7BYiCy5yI?=
 =?us-ascii?Q?deOleVZn+43xhaxveCg0ggI2TB4tKsN8jyz2uxuYFGG5bYRsaXqe0Omz1i9Q?=
 =?us-ascii?Q?weiUz+gho0oV+GQc4E3BXJoy6BwwomtM+4VIRR2BsQFJ3zkUK6uMVUe1sHpL?=
 =?us-ascii?Q?Xzr1BBeI6RMvbpXgOW5bnsMegjpK2bvHm0zq5TAIAyZBCja9nEtuYzT3I4lW?=
 =?us-ascii?Q?3y/du21c7W37vx7DvnlnqTgdVC0eGBULgPLu56ZOmZU9qlNpE1xUescWVG73?=
 =?us-ascii?Q?rlnb2dJWgtTlBRudqpikvDXoDTnOrF5gaCNxn3LA14AAPft5nrJC/IUwFbIz?=
 =?us-ascii?Q?GOwyvEEvemDsubvf6mWTQfcv/7rWvpOyRYBhzmgQdn31dYkEYt3RiruVI7Hl?=
 =?us-ascii?Q?KPTwZQy1eaYji1baK6DXMLdqEriSa4MbgsBbcoRcJg/LynB20oTLvmNUQuI3?=
 =?us-ascii?Q?YkqGx5aNpGBV273041tiR72I3BrQ6xVSxgqiqivFVshtlCJdXKghOSef0rIa?=
 =?us-ascii?Q?6su42Tyq23rDXHCTEyKuGSOF/Af2KydzaadIKxk6oGE5Mhpsb4rZ7XNoXovc?=
 =?us-ascii?Q?CovuNSKZA3L+ukxKOIbFpUgcjOMwi/EhvirXsiGAXYxzn3Z1zG2GRc7Og7HK?=
 =?us-ascii?Q?sWJ8cs3klorVylgZeWD9Dg5Ge+MGACN5e2Ti0A7Dn1vNZBsMk1C1QHnnhOAz?=
 =?us-ascii?Q?cwOba1kzsEVCnjb6WtPNd1nNT1cU77NcJIrHCxjo722NIwzwzG5DHTEtyR9J?=
 =?us-ascii?Q?BgARmFS+KMoTjD+BqP//uSy8DginGbmMi9nUBLX27X0Rp7UuQHJhfbcQBnEq?=
 =?us-ascii?Q?CNoQI/3jCdik4MflrHiDsD7Pm0hsVAsU1wE1eAuacCVBfrRsjkLbpLVgGb7U?=
x-ms-exchange-antispam-messagedata-1:
 D9ecXv2YSTjLv5wTbIv3uGMT2tpaGSkXZnUPGYBvDALF+webhWiPyJL+
Content-Type: multipart/mixed;
	boundary="_004_MA0P287MB3082181CE402F12F043C3A0B9FA9AMA0P287MB3082INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 972f6c4d-52b6-471f-877b-08de3f2441ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2025 17:30:08.5877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YyzynlKvNpahJfWM0fuH0vveXHFTlq5qgLmoCVrOD4MFECYTenTHZSuFdzgnJI87gYJewlLkxRmDWMxa8hVhX/8TTBy8ye7aLcrSluT2rhwJeqTTfX0UOOgWi2dZx2l8JpXqdcZyuVgfMUBttaR14w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB0704
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_MA0P287MB3082181CE402F12F043C3A0B9FA9AMA0P287MB3082INDP_
Content-Type: multipart/alternative;
	boundary="_000_MA0P287MB3082181CE402F12F043C3A0B9FA9AMA0P287MB3082INDP_"

--_000_MA0P287MB3082181CE402F12F043C3A0B9FA9AMA0P287MB3082INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

Please find the attached patch which adds an ARM64 stub for the _sigfe_mayb=
e routine
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
index 1419704b8..52a5b77ca 100755
--- a/winsup/cygwin/scripts/gendef
+++ b/winsup/cygwin/scripts/gendef
@@ -367,8 +367,24 @@ EOF
        .include "tlsoffsets"
        .text

-_sigfe_maybe:
-       .global _sigbe
+       .seh_proc _sigfe_maybe
+_sigfe_maybe:                                  # stack is aligned on entry!
+       .seh_endprologue
+       ldr     x10, [x18, #0x8]                // Load TEB pointer in x10
+       ldr     x11, =3D_cygtls.initialized       // Load relative offset o=
f _cygtls.initialized
+       add     x11, x10, x11                   // compute absolute address=
 and store in x11
+       cmp     sp, x11                         // Compare current stack po=
inter with TLS location
+       b.hs    0f                              // if sp >=3D tls, skip TLS=
 logic
+       ldr     w12, [x11]                      // Load the value at _cygtl=
s.initialized (32-bit)
+       movz    w13, #0xc763                    // Prepare magic value(0xc7=
63173f) lower 16 bits
+       movk    w13, #0x173f, lsl #16           // Add upper 16 bits, full =
value now in w13
+       cmp     w12, w13                        // Compare loaded value wit=
h magic
+       b.ne    0f                              // If not equal, not initia=
lized, skip TLS logic
+       ret
+0:
+       ret
+       .seh_endproc
+
 _sigfe:
 _sigbe:
        .global sigdelayed
--

--_000_MA0P287MB3082181CE402F12F043C3A0B9FA9AMA0P287MB3082INDP_--

--_004_MA0P287MB3082181CE402F12F043C3A0B9FA9AMA0P287MB3082INDP_
Content-Type: application/octet-stream;
	name="0002-Cygwin-gendef-add-_sigfe_maybe-for-TLS-initializatio.patch"
Content-Description:
 0002-Cygwin-gendef-add-_sigfe_maybe-for-TLS-initializatio.patch
Content-Disposition: attachment;
	filename="0002-Cygwin-gendef-add-_sigfe_maybe-for-TLS-initializatio.patch";
	size=1679; creation-date="Fri, 19 Dec 2025 17:21:45 GMT";
	modification-date="Fri, 19 Dec 2025 17:24:06 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiODBlM2NlYjNmZDhlZjY2OGQyZTBmZDBhMzhhNzU1MzFmNmViYjhj
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5h
Z2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJl
aW5jLmNvbT4KRGF0ZTogU2F0LCA2IERlYyAyMDI1IDE5OjE0OjU2ICswNTMw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBnZW5kZWY6IGFkZCBfc2lnZmVf
bWF5YmUgZm9yIFRMUyBpbml0aWFsaXphdGlvbgogY2hlY2tzIG9uIEFBcmNo
NjQKClNpZ25lZC1vZmYtYnk6IFRoaXJ1bWFsYWkgTmFnYWxpbmdhbSA8dGhp
cnVtYWxhaS5uYWdhbGluZ2FtQG11bHRpY29yZXdhcmVpbmMuY29tPgotLS0K
IHdpbnN1cC9jeWd3aW4vc2NyaXB0cy9nZW5kZWYgfCAyMCArKysrKysrKysr
KysrKysrKystLQogMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9z
Y3JpcHRzL2dlbmRlZiBiL3dpbnN1cC9jeWd3aW4vc2NyaXB0cy9nZW5kZWYK
aW5kZXggMTQxOTcwNGI4Li41MmE1Yjc3Y2EgMTAwNzU1Ci0tLSBhL3dpbnN1
cC9jeWd3aW4vc2NyaXB0cy9nZW5kZWYKKysrIGIvd2luc3VwL2N5Z3dpbi9z
Y3JpcHRzL2dlbmRlZgpAQCAtMzY3LDggKzM2NywyNCBAQCBFT0YKIAkuaW5j
bHVkZSAidGxzb2Zmc2V0cyIKIAkudGV4dAoKLV9zaWdmZV9tYXliZToKLQku
Z2xvYmFsIF9zaWdiZQorCS5zZWhfcHJvYyBfc2lnZmVfbWF5YmUKK19zaWdm
ZV9tYXliZToJCQkJCSMgc3RhY2sgaXMgYWxpZ25lZCBvbiBlbnRyeSEKKwku
c2VoX2VuZHByb2xvZ3VlCisJbGRyICAgICB4MTAsIFt4MTgsICMweDhdCQkv
LyBMb2FkIFRFQiBwb2ludGVyIGluIHgxMAorCWxkciAgICAgeDExLCA9X2N5
Z3Rscy5pbml0aWFsaXplZAkvLyBMb2FkIHJlbGF0aXZlIG9mZnNldCBvZiBf
Y3lndGxzLmluaXRpYWxpemVkCisJYWRkICAgICB4MTEsIHgxMCwgeDExICAg
ICAgICAgICAgICAgICAgCS8vIGNvbXB1dGUgYWJzb2x1dGUgYWRkcmVzcyBh
bmQgc3RvcmUgaW4geDExCisJY21wICAgICBzcCwgeDExCQkJCS8vIENvbXBh
cmUgY3VycmVudCBzdGFjayBwb2ludGVyIHdpdGggVExTIGxvY2F0aW9uCisJ
Yi5ocyAgICAwZiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCS8vIGlm
IHNwID49IHRscywgc2tpcCBUTFMgbG9naWMKKwlsZHIgICAgIHcxMiwgW3gx
MV0gICAgICAgICAgICAgICAgICAgIAkvLyBMb2FkIHRoZSB2YWx1ZSBhdCBf
Y3lndGxzLmluaXRpYWxpemVkICgzMi1iaXQpCisJbW92eiAgICB3MTMsICMw
eGM3NjMJCQkvLyBQcmVwYXJlIG1hZ2ljIHZhbHVlKDB4Yzc2MzE3M2YpIGxv
d2VyIDE2IGJpdHMKKwltb3ZrICAgIHcxMywgIzB4MTczZiwgbHNsICMxNgkJ
Ly8gQWRkIHVwcGVyIDE2IGJpdHMsIGZ1bGwgdmFsdWUgbm93IGluIHcxMwor
CWNtcCAgICAgdzEyLCB3MTMJCQkvLyBDb21wYXJlIGxvYWRlZCB2YWx1ZSB3
aXRoIG1hZ2ljCisJYi5uZSAgICAwZiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIC8vIElmIG5vdCBlcXVhbCwgbm90IGluaXRpYWxpemVkLCBza2lw
IFRMUyBsb2dpYworCXJldAorMDoKKwlyZXQKKwkuc2VoX2VuZHByb2MKKwog
X3NpZ2ZlOgogX3NpZ2JlOgogCS5nbG9iYWwJc2lnZGVsYXllZAotLQoyLjUy
LjAud2luZG93cy4xCgo=

--_004_MA0P287MB3082181CE402F12F043C3A0B9FA9AMA0P287MB3082INDP_--
