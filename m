Return-Path: <lavr@ncbi.nlm.nih.gov>
Received: from nihcesxway6.hub.nih.gov (nihcesxway6.hub.nih.gov
 [128.231.90.121])
 by sourceware.org (Postfix) with ESMTPS id 41DB73858D35
 for <cygwin-patches@cygwin.com>; Tue,  7 Jul 2020 18:36:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 41DB73858D35
IronPort-SDR: 0BcxzEDQ496dQt5u0M3IPZANLMyRfLx3vdnKosYll1YIUYEr2fAV+m5dBsd13EW81XJHnsuOaS
 ceky+BLQleTQ==
X-SBRS-Extended: Low
X-IronPortListener: ces-out
X-IronPort-AV: E=Sophos;i="5.75,324,1589256000"; d="scan'208";a="201728904"
Received: from nihexb2.nih.gov (HELO ces.nih.gov) ([156.40.79.162])
 by nihcesxway6.hub.nih.gov with ESMTP/TLS/ECDHE-RSA-AES256-SHA384;
 07 Jul 2020 14:36:27 -0400
Received: from uccbX02.nih.gov (156.40.79.152) by nihexb2.nih.gov
 (156.40.79.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1913.5; Tue, 7 Jul 2020
 14:36:27 -0400
Received: from nihexb3.nih.gov (156.40.79.163) by uccbX02.nih.gov
 (156.40.79.152) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 7 Jul
 2020 14:36:27 -0400
Received: from GCC02-BL0-obe.outbound.protection.outlook.com (156.40.79.134)
 by nihexb3.nih.gov (156.40.79.163) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1913.5
 via Frontend Transport; Tue, 7 Jul 2020 14:36:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJknAJGdn2c2t6rBqGMbp65a1h7i8I0x12FGVHF6Wd8Fp4fSJtK9P7JfamOOefzWJPGEuUKDE6Fcg1A6pNjR7J3IMAGH6SrYBMHDnDHieTLBHUJhHKxGK+h37cKK5e4CAI0Ro8r1feBu3GIWXD9w8ExA06iSkD25wyu2eMwFJFZDZxizDJDAGyLrUiFUKGp+5pRkX5AecREVQcLA/mtcAIBXpTVYqIp5gQXaq00lEWf1FbLyu9LV4LRgRqazNLAOYK8UB+FELVOc2b97s5ovVVI82iJFgmXiQB9RA/DuFnXEYoPvV416qtJ45S/EOVvrS+OFsbCtKa46t2EqHTaS6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGjEQdDMe5b0O3V/rPX/lYchrG7but0Bp5jtxfzZG7Q=;
 b=nHQzRo6Pvj2RQhACTc9NXOydHAnDE/F2faqgYQYUAH/8Rksn5L83U4Q4I7wvrCzMnq50OOpYykjGJQ3/ZE98NBh2p6xhj001oeOnwcKcpB40p+qgjFoE6iOMf1FgV27K4ZfSu1oRS8qm2PegRZmOfC0PgDeHFHQaf1bhq76FtN2h1Sx2YT7k9kBB7Drilt01sF97zB7wtFIGHmbfW/wgjfxaREuzPuluuQPjf7xiijYYPr6hqU8IwkpjX6+vj14GofV5s23oXDt3URMAXBHGxME5h+toocEqhoKyDXteKvRSSyjmm8vmlZD76O3Jv+Skv3qnO9QO/PbK5PW9aI0f8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ncbi.nlm.nih.gov; dmarc=pass action=none
 header.from=ncbi.nlm.nih.gov; dkim=pass header.d=ncbi.nlm.nih.gov; arc=none
Received: from DM6PR09MB4043.namprd09.prod.outlook.com (2603:10b6:5:1d6::21)
 by DM6PR09MB4902.namprd09.prod.outlook.com (2603:10b6:5:26c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21; Tue, 7 Jul
 2020 18:36:26 +0000
Received: from DM6PR09MB4043.namprd09.prod.outlook.com
 ([fe80::1947:99bf:b4d2:9a9e]) by DM6PR09MB4043.namprd09.prod.outlook.com
 ([fe80::1947:99bf:b4d2:9a9e%3]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 18:36:26 +0000
From: "Lavrentiev, Anton (NIH/NLM/NCBI) [C]" <lavr@ncbi.nlm.nih.gov>
To: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
CC: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: RE: [PATCH] format_proc_cpuinfo: add microcode registry lookup values
Thread-Topic: [PATCH] format_proc_cpuinfo: add microcode registry lookup values
Thread-Index: AQHWVIUe/C93YX7d5U2sJeQbzLbZQqj8cbrQ
Date: Tue, 7 Jul 2020 18:36:26 +0000
Message-ID: <DM6PR09MB4043212C210FD275CD44F296A5660@DM6PR09MB4043.namprd09.prod.outlook.com>
References: <20200707173339.4554-1-Brian.Inglis@SystematicSW.ab.ca>
In-Reply-To: <20200707173339.4554-1-Brian.Inglis@SystematicSW.ab.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [130.14.9.135]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d9b3040-bc1a-431a-8758-08d822a4a82c
x-ms-traffictypediagnostic: DM6PR09MB4902:
x-microsoft-antispam-prvs: <DM6PR09MB49029BCF641AE78E1E9AA25EA5660@DM6PR09MB4902.namprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0457F11EAF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vmHfnm1P2TQYF96LzrbTn+5lmBlM2yHxKotlXst2MfLivBcXjmvCD7HuyQrwd4lxwRjRSxxCFeYiK8uMT57hlht1UyaaqovA6FEhCFI84SWT+6Su+D/+0oDo+mqu3ItJ5gjcEiBnr/6tF60mosFK6zxaEb3HUhyBugDW+ynlwWYPjtYAoND7zG6Pjfsk6I0is31NFZtcCoT1WaWakK8XB5K0zdxEwEx/HqrSFkS8zI60InU/7GUiGlp50j7Ez59Hv6TWbvn7oDkA4w+uMZdCkHg7GVjymfvyXKpop3zs8d4aW763l4A2unso/85vmDtsY7XfkCz1KJcA0a8s9tCJ38vpPseilcAeq2TqY8acBqASjTtJ4BDZuuWu78TgokMC/ds25u8rC/NLdY8mPI5Q6g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR09MB4043.namprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(346002)(396003)(376002)(39860400002)(136003)(186003)(83380400001)(26005)(8676002)(64756008)(33656002)(53546011)(66446008)(66476007)(66556008)(966005)(4326008)(7696005)(478600001)(316002)(76116006)(8936002)(86362001)(6506007)(66946007)(2906002)(6916009)(5660300002)(55016002)(9686003)(71200400001)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: gvitAOwXGFWH2EJCcEfVjkbFJj0nevaQcK7mwxyHUuXi9jhyrVUGWDL8ZqXz1JLoj5idv9TggxAkPT6Gm7NFrZmRcjR/PU6OToVOAavS7V9fd2h3yu5zd0jIrFEsN0P/c4OmqR0eqiBvlRAMmZaiVp8BXy8vTSSzk4zfOmNNOeEdEFCxPBtk6BHsaH6JwEIPFd9jZ/f/BZdVQuk397AXvB6TYCV0gP+QUhWCszgzcoSSO8I7/R1FjCtk8Uos5rhwsYEkLT01ogQOEo42Hr/OyjyRdvWfMVbARNpVmhZyFGpC519ggnYNPcZov9klE/cf0Kblf3jzkEhS4qOIG2F+j/1S2lKSDkWz583GadgIRYalkkfTC+mvjHwSS2j+1rRXs0jfd3soYH8yb+aaGZVaTr3N/ARxXHZvW5NEXU9p/cgiilmXVF/qDAfdyJ8IhKFGeOnfQfaIESSlWcccoFVmo6g39d+08sXegL8UAVazXKc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR09MB4043.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d9b3040-bc1a-431a-8758-08d822a4a82c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2020 18:36:26.3816 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 14b77578-9773-42d5-8507-251ca2dc2b06
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wru2xicO0RbUn2F6QXFQZwkjxq1JHSEwTR5gGQAXOcQ3I0yQeCFKK1o2BsbGkx1O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR09MB4902
X-OriginatorOrg: ncbi.nlm.nih.gov
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_EF, GIT_PATCH_0, NO_DNS_FOR_FROM, RCVD_IN_MSPIKE_H3,
 RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, TXREP,
 T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 07 Jul 2020 18:36:41 -0000

Hi,

This is shifting up, IMO:

+		  microcode <<=3D 32;		/* shift them down */

Thanks,
Anton

> -----Original Message-----
> From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
> Sent: Tuesday, July 07, 2020 1:34 PM
> To: cygwin-patches@cygwin.com
> Subject: [PATCH] format_proc_cpuinfo: add microcode registry lookup value=
s
>=20
> Re: CPU microcode reported wrong in /proc/cpuinfo
>     https://sourceware.org/pipermail/cygwin/2020-May/245063.html
> earlier Windows releases used different registry values to store microcod=
e
> revisions depending on the MSR name being used to get microcode revisions=
:
> add these alternative registry values to the cpuinfo registry value looku=
p;
> iterate thru the registry data until a valid microcode revision is found;
> some revision values are in the high bits, so if the low bits are all cle=
ar,
> shift the revision value down into the low bits
> ---
>  winsup/cygwin/fhandler_proc.cc | 44 +++++++++++++++++++++++++++-------
>  1 file changed, 35 insertions(+), 9 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc=
.cc
> index f1bc1c7405..f637dfd8e4 100644
> --- a/winsup/cygwin/fhandler_proc.cc
> +++ b/winsup/cygwin/fhandler_proc.cc
> @@ -692,26 +692,52 @@ format_proc_cpuinfo (void *, char *&destbuf)
>        union
>          {
>  	  LONG uc_len;		/* -max size of buffer before call */
> -	  char uc_microcode[16];
> -        } uc;
> +	  char uc_microcode[16];	/* at least 8 bytes */
> +        } uc[4];		/* microcode values changed historically */
>=20
> -      RTL_QUERY_REGISTRY_TABLE tab[3] =3D
> +      RTL_QUERY_REGISTRY_TABLE tab[6] =3D
>          {
>  	  { NULL, RTL_QUERY_REGISTRY_DIRECT | RTL_QUERY_REGISTRY_NOSTRING,
> -	    L"~Mhz", &cpu_mhz, REG_NONE, NULL, 0 },
> +	    L"~Mhz",		       &cpu_mhz, REG_NONE, NULL, 0 },
>  	  { NULL, RTL_QUERY_REGISTRY_DIRECT | RTL_QUERY_REGISTRY_NOSTRING,
> -	    L"Update Revision", &uc, REG_NONE, NULL, 0 },
> +	    L"Update Revision",		 &uc[0], REG_NONE, NULL, 0 },
> +							/* latest MSR */
> +	  { NULL, RTL_QUERY_REGISTRY_DIRECT | RTL_QUERY_REGISTRY_NOSTRING,
> +	    L"Update Signature",	 &uc[1], REG_NONE, NULL, 0 },
> +							/* previous MSR */
> +	  { NULL, RTL_QUERY_REGISTRY_DIRECT | RTL_QUERY_REGISTRY_NOSTRING,
> +	    L"CurrentPatchLevel",	 &uc[2], REG_NONE, NULL, 0 },
> +							/* earlier MSR */
> +	  { NULL, RTL_QUERY_REGISTRY_DIRECT | RTL_QUERY_REGISTRY_NOSTRING,
> +	    L"Platform Specific Field1", &uc[3], REG_NONE, NULL, 0 },
> +							/* alternative */
>  	  { NULL, 0, NULL, NULL, 0, NULL, 0 }
>          };
>=20
> -      memset (&uc, 0, sizeof (uc.uc_microcode));
> -      uc.uc_len =3D -16;	/* -max size of microcode buffer */
> +      for (size_t uci =3D 0; uci < sizeof (uc)/sizeof (*uc); ++uci)
> +	{
> +	  memset (&uc[uci], 0, sizeof (uc[uci]));
> +	  uc[uci].uc_len =3D -(LONG)sizeof (uc[0].uc_microcode);
> +							/* neg buffer size */
> +	}
> +
>        RtlQueryRegistryValues (RTL_REGISTRY_ABSOLUTE, cpu_key, tab,
>  			      NULL, NULL);
>        cpu_mhz =3D ((cpu_mhz - 1) / 10 + 1) * 10;	/* round up to multiple=
 of 10 */
>        DWORD bogomips =3D cpu_mhz * 2; /* bogomips is double cpu MHz sinc=
e MMX */
> -      long long microcode =3D 0;	/* at least 8 bytes for AMD */
> -      memcpy (&microcode, &uc, sizeof (microcode));
> +
> +      unsigned long long microcode =3D 0;	/* needs 8 bytes */
> +      for (size_t uci =3D 0; uci < sizeof (uc)/sizeof (*uc) && !microcod=
e; ++uci)
> +	{
> +	  /* still neg buffer size =3D> no data */
> +	  if (-(LONG)sizeof (uc[uci].uc_microcode) !=3D uc[uci].uc_len)
> +	    {
> +	      memcpy (&microcode, uc[uci].uc_microcode, sizeof (microcode));
> +
> +	      if (!(microcode & 0xFFFFFFFFLL))	/* some values in high bits */
> +		  microcode <<=3D 32;		/* shift them down */
> +	    }
> +	}
>=20
>        bufptr +=3D __small_sprintf (bufptr, "processor\t: %d\n", cpu_numb=
er);
>        uint32_t maxf, vendor_id[4], unused;
> --
> 2.27.0

