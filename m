Return-Path: <alexandremf3@al.insper.edu.br>
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on20606.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e83::606])
	by sourceware.org (Postfix) with ESMTPS id 2D99D3858D35
	for <cygwin-patches@cygwin.com>; Mon, 14 Nov 2022 12:26:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 2D99D3858D35
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=al.insper.edu.br
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=al.insper.edu.br
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCjm1OzKFj4nh+q+EYlXWIghAG2CN/LumrEljUTqNRU1YLmxdl9jIZ2xOTte1p5mJrVRJxZ8XYh8NY91alHXvNcnTVhjbDMX6YXPl46rVVWDsdwOeedDhFCvejkhJ0yqD+VRGjlwZv7CAj+KN0aBi8mhjHV2ZHW18SzwDTLpvrC9XC5GVzor6KL5Q5WMWKTIp2NDu/LPixp8lPXxv1nvwpMMYpojtWNF2JfKwPLQODA/hwCfu+rEz/VsLk1vT2j19PAL55JJIG1lCC94WJ3PxZrWlXB3dj4Bffmy4kFTRFrcLm3RSSGMpo30KIYP5HGgaJHfZ1d4nAaeJpG+fHta/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/eDpLHQ8VE1xaiHq6uWgwIdn/ZRGwhTdfpFXXR3Ej8=;
 b=B9AGx1/ClAD/Y6RCDFbl3bQBe6QeTXjB5gBNJZvk3aH7A1R+AbjE+BasR1RFA10wUFfHZHIROUgRWdPdP+m0x/iS/VQSG9gHDNKhg3dbMSzE/XmOi26xbCArKEH2vtGStQUASw21mmAMJCallFDOhLRyzvG/Y5iKxYzKWV1fjTtQ5wk9vPJ+133tPBoMVpDXMiTGDJLjHGLDgZbtxfH6y+nGBvhHz3UXzG2TtTAgf1jAW1/LVRAQT2ZsDyP7FdXs3UIZYqd1RZMVYGgh0xdauWCFWb5dBtPewuqTfEXC4SaEtJvFa32lCOzq0sb28x/H7/EG5gmScgIXMtAjgFQ6MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=al.insper.edu.br; dmarc=pass action=none
 header.from=al.insper.edu.br; dkim=pass header.d=al.insper.edu.br; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=al.insper.edu.br;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/eDpLHQ8VE1xaiHq6uWgwIdn/ZRGwhTdfpFXXR3Ej8=;
 b=bIOolSCihfCAAKe9XYkz1/nf4IH34ExxQoZs85IQIXiiWECbFR+wwYWy4/jSoIfJWgcixRAL5G8Ho5JRqBKde/E9lWy5FiE54ehO+y/YteEVpH6tDnO9mvjdp4yYIa67W/+FLUU49dRuJm/RWs7KvUDeJuPVZK3Fqi2ptHtDKT0=
Received: from CO6P220MB0340.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:35d::22) by
 SN4P220MB0774.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:1ee::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.17; Mon, 14 Nov 2022 12:26:13 +0000
Received: from CO6P220MB0340.NAMP220.PROD.OUTLOOK.COM
 ([fe80::d22:c3a6:e187:37fd]) by CO6P220MB0340.NAMP220.PROD.OUTLOOK.COM
 ([fe80::d22:c3a6:e187:37fd%7]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 12:26:13 +0000
From: Alexandre de Marchi Fernandes <alexandremf3@al.insper.edu.br>
Subject: Checking
Thread-Topic: Checking
Thread-Index: AQHY+CPnc5F/QS2uhUK3WsM0o62RWw==
Date: Mon, 14 Nov 2022 12:24:46 +0000
Message-ID:
 <CO6P220MB0340268BCA05BA3BE8499E08FA059@CO6P220MB0340.NAMP220.PROD.OUTLOOK.COM>
Accept-Language: pt-BR, en-US
Content-Language: pt-BR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=al.insper.edu.br;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6P220MB0340:EE_|SN4P220MB0774:EE_
x-ms-office365-filtering-correlation-id: 71ee6065-80cc-40b7-852f-08dac63b6b48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 kMspUl0yib2BELhuzWVVsFKnyGl4ZuANAvuNUl/SV9r1S0xzbrJ2CJZpnmePLLHC5k0izYklksiKdLGZfEVhBO8MQZxqwtSnIUviR65sA/QRbd8AFxGA44INsRxuiX/8nyh71M28iqqBQJGL5vkqJ3mFb/AZL0wRFqoo/2xdBF49LAirXqpq5DsccqsDE0DlXCMUbcJuTau80A6Qq2456zIRq7OmKrgyixqW6uCxMUWw5hw5aN+E76/3XmEv0a8jO7PEide+vIUrrtJhU5W0pGLNRF3gMdMOejV4eMZDsmAgAxM0obYxy7jxL3BS3FzKbSDjURE+ZSWRd27u29go918o+Zn/P9ypYn1QEQWmo4svRMW68xa28LlD/iqPDGKhMDlK6yAmCaSBdFdD03N7NAj9DQWTTbSoLKuJMbRmJezta/KQkY7vsdPX0Z3KXrFWs1DD8BCbkedlPgUMnucLQBJ8YWwBN19DNYKR05gP2kvtXzhirRoWA/ZodTEWe47QXDyHRUdi63VbgPkFUUWXICgvW96NdxYH0B8R7Hf1MS38WaM1c5aSBtoAGBymaXMF6mf0Y5PS1/rXu45m2w5TEeCHr5vN8OZy6HmBsBFej5wnedWQ4S6O8+BrnVIEK6+lqTqTgH+DIDs0XfVLMeGBPdTE+FlOveupqBVoCrt+AIEOHlfrNFb0V698xZ2jRqLgf03MQUo8dGMgij1aCYw6/OpY8pR676qK+J6AsYT29qsgyRMQOo2O8rL1S0e5vhQD
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6P220MB0340.NAMP220.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199015)(109986013)(88732003)(89122003)(6666004)(76576003)(71200400001)(19627405001)(38070700005)(33656002)(41320700001)(478600001)(6506007)(7696005)(316002)(786003)(7336002)(76116006)(64756008)(8676002)(7416002)(7406005)(5660300002)(186003)(26005)(7276002)(7116003)(7366002)(9686003)(91956017)(66446008)(41300700001)(52536014)(66556008)(66946007)(8936002)(66476007)(55016003)(66574015)(2906002)(558084003)(3480700007)(86362001)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?koi8-r?Q?3QxooSE5NrrsWYAWWXYXNh+9HjzNR+OfTAXJWXh+sQN624obhrYm3ECnPSDWa+?=
 =?koi8-r?Q?igmCO9PzxfwrBkv64SDyFhqAkeTA5BXTYcSmyvcsyvfQfHGCTU5ixzBpiHpeT3?=
 =?koi8-r?Q?LoWdBw6Hqbt2CtCND+FjXE2hQI2aYF2T1vKfyYjgujwUjifopCYEVKghh4S9jo?=
 =?koi8-r?Q?jtKBtLZB5fBzabvf2UtD19Ku9OR/WwzLoG+qmRwXs7j04TQXiBP33s0YciZUYz?=
 =?koi8-r?Q?Y4LUDlY7eGafb+K7Y+S02eu5Y+rSMVeERpzxw8s6X4bsRO5le1daJ8aMT8uOX5?=
 =?koi8-r?Q?1INGKp7uYe9DG6KJ9MQHJ6BJ1pkuv5z5EIeGSF7/9u3ulCkzHsAP31BaLMSBmP?=
 =?koi8-r?Q?TJP0AN40yPwO0o7Gaxj4bTT4d25nxFGCBx/J/ACXH+5swZVgl/MtrBHS6rAbxs?=
 =?koi8-r?Q?Wy50YGrzGiQWI/fA7PQiuBcvyZRZT5omz/5Be94Eemq6YxHYnYe4aPWoynrTlv?=
 =?koi8-r?Q?1M5yAibIqIgfztnqJZV+KuLCWq5jZZxcl+McrTECije1IInEdqdYmIf4QV+yQJ?=
 =?koi8-r?Q?MrYc/+ktnkByWPp76Q4biW29UflJsgm4+xvxLrpdhcIWRjCizoEbMQ9wtJSkcc?=
 =?koi8-r?Q?Lhdf9pBwrZB7d5ZQiE0nhZ3DmaNoRE/riUSfbhQLEXTFUTeBIwiP8slybvMa5H?=
 =?koi8-r?Q?4iHuPhBz4SalH7eTxccktCC3bncNXN8mbW8Xqf85FSCRBBD6TJkB2W4kWnWwpm?=
 =?koi8-r?Q?6O3eR0lpn9byfYII0gXI+YAGCZc15VzGXkhWZMX9B2AKWsnlOuMP+XDoAZXFFo?=
 =?koi8-r?Q?uZIlPdjh1epD0OJZ/HW5uL163ask2jw1k2a1k1/vIURkDTwSfFOySLYQKOvmAr?=
 =?koi8-r?Q?e4vb2z5e3kcqAwdN9XMXkGUFmUQP4rUtzKBqHwS9eiBCO+o2Jk1IebdfQlRPGe?=
 =?koi8-r?Q?BP54VzJEjURJ9QNLjj2GaumYuH1iCoPVxEHPx0oAphL3/8nS3FZa66WaXlF77e?=
 =?koi8-r?Q?wMP6KRFbbcTTV6ZGpZUAYoYZouePTcDvKA3F8nX7eWMMlbIctwJUTwuXCSRu9D?=
 =?koi8-r?Q?ACzJGOTRWGuTNRx6LbR9+gLlD+g7jZCExVZHYun7OGeC2KtHCqSYwxyTY+xp5H?=
 =?koi8-r?Q?vCtYPwnp9zZREOpXOc1vzqo8FeQ7g4UzgzER3poLTIchaR/dhZ8TTCzGTaPRpo?=
 =?koi8-r?Q?PYAFhUkwQUzJ/CIVDB4wHpVSN7rfcmuEy/8joD4XDJwoiIZn+O3hHKjBI+j1ys?=
 =?koi8-r?Q?WkTlcpejgs888ZzIClaiyirKcI9ZKBTMaXIrMkQzVD71TXJ9MdvNis7fyxXN8c?=
 =?koi8-r?Q?9ak9lLRbi7i0luCfwYDPj5lNL6GvB0za77EmAZO3z7kaeDq2eckKV4GpkQpVyu?=
 =?koi8-r?Q?AjNMTVZfialR+8njMMMoc+rvpwL69KTZGVi2yPS6+1IFW534d9/M96x9wr3c7I?=
 =?koi8-r?Q?DD1q6G9P3MttU/Y+f/CQ28qCxp3mIfjX1J6biBhH62px9izJxiSG3gi+IFTlU2?=
 =?koi8-r?Q?BNGk8ZMrMfTFzorW3Wa26Dg8TnVVslChBWGD+FHlOWzlcRCZAw9nNhtjrd/wXf?=
 =?koi8-r?Q?kE2aOw4I5oVcYojnDdpSCiIwNU8oHtxNhmNq+pkZ+M5egP6+/p?=
Content-Type: multipart/alternative;
	boundary="_000_CO6P220MB0340268BCA05BA3BE8499E08FA059CO6P220MB0340NAMP_"
MIME-Version: 1.0
X-OriginatorOrg: al.insper.edu.br
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6P220MB0340.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ee6065-80cc-40b7-852f-08dac63b6b48
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 12:24:46.7385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6370a6c0-7b90-4709-bd6e-59c28ede833b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mzRAJFfIXAhE0bobzahYae7ATSXSwy1COgZvH3cDsapkcyp01c93ojy6QHgF/AXQ9thaGF9hptPg6iXxsW1Bz9FaKogWRMlwf6iOlLVU7/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4P220MB0774
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_05,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HTML_MESSAGE,MISSING_HEADERS,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_000_CO6P220MB0340268BCA05BA3BE8499E08FA059CO6P220MB0340NAMP_
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable

Hi,

Please inform me if this e-mail is still up & running.
My boss has an i=D0t'l business proposaI to share with you.


Alex.



--_000_CO6P220MB0340268BCA05BA3BE8499E08FA059CO6P220MB0340NAMP_--
