Return-Path: <cygwin-patches-return-9730-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 121051 invoked by alias); 3 Oct 2019 13:31:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 120913 invoked by uid 89); 3 Oct 2019 13:31:31 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=H*Ad:U*cygwin-patches
X-HELO: NAM02-CY1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr760125.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) (40.107.76.125) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 03 Oct 2019 13:31:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=L9QJziwAE/9hQ/L2Yv8HbmEx2lSux90ymT6GdU/etNu9RTvDm8P0HV+VLdqtO9fGe2DR7S3LWt13InoOh3MWo9SXTHtcbaSM+NtSBzIMTtWaGDkCk5SgVJuB74ExIivFQ2HnApGh3y8MCseGmN5cBrx1328ExCp07JrzdDGxwiPQKAyX6xt4jW/I8h+bszZlYo8sWI2nFEpnWZWBvUAcQehPPAnyGwixpdIeouv85krH6D377xHGt98hOpojxDkdtLTb0wR++H32LwBezk0UVaboWIBBrQueiZXQeFaov3bpVQkyPmB33VzmIFOHBHHwtnaH/johfiHIY+2vOH3PCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=zAiRi7qdWnEpVu5fPqwCp66GStUeqHxs+7j2YKNCba8=; b=Spa2OP/39t2EKguxtM40IKff2Vx5gB79J0RRcR1QATiXQShzj8BubkMgGIOjQfrdlB2Zkz7YV0O08WAwoxB0Cu+vLK+bLAAyAGeQcgLtiFpZeFD1Jfmo3bkDYPafOG3nvSXFa8U38Ogh32TB1ujZSIY5ihZ2VlwUjrk+NaBCFZILQyoxi+Da2yLfitG0/mhVCtXR/7eCTmOsAF/LpX5IQCjAsi1f5nErekXXcTCzemrWrFViYsYWaEHWQFVXvFlRSMp5j+WVGKcN9G4iinlGCVCmc6WBOgOJHjlVSx1sXcT8cBamNzboQ4uDbA1eSyPls9Sj6Lhipj2IvEtEQNB7Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=zAiRi7qdWnEpVu5fPqwCp66GStUeqHxs+7j2YKNCba8=; b=h3B1qe23h8xPOTGRnes/L7KOCUYYsDhI/AklXJX3Dx6eg8gDhh7bFJlGJHorFv3pJpso1U3m/f2LqMnbMkiwem2/oTW2OANGQV3NSLwcwmoOXP0x0DeiRjcaLrlx1+wIowhnnUypYfRIuYb/HfzW/LQ0UQUgGS9DqN+USgrp3g4=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB5593.namprd04.prod.outlook.com (20.179.48.202) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.20; Thu, 3 Oct 2019 13:31:27 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::6998:197f:bcff:7172]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::6998:197f:bcff:7172%4]) with mapi id 15.20.2305.023; Thu, 3 Oct 2019 13:31:27 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: Fix signal handling issue introduced by PTY related change.
Date: Thu, 03 Oct 2019 13:31:00 -0000
Message-ID: <50b005c9-79ea-5e4d-6aa6-aa51bdedcddf@cornell.edu>
References: <20191003104337.700-1-takashi.yano@nifty.ne.jp>
In-Reply-To: <20191003104337.700-1-takashi.yano@nifty.ne.jp>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-exchange-purlcount: 1
x-ms-oob-tlc-oobclassifiers: OLM:294;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <3A9472C134AB56499961C8B98B8E9848@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WxCx5C4J5Ph78fqC0wUmI7eeu+Zo0Gp5QCWZXm4Mf6cggeYxQZphxLF4EKOrKaBJwAuJUEOZWmEhZ2eo5X3jrw==
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00001.txt.bz2

On 10/3/2019 6:43 AM, Takashi Yano wrote:
> - After commit 41864091014b63b0cb72ae98281fa53349b6ef77, there is a
>    regression in signal handling reported in
>    https://www.cygwin.com/ml/cygwin/2019-10/msg00010.html. This patch
>    fixes the issue.
> ---
>   winsup/cygwin/exceptions.cc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
> index db0fe0867..132fea427 100644
> --- a/winsup/cygwin/exceptions.cc
> +++ b/winsup/cygwin/exceptions.cc
> @@ -949,7 +949,7 @@ _cygtls::interrupt_setup (siginfo_t& si, void *handle=
r, struct sigaction& siga)
>     if (incyg)
>       set_signal_arrived ();
>=20=20=20
> -  if (!have_execed && ch_spawn.iscygwin ())
> +  if (!have_execed && !(myself->exec_sendsig && !ch_spawn.iscygwin ()))
>       proc_subproc (PROC_CLEARWAIT, 1);
>     sigproc_printf ("armed signal_arrived %p, signal %d",
>   		  signal_arrived, si.si_signo);

Pushed.  Thanks.

Ken
