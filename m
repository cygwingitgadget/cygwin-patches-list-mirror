Return-Path: <cygwin-patches-return-10097-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 59147 invoked by alias); 20 Feb 2020 18:11:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 59138 invoked by uid 89); 20 Feb 2020 18:11:52 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-16.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3 autolearn=ham version=3.3.1 spammy=H*F:D*gov, DEL, cygwin-patches@cygwin.com, cygwinpatchescygwincom
X-HELO: nihcesxway3.hub.nih.gov
Received: from nihcesxway3.hub.nih.gov (HELO nihcesxway3.hub.nih.gov) (128.231.90.125) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 20 Feb 2020 18:11:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;  d=nih.gov; i=@nih.gov; q=dns/txt; s=NIH; t=1582222310;  x=1613758310;  h=from:to:subject:date:message-id:references:in-reply-to:   content-transfer-encoding:mime-version;  bh=+OQNk4kvPLHd8wM7cSusiMIeqPaZvrdR0nN3aue+XPw=;  b=akB0DN6eOKaJoVUemiyBAy6he8Exngvlz9cukebbGP24o8jos0sYArCB   bkwU+HBHfLnDt2GVRj8I3mjEJaimsFMrl/easbbFAS/BVWSGcL7GrZLbG   zCw6CNRqNnUC4B+kGIxeKMEXwjVA3KHwior6Y1CfQDkvNEYEJgtv7uWsj   99d8G+h/6PJ919thEP7+IHSl8D68a4ii5OrSmZPQx4BImGbzegYw0vhdK   OdCtkvtDn8YfHYSSiEkSZ0n3xeprMoBCH6exdTKxJO57rKKYSaNTSWYUX   mRqp4xNKbaXGWHQHuMPOTt4MtiZQvPc3xk3V48B2q8RQINvWHvti+R50f   w==;
IronPort-SDR: 5riwqn0qPfxwEP9L0EblkhENfk8n65m+W1zkZdXjFFqGQLoTMDugIoCO8GTj0VhcfQHX5uOfCx yBuruiW+Dtwg==
Received: from uccbx04.nih.gov (HELO ces.nih.gov) ([156.40.79.154])  by nihcesxway3.hub.nih.gov with ESMTP/TLS/ECDHE-RSA-AES256-SHA384; 20 Feb 2020 13:11:48 -0500
Received: from uccbx04.nih.gov (156.40.79.154) by uccbx04.nih.gov (156.40.79.154) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 20 Feb 2020 13:11:47 -0500
Received: from GCC02-DM3-obe.outbound.protection.outlook.com (156.40.79.134) by uccbx04.nih.gov (156.40.79.154) with Microsoft SMTP Server (TLS) id 15.0.1497.2 via Frontend Transport; Thu, 20 Feb 2020 13:11:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=Qtx955oQ9wacsRAa9JjlOjPE4Wj2CgJ0ABsjhlou8gJC0t8/KqoWxYJ1IIhIzawM0yuWBEV7UuVWCztgqKHBa+pzmaGJJv/7X7nYWgNXaDGv+90/RMJt1qQJNgiypO2K7yEm+SN4zzy4Dh1UegXeyokwZ/xODZmVTr0Q5uKPoEnvBrAAlbilwiCC1jMTsj+nYy7a7Hb3+SkKgdTs3rfnv8YVpezX09LZ75SapJq8QIGHR+QGOQAKjgAFjYKyGpQbWpXtC4NWRtNSP6MS2bp43pM/lEIutAARGFma1H5awAYhsEdL4+FsYFJIH0529fgF/GqtAzpYybItvom+leTuGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=+OQNk4kvPLHd8wM7cSusiMIeqPaZvrdR0nN3aue+XPw=; b=Tp1uyHLLJJtw7i2S/5ng1rljOWeuR3nrG9iE1qniaKyLrzfZgbesqocDbrFcZwSXFRPnGOuPJwvHN+45jyH+/BBPa9lRhTMUWw09wArdCulAqsbsb8ULgUcwh84QD8NenweAa4F/bzxjg3t+9xBjdJRy3S0JwkRQeu/hjBFC8+A5LEjbMFS1Z+1Naeq+CX2XPWgXaNmyIE1hgvyWtoM+kXnRTAnJ6wWTZUv/Ujg+VFvGF7Ya7Om/PIDiwE2LnRnVNQbor3kLiPqfKAris1TOjNF1KjUZTprHuAyIvPewgOSkge4koGqtGZR6JwoYG8SoqCl1gK7zrkNc4EkalCz6Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=ncbi.nlm.nih.gov; dmarc=pass action=none header.from=ncbi.nlm.nih.gov; dkim=pass header.d=ncbi.nlm.nih.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nih.onmicrosoft.com; s=selector2-nih-onmicrosoft-com; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=+OQNk4kvPLHd8wM7cSusiMIeqPaZvrdR0nN3aue+XPw=; b=cIzr+dI++RCzutkc4xc5xuIbgeT1jX0en1va61BJdMAVkJpC0YRQQX2RrYqH+XNSfGVuoDe3s6zvySPy7mpvwzaKEez3XKxqaNb7O6Vx7lBRf3+izSTJ0ra7UXyTzWdoIxlxha7ZYjOW8Cv9Eusk6Y0C5d+WrDyzvh+jBltxeS0=
Received: from MN2PR09MB5770.namprd09.prod.outlook.com (20.180.66.19) by MN2PR09MB5867.namprd09.prod.outlook.com (20.180.66.74) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.34; Thu, 20 Feb 2020 18:11:46 +0000
Received: from MN2PR09MB5770.namprd09.prod.outlook.com ([fe80::19b5:c25:3ff1:e111]) by MN2PR09MB5770.namprd09.prod.outlook.com ([fe80::19b5:c25:3ff1:e111%3]) with mapi id 15.20.2729.032; Thu, 20 Feb 2020 18:11:46 +0000
From: "Lavrentiev, Anton (NIH/NLM/NCBI) [C] via cygwin-patches" <cygwin-patches@cygwin.com>
Reply-To: "Lavrentiev, Anton (NIH/NLM/NCBI) [C]" <lavr@ncbi.nlm.nih.gov>
To: Takashi Yano <takashi.yano@nifty.ne.jp>, "cygwin-patches@cygwin.com"	<cygwin-patches@cygwin.com>
Subject: RE: [PATCH] Cygwin: console: Ignore 0x00 on write().
Date: Thu, 20 Feb 2020 18:11:00 -0000
Message-ID: <MN2PR09MB5770772CED741B50ACE93229A5130@MN2PR09MB5770.namprd09.prod.outlook.com>
References: <20200220115145.2033-1-takashi.yano@nifty.ne.jp>
In-Reply-To: <20200220115145.2033-1-takashi.yano@nifty.ne.jp>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=lavr@ncbi.nlm.nih.gov;
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-messagedata: hWxccNwnNKpiLy9B4LWZSBwwWmNySmZ4YVubNspqABstA40LekssX61pjVS9fX9lbmP3ZGYWTMKiKCoPY8iEm54ZZE9sM1/2wM984ci5MvI50/yIrYo+yOaGQlww8OiSx7dbt3o8+4jPUk0pIr74LA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y5hjP1ovopLrkk5/ahcjl8biM/0F2MSxhrfzyAHAPWdUXIlQ0P31SYw+OkhctBFq
Return-Path: lavr@ncbi.nlm.nih.gov
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00203.txt

JFYI:

Both 0x00 (NUL) and 0x7F (DEL) used to be the filler characters, and were i=
gnored by most (hardware) terminals from the very early days.

HTH,
Anton

> -----Original Message-----
> From: cygwin-patches-owner@cygwin.com <cygwin-patches-owner@cygwin.com> On
> Behalf Of Takashi Yano
> Sent: Thursday, February 20, 2020 6:52 AM
> To: cygwin-patches@cygwin.com
> Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
> Subject: [PATCH] Cygwin: console: Ignore 0x00 on write().
>=20
> - In xterm compatible mode, 0x00 on write() behaves incompatible
>   with real xterm. In xterm, 0x00 completely ignored. Therefore,
>   0x00 is ignored by console with this patch.
> ---
>  winsup/cygwin/fhandler_console.cc | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/winsup/cygwin/fhandler_console.cc
> b/winsup/cygwin/fhandler_console.cc
> index 66e645aa1..705ce696e 100644
> --- a/winsup/cygwin/fhandler_console.cc
> +++ b/winsup/cygwin/fhandler_console.cc
> @@ -1794,6 +1794,16 @@ bool fhandler_console::write_console (PWCHAR buf,
> DWORD len, DWORD& done)
>  	  len -=3D 4;
>  	}
>      }
> +  /* Workaround for ^@ (0x00) handling in xterm compatible mode. */
> +  if (wincap.has_con_24bit_colors () && !con_is_legacy)
> +    {
> +      WCHAR *p =3D buf;
> +      while ((p =3D wmemchr (p, L'\0', len - (p - buf))))
> +	{
> +	  memmove (p, p+1, (len - (p+1 - buf))*sizeof (WCHAR));
> +	  len --;
> +	}
> +    }
>=20
>    if (con.iso_2022_G1
>  	? con.vt100_graphics_mode_G1
> --
> 2.21.0
