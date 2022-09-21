Return-Path: <Johannes.Schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by sourceware.org (Postfix) with ESMTPS id 11E6E3856DF1
	for <cygwin-patches@cygwin.com>; Wed, 21 Sep 2022 12:00:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 11E6E3856DF1
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1663761617;
	bh=PeymxcDm1LPquRiCd82S83zAHwzQKcXQCWgSrVqkLJQ=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
	b=ROaB/qZ5jHbYnzfuvP7hayCpv7WcE3fjJJMKMxUscAXACxnkm+mWY49uYsHbo2goC
	 m9bDWoxzo6pzw62XWxXOWyf4QOxSyyvXD4lThRIfHqUm7EZfy1DexRQt9MF+Jt+lzB
	 UIpFy4ceOX/ZKvHzheXrt34lq62xipQ+3Hz9jEns=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.115.55] ([89.1.213.188]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOREi-1ovE0V33Yk-00PxJX for
 <cygwin-patches@cygwin.com>; Wed, 21 Sep 2022 14:00:17 +0200
Date: Wed, 21 Sep 2022 14:00:17 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 2/2] Respect `db_home` setting even for the SYSTEM
 account
In-Reply-To: <20151217204929.GB3507@calimero.vinschen.de>
Message-ID: <4rq98no4-1p03-31o0-os85-5pq2p6prn356@tzk.qr>
References: <0Lg1Tn-1YnzUw0ScN-00pcgi@mail.gmx.com> <cover.1450375424.git.johannes.schindelin@gmx.de> <90c5b45fbe7c26e85e65d69d999b4118a2a89c5a.1450375424.git.johannes.schindelin@gmx.de> <20151217204929.GB3507@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:f5axfdfTpwNtM8LRtB3Z1IK8msTuSFnkE+7nI4UBJp9SEi+3fXI
 LX9Rq0O5FGwfilDUf8Kpcxq9uVLvfO0kAf9QptECzzvb3JBVXAiQQaHN0Nay1icik4iLoEY
 J8z7cQQtDjU7kIuav0Id86K2Zll4TkIkta/RUdV3FMhPKTU2f428D5c0Prc1mhptsV3x7gK
 q+w3vEoX+NC0SQLc9CDSQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GBZeu/YfxKQ=:HD6NkYqcsMlJXSFKaps2U1
 Iqcxkp/C8NuLvkezfPAlAk/ZCDMAUjGbMUjPgy5uphasodgpGKbMQDovnFONt7/55RMFdw8IX
 xegjDqTBQxVmqc9Ms50VkERPfJmX+2rXeZ5ah/wjLofoAfDIAX/+hjBEIPZFF4kHFSgKn8DRB
 146kkQwi6SvYyp3EEFpcC8t4hN4haQ1OwNONfGOYgKUXnabaGU22vm+54IVLLyUGhGXrKsPHN
 sh2M+4SY0PuIAdlomr4JnR8zNnkmxiSVnF8Bbn206JHQG4nUhWtUgUbHceBCYoy9SnQJVpax8
 2I9xxpnkrEtX1X0CLe7mhPZEuXCyIsyFTodhOHmbV5I7UOdMauFPns3g6FIJ2ZJuXTZZBADtl
 xkqL9AWQvd8F+gaSJZO+YxeNad9Z/6mKpyuC569c26L5KPeXtJElzDhFX8Y/X8Srpfi2DapV5
 38fqZ0ulJ9TTxSCoZKfCDBRJOS3VXMvZeCMPjhx4mCtyUaP3ko4Jefi29CEEMIN3CYni5Dp8V
 BrwFdjs+iIcGP+u97+/Kxg/4BO8zwksmMieCK7ZNEoKiGreWbKGepYlYCwv9keQ+nO8ppqmZF
 MiSZTAUaEE2jecD3VLcy131o8RcRBOeScBq+H5LsQYWAK+igUwOthC3f2cSwF6cdSQR/vywx6
 0K9VhhqWPumG6O3GS0+JHG/Y//e5ikmHaeyu6ahxjTRnaq/jyzDaZpucN+Nd7hPKAysbIkhYI
 RuF0nqJrxghwYXmE0o/m4hvLYTQec2bnkeyGgRkLFOKh16YWooLTIZ9wl+QFoyR1allC5/bGk
 B67RIbUDsxY+SbbbBFVieao4UY9Ep75QdBamZ5npNJw/u8Qpx5o6mh1pEPnNCrg6BV/SME8qV
 FNaDhHO2Fkay8iI2fUS6s0InBA3w3hI+LAEqnMYKD5ZCHVs4NvFPQ7IKy/ILQB6b3kj2gTM1J
 /DjDWEA6OKCHrExdNbWqZhBmry4WHWwXa7WKO887WYV6RKIM3HzUAiqMEixC/bfL4jOMGlpVl
 7btL0iQ/9+/WR1CxB6GDbTSBOOuhiA5abXDWPXSwXxpNlPR8XPed57CEN+en37qR9iRDiuyG7
 s4e9DVm8+hr5M2VXazd43V24TZ8jAyc3FWqw0289tikhK6Sona5inS0yPm8l6uGXAqfCdOw6A
 KJI3mkctdYVd+Lpa+270TVJhtx
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On Thu, 17 Dec 2015, Corinna Vinschen wrote:

> On Dec 17 19:05, Johannes Schindelin wrote:
> > We should not blindly set the home directory of the SYSTEM account to
> > /home/SYSTEM, especially not when that value disagrees with what is
> > configured via the `db_home` line in the `/etc/nsswitch.conf` file.
> >
> > This fixes https://github.com/git-for-windows/git/issues/435
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  winsup/cygwin/uinfo.cc | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
> > index a5d6270..8c51b82 100644
> > --- a/winsup/cygwin/uinfo.cc
> > +++ b/winsup/cygwin/uinfo.cc
> > @@ -2129,7 +2129,11 @@ pwdgrp::fetch_account_from_windows (fetch_user_=
arg_t &arg, cyg_ldap *pldap)
> >  	 it to a well-known group here. */
> >        if (acc_type =3D=3D SidTypeUser
> >  	  && (sid_sub_auth_count (sid) <=3D 3 || sid_id_auth (sid) =3D=3D 11=
))
> > -	acc_type =3D SidTypeWellKnownGroup;
> > +	{
> > +	  acc_type =3D SidTypeWellKnownGroup;
> > +	  home =3D cygheap->pg.get_home (pldap, sid, dom, domain, name,
> > +				       fully_qualified_name);
>
> Uhm, that's a bit over the top, isn't it?  It will affect all S-1-5-X
> accounts as well as the S-1-5-11 Windows account SIDs.  Is that really
> what you want?

Yes, it was really what I want because it's about respecting `db_home:
env`, and there _are_ apparently SIDs a user can have that fall into the
category "Microsoft account" where we want that to be respected, too ;-)

> Using pldap here may SEGV in cygheap_pwdgrp::get_home, btw, because
> it may be NULL.  cygheap_pwdgrp::get_home doesn't check pldap for
> validity, it expects a valid pointer.  You could either use cldap, or
> cygheap_pwdgrp::get_home would have to check pldap before using it.
>
> However, either way there's another problem: Independently of the
> configured db_home schemes, you don't want to ask the DC for info on
> these builtin accounts.  The better approach might be to call the
> PUSER_INFO_3 variant of cygheap_pwdgrp::get_home with a NULL ui
> pointer and just check for ui in the NSS_SCHEME_DESC case.  The other
> called functions fetch_windows_home and fetch_from_path both can
> live with both pointers, pldap and ui being NULL.

Excellent, I used the `PUSER_INFO_3` method.

Thank you,
Dscho
