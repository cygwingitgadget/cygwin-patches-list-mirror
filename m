Return-Path: <cygwin-patches-return-9754-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 931 invoked by alias); 7 Oct 2019 19:58:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 922 invoked by uid 89); 7 Oct 2019 19:58:48 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-5.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=periods
X-HELO: NAM04-CO1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr690098.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) (40.107.69.98) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 07 Oct 2019 19:58:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=C5QX5FcOoYJKTM7SBxu0HZMIBvcIkSTcu04Vv7B3vq19+b7QkejSd8T9uvKcO89jImH0cPGBJfTe4dXiAui+gojt2Bxgqe0w+HisSfVgY+4KAj85UACW/MOMF1FKu0WRGZxJBK4d3+BEtanNHiTFDCLr6VjHuyxXUVGca1gBrttJG92/dc0kUS+zeEvyhrWk3aisWzCNDGx3nx4JgRYTAoyXIncFbvFOUgAH6fWhayJhGu9ICGeO1GzYDoq/rLJiOdwfYeUuLbOwvQRB79pwPRacYXbpZllcREp+OWAMOe9831+iWpPvLDPzEIL1CR9uDazRz0U3N65gKwwKKW/B5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=gd8WaogWUe7gBcT/kCO5l/tSdTLF95Ah4ak9vzm11xc=; b=QV65c9CQTbZrQDUnFu63dO7EaFbuDoRU5YAztwQdB2qA5vQxjQIN3SOCMbDaL94LdmD4bLd/Ovlh7xOjxH9HEL0SWijfUueWdFkfktf179uZ78sVsfMjAwXCvLLmh1aeSlKMl9tCGW/89DZEVY2Aw9MtWIVf1ccGLbGpo3UCSCby+B2ZBJIwZNkSwCnu3mAZjDNEth1h6JShjv0bXX+b5bER9b3nlhTX/uFSfFiDEowfzIyNP7D8vyw8fYR1xRDHisQdSpdzr0/piAk8vxtZO6+LoCpv/o6l/eQiy5EkyCC5GDmgaaQzmAVf//6yG+YAvf7DM7K5D+8AidwH9U5Xpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=gd8WaogWUe7gBcT/kCO5l/tSdTLF95Ah4ak9vzm11xc=; b=T99rZZzipKtP6Dz/IP5C1wnN5VaFoddiNbXafv+pt+VykviiuFwOx3iGGj1syCWQV4en+xzYBlIPy2Gxwc2ZgL3luBR8Oq8ffQ8neUj8U1QncN/lexNRUz+Ee9WIRXiBlbvCW84ntr6IbDIFU3QBPYt3xZTHMGXOP9vzE2jOOCU=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB6412.namprd04.prod.outlook.com (10.141.162.214) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.20; Mon, 7 Oct 2019 19:58:45 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::6998:197f:bcff:7172]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::6998:197f:bcff:7172%4]) with mapi id 15.20.2327.023; Mon, 7 Oct 2019 19:58:45 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v3 00/10] fhandler_proc.cc(format_proc_cpuinfo): fix issues, add fields, feature flags
Date: Mon, 07 Oct 2019 19:58:00 -0000
Message-ID: <bf66f420-e7ea-ddbf-874d-bcfe2380602d@cornell.edu>
References: <20191005222328.57805-1-Brian.Inglis@SystematicSW.ab.ca> <20191007162307.7435-1-Brian.Inglis@SystematicSW.ab.ca>
In-Reply-To: <20191007162307.7435-1-Brian.Inglis@SystematicSW.ab.ca>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:2657;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <B7409902716B184D8E46DFB18CA27E4C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: izDDrHS7tAKFgaxPrGoVXZFxlv2/pLhNxvkyHDz0gBecO61NA46OE5KJd4lUiN2wg0joGvmCi/roO6zcLxyICQ==
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00025.txt.bz2

On 10/7/2019 12:22 PM, Brian Inglis wrote:
> *   fix cache size return code handling and make AMD/Intel code common
> *   fix cpuid level count as number of non-zero leafs excluding sub-leafs
> *   fix AMD physical cores count documented as core_info low byte + 1
> *   round cpu MHz to correct Windows and match Linux cpuinfo
> *   add bogomips which has been cpu MHz*2 since Pentium MMX
> *   add microcode from Windows registry Update Revision REG_BINARY
> *   feature test print macro makes cpuid feature, bit, and flag text
>      comparison and checking easier;
>      handle as common former Intel only feature flags also supported on A=
MD;
>      change order and some flag names to agree with current Linux
> *   add 99 feature flags inc. AVX512 extensions, AES, SHA with 20 cpuid c=
alls
> *   comment out flags not reported by Linux in cpuinfo although some flags
>      may not be used by Linux
> *   or model extension bits into high model bits instead of adding
>      arithmetically like family extension bits
>=20
>   winsup/cygwin/fhandler_proc.cc | 737 +++++++++++++++++++--------------
>   1 file changed, 434 insertions(+), 303 deletions(-)

Series pushed, with minor tweaks to the commit messages.  (Except for the f=
irst=20
line, the commit message should consist of complete sentences, starting wit=
h=20
capitals and ending with periods.)

Thanks very much.

Ken
