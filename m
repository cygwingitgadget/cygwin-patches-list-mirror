Return-Path: <SRS0=b2x2=7N=hotmail.com=nirbhaya_singh013@sourceware.org>
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn20823.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::823])
	by sourceware.org (Postfix) with ESMTPS id DEE593858D38
	for <cygwin-patches@cygwin.com>; Tue, 21 Mar 2023 10:22:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DEE593858D38
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJzoM65A+3/Djh1vz/v+Efdigbz3DXvrCwCUfylLT45fajWS3v+zFbJxibtD5hga4cxRn3dQMfTwJq0mrGyQslMy77d2QMGRtEN9f6ks5Nt6Jylk5/vvd/W3UsNgSjjqQYtS54hdJNsvY7x9GU81qBVa5Ek+wXvtCicxAmed+K0e7BIHwN/B6xt1RQHUJKWVNRiqfs+DWrTxy3+Kelml99icQt6yb53sBJPHMNzfqHcG98FOzAZ5lbl/LhNUk3drxznIb0LiUSaxa85fqIv3bbV/tWrwV9vh4ykxGfxdddCcj2jVytesSI+hpt/DESLl9KogRw/kKXKwtDfQB/J+Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SH0TcRAG10DukoOPLJBUp8Zb0eV0O6VZWdZApE0G+s=;
 b=ZZrzKqHXTcwY8Jb0zPohW1CAub/yeVh1pwX/K0AhUY4i2uYW9PkoPn8BCd33l4QICK6XXxnX05tEei+u6YzhiuyV9cLoRll+SL5ht1comJGmBVhdnXhhIi1JcDEbJ/THgm6w+j86YWyA0PItDQEw2KXQa3fgGU1qAcR0k1HfCDFwuB5oBL7UAvxd2eK6MaLi08jhYEwlbT7MZL7g3UcilKCb5Zul3MqqOSKZ30aTMI1pU4RfxfDFm/GPax2uyGh5aw5aSB4BOuxhK35tAyG/bzjVADGpBnFtT1b0jCKJn7l0vU0EjXTSNGZsDw6F1Rc7borIsDk86W89FZkSm5Yk2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SH0TcRAG10DukoOPLJBUp8Zb0eV0O6VZWdZApE0G+s=;
 b=BS+G8No52uqMbfAPmmD/Z1HPBkIbL48u3yLcbOfYi8AbiRFznEpfCPBz67O/EozrSBHpkZTVwlQ1VTaIHbHAwJ9qn6+BH0ylTA5E4TiTaz5Jqp3PXR2B0vAkVCeaX2tCNsosIpkZb81t5Dlvxi8p4i3A0rcRo0TcH6dE0k4vOBDyZj4mIbo4xpZAKJ4kQb1fZdnWZLVc81SK0WR1pjRtq8Svk4+vvu6mBAvfzlOctkQSZH9/CxfEXQYKZxcZejjg5U1rfF7jOGk1/DNq54n1Vn1edds4RtcZp5BrL6+tOxeFy1M2qBekipcU5S8p/qbJcS/rtfmvAt+kvPnh+Nt8SA==
Received: from IA1PR12MB7567.namprd12.prod.outlook.com (2603:10b6:208:42d::19)
 by PH0PR12MB7813.namprd12.prod.outlook.com (2603:10b6:510:286::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 10:21:59 +0000
Received: from IA1PR12MB7567.namprd12.prod.outlook.com
 ([fe80::d1e:bb40:99d6:5c7c]) by IA1PR12MB7567.namprd12.prod.outlook.com
 ([fe80::d1e:bb40:99d6:5c7c%2]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 10:21:59 +0000
From: "Ajit" <nirbhaya_singh013@hotmail.com>
To: "Ajit" <nirbhaya_singh013@hotmail.com>
References:
In-Reply-To:
Subject: RE: Apps
Date: Tue, 21 Mar 2023 15:49:27 +0530
Message-ID:
 <IA1PR12MB7567A550F55A3A261EFAB955DF819@IA1PR12MB7567.namprd12.prod.outlook.com>
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00DD_01D95C0D.12C63490"
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdkbVnFkylCdXamnTqOfJE7l1kN6QRAh41sw
Content-Language: en-in
X-TMN: [sya3ZtEqjxtxmz0aNkRNxRReQw68JQ3m]
X-ClientProxiedBy: PN2PR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::23) To IA1PR12MB7567.namprd12.prod.outlook.com
 (2603:10b6:208:42d::19)
X-Microsoft-Original-Message-ID: <00dc01d95bde$f90df890$eb29e9b0$@com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7567:EE_|PH0PR12MB7813:EE_
X-MS-Office365-Filtering-Correlation-Id: c1a8cf04-4e08-4221-d7fe-08db29f61a89
X-MS-Exchange-SLBlob-MailProps:
	BVn/NbfP0bckSi2iZ4jC4sYzcZY2Ysw64WQ15ldvToS3i8/fzQikcK1psRQi6O4Ez3dvp/+UNngXUb3Tca9QHFYN/3fI4Ir7csPQd8EIs0uk941MT0TQtwm+d+kobl2TEL6sjd8U1/Pr7Zu55DsO4Np4/qd8RNNngr6JR0fU1rlo893SF1tlVP5G4i9DELb8MTXyJlPZsakFwt9+a74zGLdjDKXNkxXstMMM5x5jxScHNBi7G8ZdckhKNxpDDPXzXkgAX17o7C3QZUl5TfBMnVo0eJxIiNHJWnK65Wv5lO6ARinreGonrXr9LR3MsiKhglvwR2drJvV8bWu+2TNfXnI6IkD1rAmYDbxfr8i1YwVb8exB81NM4RXW95G9Kp7j9EeDgV58OIIpkEJF+Us2MBlSCCv4nOwOPdmcBSzRrwvpdPD5cNB0mwn290G1zUJ6uR6TamL7fjRSS/n+lrFMXdeMACwhmeixkUBoZWcVwP+SJYCimhIn63voOxrCbZ3TQ4LgfERcXhc+zp3LNIjvB26otZLaSsdoI+QuvyiRx1JcbAyJla7b+n3LSRHgmeFfbt42SEOwhIbrhvU2kqR4ndW8scLjCde25JTzShfbH3gStvuO0KvarhNVB+Oj5N6JimGNDOKdv0o=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sGR/OSLCUVa8/xURD24TJfuCGHyqEqiWYXwtKtjrEiQ/Ja+E1L98N1xas8OWHSO8MA0SdcSUyssIEmHcJSVBBEDWmN2tzF8fFepmlZwhOWrcmKa82uqtLvJNfyg7tTItiVUiEZM2X08vFUxb2y6CS1TuicmJvv3qceNTSj4gztiIb+RyaESo78Qh0+p6PjB1xOkke71JupNfxD6jezUVOrMHLFtxDQLMCOj3ZiD5IeYW2fN3BSowZj/PiA3vB2PvbUMUUDf+aOj266FAKIhoHtpLT4NIaZQq/aV6+Hoa2VU20mCHRjNCXGh90QpRMcT8HFwxz0x9hDrzynmvWCzLlv93NIxCceQFaZlty+xZTc2tp1TeIxK2uHqtE1gbVvxF929DNLJO5jryT4JpSqMtr8RY2dDy2UkV4JtdsNaVN1YU7rwn/Mu0y3n2Qp6AiuQEPp+AepVu91rixIQ+DYRJU8AgExevKfwjiHXz7zNuysENsg8SEbhrIImXbDDjRi9ygDxpqKKZv6WlzG+Ygnq/9lEOi+AHQMY5oz3RxPpyvt2rCk8oH38qhfFq4Xbnf3yBU3XOCz2/96d+5Jc/D6y4/EEhnX3SPQJRmdOFrUfzxSq5XIJ3HvLXgkR1nC8KAe9CNn5QRWU/oUfO5OFY7JSvoSgS6HNr5tCnkBoNxVdJTzHY4hSlinEuIZEBN+eeV6vz
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jKNMkR5CMG8yoFPSgXzqlwxUTCEdOSbLmAViXC7VmCKmxhzUDl12MSrqaejX?=
 =?us-ascii?Q?uXwUZjAMwBLeO9zZbAGYIKB0mFo2+RR7CQYdoIXFT2S1J2ILJYOvD8T8u0lI?=
 =?us-ascii?Q?LZUv36DHFJMSmSIhjlktej8Qn843CQ39y6hz8t/w/ztpLJpJVgr8dF2mT6Mf?=
 =?us-ascii?Q?NSmjlFIRuS5muAwuPlFjBho+89adcAYJCrLkv1Z8wfGGAKyFIJg1e00fRip7?=
 =?us-ascii?Q?sGsbOSoV1vmYL78wKNZ238MrakrN2cdhXLJsLsSSLGVbkuR6q0dbW5nIma5a?=
 =?us-ascii?Q?A/sAhA/7mBBCuJXL7yt2puyybG0/vdGdveq9lUibcOxL/WEq1C4GG1Ay41bT?=
 =?us-ascii?Q?7j4ztnIbCUCuU5WlWXMoGa4M+m+cljuamLt9RYc/1IrMkOdVEzos+ep83SN1?=
 =?us-ascii?Q?Tn1PG3D5DKiRp/OD4ZYXkUkpoiS9HucCFBax0g+wZoO1LEfWspFNoHt3sC3c?=
 =?us-ascii?Q?UjB56xI/+Hcsnel5P3J3hjI9bZoaGfZIJyQdOOpq5ImneyWbo2cHtF4cFr+X?=
 =?us-ascii?Q?3g059zs6MXiB4c6HL7DJI8s3C00XBdBnG/shQ0W06vOPen6JPNWtxI4d0IZ5?=
 =?us-ascii?Q?tAIAXhncAnpuLQ9bYkBbZLB0u1BZtKQScOAUoiM4gQvTVPZeDWoDRW/SRfHX?=
 =?us-ascii?Q?geiIDcgHb8FvyycNTtoESsvYjBTRfaIiwZhTO3gJrbogQ9KGQ6rpXHcvpBgp?=
 =?us-ascii?Q?LflWj0SVOGf2O6WyKk+B10J/BjqIFzvk17clmI7Ikh0QVH2ejC0WZI0nMa2a?=
 =?us-ascii?Q?kuwEZt6EvNNKa2c9zdGlL6fixS1rs7GhjKv2KF9iIG7ngV28h96xT82u9B+1?=
 =?us-ascii?Q?luOilL7YkRQZy+rExY6UGxOkwaZnn55/uPetA3hXFM0aVx0WHwrg837ynO8k?=
 =?us-ascii?Q?LbnPlHoL2CTnQs7sRN5P0bDsbaU+LT0o3T9lMOXv01JKtgZhhkTW5J/D3X1L?=
 =?us-ascii?Q?dTMEHLYzbtsDeTdmfyTCmUXSBj3TEqdptoBB32DIqU0H5IeBlqUmyb/RhN8l?=
 =?us-ascii?Q?nQR8nsrFJ1aoOVurH7oem19Ab1AWdYHkv3ax/JgnD6XPoUq61sdRwGB7yg3V?=
 =?us-ascii?Q?GqGKf4uqv2FYT6ryKPtcmsR3BpZaCi5XYQngPKGazTiSpNYHEXg2kQbXkfvr?=
 =?us-ascii?Q?2QlAAaPcuJyNZQqjvvvg1PHcDiCqkQlq/iy6HFF0cZ+fW4BoIKj9R4j2vpN1?=
 =?us-ascii?Q?0TOOFLpy5KunGT8rDEuyd0pTmTxEVwOfR00wCiYlDgmryGdai2s0biKCzQDD?=
 =?us-ascii?Q?VtysfrrTlQTwn7NDwrUsj6Y4VBwEb+fSm/hWoQYUPubBCUR0b9wIrOJO/+l5?=
 =?us-ascii?Q?nyQ=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-71ea3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a8cf04-4e08-4221-d7fe-08db29f61a89
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 10:21:59.4649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7813
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HTML_MESSAGE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

------=_NextPart_000_00DD_01D95C0D.12C63490
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear,

 

Could you please share me your reply?

 

Please tell me what type of App development you need.

 

Thanks,

 

 

From: Ajit [mailto:nirbhaya_singh013@hotmail.com] 
Sent: 29 December 2022 01:12 PM
Subject: Apps

 

Hi,

 

Are you looking any type Apps for your current business? We have intensive
experience in creating apps for:

 

. Education Apps

. Food Delivery & Restaurants Booking Apps

. Logistics Apps

. E-Commerce & M-Commerce Apps

. Real Estate Apps

. Taxi Apps

. Business Apps (Billing, buying, booking, tracking, Finance)

. Lifestyle Apps (Health & Fitness) & many more type apps build regarding
your requirement.

 

Please let us know your App's idea, exact requirement with us which kinds of
Mobile App and for which service you want?

 

Thanks,

Ajit

(India)

 


------=_NextPart_000_00DD_01D95C0D.12C63490--
