Return-Path: <SRS0=0muy=ZI=microsoft.com=radek.barton@sourceware.org>
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2071d.outbound.protection.outlook.com [IPv6:2a01:111:f403:2607::71d])
	by sourceware.org (Postfix) with ESMTPS id 130E1385800F
	for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 07:23:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 130E1385800F
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 130E1385800F
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2607::71d
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1750836235; cv=pass;
	b=YkZtfcGz7ie2fRy3iCXFD/Y7u5v9NOhX93eC2epPmp0BaKSvNUUwbQvAcxkA8jvPcKItV5QuMslBU2dfiTiShqWOYbHdd3nhZfiC3Ss3qrk50vWzOz+NOANNKk1E4d5SDon61QTX3ISLqXQcKbNMicpJuNAd1fs311Ww6Eov+Mo=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750836235; c=relaxed/simple;
	bh=WfqovSCnSaKQ8vtxrXIBc0zSxUC+j/JxJA1kFeZ3rXo=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=IwgUegR5KJopSASiaWSh4qFQZkHaAxbXBBa6Tg4Ee17cqdELouo3EGM8aQzZ7HWY1rod/7HlpUV3N/6mZnbJukJn/mdWUzKarHdLDdzSR0lC+VZLZ4h2UPHPJoAzks2gb+sGdz7qRDMvNmw8IOKxsfT7s8AK9e6uqHccs0oUzNo=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 130E1385800F
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=Ca5cC6o0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BSZ7qA9pC2DQ1VSvWO24qcwQwXoiRxNREbRz6d28hr8fX9WCVIrvumWWMXydbnotRpdLoFULeVRI5P7uS8HseKQJDnxh0duQVKOsLBCRuNN3zonKv/mq/0ehP/g8dMt6E7OJe2kNLNngXhfIyIsZRIEwWhAUoYnvKiwxM9zskbX4ws2VbWTyuzeICNPXgI6ZjwO1NKqJ3Bhg8dUBbjAnToe8ZCEzibCnvWkQd4kbrBaWGLKRFWQO3vRSQ4201dczlZtdoCnMK1Xzdvk9OrZFyUtG26SkiFu9EVlld0Eny7UoNindh6OhSZ5RWuB9auoBOBjkzIzctJd8QXjb7K95jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/nclGpjfkQHMtdmOLpE12JaaXMaICdu9paUHR2XDXg=;
 b=hwZac5kYmKl7f7p3VWZb+cHfjXVgvrtG4wnnrWxEuFHnW2DgIpPSn2T8aWb3KAYFiI9Je67uxhsCFXKRr0LkOJpdCoZjO5PfpwpKW9NtGQlOBTXck71X9JrNDCWInGYybyBjs8BHbeuUYFPyQB0/LQJsppwMWxj4uP7lJx0aouaDELTd1noKxmoxrmlufHZEtcobO4DhDTcWclWFQlOpJnd665pTkmZM+y66PERqXMKzg1VmLuCyQJS19XGa8SaGGa6/+F04dXT2Ta1tehceY8ZRIJ01QPlBMtQz04rznLLVeWIOUavxHQi9zKhpMYGk8cq3vO6sSn/kRiGIVTQE8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/nclGpjfkQHMtdmOLpE12JaaXMaICdu9paUHR2XDXg=;
 b=Ca5cC6o0f0Rs1hGo7AC9i8ibeo/nsixzQdcE594NvJOIg+YvlN9msyx2rfhfKclPKyOVZb+DOF/ewMT46jfGr8ksd5jqK1SzBQXk5jNOK626lrFA8z5xByLQW8R3hh+gKYfdznuz3+mYdV6+QdeQs30DL5JgxKu5rMqEsOMUDaI=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by GVXPR83MB0735.EURPRD83.prod.outlook.com (2603:10a6:150:21c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.5; Wed, 25 Jun
 2025 07:23:51 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%5]) with mapi id 15.20.8880.012; Wed, 25 Jun 2025
 07:23:51 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH v4] Cygwin: stack base initialization for AArch64
Thread-Topic: [PATCH v4] Cygwin: stack base initialization for AArch64
Thread-Index: AQHb5aIZzf0AvyOxlkS/WVQVnMTnrg==
Date: Wed, 25 Jun 2025 07:23:50 +0000
Message-ID:
 <DB9PR83MB09238E68F3977CC064F2EDC1927BA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
References:
 <DB9PR83MB0923A2E70C6E9F5931020E409272A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <f93437b4-a88d-9cc6-b156-a37b1e629810@jdrake.com>
 <5a0ee0d2-6fac-1886-45c0-c75dba8d0bd7@jdrake.com>
 <DB9PR83MB0923E495EA001D0887EC80469279A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aFj-bZ28sTEOvVqj@calimero.vinschen.de>
 <DB9PR83MB0923D30C1D31D3B74457118C9278A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aFufJb2PZg1pQ5Ha@calimero.vinschen.de>
In-Reply-To: <aFufJb2PZg1pQ5Ha@calimero.vinschen.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-06-25T07:23:48.469Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|GVXPR83MB0735:EE_
x-ms-office365-filtering-correlation-id: 281ebb5f-69e2-4584-9f3a-08ddb3b93bbc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?yW9h7n3oyzw2Y1aA7zdqC1z4QvieLfRK8fu4E1F1jS+RIjsxFZ69GTWmip?=
 =?iso-8859-2?Q?2Xz4eSS0gqsMGFi+sjTGtDMSS8EmqJXwNKm61e2Jjgu/pozOg6q52UXHpq?=
 =?iso-8859-2?Q?9dFqr+cHHFRQM64DEEv955mdtvXlkpO1XzNOUGLB4JOWLBP4fgHUyyk86Q?=
 =?iso-8859-2?Q?OzKvMKyG4xu/0bll/Oub2PyCaPy8uTU1I04mJeuliN3Q1JjhdA3NrqZk6D?=
 =?iso-8859-2?Q?sSQBle9GiO6+L8/a11WSwkWfFxzewcy2dgji3ijFyc7fFle/x5wtX/MFBy?=
 =?iso-8859-2?Q?1O9SFyCJcy59QpoGOsimWKNIsWoU3QdBp7v4ZxAhWBZ2UR+bi0YD880KwG?=
 =?iso-8859-2?Q?RwdUrkqqcsqRWAKSE3a3FFC9Gz8YNKe8OvYAeDEYT83VEN56y7aX3sZ+rZ?=
 =?iso-8859-2?Q?Rh2CDQP/6DuyW2CbBaAG6TPzvTvWe8bKWZ2rVFz8/36yGhQz3gtWggks3d?=
 =?iso-8859-2?Q?lBzWTKplgIsr+LaKCP4p3+fU5W1X3IcgQGZY1ZWLpF4Zocce0Eb7tu2T3t?=
 =?iso-8859-2?Q?aLvvqGdVF2n1wUfiXbMBnnxxCP4TygFh3OFYqO09AnamviZUwaWggAx0Rg?=
 =?iso-8859-2?Q?s/B9sdGv8t9TBkqQGcxgmAxorAUbO0vpgSh7zYQS29SGL/hhkvXxGI9ye2?=
 =?iso-8859-2?Q?040xQQB8ClZDOWo+6BIqwlAQV1V9xmyggPLkoJYZsBk/Mg8zGSuGfG16Jg?=
 =?iso-8859-2?Q?664MU+EMEWaMDzZVVKycTU67hdEI8X52DlqKCNimnCyDfgTXL+afYYxtwJ?=
 =?iso-8859-2?Q?Vfxdgbo+M4j+zwgkN8McTeaCv4GgO6rXqtMFUYoDLE4ooeiRJmQAX3Jqwb?=
 =?iso-8859-2?Q?zpCgihrwi60B4hcuRLdfaAXmcKKUuyr8D+kn/8K9BPwyEY5GzfTpB9/tJl?=
 =?iso-8859-2?Q?LOxdbQQ00HpEdzcwO5JP2EDb0I6WSpBlgnDT54qqCZ0OQaiPHHrwumQ+bL?=
 =?iso-8859-2?Q?HuLMzmAtgpE3TpDJwwNv8/jQkP/7Li4xAqhYcCFX6kstIFawC3DglVoHoq?=
 =?iso-8859-2?Q?j7cTOKYV0HcJisHT3Ay3xVSnkSGc2hLmRDdfcaWRLZhqX6G+Wi6VLZRFaF?=
 =?iso-8859-2?Q?+bQBPLT3dfxmCmCdOD4jpcFY6K7MMo4A/vrARx2/5DD+K0wpxFSpMQO5yV?=
 =?iso-8859-2?Q?pqj5oknM3dJb5ARf7lmAo2BJmymD4sdIQnnFlW3XbhjelJVSkxdxW1EmJ2?=
 =?iso-8859-2?Q?ZbonJnXcye1hwjWoH9yhKrJPSJICtF9Dy2A3zhxbJHDNwIwJIfb1rg3Unn?=
 =?iso-8859-2?Q?/T6EfBeR8C7hihPpV1GrUe1JKaIrN8lFi2zrhlEHTh6HXPSn/d6TrOAECW?=
 =?iso-8859-2?Q?YIOHGxdnT09uBcBhqXqjBzDW7HaeCKhBPUAmAxeehAwbKUGYPCqQAPTjxZ?=
 =?iso-8859-2?Q?ms7Wt0uR1TdkEoCMCXiX8kDpTYsfTIlMK281ReEpz7a2KjVU9D1N/yUC9O?=
 =?iso-8859-2?Q?iJtexBP8MkplVwPioVfEsHiAVTjt7K702ihqgDlNroKjbw/edKpgw3czc6?=
 =?iso-8859-2?Q?n9GtlfMoeX9hWNPaqLgVBPK77eEHt9ep3YxOq7UFb/58HZUFHkaGFg/6P+?=
 =?iso-8859-2?Q?qBdx9eg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?AdjK2r9NBcOTaEscputecCkfU5JZajQo8NJNfPT5YdboZRV3tBydsU8TxL?=
 =?iso-8859-2?Q?5ppR0omesXlhSZa8Qs+xafkb5kY+8c0E7rrvhzXaGaqItH5BKdeRQVtkDa?=
 =?iso-8859-2?Q?pGc+3XeuARUMQ3IiU61fHVyjJ9RMn8X4/UMxAUXuY4l7YshtdnsBKPOYWx?=
 =?iso-8859-2?Q?nsK6FTZdALbkcW33wqgPcydrlKZlbx1iNsHCqbkf/6XNY6l1ZTIoreIih7?=
 =?iso-8859-2?Q?hyh0h4kMKWENCbcCyE9ehTgnR9NeSbEzTUO77/x3RawUuAsj0ReSlQKf0n?=
 =?iso-8859-2?Q?70lxGPkPaIJFx9tzYybAwNjNvQ+FmnTvXASUhoYB70dPi8AhPP9VE5JT11?=
 =?iso-8859-2?Q?DXVW/mq7FQEIgIiTGq3kZYTp4cy07AKBGM1GZ59hE5S56/6LMNSyewxpYt?=
 =?iso-8859-2?Q?qqN0dt8ISN9snOY6zMHQj9eYKpsyCP9vJCGBpIZK+Bd0jMHUZzOjpA4Ina?=
 =?iso-8859-2?Q?QwB2k8uadG1L+knMyIazIrNDi19FfGQDLl1xYaTlL3BmMORfkqOU+8t4x2?=
 =?iso-8859-2?Q?kEaP9d/ZW+VGl1Pnzf0yMiqw10hIGTocfYJHncoLIZJXGgjwaviWQd/iKJ?=
 =?iso-8859-2?Q?Oh9ZDye4fE8MC6Jgz6pHuoz+pw7BdvYNNIGWAvIYurlvbwmpxg5fyM/l4z?=
 =?iso-8859-2?Q?LKhhHkXHJLi1am88+koayeXDOGIsiT3EOFfqowzZiFKvuw0eKlGHFflzK3?=
 =?iso-8859-2?Q?zAU0tjl7X9TfJO25VsIGfVQueu5qSS+xOThTCW/r+pkDwQd+YIrAwsnEZn?=
 =?iso-8859-2?Q?In7nTj+LVD7p7JiZiRnSKBRxrlnv5qyy94jx3fu46l/DvBgnsoMx3X+i32?=
 =?iso-8859-2?Q?cLQw4XWzTiMIePGELbCwgKpRuQxcCKM/zaBvbHarcqET5gcCVlH/QsYudc?=
 =?iso-8859-2?Q?bHsn53nAm0feB9DA7j0DpqLu22rAOTN8PjJo1RakcsspHdg7r7K3VDXNbL?=
 =?iso-8859-2?Q?LrY3ID+hNmP7Iz/b0iqZ+nmBhjYc7dG82h+5oW2TRQWVktWtcwgoWBgH70?=
 =?iso-8859-2?Q?vLluZKpkExaS4JPmSyeAUf2ZNenGSOPA05oz/DjHMDZdr3N4TaqOgF5fSU?=
 =?iso-8859-2?Q?hMw9Vw2QUmOcigQd55epD3KxFkAXTAe+ycLkzaxiZvKNQ16fVQyz7/BuPr?=
 =?iso-8859-2?Q?O7u11oogBF7JWVxq3NikIh28eZ5s56UfoUMVE9ebeQnFar7wLJvTt2/Bi+?=
 =?iso-8859-2?Q?pwKsCMNd8m0vPWJGE+TAabsyW4Zvnn3vLOK7eJkkkcywGc61bPh3mIFJeS?=
 =?iso-8859-2?Q?IaVr929jPDny3Ac9CoHZDX0hpPms438dBzc4FMl8BhfOrJifIcNoYYfOtd?=
 =?iso-8859-2?Q?JN2j4ilLsm+kJOMkgZGTN21ISuL7oHeN8HwZrFP61uzOdy1q0BoNcVHwqT?=
 =?iso-8859-2?Q?U2Iq0DkV8rS1fFkvo2A14L0AuJdavQ5kWjfw6IYbG5p/z35JJh6CFk7MKV?=
 =?iso-8859-2?Q?+BflMWkLgCQayZoZFSIRbppZ+xWRIhguSt0AR50GXpDsR3MEsv+Hp+KxGK?=
 =?iso-8859-2?Q?qVot3mU2fKfEpYhZauMfyIh6YCgC3pc5KqVQgb4N01tZ2mqkmhLr7S/ksa?=
 =?iso-8859-2?Q?Bof8n9prQs0+ImrcmF8z8Y8cFSHE?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB09238E68F3977CC064F2EDC1927BADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 281ebb5f-69e2-4584-9f3a-08ddb3b93bbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 07:23:50.8693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0kaNhmfuXfOCC0/YWItOy15Qp3Cq7cRfOnRiUgojsxtaVRnpMkKnXlMKDKSNfwJ9EXCmQMh7X9tzU2ti9CP0e8h0Fsh0iReFM8IXi1ubKas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR83MB0735
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB09238E68F3977CC064F2EDC1927BADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hello.=0A=
=0A=
Missed that, sorry.=0A=
=0A=
Thank you for noticing.=0A=
=0A=
Radek=0A=
---=0A=
From 68edd69104961961013f506593b5ccbb2ad0e61a Mon Sep 17 00:00:00 2001=0A=
From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft.com=
>=0A=
Date: Thu, 5 Jun 2025 13:15:22 +0200=0A=
Subject: [PATCH v4] Cygwin: stack base initialization for AArch64=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
Signed-off-by: Radek Barto=F2 <radek.barton@microsoft.com>=0A=
---=0A=
 winsup/cygwin/dcrt0.cc | 9 ++++++++-=0A=
 1 file changed, 8 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc=0A=
index f4c09befd..69c233c24 100644=0A=
--- a/winsup/cygwin/dcrt0.cc=0A=
+++ b/winsup/cygwin/dcrt0.cc=0A=
@@ -1030,7 +1030,7 @@ _dll_crt0 ()=0A=
 	  PVOID stackaddr =3D create_new_main_thread_stack (allocationbase);=0A=
 	  if (stackaddr)=0A=
 	    {=0A=
-#ifdef __x86_64__=0A=
+#if defined(__x86_64__)=0A=
 	      /* Set stack pointer to new address.  Set frame pointer to=0A=
 	         stack pointer and subtract 32 bytes for shadow space. */=0A=
 	      __asm__ ("\n\=0A=
@@ -1038,6 +1038,13 @@ _dll_crt0 ()=0A=
 		       movq  %%rsp, %%rbp  \n\=0A=
 		       subq  $32,%%rsp     \n"=0A=
 		       : : [ADDR] "r" (stackaddr));=0A=
+#elif defined(__aarch64__)=0A=
+	      /* Set stack and frame pointers to new address. */=0A=
+	      __asm__ ("\n\=0A=
+		       mov fp, %[ADDR] \n\=0A=
+		       mov sp, fp      \n"=0A=
+		       : : [ADDR] "r" (stackaddr)=0A=
+		       : "memory");=0A=
 #else=0A=
 #error unimplemented for this target=0A=
 #endif=0A=
-- =0A=
2.49.0.vfs.0.4=0A=
=0A=

--_002_DB9PR83MB09238E68F3977CC064F2EDC1927BADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="v4-0001-Cygwin-stack-base-initialization-for-AArch64.patch"
Content-Description:
 v4-0001-Cygwin-stack-base-initialization-for-AArch64.patch
Content-Disposition: attachment;
	filename="v4-0001-Cygwin-stack-base-initialization-for-AArch64.patch";
	size=1411; creation-date="Wed, 25 Jun 2025 07:23:40 GMT";
	modification-date="Wed, 25 Jun 2025 07:23:40 GMT"
Content-Transfer-Encoding: base64

RnJvbSA2OGVkZDY5MTA0OTYxOTYxMDEzZjUwNjU5M2I1Y2NiYjJhZDBlNjFhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogVGh1LCA1IEp1biAyMDI1IDEzOjE1OjIyICsw
MjAwClN1YmplY3Q6IFtQQVRDSCB2NF0gQ3lnd2luOiBzdGFjayBiYXNlIGluaXRpYWxpemF0aW9u
IGZvciBBQXJjaDY0Ck1JTUUtVmVyc2lvbjogMS4wCkNvbnRlbnQtVHlwZTogdGV4dC9wbGFpbjsg
Y2hhcnNldD1VVEYtOApDb250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0CgpTaWduZWQtb2Zm
LWJ5OiBSYWRlayBCYXJ0b8WIIDxyYWRlay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KLS0tCiB3aW5z
dXAvY3lnd2luL2RjcnQwLmNjIHwgOSArKysrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL2RjcnQw
LmNjIGIvd2luc3VwL2N5Z3dpbi9kY3J0MC5jYwppbmRleCBmNGMwOWJlZmQuLjY5YzIzM2MyNCAx
MDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9kY3J0MC5jYworKysgYi93aW5zdXAvY3lnd2luL2Rj
cnQwLmNjCkBAIC0xMDMwLDcgKzEwMzAsNyBAQCBfZGxsX2NydDAgKCkKIAkgIFBWT0lEIHN0YWNr
YWRkciA9IGNyZWF0ZV9uZXdfbWFpbl90aHJlYWRfc3RhY2sgKGFsbG9jYXRpb25iYXNlKTsKIAkg
IGlmIChzdGFja2FkZHIpCiAJICAgIHsKLSNpZmRlZiBfX3g4Nl82NF9fCisjaWYgZGVmaW5lZChf
X3g4Nl82NF9fKQogCSAgICAgIC8qIFNldCBzdGFjayBwb2ludGVyIHRvIG5ldyBhZGRyZXNzLiAg
U2V0IGZyYW1lIHBvaW50ZXIgdG8KIAkgICAgICAgICBzdGFjayBwb2ludGVyIGFuZCBzdWJ0cmFj
dCAzMiBieXRlcyBmb3Igc2hhZG93IHNwYWNlLiAqLwogCSAgICAgIF9fYXNtX18gKCJcblwKQEAg
LTEwMzgsNiArMTAzOCwxMyBAQCBfZGxsX2NydDAgKCkKIAkJICAgICAgIG1vdnEgICUlcnNwLCAl
JXJicCAgXG5cCiAJCSAgICAgICBzdWJxICAkMzIsJSVyc3AgICAgIFxuIgogCQkgICAgICAgOiA6
IFtBRERSXSAiciIgKHN0YWNrYWRkcikpOworI2VsaWYgZGVmaW5lZChfX2FhcmNoNjRfXykKKwkg
ICAgICAvKiBTZXQgc3RhY2sgYW5kIGZyYW1lIHBvaW50ZXJzIHRvIG5ldyBhZGRyZXNzLiAqLwor
CSAgICAgIF9fYXNtX18gKCJcblwKKwkJICAgICAgIG1vdiBmcCwgJVtBRERSXSBcblwKKwkJICAg
ICAgIG1vdiBzcCwgZnAgICAgICBcbiIKKwkJICAgICAgIDogOiBbQUREUl0gInIiIChzdGFja2Fk
ZHIpCisJCSAgICAgICA6ICJtZW1vcnkiKTsKICNlbHNlCiAjZXJyb3IgdW5pbXBsZW1lbnRlZCBm
b3IgdGhpcyB0YXJnZXQKICNlbmRpZgotLSAKMi40OS4wLnZmcy4wLjQKCg==

--_002_DB9PR83MB09238E68F3977CC064F2EDC1927BADB9PR83MB0923EURP_--
