Return-Path: <cygwin-patches-return-9736-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 124663 invoked by alias); 5 Oct 2019 21:06:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 124651 invoked by uid 89); 5 Oct 2019 21:06:25 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=commented, parenthesis, Space
X-HELO: NAM02-SN1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr770101.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) (40.107.77.101) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 05 Oct 2019 21:06:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=MmOLPmNYOcdojAyfa2rUmpGSN/VMO8cK/obUL61yhHRyzPmleiVwHHp5/2/KOYomvKaqtMNUAsxHs0rN3qF/rlkfnHVqgysJT5xDyH7IdvvIAKchQUTS1icfdbWpZ5K4GuLNZso2rXa1Nmh1ZPZSZ6JwFEWC5Vy3MywpH3n1QftuwGo52lDGBNSX2CoXQH7lg5fZGF5hMYiI/GWiXT7R5KKRAI/Vm4/XRk7BkOsBjKFp7mIe2s4G8fZ8ROo7Zx+Pz1AG8ofdH5lk/fHyoM5TU/y5BbI+QSQoFe9aWNjwqpxolEghh+UE9AX1Wpw8geBuFy+G9T8WtOkoZh3qWhaC5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=1fwN9nkVX1VHHjxfxc6D5NKfylzb7LdW3W08RR3iQZ0=; b=RN8qKKvixg3wenwWjM0R4F+osfV2kJxf1ypu75XwALcturKwwhkfsZXx9ePTpEs7T/7qguff1e8bPjab2wi68Su9KepzWYPKZQxBy2Sq8xnRb71Odz9UTg1I2ZKv+rdod0Qv/wNdnFkeq8ZzsrgohWMUURtNmnI8ohf7jbzHSqEME1VYchN07gsbzHiIQbrbngRMSgB64qmw5/ymLOCeYG1eBCNTLpyc+C8BirNAl9tyAfZT1UHrnalCfcwGaGLO/Q4fMMdFCDe+oZ2rrH7/ncy4UsFYKlOSR8DhvB9MK4W8tvnvC6+ywtyHydjcEJth5/WhxpiUdtomKAFzTAxd+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=1fwN9nkVX1VHHjxfxc6D5NKfylzb7LdW3W08RR3iQZ0=; b=dd15m+vNyQY0UakZRZRx/wY3DNajp3c5Y/mxYEGLXH8lo4Y3gWdpvcu7cN1e09bUbzvlQQXvQw73/14joYuZhneix/EUQXeZEMoj5LoeWM03viD6x1gF4dboDLGa5utFwcnfqmHDPTzUKBf3yxQfa8l4yOVfw//eVkQ5xupW++0=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB6496.namprd04.prod.outlook.com (20.179.227.24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.24; Sat, 5 Oct 2019 21:06:21 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::6998:197f:bcff:7172]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::6998:197f:bcff:7172%4]) with mapi id 15.20.2327.023; Sat, 5 Oct 2019 21:06:21 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] fhandler_proc.cc(format_proc_cpuinfo): fix issues, add fields, flags
Date: Sat, 05 Oct 2019 21:06:00 -0000
Message-ID: <95be25ec-eeea-060e-fb40-ed5c7fc787c1@cornell.edu>
References: <20191004104457.33757-1-Brian.Inglis@SystematicSW.ab.ca>
In-Reply-To: <20191004104457.33757-1-Brian.Inglis@SystematicSW.ab.ca>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:9508;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <CBCBD686E965DF479A1E0C045943BD15@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b1I+rKaYGQZVIrgesSby3rqhkmpYHDurdoj2ocq6n4GMaVKvd7JxkT+romp3hKkPpXKxaOfxoMXUHkY7G+u39A==
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00007.txt.bz2

Hi Brian,

On 10/4/2019 6:44 AM, Brian Inglis wrote:
> fix cache size return code handling and make AMD/Intel code common;
> fix cpuid level count as number of non-zero leafs excluding sub-leafs;
> fix AMD physical cores count to be documented nc + 1;
> round cpu MHz to correct Windows and match Linux cpuinfo;
> add microcode from Windows registry Update Revision REG_BINARY;
> add bogomips which has been cpu MHz*2 since Pentium MMX;
> handle as common former Intel only feature flags also supported on AMD;
> add 88 feature flags inc. AVX512 extensions, AES, SHA with 20 cpuid calls;
> commented out flags are mostly used but not currently reported in cpuinfo
> but some may not currently be used by Linux

Thanks!  This must have been a lot of work.

It would be easier to review if you would split it up into smaller patches,=
 each=20
doing one thing, to the extent that this makes sense.  For example, the=20
simplification achieved by using the ftcprint macro could be done in a sing=
le=20
patch that's separate from the substantive changes.

A few nits:

> -      DWORD cpu_mhz =3D 0;
> -      RTL_QUERY_REGISTRY_TABLE tab[2] =3D {
> +      DWORD cpu_mhz;
> +      DWORD bogomips;
> +      long long microcode =3D 0xffffffff;	/* at least 8 bytes for AMD */
> +      union {
> +	  LONG len;
> +	  char uc_microcode[16];
> +      } uc;
> +
> +      cpu_mhz =3D 0;
> +      bogomips =3D 0;
> +      microcode =3D 0;

Why change the existing intialization style?  How about

       DWORD cpu_mhz =3D 0;
       DWORD bogomips =3D 0;
       long long microcode =3D 0;	/* at least 8 bytes for AMD */

> +      memset(&uc, 0, sizeof(uc.uc_microcode));
               ^              ^
(Space before parenthesis, here and in several other places.)

> +      cpu_mhz =3D ((cpu_mhz - 1)/10 + 1)*10;	/* round up a digit */

Please surround '/' and '*' by spaces (and similarly in what follows).  Als=
o,=20
the comment is confusing.  Maybe "round up to a multiple of 10"?

> +      for (uint32_t l =3D maxf; 1 < l; --l) {
                                             ^
(Brace on next line, and also in one other place.)

Ken
