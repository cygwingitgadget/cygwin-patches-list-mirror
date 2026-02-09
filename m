Return-Path: <SRS0=mDB5=AN=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c408::3])
	by sourceware.org (Postfix) with ESMTPS id 0F40748FE560
	for <cygwin-patches@cygwin.com>; Mon,  9 Feb 2026 20:00:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0F40748FE560
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0F40748FE560
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c408::3
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1770667228; cv=pass;
	b=pLtsm4cN85CMui3M75a2qMEdh7GspWwqjshKrfypl9po3WquME9peqNuUe663JMmGWnbLNQjFf2NKHtjLVhAcBqWoycTxDVXxz/obsqUxVKB7kr2dJvedDeX95nlZNrbaS+R/6Esfkzea7lVZYoiD5LuwNTZOI6gJ3qk2eSn2oA=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1770667228; c=relaxed/simple;
	bh=iRlFHHaPPzOw8ir7sEUlMjnJMMEoo6zpfeWXa6rgStw=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=t2B+jK+bGRSQcTMx+E4IjhbobVrwaJbH1TGye/wZwDkvs/6ASsd3FQZkh2w8fHIMSUVbtLF2lI141iaDVodG4YuWBDVLYpsVVDzQ7NFhmi7P97iVL59ZDZfI4bVVhKQQXwd5Uy0J0MvH8i3xkLLtBN8G3nCECk3tJfM4D6AVPtA=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0F40748FE560
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=U5EzFXSO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g0/UWB9byClMWzUPahfbxTsN5+YDR08nWMluDIPbWFPKi47bPJLHFlbuLgveZHEYK+BQ2gDHl4UiBn7E23KL2Js1XGwFsm88l7fPFyKb18edvlDTlKkN4d163gIo3cU6u2oc7C01GowGv++Z5JUdjQH9XAa7ZP9uw4faqZ+mO9xbBbQlZhcWx4QiiO1MBBV1OzKVGJmy5WVpXmmCXUxrcN5bWnjF/7XKci13A2V7i7OYlrqZ3V0LarUXebjP+Vl5tjyS6hbPAxoEM2tkohBgj1kVhnGCbeM8FNdFhGtCZ0yTZ5dKcG7CnWEYo8Qval2dY8mPC3jRRV+D+pVoLnWShA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGiGqpNasYZX3PTSTNgNbrhyaDutvTlzAmElU0X9x5A=;
 b=f5M6kWpqdc4qmUlLJTn4pfGr2p5QeNqwpdNtNIVpZPGios4Rqeo2fSeVWYqZThVWpBGYveyTXnZ9aPgOjzvtb/v4sSFzfrb8A6mM7S/OpHHo3IJUT06WH/cEccJ5XFWG2NHKy17oOqAmt8MRl+C4y9F9HOuEi5Vj6fNzsUngHON3/scu7YoAli1PXjNJUoTND7p6UGHlAukJluNI9Xid2dWzPjwEVjSvi0DcQXVCgEuEzAUCX6yjS9DnKyaN7tdgH4gy2q08GOqaT+CPMDWFOpfTSUtsd0Wg64QMmh+q5loBi4pZAxo9cDLt6JAi0q2wZUKKrrwI0JsswQrb69wXsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGiGqpNasYZX3PTSTNgNbrhyaDutvTlzAmElU0X9x5A=;
 b=U5EzFXSOGwdBdo6uaemzyN8Av7JuVsxOokpBXSM0HLDeIi8iv1nKlrfRJXAYV4W0UNc/cWkm9QOyib/O8IWFeO6zUQVL9JBAc+1p1/uwNG9gF7z7pb9xiHmUMc0pazVU3MMN/PURQVdadXcbXvTF849ITjcB58v2utTrNcZfFi8A0krZFAcgJXfRrQrZDrJR94TFzMWyNvHkIsM64NzZ7brC3il8xoOJLgz31k3LKgs4lN2m7523SPGflJXEg5+urb2w4B81fKC/oK0/s21q4Dzf+5DCZg8lZPRRQolcb4qbl2aXoDhY75CfurhvnmrMdSJyR8zmVpWDQsBrElYv8A==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by PN1P287MB3742.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:257::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Mon, 9 Feb
 2026 20:00:19 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::f574:2c10:ce6:4682]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::f574:2c10:ce6:4682%4]) with mapi id 15.20.9611.006; Mon, 9 Feb 2026
 20:00:19 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH 1/2] Cygwin: gendef: support architecture-specific cygwin.din
 files
Thread-Topic: [PATCH 1/2] Cygwin: gendef: support architecture-specific
 cygwin.din files
Thread-Index: AQHcmfOdDAmNLeO57EabyBKkF6CMOQ==
Date: Mon, 9 Feb 2026 20:00:00 +0000
Message-ID:
 <MA0P287MB3082001F897D700E99FA82CD9F65A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|PN1P287MB3742:EE_
x-ms-office365-filtering-correlation-id: d567cf72-974d-42cb-e121-08de6815d9dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|6049299003|1800799024|38070700021|8096899003|4053099003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?9SkOLFSZam5l8eMkZz+2megiL5liMFdRHYeOCH07T2o4tNcpnqYyNP0DKK?=
 =?iso-8859-1?Q?ni+hfOQw1NqmNFyfVoADVMUY0MSkxjq3jN1XKzSq2zwi1OELV9Kxs9JCVn?=
 =?iso-8859-1?Q?3yTZMfElv1aGNbb05WGPA91eRyxgOSywS2FWOsg5gFDzqGbmneJaGav3D2?=
 =?iso-8859-1?Q?WGD+UwstwQZA0GBv7ryBidljJevdPwYSI75LguMBfxzsHsB6xpD+amndkV?=
 =?iso-8859-1?Q?CtqEFBoP2a0EVcUxOAyiP02emhTlQCUoi9IKGXCsCat20jdSwRZW51B0QE?=
 =?iso-8859-1?Q?cKZ+StEo7rcpjzpWDK5o0i+Dv6IBzm+fBFQ7y47LijBKyY7sEPZ6DjxV8Z?=
 =?iso-8859-1?Q?j0rkR47kKpaKDRg8vyL8kxl9mpCImBpSllTyw2mq+E4su53neQNgiGU+P/?=
 =?iso-8859-1?Q?DZv8ZqMI1JFURUOcNwMZclMgnHSTgZVHReb99FOkagveJ6WkdCwXoe5g83?=
 =?iso-8859-1?Q?h0tasrkpe7f+5e2qrJuzmmYu9w3EXNhgjWYy+rV8o1RHalidYgK9sAsIz/?=
 =?iso-8859-1?Q?SVWDnlf0AOjtuuDes+NXtYlDkc+NeAJ38rpndHUTRjLbCOYcFXoCsWf8lf?=
 =?iso-8859-1?Q?LHeRf5R+BWx3SIOvFibloknHd4UKwDrtfseObO5f8S+MeLGYmnfuvLPESe?=
 =?iso-8859-1?Q?Xh7+0hdYjKMAhQwLhwb+pqOQcTV/Jokjg1J+CEkw3uFd5eWf/Tf/MA02bV?=
 =?iso-8859-1?Q?/4lcayrPaSF8XZrfBeeVLzH1MgAk0NPS+WOWuKfYZaWkI/vuS6vbpS2m7b?=
 =?iso-8859-1?Q?3BPH1A0K9Mh/B4IXzCJ0bFjilRBymPWp/DfIPFMa1HeTVbqQKWTkJBYRcU?=
 =?iso-8859-1?Q?iygYLJz3ktJ9qLrL5ryNGBmm6TZexbPMZNjCjWxeufC4XciOBvonOK0WT+?=
 =?iso-8859-1?Q?cGlVIsTNfWVt49ISElRm+c1DwpeypyltqrC9Qvw04atvLOYIWDY7T7cekE?=
 =?iso-8859-1?Q?/Q9h89KbQnTzx166RwbZSZi5nYxlD5RVsFAYAuhmKTX6kPf66Btswk+tYa?=
 =?iso-8859-1?Q?6/Ceejwxw36s/8pjONSxWCXm2IJELJo2MVEbfSr/wF5BWEEmJhJFvQZfol?=
 =?iso-8859-1?Q?Udc6G+oqDj73x60APBoKsiklBDyMrWydUnUNiJ0k4WFcBXIeM2vhL4u5YY?=
 =?iso-8859-1?Q?ll5KSUwYHH/0xOh4tzkZA7QlY+DzMuFD8ALZBM7c6Oay+klZhRS3kHVj1m?=
 =?iso-8859-1?Q?hlQzZa7Fsq/oaKQ2G6/9gcQe88Zx+W2hiUC7zTrk1MGI0tKwY8+5OsV4et?=
 =?iso-8859-1?Q?XbqAhQTZbnhJwK4GGz1wP69hphoksgbApAa1TRfHQjOrbPZLHrFjF+B7aG?=
 =?iso-8859-1?Q?KI9tkz1kcr7jXbXc5kowBF6qlxpGXrIe00hHDDi1S51rNcuc34aak2izSH?=
 =?iso-8859-1?Q?DaN9Ku2x5jv4q7+bXa7+fZsN/7yf6iYmREZnGlgeMqc1DvOrX5PbOL4SqS?=
 =?iso-8859-1?Q?QGyNpNRCUtmUdZQvVisRjFxPQGVmkvuOMldkhqrdhsA8Q+pJg4eqMdvTUH?=
 =?iso-8859-1?Q?VPF340SEJL1YfN3qcpoqIQGpaOZNZ40DBlIST0Dmx0oBC+g9GnpVvFSwEY?=
 =?iso-8859-1?Q?pkxrWk+CXLZEj6tV8ncwQiwcFrfmunH5Is8l5bYOzSwujtPufdN3d0Bd9l?=
 =?iso-8859-1?Q?QXJ1srI2M5nVdebCAYe+JqXv4kX/7ksp4aaDw6ujDTOxJA2q8+6nZXqd5I?=
 =?iso-8859-1?Q?vbLTH8Z3G2hxOPYoDIc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(6049299003)(1800799024)(38070700021)(8096899003)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?8lOAeg1YDhJWY6HnEIrlB0nn3NiYEpjot7SRT+o/Yd0EurogGSYPXeOSGs?=
 =?iso-8859-1?Q?lPu3VzW7wg1dJhux4h5YG4g6RxbtoGKn/UhXkUt5EFsCjm8RPyIRnXWXsG?=
 =?iso-8859-1?Q?0k3GGa4cqRgDyc8Xiwh6sWvbUCF7/vtwG8NE1OtKF9KC5hE7NVuYByse2P?=
 =?iso-8859-1?Q?Jkvar0okO5Xb7Ys61GE7OLlhz8qS864b5j3mC+5A46PCzaL8zMVGnrApQ+?=
 =?iso-8859-1?Q?WPfDFAZ89yw6u3l0ufujivSzK21Yj4NjxbdRBCM21Vs8TSUvKuuIAP9zF0?=
 =?iso-8859-1?Q?zhwLHXi2SL2DThoU76EhCFg+QAqzeOK9AMUQVzbAvkfg7IFGSanD9851y/?=
 =?iso-8859-1?Q?TyV6q5AeQCmHqo4TESfaIZNs8C4dsIhG1nVaKjP7++Q9HuspU675Cu3+8d?=
 =?iso-8859-1?Q?7KhoZwAch2dBkFA49I1/x1qX+ltQVSNIP6gj7RX2vWHqtq2euWdNFAH7Be?=
 =?iso-8859-1?Q?qXZdqjilBuxTtYk0SCJvB/G1qcXpAFofYO6p4Zp+AphKwQc4m5vqOawzXD?=
 =?iso-8859-1?Q?F9bPoXrNgON31UBpxIiBpnIxaLHKgVb7P2MfO4Qw+RTH6y+jHzxozF0iZS?=
 =?iso-8859-1?Q?GBjDyVe8EFh+HrGP25aOKWPIzGT3QYhBiYYYku0OJCM/9YFklLn6fByK1k?=
 =?iso-8859-1?Q?pClz/ut44p3HHr+lHzRPH6x5VPvaeonZUNLKOa82w4uvAST8MGJ8jIFZrG?=
 =?iso-8859-1?Q?an65G9o350XfkIAMi+x7JbnPuSZL0BrUgaPzylohb+KYbhPgt9fEjROb6X?=
 =?iso-8859-1?Q?rc7VbcoBmv9dzq8rhvXj5O8VwhjWuRrMNzFgaZpuG3hyx/wUTMyOpm4BZV?=
 =?iso-8859-1?Q?AZbDVdOznj5WhZ5LGfJHLKBNcYlarfkY6oAXgZ5yppXspsORPQK7laorUp?=
 =?iso-8859-1?Q?ASg0Q3sGljsAB83CGm6eDQ0QaX26mJ3W4hSyE+CkhSedn1BHdwLhcG5xAS?=
 =?iso-8859-1?Q?zdNLxqRFs3wVzyT2o6zeSFavkPOy98ZKAciYlAHHOP4Say5h0LUCz0kttd?=
 =?iso-8859-1?Q?YH0NI65ZkVsTeWVDI5RfukYJbYCqfGJSnOdsfPU7VWxRHfr9Ger6dFH6ZW?=
 =?iso-8859-1?Q?Eli9MpreR4hfzJtq0caXKMdEY7x8o3maOrKIHob2hW+944voCRdAVjzsPO?=
 =?iso-8859-1?Q?1ZIeFlc8U0Hetk59Ftvku2wCvY1hGGle80eLRKVAbanvwnc6l3ZXS2t6u2?=
 =?iso-8859-1?Q?eXFm+81fFDhNk4rExMThimdKDeoEnvBKiwGYgJ8YOEx8OpjoTExTY/widN?=
 =?iso-8859-1?Q?KcIvqJprzHsSFOdqu8sbGmkPwXkn+Jvyu8YdquD2KC9Odezepk5Zeb57cO?=
 =?iso-8859-1?Q?Ui2YiB7ZJXbvntlioo2wdJIUlpbVsZ1l0UyFb+XV5l3VGe/YbT9ZxmHWhg?=
 =?iso-8859-1?Q?Dh4Xc7/bh0OHt641BZuOvi6QWQCDLq8J9xHtkRqV9RpdjoF+NJenIoBsYq?=
 =?iso-8859-1?Q?n4VpJlcuvW9pJyDG4dzBBVmICVvRds7EW2vLb7cWd7QCPSS1U8oMYYhDls?=
 =?iso-8859-1?Q?0S0CqR7Q3KzPo09u4ySRiPAEHtUGjpMIMjMrP948x2akke3uNhRV9qQmSa?=
 =?iso-8859-1?Q?YHuqAUEOO2FjKeoRGxsF5ieA6GSmUNbro3IrLQ26qoBkaWEqQVrOx3BGnU?=
 =?iso-8859-1?Q?U2GNTOe6Jjnfx02AdJ2sMiSlYDnOZ/FtYiCHiH9OJtsnXu/et+9QnUNr1K?=
 =?iso-8859-1?Q?gz7nLC2qkzIjRH+aeCfli93pAn9JvDAKQ60TruqTbK/Rbl6NC35Jbi0PEu?=
 =?iso-8859-1?Q?OXTxIWLKn6XP3kybl9Glyu6DjW4L5Y5dqjnGISjcRNsPZTZ80/aaUBDB3r?=
 =?iso-8859-1?Q?WLOJBb29wbPGic31okrUScdeHXsW+0Vw2OVBibxLJWOmc3hKGaBkxxkuia?=
 =?iso-8859-1?Q?et?=
x-ms-exchange-antispam-messagedata-1:
 bVBhE2kfVUYiEDqX7/9M0HSbSngKQK5SQ/l9TWPEiOosyOEYvp2A2GUCrsBrcM//i1Gz8PjJl/IqLA==
Content-Type: multipart/mixed;
	boundary="_004_MA0P287MB3082001F897D700E99FA82CD9F65AMA0P287MB3082INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d567cf72-974d-42cb-e121-08de6815d9dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 20:00:19.1458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GM+DAYglpC7UwXVdIfuftAgXsiDVYR9qoZVo0SxNJL6Cy3X6BcKYBO2b2KMvovQGz193zy9ne71HVJRD/X1w873Xg/2VQFqM13WLDNe15uIvIDG3e70cGgmfN5nl56vf9LbM1lGmJdeWCakVoVkXbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN1P287MB3742
X-Spam-Status: No, score=-12.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,HTML_MESSAGE,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_004_MA0P287MB3082001F897D700E99FA82CD9F65AMA0P287MB3082INDP_
Content-Type: multipart/alternative;
	boundary="_000_MA0P287MB3082001F897D700E99FA82CD9F65AMA0P287MB3082INDP_"

--_000_MA0P287MB3082001F897D700E99FA82CD9F65AMA0P287MB3082INDP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Everyone,

This patch restores support for a common cygwin.din file combined with
optional architecture-specific cygwin.din fragments, allowing exported
symbols to vary by target CPU.


  *
The gendef script is extended to read a per-architecture cygwin.din file,
which is appended to the common export list during generation.

This kind of mechanism existed prior to commit 3ba050dfcd1d
("Cygwin: fold common.din and x86_64.din into cygwin.din"), which merged
all exports into a single file when only x86/x86_64 targets were
supported.

With the ongoing introduction of AArch64 support, architecture-specific
export control is again required. The common cygwin.din remains in the
parent directory, while per-architecture files are placed under the
respective arch subdirectories.

Thanks & regards
Thirumalai Nagalingam

In-Lined patch:

iff --git a/winsup/cygwin/Makefile.am b/winsup/cygwin/Makefile.am
index d543b9b19..a30ceed3b 100644
--- a/winsup/cygwin/Makefile.am
+++ b/winsup/cygwin/Makefile.am
@@ -646,7 +646,9 @@ $(NEW_DLL_NAME): $(LDSCRIPT) libdll.a $(VERSION_OFILES)=
 $(LIBSERVER)\
 # cygwin import library
 toolopts=3D--cpu=3D@target_cpu@ --ar=3D@AR@ --as=3D@AS@ --nm=3D@NM@ --objc=
opy=3D@OBJCOPY@

-$(DEF_FILE): scripts/gendef cygwin.din
+# Architecture-specific .din files
+ARCH_DIN =3D $(srcdir)/@target_cpu@/cygwin.din
+$(DEF_FILE): scripts/gendef cygwin.din $(wildcard $(ARCH_DIN))
        $(AM_V_GEN)$(srcdir)/scripts/gendef --cpu=3D@target_cpu@ --output-d=
ef=3D$(DEF_FILE) $(srcdir)/cygwin.din

 sigfe.s: $(DEF_FILE) tlsoffsets
diff --git a/winsup/cygwin/aarch64/cygwin.din b/winsup/cygwin/aarch64/cygwi=
n.din
new file mode 100644
index 000000000..927b7411e
--- /dev/null
+++ b/winsup/cygwin/aarch64/cygwin.din
@@ -0,0 +1,4 @@
+# aarch64-specific exports
+# These symbols are only available on aarch64 architecture
+
+# Currently empty - all exports are in common cygwin.din
diff --git a/winsup/cygwin/scripts/gendef b/winsup/cygwin/scripts/gendef
index ddabe8474..45be2d54a 100755
--- a/winsup/cygwin/scripts/gendef
+++ b/winsup/cygwin/scripts/gendef
@@ -33,6 +33,23 @@ while (<>) {
 }
 my @in =3D cleanup <>;

+# Derive arch-specific cygwin.din relative to the common cygwin.din path
+my $arch_din =3D $ARGV[0];
+$arch_din =3D~ s/cygwin\.din$//;
+$arch_din .=3D "$cpu/cygwin.din";
+
+if (-f $arch_din) {
+    open(ARCH_DIN, '<', $arch_din) or die "Cannot open $arch_din: $!\n";
+    my $in_exports =3D 0;
+    while (<ARCH_DIN>) {
+        $in_exports =3D 1 if /^\s*exports$/oi;
+        next unless $in_exports;
+        next if /^\s*exports$/oi;
+        push(@in, cleanup $_);
+    }
+    close(ARCH_DIN);
+}
+
 my %sigfe =3D ();
 my @data =3D ();
 my @nosigfuncs =3D ();
diff --git a/winsup/cygwin/x86_64/cygwin.din b/winsup/cygwin/x86_64/cygwin.=
din
new file mode 100644
index 000000000..228894623
--- /dev/null
+++ b/winsup/cygwin/x86_64/cygwin.din
@@ -0,0 +1,2 @@
+# x86_64-specific exports
+# These symbols are only available on x86/x64 architectures
--


--_000_MA0P287MB3082001F897D700E99FA82CD9F65AMA0P287MB3082INDP_--

--_004_MA0P287MB3082001F897D700E99FA82CD9F65AMA0P287MB3082INDP_
Content-Type: application/octet-stream;
	name="0001-Cygwin-gendef-support-architecture-specific-cygwin.d.patch"
Content-Description:
 0001-Cygwin-gendef-support-architecture-specific-cygwin.d.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-gendef-support-architecture-specific-cygwin.d.patch";
	size=3461; creation-date="Mon, 09 Feb 2026 18:40:55 GMT";
	modification-date="Mon, 09 Feb 2026 18:41:46 GMT"
Content-Transfer-Encoding: base64

RnJvbSA1N2EwZjU2NWI2YTExMjcxM2JmYWQ0MzhiNDllYjg5MGE0ZTg0MTIx
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5h
Z2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJl
aW5jLmNvbT4KRGF0ZTogU3VuLCA4IEZlYiAyMDI2IDE3OjI2OjQzICswNTMw
ClN1YmplY3Q6IFtQQVRDSCAxLzJdIEN5Z3dpbjogZ2VuZGVmOiBzdXBwb3J0
IGFyY2hpdGVjdHVyZS1zcGVjaWZpYyBjeWd3aW4uZGluCiBmaWxlcwoKVGhp
cyBjaGFuZ2UgYWRkcyBzdXBwb3J0IGZvciBhcmNoaXRlY3R1cmUtc3BlY2lm
aWMgY3lnd2luLmRpbiBmcmFnbWVudHMKdG8gYWxsb3cgZXhwb3J0ZWQgc3lt
Ym9scyB0byB2YXJ5IGJ5IHRhcmdldCBDUFUuClRoZSBnZW5kZWYgc2NyaXB0
IGlzIGV4dGVuZGVkIHRvIHJlYWQgYSBwZXItYXJjaGl0ZWN0dXJlIGN5Z3dp
bi5kaW4KZmlsZSwgd2hpY2ggaXMgYXBwZW5kZWQgdG8gdGhlIGNvbW1vbiBl
eHBvcnQgbGlzdC4KClRoaXMgbWVjaGFuaXNtIGV4aXN0ZWQgcHJpb3IgdG8g
Y29tbWl0IDNiYTA1MGRmY2QxZAooIkN5Z3dpbjogZm9sZCBjb21tb24uZGlu
IGFuZCB4ODZfNjQuZGluIGludG8gY3lnd2luLmRpbiIpLCB3aGljaCBtZXJn
ZWQKYWxsIGV4cG9ydHMgaW50byBhIHNpbmdsZSBmaWxlLgoKV2l0aCB0aGUg
aW50cm9kdWN0aW9uIG9mIG9uLWdvaW5nIEFBcmNoNjQgc3Vwb3J0LCBhcmNo
aXRlY3R1cmUtc3BlY2lmaWMKZXhwb3J0IGNvbnRyb2wgaXMgYWdhaW4gcmVx
dWlyZWQuIFRoZSBjb21tb24gY3lnd2luLmRpbiByZW1haW5zIGluIHRoZQpw
YXJlbnQgZGlyZWN0b3J5LCB3aGlsZSBwZXItYXJjaGl0ZWN0dXJlIGZpbGVz
IGFyZSBwbGFjZWQgdW5kZXIgdGhlCnJlc3BlY3RpdmUgYXJjaCBzdWItZGly
ZWN0b3JpZXMuCgpTaWduZWQtb2ZmLWJ5OiBUaGlydW1hbGFpIE5hZ2FsaW5n
YW0gPHRoaXJ1bWFsYWkubmFnYWxpbmdhbUBtdWx0aWNvcmV3YXJlaW5jLmNv
bT4KLS0tCiB3aW5zdXAvY3lnd2luL01ha2VmaWxlLmFtICAgICAgICB8ICA0
ICsrKy0KIHdpbnN1cC9jeWd3aW4vYWFyY2g2NC9jeWd3aW4uZGluIHwgIDQg
KysrKwogd2luc3VwL2N5Z3dpbi9zY3JpcHRzL2dlbmRlZiAgICAgfCAxNyAr
KysrKysrKysrKysrKysrKwogd2luc3VwL2N5Z3dpbi94ODZfNjQvY3lnd2lu
LmRpbiAgfCAgMiArKwogNCBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgd2luc3Vw
L2N5Z3dpbi9hYXJjaDY0L2N5Z3dpbi5kaW4KIGNyZWF0ZSBtb2RlIDEwMDY0
NCB3aW5zdXAvY3lnd2luL3g4Nl82NC9jeWd3aW4uZGluCgpkaWZmIC0tZ2l0
IGEvd2luc3VwL2N5Z3dpbi9NYWtlZmlsZS5hbSBiL3dpbnN1cC9jeWd3aW4v
TWFrZWZpbGUuYW0KaW5kZXggZDU0M2I5YjE5Li5hMzBjZWVkM2IgMTAwNjQ0
Ci0tLSBhL3dpbnN1cC9jeWd3aW4vTWFrZWZpbGUuYW0KKysrIGIvd2luc3Vw
L2N5Z3dpbi9NYWtlZmlsZS5hbQpAQCAtNjQ2LDcgKzY0Niw5IEBAICQoTkVX
X0RMTF9OQU1FKTogJChMRFNDUklQVCkgbGliZGxsLmEgJChWRVJTSU9OX09G
SUxFUykgJChMSUJTRVJWRVIpXAogIyBjeWd3aW4gaW1wb3J0IGxpYnJhcnkK
IHRvb2xvcHRzPS0tY3B1PUB0YXJnZXRfY3B1QCAtLWFyPUBBUkAgLS1hcz1A
QVNAIC0tbm09QE5NQCAtLW9iamNvcHk9QE9CSkNPUFlACiAKLSQoREVGX0ZJ
TEUpOiBzY3JpcHRzL2dlbmRlZiBjeWd3aW4uZGluCisjIEFyY2hpdGVjdHVy
ZS1zcGVjaWZpYyAuZGluIGZpbGVzCitBUkNIX0RJTiA9ICQoc3JjZGlyKS9A
dGFyZ2V0X2NwdUAvY3lnd2luLmRpbgorJChERUZfRklMRSk6IHNjcmlwdHMv
Z2VuZGVmIGN5Z3dpbi5kaW4gJCh3aWxkY2FyZCAkKEFSQ0hfRElOKSkKIAkk
KEFNX1ZfR0VOKSQoc3JjZGlyKS9zY3JpcHRzL2dlbmRlZiAtLWNwdT1AdGFy
Z2V0X2NwdUAgLS1vdXRwdXQtZGVmPSQoREVGX0ZJTEUpICQoc3JjZGlyKS9j
eWd3aW4uZGluCiAKIHNpZ2ZlLnM6ICQoREVGX0ZJTEUpIHRsc29mZnNldHMK
ZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vYWFyY2g2NC9jeWd3aW4uZGlu
IGIvd2luc3VwL2N5Z3dpbi9hYXJjaDY0L2N5Z3dpbi5kaW4KbmV3IGZpbGUg
bW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwLi45MjdiNzQxMWUKLS0tIC9k
ZXYvbnVsbAorKysgYi93aW5zdXAvY3lnd2luL2FhcmNoNjQvY3lnd2luLmRp
bgpAQCAtMCwwICsxLDQgQEAKKyMgYWFyY2g2NC1zcGVjaWZpYyBleHBvcnRz
CisjIFRoZXNlIHN5bWJvbHMgYXJlIG9ubHkgYXZhaWxhYmxlIG9uIGFhcmNo
NjQgYXJjaGl0ZWN0dXJlCisKKyMgQ3VycmVudGx5IGVtcHR5IC0gYWxsIGV4
cG9ydHMgYXJlIGluIGNvbW1vbiBjeWd3aW4uZGluCmRpZmYgLS1naXQgYS93
aW5zdXAvY3lnd2luL3NjcmlwdHMvZ2VuZGVmIGIvd2luc3VwL2N5Z3dpbi9z
Y3JpcHRzL2dlbmRlZgppbmRleCBkZGFiZTg0NzQuLjQ1YmUyZDU0YSAxMDA3
NTUKLS0tIGEvd2luc3VwL2N5Z3dpbi9zY3JpcHRzL2dlbmRlZgorKysgYi93
aW5zdXAvY3lnd2luL3NjcmlwdHMvZ2VuZGVmCkBAIC0zMyw2ICszMywyMyBA
QCB3aGlsZSAoPD4pIHsKIH0KIG15IEBpbiA9IGNsZWFudXAgPD47CiAKKyMg
RGVyaXZlIGFyY2gtc3BlY2lmaWMgY3lnd2luLmRpbiByZWxhdGl2ZSB0byB0
aGUgY29tbW9uIGN5Z3dpbi5kaW4gcGF0aAorbXkgJGFyY2hfZGluID0gJEFS
R1ZbMF07CiskYXJjaF9kaW4gPX4gcy9jeWd3aW5cLmRpbiQvLzsKKyRhcmNo
X2RpbiAuPSAiJGNwdS9jeWd3aW4uZGluIjsKKworaWYgKC1mICRhcmNoX2Rp
bikgeworICAgIG9wZW4oQVJDSF9ESU4sICc8JywgJGFyY2hfZGluKSBvciBk
aWUgIkNhbm5vdCBvcGVuICRhcmNoX2RpbjogJCFcbiI7CisgICAgbXkgJGlu
X2V4cG9ydHMgPSAwOworICAgIHdoaWxlICg8QVJDSF9ESU4+KSB7CisgICAg
ICAgICRpbl9leHBvcnRzID0gMSBpZiAvXlxzKmV4cG9ydHMkL29pOworICAg
ICAgICBuZXh0IHVubGVzcyAkaW5fZXhwb3J0czsKKyAgICAgICAgbmV4dCBp
ZiAvXlxzKmV4cG9ydHMkL29pOworICAgICAgICBwdXNoKEBpbiwgY2xlYW51
cCAkXyk7CisgICAgfQorICAgIGNsb3NlKEFSQ0hfRElOKTsKK30KKwogbXkg
JXNpZ2ZlID0gKCk7CiBteSBAZGF0YSA9ICgpOwogbXkgQG5vc2lnZnVuY3Mg
PSAoKTsKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4veDg2XzY0L2N5Z3dp
bi5kaW4gYi93aW5zdXAvY3lnd2luL3g4Nl82NC9jeWd3aW4uZGluCm5ldyBm
aWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMC4uMjI4ODk0NjIzCi0t
LSAvZGV2L251bGwKKysrIGIvd2luc3VwL2N5Z3dpbi94ODZfNjQvY3lnd2lu
LmRpbgpAQCAtMCwwICsxLDIgQEAKKyMgeDg2XzY0LXNwZWNpZmljIGV4cG9y
dHMKKyMgVGhlc2Ugc3ltYm9scyBhcmUgb25seSBhdmFpbGFibGUgb24geDg2
L3g2NCBhcmNoaXRlY3R1cmVzCi0tIAoyLjUzLjAud2luZG93cy4xCgo=

--_004_MA0P287MB3082001F897D700E99FA82CD9F65AMA0P287MB3082INDP_--
