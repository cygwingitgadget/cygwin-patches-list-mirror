Return-Path: <SRS0=fnnH=HK=eduspheresolutions.tech=debra.smith@sourceware.org>
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on20700.outbound.protection.outlook.com [IPv6:2a01:111:f403:2020::700])
	by sourceware.org (Postfix) with ESMTPS id 353353858D1E;
	Wed, 29 Nov 2023 10:05:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 353353858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=eduspheresolutions.tech
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=eduspheresolutions.tech
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 353353858D1E
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2020::700
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1701252334; cv=pass;
	b=bR4Y0rxuZ6EBrF2DnR07zMHqWF+PYtZt0az5QtiW1+LZc2BFpOIV4wLEJNupA8HIcsMwOkNwNPZuAycT8BCGDvxGmmva+9hDDiHeQK9ZEESJlsvYJz0yfHUshmXjZqFcBZLSM+iK+WR+q20q6w7U4Srver954feo8uLIg7y0Olw=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1701252334; c=relaxed/simple;
	bh=+jEcQ7t/KZ4FNVnWESRR9yU1yH1ePwseAOTuiXVLYPA=;
	h=From:Subject:Date:Message-ID:MIME-Version; b=dDdXZvuuFPhcK3MwHxAmsNSYoS8qIHiSvCRJTD/bNAwdIqkbTG04RnZ0cW283Yau4xWfM/VPG7o9TNZ6pJuBBIdfIv/l9oyem+/q3gZ8rlAVzgGDbr74OwTQsA9Ruz58kI1CucG0JhJskY9bznpq05+7Qoig7SN4nDpF9069tNU=
ARC-Authentication-Results: i=2; server2.sourceware.org
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpvtuVs7od/7EdsHVFkkYpTRx1Tj0ckNFmXgyJ6/lsTP17icjpbzjK5QxVBsSt+HApsjImijvseISW0EaaA48BwrOfRu74pKUnOKzuicoHrKic9LuS4GSfvIco2JqOjMoSIfM5o02/qYl4mmhdIGV9c87yzW9IfZoEQ80rvZfkZDw3sIgzVuqFRrY95RzHNm+Rl1iKzlY2P0d5jfyte7LRI8La4Y+JF2CYzzWU/HbdtQF8VirLtRO0biR74OhZbuIskmFEl/EaFksfRpy8tj5FBEqX6GbJVA2IafyIA2EUN5gSe3VCrm6p+V3orWcyKWvi18WOodsHKvwDOr+ryhjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBt0n7cMZkzkThgnQjghIfgioOUfDa8t2A/1DQv0igQ=;
 b=fdaSc6sZPR9ddrHSl/ry9n0Y5Zzr7gowph0yqY8vMTKaRX7FCGs91INcOygkDJNeYd46rOx8+SZCP0TaNksaD1w1EwgVJsR2rgmpyV3njlfaBSa5YWOcCNpVhZG9sIJM4frmvfhRjveIWTxeLiKEEm4HmmekmLR4iK7cJC8sBS29L+oortawpcinl33mKgxkhmdokL1kG66JZlnZrB0KPPJsWo87F3PsFeVnbkMwk3YVW5BfEJ1yuTKmTbTd8u6qQSGdQsDrgH40Rpfi0RiGVXrbadvfM+Mof+99dovjF8aFsChzBMLKjT89AyHVDc2q5wicMVHMro0SI93AVmWncw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eduspheresolutions.tech; dmarc=pass action=none
 header.from=eduspheresolutions.tech; dkim=pass
 header.d=eduspheresolutions.tech; arc=none
Received: from PN0P287MB1061.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:139::7)
 by PN0P287MB2426.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 10:05:24 +0000
Received: from PN0P287MB1061.INDP287.PROD.OUTLOOK.COM
 ([fe80::6271:9c81:2070:6c01]) by PN0P287MB1061.INDP287.PROD.OUTLOOK.COM
 ([fe80::6271:9c81:2070:6c01%4]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 10:05:24 +0000
From: Debra Smith <debra.smith@eduspheresolutions.tech>
Subject: Re: School Districts Contacts 2023
Thread-Topic: Re: School Districts Contacts 2023
Thread-Index: Adoiq2vrsEqiFQFeScW4fYjRjRpY0Q==
Date: Wed, 29 Nov 2023 10:05:23 +0000
Message-ID:
 <PN0P287MB1061BE8243DB4F1DCB0D5340FC83A@PN0P287MB1061.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eduspheresolutions.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB1061:EE_|PN0P287MB2426:EE_
x-ms-office365-filtering-correlation-id: aba46b68-df72-476a-05d3-08dbf0c2b3ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 em7tlyKi6lkzfjBko/J7Ncg0+0qMbJrcOPhcBP5JccurebgJeJuYR+uervTG73h66ANt0MYRJ7pAeCTVNeneG09UXXBOGPNBY5m2eFJ9X1QwsdVst3CWuHQPTHxqQpQPaj1PUD/lDhtF7/EodmDHV4a0Ztq1kwtUA5KoA20TcRscm4muIKPGMsd7Mz6OqXytz2uR1V7H0uNJWRml9PxJ7kStKhTzfFlTqTsz2rVAp0guboQmsz3QpZPZHu87LSHq4UN8vy96S1ye0tDtWdlYlD3WFoDVtekkfRkIgKqSELfzLXW2R8vyRU4rH6zIRwaO865RP+vdjQQnLaLkSk9CettkRH856HLsmshUini7fGo/VPmbZVeE1/yXBdkaj0fnDcEqyf26vyuk5YaTQNEoStS2RZvF4jaXHxdQlZoH+jwOeqQemRwgG7Ztg9x8QmaXCmj7O+GwTY2oMQcxXtUfYHRqEfhaj7zr++o7Tux0/EOP1+jALu/j8ExogTig/EaKewkUTeE4cG5QKal8SmWJyKDksm8m4YYKBLfG76afbnXtnJ0chavk41liY7BTFCGca9/q4qj2RsI/LfLtZcdy1ulTBy5HSDkL87+jEGbzymDNsDkPJUzhSyQxfr8WSHSi
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB1061.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(366004)(34096005)(39860400002)(448600002)(230922051799003)(451199024)(109986022)(186009)(64100799003)(1800799012)(66556008)(65686005)(76576003)(66946007)(76116006)(88732003)(89122003)(66476007)(66446008)(64756008)(586005)(6506007)(7696005)(66899024)(9686003)(33656002)(83380400001)(86362001)(38100700002)(44832011)(5660300002)(7416002)(122000001)(7366002)(7406005)(7336002)(7276002)(8936002)(8676002)(55016003)(41300700001)(7116003)(52536014)(71200400001)(38070700009)(38610400001)(2906002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CkxW92lCVmylP8fakdKhxRy7aIxf5VksoOQM92CTtah9P14v0gZ82ItiPRMJ?=
 =?us-ascii?Q?PjcfS0qhCqFk+jjgmgVM4XbTPim09tP137PT0I7wR6zbexp2aCwtjfSv2eHF?=
 =?us-ascii?Q?Qs65PPRY/6o6+1kLcynya4xPqFWXym33WYvJKAS/SKx7U9M7npgHS686PA20?=
 =?us-ascii?Q?Vl1coj+7SJjz5QSMnX77v38yeUC9qdiU5ZcXGD0Fm475yW9yEecYW+ILnGRP?=
 =?us-ascii?Q?U+Kmyb7mh2+fY4K8gxLJd51jZOuCL/LcTSRrc7VhUHVjbJauXDLuDx01hq4z?=
 =?us-ascii?Q?Po3BiGL99qz9V5qWAProBJL7hnKYpNrIWxcZxEJ51cxKvyAIEfwjjBMuCXDU?=
 =?us-ascii?Q?KpOXXeZ/TCP+GQyDyJGZZquVxpQ/XQVCHNE+i2fP+ECV+PMb2liGEovO8X6n?=
 =?us-ascii?Q?EAJ5Rc4Gt7+Mp+ksUEyjDplDwVsWBSeJtXThdySBS+wg6eNmxPpTgIyLQlrW?=
 =?us-ascii?Q?2M85CShYe2BXvpQnVeWNaFbko32I5BSHsvfnFrz7u5n6DD0P7WM7enH7B0+C?=
 =?us-ascii?Q?tbnz+6Dftqg9Xaij0O2fdIj56pvy0p5sDMmedeDOwn3DKls9jJvsgwHTlcbX?=
 =?us-ascii?Q?f7v5uU2ylQvugib2D1nS2k7jhpp6hDhXDUNPpPDlxi2BoyY+4lHp9g6ajCnH?=
 =?us-ascii?Q?t7lisKA+ccxqCkrFoIxlzM0QSM2IOg/GDPgAXNxWKuEKP0PSLY7LBvKqbuv3?=
 =?us-ascii?Q?8sONf/QQ0ze53nMkEHTNWK9iekdLonY6LIExCXbbdNaSDVkfK+A5wRn9x5XG?=
 =?us-ascii?Q?P57+t8uOWMDnHfsTJit3/JLvttAWIy7GhTI72OwH4IVM6G/KTZWC6Xa0yrDv?=
 =?us-ascii?Q?aUNFrrR8lhZ38HNlKoidxDhNfWF5DE9Jh2zwm1PBQY4/iL3LO/dFN5mH+qvf?=
 =?us-ascii?Q?CGgCuLIYKTuHVV0wTMIz1CsW1vkOoNpkZAOZmXX3+Uwk8mTXpLDRltaP9u9Q?=
 =?us-ascii?Q?ewc4ZVYQ45lvhyr5RRC9TIoxcabUitXx6/jb5CCVoRXx3DqBGmMcPnJWRA8w?=
 =?us-ascii?Q?imXgO2HXiO41w/VcjWO5Wd7fyBHF+QDh1e1tbavvFQrCMB++sPxwl6js/DDk?=
 =?us-ascii?Q?Whu0c+Wem5U5pqaQJ7x8Fqaf0uQ9pehruVSsqF4FANEkJWJd+yY6yjD+ElFK?=
 =?us-ascii?Q?cnRzbzHwWG2KRvWGxgVl3NwdETQI8/+q47Z1aP+TFVcW92nJ7YeNsPJHe1zv?=
 =?us-ascii?Q?eSKFq+FBZPQgih76POxjePTZ7ih0nyEOlilp0iYYm7/c0BPfSuyaQ/b6ONFF?=
 =?us-ascii?Q?uKtnFbSrXRFnF+R8qu5dxgXeGg2FAJSBXLj0OBGqqn+gY4JaehWMMbkoypzF?=
 =?us-ascii?Q?ZnWOHn3ljGXa9rmX+x3dKCdv2cusdS0qOSfLgJ7bFPuF6eafbX8cqIJnvGwZ?=
 =?us-ascii?Q?xcuxnP9bYc8PrNuzY7PA218SNbjvjP6N21E81xPAvNcQNVg8FSJWjyKGICvF?=
 =?us-ascii?Q?5VvF3qal1XEmRsvYhslcsF6rBv8Ut3S2BKaGAYkytjPXXcMTjCowtkL13rWD?=
 =?us-ascii?Q?WbA+dnF0IgU2uRAQLK1waVkI9tJPa2VocL71cfbXKuv544/yZC0/o+ZdzvZ0?=
 =?us-ascii?Q?dX6nTxsGZHXdJ2URQNfhBSDbbroVHn2NqPwPidi605lHPIbEm7FBeXoTgoTz?=
 =?us-ascii?Q?xLOaFGC0++lSqvNViDyGicOp7MKAL5Y21sXW1GXpB5YP29zXn48e8ElDhxdm?=
 =?us-ascii?Q?LdON6wJWa9IagWy64jUA0Cpcn9o=3D?=
Content-Type: multipart/alternative;
	boundary="_000_PN0P287MB1061BE8243DB4F1DCB0D5340FC83APN0P287MB1061INDP_"
MIME-Version: 1.0
X-OriginatorOrg: eduspheresolutions.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB1061.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: aba46b68-df72-476a-05d3-08dbf0c2b3ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 10:05:23.5708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: db65f3c7-c855-4e49-97d3-de2428298599
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: burgrN2T5pbX2cCnFyfNl8Bry6tI94f3dPAODqzD+p7NRLCqAhlIxGxrOHYsgk4f1jrIG1U0qUWrOo8u74ktJlTsE8a3wD7rvQGRqrg4XAs8+2sz8bW5CDQaIAnko3SD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB2426
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_50,HTML_MESSAGE,KAM_DMARC_STATUS,MISSING_HEADERS,SPF_HELO_PASS,SPF_PASS,TXREP,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_000_PN0P287MB1061BE8243DB4F1DCB0D5340FC83APN0P287MB1061INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi there,
We are excited to offer you a comprehensive email list of school districts =
that includes key contact information such as phone numbers, email addresse=
s, mailing addresses, company revenue, size, and web addresses. Our databas=
es also cover related industries such as:

  *   K-12 schools
  *   Universities
  *   Vocational schools and training programs
  *   Performing arts schools
  *   Fitness centers and gyms
  *   Child care services and providers
  *   Educational publishers and suppliers
If you're interested, we would be happy to provide you with relevant counts=
 and a test file based on your specific requirements.
Thank you for your time and consideration, and please let us know if you ha=
ve any questions or concerns.
Thanks,
Debra Smith

To remove from this mailing reply with the subject line " LEAVE US".


--_000_PN0P287MB1061BE8243DB4F1DCB0D5340FC83APN0P287MB1061INDP_--
