Return-Path: <SRS0=kNIP=2F=microsoft.com=radek.barton@sourceware.org>
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on20708.outbound.protection.outlook.com [IPv6:2a01:111:f403:2612::708])
	by sourceware.org (Postfix) with ESMTPS id EDD983858D35
	for <cygwin-patches@cygwin.com>; Thu, 24 Jul 2025 10:52:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EDD983858D35
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EDD983858D35
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2612::708
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1753354332; cv=pass;
	b=EI53WOWPLa6Z7Rl9D6M/CWuHfDJ5i/razpF7bw7PptSxRXMYJ8Gs1bGdTn3TVG90ZHq8+Pxpo3gsJ/A4+7N91pOvEI+/ncq19NROgngd1rrX3yAZs1Egrpg+2gW8s4n69Df2e/r1LC7rHNSoEGMx6jTWje4Pd7izp07TqJrp6VI=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753354332; c=relaxed/simple;
	bh=fYGk3dZUGuE2Tw8ge8l/Oq/A/jQOzLcVOgYUdZoMfTw=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=RyyzTKAKh9Lc+jifvbrSA8kSH922U90p8T/FDVUeSAbhvZ+q4jMH1coMJl76Os6n32NXl1v8V0bDCu7VbwsNIL0t4hwAtXLo6+nV7wLASc2oaj20WvFwUDOQu7XtJw9tZE9+XSO0bj2KFAjdk6CrLAHR+7fzBZbr08Y5/l+gHk8=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EDD983858D35
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=cdVW1As6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/KNWlfxfiJSvm/c1TgLtMDXs76SbTj9z7RFibNOwffAUN5kDI64qeKHP8qrFnYRZRThtTRwcpKjZHoUcmo+fbumn8V7FP73VQHEYUk4CK3gsnC9XdqFCkjs9ibUxfTcJqv4J/XJoi6FxAfV9F4Kf+0Q+KVWltN7MTTQHBcovaheFju/JcF/WA1atgAsem1nH8MGbldk1TF7kLed1YGpt/84oBg2eDQQUKZS5e8cOaEVcb86AsAE7Zp6jqYzgmuYH4Rgv4XpZO+X/K+bJMy7m+uVMmbcHBy+oenSRLK5TFQVIDatz5Qa3oEwvhsgo2hKtxhKbW64RVzhhItdUWzOwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FW4WKfKbJClkSmHboTO4xWd05/S0LA503d2HDIG/Ih8=;
 b=GBmnbIOV1eQ+7CZHwlpvHm/sM9BaEEd2A4Y6yXmV5SIiCmytFn+9kh+ebQhWjAf3Ep7oJkIs1nT7nbATM/GXbYVHdcFbmp0KDY8Fv5ady4FRbtDMEmIZVlIj2m5qy8uu1qcuY4yM5ynU76OD2R4b15XJtc2DewJ1nY2PNWX8rxwPrLfuRpFCwKY0FL63UuCKjNKlreB/c1l1Go08gsc2l9giMrkpP9UUu4zAGmLP99NWgimcyqcHRCC0LhiD8RwbFuLe3m8a3aE+IiMd72wWPoaACwHv6Z7BLIcnaHSPqRWifd7NXG1avHQtHt/AulE3e9SwGsHXc182fnIT5p3vig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FW4WKfKbJClkSmHboTO4xWd05/S0LA503d2HDIG/Ih8=;
 b=cdVW1As61r2vcliBamgQvDhv/jUgjfI9W972QBx8N1mkJBr7wFx8SLh+2nptIbCF1rPBqE4IBLbtqGouk+F97WzMcG8dghIqCH8GKxGLK+mCSSipSflyhFW7Bdo7pkmSR/5GMf/e/CS+mSKkAFupq4G2jJLMlw5GBs1jMFivcCo=
Received: from GV4PR83MB0941.EURPRD83.prod.outlook.com (2603:10a6:150:27e::22)
 by DU6PR83MB0851.EURPRD83.prod.outlook.com (2603:10a6:10:5c4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.15; Thu, 24 Jul
 2025 10:52:09 +0000
Received: from GV4PR83MB0941.EURPRD83.prod.outlook.com
 ([fe80::db38:300c:f561:a48a]) by GV4PR83MB0941.EURPRD83.prod.outlook.com
 ([fe80::db38:300c:f561:a48a%3]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 10:52:08 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: Jeremy Drake <cygwin@jdrake.com>
Subject: [PATCH v3] Cygwin: mkimport: implement AArch64 +/-4GB relocations
Thread-Topic: [PATCH v3] Cygwin: mkimport: implement AArch64 +/-4GB
 relocations
Thread-Index: AQHb/IkA5XvCFL5BNU+9p0/gBNdyHA==
Date: Thu, 24 Jul 2025 10:52:08 +0000
Message-ID:
 <GV4PR83MB0941BC79A50B76470922FE38925EA@GV4PR83MB0941.EURPRD83.prod.outlook.com>
References:
 <DB9PR83MB0923E3D187978CF43940B188925DA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aH4NM_WJNC2KHpHT@calimero.vinschen.de>
 <23af2767-7e76-74fd-198f-2abdee7cc73e@jdrake.com>
 <GV4PR83MB0941B168699D42E77A73814F925CA@GV4PR83MB0941.EURPRD83.prod.outlook.com>
 <aH9Pi6bJNDa_Q7V1@calimero.vinschen.de>
 <GV4PR83MB09417042234459A19594C15C925CA@GV4PR83MB0941.EURPRD83.prod.outlook.com>
 <aH9jZCS92AGUaP-o@calimero.vinschen.de>
 <b76de53a-24a7-0983-c756-2fd7213950f2@jdrake.com>
 <aICZuCg3tKXOj_mR@calimero.vinschen.de>
 <GV4PR83MB0941AA5AD0E67B89787B1FE0925EA@GV4PR83MB0941.EURPRD83.prod.outlook.com>
 <aIIM-ZOEUZDsq-og@calimero.vinschen.de>
In-Reply-To: <aIIM-ZOEUZDsq-og@calimero.vinschen.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-24T10:52:07.125Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV4PR83MB0941:EE_|DU6PR83MB0851:EE_
x-ms-office365-filtering-correlation-id: 01c79dc3-8328-4f50-9c75-08ddcaa022b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?DAcmqqeGwsiPkflxurlhMR1luU8nnhVNWJKtjw3JfAmRD8PuxzLO4B79QR?=
 =?iso-8859-2?Q?TbA3hrQk2V+eeR/o0wO85aQbihrpMq9Yi222P0fndUEFEwk+Zij7ptKHee?=
 =?iso-8859-2?Q?SUcsMNDJ3uevNrUAOWRBdHl8PhUrilP/JICfWrWhQNoLlpTmlBBEeECm3U?=
 =?iso-8859-2?Q?pT6jeNF4/sZmTp3CffLsHnup1qjJ1X57X7Ks7HmHfxAKWGnOnBhb6vo2jp?=
 =?iso-8859-2?Q?25gQbJeWnHxbIy6zDUhRPRlUmqMGeXxQRomiNeLiY2PcIOPdC4SdH2UJIi?=
 =?iso-8859-2?Q?sPLVVkXYMwbSJ2uzh8hcGpACI3huM1pn2/Pz41X4maKSUTtX2c/fuUUeur?=
 =?iso-8859-2?Q?D9jmxh8UqYLc9dDkwtgLuqo8uYIwGVB7V6GQIqn5pphzMKXK8L/BDLkrpj?=
 =?iso-8859-2?Q?01S3Edt1IeJuDkLmcrBqtRZ5nioObr/9Q8q6GqBeaCmsVmk4GWRrB+gdqY?=
 =?iso-8859-2?Q?QRCtQyEAX9jHxI5r9i2PqHiidUEOratz1nIWlYoXTEW/+fBxfpFTXfx4lY?=
 =?iso-8859-2?Q?W9CEPHyNC0S7r31KRdX6dXcxBM0aJelCB8E+kQ6jjiHhotLNjPilgVNGpH?=
 =?iso-8859-2?Q?eoeFTA9Bnf8+XpJQ+DRGFjb8+T5f3ldeW18A/xIzRo/hBmDkAYU9DUWF3C?=
 =?iso-8859-2?Q?h+dp3OQH+LWC51etazs6MPTCLLlmsOwe2LbZfiZFy+AbMwogiAFNu4GNZI?=
 =?iso-8859-2?Q?X447zvRLglTA6r0B7oQOLH/HxDs1rgBhmkU6RknHdbGUGWxnn/ys5GBNxN?=
 =?iso-8859-2?Q?dcSmbHW/iSNESsyy/5TG2Vesi/DGeUQBY73YYHLiUU6rwrERRhavdTaDNA?=
 =?iso-8859-2?Q?w2s0GAwQuhkdwWJONn4GvE/bSE3raSJ+BufwlYtaINip7lAOEpFFuSHL6f?=
 =?iso-8859-2?Q?jalKBLEVWuoKRvgsicJgNFdzkWGun4ul1x95ejJfOv2jiKZ0JHd8d97g+t?=
 =?iso-8859-2?Q?Byz5MdflsK43yhXEpmgXpmoR4X1AE3wIERDcggb+0hX4/6Q7zZgyVncYNf?=
 =?iso-8859-2?Q?f4WXkD68B4y5aCrKd0isnKMgdSsHUG838kf71eHt5YqvTcA4PUXYt5Nvco?=
 =?iso-8859-2?Q?2NQIj4JFrm4ErLDzYPbFBtPVPTvNLe8Z3xJyrqo5x7N16z4DZgP8zF42e8?=
 =?iso-8859-2?Q?eAsNQdUVJNsIXs9+1awiaFzmUUuoDBBm7T7WG90iuM7mPKIFl374QFpMYD?=
 =?iso-8859-2?Q?1NhXt9/eXGB5+WyW8C69HXvj2n5tQUzt5Iu6fLYCimSTyqzjOvKHGXWRk/?=
 =?iso-8859-2?Q?GwB6BDuJ8d47c05IvgKBqkUcWcJ5ed8eXeuZ4NXiGs9Y7YQL7KgJqAxRxn?=
 =?iso-8859-2?Q?ME/0pooKME3GdAhz9rivGU1TnRffdjQWZURdo9m19tEhfV7j5myqxDcsdT?=
 =?iso-8859-2?Q?98k5fEy1x2kxzPCQStIoOBFEESdAvUBWga8v7XPyDW5r2NHyxsyDIH6U26?=
 =?iso-8859-2?Q?L6bSzga8crSBUw7zsEGcemZg0MihgVNJ6hKoaFkPsV6TLkuvjrLHpHMcnY?=
 =?iso-8859-2?Q?Q=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV4PR83MB0941.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?Pjcaef62w4XD3oUHLdTvIstN28F0Fh3h2oKhbz2Tj8JEJCMsUklQqfHmS5?=
 =?iso-8859-2?Q?AN/NmKqqk8rHxjK7GYvjCTmhknj1gO6WLOfvatljWM4bKKgEzLa/1uY2J/?=
 =?iso-8859-2?Q?tciFUhWtEXR975OcoVxgjwnY7+EyoRkvAnkA6se+9dIyto5BUc3GCWLCyz?=
 =?iso-8859-2?Q?EPG2XE5Q0xOv7NO3sW1BAZB375fU5FAPxDvrstgLPFUXQOvuR+tUMNXF8h?=
 =?iso-8859-2?Q?uaeoYV2ajSJiXPF5XeQaxrZpP5B4MC3+CkHrs7N1oawb95Fc4m7qrFzKlc?=
 =?iso-8859-2?Q?jRNqxJI/EqjHSo+FHHLCOkMLlc3lo0LrM5w6xEXuec0Fumt5eyaM8SXegc?=
 =?iso-8859-2?Q?fS0lhidyJuwZO0OuwgLOLziFDinpo4dnJUUQKE4SUsW3AeFGO6b1v9nlo/?=
 =?iso-8859-2?Q?N7aFyZNycpnGmg0iJkp864kYBO7uSXJ3Idcg+nkQxcFNl5wjCth63SNPkZ?=
 =?iso-8859-2?Q?lEnrqyNEmM9Lr5tFn9YVAWM/tZUXxPgVZfFmByaSoydpgbycgN3Qd1e1EV?=
 =?iso-8859-2?Q?ckc14RPatfvljRz1Lq4XCrm99xdNiZtNN9SEqhHWD6HhoSdwflqSowWFZo?=
 =?iso-8859-2?Q?gVQnLPB6qsrqTwMwntjeX4Yl0gYQAeDzZtJl3pBnyMgU+EAgN29m5GZ60d?=
 =?iso-8859-2?Q?ISct8wDd8yrFIop1dbOpwlgyk1JqnMAU+lqsfiD7t6SfX2Hhr19j5NsNQr?=
 =?iso-8859-2?Q?itIe5+iKsfR8kgHgsDjca0GUJx0oK3v+OGjXZHsM3goBXb9A+dPRD+yD40?=
 =?iso-8859-2?Q?l0K+4pQpsURvHuMhHA7/Wxg7mKrUG/NUtQExZIy5ulN9Tbb+d8BMzqGmDQ?=
 =?iso-8859-2?Q?zDnmFaiAqyoQqLU+OdJheuyc/vMYVoWhvpqsuuVfDpTSdkRCBlPQ+QfCsE?=
 =?iso-8859-2?Q?mNQ7BaBAhxfekZRIKq8pqIFS19Ikf8ojGrSl+fqnCvwSAAdNRF50fNJw4Z?=
 =?iso-8859-2?Q?OWPzXejTZTvLcUZakXJhuFUB+Ky1cIv4LB+w6mXewDIAaL4XGN6pPA95cB?=
 =?iso-8859-2?Q?l+bO9FxrHc6HxivWC01Y2jNE5g/77F+8UannfU1Wc1i4VrW52aG2PbZFWw?=
 =?iso-8859-2?Q?Uqc8I36Le6itme457166yUP8yNuNCKFAFIlT5jETDnUOrmz1Ayim9jM8hX?=
 =?iso-8859-2?Q?eOiFWR03yr9zYR6g+gaMlZTAZZiMnfaWwCzm8sbP8s99/42gWsdmzDf03u?=
 =?iso-8859-2?Q?19oF+mjUy871HTSI9uPF2TGtgj3E9F+jr/9OMHRLCKlJrz+CFabc7Xkcnk?=
 =?iso-8859-2?Q?hCPtq2Av0RjrTUNSqE7F6kdKIVTbB7vmKd7HqQQfn1NtcYQj/CPKjHcSlq?=
 =?iso-8859-2?Q?ljMN6dfll8xOysEIqTqzw5nR6A/9HmlgJFZL1BsQnm+Dp1fLo5ER7OWGMv?=
 =?iso-8859-2?Q?bU4hQEUwj4ZTpSckSDmH5lBoOIBjiEYwMOVe8qZem8O/GsP98bqufVsld/?=
 =?iso-8859-2?Q?FlEC00WTU9Wv7+318hJH6HFe6plpnx2z17v077ndHCmzQ2/OsSFADJV9Ft?=
 =?iso-8859-2?Q?bhvkufcs2uDsi7uyBb14CAk/7y9lxbixoUbLw1pfMsmNe8swT5qpEocW9X?=
 =?iso-8859-2?Q?NxL1WrQykXHulU4TSM7VGO14X4+O?=
Content-Type: multipart/mixed;
	boundary="_002_GV4PR83MB0941BC79A50B76470922FE38925EAGV4PR83MB0941EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV4PR83MB0941.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c79dc3-8328-4f50-9c75-08ddcaa022b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2025 10:52:08.1705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ZdEvfa3XV5SjUYazscYHtE2Xy7la+Q1CKNp1+BXcjpxidIgylVGxB3MZ5WlzYDDjv5U6TIkPzD8+hoPUtFQIM5HVm6RkgPpOyJF+MQb6lI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR83MB0851
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP,URI_DOTEDU autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_GV4PR83MB0941BC79A50B76470922FE38925EAGV4PR83MB0941EURP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello.=0A=
=0A=
Thank you for noticing. Here's the fixed version.=0A=
=0A=
Radek=0A=
=0A=
---=0A=
From 353e7120b660a5bf5abdff7afbd652c666c66bf8 Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Sat, 19 Jul 2025 19:17:12 +0200=0A=
Subject: [PATCH v3] Cygwin: mkimport: implement AArch64 +/-4GB relocations=
=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
Based on https://sourceware.org/pipermail/cygwin-patches/2025q3/014154.html=
=0A=
suggestion, this patch implements +/-4GB relocations for AArch64 in the mki=
mport=0A=
script by using adrp and ldr instructions. This change required update=0A=
in winsup/cygwin/mm/malloc_wrapper.cc where those instructions are=0A=
decoded to get target import address.=0A=
=0A=
Signed-off-by: Radek Barto=F2 <radek.barton@microsoft.com>=0A=
---=0A=
 winsup/cygwin/mm/malloc_wrapper.cc | 26 +++++++++++++++++---------=0A=
 winsup/cygwin/scripts/mkimport     |  7 +++++--=0A=
 2 files changed, 22 insertions(+), 11 deletions(-)=0A=
=0A=
diff --git a/winsup/cygwin/mm/malloc_wrapper.cc b/winsup/cygwin/mm/malloc_w=
rapper.cc=0A=
index 863d3089c..20d933bf5 100644=0A=
--- a/winsup/cygwin/mm/malloc_wrapper.cc=0A=
+++ b/winsup/cygwin/mm/malloc_wrapper.cc=0A=
@@ -51,16 +51,24 @@ import_address (void *imp)=0A=
   __try=0A=
     {=0A=
 #if defined(__aarch64__)=0A=
-      // If opcode is an adr instruction.=0A=
-      uint32_t opcode =3D *(uint32_t *) imp;=0A=
-      if ((opcode & 0x9f000000) =3D=3D 0x10000000)=0A=
+      /* If opcode1 is an adrp and opcode2 is ldr instruction:=0A=
+           - https://www.scs.stanford.edu/~zyedidia/arm64/adrp.html=0A=
+           - https://www.scs.stanford.edu/~zyedidia/arm64/ldr_imm_gen.html=
=0A=
+         NOTE: This implementation assumes that the relocation table is ma=
de of=0A=
+         those specific AArch64 instructions as generated by the=0A=
+         winsup/cygwin/scripts/mkimport script. Please, keep it in sync. *=
/=0A=
+      uint32_t opcode1 =3D *((uint32_t *) imp);=0A=
+      uint32_t opcode2 =3D *(((uint32_t *) imp) + 1);=0A=
+      if (((opcode1 & 0x9f000000) =3D=3D 0x90000000) && ((opcode2 & 0xbfc0=
0000) =3D=3D 0xb9400000))=0A=
 	{=0A=
-	  uint32_t immhi =3D (opcode >> 5) & 0x7ffff;=0A=
-	  uint32_t immlo =3D (opcode >> 29) & 0x3;=0A=
-	  int64_t sign_extend =3D (0l - (immhi >> 18)) << 21;=0A=
-	  int64_t imm =3D sign_extend | (immhi << 2) | immlo;=0A=
-	  uintptr_t jmpto =3D *(uintptr_t *) ((uint8_t *) imp + imm);=0A=
-	  return (void *) jmpto;=0A=
+	  uint32_t immhi =3D (opcode1 >> 5) & 0x7ffff;=0A=
+	  uint32_t immlo =3D (opcode1 >> 29) & 0x3;=0A=
+	  uint32_t imm12 =3D ((opcode2 >> 10) & 0xfff) * 8; // 64 bit scale=0A=
+	  int64_t sign_extend =3D (0l - ((int64_t) immhi >> 32)) << 33; // sign e=
xtend from 33 to 64 bits=0A=
+	  int64_t imm =3D sign_extend | (((immhi << 2) | immlo) << 12);=0A=
+	  int64_t base =3D (int64_t) imp & ~0xfff;=0A=
+	  uintptr_t* jmpto =3D (uintptr_t *) (base + imm + imm12);=0A=
+	  return (void *) *jmpto;=0A=
 	}=0A=
 #else=0A=
       if (*((uint16_t *) imp) =3D=3D 0x25ff)=0A=
diff --git a/winsup/cygwin/scripts/mkimport b/winsup/cygwin/scripts/mkimpor=
t=0A=
index 0c1bcafbf..33d8b08fb 100755=0A=
--- a/winsup/cygwin/scripts/mkimport=0A=
+++ b/winsup/cygwin/scripts/mkimport=0A=
@@ -73,8 +73,11 @@ EOF=0A=
 	.extern	$imp_sym=0A=
 	.global	$glob_sym=0A=
 $glob_sym:=0A=
-	adr x16, $imp_sym=0A=
-	ldr x16, [x16]=0A=
+	# NOTE: Using instructions that are used by MSVC and LLVM. Binutils are=
=0A=
+	# using adrp/add/ldr-0-offset though. Please, keep it in sync with=0A=
+  # import_address implementation in winsup/cygwin/mm/malloc_wrapper.cc.=
=0A=
+	adrp x16, $imp_sym=0A=
+	ldr x16, [x16, #:lo12:$imp_sym]=0A=
 	br x16=0A=
 EOF=0A=
 	} else {=0A=
-- =0A=
2.50.1.vfs.0.0=0A=

--_002_GV4PR83MB0941BC79A50B76470922FE38925EAGV4PR83MB0941EURP_
Content-Type: application/octet-stream;
	name="v3-0001-Cygwin-mkimport-implement-AArch64-4GB-relocations.patch"
Content-Description:
 v3-0001-Cygwin-mkimport-implement-AArch64-4GB-relocations.patch
Content-Disposition: attachment;
	filename="v3-0001-Cygwin-mkimport-implement-AArch64-4GB-relocations.patch";
	size=3366; creation-date="Thu, 24 Jul 2025 10:51:46 GMT";
	modification-date="Thu, 24 Jul 2025 10:51:46 GMT"
Content-Transfer-Encoding: base64

RnJvbSAzNTNlNzEyMGI2NjBhNWJmNWFiZGZmN2FmYmQ2NTJjNjY2YzY2YmY4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogU2F0LCAxOSBKdWwgMjAyNSAxOToxNzoxMiAr
MDIwMApTdWJqZWN0OiBbUEFUQ0ggdjNdIEN5Z3dpbjogbWtpbXBvcnQ6IGltcGxlbWVudCBBQXJj
aDY0ICsvLTRHQiByZWxvY2F0aW9ucwpNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IHRl
eHQvcGxhaW47IGNoYXJzZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdAoK
QmFzZWQgb24gaHR0cHM6Ly9zb3VyY2V3YXJlLm9yZy9waXBlcm1haWwvY3lnd2luLXBhdGNoZXMv
MjAyNXEzLzAxNDE1NC5odG1sCnN1Z2dlc3Rpb24sIHRoaXMgcGF0Y2ggaW1wbGVtZW50cyArLy00
R0IgcmVsb2NhdGlvbnMgZm9yIEFBcmNoNjQgaW4gdGhlIG1raW1wb3J0CnNjcmlwdCBieSB1c2lu
ZyBhZHJwIGFuZCBsZHIgaW5zdHJ1Y3Rpb25zLiBUaGlzIGNoYW5nZSByZXF1aXJlZCB1cGRhdGUK
aW4gd2luc3VwL2N5Z3dpbi9tbS9tYWxsb2Nfd3JhcHBlci5jYyB3aGVyZSB0aG9zZSBpbnN0cnVj
dGlvbnMgYXJlCmRlY29kZWQgdG8gZ2V0IHRhcmdldCBpbXBvcnQgYWRkcmVzcy4KClNpZ25lZC1v
ZmYtYnk6IFJhZGVrIEJhcnRvxYggPHJhZGVrLmJhcnRvbkBtaWNyb3NvZnQuY29tPgotLS0KIHdp
bnN1cC9jeWd3aW4vbW0vbWFsbG9jX3dyYXBwZXIuY2MgfCAyNiArKysrKysrKysrKysrKysrKy0t
LS0tLS0tLQogd2luc3VwL2N5Z3dpbi9zY3JpcHRzL21raW1wb3J0ICAgICB8ICA3ICsrKysrLS0K
IDIgZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9tbS9tYWxsb2Nfd3JhcHBlci5jYyBiL3dpbnN1cC9jeWd3
aW4vbW0vbWFsbG9jX3dyYXBwZXIuY2MKaW5kZXggODYzZDMwODljLi4yMGQ5MzNiZjUgMTAwNjQ0
Ci0tLSBhL3dpbnN1cC9jeWd3aW4vbW0vbWFsbG9jX3dyYXBwZXIuY2MKKysrIGIvd2luc3VwL2N5
Z3dpbi9tbS9tYWxsb2Nfd3JhcHBlci5jYwpAQCAtNTEsMTYgKzUxLDI0IEBAIGltcG9ydF9hZGRy
ZXNzICh2b2lkICppbXApCiAgIF9fdHJ5CiAgICAgewogI2lmIGRlZmluZWQoX19hYXJjaDY0X18p
Ci0gICAgICAvLyBJZiBvcGNvZGUgaXMgYW4gYWRyIGluc3RydWN0aW9uLgotICAgICAgdWludDMy
X3Qgb3Bjb2RlID0gKih1aW50MzJfdCAqKSBpbXA7Ci0gICAgICBpZiAoKG9wY29kZSAmIDB4OWYw
MDAwMDApID09IDB4MTAwMDAwMDApCisgICAgICAvKiBJZiBvcGNvZGUxIGlzIGFuIGFkcnAgYW5k
IG9wY29kZTIgaXMgbGRyIGluc3RydWN0aW9uOgorICAgICAgICAgICAtIGh0dHBzOi8vd3d3LnNj
cy5zdGFuZm9yZC5lZHUvfnp5ZWRpZGlhL2FybTY0L2FkcnAuaHRtbAorICAgICAgICAgICAtIGh0
dHBzOi8vd3d3LnNjcy5zdGFuZm9yZC5lZHUvfnp5ZWRpZGlhL2FybTY0L2xkcl9pbW1fZ2VuLmh0
bWwKKyAgICAgICAgIE5PVEU6IFRoaXMgaW1wbGVtZW50YXRpb24gYXNzdW1lcyB0aGF0IHRoZSBy
ZWxvY2F0aW9uIHRhYmxlIGlzIG1hZGUgb2YKKyAgICAgICAgIHRob3NlIHNwZWNpZmljIEFBcmNo
NjQgaW5zdHJ1Y3Rpb25zIGFzIGdlbmVyYXRlZCBieSB0aGUKKyAgICAgICAgIHdpbnN1cC9jeWd3
aW4vc2NyaXB0cy9ta2ltcG9ydCBzY3JpcHQuIFBsZWFzZSwga2VlcCBpdCBpbiBzeW5jLiAqLwor
ICAgICAgdWludDMyX3Qgb3Bjb2RlMSA9ICooKHVpbnQzMl90ICopIGltcCk7CisgICAgICB1aW50
MzJfdCBvcGNvZGUyID0gKigoKHVpbnQzMl90ICopIGltcCkgKyAxKTsKKyAgICAgIGlmICgoKG9w
Y29kZTEgJiAweDlmMDAwMDAwKSA9PSAweDkwMDAwMDAwKSAmJiAoKG9wY29kZTIgJiAweGJmYzAw
MDAwKSA9PSAweGI5NDAwMDAwKSkKIAl7Ci0JICB1aW50MzJfdCBpbW1oaSA9IChvcGNvZGUgPj4g
NSkgJiAweDdmZmZmOwotCSAgdWludDMyX3QgaW1tbG8gPSAob3Bjb2RlID4+IDI5KSAmIDB4MzsK
LQkgIGludDY0X3Qgc2lnbl9leHRlbmQgPSAoMGwgLSAoaW1taGkgPj4gMTgpKSA8PCAyMTsKLQkg
IGludDY0X3QgaW1tID0gc2lnbl9leHRlbmQgfCAoaW1taGkgPDwgMikgfCBpbW1sbzsKLQkgIHVp
bnRwdHJfdCBqbXB0byA9ICoodWludHB0cl90ICopICgodWludDhfdCAqKSBpbXAgKyBpbW0pOwot
CSAgcmV0dXJuICh2b2lkICopIGptcHRvOworCSAgdWludDMyX3QgaW1taGkgPSAob3Bjb2RlMSA+
PiA1KSAmIDB4N2ZmZmY7CisJICB1aW50MzJfdCBpbW1sbyA9IChvcGNvZGUxID4+IDI5KSAmIDB4
MzsKKwkgIHVpbnQzMl90IGltbTEyID0gKChvcGNvZGUyID4+IDEwKSAmIDB4ZmZmKSAqIDg7IC8v
IDY0IGJpdCBzY2FsZQorCSAgaW50NjRfdCBzaWduX2V4dGVuZCA9ICgwbCAtICgoaW50NjRfdCkg
aW1taGkgPj4gMzIpKSA8PCAzMzsgLy8gc2lnbiBleHRlbmQgZnJvbSAzMyB0byA2NCBiaXRzCisJ
ICBpbnQ2NF90IGltbSA9IHNpZ25fZXh0ZW5kIHwgKCgoaW1taGkgPDwgMikgfCBpbW1sbykgPDwg
MTIpOworCSAgaW50NjRfdCBiYXNlID0gKGludDY0X3QpIGltcCAmIH4weGZmZjsKKwkgIHVpbnRw
dHJfdCogam1wdG8gPSAodWludHB0cl90ICopIChiYXNlICsgaW1tICsgaW1tMTIpOworCSAgcmV0
dXJuICh2b2lkICopICpqbXB0bzsKIAl9CiAjZWxzZQogICAgICAgaWYgKCooKHVpbnQxNl90ICop
IGltcCkgPT0gMHgyNWZmKQpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9zY3JpcHRzL21raW1w
b3J0IGIvd2luc3VwL2N5Z3dpbi9zY3JpcHRzL21raW1wb3J0CmluZGV4IDBjMWJjYWZiZi4uMzNk
OGIwOGZiIDEwMDc1NQotLS0gYS93aW5zdXAvY3lnd2luL3NjcmlwdHMvbWtpbXBvcnQKKysrIGIv
d2luc3VwL2N5Z3dpbi9zY3JpcHRzL21raW1wb3J0CkBAIC03Myw4ICs3MywxMSBAQCBFT0YKIAku
ZXh0ZXJuCSRpbXBfc3ltCiAJLmdsb2JhbAkkZ2xvYl9zeW0KICRnbG9iX3N5bToKLQlhZHIgeDE2
LCAkaW1wX3N5bQotCWxkciB4MTYsIFt4MTZdCisJIyBOT1RFOiBVc2luZyBpbnN0cnVjdGlvbnMg
dGhhdCBhcmUgdXNlZCBieSBNU1ZDIGFuZCBMTFZNLiBCaW51dGlscyBhcmUKKwkjIHVzaW5nIGFk
cnAvYWRkL2xkci0wLW9mZnNldCB0aG91Z2guIFBsZWFzZSwga2VlcCBpdCBpbiBzeW5jIHdpdGgK
KyAgIyBpbXBvcnRfYWRkcmVzcyBpbXBsZW1lbnRhdGlvbiBpbiB3aW5zdXAvY3lnd2luL21tL21h
bGxvY193cmFwcGVyLmNjLgorCWFkcnAgeDE2LCAkaW1wX3N5bQorCWxkciB4MTYsIFt4MTYsICM6
bG8xMjokaW1wX3N5bV0KIAliciB4MTYKIEVPRgogCX0gZWxzZSB7Ci0tIAoyLjUwLjEudmZzLjAu
MAoK

--_002_GV4PR83MB0941BC79A50B76470922FE38925EAGV4PR83MB0941EURP_--
