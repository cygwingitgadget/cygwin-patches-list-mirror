Return-Path: <SRS0=acxd=75=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c409::1])
	by sourceware.org (Postfix) with ESMTPS id 5BDD14BA23D2
	for <cygwin-patches@cygwin.com>; Sat, 24 Jan 2026 18:54:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5BDD14BA23D2
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5BDD14BA23D2
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c409::1
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1769280855; cv=pass;
	b=PazjPVagzKEsgYajJLCxbwYqZQL2F9eAoNPtTjnBrurRWo060Dz6FekZZkGiZSAqtFCA5IdOikGBj85bYFd3Yry85Lz5OyzqQj8MO3vhUGAW6/zI13pTMdwKjK7B6Y2ZCD4N7Ipt98yZ4dIvF6kd4tVEoGZDv4jyrZS/ZPJ6p58=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1769280855; c=relaxed/simple;
	bh=KURH6upqYQCFkWEmn6UR67ii2w6gupY8A6hg6TTR3e0=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=kTyOXVPMAyziq8aSKDwE9TJ8WySums+Z8CUoNE5fQgNzxIH+JliJ7WokEHztND6IiCx9zNpyanLvD3kbNK6n0jTuW3FsCn6YVy0V+kIkVYg5vXgd5Hb3sMBwTjhUQXjz2V9tmYys5apOI0oUltSoelB8qp/dVQpqt6KwAKasHO4=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5BDD14BA23D2
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=zzs28zwn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2zXp7MDCYglqybTc2BnPCWI2JXqRBJ0NhAAN8+CJzhoKSIDQ2lNxBgw+NkZhXcGyuVkwsj0ze3t9zPd0FvOuKwT5e7OEzyocUpl0sR0NBTfcWQ8j79dp4VWEOfE9k++QKBE25vaWnhnqaNCP1nBM6TA3U3XMnHnxn/KRjapOlzF5Cc5YaWFI7ZNFTsnZj/yZI4WYo5eMEjFexQBXU5rzJBSot29sxwlBNvd9HU8Xb50u2L7reY/LDAAZ2QtdnhdYpd3WePRVo/LNlJTzWmQSAM8IkqVjMp22TGwMh+7MN9PixcyHFLrabGe59yZHwr3wMJGL9RqgczW1vSuQKCP9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ilwq26/O5lBJc5C7WJwToLq5dc9PUPf56gOwCD/A7k=;
 b=DU9Ig6oTnOoXrMs2+i3jMdy1N6pG7/5Ubs33haeOX5cblPsQaPcItabY1CQXBd9gGTzXYNK9qAJTz06Bi3TBzDQNPKYvT3KrH64ZQnoFBkAh2UtJRo1VOC6t6WLaiPzDE+r4v4PAI2Xtll8uX2rnEsuhaX6yDDk74D+t1IeTlOXU2pd/76lgwcuC7W5K+DVmuasMz2ZB7v4OKITJk+NrDFlaEH5cDnX0CpfwgtjXNcOX3yxYPLF8bCGV91UoqDpj4GgG1GG2obmGgRx6U1BKgk5vXK4ZlrP0P6zBEplJepEf3NcwA/C64EB0D00aEvuUc61UAbRKFrqLvcw007lg7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ilwq26/O5lBJc5C7WJwToLq5dc9PUPf56gOwCD/A7k=;
 b=zzs28zwnaLuco6+3+aKlHRIbAUHzqdhHM7j87I5/hvOBqoeYC5z+E6ZM2d+aPNqWglrVIfjFb0cYjL3OSH+B3bwqfRV01N//nkRQC0Gf/wlj9CSpC/XUDkgHOKTGgZ9L1NbrLqgsHuQokXVHypfLtNwrufixMsbsyeM/0i5EqHMvTpYUtpcbnF4KN5JYdkCOfVcqeg8p7QueVIYiZHU/1DSMZQXeB+P745G5EUap77xd76EOtPfJUrsiJNaJv/UtUtuLQwQjU3UsluQSbHpSNPuYV2HEnm4pi6LhxE0cmnPcJybKx3fe8Sa8hopkjKPPMLntlI7GT4d5nryNGveQQA==
Received: from PN3P287MB3077.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:226::14)
 by PN2P287MB1454.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.5; Sat, 24 Jan
 2026 18:54:12 +0000
Received: from PN3P287MB3077.INDP287.PROD.OUTLOOK.COM
 ([fe80::48eb:264b:989d:5de3]) by PN3P287MB3077.INDP287.PROD.OUTLOOK.COM
 ([fe80::48eb:264b:989d:5de3%6]) with mapi id 15.20.9564.001; Sat, 24 Jan 2026
 18:54:12 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: Igor Podgainoi <igor.podgainoi@arm.com>
Subject: [PATCH] Cygwin: gendef: Implement longjmp for AArch64
Thread-Topic: [PATCH] Cygwin: gendef: Implement longjmp for AArch64
Thread-Index: AdyNYneh381oeUocRWOs+/49F/iADQ==
Date: Sat, 24 Jan 2026 18:54:12 +0000
Message-ID:
 <PN3P287MB3077A99C408AEF13C8036E4C9F95A@PN3P287MB3077.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB3077:EE_|PN2P287MB1454:EE_
x-ms-office365-filtering-correlation-id: e4446e4b-e152-4d49-33bf-08de5b79f6c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|8096899003|4053099003|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?gx1NaCtuw6FrgSuCdbTzwJ05RqLz6HBo/m5qZMEzerSyyOOLhDaAVjOwED?=
 =?iso-8859-2?Q?+fK2kjPaQk3okC2EW5Ifcb++hsRSv/INlCPhAPRQoJJFIthTr5vZJU7bH7?=
 =?iso-8859-2?Q?TE+2vyy1YJ/laECIbjsk9jrjI8Yya849IhrjBD5OvBWSc+D7Bblia/soRl?=
 =?iso-8859-2?Q?pPyiFvikQWII8p/qyFp0Z3FjlFdrIgEus2qE3lSrSGnodFZJx1oF47pg63?=
 =?iso-8859-2?Q?QJjcwH687Bkc2uc4ZDZeuZd6Y1PWIrMTl/8jCvFU/dwOlzImX68OKzc874?=
 =?iso-8859-2?Q?/BxDiYvtQQ14tvKhtEa1ObqZQfw1q5jaHczZRuUv5QbWkMHVqxGOT35rwW?=
 =?iso-8859-2?Q?TfN9EauPu38Uxye9dQDUdfnhTGxALdLvmeaX9mpolOQ7JvPuWcm2URKNF0?=
 =?iso-8859-2?Q?9cVKmOeICgrr3AgZ/Z8mNV0G1K/G7jMAuSFSV0Zs6cQMiuOnT3GPthYCB5?=
 =?iso-8859-2?Q?c14t5WyHPTwOhQXNP7FAc2CqQ7DKUO6JXw75dX9api/J0Zq40LL5SF+NKW?=
 =?iso-8859-2?Q?2hS+DfzcAuHbxXdvrRbpZQ3TDSdS4IpoVaewZY1+pg0SIBsZfAH+WR0NmE?=
 =?iso-8859-2?Q?5e9tBFnFAsiZ64ESkuEQv31GmMhzBlRirI02Mli+5lUIQyIx7b6h7wXbX+?=
 =?iso-8859-2?Q?evqvBxGbaw7VGiQ/58iuJI8ZBKolDcMrEnsh5wfHZhrYJ5pL3VOxOqHOq2?=
 =?iso-8859-2?Q?1ANWnb7oET+lAA9Hk+bvFNHDdrTzQr13nh7R/QPodinlo2hMiSpojtvI5l?=
 =?iso-8859-2?Q?GLvazEk/aNAaX20dWX5LF6JZtrQhz1yOjuyrU7cQY2p7xuQsKsMwTuvkuw?=
 =?iso-8859-2?Q?fco/TxZBTXPGNjU0E8+n+PD5GqZOYVvFGiYWtA04P9X7glGygYvfq8sk9w?=
 =?iso-8859-2?Q?t+ijhNJBmDePHvBeEKM9I3B1jjYT6NBmbbG+Y+PdLAdkkK17qC+/X5fsu7?=
 =?iso-8859-2?Q?Y8EtqLH5WIgYas0GKJUFt8DYG6EMNUYHX6wxfFdrfmNBoNkKLBDYkETqdh?=
 =?iso-8859-2?Q?VNHad0dYPCvYLpDEL9SiVx1i+cwOW+8VBgz6oLUUPwXptO1d1sikDjUSyF?=
 =?iso-8859-2?Q?f0lYeuAf6GHVY0Cl/g8I/Aao2+T+xTz25hGSyW9PenetECwGM8lK3xUgjb?=
 =?iso-8859-2?Q?HIWVby2rhOM4XbcPdyEV8Jup3fQTwTRahEnArZdHpF4pV7N7ZOwbP59a76?=
 =?iso-8859-2?Q?4KNHYKX5YKRKq8IiFEJFmmTk6aJilJmjq3qByr5nN8anc4UfBgdZWgjFug?=
 =?iso-8859-2?Q?OkTcfMSoeYnfMluC3sXYZnlwkPAq1CpuSMf6QDAJ/TFywPreCzsxsgJPOw?=
 =?iso-8859-2?Q?g1oorxFA82aXHeWYQ3O7FTeUa+54No/0SmSNJvgd/qVqed0wRV0JYBWwp5?=
 =?iso-8859-2?Q?9oHB3/rje7wjhSUwXvN1NWpYdnRuQ5x6hPcJXJDZEK33r/q1oySHLdkDP5?=
 =?iso-8859-2?Q?wOoOfx/m5mWP9Pp2OQgTrfydd492+Rhsu462kiMGIXgOMZpIii/2z5TeR6?=
 =?iso-8859-2?Q?q/+FTykHCYBnnhy6s96drtYtq36hSFdGS55YNoZ0i5ahsaRCvyehpgzGlr?=
 =?iso-8859-2?Q?pfNPaCOFXZoaXi6HI5tTo9Ktu1QC85PhFCM55tq1rOUsdjdGIojhacyLZG?=
 =?iso-8859-2?Q?HEl8XVF8Vy53Heb9NI6s/hOYJA9X5xvUQxuevjTFUmM92ZyeuS68cFoA/Y?=
 =?iso-8859-2?Q?AwqAA+1twfbD84xpNCE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB3077.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(8096899003)(4053099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?RyN1VLrKIARhE2OqOJbl0PTobW3LUuwMNhObMyAPy9jzcq8CRruj5ycthU?=
 =?iso-8859-2?Q?Z3uDTDeSgHR7wkPmsQ6vZIlLnKr4kuYG8UmNHnKgkFsJEpmB0/LbsP9PZT?=
 =?iso-8859-2?Q?aJjMEJXUjcS3zcTjWBCLD0iR9t/R+joEe0tg0HNnHfiVtqmZ1Nz55qpq4s?=
 =?iso-8859-2?Q?FCW8pmeimts0bFi0OY3Nw8FVUbzMz1AVfPEpcWpGo8kSxm/PUE6PWoTDF+?=
 =?iso-8859-2?Q?Jj/9ztUdA3Q3Vr1VJuKsU3b8CpAgjp1a+VOOZEK34ijML9pnH/YEaQPvgl?=
 =?iso-8859-2?Q?3Re0Xrbpk6R9D30l/4+0XQe0EVm9eoGa2iKOgwMJ1n0RaiGGT2RMtLsMpF?=
 =?iso-8859-2?Q?DIW+ZHqe2QNG5nWLtEa8I2rapQlNEvKBAv2SnlIY4hwqyLhV2NyGRXXIhQ?=
 =?iso-8859-2?Q?WKl6NfB0/eh9wF4bICJUxz2467iO8U2OESoGtrJTqJIlCBVg9YDb1EAtl2?=
 =?iso-8859-2?Q?phTWJ466E6wQ6sRNFoL0mSHp1vi1apjzkI3tR/QCSQx8kjBLVoHrQf/UUu?=
 =?iso-8859-2?Q?4ofDM/iodLVnsctkc3QyJDlFUPkehw0hPXAmadjMjbuJAnCwIUWKeCPMFX?=
 =?iso-8859-2?Q?7yLvk7YVgc5pjZIYgyEC+xvH7IgGG32MDXqXqejqZ2yO31ANg/HfQvvct/?=
 =?iso-8859-2?Q?ewJHD548wDxq1aF9c19B+YDGfcMEVhMWWm5vJNMbzNbgeg0xhefUXNI9Qb?=
 =?iso-8859-2?Q?umoBpW2DNVNrRlSfk5a48Tpf5emlXsHBpvXlqgn7OCbGyS1mbZLSjWnDbW?=
 =?iso-8859-2?Q?htuERliCysQ5vJuDsbMLHS1OpmhITrVm5gWJloob2kAnAlfxyTEgIeAw47?=
 =?iso-8859-2?Q?OhGDGWkxuvTIAD0SYmWeJ9E9lZKmMxDWrTKX436Zopse8HuJGHgG054tct?=
 =?iso-8859-2?Q?d5mTpVi/de4X6KVOYPvwtY5H8jQjm2g+SipjUvhm4rkdCSAMzu1S7qtBKD?=
 =?iso-8859-2?Q?RSoFFVAgJ4+9Bf68OlnqYmM0zk35KpBZFgyfmKpGcfI4mJHB3tVcl0Ks0p?=
 =?iso-8859-2?Q?JnC9YOzWAPb9XiJYYIuKos6tyLwoKFEWa/64X2zNf016hIva5Rhk3SkpYX?=
 =?iso-8859-2?Q?HJm6LeB8QDzl0d1HRnXRZF2/N+WdYBOFbr2hbfS9cgQUw27n86RKMTlj/e?=
 =?iso-8859-2?Q?SNSU8BdIFB9L2EGAihi8F+BoTsFUwxmfDvAkXQq703zTIsLGwkZfWjdeAH?=
 =?iso-8859-2?Q?Ut4zQ5iQREzvbVLpjR5hMzPdKQotzbL6VZIKe2IziP0cIxrI8UOAV1jyp5?=
 =?iso-8859-2?Q?or+H6cl4fdMjaCCed3lUA1PCzFQ8JpkL69oNfgnZ7OhrIWbrLerap8ZX4e?=
 =?iso-8859-2?Q?iauSm1NpGOWTKumrPW5bu1bCvC3pKM1kUfCUBcXhhfe9IJOQYgi4OavOrs?=
 =?iso-8859-2?Q?DH20BASr50kIJEgeeOiikOCnvcOsJRky0q4ZbAYJ3VJbz26yu9R25Znkxh?=
 =?iso-8859-2?Q?FuRwT0UUBCShRNf4ohN3aOPobYjlBmngJxBt2dNTVZLf9PyKNpiUjZlkz4?=
 =?iso-8859-2?Q?czalGDMBBrhXUL/PDdN8wXa+lJDcJBeVIBfZZKRoTQUodyIoWmlj3pI5Xq?=
 =?iso-8859-2?Q?zAITy9OAW72mv1w5KJbM19H9xSzxhd7JbJzNOj2dLL9EM46NnEN/7kXqym?=
 =?iso-8859-2?Q?Mn0WVz/i/7D8OfbNgS+mvzjuo/6f0eVvU+tJelkGfAWqC3UauVXGdocZkM?=
 =?iso-8859-2?Q?+W87eM+d235IORiw14iUZLoTfXjsQfhDKssoykOGUMGg8I1xF6sLWYqatP?=
 =?iso-8859-2?Q?AwVOody6kFLssCP7cYeC/sPOD3pzfnkdnfsNtHt1WEvRGHToy8Sn6F4hIo?=
 =?iso-8859-2?Q?wOwI7CSH7TOnvYRrtE6tqdWWp7ZFuSrZX2w94BtkZltYNwUsyMBMFqJPt/?=
 =?iso-8859-2?Q?G+?=
x-ms-exchange-antispam-messagedata-1:
 yKLU8r2S5y0dwmCL9igG4hPfq9NMbuUaQnSOMGUG8x68LwvRP0Dr7DE3
Content-Type: multipart/mixed;
	boundary="_004_PN3P287MB3077A99C408AEF13C8036E4C9F95APN3P287MB3077INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB3077.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e4446e4b-e152-4d49-33bf-08de5b79f6c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2026 18:54:12.1717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v5E2FxdawiVy+xOF6dXkfYElwVvOvlRBWHmqwkwsgd+zzXUA/IY1w0RqaD0k47wS4/bF3rZpwfABO7lQIQ2ZGrbaVbY/0+rY1p3m+CQeikPg1yjrRrZ51QriE5oSOU9TrVn7RHlCQbujF8/oNjJ6NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB1454
X-Spam-Status: No, score=-12.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_PN3P287MB3077A99C408AEF13C8036E4C9F95APN3P287MB3077INDP_
Content-Type: multipart/alternative;
	boundary="_000_PN3P287MB3077A99C408AEF13C8036E4C9F95APN3P287MB3077INDP_"

--_000_PN3P287MB3077A99C408AEF13C8036E4C9F95APN3P287MB3077INDP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hi all,

This patch is not for review and a V2 is upcoming.

The current version contains a few known issues that have already been
fixed by Igor Podgainoi <Igor.Podgainoi@arm.com<mailto:Igor.Podgainoi@arm.c=
om>>.  Those fixes will be
contributed directly by Igor by a V2 patch, which will be posted to this sa=
me thread.

Notes:
Attached is a patch that adds an ARM64 stub for the `longjmp` routine
in the gendef script. The changes are documented with inline comments and
should be self-explanatory.
I would also like to thank Radek Barto=F2 <radek.barton@microsoft.com<mailt=
o:radek.barton@microsoft.com>> for his
initial contributions to this effort.

Thanks & regards
Thirumalai Nagalingam
<thirumalai.nagalingam@multicorewareinc.com<mailto:thirumalai.nagalingam@mu=
lticorewareinc.com>>

In-lined patch:

diff --git a/winsup/cygwin/scripts/gendef b/winsup/cygwin/scripts/gendef
index 5ad7fd947..e94c97195 100755
--- a/winsup/cygwin/scripts/gendef
+++ b/winsup/cygwin/scripts/gendef
@@ -791,7 +791,71 @@ siglongjmp:
        .seh_endproc

        .globl  longjmp
+       .seh_proc longjmp
 longjmp:
+       // prologue
+       stp     fp, lr, [sp, #-0x20]!                   // save FP and LR r=
egisters, allocate additional 16 bytes for function arguments
+       stp     x0, x1, [sp, #0x10]                     // save function ar=
guments (jump buffer and return value)
+       mov     fp, sp                                  // establishing fra=
me chain
+       .seh_endprologue
+1:
+       bl      stabilize_sig_stack                     // call stabilize_s=
ig_stack which returns TLS pointer in x0
+       ldr     x2, [sp, #0x10]                         // get jump buffer =
pointer from stack
+       ldr     x10, [x2]                               // get old signal s=
tack from jump buffer
+
+       // restore stack pointer in TLS
+       ldr     x11, =3D_cygtls.stackptr
+       add     x11, x0, x11
+       str     x10, [x11]
+
+       // release lock by decrementing counter
+       ldr     x11, =3D_cygtls.stacklock
+       add     x11, x0, x11
+       ldr     w12, [x11]
+       sub     w12, w12, #1
+       str     w12, [x11]
+
+       // we're not in cygwin anymore, clear "in cygwin" flag
+       ldr     x11, =3D_cygtls.incyg
+       add     x11, x0, x11
+       mov     w12, #0
+       str     w12, [x11]
+
+       // get saved return value before SP is restored
+       ldr     x0, [sp, #0x10]
+
+       // restore callee-saved registers from jump buffer
+       ldp     x19, x20, [x2, #0x08]                   // restore x19, x20
+       ldp     x21, x22, [x2, #0x18]                   // restore x21, x22
+       ldp     x23, x24, [x2, #0x28]                   // restore x23, x24
+       ldp     x25, x26, [x2, #0x38]                   // restore x25, x26
+       ldp     x27, x28, [x2, #0x48]                   // restore x27, x28
+       ldp     fp, lr, [x2, #0x58]                     // restore x29 (fra=
me pointer) and x30 (link register)
+       ldr     x10, [x2, #0x68]                        // get saved stack =
pointer
+       mov     sp, x10                                 // restore stack po=
inter
+       ldr     x10, [x2, #0x70]                        // load floating-po=
int control register
+       msr     fpcr, x10                               // restore FPCR
+       ldr     x10, [x2, #0x78]                        // load floating-po=
int status register
+       msr     fpsr, x10                               // restore FPSR
+
+       // restore floating-point registers (d8-d15)
+       ldp     d8, d9, [x2, #0x80]
+       ldp     d10, d11, [x2, #0x90]
+       ldp     d12, d13, [x2, #0xA0]
+       ldp     d14, d15, [x2, #0xB0]
+
+       // restore TLS stack pointer
+       ldr     x1, [x0, #0xB8]
+       str     x1, [sp]
+
+       // ensure return value is non-zero (C standard requirement)
+       cbnz    x0, 0f
+       mov     x0, #1
+0:
+       // epilogue
+       add     sp, sp, #0x10                           // FP and LR are al=
ready restored, just restore SP as it would be popped
+       ret
+       .seh_endproc
 EOF
     }
 }

--_000_PN3P287MB3077A99C408AEF13C8036E4C9F95APN3P287MB3077INDP_--

--_004_PN3P287MB3077A99C408AEF13C8036E4C9F95APN3P287MB3077INDP_
Content-Type: application/octet-stream;
	name="Cygwin-gendef-Implement-longjmp-for-AArch64.patch"
Content-Description: Cygwin-gendef-Implement-longjmp-for-AArch64.patch
Content-Disposition: attachment;
	filename="Cygwin-gendef-Implement-longjmp-for-AArch64.patch"; size=3055;
	creation-date="Sat, 24 Jan 2026 18:53:33 GMT";
	modification-date="Sat, 24 Jan 2026 18:54:12 GMT"
Content-Transfer-Encoding: base64

RnJvbSA3NzcwZDdmMGRmMjAyZTdjMmUzY2E4YTlmZTY0MjE0NTBjMjBhZGY1
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5h
Z2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJl
aW5jLmNvbT4KRGF0ZTogU2F0LCA2IERlYyAyMDI1IDE4OjE0OjM3ICswNTMw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBnZW5kZWY6IEltcGxlbWVudCBs
b25nam1wIGZvciBBQXJjaDY0Ck1JTUUtVmVyc2lvbjogMS4wCkNvbnRlbnQt
VHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD1VVEYtOApDb250ZW50LVRyYW5z
ZmVyLUVuY29kaW5nOiA4Yml0CgpBdXRob3I6IFJhZGVrIEJhcnRvxYggPHJh
ZGVrLmJhcnRvbkBtaWNyb3NvZnQuY29tPgpDby1hdXRob3JlZC1ieTogVGhp
cnVtYWxhaSBOYWdhbGluZ2FtIDx0aGlydW1hbGFpLm5hZ2FsaW5nYW1AbXVs
dGljb3Jld2FyZWluYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBUaGlydW1hbGFp
IE5hZ2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3
YXJlaW5jLmNvbT4KLS0tCiB3aW5zdXAvY3lnd2luL3NjcmlwdHMvZ2VuZGVm
IHwgNjQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAx
IGZpbGUgY2hhbmdlZCwgNjQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBh
L3dpbnN1cC9jeWd3aW4vc2NyaXB0cy9nZW5kZWYgYi93aW5zdXAvY3lnd2lu
L3NjcmlwdHMvZ2VuZGVmCmluZGV4IDVhZDdmZDk0Ny4uZTk0Yzk3MTk1IDEw
MDc1NQotLS0gYS93aW5zdXAvY3lnd2luL3NjcmlwdHMvZ2VuZGVmCisrKyBi
L3dpbnN1cC9jeWd3aW4vc2NyaXB0cy9nZW5kZWYKQEAgLTc5MSw3ICs3OTEs
NzEgQEAgc2lnbG9uZ2ptcDoKIAkuc2VoX2VuZHByb2MKCiAJLmdsb2JsICBs
b25nam1wCisJLnNlaF9wcm9jIGxvbmdqbXAKIGxvbmdqbXA6CisJLy8gcHJv
bG9ndWUKKwlzdHAJZnAsIGxyLCBbc3AsICMtMHgyMF0hCQkJLy8gc2F2ZSBG
UCBhbmQgTFIgcmVnaXN0ZXJzLCBhbGxvY2F0ZSBhZGRpdGlvbmFsIDE2IGJ5
dGVzIGZvciBmdW5jdGlvbiBhcmd1bWVudHMKKwlzdHAJeDAsIHgxLCBbc3As
ICMweDEwXQkJCS8vIHNhdmUgZnVuY3Rpb24gYXJndW1lbnRzIChqdW1wIGJ1
ZmZlciBhbmQgcmV0dXJuIHZhbHVlKQorCW1vdglmcCwgc3AJCQkJCS8vIGVz
dGFibGlzaGluZyBmcmFtZSBjaGFpbgorCS5zZWhfZW5kcHJvbG9ndWUKKzE6
CisJYmwJc3RhYmlsaXplX3NpZ19zdGFjawkJCS8vIGNhbGwgc3RhYmlsaXpl
X3NpZ19zdGFjayB3aGljaCByZXR1cm5zIFRMUyBwb2ludGVyIGluIHgwCisJ
bGRyCXgyLCBbc3AsICMweDEwXQkJCQkvLyBnZXQganVtcCBidWZmZXIgcG9p
bnRlciBmcm9tIHN0YWNrCisJbGRyCXgxMCwgW3gyXQkJCQkvLyBnZXQgb2xk
IHNpZ25hbCBzdGFjayBmcm9tIGp1bXAgYnVmZmVyCisKKwkvLyByZXN0b3Jl
IHN0YWNrIHBvaW50ZXIgaW4gVExTCisJbGRyCXgxMSwgPV9jeWd0bHMuc3Rh
Y2twdHIKKwlhZGQJeDExLCB4MCwgeDExCisJc3RyCXgxMCwgW3gxMV0KKwor
CS8vIHJlbGVhc2UgbG9jayBieSBkZWNyZW1lbnRpbmcgY291bnRlcgorCWxk
cgl4MTEsID1fY3lndGxzLnN0YWNrbG9jaworCWFkZAl4MTEsIHgwLCB4MTEK
KwlsZHIJdzEyLCBbeDExXQorCXN1Ygl3MTIsIHcxMiwgIzEKKwlzdHIJdzEy
LCBbeDExXQorCisJLy8gd2UncmUgbm90IGluIGN5Z3dpbiBhbnltb3JlLCBj
bGVhciAiaW4gY3lnd2luIiBmbGFnCisJbGRyCXgxMSwgPV9jeWd0bHMuaW5j
eWcKKwlhZGQJeDExLCB4MCwgeDExCisJbW92CXcxMiwgIzAKKwlzdHIJdzEy
LCBbeDExXQorCisJLy8gZ2V0IHNhdmVkIHJldHVybiB2YWx1ZSBiZWZvcmUg
U1AgaXMgcmVzdG9yZWQKKwlsZHIJeDAsIFtzcCwgIzB4MTBdCisKKwkvLyBy
ZXN0b3JlIGNhbGxlZS1zYXZlZCByZWdpc3RlcnMgZnJvbSBqdW1wIGJ1ZmZl
cgorCWxkcAl4MTksIHgyMCwgW3gyLCAjMHgwOF0JCQkvLyByZXN0b3JlIHgx
OSwgeDIwCisJbGRwCXgyMSwgeDIyLCBbeDIsICMweDE4XQkJCS8vIHJlc3Rv
cmUgeDIxLCB4MjIKKwlsZHAJeDIzLCB4MjQsIFt4MiwgIzB4MjhdCQkJLy8g
cmVzdG9yZSB4MjMsIHgyNAorCWxkcAl4MjUsIHgyNiwgW3gyLCAjMHgzOF0J
CQkvLyByZXN0b3JlIHgyNSwgeDI2CisJbGRwCXgyNywgeDI4LCBbeDIsICMw
eDQ4XQkJCS8vIHJlc3RvcmUgeDI3LCB4MjgKKwlsZHAJZnAsIGxyLCBbeDIs
ICMweDU4XQkJCS8vIHJlc3RvcmUgeDI5IChmcmFtZSBwb2ludGVyKSBhbmQg
eDMwIChsaW5rIHJlZ2lzdGVyKQorCWxkcgl4MTAsIFt4MiwgIzB4NjhdCQkJ
Ly8gZ2V0IHNhdmVkIHN0YWNrIHBvaW50ZXIKKwltb3YJc3AsIHgxMAkJCQkJ
Ly8gcmVzdG9yZSBzdGFjayBwb2ludGVyCisJbGRyCXgxMCwgW3gyLCAjMHg3
MF0JCQkvLyBsb2FkIGZsb2F0aW5nLXBvaW50IGNvbnRyb2wgcmVnaXN0ZXIK
Kwltc3IJZnBjciwgeDEwCQkJCS8vIHJlc3RvcmUgRlBDUgorCWxkcgl4MTAs
IFt4MiwgIzB4NzhdCQkJLy8gbG9hZCBmbG9hdGluZy1wb2ludCBzdGF0dXMg
cmVnaXN0ZXIKKwltc3IJZnBzciwgeDEwCQkJCS8vIHJlc3RvcmUgRlBTUgor
CisJLy8gcmVzdG9yZSBmbG9hdGluZy1wb2ludCByZWdpc3RlcnMgKGQ4LWQx
NSkKKwlsZHAJZDgsIGQ5LCBbeDIsICMweDgwXQorCWxkcAlkMTAsIGQxMSwg
W3gyLCAjMHg5MF0KKwlsZHAJZDEyLCBkMTMsIFt4MiwgIzB4QTBdCisJbGRw
CWQxNCwgZDE1LCBbeDIsICMweEIwXQorCisJLy8gcmVzdG9yZSBUTFMgc3Rh
Y2sgcG9pbnRlcgorCWxkcgl4MSwgW3gwLCAjMHhCOF0KKwlzdHIJeDEsIFtz
cF0KKworCS8vIGVuc3VyZSByZXR1cm4gdmFsdWUgaXMgbm9uLXplcm8gKEMg
c3RhbmRhcmQgcmVxdWlyZW1lbnQpCisJY2Juegl4MCwgMGYKKwltb3YJeDAs
ICMxCiswOgorCS8vIGVwaWxvZ3VlCisJYWRkCXNwLCBzcCwgIzB4MTAJCQkJ
Ly8gRlAgYW5kIExSIGFyZSBhbHJlYWR5IHJlc3RvcmVkLCBqdXN0IHJlc3Rv
cmUgU1AgYXMgaXQgd291bGQgYmUgcG9wcGVkCisJcmV0CisJLnNlaF9lbmRw
cm9jCiBFT0YKICAgICB9CiB9Ci0tCjIuNTIuMC53aW5kb3dzLjEKCg==

--_004_PN3P287MB3077A99C408AEF13C8036E4C9F95APN3P287MB3077INDP_--
