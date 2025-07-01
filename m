Return-Path: <SRS0=y+SQ=ZO=multicorewareinc.com=thirumalai.nagalingam@sourceware.org>
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazlp170110002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c409::2])
	by sourceware.org (Postfix) with ESMTPS id DFD7A3857B9B
	for <cygwin-patches@cygwin.com>; Tue,  1 Jul 2025 18:26:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DFD7A3857B9B
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=multicorewareinc.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=multicorewareinc.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DFD7A3857B9B
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a01:111:f403:c409::2
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1751394371; cv=pass;
	b=YWqZQcp6bGVTbN+P6AOVeuvSewqujNapoEV5MyrJyeJ7QZf/n3hVa1qJVzHkM3KsQXEEVW5VCfpJtqfhFAFtLQ2jl/m8gPxzEHFiCYVv2BtPc3GzuZfplwAng/b3zNic+qS1Fi0AQCiSRMY5wfhhNunoCxfNKEexMKi/M/13YeE=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751394371; c=relaxed/simple;
	bh=i6bg/YVLCI0tkmp+VfsIdvX5G1VAMcfA9TiRL3VIiUA=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=QGXi3fMlrhBgQ7YXbV9y7UbnXkBDzNBp0xH62eo2yHm7K8f+7Prsny3WTSuD2+B21yXnek1eQ6y85q0aXfAgRmX8wKQ+dz0fGCM89SaOwGeCfN/7Xno8SDg/Q8PoJoh7kUbGBYzPNVLpHhp1YygZY8bHogSMa5K6YBBixDSgzKU=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DFD7A3857B9B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=multicorewareinc.com header.i=@multicorewareinc.com header.a=rsa-sha256 header.s=selector1 header.b=Irq38ZGO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SL2BNTxcN+z6ESPAgzY7fpUTg7yNIhFNKvnUAf/QmnOBlNPDrl73jQx3QtRzEraPYkFz4OQN5RO32zIh4GZLRa+TXnW9b0rTm+Yhc7oMZQxLvwtSJHjmcAEX9Cb1vTrkdVcXAcs6TpNKsR6qYDJf5cnW/iirm2SgihVpvtOgWVTMSJgPCGJyRv7ibmf0r6okk7nPsF4Ema3HH5nm8aHH286CTl48tIq4jbwKXbdg0IsOAjxvzhczT5xiBI5DRIijeGi/Rv9S1Z4GkIbI3h7+sWnD2QzYOOxa/uhYHkMFspWbn0rRFlvgXttcuXuG2Kcc0zgN7IHaZE4dztBHvX/Duw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmBgS5H486PIFsnfW2e0/W51GIgS7Z4Rhpa2U/IjE8M=;
 b=pR+TTSl78BmKnevkN6vBLXWsDxR3m86kSLYJlLZVtSKDQPEevmcUB8I5kLNwCZw8V64OiVIhI+mqnkM1KoLyfz+ecqlzaXY9w9d+1cM0NHy+xMLoqSEC54I++W5WYNuj5UfL9narrhGG50mLMwxGkS7aYfuOxxoGMV64fJEmI3aFFqLs2WcHhx9NTuYbedOqygpXlc8oOuIloSR9mP6Ccw6/xW6mU5pdB653UaRo9s9tSuW5P5LJGtVkyE1obrPqnEuCFUSOG8aG4+6TjodZIcE6ibnHJKqF7BRhXyp5a1Bj/zR148htQKrVgRB+pqVJfkRV4Tc3rB2AZEiQjAh12w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multicorewareinc.com; dmarc=pass action=none
 header.from=multicorewareinc.com; dkim=pass header.d=multicorewareinc.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=multicorewareinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmBgS5H486PIFsnfW2e0/W51GIgS7Z4Rhpa2U/IjE8M=;
 b=Irq38ZGOND4TwCL+E3hsxCzUMyOqVplupdna/EiYop+jkX8H74IVlN0/gPtxE7j7a3QY7vK5ZIqR6XVUSbolnPYRRue+eRXdYYnOPW+t9sUXD46Ld+d51VvDLjO3hmiu53L0do9u/nZRR61Zqcyyq8Sj69apYcRNN/H85zSPcpAN/kBamnBLoiLksRYn+ueKoe182SmSm5XRtmvMlJf1JDKN+zOqJH8lcABgRoo/k7/zwX2AQYODt9f2NNsXMcNG+Qtw4Fl4oTE5Jh0NKUUX9Ar87SRlVOqbIjJwQnSma6+kcw0CWpPmsY5xcka7svXcrpF9aZaHhixixfEvOuaTnA==
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:141::12)
 by MA0P287MB1576.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:fb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Tue, 1 Jul
 2025 18:26:06 +0000
Received: from MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362]) by MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
 ([fe80::e76a:ce2f:84fe:3362%3]) with mapi id 15.20.8880.029; Tue, 1 Jul 2025
 18:26:05 +0000
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
To: Jeremy Drake <cygwin@jdrake.com>
CC: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: RE: [PATCH V2] Aarch64: Optimize pthread_wrapper by eliminating x19
 and streamlining register usage
Thread-Topic: [PATCH V2] Aarch64: Optimize pthread_wrapper by eliminating x19
 and streamlining register usage
Thread-Index: AQHb6rWbeIl1QkUstkyUGwr8neuM5Q==
Date: Tue, 1 Jul 2025 18:26:05 +0000
Message-ID:
 <MA0P287MB3082CA8A50FDA8CBFEA81A0B9F41A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
References:
 <MA0P287MB3082799B10054C7B9C07F51F9F41A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
 <01c32140-1dd2-de2a-4d86-a74fca7af70c@jdrake.com>
In-Reply-To: <01c32140-1dd2-de2a-4d86-a74fca7af70c@jdrake.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multicorewareinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB3082:EE_|MA0P287MB1576:EE_
x-ms-office365-filtering-correlation-id: c41aebb7-479e-4875-467e-08ddb8ccbe00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?soX9Nmt0l2bHyEouK6MSSs/JnGXEGxnskLX2fdBUFEjqsmNYfjeFKtUaclo4?=
 =?us-ascii?Q?JQiTKIwE15jPluI3uONIv9Y9Uw0oNoJvroN5q60ICRo40JXkKrL6p05qwmGH?=
 =?us-ascii?Q?tvrWB1NAJTOl7L6TKY2fx5dXG7T4D/d+x5o1Y4tgBOKGuwtrggnr0vpwZA8z?=
 =?us-ascii?Q?+7rK2qu2uRQQ2YedWqk6LBuYPYBMRY25Trgw0eP1+xInQSNDhqXKTFunhtAX?=
 =?us-ascii?Q?93ObeZW5d4wzNPTARKu52JhL0nIZ5LNavPeDAL1NrxgEZdH9HsC1GikwBdoI?=
 =?us-ascii?Q?i5GmledF4T9lpgP1eHlsSrfPokp8A7nmGR21jPAfFcY72+oldKSPiNPrqbpP?=
 =?us-ascii?Q?kyiOBK3zgclzXvM2kMYVeA8xx69txl02TAl+cbME2fVCZ6hULHSohXlH/XAu?=
 =?us-ascii?Q?liGWeAJFkfSjLUZ2HWU0iD2n2QQUO30ppNpDIw5SGa3egsOTlsJ8mUXsil8E?=
 =?us-ascii?Q?ssFMi9twVRYmOkqFTK5e2woSMrAAF56JIuQko10bSh5RAleYHh1EtM0Cx7WN?=
 =?us-ascii?Q?0J0Vw/CRiQRdvzktR/euc0YPeKSpVFW1+8IVWGSMPssm5++5freHn6OXFUa1?=
 =?us-ascii?Q?tt93le9jJsRzAwEQLJWejobr1V7VI6e2vuJmbuILVTeNTnY5o9UBY7mYIulb?=
 =?us-ascii?Q?a983J2dPg8HUsUMbmXGS8LGOFeC6a7cFq52CilmOtFwEh1MJYPFrv5NNHFL2?=
 =?us-ascii?Q?qlzIM/jaGrnaAXq1tZl5uxMQaYthlzLvsNXdp8jA7RdCmwKGFuO7nyR8PW8e?=
 =?us-ascii?Q?vUZrj3z0p1xv+FYp1T1sj8AM9ScsVylbvn/qGfqkKhX+UcjYTjcx5YWchvWX?=
 =?us-ascii?Q?QDCDFHh/AmbDBVzJhQPmVYVxl+f+OWZ1+rSR1RjqBq+2XLvUQ/B9e0WzyqoU?=
 =?us-ascii?Q?52zTsntAn4R6Z/m5DW+PXGxSLu+rsZqEzFI8znvZ5l/Gm8gX1MJyQiIIa08k?=
 =?us-ascii?Q?MJUQyraRXPO8ymFSWaT016gO+PBwak1SnhraWhsvhHnROFa0Lf2b9BaSvkxS?=
 =?us-ascii?Q?2OyB4GNwHMDd2uke+/Hr3zBZphVA/u9IRVnHs8Fw6mZ1PMAAJqXP71wH010H?=
 =?us-ascii?Q?qT1gZI7ou96koJJT/uH4L76okBg8sDQDXr/lYiV4NWxnruoNUfUf30XuHUG9?=
 =?us-ascii?Q?CRAq+6UFpKphE/Sq0XweGkq/Vxyui9BNC6PfvGrG1/+p2fK49JsdJrdY7S+w?=
 =?us-ascii?Q?Y3UVxhRCYwDYy7CV7XnvmsmRTMKaYO7Z+dvIuxjeAEAKkbrjhL4A5u2yUQeA?=
 =?us-ascii?Q?kkodvI3a4WloWpU2HMAOiELsS3glxlD3sOm44RVhMJBdfVAwLppOoqbO77ZG?=
 =?us-ascii?Q?hSDkZK5Ksu4Etr1fxw76aVYogXoquLAF8jO1CgkleIcyZXTNsuzU7NxCL5pn?=
 =?us-ascii?Q?pWPg8TPlsbjc0KWW2hEzFEChfMj9alNJbuykMBLUl9wLbWyC1IMiHOnI7Ucv?=
 =?us-ascii?Q?XiwtB98g4DbG3jU7cLGVboyut/v8410HVkqe6H59IGaM2xGfTDlwdJsN8o20?=
 =?us-ascii?Q?ynmgnNAUqWs+yNA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB3082.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Jt60f/1PnUcHOy66Lw4Kb8VlOdgiab1lW2nyFe+RXrl/HHR+voXZ0jXVb5GH?=
 =?us-ascii?Q?/PQHiCVTKm9Oud/cNVk1USNPUxxyevug7R1S6vuJ4DnoEPqDxXBGmSDAG5Tr?=
 =?us-ascii?Q?oAEabv2/GmmK1ZeEnF+gqbQyEPKJYrq0MllWZOqdFTPUUD42foaFcfqCKHoT?=
 =?us-ascii?Q?oXm+0fE9D75Ha/ZahN+110U1T4flUQ1D54QhGU5Y+xIm5A2dQ4nzL/MJilVn?=
 =?us-ascii?Q?118KTDdvNsNjU6y6+E8zuTu41oYiC/Wan6VODkrHDAWKRP8JsDvuxrqkuq7r?=
 =?us-ascii?Q?pk/ig2sZaFx1etjfsns3SaQ+6CvsiNGhLE79FDYDOu9p9wSmDVTJkatZFh1s?=
 =?us-ascii?Q?NCJ9P3RQGNl9uvgCz/oMsF/2vrmWSTwi1EHaiM09Ogecp2oQECbjGKy0K0kW?=
 =?us-ascii?Q?H249/UuaFJIdN2tZ03ftqit1jGjZcKxoBVZn43ac7EWry8RqgOtjNCp0A/Me?=
 =?us-ascii?Q?F3/OOYxicMTwX4U+g/V5pQmMHo8Ih0HsMxYeOyhSHlvntkkBpm4bFGqUuSR7?=
 =?us-ascii?Q?YEthlzYcrs6UD1NzBkQtiW8jK8tjlrVOI4M3hHM7Je2ie2vCFht/QFNbB7bw?=
 =?us-ascii?Q?rp2SLY4+nDEciHKC+SgCs9Ka+4ddR5O5qxAWmG2XMaNKFHXWWpPvI3CzT49P?=
 =?us-ascii?Q?Nqy7IBERrhQ8JsrzI499NBwt5s9/1+om1suK2YmCkS0IAVTRq+3V9tJ8nqns?=
 =?us-ascii?Q?B3n3d3hVi3YdSJ5iwO7dvyPqpG9xF+OcUmNQxcFlFME1PQSYoDi/8juL+GYt?=
 =?us-ascii?Q?hfkUbw8vgMGTK2kw0zixdL5oacD9Xwj5wW+LcuFvg5MlzZiwF0qQYQDNFI1I?=
 =?us-ascii?Q?MX8CTFDJTGNXQCrh0hMkpVkJq9KMJAJXo9CXIZ/b9WS5DeQyGo/VPlrXTF7/?=
 =?us-ascii?Q?f9de5yY8SUUu4ffrVywnnAL4rv87CguYQ9dS0+RnfFr9TQv4KHTRrpIAiHkW?=
 =?us-ascii?Q?mU12IZkIcEtWocxPkPS3pOzd5vPy71xWiE5gmTYB4IUgRWbrxGYsK3ycg4Xi?=
 =?us-ascii?Q?qrLC4T4L1EpI9ewuTK9EH80ynG6e9hkhgTaXuzpoR0cmSCRVUj/Jjrd6qVB6?=
 =?us-ascii?Q?P4DDF0obAI1Vy3sNzNPde1+IAdoBQVYzqBNe/SQDFF3426upzK5ItDwLZPO1?=
 =?us-ascii?Q?WWqCgusXaNbYqtLqqhdJFg9JMLwvjQHCKysC757s7G7Wv+EdVHwp1rd+E9AP?=
 =?us-ascii?Q?Ml3w7uaYWmRzzSkIz1e0YTFjMN14m02PaYIfH5yFWjou+7sP+kNcne0lmX8i?=
 =?us-ascii?Q?YzSvwKShEl2ZelvdiHhSnEp7IeDiSn9aoTXz74y87hoOfdIq1b2e3QCb0Aqb?=
 =?us-ascii?Q?Yd4jC2xkUjIhOJ32tvA7HVmEqTG0iAcB2LK/Yghns9Mui7duxUPN2V8n2N0j?=
 =?us-ascii?Q?aFD6AQQ2jGeLUGtAbm0g71fsAxsqx/dxPafzBsd+2XVnTj6H4/uPu9xOQgAE?=
 =?us-ascii?Q?lbp0Ys7bIkakaoTCc9APu8UgFvx1BYr6LnUne8sE5/4+unEebo/5TTe3i/46?=
 =?us-ascii?Q?RH5x0r23A7Sis65RCrsYgwpuB4k665lJgBB+5PgQG2liVu5Su95OHaGfLIsf?=
 =?us-ascii?Q?jsvbC9N0N9wJw0sxWVf7rxFgHJbHUkiHgLkg7YPMEKYi7hekIH6lFOXjSYbu?=
 =?us-ascii?Q?E+fQ8on33wXPHHB+3Ya/l58Iqgjt1U6CfEhzBwOXefHi?=
Content-Type: multipart/mixed;
	boundary="_002_MA0P287MB3082CA8A50FDA8CBFEA81A0B9F41AMA0P287MB3082INDP_"
MIME-Version: 1.0
X-OriginatorOrg: multicorewareinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB3082.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c41aebb7-479e-4875-467e-08ddb8ccbe00
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2025 18:26:05.6657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ffc5e88b-3fa2-4d69-a468-344b6b766e7d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VCBOJs6oHTVDXoIAF/erdOdSbz+0xQPr5O8yRADkTRAxzOBbZLJLKEJMPeiYySoM9+/Noe7zAg1nzlX16bcB/b1VH5NHAdL0gLxdc3b/o65nMgY4rVMR4MkLvqBgknG98omFpAB/ZJMqWHTFX4PWOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1576
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--_002_MA0P287MB3082CA8A50FDA8CBFEA81A0B9F41AMA0P287MB3082INDP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Jeremy,

Please find this revised version of the previous patch.=20
The main issue being addressed is a segfault caused by accessing `wrapper_a=
rg` on the stack after it had been deallocated by VirtualFree.=20
This resulted in invalid memory access during thread startup on AArch64. In=
 this version, the thread `func` and `arg` are loaded before the stack is f=
reed, stored in callee-saved registers, and restored before calling the thr=
ead func.

Commit message has been updated accordingly and wrapped at 72 characters wi=
th trailer. Thanks for the feedback!

In-Lined patch:=20

From 53215b09e6a19c9493fa5fa58d91a82f6d51e1b2 Mon Sep 17 00:00:00 2001
From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
Date: Tue, 1 Jul 2025 18:17:24 +0000
Subject: [PATCH] Cygwin: Aarch64: optimize pthread_wrapper register usage

This patch resolves issues related to unsafe access to deallocated
stack memory in the pthread wrapper for AArch64.

Key changes:
- Removed use of x19 by directly loading the thread function and
  argument using LDP from [WRAPPER_ARG], freeing one register.
- Stored thread function and argument in x20 and x21 before
  VirtualFree to preserve them across calls.
- Used x1 as a temporary register to load the stack base,
  subtract CYGTLS, and update SP.
- Moved the thread argument back into x0 after VirtualFree and
  before calling the thread function.

Earlier, `wrapper_arg` lived on the stack, which was freed via
`VirtualFree`, risking segfaults on later access. Now, the thread
`func` and `arg` are loaded before the stack is freed, stored in
callee-saved registers, and restored to `x0` before calling the
thread function.

Fixes: f4ba145056db ("Aarch64: Add inline assembly pthread wrapper")
Signed-off-by: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewarein=
c.com>
---
 winsup/cygwin/create_posix_thread.cc | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/winsup/cygwin/create_posix_thread.cc b/winsup/cygwin/create_po=
six_thread.cc
index 592aaf1a5..17bb607f7 100644
--- a/winsup/cygwin/create_posix_thread.cc
+++ b/winsup/cygwin/create_posix_thread.cc
@@ -103,18 +103,19 @@ pthread_wrapper (PVOID arg)
   /* Sets up a new thread stack, frees the original OS stack,
    * and calls the thread function with its arg using AArch64 ABI. */
   __asm__ __volatile__ ("\n\
-	   mov     x19, %[WRAPPER_ARG]  // x19 =3D &wrapper_arg              \n\
-	   ldp     x0, x10, [x19, #16]  // x0 =3D stackaddr, x10 =3D stackbase \n=
\
-	   sub     sp, x10, %[CYGTLS]   // sp =3D stackbase - (CYGTLS)       \n\
-	   mov     fp, xzr              // clear frame pointer (x29)       \n\
-	   mov     x1, xzr              // x1 =3D 0 (dwSize)                 \n\
-	   mov     x2, #0x8000          // x2 =3D MEM_RELEASE                \n\
-	   bl      VirtualFree          // free original stack             \n\
-	   ldp     x19, x0, [x19]       // x19 =3D func, x0 =3D arg            \n=
\
-	   blr     x19                  // call thread function            \n"
+	   ldp     x20, x21, [%[WRAPPER_ARG]]    // x20 =3D thread func, x21 =3D =
thread arg \n\
+	   ldp     x0, x1, [%[WRAPPER_ARG], #16] // x0 =3D stackaddr, x1 =3D stac=
kbase	\n\
+	   sub     sp, x1, %[CYGTLS]  		 // sp =3D stackbase - (CYGTLS)    	\n\
+	   mov     fp, xzr              	 // clear frame pointer (x29)    	\n\
+						 // x0 already has stackaddr		\n\
+	   mov     x1, xzr              	 // x1 =3D 0 (dwSize)              	\n\
+	   mov     x2, #0x8000          	 // x2 =3D MEM_RELEASE             	\n\
+	   bl      VirtualFree          	 // free original stack          	\n\
+	   mov     x0, x21  			 // Move arg into x0			\n\
+	   blr     x20                  	 // call thread function         	\n"
 	   : : [WRAPPER_ARG] "r" (&wrapper_arg),
 	       [CYGTLS] "r" (__CYGTLS_PADSIZE__)
-	   : "x0", "x1", "x2", "x10", "x19", "x29", "memory");
+	   : "x0", "x1", "x2", "x20", "x21", "x29", "memory");
 #else
 #error unimplemented for this target
 #endif
--=20
2.49.0

Best regards,
Thirumalai Nagalingam

-----Original Message-----
From: Jeremy Drake <cygwin@jdrake.com>=20
Sent: 01 July 2025 22:53
To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Aarch64: Optimize pthread_wrapper by eliminating x19 a=
nd streamlining register usage

On Tue, 1 Jul 2025, Thirumalai Nagalingam wrote:

> Hi all,
>
> This patch fixes existing issues in my earlier commit=20
> [https://github.com/cygwin/cygwin/commit/f4ba145056dbe99adf4dbe632bec0
> 35e006539f8] and optimizes the AArch64 thread startup sequence by=20
> eliminating the use of register x19 and streamlining register usage.=20
> The key modifications are detailed in the patch's commit description.=20
> These changes improve register efficiency while ensuring correct=20
> thread argument in register `x0` after virtual free call, preventing=20
> from any segmentation faults.
> The patch has been tested in our internal AArch64 environment where=20
> pthread related test cases are now passing as expected.
>
> Inlined Patch:
>
> From e197e39452e542d18812f41ac2a3af2fa172b273 Mon Sep 17 00:00:00 2001
> From: Thirumalai Nagalingam=20
> <thirumalai.nagalingam@multicorewareinc.com>
> Date: Tue, 1 Jul 2025 14:46:52 +0530
> Subject: [PATCH] Aarch64: Optimize pthread_wrapper by eliminating x19=20
> and  streamlining register usage
>
> - Removed use of x19 by directly loading the thread func and arg using=20
> LDP from [WRAPPER_ARG], freeing up one additional register
> - Loaded thread function and argument into x20 and x21 before=20
> VirtualFree to preserve their values across the virtual free call
> - Used x1 as a temporary register to load stack base, subtract CYGTLS,=20
> and update SP
> - Moved thread argument back into x0 after VirtualFree and before=20
> calling the thread function
>

So the problem was that the registers used before were ones not required to=
 be preserved across function calls in the ABI?  Or was it that wrapper_arg=
 was on the now-freed stack so could not be accessed after the VirtualFree?=
  Pleas include that in your commit message.  Also, please wrap your commit=
 message at 72 characters, prefix the subject/first line
"Cygwin: ", and include the trailer

Fixes: f4ba145056db ("Aarch64: Add inline assembly pthread wrapper")
Signed-off-by: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewarein=
c.com>


--_002_MA0P287MB3082CA8A50FDA8CBFEA81A0B9F41AMA0P287MB3082INDP_
Content-Type: application/octet-stream;
	name="0001-Cygwin-Aarch64-optimize-pthread_wrapper-register-usa.patch"
Content-Description:
 0001-Cygwin-Aarch64-optimize-pthread_wrapper-register-usa.patch
Content-Disposition: attachment;
	filename="0001-Cygwin-Aarch64-optimize-pthread_wrapper-register-usa.patch";
	size=3403; creation-date="Tue, 01 Jul 2025 17:55:11 GMT";
	modification-date="Tue, 01 Jul 2025 18:26:05 GMT"
Content-Transfer-Encoding: base64

RnJvbSA1MzIxNWIwOWU2YTE5Yzk0OTNmYTVmYTU4ZDkxYTgyZjZkNTFlMWIyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlydW1hbGFpIE5hZ2FsaW5nYW0gPHRoaXJ1bWFsYWkubmFn
YWxpbmdhbUBtdWx0aWNvcmV3YXJlaW5jLmNvbT4KRGF0ZTogVHVlLCAxIEp1bCAyMDI1IDE4OjE3
OjI0ICswMDAwClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBBYXJjaDY0OiBvcHRpbWl6ZSBwdGhy
ZWFkX3dyYXBwZXIgcmVnaXN0ZXIgdXNhZ2UKClRoaXMgcGF0Y2ggcmVzb2x2ZXMgaXNzdWVzIHJl
bGF0ZWQgdG8gdW5zYWZlIGFjY2VzcyB0byBkZWFsbG9jYXRlZApzdGFjayBtZW1vcnkgaW4gdGhl
IHB0aHJlYWQgd3JhcHBlciBmb3IgQUFyY2g2NC4KCktleSBjaGFuZ2VzOgotIFJlbW92ZWQgdXNl
IG9mIHgxOSBieSBkaXJlY3RseSBsb2FkaW5nIHRoZSB0aHJlYWQgZnVuY3Rpb24gYW5kCiAgYXJn
dW1lbnQgdXNpbmcgTERQIGZyb20gW1dSQVBQRVJfQVJHXSwgZnJlZWluZyBvbmUgcmVnaXN0ZXIu
Ci0gU3RvcmVkIHRocmVhZCBmdW5jdGlvbiBhbmQgYXJndW1lbnQgaW4geDIwIGFuZCB4MjEgYmVm
b3JlCiAgVmlydHVhbEZyZWUgdG8gcHJlc2VydmUgdGhlbSBhY3Jvc3MgY2FsbHMuCi0gVXNlZCB4
MSBhcyBhIHRlbXBvcmFyeSByZWdpc3RlciB0byBsb2FkIHRoZSBzdGFjayBiYXNlLAogIHN1YnRy
YWN0IENZR1RMUywgYW5kIHVwZGF0ZSBTUC4KLSBNb3ZlZCB0aGUgdGhyZWFkIGFyZ3VtZW50IGJh
Y2sgaW50byB4MCBhZnRlciBWaXJ0dWFsRnJlZSBhbmQKICBiZWZvcmUgY2FsbGluZyB0aGUgdGhy
ZWFkIGZ1bmN0aW9uLgoKRWFybGllciwgYHdyYXBwZXJfYXJnYCBsaXZlZCBvbiB0aGUgc3RhY2ss
IHdoaWNoIHdhcyBmcmVlZCB2aWEKYFZpcnR1YWxGcmVlYCwgcmlza2luZyBzZWdmYXVsdHMgb24g
bGF0ZXIgYWNjZXNzLiBOb3csIHRoZSB0aHJlYWQKYGZ1bmNgIGFuZCBgYXJnYCBhcmUgbG9hZGVk
IGJlZm9yZSB0aGUgc3RhY2sgaXMgZnJlZWQsIHN0b3JlZCBpbgpjYWxsZWUtc2F2ZWQgcmVnaXN0
ZXJzLCBhbmQgcmVzdG9yZWQgdG8gYHgwYCBiZWZvcmUgY2FsbGluZyB0aGUKdGhyZWFkIGZ1bmN0
aW9uLgoKRml4ZXM6IGY0YmExNDUwNTZkYiAoIkFhcmNoNjQ6IEFkZCBpbmxpbmUgYXNzZW1ibHkg
cHRocmVhZCB3cmFwcGVyIikKU2lnbmVkLW9mZi1ieTogVGhpcnVtYWxhaSBOYWdhbGluZ2FtIDx0
aGlydW1hbGFpLm5hZ2FsaW5nYW1AbXVsdGljb3Jld2FyZWluYy5jb20+Ci0tLQogd2luc3VwL2N5
Z3dpbi9jcmVhdGVfcG9zaXhfdGhyZWFkLmNjIHwgMjEgKysrKysrKysrKystLS0tLS0tLS0tCiAx
IGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvd2luc3VwL2N5Z3dpbi9jcmVhdGVfcG9zaXhfdGhyZWFkLmNjIGIvd2luc3VwL2N5Z3dp
bi9jcmVhdGVfcG9zaXhfdGhyZWFkLmNjCmluZGV4IDU5MmFhZjFhNS4uMTdiYjYwN2Y3IDEwMDY0
NAotLS0gYS93aW5zdXAvY3lnd2luL2NyZWF0ZV9wb3NpeF90aHJlYWQuY2MKKysrIGIvd2luc3Vw
L2N5Z3dpbi9jcmVhdGVfcG9zaXhfdGhyZWFkLmNjCkBAIC0xMDMsMTggKzEwMywxOSBAQCBwdGhy
ZWFkX3dyYXBwZXIgKFBWT0lEIGFyZykKICAgLyogU2V0cyB1cCBhIG5ldyB0aHJlYWQgc3RhY2ss
IGZyZWVzIHRoZSBvcmlnaW5hbCBPUyBzdGFjaywKICAgICogYW5kIGNhbGxzIHRoZSB0aHJlYWQg
ZnVuY3Rpb24gd2l0aCBpdHMgYXJnIHVzaW5nIEFBcmNoNjQgQUJJLiAqLwogICBfX2FzbV9fIF9f
dm9sYXRpbGVfXyAoIlxuXAotCSAgIG1vdiAgICAgeDE5LCAlW1dSQVBQRVJfQVJHXSAgLy8geDE5
ID0gJndyYXBwZXJfYXJnICAgICAgICAgICAgICBcblwKLQkgICBsZHAgICAgIHgwLCB4MTAsIFt4
MTksICMxNl0gIC8vIHgwID0gc3RhY2thZGRyLCB4MTAgPSBzdGFja2Jhc2UgXG5cCi0JICAgc3Vi
ICAgICBzcCwgeDEwLCAlW0NZR1RMU10gICAvLyBzcCA9IHN0YWNrYmFzZSAtIChDWUdUTFMpICAg
ICAgIFxuXAotCSAgIG1vdiAgICAgZnAsIHh6ciAgICAgICAgICAgICAgLy8gY2xlYXIgZnJhbWUg
cG9pbnRlciAoeDI5KSAgICAgICBcblwKLQkgICBtb3YgICAgIHgxLCB4enIgICAgICAgICAgICAg
IC8vIHgxID0gMCAoZHdTaXplKSAgICAgICAgICAgICAgICAgXG5cCi0JICAgbW92ICAgICB4Miwg
IzB4ODAwMCAgICAgICAgICAvLyB4MiA9IE1FTV9SRUxFQVNFICAgICAgICAgICAgICAgIFxuXAot
CSAgIGJsICAgICAgVmlydHVhbEZyZWUgICAgICAgICAgLy8gZnJlZSBvcmlnaW5hbCBzdGFjayAg
ICAgICAgICAgICBcblwKLQkgICBsZHAgICAgIHgxOSwgeDAsIFt4MTldICAgICAgIC8vIHgxOSA9
IGZ1bmMsIHgwID0gYXJnICAgICAgICAgICAgXG5cCi0JICAgYmxyICAgICB4MTkgICAgICAgICAg
ICAgICAgICAvLyBjYWxsIHRocmVhZCBmdW5jdGlvbiAgICAgICAgICAgIFxuIgorCSAgIGxkcCAg
ICAgeDIwLCB4MjEsIFslW1dSQVBQRVJfQVJHXV0gICAgLy8geDIwID0gdGhyZWFkIGZ1bmMsIHgy
MSA9IHRocmVhZCBhcmcgXG5cCisJICAgbGRwICAgICB4MCwgeDEsIFslW1dSQVBQRVJfQVJHXSwg
IzE2XSAvLyB4MCA9IHN0YWNrYWRkciwgeDEgPSBzdGFja2Jhc2UJXG5cCisJICAgc3ViICAgICBz
cCwgeDEsICVbQ1lHVExTXSAgCQkgLy8gc3AgPSBzdGFja2Jhc2UgLSAoQ1lHVExTKSAgICAJXG5c
CisJICAgbW92ICAgICBmcCwgeHpyICAgICAgICAgICAgICAJIC8vIGNsZWFyIGZyYW1lIHBvaW50
ZXIgKHgyOSkgICAgCVxuXAorCQkJCQkJIC8vIHgwIGFscmVhZHkgaGFzIHN0YWNrYWRkcgkJXG5c
CisJICAgbW92ICAgICB4MSwgeHpyICAgICAgICAgICAgICAJIC8vIHgxID0gMCAoZHdTaXplKSAg
ICAgICAgICAgICAgCVxuXAorCSAgIG1vdiAgICAgeDIsICMweDgwMDAgICAgICAgICAgCSAvLyB4
MiA9IE1FTV9SRUxFQVNFICAgICAgICAgICAgIAlcblwKKwkgICBibCAgICAgIFZpcnR1YWxGcmVl
ICAgICAgICAgIAkgLy8gZnJlZSBvcmlnaW5hbCBzdGFjayAgICAgICAgICAJXG5cCisJICAgbW92
ICAgICB4MCwgeDIxICAJCQkgLy8gTW92ZSBhcmcgaW50byB4MAkJCVxuXAorCSAgIGJsciAgICAg
eDIwICAgICAgICAgICAgICAgICAgCSAvLyBjYWxsIHRocmVhZCBmdW5jdGlvbiAgICAgICAgIAlc
biIKIAkgICA6IDogW1dSQVBQRVJfQVJHXSAiciIgKCZ3cmFwcGVyX2FyZyksCiAJICAgICAgIFtD
WUdUTFNdICJyIiAoX19DWUdUTFNfUEFEU0laRV9fKQotCSAgIDogIngwIiwgIngxIiwgIngyIiwg
IngxMCIsICJ4MTkiLCAieDI5IiwgIm1lbW9yeSIpOworCSAgIDogIngwIiwgIngxIiwgIngyIiwg
IngyMCIsICJ4MjEiLCAieDI5IiwgIm1lbW9yeSIpOwogI2Vsc2UKICNlcnJvciB1bmltcGxlbWVu
dGVkIGZvciB0aGlzIHRhcmdldAogI2VuZGlmCi0tIAoyLjQ5LjAKCg==

--_002_MA0P287MB3082CA8A50FDA8CBFEA81A0B9F41AMA0P287MB3082INDP_--
