Return-Path: <SRS0=UBKG=AM=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c408::3])
	by sourceware.org (Postfix) with ESMTPS id DC1A948EEBDA
	for <cygwin-patches@cygwin.com>; Sun,  8 Feb 2026 19:30:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DC1A948EEBDA
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DC1A948EEBDA
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c408::3
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1770579009; cv=pass;
	b=hM0vSbaOIUpQPxcAlnWgnE6I+yQe6iGTgeosIXqJ1kZYLjMR50Ee+HI/cCFRcnJ4N2yT65gKRHbqzQVLBVix7rkbMV0RZQe4oS2/PbmoFDFGSLK9lE/VBFPKCannisyxZtFv6neAr0ZwXU+Fvx0/1ZRu1Jr8jXrY/tbNjuPtTwA=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1770579009; c=relaxed/simple;
	bh=clPmOqKxBbZJ+caSg01GmhrG5xHEqkN0qOl+l2Hf97U=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=RNQwpn3neRmpVNpa52JmOEv7JTZQ6COfVJcQXqW9UnUoRNHNTzIuxPbkk4qAvEkcomOxrHJBUmXRSA8Ik63kkyagNCHeHjWz3Jhp21bey9r7n//0MNPvI/T2/DxJPsbJMh4QkkEOza6SZ89mPaJj/3vOVde4085RyyvTudN61cY=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DC1A948EEBDA
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=EEOzWA1+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLUcYyn4ER4FhLLxx5XMd2Dz5mxJpkhG5ouvm5Uz0vePrAcT2PZMa10bIWOy+v2IK88Ns4LpXUkVVE7TTqzQwwBa+7BbzOp6Su094v1AfO3fHImsui7qWFz1ioXMIbQI+gGSlHRdYZWIOCNlxFrjdF+XFty5rFZXQsqmaFFoJtTlzqusaluYgEaMXUzEI9izlYWEqCZUSuTzHRRBeeXjI8IH43ROux4jNUynbhLN1td7LD9QT7JVaYdo4XPKDO4s5HDuJ54RCcK0tJd4T3HgoilorqrqVOyn9HwFW3Bx2F/FLwULZXtNZO0Y8n4/9ZmyElvbRhl47QpQkDmfOnqy+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3ou+xwXX4c19P/RHQknmKZtkaXGUVW2gFQ6TEuL0Ls=;
 b=Cc3lN5eeh6izuEqJ7tbI8rHNO/7IUaVdaOfI0X/1sJ8Z+BtdogLGjJ8a80krj9ueypa8KY/HueJ4LFeGQ4UonwOXRB24KqwM/OplYDTLKxGV5DNcuNpNsXAoPY5LDeIkw0TxEGy+t0cPz8JerS9tWgmJjnYk5DSSsih32OvqKsSMSYd4SA5xIsb/jXufqWQtUal3bHXvHBysxy2cPq22J81qK7H8L34rdK7DX5iKHbNumq2fQ2DyBG5sZPgdCe23vlqNYfn+nipcSQo88O3b/nc/eNRf+A+BAHRFlNDnLQcFgQddsYc3EBMvJu3pNkg3GtIcyroMU5YbQFV5/JGYTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3ou+xwXX4c19P/RHQknmKZtkaXGUVW2gFQ6TEuL0Ls=;
 b=EEOzWA1+LuSZPwtDvUEm4AWaeC3iiAluBw/C3tuM0Qg36/rTxsiGGsWJgfKoRP1+vPy7X2p3U1AmROL+51dJy0lrxd/8ITajULAcADkSp6daDr04/H3GNC9hS3EH//oGrTTGz/IUDEH33KhRT8bEPn3x0lzm5iTMz/s2sI6rT64IBb46sqpfit4fgM88oY8fFqO/th2TLbG7bqZ6AV/+jZXl0P/+APIC+0e21Z0sC7auJZFlV0aO9stki0JArFsZTH0RuLBnn2s8MDhgWFpimWv7hxxAXjwAyJ4VJEL0yO3XocCgbkJhW7+nxIcXBK964klkwIte4guIdvUNtpTt9A==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by PN1P287MB3822.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:256::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.6; Sun, 8 Feb
 2026 19:30:03 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::f574:2c10:ce6:4682]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::f574:2c10:ce6:4682%4]) with mapi id 15.20.9611.005; Sun, 8 Feb 2026
 19:30:03 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: ssp: add AArch64 build stubs
Thread-Topic: [PATCH] Cygwin: ssp: add AArch64 build stubs
Thread-Index: AQHcmSzF+nYfWW1EBUS/pOLNHiIPNw==
Date: Sun, 8 Feb 2026 19:30:00 +0000
Message-ID:
 <MA0P287MB30821EDE9EBFE1F1A9769E2C9F64A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
undefined: 4243809
drawingcanvaselements: []
composetype: newMail
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|PN1P287MB3822:EE_
x-ms-office365-filtering-correlation-id: 5b897bb9-e49b-479f-f3b5-08de674874f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|6049299003|1800799024|38070700021|8096899003|4053099003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?FOpZIEYugssDSTbp/y6KQwjyhMtq8oXkYDGMiYWQ4ymiYsHxJASbTaPpx5?=
 =?iso-8859-1?Q?I9MLTMz7V9cMHQBNtb3w3IsqOgrAw/yxftKDAUcHwudP78YcJBEHqUuVWt?=
 =?iso-8859-1?Q?6EqLAiFJVxFnZYuTh+G8p5ZOJtC8qGn23tPDXi3LbdJa+T208xgIHb+ZcL?=
 =?iso-8859-1?Q?E+d4kXvw2GMwglYZHNviXMeO8VHhJQ/aTBLJw3fY0L6lydOIXIBhvfEAKx?=
 =?iso-8859-1?Q?HDfEbbCW8qdD8EstKfmfBlWaUSS05VQ5t81c+8pY5G2pvLcyXdrihIRJ3f?=
 =?iso-8859-1?Q?MUo8GXIBbRlhlV7iNKpsEyW96HnrPVggmF5AGollf62VxhrR/djkkfoDgG?=
 =?iso-8859-1?Q?SRlFpzbVOlGvsKmTX+VpQUTtUkvhXGz0u9mK0wS+sgCfjZ/LlwUzebVt6V?=
 =?iso-8859-1?Q?OWklTJ+eF+PbdsfHYNk6aRaSQsMyH0vuGuL5C1UTIXuvGYVsGp+6SN3jbf?=
 =?iso-8859-1?Q?k7udxocLGFTyijIVjnHEhGXndHwnZAOyUr5irG+Deu0T4iplCVTKJ80n13?=
 =?iso-8859-1?Q?0Oj3EFHLWK+xlONrcH0zyG8qiGLi9BBCx4stEuaOVBYsF3wqbjGS19cGDf?=
 =?iso-8859-1?Q?hSPScgi+B+mtL9zFofDI7z+80+tZqXGgUSkqLKmJFNFhwaHBrXM0mt/vcp?=
 =?iso-8859-1?Q?5uy6HW54SYwdetrGb4LiR9j2trdFCSCVKZj4Yqbto114ziombD0jc6HlHe?=
 =?iso-8859-1?Q?XtODjO5QrK+kP5mqkXZ2XXkNenS9atHwl+S4l62HeoHnEZKWCo6OhI4IL0?=
 =?iso-8859-1?Q?ljR33jkS0FYa7I4RG5K4Xz0awsUn8v0qP+8pmkrOvsMSqPREPfHu1q2Zjf?=
 =?iso-8859-1?Q?1HoHLMCdSFvpDLvpuRZA6WCvAtgFHBolAmrb/P+4k+P9n2cJxziDFhSKX0?=
 =?iso-8859-1?Q?c1+b2JzDldPw3ZvoJ7q85u77s+WB6R0ABf/whckBvCRODafEBRpk+pGHCk?=
 =?iso-8859-1?Q?aGRFhVprDvwYBM0uXjoVSn8qJMdqfIrhtb5tF84eRpgbmq7HygGSOgjw8h?=
 =?iso-8859-1?Q?hHr2u6C1jI1A6VX7J+3ODtNqV4zh5A+EWlfTNozyaWNkWBb/+TPDvruQVa?=
 =?iso-8859-1?Q?8ONp6wnKkXt+rjfVscfYyp1DRe1odrhdw0dsgawm9dQyeuIV8KcblXvbDn?=
 =?iso-8859-1?Q?vKP0ClKq1m5wB5RSjQx9IXR1qksKGa/hrK/wT19UveMdEdzHSxmN1nPHn1?=
 =?iso-8859-1?Q?+Q+KS8iNHl6Nr/gb2kQHKwbT2j7cjYfLYnhInKALUzgjtcXRFVo2AMSdxJ?=
 =?iso-8859-1?Q?1x4nc8YBdNeL45IVpfYxhtxbl/j+3HASQfVI/JX1BoRUc6/r7rK5YE6e+2?=
 =?iso-8859-1?Q?Y6OcVekeCFcLiFx8WpOstTIn6JAfXVLtpiR1w1Vs0kIvKr2a6oFsEoDh73?=
 =?iso-8859-1?Q?7r+R9FMN/DZ/NjMQ8BnU9gVm/pTs2GvytDzAgQCQP6Rm+hEjmalPu38l/q?=
 =?iso-8859-1?Q?RNiVCHg9UJX/wIR0PeMixh+N8QRBFo8uuMMpHWtg7+aqgZeGjPV1LcvhRx?=
 =?iso-8859-1?Q?MDGdQHKXJK1cVUpiS7gZKwyNHGqhGntMNW6qJCMg7bJtZccEB0m2++EUvN?=
 =?iso-8859-1?Q?5XsSJAhdU1fCkT64b0uzhaj4BZkRrJhmBURZxqeX8ZGjiMomO1m0MHoYRs?=
 =?iso-8859-1?Q?v9LZ5pWc9hg8fYenVK6FucWZEMlpiNw9646uRgLQ7eT90NFynY0+NL6wvC?=
 =?iso-8859-1?Q?sNuw+4yI8Yq3S2isiVg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(6049299003)(1800799024)(38070700021)(8096899003)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?/FYoh8mb5fEQm52N+x0fbUSD3Xd/yLbiIFaoM63VHXymisGUBHjXcmBkVB?=
 =?iso-8859-1?Q?D6U0QThW3xB3lntIFLKpbr147Ib7e4DE7+bTxyvvkednUGAYb/ND1v6HWm?=
 =?iso-8859-1?Q?2zthXJJMwxKjkojZtp2di7igExal6RvrJpkoctDsJLcIJWyawnuXYa+20d?=
 =?iso-8859-1?Q?dMqnLAm4P+2Uga4+XHlHTsV5DeoPu+amio4AWspGPRXf20RyBdKHzOLv9V?=
 =?iso-8859-1?Q?ucXKPC3ZQ/lQQ/n07Fy4GJc4yTDOCW7dOx8n/SVZ7l/BhjFHwifvOFurBY?=
 =?iso-8859-1?Q?2A8AV51ykDWdjMDgDUfwAssV4dMsQJJ7hC3goKJu2B0qWwQSJWXRZbeLS0?=
 =?iso-8859-1?Q?92T6kwHFCKTRXpfre8oK2F6Ih3iPAhPbqBlzzYxRGUWT7vEl5J2xBFsmwr?=
 =?iso-8859-1?Q?MZgEhWaBgp2Vns7UQWeHAJb0LavjF5AX7T7ba4od2b4fAnumEhl5VtW037?=
 =?iso-8859-1?Q?wxeWOqCfRJPa87R2Eas163rR/WCiKfRhMStEB48UMOWlm8tE3Nh/Q61Gcb?=
 =?iso-8859-1?Q?cAid/2+/AMkvvX4zOVEHqVMV/wh7AcytNO/xJoxAnGuYlorYLic2b86XJB?=
 =?iso-8859-1?Q?8k9Xvrp4G6zfE5pgENQqAlToBfAWUmc4H6IMoGoZZWaYF/6nrrKVoM/Pha?=
 =?iso-8859-1?Q?YtWLKsUAbiA1ALiJwagrQai7lgiOPneZwko5eVQL3OY4s1pHgrQ4yjG7af?=
 =?iso-8859-1?Q?71//eAaFLZOR5geLNhLh8W30FAy1TiiOvsmAZiV6FLd9yS01WyFkoi0Qh1?=
 =?iso-8859-1?Q?rGjg5yESZftPxP9l6MDGFF/dS3U6nZFXpKDMFARblhOPFITmRH24dnqIqN?=
 =?iso-8859-1?Q?8RxQrzn4XuB2Cve6V+/z1T9f2GEuGeVOaKAMTMcPVu6KOFxxqYa7KT37pf?=
 =?iso-8859-1?Q?x4XklS3XppWNEcQIi26+MD1TMJgA52xbglqo2A+L72HvaV7qBwefwLLh7M?=
 =?iso-8859-1?Q?N3MbrNfC1IRxi6gXRlu4gAStcAZgAxcZarNTZOxdkFDRNHH8yBIltHo0o+?=
 =?iso-8859-1?Q?73JCvj5uvyRiwOJiLVnnz0m2XyisIuiNX6zauLToiEMbHSl4gw7575wuae?=
 =?iso-8859-1?Q?SNYPCrbrng2pHHaFMUSVmDkAjHZtqzePL/3cGqCZFE39TMJEfpFZun9Dwt?=
 =?iso-8859-1?Q?qOXZ7IfvXehXbMn/PHCigjBIePPrUjM54v7Sfq8mhvwi23CyWVPMzC7H5R?=
 =?iso-8859-1?Q?PLtUfvu13t3lhy0XYzwKh2D6776859nDoNZgBwatHN1NoiPEDY71w7LWQP?=
 =?iso-8859-1?Q?x5YiKT1VcrUxTE4/Ana7a7C6+xpQ04DbgTon4h7LjQyLMK4jUZBngktT35?=
 =?iso-8859-1?Q?NJL1+O3BEAPq0ay35hB/4tYtWFcZ0+/vHm4laFFeJ7Xz02mYHw+1LEVq9t?=
 =?iso-8859-1?Q?Kzz/JzomrMMu9eyh0hVnHlJX4G5EVtvXWaX9kCY9DOPJzatC83SX9OmUR8?=
 =?iso-8859-1?Q?Gfp28lS5RlUx6Jht9L/vlddqQRtVtyAaBvZ2wd5t5QtT/+2OAWLMzvKTfs?=
 =?iso-8859-1?Q?TlxBg9c8sgqX/TXb++i+GIUjswlFMlgdZ4A/7Utc+EP0kaXeeVv+XKzEQM?=
 =?iso-8859-1?Q?xiVjG9Wib2SBryzEmvB9FFAmPH9Rou9jKuVNWDoJkhKCgaQnMKGPAQbQPG?=
 =?iso-8859-1?Q?CNTULd1+WmltMrvLn6uz6uChVycnuayQ8W+0rdVgK/RQkX1sYupGL9+UvI?=
 =?iso-8859-1?Q?nqTip0hPxkQJ/Q375IE2O7quY+D+xiNEmqppRlloiSz77V9ciDLEK/RHMa?=
 =?iso-8859-1?Q?oG5XgqZWr31SH1yOvCIl47EQ/aUASBlf1m8xi8I85ZkGQ1WHIg48pIuBtN?=
 =?iso-8859-1?Q?m6xK6MhoPyUHv0PnDjKXURej7QKFFykG5ljBdTfG2MaVoY26YEgpcuDNsG?=
 =?iso-8859-1?Q?Cr?=
x-ms-exchange-antispam-messagedata-1:
 Y7QW5YIcH0b11ifS80khIpqrDeAeBAl49LclBZQFuNwXj9XgvaTZAt4puLzreKcsrO/YYx7NwZaayA==
Content-Type: multipart/mixed;
	boundary="_004_MA0P287MB30821EDE9EBFE1F1A9769E2C9F64AMA0P287MB3082INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b897bb9-e49b-479f-f3b5-08de674874f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2026 19:30:02.2998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J6hY/9uLgI9Xs5yfayqqM4GRE5rT4yIXRvFZeOPRRtRQvIVLte3nEShjNqB1aGNTigYe8lOQFEZKJFk5JOAgMBQ0uo2iFxkZjZpIuwVPEtE/lXKVLJFmkUoxEQWue/IQGU6xjsFzK67TsdiDWDjHnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN1P287MB3822
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,PROLO_LEO1,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_MA0P287MB30821EDE9EBFE1F1A9769E2C9F64AMA0P287MB3082INDP_
Content-Type: multipart/alternative;
	boundary="_000_MA0P287MB30821EDE9EBFE1F1A9769E2C9F64AMA0P287MB3082INDP_"

--_000_MA0P287MB30821EDE9EBFE1F1A9769E2C9F64AMA0P287MB3082INDP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

This patch adds minimal AArch64 stubs to `winsup/utils/ssp.c` to allow the
ssp utility to compile as part of the Cygwin AArch64 target.


  *
Architecture-specific conditionals are extended to cover aarch64
alongside existing i386 and x86_64 code paths.
  *
Context register handling, single-step control, and register dumping
are stubbed out with placeholder logic.
  *
No functional debugging or single-step support is implemented for AArch64.
  *
These changes are intended solely to unblock the build and will require pro=
per
AArch64-specific implementations in a follow-up change.

Thanks & regards
Thirumalai N

In-lined Patch:

diff --git a/winsup/utils/ssp.c b/winsup/utils/ssp.c
index 96a90a1d9..9ab9d1e05 100644
--- a/winsup/utils/ssp.c
+++ b/winsup/utils/ssp.c
@@ -41,13 +41,21 @@ static struct option longopts[] =3D

 static char opts[] =3D "+cdehlstvV";

-#ifdef __x86_64__
+#if defined(__x86_64__)
 #define KERNEL_ADDR 0x00007FF000000000
 #define CONTEXT_SP Rsp
 #define CONTEXT_IP Rip
 typedef DWORD64 CONTEXT_REG;
 #define CONTEXT_REG_FMT "%016llx"
 #define ADDR_SSCANF_FMT "%lli"
+#elif defined(__aarch64__)
+// TODO
+#define KERNEL_ADDR 0x00007FF000000000
+#define CONTEXT_SP Sp
+#define CONTEXT_IP Pc
+typedef DWORD64 CONTEXT_REG;
+#define CONTEXT_REG_FMT "%016llx"
+#define ADDR_SSCANF_FMT "%lli"
 #else
 #error unimplemented for this target
 #endif
@@ -200,10 +208,16 @@ set_step_threads (int threadId, int trace)
   if (rv !=3D -1)
     {
       thread_step_flags[tix] =3D trace;
+#if defined(__i386__) || defined(__x86_64__)
       if (trace)
        context.EFlags |=3D 0x100; /* TRAP (single step) flag */
       else
        context.EFlags &=3D ~0x100; /* TRAP (single step) flag */
+#elif defined(__aarch64__)
+       // TODO
+#else
+#error unimplemented for this target
+#endif
       SetThreadContext (thread, &context);
     }
 }
@@ -215,7 +229,14 @@ set_steps ()
   for (i=3D0; i<num_active_threads; i++)
     {
       GetThreadContext (active_threads[i], &context);
+#if defined(__i386__) || defined(__x86_64__)
       s =3D context.EFlags & 0x0100;
+#elif defined(__aarch64__)
+      // TODO
+      s =3D 0;
+#else
+#error unimplemented for this target
+#endif
       if (!s && thread_step_flags[i])
        {
          set_step_threads (active_thread_ids[i], 1);
@@ -252,11 +273,13 @@ dump_registers (HANDLE thread)
 {
   context.ContextFlags =3D CONTEXT_FULL;
   GetThreadContext (thread, &context);
-#ifdef __x86_64__
+#if defined(__x86_64__)
   printf ("eax %016llx ebx %016llx ecx %016llx edx %016llx eip\n",
          context.Rax, context.Rbx, context.Rcx, context.Rdx);
   printf ("esi %016llx edi %016llx ebp %016llx esp %016llx %016llx\n",
          context.Rsi, context.Rdi, context.Rbp, context.Rsp, context.Rip);
+#elif defined(__aarch64__)
+  // TODO
 #else
 #error unimplemented for this target
 #endif
@@ -542,19 +565,31 @@ run_program (char *cmdline)
            {
              if (pc =3D=3D thread_return_address[tix])
                {
+#if defined(__i386__) || defined(__x86_64__)
                  if (context.EFlags & 0x100)
                    {
                      context.EFlags &=3D ~0x100; /* TRAP (single step) fla=
g */
                      SetThreadContext (hThread, &context);
                    }
+#elif defined(__aarch64__)
+                 // TODO
+#else
+#error unimplemented for this target
+#endif
                }
              else if (stepping_enabled)
                {
+#if defined(__i386__) || defined(__x86_64__)
                  if (!(context.EFlags & 0x100))
                    {
                      context.EFlags |=3D 0x100; /* TRAP (single step) flag=
 */
                      SetThreadContext (hThread, &context);
                    }
+#elif defined(__aarch64__)
+                 // TODO
+#else
+#error unimplemented for this target
+#endif
                }
            }
          break;
@@ -935,7 +970,7 @@ main (int argc, char **argv)

   if (dll_counts)
     {
-#ifdef __x86_64__
+#if defined(__x86_64__) || defined(__aarch64__)
       /*       1234567 123% 1234567 123% 1234567812345678 xxxxxxxxxxx */
       printf (" Main-Thread Other-Thread BaseAddr         DLL Name\n");
 #else
--


--_000_MA0P287MB30821EDE9EBFE1F1A9769E2C9F64AMA0P287MB3082INDP_--

--_004_MA0P287MB30821EDE9EBFE1F1A9769E2C9F64AMA0P287MB3082INDP_
Content-Type: application/octet-stream;
	name="Cygwin-ssp-add-AArch64-build-stubs.patch"
Content-Description: Cygwin-ssp-add-AArch64-build-stubs.patch
Content-Disposition: attachment;
	filename="Cygwin-ssp-add-AArch64-build-stubs.patch"; size=4340;
	creation-date="Sun, 08 Feb 2026 19:11:03 GMT";
	modification-date="Sun, 08 Feb 2026 19:11:11 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxODExMDkzMmFmNWIxN2UzYTkxOWNmOWQ3MWRkM2YxMDViMDQ0OTIz
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5h
Z2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJl
aW5jLmNvbT4KRGF0ZTogU3VuLCA4IEZlYiAyMDI2IDE2OjU5OjI4ICswNTMw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBzc3A6IGFkZCBBQXJjaDY0IGJ1
aWxkIHN0dWJzCk1JTUUtVmVyc2lvbjogMS4wCkNvbnRlbnQtVHlwZTogdGV4
dC9wbGFpbjsgY2hhcnNldD1VVEYtOApDb250ZW50LVRyYW5zZmVyLUVuY29k
aW5nOiA4Yml0CgpUaGlzIHBhdGNoIGFkZHMgIEFBcmNoNjQgc3R1YnMgdG8g
d2luc3VwL3V0aWxzL3NzcC5jIHRvIGFsbG93IHRoZSBzc3AgdXRpbGl0eQp0
byBjb21waWxlIGFzIHBhcnQgb2YgdGhlIEN5Z3dpbiBBQXJjaDY0IHBvcnQu
CgpDb25kaXRpb25hbCBoYW5kbGluZyBmb3IgX19hYXJjaDY0X18gaXMgaW50
cm9kdWNlZCBhbG9uZ3NpZGUgZXhpc3RpbmcKaTM4NiBhbmQgeDg2XzY0IGNv
ZGUgcGF0aHMuIEFyY2hpdGVjdHVyZS1zcGVjaWZpYyBjb250ZXh0IHJlZ2lz
dGVyCmRlZmluaXRpb25zIGFuZCBzaW5nbGUtc3RlcCBoYW5kbGluZyBhcmUg
c3R1YmJlZCBvdXQgd2l0aCBwbGFjZWhvbGRlcgpsb2dpYy4KCk5vIGZ1bmN0
aW9uYWwgc3VwcG9ydCBpcyBpbXBsZW1lbnRlZC4gVGhlc2UgY2hhbmdlcyBh
cmUgaW50ZW5kZWQgdW5ibG9jayB0aGUKQUFyY2g2NCBidWlsZCBhbmQgd2ls
bCByZXF1aXJlIHByb3BlciBpbXBsZW1lbnRhdGlvbnMgaW4gZm9sbG93LXVw
IGNoYW5nZS4KClNpZ25lZC1vZmYtYnk6IFJhZGVrIEJhcnRvxYggPHJhZGVr
LmJhcnRvbkBtaWNyb3NvZnQuY29tPgpTaWduZWQtb2ZmLWJ5OiBUaGlydW1h
bGFpIE5hZ2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNv
cmV3YXJlaW5jLmNvbT4KLS0tCiB3aW5zdXAvdXRpbHMvc3NwLmMgfCA0MSAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLQogMSBm
aWxlIGNoYW5nZWQsIDM4IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvd2luc3VwL3V0aWxzL3NzcC5jIGIvd2luc3VwL3V0
aWxzL3NzcC5jCmluZGV4IDk2YTkwYTFkOS4uOWFiOWQxZTA1IDEwMDY0NAot
LS0gYS93aW5zdXAvdXRpbHMvc3NwLmMKKysrIGIvd2luc3VwL3V0aWxzL3Nz
cC5jCkBAIC00MSwxMyArNDEsMjEgQEAgc3RhdGljIHN0cnVjdCBvcHRpb24g
bG9uZ29wdHNbXSA9Cgogc3RhdGljIGNoYXIgb3B0c1tdID0gIitjZGVobHN0
dlYiOwoKLSNpZmRlZiBfX3g4Nl82NF9fCisjaWYgZGVmaW5lZChfX3g4Nl82
NF9fKQogI2RlZmluZSBLRVJORUxfQUREUiAweDAwMDA3RkYwMDAwMDAwMDAK
ICNkZWZpbmUgQ09OVEVYVF9TUCBSc3AKICNkZWZpbmUgQ09OVEVYVF9JUCBS
aXAKIHR5cGVkZWYgRFdPUkQ2NCBDT05URVhUX1JFRzsKICNkZWZpbmUgQ09O
VEVYVF9SRUdfRk1UICIlMDE2bGx4IgogI2RlZmluZSBBRERSX1NTQ0FORl9G
TVQgIiVsbGkiCisjZWxpZiBkZWZpbmVkKF9fYWFyY2g2NF9fKQorLy8gVE9E
TworI2RlZmluZSBLRVJORUxfQUREUiAweDAwMDA3RkYwMDAwMDAwMDAKKyNk
ZWZpbmUgQ09OVEVYVF9TUCBTcAorI2RlZmluZSBDT05URVhUX0lQIFBjCit0
eXBlZGVmIERXT1JENjQgQ09OVEVYVF9SRUc7CisjZGVmaW5lIENPTlRFWFRf
UkVHX0ZNVCAiJTAxNmxseCIKKyNkZWZpbmUgQUREUl9TU0NBTkZfRk1UICIl
bGxpIgogI2Vsc2UKICNlcnJvciB1bmltcGxlbWVudGVkIGZvciB0aGlzIHRh
cmdldAogI2VuZGlmCkBAIC0yMDAsMTAgKzIwOCwxNiBAQCBzZXRfc3RlcF90
aHJlYWRzIChpbnQgdGhyZWFkSWQsIGludCB0cmFjZSkKICAgaWYgKHJ2ICE9
IC0xKQogICAgIHsKICAgICAgIHRocmVhZF9zdGVwX2ZsYWdzW3RpeF0gPSB0
cmFjZTsKKyNpZiBkZWZpbmVkKF9faTM4Nl9fKSB8fCBkZWZpbmVkKF9feDg2
XzY0X18pCiAgICAgICBpZiAodHJhY2UpCiAJY29udGV4dC5FRmxhZ3MgfD0g
MHgxMDA7IC8qIFRSQVAgKHNpbmdsZSBzdGVwKSBmbGFnICovCiAgICAgICBl
bHNlCiAJY29udGV4dC5FRmxhZ3MgJj0gfjB4MTAwOyAvKiBUUkFQIChzaW5n
bGUgc3RlcCkgZmxhZyAqLworI2VsaWYgZGVmaW5lZChfX2FhcmNoNjRfXykK
KwkvLyBUT0RPCisjZWxzZQorI2Vycm9yIHVuaW1wbGVtZW50ZWQgZm9yIHRo
aXMgdGFyZ2V0CisjZW5kaWYKICAgICAgIFNldFRocmVhZENvbnRleHQgKHRo
cmVhZCwgJmNvbnRleHQpOwogICAgIH0KIH0KQEAgLTIxNSw3ICsyMjksMTQg
QEAgc2V0X3N0ZXBzICgpCiAgIGZvciAoaT0wOyBpPG51bV9hY3RpdmVfdGhy
ZWFkczsgaSsrKQogICAgIHsKICAgICAgIEdldFRocmVhZENvbnRleHQgKGFj
dGl2ZV90aHJlYWRzW2ldLCAmY29udGV4dCk7CisjaWYgZGVmaW5lZChfX2kz
ODZfXykgfHwgZGVmaW5lZChfX3g4Nl82NF9fKQogICAgICAgcyA9IGNvbnRl
eHQuRUZsYWdzICYgMHgwMTAwOworI2VsaWYgZGVmaW5lZChfX2FhcmNoNjRf
XykKKyAgICAgIC8vIFRPRE8KKyAgICAgIHMgPSAwOworI2Vsc2UKKyNlcnJv
ciB1bmltcGxlbWVudGVkIGZvciB0aGlzIHRhcmdldAorI2VuZGlmCiAgICAg
ICBpZiAoIXMgJiYgdGhyZWFkX3N0ZXBfZmxhZ3NbaV0pCiAJewogCSAgc2V0
X3N0ZXBfdGhyZWFkcyAoYWN0aXZlX3RocmVhZF9pZHNbaV0sIDEpOwpAQCAt
MjUyLDExICsyNzMsMTMgQEAgZHVtcF9yZWdpc3RlcnMgKEhBTkRMRSB0aHJl
YWQpCiB7CiAgIGNvbnRleHQuQ29udGV4dEZsYWdzID0gQ09OVEVYVF9GVUxM
OwogICBHZXRUaHJlYWRDb250ZXh0ICh0aHJlYWQsICZjb250ZXh0KTsKLSNp
ZmRlZiBfX3g4Nl82NF9fCisjaWYgZGVmaW5lZChfX3g4Nl82NF9fKQogICBw
cmludGYgKCJlYXggJTAxNmxseCBlYnggJTAxNmxseCBlY3ggJTAxNmxseCBl
ZHggJTAxNmxseCBlaXBcbiIsCiAJICBjb250ZXh0LlJheCwgY29udGV4dC5S
YngsIGNvbnRleHQuUmN4LCBjb250ZXh0LlJkeCk7CiAgIHByaW50ZiAoImVz
aSAlMDE2bGx4IGVkaSAlMDE2bGx4IGVicCAlMDE2bGx4IGVzcCAlMDE2bGx4
ICUwMTZsbHhcbiIsCiAJICBjb250ZXh0LlJzaSwgY29udGV4dC5SZGksIGNv
bnRleHQuUmJwLCBjb250ZXh0LlJzcCwgY29udGV4dC5SaXApOworI2VsaWYg
ZGVmaW5lZChfX2FhcmNoNjRfXykKKyAgLy8gVE9ETwogI2Vsc2UKICNlcnJv
ciB1bmltcGxlbWVudGVkIGZvciB0aGlzIHRhcmdldAogI2VuZGlmCkBAIC01
NDIsMTkgKzU2NSwzMSBAQCBydW5fcHJvZ3JhbSAoY2hhciAqY21kbGluZSkK
IAkgICAgewogCSAgICAgIGlmIChwYyA9PSB0aHJlYWRfcmV0dXJuX2FkZHJl
c3NbdGl4XSkKIAkJeworI2lmIGRlZmluZWQoX19pMzg2X18pIHx8IGRlZmlu
ZWQoX194ODZfNjRfXykKIAkJICBpZiAoY29udGV4dC5FRmxhZ3MgJiAweDEw
MCkKIAkJICAgIHsKIAkJICAgICAgY29udGV4dC5FRmxhZ3MgJj0gfjB4MTAw
OyAvKiBUUkFQIChzaW5nbGUgc3RlcCkgZmxhZyAqLwogCQkgICAgICBTZXRU
aHJlYWRDb250ZXh0IChoVGhyZWFkLCAmY29udGV4dCk7CiAJCSAgICB9Cisj
ZWxpZiBkZWZpbmVkKF9fYWFyY2g2NF9fKQorCQkgIC8vIFRPRE8KKyNlbHNl
CisjZXJyb3IgdW5pbXBsZW1lbnRlZCBmb3IgdGhpcyB0YXJnZXQKKyNlbmRp
ZgogCQl9CiAJICAgICAgZWxzZSBpZiAoc3RlcHBpbmdfZW5hYmxlZCkKIAkJ
eworI2lmIGRlZmluZWQoX19pMzg2X18pIHx8IGRlZmluZWQoX194ODZfNjRf
XykKIAkJICBpZiAoIShjb250ZXh0LkVGbGFncyAmIDB4MTAwKSkKIAkJICAg
IHsKIAkJICAgICAgY29udGV4dC5FRmxhZ3MgfD0gMHgxMDA7IC8qIFRSQVAg
KHNpbmdsZSBzdGVwKSBmbGFnICovCiAJCSAgICAgIFNldFRocmVhZENvbnRl
eHQgKGhUaHJlYWQsICZjb250ZXh0KTsKIAkJICAgIH0KKyNlbGlmIGRlZmlu
ZWQoX19hYXJjaDY0X18pCisJCSAgLy8gVE9ETworI2Vsc2UKKyNlcnJvciB1
bmltcGxlbWVudGVkIGZvciB0aGlzIHRhcmdldAorI2VuZGlmCiAJCX0KIAkg
ICAgfQogCSAgYnJlYWs7CkBAIC05MzUsNyArOTcwLDcgQEAgbWFpbiAoaW50
IGFyZ2MsIGNoYXIgKiphcmd2KQoKICAgaWYgKGRsbF9jb3VudHMpCiAgICAg
ewotI2lmZGVmIF9feDg2XzY0X18KKyNpZiBkZWZpbmVkKF9feDg2XzY0X18p
IHx8IGRlZmluZWQoX19hYXJjaDY0X18pCiAgICAgICAvKiAgICAgICAxMjM0
NTY3IDEyMyUgMTIzNDU2NyAxMjMlIDEyMzQ1Njc4MTIzNDU2NzggeHh4eHh4
eHh4eHggKi8KICAgICAgIHByaW50ZiAoIiBNYWluLVRocmVhZCBPdGhlci1U
aHJlYWQgQmFzZUFkZHIgICAgICAgICBETEwgTmFtZVxuIik7CiAjZWxzZQot
LQoyLjUzLjAud2luZG93cy4xCgo=

--_004_MA0P287MB30821EDE9EBFE1F1A9769E2C9F64AMA0P287MB3082INDP_--
