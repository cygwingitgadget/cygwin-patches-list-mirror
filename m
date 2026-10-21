Return-Path: <SRS0=QmHi=IL=multicorewareinc.com=aswin.kalies@sourceware.org>
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c408::3])
	by sourceware.org (Postfix) with ESMTPS id 364FA4BA2E22
	for <cygwin-patches@cygwin.com>; Wed, 21 Oct 2026 10:43:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 364FA4BA2E22
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 364FA4BA2E22
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c408::3
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1792579408; cv=pass;
	b=vO8BSDSH6TmhYb+5cWjjK+SF+7oTNFTY4L4uGLlESfToByga5CtcEr/vbN02MurPjOIHplhnaA1dX+zK8Qe3kidSYwQwcxNTaCvqQOtuc91x91BYIhOaEXYzn4mxuA1CDLjcQ67FG6Mdd+K8A1eS/2rIaiY2zMRLoCP0SDxrmWs=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792579408; c=relaxed/simple;
	bh=1IaCD2FKxyHMcb/qTN23ycRyjaaq5TfAfJqHqRymnlo=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=Z0GpAcawAx1yUClAdf8b8AXy+QtTC33PUtyE+sSyG/nkJLN9WpFFnpwKvuu7CjxkM7GGocODBo5ho9NZsV0rCWamlQrscCYalNdZce0rBpsY81kuoc0ZbhC/juYXcaORMdCGlbiZdHpyyHdzyReHdGG/8Ha+OsM2EAIjrjGcOg8=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=W1FyH8AP
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 364FA4BA2E22
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=W1FyH8AP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wu4eM+HIgWunvcI1BMetvjgYYnjg7+KsgovCZtmnAPgEMElUzBU0lJepN64xb3j+hPRF5VDYzbSZRsK85u6t0ZEROy2gNc7OHnkoaEs3ghxD8avCmhpOzIZqCKkEHXmKTwPaqEUrYS0tiexx3sR6G5h7Wm/e0UmroUPIoeswklQhk3rGWR28vDRqAJ8eka4bl5MxRsnLnmSGDn6sGiKlxl+x8DSf24XnhwpG/9BiqV8jkedjqq7FsKm3DdTdmCl8o5/Cita59ej+POrjRur0NWljku46/wQOOKQEjvRMD+IlFpzSupT/K4OWMeYy3LNiqGtwcEBsojam3dP1vdrvjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1IaCD2FKxyHMcb/qTN23ycRyjaaq5TfAfJqHqRymnlo=;
 b=tu9KIajGaN5NuBB/qB0/63xjCA+JjxRU/nc7LNB4zX4ldEXgzj0pLdDOwdZ34defy3Axugo1pVldShRVZL/78cfZ043WsJHZZHGzUJJkZZFWxQu4I52XVPT+nDxevteJlqUYtkxIP2Eya0g4Rs+Qwtq8FJugMw1U3eRrI4coUHFh2fQ1nK5CnbY8rk9avq7Z+UzQosH0jqmUKQR3BWz3Z9yNmN2rWrplF7sYWTWLnUi0pbKkCa3hTWeCgJQsfDfiaVNH9pHo/g+jUq6/xmuMUZwQoSPRfu8/3q7TPNltjPobps1x/wZqLSZ45YLmHwbMMrFvBGrYdK79i8uioFJmpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IaCD2FKxyHMcb/qTN23ycRyjaaq5TfAfJqHqRymnlo=;
 b=W1FyH8AP1CIwD9O+laptN2CvxR3WHah3LC1lV5mSy3HVWJ7b6vYlL21fq+1Y2WuKMpTJisolerKflRWxuFxGfFh4t95ZQFhnOHKk7nCCX3zj8TolNWn4JNYVSMTMtTK1CoKxhIiPEascuGo2srcpIRzKjbskREBy+jMePMnggWtGpTab5Uv92ieHXqfdChp7VWiBy3I1AULzZESyYxHRTO2iFR52LV6eRH7Tz8G1zJTuFZVU5QVeFu2UUdM6tjzc22DPNRQjwSJk5Gxj4sr3BynB58w3oPzxnxI9dx7WJSrBDwtb480QstEfq6TWn7ugVMR1XA2ds2ZjrcKW1PvlvA==
Received: from PN3P287MB1320.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:193::14)
 by PN7P287MB775004.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:363::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 10:43:21 +0000
Received: from PN3P287MB1320.INDP287.PROD.OUTLOOK.COM
 ([fe80::8f7c:54ae:2172:b97b]) by PN3P287MB1320.INDP287.PROD.OUTLOOK.COM
 ([fe80::8f7c:54ae:2172:b97b%4]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 10:43:21 +0000
From: Aswin Kalies Ramkumar Mangayarkarasi <aswin.kalies@multicorewareinc.com>
To: Jon Turney <jon.turney@dronecode.org.uk>
CC: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v3] Cygwin: autoload: fix ws2_32 chained init on AArch64
Thread-Topic: [PATCH v3] Cygwin: autoload: fix ws2_32 chained init on AArch64
Thread-Index: AQHdYUfGWayWKotqfkq4F0FTcA5u9g==
Date: Wed, 21 Oct 2026 10:43:21 +0000
Message-ID:
 <PN3P287MB1320160668DF2DD69F936579F7662@PN3P287MB1320.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-GB, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB1320:EE_|PN7P287MB775004:EE_
x-ms-office365-filtering-correlation-id: a7b66839-0733-4f3a-ce74-08df2f602075
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|31052699007|39142699007|23010399003|56012099006|8096899003|18002099003|55112099003|10067099003|38070700021;
x-microsoft-antispam-message-info:
 LlqOBT70/yhnBuzJeobefmqb8B604dAF7l3oijns68Cj6Kmug2dtOBRvMsp7B3zF9tGez6R6eznHXDbkGdSiuIIzManLMOqVfc1ZVO6TuKXJT7tQCmQ7JAu3PT+jFISPIG7mjsTfGZvOWxMQKmjRkpXDnw/+7GRCWWWj2zr6YqgFZePYqngsHcI4v4+a7NO+qY53KiES61rKz5yzmeW/jAKr0KWhHD2GclvOBwIaeCN9lJeer9v3tbv80cCtvoaEuS/UyVpvF1v4AMO3ThyGAIwvJfROOztOEQulz279+OIwlAN3owz7AkP8uKEf/fjWgsbUu5oyARR9K0QBErVtoIY3D3zVUB7+m2hqTbfAFeWkLQzoHwvcTAr4okuDNUTqJNMUPGFhwio5F91bjfJB/JphsSXhTeAdbtqwB3ShqDgEOnJ5ZHHG+HbCl7hQWEmUwZ0VyUNozU9IuN7MYjymzHvYBA9m0P1rn+nzDCk0GlYQ0P6r5f5pTakvk9Dgn6tiLpJmD9DLFO4mIZOxujbc8Q0mpbbCXh2fW7MDa6KBOBqZ9Kg9Tvb4BCDhgLWkAUnXM2DMngCXTUPIjd+Np5N7hxNv/6sut2oI4noEcH+bT/SGDC/j3vPDLa2SnweX9pisxbnvRQYQXq4HafmEf6Z1QcpzUph8+MqBQh288APq66XV83lLypt72lcmukCJ8e7ecR7M9kaumRbiNd1z4Oejvn2wWo4R3xVWGlSRLp2PSoA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1320.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(31052699007)(39142699007)(23010399003)(56012099006)(8096899003)(18002099003)(55112099003)(10067099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?NPO7F9lhr1j5gbIgKKl99saqlvlziOIDIupmt5Xa2YqtrU02LQ2rW8Dl?=
 =?Windows-1252?Q?bxlPj3kJC1ZtujMIcWkd6WnycZQikoe3r/l1htDppkWng9LnEwIKBOxW?=
 =?Windows-1252?Q?FNzSzE/a4TccGf3b08XnpVGXBlSfaOpWI82dJyJDcSVMnUFi20MdgGpC?=
 =?Windows-1252?Q?hwYPlaAOzeAEJScC03tjiFOwGqZrshU5YrZjryDbtFc05AMBCEM/cPxs?=
 =?Windows-1252?Q?kDLmoZH/OshlQyds7tZryx6IoufIWYK8e3Z9Ifj0IX8E6+59uaWb7buT?=
 =?Windows-1252?Q?PIYHKcfJ2qpQj0YMb9k/Hhl6kqQ/83Tbru6vok4AiolqDoZk4voNjSAD?=
 =?Windows-1252?Q?TbXckQKOi6ptaCCBdkmdaAkf5JANzn9RtFlW1Lw7pRcsEtUUcGf/x7Wm?=
 =?Windows-1252?Q?rlonjEUqErRGGXFLgT4T7QZEJ91zaslPcjsidBfK8bRtB7K2s42vjhEV?=
 =?Windows-1252?Q?+JzWxUMxyUMGNTh2HpIcH+uj4Bf2R+9XTgsSutAHiJF8dyK6AZriVSKS?=
 =?Windows-1252?Q?DkiuBEFHzSyX63EEERexrIQmziN63lml1C96jWxbQj8QRprb2V/ompli?=
 =?Windows-1252?Q?v7HcWjGxTUO9qHxvqho7POTO4HOrJAEs/hPc0dNrlw60WmlnTeJeVk4X?=
 =?Windows-1252?Q?q6qx1UgjL34P/ceGXrPW+OMw1qJA4SFODeYIvGtlUQCOS2FICW1oLq/U?=
 =?Windows-1252?Q?G0IsgzJTG32LFUMCw0DMGQE67ZivUuc+2kln10LsY9JJzL/MLDC6Y99g?=
 =?Windows-1252?Q?VIlyLa2rYDaPmuFtHbGVOoQos7xoDIeL0wuJTt8wsTHPSFSzfl1wTI9p?=
 =?Windows-1252?Q?+c43lme5YktoBcBlqOkHSE4GmuDoRIzMuTvjs4iLTDBER01UdR+/FSa4?=
 =?Windows-1252?Q?QW9NUyGrZESE4a3F7lg2GT4qCpm0HvxT4zSMZlel9zOeTiaLKXzuGSzm?=
 =?Windows-1252?Q?y1K7s/UNZOR4IXQ1FFI9pb5PWlekU/8QEkl+wqSicDWBx3t6s11PQfoP?=
 =?Windows-1252?Q?1PuxMviCzYa7tKW0gB2AqHOe/etLZBgwE8BECE6yJdHtTWjlh2mcDAY8?=
 =?Windows-1252?Q?LSujn2yiDzS3ymr8EdNZwZLNPsEhceAkkUKI8FAwejD0Ib7N+zqMsxf6?=
 =?Windows-1252?Q?E9UIpWfCLJZC5QFcw+BuMsd3Vbk6YZWIvRA8ZCC62PEjJbozsEbwrH7C?=
 =?Windows-1252?Q?h/VQsB+zQpTevfnHpjVVnv4/Hs+Xlx7oB5XZXc5rJZnjEHHG5omP0AEx?=
 =?Windows-1252?Q?wXOVaoque1J3msdHfghov3LtAExbadIirwJorlvkRLFoNFO7l1R1t9Yw?=
 =?Windows-1252?Q?kn470tb/ZDZ5EtqlxRxz2sXHPA35uiTPBR2phJKIYCn7iKkRo5+H5uAk?=
 =?Windows-1252?Q?9Win2ry9Vuox1B5SSMH5O/xRbaWbB93uTU21z+yn9Juc2ndl6nYyaiKo?=
 =?Windows-1252?Q?1cOk3tJquCh0Z4xNl5oQsahyTSFPq3+RmsyQQhXcBncxSFfI8cyKqJlg?=
 =?Windows-1252?Q?2AW6MXWMy+h0qVByXoQhAnb/qgXZkLHtomHjjXPC9ULorWTMZoGN9HEJ?=
 =?Windows-1252?Q?MADgltLhdcKs1IWTu5o3sXtrwh69bdC3x1NEjKGWWrsF8OUzsF+BZAxJ?=
 =?Windows-1252?Q?OXJdPj3knEaOSYmmlDOE0gq6aZChIRoAaWnqUHX9WQEZxUtH549EAKz7?=
 =?Windows-1252?Q?5bvo5wVC7Um0YjGN/+iDRgxI1uyzsEMnTSJsJqhJRd1n1yM/r1nSgkDX?=
 =?Windows-1252?Q?ZUUsHidVdjGE+4PdApfBgW1tySrME7utnwwwRzrfBLKhafOdnD+lDPta?=
 =?Windows-1252?Q?n5Egj2BRcB0nc1s0XxOLmMgPSKLHk2vgYAN/IVqvKr5dLtv1wxxgwwao?=
 =?Windows-1252?Q?Zd1MPrDb8VYg1HV0FFixKZve/7+54G57dbg=3D?=
Content-Type: multipart/alternative;
	boundary="_000_PN3P287MB1320160668DF2DD69F936579F7662PN3P287MB1320INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1320.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b66839-0733-4f3a-ce74-08df2f602075
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 10:43:21.7755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a2ii2DeZ0ebcp5KkgkwstHL+GNhXnPL9DRSeNeyZRt/4SzeBbYnHp0glIXLGhonwqw9SDLhzkZi+Wat3q/Jy1F2oUk6hFS3XQwT09gbJQRrn+8ySMAMnnSSm6yfsiqNl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN7P287MB775004
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GB_MSAUTHSOURCE_INDIA,HTML_MESSAGE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_000_PN3P287MB1320160668DF2DD69F936579F7662PN3P287MB1320INDP_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable


Hi Jon,
Apologies for the delay.
Following confirmation with MulticoreWare management, I can confirm that al=
l Cygwin patches contributed by MulticoreWare employees =97 Aswin Kalies, C=
handru Kumaresan, and Thirumalai Nagalingam =97 both past and future, follo=
ws the 2-clause BSD license (BSD-2-Clause).
Regards,
Aswin Kalies
MulticoreWare Inc.


--_000_PN3P287MB1320160668DF2DD69F936579F7662PN3P287MB1320INDP_--
