Return-Path: <SRS0=acxd=75=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazlp170110002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c409::2])
	by sourceware.org (Postfix) with ESMTPS id BCC474BA23D2
	for <cygwin-patches@cygwin.com>; Sat, 24 Jan 2026 18:47:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BCC474BA23D2
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org BCC474BA23D2
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c409::2
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1769280453; cv=pass;
	b=KxRC+ClpWaO64MzsW6wV77r5ILh8i2NO37Tek9JEEq+1WQMvnh4HiqFl41djvrDFJmS6ESTPBiTf0CCOK7KP5H5mes9CwGLACUqxL4HdYt6unLiiOSnv/fQNSpNt7zUM1kN4h6ird3H2NeffI+mpqtdR68DRREg1goi7Nfx5g08=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1769280453; c=relaxed/simple;
	bh=EGyxUFa0ad/a8yDmwqGscJpTi2453sj107oCedsNPeo=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=dIhWMnJCShqGoRlCGqmq152jO8FW5RbloThzTHauPRIjrmKyBQmmbpqR0fcQ7dkuxDrQEPIljGvizEMnueSqFa/QUHVMmRkuDzSc24gpgunndrlN5z4ME2iPJGCFxlw/+NNE9U/ei+4ANxD2HgizUnJ747jDZ+4N7r7hIy6Efl8=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BCC474BA23D2
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=WRKqWaaM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uiH4xOhiLT1+imqTm1JfQdLFwIZBvmcQ7DUDFJbxb0xy+VG1qCMoiuxd07gYTWqNR/psSNlC0tYDWmgOsNdGHhx2pz74FfrjZgvudLqKCibQmMkbJ5HSseT+yjdsb4R5ZIrQYhaRigfbBD1pMN9RTUMFly0lFWMQ+46HoIz23JgcTmgAvYQ6KjjFy+LD4qbG6n+mO9IhhXVoJ2LHTkMTCTsH0WRfZGeEhKWbIFZLDsNvqx0t9JopowZWzkhI6QgfegzXH7hJdg/9MQgDLehI7xIXIuX9fGvqOdRdf/wSpbhBysNJmAmPo/5s4pmF/gZjCIt87L2hOOD26C4Dy0qs5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHF9K+pR8zTyWADPbNkhfomyEAK4FbNC4+3YRbo4iaQ=;
 b=k/skcsqxDrhb0DUqV5VRFKj3jnOhljdnBcitVHgZ+yCWegcBIfNJQ5iEmAiRHq+fMJ9gxPXbYK9nOqBh8dbdgWj+MNqaEdoo8QGMuyfD+Z6az2deHuq0c+27MSHupUbpTANDwvE08N6z9Id1bh797vqy5NjMJV4i+01WOzUHgP0C2MwbRvRDY6K4ZmCeFuXW8n+g55pqRkP+YlSUALlpfAfratV+olt2fAOxkL+pVpYUCyLSiXKwGOPxvo+CucIH7XmTSE7jVILcaO02COpuWz8LV1X3r73E9R09pj0WAtS0etrjy0Ncim4GLChg7mhRYnTmwH0+Ao8BhT3Vh5Eq0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHF9K+pR8zTyWADPbNkhfomyEAK4FbNC4+3YRbo4iaQ=;
 b=WRKqWaaME1mFMY681L5MkBVSmlaGaxAc82HihA/B5+TRjOB1S+DGlt3Sp3dDIPx41bA316Rnhdk3dTC848EYTl56smz1rUYXVWSNjY+GBMs1uf8qKLYdQwGnJlcEh7uWrqAVZ+4AQOqofu4pX6NfUwuE4SZEBkHwgNmOzjCbaqHofVTLRILAokFMTx7lqa52mP3ZJjWZu9pc3nPT8AmvgKyMViIiIrM7y0tnF6pRAtSQBTlzlTdNkroW/O/dnA2NVVX7gSgdHqmkXrKPs52NJRxz4QC39ojnSqIXTIfiglA3iwxoez3bQIS8i+mVdIiAb5q6gX67ZoLftp/zva541w==
Received: from PN3P287MB3077.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:226::14)
 by PN2P287MB1454.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.5; Sat, 24 Jan
 2026 18:47:29 +0000
Received: from PN3P287MB3077.INDP287.PROD.OUTLOOK.COM
 ([fe80::48eb:264b:989d:5de3]) by PN3P287MB3077.INDP287.PROD.OUTLOOK.COM
 ([fe80::48eb:264b:989d:5de3%6]) with mapi id 15.20.9564.001; Sat, 24 Jan 2026
 18:47:28 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
CC: "Igor.Podgainoi@arm.com" <Igor.Podgainoi@arm.com>
Subject: [PATCH] Cygwin: gendef: Implement stabilize_sig_stack for aarch64
Thread-Topic: [PATCH] Cygwin: gendef: Implement stabilize_sig_stack for
 aarch64
Thread-Index: AdyNX8A0HheKB0X7Q1WtfnXac/6ehw==
Date: Sat, 24 Jan 2026 18:47:28 +0000
Message-ID:
 <PN3P287MB3077A9FBEF7358C49A71B1699F95A@PN3P287MB3077.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB3077:EE_|PN2P287MB1454:EE_
x-ms-office365-filtering-correlation-id: 91ba8e73-9f3b-40c4-a829-08de5b790650
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|8096899003|4053099003|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?e4RAIed1BowLqBk30CZF81XsbMrTqQAZozWjYojSWmrs1nxOuMlhyH5z5W?=
 =?iso-8859-2?Q?sEbTx+89CyNWv63vax4NwlTo38BHgnx/VJDiXJAdZXPiL7CRdOaA/ZsnYI?=
 =?iso-8859-2?Q?X+pMm0nw3dRObQeK64uXRX5AXB0/1QySJqaMUY2wdXBRSIWJEwLWoZJJ65?=
 =?iso-8859-2?Q?fBLWIDizKYiwx5EGqnybon1rCayU+erlm6HSY9jflRHqqw2/zS59Hn57Cd?=
 =?iso-8859-2?Q?NSHFggUidZjjgf8JeDJ5JkZ0rsDFtaYhAttrVqW9zlmjFEFRRaqvMFaZsB?=
 =?iso-8859-2?Q?vvK5ED452KkQEQSN54eQXZwsbtEX1vI+p+MbPC0FF3TJle7ijhSdAXGTLi?=
 =?iso-8859-2?Q?G04m/Y+aLqtDmw4qjqB7aJyR91p17ff0vBi/ZrSPQFTkMhFbY+9r01SNvk?=
 =?iso-8859-2?Q?204VYRzRW5hdhaY7F+heVi55WQ97let5sWjHHcQFXrrTzvjKn4PkawM52J?=
 =?iso-8859-2?Q?OKM5iivAm4rDGyE/kbkyUq8S7b2zcl/4t9VAejmYeP+CoFY1k9UzQBY1CL?=
 =?iso-8859-2?Q?G4ybZtnCrdHd073vaNOEe6EwEwX0mPfFz6IAb9fCB8PPA1WO7FSPtriRxZ?=
 =?iso-8859-2?Q?XdPrD2HlxuER3qa7gnPj1j1xe9dShIMnTSS+qfLBt252akQOUDULl90LKO?=
 =?iso-8859-2?Q?UPJeDN4NFa0C6fZFtiEWLvmRqMcGWpC/wKvQdYmkm5ckX6i0jhnfMPWGgG?=
 =?iso-8859-2?Q?y86hnrGm/Uvd5Dn+44ej6B1+FlIy81dRp1g2umOYIDIR53rg1YIR/odGze?=
 =?iso-8859-2?Q?y0jVXK+ra7w+to1szvaosGOdBH55S2KTSvzxFZhXWFOCI3mvqTm8Tkyk/K?=
 =?iso-8859-2?Q?iWZTG/Sm0sUKZ3x2gZpuEqLTE8ooxj7/yZgxErLPZ0ZYVvjAY/HnODKUPV?=
 =?iso-8859-2?Q?PIsgMuHeNIyZsIUlqPO9pbii58twD022ew7yREdAm0aXz6KmEgC8fzOT/T?=
 =?iso-8859-2?Q?zxHCW4K7Hpb0b41azuBkNgNRM7D8VxyGBGDc6cthXAnMmjOThlH6/4BaOD?=
 =?iso-8859-2?Q?e0EgLEjlrwkTAmKj59zwgFrWc8LVOvdWNh4CKChZSW0PsdMlRgwgTCte6i?=
 =?iso-8859-2?Q?Gy53BIVhJgysSwPTX/7mCfazDy/mbY6TbFEhqKoO9lR45FD+34DUxR8Es7?=
 =?iso-8859-2?Q?YSKhdqQsV945KJkJQga9zUx+3jfUG2M2Jk3cwRVzoAHc231f3Et6u27MH9?=
 =?iso-8859-2?Q?2rrQ6JZnqUEMPNEXEu0Q769ZRCE5RAjFtdC8DOz9zXnKdQPxGQIBkEHg5o?=
 =?iso-8859-2?Q?ujD0BEmZ2xL8opSVKAvw1HGhvnkjG1AATP6WZ+AnbQEMMpFP0Ctel7//H6?=
 =?iso-8859-2?Q?3KqdQT+eLYMnL5kmuwFvBFLDKirnbFE7kTw1i1V9Nal8iK7zddOF8Oiyti?=
 =?iso-8859-2?Q?t+MutwqeX4JAbHBKBVUcKYjkrlzOmv72ONdpYZaUGMaDHEe/ESaEL70UeO?=
 =?iso-8859-2?Q?yvQa2Gy9a4cqe+azYPXwL12SJCOzh5RAI4CbfeJ6agqaEykRqWTUxLI0VW?=
 =?iso-8859-2?Q?WfcjeOpGk7f3ezxfMRVcoYoGedCdFv3rW/Pnztvc+jsIIklL2oiBcqDVXd?=
 =?iso-8859-2?Q?7ng+/m+KRaeII7cjoeNVe0oTr25n995F/fQPoDbapOJo29FQor+IpdKLZl?=
 =?iso-8859-2?Q?JiqA3Xh71JWq2EODE1V553YGnMtdsZJGPL4Nzf2VJqN9aLNV+oedsfwrAy?=
 =?iso-8859-2?Q?1vI/twqTqiHtd/n3uOk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB3077.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(8096899003)(4053099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?vQKRbC0QS+39ygk1XAMqSDZsa38vf1nQgBBAoVu0x3zasW2i5TMSF56RgJ?=
 =?iso-8859-2?Q?enF9snnZdy6K1Poa+MWP0qiB7HEvafkX5l6BiZaL+psXqilU5AD3u02cWy?=
 =?iso-8859-2?Q?W9vz6uMxcsOTZIgBeGkDhpJvlwJOnSKNxeSIESZgR0O4BS+8JSKkcLd42i?=
 =?iso-8859-2?Q?eU9aYZYtaIqzqAPGKwRTAVXGp0jK3hGly9FMlhfAiKyUR2RBvqwIZ4/OGF?=
 =?iso-8859-2?Q?UeksOVflWeOZ1WLyyk9IKL2qzTOzDic4fHPg9gDcTX+EWIYNHLBmCieBox?=
 =?iso-8859-2?Q?95YRUxh/eRSEJJGSrUaoQxb3CrjXQyG9Z/ua18Wc3nebnWrjqLHl6/S7I3?=
 =?iso-8859-2?Q?hKERhVRBC9L84DpG6pPnC/XcaBw46EDlt4MUhgZBXMzq5xGlMVZT7jTpI9?=
 =?iso-8859-2?Q?j/weHIlNabg3FLzABFs2Kb/1D36tGMZAWGAMi8tiABRiTkNbqapZ7aQ5hD?=
 =?iso-8859-2?Q?yOUMqrcCs4wXWbyuqN7HG4VG2IgBlP1jx7lWCD78a3P8VBu6Ra8ylkZPk2?=
 =?iso-8859-2?Q?PH7TztdKyW0Y8WZ6+911QmFwsyJ02kVeKc/BuE/1ZU6DtK/NN4XW73f6mG?=
 =?iso-8859-2?Q?9d6yKvv92w9P0sD4HgiQeo1pA9UQaaX2DLfoqnThIwWXIbgcOjXoIT52/6?=
 =?iso-8859-2?Q?0vFc7BlTmLo5JvILEWp9lx6QmSMvWtCzM5eS8yNYcrqPfx80nXNLSa5y8V?=
 =?iso-8859-2?Q?fgqulfeDU1NLrF+e2Rknfjck6RCJgges4U9SXi4NqXl+sk+PJvD4m2hnrf?=
 =?iso-8859-2?Q?5XPRazteLc66vayt5rZWBnl01q+fumnjCeHx4uIlsKafjfpCpPSznoxjUI?=
 =?iso-8859-2?Q?IN62Ou0WLfgEy5RBHCPldPlLziY5ZtfcWbMc/WDCgCvnmy3TIbIg6kGI2R?=
 =?iso-8859-2?Q?qyAujJQg6M23/6sumLGmn7JnA2th0i6iCTrU4kUKIOMa8wMFwrGrYsSIL9?=
 =?iso-8859-2?Q?UCWAp/AvnfoFzgh12IMw83bHOae/7vOTvbIvsAlj1bUEh/BAH0mzB0Gg8O?=
 =?iso-8859-2?Q?Q+EeT7Xlu2kWnny9nh9FKSTMJULtF3HkMXZBffyiknkQp7jvvegt4QTtJD?=
 =?iso-8859-2?Q?VDmiGCmuMafUzQh6KZ454EwxcSIRyMybOdnWgJ1dWZaZlENcdZvvnd+5fi?=
 =?iso-8859-2?Q?4hcZR4k/yw1RDBXXgPDF/ItF+s/BGOKqCK9cdJ/6GgnU/uZuWq49z+xIR9?=
 =?iso-8859-2?Q?Cbu0JSEjV07zyazAOlRx76Swh5vpqMnoZ6lrAA4MwyFeBZq74RMVm1l8rH?=
 =?iso-8859-2?Q?3mLoDc3jiMa7qGoGydY4ZTL6l6Odbn431pTVPmmC2EbgGUqlI0uIisQncF?=
 =?iso-8859-2?Q?cshR4e75+9sAE5mpyGzNca74xVfLzoIHXhmPBTbxmCs2qsq1gJ2ftc78YJ?=
 =?iso-8859-2?Q?PjkhH7RLOAyYaquOTTIhuSE7ctWEkVLGT94mPZk1XrVidYji0BJlpr0qqV?=
 =?iso-8859-2?Q?BvcXRmuqeZHLqApZFasEjGUxRj7Hbm+xVHJiby/P5wymROPcCT+ORSQ2FF?=
 =?iso-8859-2?Q?YduSbXsavkntG888N9y2KoDzseIkvpGKs2wqlFCnnm3Ui9WgClDAa/fOk9?=
 =?iso-8859-2?Q?P0mNuTM9HeRCpPcIDWxCkWvL5Vg05Kabosk1O/E3BTWwlDGLqBwCkUffi/?=
 =?iso-8859-2?Q?JyqDZY0+gCQTmiMh6ZyvSjgrshDORDraDqIarFYLiqv9h9wTuAu1CHYGmF?=
 =?iso-8859-2?Q?F5LLp2Hr8fGOVJNNvWVotwVTmrhcte5Kn1rwBQbrf5rJDkpgR9NRyQFuyL?=
 =?iso-8859-2?Q?pV1eE3LYv2zyZnXCe80t3JAoD4z2t7Ir/5HJkc52jeajn820alxnp3cEil?=
 =?iso-8859-2?Q?YunzQ8GACTLNjftfZqVHddRREgp5AjPQY2jT2CFqxHzN+Pep3BJ6ewI73x?=
 =?iso-8859-2?Q?Nr?=
x-ms-exchange-antispam-messagedata-1:
 2cWqGr105M6kHn2ogZTxbOj9KcOIbY9ZTmWz2MIrhsLKnFqJaqYiWs+T
Content-Type: multipart/mixed;
	boundary="_004_PN3P287MB3077A9FBEF7358C49A71B1699F95APN3P287MB3077INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB3077.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ba8e73-9f3b-40c4-a829-08de5b790650
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2026 18:47:28.7959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o9rdcCaUbPaEnU1vmzKr9xbft9XLr+rvjbJGvOxG+CODoxF8aLdWLAhk1CCzbM+g9XT2dtcO4iWf28FKiBdvPE2w7ctExY3fDABIv1lcTTtpwaMjBclOkMmQi7HA2NIaYl+3+2oZY2Fw2RUldo0NRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB1454
X-Spam-Status: No, score=-12.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_PN3P287MB3077A9FBEF7358C49A71B1699F95APN3P287MB3077INDP_
Content-Type: multipart/alternative;
	boundary="_000_PN3P287MB3077A9FBEF7358C49A71B1699F95APN3P287MB3077INDP_"

--_000_PN3P287MB3077A9FBEF7358C49A71B1699F95APN3P287MB3077INDP_
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
Attached is a patch that adds an ARM64 stub for the `stabilize_sig_stack` r=
outine
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
index ff13f1daa..0b2d3db9b 100755
--- a/winsup/cygwin/scripts/gendef
+++ b/winsup/cygwin/scripts/gendef
@@ -464,7 +464,83 @@ _sigbe:
 sigdelayed:
 _sigdelayed_end:
        .global _sigdelayed_end
+       .seh_proc stabilize_sig_stack
 stabilize_sig_stack:
+    // prologue
+    stp     fp, lr, [sp, #-0x10]!        // save FP and LR registers
+    .seh_save_fplr_x 0x10
+    mov     fp, sp                       // set frame pointer for unwinder
+    .seh_set_fp
+    .seh_endprologue
+
+    ldr     x10, [x18, #0x8]             // load TLS block base pointer in=
to x10
+
+    // try to acquire the lock
+    mov     w9, #1                       // value to store (1 =3D=3D locke=
d)
+    ldr     x11, =3D_cygtls.stacklock      // load the symbol offset
+    add     x12, x10, x11                // x12 =3D tls_base + &stacklock
+1:
+    ldaxr   w13, [x12]                   // load old lock value
+    stlxr   w14, w9, [x12]               // attempt to store 1
+    cbnz    w14, 1b                      // if store failed, retry
+    cbz     w13, 2f                      // if lock was acquired, continue
+    yield                                // yield to allow other threads t=
o run
+    b       1b                           // retry acquiring the lock
+
+2:
+    // lock acquired, increment incyg counter
+    ldr     x11, =3D_cygtls.incyg          // load the symbol offset
+    add     x12, x10, x11                // x12 =3D tls_base + &incyg
+    ldr     w9, [x12]                    // load current value of incyg
+    add     w9, w9, #1                   // increment incyg counter
+    str     w9, [x12]                    // store back incremented value
+
+    // check current_sig
+    ldr     x11, =3D_cygtls.current_sig    // load the symbol offset
+    ldr     w9, [x10, x11]               // load current value of current_=
sig
+    cbz     w9, 3f                       // if no current signal, jump to =
cleanup
+
+    // release lock before calling signal handler
+    ldr     x11, =3D_cygtls.stacklock      // load the symbol offset
+    add     x12, x10, x11                // x12 =3D tls_base + &stacklock
+    ldr     w9, [x12]                    // load current value of stacklock
+    sub     w9, w9, #1                   // decrement stacklock
+    stlr    w9, [x12]                    // store with release semantics
+
+    // prepare arg and call handler
+    ldr     x0, =3D_cygtls.start_offset    // load the symbol offset
+    add     x0, x10, x0                  // x0 =3D tls_base + &start_offset
+    bl      _ZN7_cygtls19call_signal_handlerEv
+
+    // call may clobber x10, restore TLS base
+    ldr     x10, [x18, #0x8]             // reload tls_base
+
+    // decrement incyg
+    ldr     x11, =3D_cygtls.incyg
+    add     x12, x10, x11
+    ldr     w9, [x12]
+    sub     w9, w9, #1
+    str     w9, [x12]
+
+    // loop to handle another signal
+    b       1b
+
+3:
+    // no signal to handle, decrement incyg counter
+    ldr     x11, =3D_cygtls.incyg
+    add     x12, x10, x11
+    ldr     w9, [x12]
+    sub     w9, w9, #1
+    str     w9, [x12]
+
+    mov     x0, x10                      // return TLS address in x0 (retu=
rn register)
+
+    // epilogue
+    .seh_startepilogue
+    ldp     fp, lr, [sp], #0x10
+    .seh_endepilogue
+    ret
+    .seh_endproc
 EOF
        }
     }


--_000_PN3P287MB3077A9FBEF7358C49A71B1699F95APN3P287MB3077INDP_--

--_004_PN3P287MB3077A9FBEF7358C49A71B1699F95APN3P287MB3077INDP_
Content-Type: application/octet-stream;
	name="Cygwin-gendef-Implement-stabilize_sig_stack-for-aarc.patch"
Content-Description:
 Cygwin-gendef-Implement-stabilize_sig_stack-for-aarc.patch
Content-Disposition: attachment;
	filename="Cygwin-gendef-Implement-stabilize_sig_stack-for-aarc.patch";
	size=4050; creation-date="Sat, 24 Jan 2026 18:45:29 GMT";
	modification-date="Sat, 24 Jan 2026 18:47:28 GMT"
Content-Transfer-Encoding: base64

RnJvbSA4MTU0YzIwYjUwNGIyNzYwZDQzYzdjYmY3N2UyNzRlOTVlNjM3NWU0
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFk
ZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRlay5iYXJ0b25AbWljcm9zb2Z0LmNv
bT4KRGF0ZTogU2F0LCA2IERlYyAyMDI1IDE5OjIwOjEwICswNTMwClN1Ympl
Y3Q6IFtQQVRDSF0gQ3lnd2luOiBnZW5kZWY6IEltcGxlbWVudCBzdGFiaWxp
emVfc2lnX3N0YWNrIGZvciBhYXJjaDY0Ck1JTUUtVmVyc2lvbjogMS4wCkNv
bnRlbnQtVHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD1VVEYtOApDb250ZW50
LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0CgpDby1hdXRob3JlZC1ieTogVGhp
cnVtYWxhaSBOYWdhbGluZ2FtIDx0aGlydW1hbGFpLm5hZ2FsaW5nYW1AbXVs
dGljb3Jld2FyZWluYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBSYWRlayBCYXJ0
b8WIIDxyYWRlay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KU2lnbmVkLW9mZi1i
eTogVGhpcnVtYWxhaSBOYWdhbGluZ2FtIDx0aGlydW1hbGFpLm5hZ2FsaW5n
YW1AbXVsdGljb3Jld2FyZWluYy5jb20+Ci0tLQogd2luc3VwL2N5Z3dpbi9z
Y3JpcHRzL2dlbmRlZiB8IDc2ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDc2IGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL3NjcmlwdHMvZ2VuZGVmIGIv
d2luc3VwL2N5Z3dpbi9zY3JpcHRzL2dlbmRlZgppbmRleCBmZjEzZjFkYWEu
LjBiMmQzZGI5YiAxMDA3NTUKLS0tIGEvd2luc3VwL2N5Z3dpbi9zY3JpcHRz
L2dlbmRlZgorKysgYi93aW5zdXAvY3lnd2luL3NjcmlwdHMvZ2VuZGVmCkBA
IC00NjQsNyArNDY0LDgzIEBAIF9zaWdiZToKIHNpZ2RlbGF5ZWQ6CiBfc2ln
ZGVsYXllZF9lbmQ6CiAJLmdsb2JhbCBfc2lnZGVsYXllZF9lbmQKKwkuc2Vo
X3Byb2Mgc3RhYmlsaXplX3NpZ19zdGFjawogc3RhYmlsaXplX3NpZ19zdGFj
azoKKyAgICAvLyBwcm9sb2d1ZQorICAgIHN0cCAgICAgZnAsIGxyLCBbc3As
ICMtMHgxMF0hICAgICAgICAvLyBzYXZlIEZQIGFuZCBMUiByZWdpc3RlcnMK
KyAgICAuc2VoX3NhdmVfZnBscl94IDB4MTAKKyAgICBtb3YgICAgIGZwLCBz
cCAgICAgICAgICAgICAgICAgICAgICAgLy8gc2V0IGZyYW1lIHBvaW50ZXIg
Zm9yIHVud2luZGVyCisgICAgLnNlaF9zZXRfZnAKKyAgICAuc2VoX2VuZHBy
b2xvZ3VlCisKKyAgICBsZHIgICAgIHgxMCwgW3gxOCwgIzB4OF0gICAgICAg
ICAgICAgLy8gbG9hZCBUTFMgYmxvY2sgYmFzZSBwb2ludGVyIGludG8geDEw
CisKKyAgICAvLyB0cnkgdG8gYWNxdWlyZSB0aGUgbG9jaworICAgIG1vdiAg
ICAgdzksICMxICAgICAgICAgICAgICAgICAgICAgICAvLyB2YWx1ZSB0byBz
dG9yZSAoMSA9PSBsb2NrZWQpCisgICAgbGRyICAgICB4MTEsID1fY3lndGxz
LnN0YWNrbG9jayAgICAgIC8vIGxvYWQgdGhlIHN5bWJvbCBvZmZzZXQKKyAg
ICBhZGQgICAgIHgxMiwgeDEwLCB4MTEgICAgICAgICAgICAgICAgLy8geDEy
ID0gdGxzX2Jhc2UgKyAmc3RhY2tsb2NrCisxOgorICAgIGxkYXhyICAgdzEz
LCBbeDEyXSAgICAgICAgICAgICAgICAgICAvLyBsb2FkIG9sZCBsb2NrIHZh
bHVlCisgICAgc3RseHIgICB3MTQsIHc5LCBbeDEyXSAgICAgICAgICAgICAg
IC8vIGF0dGVtcHQgdG8gc3RvcmUgMQorICAgIGNibnogICAgdzE0LCAxYiAg
ICAgICAgICAgICAgICAgICAgICAvLyBpZiBzdG9yZSBmYWlsZWQsIHJldHJ5
CisgICAgY2J6ICAgICB3MTMsIDJmICAgICAgICAgICAgICAgICAgICAgIC8v
IGlmIGxvY2sgd2FzIGFjcXVpcmVkLCBjb250aW51ZQorICAgIHlpZWxkICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvLyB5aWVsZCB0byBhbGxv
dyBvdGhlciB0aHJlYWRzIHRvIHJ1bgorICAgIGIgICAgICAgMWIgICAgICAg
ICAgICAgICAgICAgICAgICAgICAvLyByZXRyeSBhY3F1aXJpbmcgdGhlIGxv
Y2sKKworMjoKKyAgICAvLyBsb2NrIGFjcXVpcmVkLCBpbmNyZW1lbnQgaW5j
eWcgY291bnRlcgorICAgIGxkciAgICAgeDExLCA9X2N5Z3Rscy5pbmN5ZyAg
ICAgICAgICAvLyBsb2FkIHRoZSBzeW1ib2wgb2Zmc2V0CisgICAgYWRkICAg
ICB4MTIsIHgxMCwgeDExICAgICAgICAgICAgICAgIC8vIHgxMiA9IHRsc19i
YXNlICsgJmluY3lnCisgICAgbGRyICAgICB3OSwgW3gxMl0gICAgICAgICAg
ICAgICAgICAgIC8vIGxvYWQgY3VycmVudCB2YWx1ZSBvZiBpbmN5ZworICAg
IGFkZCAgICAgdzksIHc5LCAjMSAgICAgICAgICAgICAgICAgICAvLyBpbmNy
ZW1lbnQgaW5jeWcgY291bnRlcgorICAgIHN0ciAgICAgdzksIFt4MTJdICAg
ICAgICAgICAgICAgICAgICAvLyBzdG9yZSBiYWNrIGluY3JlbWVudGVkIHZh
bHVlCisKKyAgICAvLyBjaGVjayBjdXJyZW50X3NpZworICAgIGxkciAgICAg
eDExLCA9X2N5Z3Rscy5jdXJyZW50X3NpZyAgICAvLyBsb2FkIHRoZSBzeW1i
b2wgb2Zmc2V0CisgICAgbGRyICAgICB3OSwgW3gxMCwgeDExXSAgICAgICAg
ICAgICAgIC8vIGxvYWQgY3VycmVudCB2YWx1ZSBvZiBjdXJyZW50X3NpZwor
ICAgIGNieiAgICAgdzksIDNmICAgICAgICAgICAgICAgICAgICAgICAvLyBp
ZiBubyBjdXJyZW50IHNpZ25hbCwganVtcCB0byBjbGVhbnVwCisKKyAgICAv
LyByZWxlYXNlIGxvY2sgYmVmb3JlIGNhbGxpbmcgc2lnbmFsIGhhbmRsZXIK
KyAgICBsZHIgICAgIHgxMSwgPV9jeWd0bHMuc3RhY2tsb2NrICAgICAgLy8g
bG9hZCB0aGUgc3ltYm9sIG9mZnNldAorICAgIGFkZCAgICAgeDEyLCB4MTAs
IHgxMSAgICAgICAgICAgICAgICAvLyB4MTIgPSB0bHNfYmFzZSArICZzdGFj
a2xvY2sKKyAgICBsZHIgICAgIHc5LCBbeDEyXSAgICAgICAgICAgICAgICAg
ICAgLy8gbG9hZCBjdXJyZW50IHZhbHVlIG9mIHN0YWNrbG9jaworICAgIHN1
YiAgICAgdzksIHc5LCAjMSAgICAgICAgICAgICAgICAgICAvLyBkZWNyZW1l
bnQgc3RhY2tsb2NrCisgICAgc3RsciAgICB3OSwgW3gxMl0gICAgICAgICAg
ICAgICAgICAgIC8vIHN0b3JlIHdpdGggcmVsZWFzZSBzZW1hbnRpY3MKKwor
ICAgIC8vIHByZXBhcmUgYXJnIGFuZCBjYWxsIGhhbmRsZXIKKyAgICBsZHIg
ICAgIHgwLCA9X2N5Z3Rscy5zdGFydF9vZmZzZXQgICAgLy8gbG9hZCB0aGUg
c3ltYm9sIG9mZnNldAorICAgIGFkZCAgICAgeDAsIHgxMCwgeDAgICAgICAg
ICAgICAgICAgICAvLyB4MCA9IHRsc19iYXNlICsgJnN0YXJ0X29mZnNldAor
ICAgIGJsICAgICAgX1pON19jeWd0bHMxOWNhbGxfc2lnbmFsX2hhbmRsZXJF
dgorCisgICAgLy8gY2FsbCBtYXkgY2xvYmJlciB4MTAsIHJlc3RvcmUgVExT
IGJhc2UKKyAgICBsZHIgICAgIHgxMCwgW3gxOCwgIzB4OF0gICAgICAgICAg
ICAgLy8gcmVsb2FkIHRsc19iYXNlCisKKyAgICAvLyBkZWNyZW1lbnQgaW5j
eWcKKyAgICBsZHIgICAgIHgxMSwgPV9jeWd0bHMuaW5jeWcKKyAgICBhZGQg
ICAgIHgxMiwgeDEwLCB4MTEKKyAgICBsZHIgICAgIHc5LCBbeDEyXQorICAg
IHN1YiAgICAgdzksIHc5LCAjMQorICAgIHN0ciAgICAgdzksIFt4MTJdCisK
KyAgICAvLyBsb29wIHRvIGhhbmRsZSBhbm90aGVyIHNpZ25hbAorICAgIGIg
ICAgICAgMWIKKworMzoKKyAgICAvLyBubyBzaWduYWwgdG8gaGFuZGxlLCBk
ZWNyZW1lbnQgaW5jeWcgY291bnRlcgorICAgIGxkciAgICAgeDExLCA9X2N5
Z3Rscy5pbmN5ZworICAgIGFkZCAgICAgeDEyLCB4MTAsIHgxMQorICAgIGxk
ciAgICAgdzksIFt4MTJdCisgICAgc3ViICAgICB3OSwgdzksICMxCisgICAg
c3RyICAgICB3OSwgW3gxMl0KKworICAgIG1vdiAgICAgeDAsIHgxMCAgICAg
ICAgICAgICAgICAgICAgICAvLyByZXR1cm4gVExTIGFkZHJlc3MgaW4geDAg
KHJldHVybiByZWdpc3RlcikKKworICAgIC8vIGVwaWxvZ3VlCisgICAgLnNl
aF9zdGFydGVwaWxvZ3VlCisgICAgbGRwICAgICBmcCwgbHIsIFtzcF0sICMw
eDEwCisgICAgLnNlaF9lbmRlcGlsb2d1ZQorICAgIHJldAorICAgIC5zZWhf
ZW5kcHJvYwogRU9GCiAJfQogICAgIH0KLS0KMi41Mi4wLndpbmRvd3MuMQoK

--_004_PN3P287MB3077A9FBEF7358C49A71B1699F95APN3P287MB3077INDP_--
