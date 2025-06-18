Return-Path: <SRS0=pByE=ZB=microsoft.com=radek.barton@sourceware.org>
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on20722.outbound.protection.outlook.com [IPv6:2a01:111:f403:2607::722])
	by sourceware.org (Postfix) with ESMTPS id 13DB9385695B
	for <cygwin-patches@cygwin.com>; Wed, 18 Jun 2025 16:04:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 13DB9385695B
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 13DB9385695B
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:2607::722
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1750262648; cv=pass;
	b=S38mkj8XiVTV9AqvVOn8RXgaa1aw2gk2l7B9KUHs0BPdpF6r6QQjwTr2IlwA9hQQdWm8LC7BM/76kYFnQIO3Cr81gdyuAGUBYXKf5BurvgBBbahsBLIsF+wpAlIgtRuM6Vz4+IZYQXYXOctiq1+UDymC/VsXly/3rqKtll2ALcY=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750262648; c=relaxed/simple;
	bh=nJrZloRh8SmcJgyN7Fy4uvuV8CLubmzEKc4TjyyYhs4=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=WQCMYC1VbVc6JNbH2WD4WneI6yxtHZ+nwSUfiRYU9bjdVoxe1KnIJwW/eIwVNZDrNnEDlhyHlKrE7p1ZALTRdoiTSpfsmXoT6+GzEogKpo8trw3ncC1yLZ3tnugdNVcKlZB1SOxljNBWblThzDXf3cvYiQ4gDOC4razNbvtWm7A=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 13DB9385695B
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=TD5R+rhJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VnfMF5Tc7iLTCcbnWj3lRw1/G8S/7LRFSjT5NsEr6JMJ0B/pT7KJ1V04nJbH3I5hfq/3CrZJ5qz5AXx1Wp0cAVrQe+j2qTVSblEWgc8jxSrvMk+7K7GwOuXhy2th5g5irs3ivyPyS23MEiaG4S0Nzl5etJtmW7xKfa0wgSX+GVitjOsWteCIBqfB66dnlA6gZFKmeY+zNM/Gx637M6Xm44mmN1a8aN3ICSdX6T6XBTK7vmuvyPyrcRTWBSl26ALMRmu71+RM/WKN7LSaZBqSIpHKpkNEsK8Hsv2p5IQpi/uvfpK1w7k7EaxeZKi6lGmEJErUHSfgP4yelmBZdooX1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05EEVeoxQ8R5hesIMHlGk40eIwByA++mP3qmua3hO4o=;
 b=rvqjNX/u3Wvho/9tVFurG+3JkrqH0Ezv8FzoLRJNcAroIP3RSq1SZ28BvojlIMB3V5VPCgWikGrIliheN16iPCXYVuxs6A5LSeRV78CHm/PMGyK55N8wXlID/LMxrbvqq6oLORXXbQcfS+fQaXjnzMBbGs3i2et3HZG06Stoee4YjuDgroROCE1IfemASJvcnvhrfxreB0kvlRoZgwCP4neaVyTSyK9+D5NhNmmR5Emtz4uzNoVPHzL3jdvxXXsaKtYi+eg/LArIXUbsh/c0MQR5GE75vB2eUn6TS1QLxO5W7HhmXj8rdb1uOqQ3rZy52BemPhUnVC6Fl0dGss9IKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05EEVeoxQ8R5hesIMHlGk40eIwByA++mP3qmua3hO4o=;
 b=TD5R+rhJq7AVeu1+I9rEIsN1+EzXGXDQKMduo2as4NDzu8PPjqukWcSU1W5uPuVIXQno0YoMVpt6sqp7tclayG6EF/xuvxX2V3SknhFjsRhygDcPpW70ZdyJdXhbBMugZ8JmfcQFcF5hNdKWXc1bALLFm3uGooKNGT7mBL85pL0=
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com (2603:10a6:10:5ca::18)
 by GV1PR83MB0730.EURPRD83.prod.outlook.com (2603:10a6:150:20e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.8; Wed, 18 Jun
 2025 16:04:04 +0000
Received: from DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea]) by DB9PR83MB0923.EURPRD83.prod.outlook.com
 ([fe80::4407:2fff:68f4:1eea%5]) with mapi id 15.20.8880.006; Wed, 18 Jun 2025
 16:04:04 +0000
From: Radek Barton <radek.barton@microsoft.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>, Radek Barton
	<radek.barton@microsoft.com>
Subject: [PATCH] Cygwin: stack base initialization for AArch64
Thread-Topic: [PATCH] Cygwin: stack base initialization for AArch64
Thread-Index: AQHb4GohaV9RByzWEkuse0eJGFCLS7QJFDMO
Date: Wed, 18 Jun 2025 16:04:04 +0000
Message-ID:
 <DB9PR83MB0923B69B503703DA53531A0F9272A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
References:
 <DB9PR83MB0923A2E70C6E9F5931020E409272A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
In-Reply-To:
 <DB9PR83MB0923A2E70C6E9F5931020E409272A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-06-18T16:04:03.545Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0923:EE_|GV1PR83MB0730:EE_
x-ms-office365-filtering-correlation-id: 69fb64b7-8eb8-4f18-d473-08ddae81bfb9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?bCdZoC1pAVhaQ0ZNhIP3lxRr8UvboPz5rnuyTpCxb75b5L+Uezem7nLMmR?=
 =?iso-8859-1?Q?VeeJOTPKO50Enp0hoKJ8bFnBTK4rPJdamJziZLWQZ4xW/TwnouKz3xCwnT?=
 =?iso-8859-1?Q?7tjN+HLoyJ6Ejbpw84lk3rzBG8vUh5/mXrupNF2Tx84oyG5F2OoA/mvTRs?=
 =?iso-8859-1?Q?OX7iwAMyWvZxAZOlvh+tIRogMtX6/J31Y0ob/TR6P48pi9aVifMRb+/KU/?=
 =?iso-8859-1?Q?4Zp/TsmKD5a88oQs0yTKY91b/CcCkYj2zeHFkS/4Uy2KoRnDcx3oBcptyj?=
 =?iso-8859-1?Q?bLCOpVy49vjtTQJCWmGxS64qTPN62KihVIcTBOvX61dOQ3b25Ry5XlMwbZ?=
 =?iso-8859-1?Q?elr+xBr/bSdyid2rjJWZaPQia1Q58xPDwGoEMKZL4VGxT9Egp1ey/B4EqD?=
 =?iso-8859-1?Q?KC3/EozVeaSLP2rw4oQOtaxFGanw1u4T6U7RJZHQMvkPc+71O/dk2nXoec?=
 =?iso-8859-1?Q?fPwEvhCFgIZ1EJ3VQKRFRyrgI4UfhVVocNm2L/YsvQNb7vZyn9xcEt5dZ9?=
 =?iso-8859-1?Q?lpADyKEr8KzBrb6H6Lrn12zkg8CXF/1BB/X2GG6K9fc3PgP/wjtfQG8e8F?=
 =?iso-8859-1?Q?XRKP06JUVMyvyzRAj/q8coi9vSwM+UsKiSeEKmZmjheuzqM84ePgxyBn/m?=
 =?iso-8859-1?Q?GmMi1fL0l3s+B5rwdrUOpACauujBiDfYF2NUIdZ6GIhalMyMOw27mZ/H5J?=
 =?iso-8859-1?Q?Ew+5S+5t15+f17kyhi7MeJkJQTnZMxwaQCP8JYbJ5KY2634BV55IiCFAM4?=
 =?iso-8859-1?Q?8JNTLcxhMxIzsF9N9BXcrPptfLSj+w/13n36gl33GWOPrPY6UuoU5CKjNt?=
 =?iso-8859-1?Q?SU6htz1+5dklCPCrhANOs1mB6aG5do+Fk7Lc6lMjp7Ui9krLkfm1Wou4Cb?=
 =?iso-8859-1?Q?v1vw85SKdsVOLhIFyJEpNf2I4huGcZuJdWtqA5qXBwhHr4zy5ElA/vXTRO?=
 =?iso-8859-1?Q?l9C+bv+A37X7IQ9l1h4AA7HI2YOV1odPliZ56DFjWLbohowZd6EAcT2v8L?=
 =?iso-8859-1?Q?Pb38nzdk/1OUK4kqjhzJ5ZiMnzF/QO51bkdyt3NwRtNnGLVyaoRaER7qov?=
 =?iso-8859-1?Q?mpV7t8rDwACwFp5hYuh4/RhcQh6HW85nOcy/LJVQGNG3uoXWe3pYMq8+xL?=
 =?iso-8859-1?Q?2SHjebqYicET/lPVDeFCitHStGAcBW1CdkUhecD+A6JTQf1CwyzPBdg5Pg?=
 =?iso-8859-1?Q?RX+5MY0NAc1nPiWeHVoSAqoxMmY/xutC0HIEJIMm5s0HJUIHFwX6uNA4ak?=
 =?iso-8859-1?Q?NswUf6hmKVDSbSr4VibxTg4qsPTALfqXmihqN242Q5o6ZINtknxv7TX2Hc?=
 =?iso-8859-1?Q?XrmhNtXmLfeirLW7bUfWguze5+eH0ye5X63c3NrJMWNL2HhgLQiq6nicIu?=
 =?iso-8859-1?Q?9x80Vk9PmqwSO3ZCvfuxWU1Lauouwkr37Og9zuCJlbrdWGcywpHb+ea44o?=
 =?iso-8859-1?Q?e6Y5uQacvBoTxGH6bWaV6RWi0t8QuguBnyMdLG4D7WrMhFCsVw/5S/U6bu?=
 =?iso-8859-1?Q?rMPHzbDFC+43rQaCF5vBLHezq4TcgIMc6j3LqR49j+jQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0923.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?TvbyytIYExfWUgBV7XjdJPJy41UEWXubpCI3yRRPThQsm+4ZHhXzpBeYnK?=
 =?iso-8859-1?Q?WKobYrZv9Lve5A0z6jMCCTI2GtMimp40oiceDTA7VB8lg9Nog/WjK0f/GC?=
 =?iso-8859-1?Q?zxeWwh8dmLARG9Rs5YsdrMYIHzrRE/say8Bk+jJrVawfMjkeIGXKJRev44?=
 =?iso-8859-1?Q?dMtw9MBjORCnaOrmvjF4y7+B6NN2aAzgsIvkvejMlw8l22CL80oiY7CeEx?=
 =?iso-8859-1?Q?S59NSFSt0bw9SXbt2t0pL4r/CJKAEdh7HdRwyzKnxBk+ou8Mu0e+kntc7d?=
 =?iso-8859-1?Q?7xgdpB9J5zcYXTuFR10DTOX/v2zIU+m+Ud2ykF43B2P/emgqhzG71z1XyE?=
 =?iso-8859-1?Q?+feDFAkaETTPC9qAeeYl4jB0GQCYAmSQ6RIr/iIskyN6PGj89G+VVd4MmW?=
 =?iso-8859-1?Q?XTPZNjEwQoeSDzXzQuNKVdPmqjnd7JWGdJry74+ZjZ/WDwjoDpkgLItvSB?=
 =?iso-8859-1?Q?9Z3yYYRAkZ7KthzjRuWjzi5mDDnQsujSjRQFkyT/DY72rp/TLYuqW0AQE4?=
 =?iso-8859-1?Q?dVwY4wtzbuS7sj7qe1+gWC/ExPp97vLshATF+WQ8bsPKyFwwY/qipG/NHN?=
 =?iso-8859-1?Q?a3T+P/N1zMCmWsdbzWUwUGzzYwwjsJYsgmPLKZY1toxgkt9Qp4uNdMyoE8?=
 =?iso-8859-1?Q?E/0Z+7zQB60RR8Bwx7ts5xrxWlinZfwpf4/jBXJeOnFamNtaXPgAY+qL4A?=
 =?iso-8859-1?Q?50RRQcvdrFMpiJfHD6QBjNK7Z1WwdeJLLjXWr1UiySdTRme828w+RSCRjJ?=
 =?iso-8859-1?Q?ql3l7yeIg1xP9En3DM0fb42j2crtADxPzWYcOXvQpQUt1RVG4i0uSal3Lo?=
 =?iso-8859-1?Q?XoRl0Jd8px1XWsNlzEuPj7WNILtvLzf2tG0ZQ8idSUidZ7zvqrpdvuNXHG?=
 =?iso-8859-1?Q?c+vOc9MktN5uxWGi+EA3KPy4yMGyx747aS0i3zQDP6+Dq24IyaVj7cjxtr?=
 =?iso-8859-1?Q?bCT/om4O+w1Kjb3djLxNIQtdiTcm7xFCllchiHEk08qGicZR6TptHEZk4o?=
 =?iso-8859-1?Q?Fb7RYsn2HKD28mxk0K23FzQw+JzXLJyBjqaxQtWu9uDUmjjad+ctqCNlVH?=
 =?iso-8859-1?Q?HxYtXXnARk/c+C1vEKcwfB2xF5NqCHkh2jjUONyBevG/raMaba3F0eh2+z?=
 =?iso-8859-1?Q?7mGK31tkcB7tjdPxDUY5qxfVLn7bN1vYzLs3UHziIRa1/U2PmVTnUI/gQ9?=
 =?iso-8859-1?Q?6xbYxRugqKGfhoBiJdqs6wpt++Rq76Jma/LzURTLFUI6KDHIG0XE3yW0m0?=
 =?iso-8859-1?Q?0tQAdExxvyBULMxQS+eIFIlef1WdVCZm00CIbfPJGTsXR3Jr4SfXQVQ1TM?=
 =?iso-8859-1?Q?dOXwT5MyvcV/NmMfEL8a8IXR8zV+fMTxI9YJsRcW4JPbRHkdnK8WjrnNQL?=
 =?iso-8859-1?Q?PcSVVJ01mSPT5fShuIcLVery9v+zpKDpn8mSCZsG2qLX/3gJfl5UO7N7Lw?=
 =?iso-8859-1?Q?Eltga6cU5Dos6LYP3HnJvdP8uB+3iMjQ3DW7Lo5QJ06N32jNu/dJuz0Nc3?=
 =?iso-8859-1?Q?I0BOIZHNYpN/TzrChB77JPstesfrWK9yz9Tzu47fTLvBQfFu+Y4u7Gtgrp?=
 =?iso-8859-1?Q?wbaeDYZ/Au2zXsXrNlfwAPN/n4I3?=
Content-Type: multipart/mixed;
	boundary="_002_DB9PR83MB0923B69B503703DA53531A0F9272ADB9PR83MB0923EURP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0923.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69fb64b7-8eb8-4f18-d473-08ddae81bfb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 16:04:04.6791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GEzj3+iybvIGeBKBioBZ6H1ze2ymWLfcVhu3AUpjroHCc1vs/5bF0RoVzfciKjxDQXbFTrn0RgRKF3Fl/vrFZxkaOx5V49wq1M7PyYqmD6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR83MB0730
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_DB9PR83MB0923B69B503703DA53531A0F9272ADB9PR83MB0923EURP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Forgot to add the attachment.=

--_002_DB9PR83MB0923B69B503703DA53531A0F9272ADB9PR83MB0923EURP_
Content-Type: application/octet-stream;
	name="0001-Cygwin-stack-base-initialization-for-AArch64.patch"
Content-Description: 0001-Cygwin-stack-base-initialization-for-AArch64.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-stack-base-initialization-for-AArch64.patch";
	size=1348; creation-date="Wed, 18 Jun 2025 16:03:40 GMT";
	modification-date="Wed, 18 Jun 2025 16:03:40 GMT"
Content-Transfer-Encoding: base64

RnJvbSA1ZDQ3MDI2MWQ5Yjg2NWJmNzA5ZjlmNGQ4ZGEzNTBlMzUzNmU2MjUxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UmFkZWs9MjBCYXJ0bz1DNT04OD89IDxyYWRl
ay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KRGF0ZTogVGh1LCA1IEp1biAyMDI1IDEzOjE1OjIyICsw
MjAwClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBzdGFjayBiYXNlIGluaXRpYWxpemF0aW9uIGZv
ciBBQXJjaDY0Ck1JTUUtVmVyc2lvbjogMS4wCkNvbnRlbnQtVHlwZTogdGV4dC9wbGFpbjsgY2hh
cnNldD1VVEYtOApDb250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0CgpTaWduZWQtb2ZmLWJ5
OiBSYWRlayBCYXJ0b8WIIDxyYWRlay5iYXJ0b25AbWljcm9zb2Z0LmNvbT4KLS0tCiB3aW5zdXAv
Y3lnd2luL2RjcnQwLmNjIHwgOCArKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vZGNydDAuY2Mg
Yi93aW5zdXAvY3lnd2luL2RjcnQwLmNjCmluZGV4IGY0YzA5YmVmZC4uMTViMzQ3OWQzIDEwMDY0
NAotLS0gYS93aW5zdXAvY3lnd2luL2RjcnQwLmNjCisrKyBiL3dpbnN1cC9jeWd3aW4vZGNydDAu
Y2MKQEAgLTEwMzAsMTQgKzEwMzAsMjAgQEAgX2RsbF9jcnQwICgpCiAJICBQVk9JRCBzdGFja2Fk
ZHIgPSBjcmVhdGVfbmV3X21haW5fdGhyZWFkX3N0YWNrIChhbGxvY2F0aW9uYmFzZSk7CiAJICBp
ZiAoc3RhY2thZGRyKQogCSAgICB7Ci0jaWZkZWYgX194ODZfNjRfXwogCSAgICAgIC8qIFNldCBz
dGFjayBwb2ludGVyIHRvIG5ldyBhZGRyZXNzLiAgU2V0IGZyYW1lIHBvaW50ZXIgdG8KIAkgICAg
ICAgICBzdGFjayBwb2ludGVyIGFuZCBzdWJ0cmFjdCAzMiBieXRlcyBmb3Igc2hhZG93IHNwYWNl
LiAqLworI2lmIGRlZmluZWQoX194ODZfNjRfXykKIAkgICAgICBfX2FzbV9fICgiXG5cCiAJCSAg
ICAgICBtb3ZxICVbQUREUl0sICUlcnNwIFxuXAogCQkgICAgICAgbW92cSAgJSVyc3AsICUlcmJw
ICBcblwKIAkJICAgICAgIHN1YnEgICQzMiwlJXJzcCAgICAgXG4iCiAJCSAgICAgICA6IDogW0FE
RFJdICJyIiAoc3RhY2thZGRyKSk7CisjZWxpZiBkZWZpbmVkKF9fYWFyY2g2NF9fKQorCSAgICAg
IF9fYXNtX18gKCJcblwKKwkJICAgICAgIG1vdiBmcCwgJVtBRERSXSBcblwKKwkJICAgICAgIHN1
YiBzcCwgZnAsICMzMiBcbiIKKwkJICAgICAgIDogOiBbQUREUl0gInIiIChzdGFja2FkZHIpCisJ
CSAgICAgICA6ICJtZW1vcnkiKTsKICNlbHNlCiAjZXJyb3IgdW5pbXBsZW1lbnRlZCBmb3IgdGhp
cyB0YXJnZXQKICNlbmRpZgotLSAKMi40OS4wLnZmcy4wLjQKCg==

--_002_DB9PR83MB0923B69B503703DA53531A0F9272ADB9PR83MB0923EURP_--
