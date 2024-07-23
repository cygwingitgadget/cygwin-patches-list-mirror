Return-Path: <SRS0=I5EI=OX=ufpr.br=amanda.santoscastro@sourceware.org>
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12hn2232.outbound.protection.outlook.com [52.100.167.232])
	by sourceware.org (Postfix) with ESMTPS id 242593858C56
	for <cygwin-patches@cygwin.com>; Tue, 23 Jul 2024 12:17:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 242593858C56
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=ufpr.br
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ufpr.br
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 242593858C56
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=52.100.167.232
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1721737063; cv=pass;
	b=pfAFdSnVHAIQ3jCLAhxBSuzrMXXimJA9ZIVPbjnel4hxAVMtR4UD76/HRUqOg3wx/MIM+HoD9An0jrhRhYmweM79xGq6v0wCZR1QrfXWsY/ueyJntZqvX/qCawYjXDTdQzBZwh2CULkjUSm4rKvvmJ5U2Pa1yOCBBqontl0j11M=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1721737063; c=relaxed/simple;
	bh=4dcHD+h3LA6vMAlFTnZB+bC+jKTv+RZONMjwus+WJPg=;
	h=DKIM-Signature:From:Subject:Date:Message-ID:MIME-Version; b=Z6h+XDV6hFR777LLy75ei4TFiPiKbcI6SuY+Xabh2JxTuG2QTgHX3fj3tndS0mkGv46m/MHjEFLERVpZg3bXHUs66OT3buM/2cuJXzBkAqT2E45VmEKFNXslmRB+VjX5IDdcZd0KhjqwV1ilwlNovGEp92LfQzVif8hJ49klTZM=
ARC-Authentication-Results: i=2; server2.sourceware.org
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLUup/jnAY/2lJfIUaVsVFSxbIn7QH7JjvLYt6nGE7TLi4avpkIeTOjlvTXDAUv0C7IQCAsLExuaSiytexKClb40jvOTttPF3n/PJFrvwgy+b5SyLgPe1hx5yP8Vpput5NWKDst8sVf6procvatn8GBxWtE59yl2+Bfmk32FlueRupNyyYtkzmBGlRo/l8idYoS0fM3eMV6dGnhtH2vT/+tVP+MiyyrkfCiapAjC3ZIw/T81GA1ECnNkA1TaohW3g9nfGoBZ8eq9qwHtxYTHCC0hndN3gdP9R2v+5Bqeo0KdZIJwdu+SPT79HLYRL4DKMnszu/jmrQiyKjm2tx3rWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmZJmSqStyO/RRvme9Zx6+ZxIZtAarCks0zq742TSeg=;
 b=BG9RZtpByZIirbFKCphm0eXY8P4BY8shOAH0zTbS23u4jdOk4kJkZ95LVHTrJTfTdjr8Pf9/nGXDIRfLowlq+WxC10pH7BLlhACEyO7ssV6oniUhvGi4LL7XgndTcRyGMy8emkbBfAwuUADDkW2AGSQk47iw2XYql4j6YfAto4ALq7CbWlW1u4xTVL+EV7ySoQvOe7k3KjTDS2OBL0Laen4mz2iGuummdKwGesmxm5spDFJ33dah3yuS6RbinfKwN0ghcqikQKYD6Zu1NEHZtRxa1mP4kTfQd9+upy7oyWyYS1fIQRR+2vkgcpmnQwqClXc1SqBj6XDpnjsKVquZtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ufpr.br; dmarc=pass action=none header.from=ufpr.br; dkim=pass
 header.d=ufpr.br; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ufpr.br; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmZJmSqStyO/RRvme9Zx6+ZxIZtAarCks0zq742TSeg=;
 b=C4/XzZ/eOpoAxgAOqMZo8eBhKO2kMcvqTdjrCace18JeTu1zjxMmcQagFi1MT8llwj3fnwymbzHl0vgoUUY3N/AYJrcG8CYiud/JUuOIOjXyfMSMpNJpy9X5xnT1QDGy+HqIYQT0Y1QVqVqX7KE6DaMev2YRH3eEu1BNU/e2U94GXLPbihvzqODul2XrD+CL96NhxfI0xsTg5EOl+CUvknN7imdGyDvr9DZ2xw6DN3iu6dVE1BIwqzhdpKFlRy5dDfEUhmiU2mt9jP9hnIOfI2iwh7eLUn8OPt7CUvjmJA8AmG5Y071zy0Svu5wD96vpt9vuzLMjx6a2r44aYT7X8w==
Received: from SCZP152MB5471.LAMP152.PROD.OUTLOOK.COM (2603:10d6:300:2a::11)
 by RO2P152MB6064.LAMP152.PROD.OUTLOOK.COM (2603:10d6:10:e1::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.29; Tue, 23 Jul 2024 12:17:37 +0000
Received: from SCZP152MB5471.LAMP152.PROD.OUTLOOK.COM
 ([fe80::e349:6c84:3083:760]) by SCZP152MB5471.LAMP152.PROD.OUTLOOK.COM
 ([fe80::e349:6c84:3083:760%4]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 12:17:37 +0000
From: Amanda dos Santos Castro Benedito <amanda.santoscastro@ufpr.br>
Subject: TEST
Thread-Topic: TEST
Thread-Index: AQHa3PnaWZAVR2zwLESLnjO7NTwNQw==
Date: Tue, 23 Jul 2024 12:17:36 +0000
Message-ID:
 <SCZP152MB54711B0665B41A849C2212B8F1A92@SCZP152MB5471.LAMP152.PROD.OUTLOOK.COM>
Accept-Language: pt-BR, en-US
Content-Language: pt-BR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ufpr.br;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SCZP152MB5471:EE_|RO2P152MB6064:EE_
x-ms-office365-filtering-correlation-id: 7c58c558-a0a5-4a1e-d685-08dcab117050
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|41320700013|366016|38070700018|41110700001|41080700001|41090700025;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?MFCDcLCKCqDFJbBQDs5eaz7R+5DG8XPZpsw+d0F279pZERhcUPgHXXujta?=
 =?iso-8859-1?Q?Iue1J7ZJ9chUY1p20oE0HnjWKCJd1pnnUcgQRSQJe6aF9NmCV3+FsyHL58?=
 =?iso-8859-1?Q?8F1+j6oRYvBwX2UVq3FnN690Qg2XRae8VUcrh2wMLvHlHYg/sP01+mc5k+?=
 =?iso-8859-1?Q?z3bRTUOFEZJ2niNuRw7DbJfiY8Zf9wjPFIFKF7OxdbCJ6unhXqMPgE+HYB?=
 =?iso-8859-1?Q?T+BmARIU5tTPVZJ2gJBDL7msHE3cRwIIvPFflJs7pqxWfOdnU12SG+klbR?=
 =?iso-8859-1?Q?KWWEtVkvnr6HtIFmrjSg65UAMMHlDkuJLNYd513HUenvQu4Hf/A8Gx2x9o?=
 =?iso-8859-1?Q?DTz7Hg+QlZyYqZnZj3erfvpGhb6JazSPnX2Hy7AqCxEzgvuZ7A3s8mfHGQ?=
 =?iso-8859-1?Q?NcZnOGnz0otetIUT2G9F7mkqEx80BK4zbaF5PrkQXmUvQzbiynJgURluN8?=
 =?iso-8859-1?Q?TXQE/ZOfmymxYmzFA997XDKhjAcF1C3v7nI5UplfPJtYFPI8RgdDv9tj1j?=
 =?iso-8859-1?Q?jx1qXXv/P3myVdluKy/UozpYmqXvalK8oznkM2lDmjqmWwsfnND/SZMSYW?=
 =?iso-8859-1?Q?HHWAr/aZv9JDyu/nv91+mGE7GF9oCGSnJU2EnZ1/xY/QZhKzzkmwgnZbcn?=
 =?iso-8859-1?Q?prplXJj7G1tLluy/5lb+fG2oqzeI1ogJlivwVrPl7wgkLKViaW8MkwE57N?=
 =?iso-8859-1?Q?oBBPgERJdCLFUGi93ZQJ/O41e+3YJGM47nFKqfQ80OZzMQtJVL2RtM9lgp?=
 =?iso-8859-1?Q?T5Imsnydr+qRLXSDfRzSdzNE1QiNqRsBO2rpdaTkHOdUC0hcfWIVivma9c?=
 =?iso-8859-1?Q?lCtVloYZAJUwLJ9S7D4LKI5P7L+JiSzHWImsYdSBWbNZJdkJn/iyhW412K?=
 =?iso-8859-1?Q?5wdgXn+lg07KkXB0cIzov1y9MNGqyvoMlZePbHF4lupZAmUzuNoNaAJlV+?=
 =?iso-8859-1?Q?xNn0wwxgICRz4ETBdS+V0aeu3vK2XRwFo9B+qZaStwMpEK5JLS/0zFQzBp?=
 =?iso-8859-1?Q?7yu43rHN/Qks7EHIBlVvHYOZALGSHrmRNDFJ6T6xNzeYGLN4jDluC/8+jr?=
 =?iso-8859-1?Q?UuxcwrnARyNL3Zfz5fzba4DU6rs5Bu8MmuDOa4Karf9sJygZyIkmAMfHus?=
 =?iso-8859-1?Q?Whp+pE6FCW4O4TttG59ozfIvIHWkNLyNl4MuWg7vgqqh6GLP6XN1JmJWP3?=
 =?iso-8859-1?Q?ecyDlgF52SMlDe/VFYys96CHj42IQtUJB/s5IdnYcsuelaCDwTFancj3Ym?=
 =?iso-8859-1?Q?F2shbN4EjCuOaStZ+OWhw9Uqm8ms/rCkt+IR9/4590HUdY/b41P9HFhfyB?=
 =?iso-8859-1?Q?xbABaF+mTAodcojm4YQ34TjmezNS1kbFoToiy3nb/Ir3X3RTnvrl5y1Vaz?=
 =?iso-8859-1?Q?lPZoCJ8NeSTGNo5k45Vr4EjluAkcWUouGvHJVbOneFQPjmTdDrfFuxD5Ga?=
 =?iso-8859-1?Q?wOhhwLnHFn3CTM/47dgekXSbGMufPbAah1mv4BDmfC2gdTgAAJmgxBUa7m?=
 =?iso-8859-1?Q?Sy86jN0JF8sTrhAfsjBcRg13p2C6PugKDerUA5m30t4g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SCZP152MB5471.LAMP152.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(41320700013)(366016)(38070700018)(41110700001)(41080700001)(41090700025);DIR:OUT;SFP:1501;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?76zaVCqQCjUeYDKPx8iqflmD6VO4GfDC4rS7UI1XGg5950TFp6rOu6o5Vr?=
 =?iso-8859-1?Q?jVl139YzFZc2kPtyYf7Tg4r5QlhE/v280Cg4y8zUPg8INeHLqNsWCN1KuJ?=
 =?iso-8859-1?Q?MXBc3Bd93GvdKVcJ5nkqVGyXc14TC+hhZLGVIK5DJyuuhJ1luimhga/WnT?=
 =?iso-8859-1?Q?QpfSKp/7Nw7gyCNHE/xtwSDg6B+63Y2vmFp64Bs+jjKHywU3Afp9lCMWjV?=
 =?iso-8859-1?Q?1XeXHTSBrOOAOH3/tXu/EDjEv8xgfv69AEprhW5OwEoF9UO7GSkBMC3TD2?=
 =?iso-8859-1?Q?iIpO6F2eTi6U+NMkVe7D+f1Se62wKOpgG7VvbAT6b4msF6L4a7R/3NSmhK?=
 =?iso-8859-1?Q?bNBLY7ybQDh028I3DfdlssABrfQz1e6BK7fYV5/aEAmjomvNaeYeqTbrQ+?=
 =?iso-8859-1?Q?NPoLc9x3GyK/+NIm63RxMFJL6IO+GWHEXmQY67GN35J3pWWGCefC3XlggL?=
 =?iso-8859-1?Q?LTeiNHXX9aedkY0AOAUA8CQE4CSDZz8EDtwaNtm7Ghjjjix3lxND6a6EQC?=
 =?iso-8859-1?Q?u9KXJqcCD90nK/SwD8CSxfdngSPCNXr9s5wB6LvQuSaQbD3pwizm1+XPck?=
 =?iso-8859-1?Q?Pn83xbdhA6Zg/xPmHFaqHnS3RPBDGclRGVs6znmh2o2E5z3GzO+1soVBS0?=
 =?iso-8859-1?Q?gttfkFAvp0yPVP5U4gnkk2WOuWsx8owjMb+Ou807B88CkJ65hpmN9NmDd0?=
 =?iso-8859-1?Q?w2UTSazNEHH4rp9eLKNXNHYb7d03WODxyyqzMCBzDnifX0MZndJ6bvrSws?=
 =?iso-8859-1?Q?doU4duairzJHbdFwqSM5Ztc0upZ1OA9bJ75EpJhQpGBljRcLXgprvO8xNy?=
 =?iso-8859-1?Q?UtGGRjBfXl4l9PRZj8mdGxtp3LUW+l/K+XglCS9kKl14uC0S2HgtosJj5t?=
 =?iso-8859-1?Q?GEjy9DaF9yYBRu9CKFD4F+YCKo8dK7NbTupFOeSVqHJJmj0L43CHQMSdQA?=
 =?iso-8859-1?Q?zN0lPvV+sxULaNThhCGijkwp4hYG0rfUSSP9YoRh0i+D5Nd2ORFzMZ7kq7?=
 =?iso-8859-1?Q?NXbDxG9nbeggTWlbpDpKz2Cjmk/ri5zx3+yDsAbFW36TefO10e5wgeU45X?=
 =?iso-8859-1?Q?oT+rPoOK9FXDaf5fvacQgyFoaooGSaUDEnWjoWVAU9UZK6B8GICRRCK4Af?=
 =?iso-8859-1?Q?utKaoUx8sie3M57UZ0Vf6JbjLKafTiov+38T99l4xWgTh6h58Pe+NeVJ9F?=
 =?iso-8859-1?Q?Jct9PFVKEBlNcvSNUV9HoalIyM4zcIoJMTQE8ZE6oftT8BAgwMaZ7Z3b2A?=
 =?iso-8859-1?Q?JALRMnduCr1Otg9jYaZzCfqld9drKgc1UFp4xtgikUOShK3wCtx5axlTLf?=
 =?iso-8859-1?Q?t1FPuyZBD5LgANvojL5uTv1ry+afv0HXUl+XZ8X9ZF2MQoEIEYiwMAh/ND?=
 =?iso-8859-1?Q?4rZyXGig0dEUVtk553qkrOmVwOjpRQJCPqHzzHgu2MlvuxLKV/0dV5E95N?=
 =?iso-8859-1?Q?K9Z81X/NUmoAHQGT2ucLFiIgp90bvFe/Liv8COzmeZfYqD0lpyM4uyYeFa?=
 =?iso-8859-1?Q?Tc5U9mkRd0Ql64L4zBxQ9rBxkXhK0/v4tdhJDptKmo15z3xAdPokwIUQl7?=
 =?iso-8859-1?Q?6hFqTbPUyD/JMDvo4QGHJ5S72yLSZuvycDrUGJblfqsLMJeZKZeCiN0kgg?=
 =?iso-8859-1?Q?3FugsIpymCVbzckD4Bdg2pX+SlXbRuoY2d?=
Content-Type: multipart/alternative;
	boundary="_000_SCZP152MB54711B0665B41A849C2212B8F1A92SCZP152MB5471LAMP_"
MIME-Version: 1.0
X-OriginatorOrg: ufpr.br
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SCZP152MB5471.LAMP152.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c58c558-a0a5-4a1e-d685-08dcab117050
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 12:17:36.6384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c37b37a3-e9e2-42f9-bc67-4b9b738e1df0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5fG62cwnQfFyt1J1bRRMbqQq/KX5p3ue9Ya53QctHWsDsaR1axbFSG5QOEMrUyEF5co+/ahUGsVRE88/kk3TYGKBJ5JS/fYbFlVZeqeat74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: RO2P152MB6064
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_000_SCZP152MB54711B0665B41A849C2212B8F1A92SCZP152MB5471LAMP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello  there,
Please  respond  if  you  are  still  reachable  through  this  email.
My  superior  [abroad]  would  be  pleased  to  share  a  business  proposi=
tion  with  you,  if  you  don't  mind.

Amanda

--_000_SCZP152MB54711B0665B41A849C2212B8F1A92SCZP152MB5471LAMP_--
