Return-Path: <SRS0=8BlN=73=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by sourceware.org (Postfix) with ESMTPS id 6586C3858C5E
	for <cygwin-patches@cygwin.com>; Tue,  4 Apr 2023 15:12:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6586C3858C5E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1680621152; i=johannes.schindelin@gmx.de;
	bh=nEXoU+/nNs7KFMqfTE1+vrKav7hmsHYOHu8ZCgVbqtM=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
	b=kQycR/GunAXEm7BL44GGYQvaiUdKBLmT/bb9vZ8dDb+eIdwp6smUXo2nJGLI1QVI/
	 laZYhtPTGaJlUEdjttGknJ3nty5ox1ziwwSRbbAivW+6E1dgMuIueggvFn/j5qG6Qf
	 /jxjQGd26lb01fRE71pjhs3WmLImIwK5ocs/gqJIqsxNN0igrmb6eZGSWyg4ocwUT7
	 oDq9irtX7+aeu6i1LxKZUEhR6clveHW9uQyjq0oMT8SpnKVZUiXVflBNfRdBGMSMV+
	 +KXW7P+g1stOgjsFp9/V/i0aDlQiV57lm5jsk7mjpTukPnt3E1I8uuZBhfLlo5ruuE
	 5F3z05Mgdtqvg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.182]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHoNC-1pehr40m62-00EsNy for
 <cygwin-patches@cygwin.com>; Tue, 04 Apr 2023 17:12:32 +0200
Date: Tue, 4 Apr 2023 17:12:30 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5 2/3] Respect `db_home` setting even for SYSTEM/Microsoft
 accounts
In-Reply-To: <ZCsc0EHN3bmWGyId@calimero.vinschen.de>
Message-ID: <613f4936-d811-9206-d466-fe9d8e241269@gmx.de>
References: <cover.1679991274.git.johannes.schindelin@gmx.de> <cover.1680532960.git.johannes.schindelin@gmx.de> <085d4dd8b67f603f0de49999d8e877a27a6751e1.1680532960.git.johannes.schindelin@gmx.de> <ZCsc0EHN3bmWGyId@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:YQxkqx7Y7g7kd54vtfhNvdocPWp60CwBRksfcBwoO3tFocL0/4/
 wYncjRQj79h+xIUe+p5BR2Xg2KM++uY4H8dq2cisi7BqybjxXujN/1k9zzlrk9rG6PpXheL
 +X4gSeue6PkPE3qHD0TLA0SN54fF04tBNjy6WxLzTbUyvw7cnfTvmURvJwMc1DN9P6TJ7b6
 5OdWF0CPAoOlVSZLOkdxA==
UI-OutboundReport: notjunk:1;M01:P0:VnR9CqwSK/0=;R/mc3lMDeNsuK+U0ffsaPpBNe09
 ILbDLu7Mc9CSlhZTMtnJGbXJGDS4y0tYmodBQsRSCOnYOdRxM9yxfynxL+y6zaamwj4geEA7r
 RDie2M8yz+x120zLgG9VF/h/9YzYmQUJVR/3FilM4i4Iy4JqC19zI9DynVTpVCfPT4z/pD0UM
 Ogp30Q5U+eaKg9p6FxzP7i+aKHjjauomLpSfzVcBo6vvKVR8s/VZA4yU232A9KpkyIHO5QPFj
 uV59hHbx2r4dNTOz9UrVvPQRLUWu1ikKCGpjYE6JrTSb5/kfM+P4pbbOleiKfuHYLd23lj9bK
 0opK6RfVxkAtOVQMo7yI3JVzWXHM9Bg5AtGkXPptHiicLEKxy97RJxQloY3HTqfs4NASrt0oG
 VgMvqfyK0+JuEj/U6wNsRuYQXLbZT4EoCvbgEzB8WVt8ur5Vzr5DRB2IspysOJg9CF+UTqcRg
 pUMsJYNQOl/FadSobBAYzfo0EmgGoQcHBNfWPDnBZ4jq52Su5+MBJ538wXDLawOheQ0icAw0Z
 w1aIwos8iagQdL6Bq0NYjGBTjM3TZjj1cZD1ohuDHs3BIFBcxeUHyqGTrLxhKj4bT1nVXUfY9
 rNYQ1klJSdT41Q0OpG8V1Trfi60DrJAtEbDhMKK5+95KHoL7N7vP0BXQgqbDRDBbPnSJebbrJ
 x0Tcf6JeTnbcMckEO72RiAuQzKnwqKhBkp4q+JgYT+IpPCFqeNKi5gGMeucj8f6O8DYlXf3CW
 MGwQ12fK2UGUik3mVcK+iQDjDDsbt7qIFsVHtbayM0vNvrunvX6l57vHe3ZvMMB5vBL4K+PcZ
 TA6OYavYmsRh9DI4dqbTDsrUTl6XdCfcgDhFcfDS8iU2F6bhWdSNAnZsPc1lSz+KymCTuMPwZ
 KZbiY+QRfemGlhQ1cXF4bJaZYy2Qx+nlHEn5ru8iPOT6tYNc/JyjS4ql0KAfY3y9Ug0JXs++e
 hX+aDg==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On Mon, 3 Apr 2023, Corinna Vinschen wrote:

> On Apr  3 16:45, Johannes Schindelin wrote:
> > We should not blindly set the home directory of the SYSTEM account (or
> > of Microsoft accounts) to `/home/<name>`, especially
> > `/etc/nsswitch.conf` defines `db_home: env`, in which case we want to
> > respect the `HOME` variable.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  winsup/cygwin/uinfo.cc | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
> > index baa670478d..d493d29b3b 100644
> > --- a/winsup/cygwin/uinfo.cc
> > +++ b/winsup/cygwin/uinfo.cc
> > @@ -2234,7 +2234,11 @@ pwdgrp::fetch_account_from_windows (fetch_user_=
arg_t &arg, cyg_ldap *pldap)
> >  	 it to a well-known group here. */
> >        if (acc_type =3D=3D SidTypeUser
> >  	  && (sid_sub_auth_count (sid) <=3D 3 || sid_id_auth (sid) =3D=3D 11=
))
> > -	acc_type =3D SidTypeWellKnownGroup;
> > +	{
> > +	  acc_type =3D SidTypeWellKnownGroup;
> > +	  home =3D cygheap->pg.get_home ((PUSER_INFO_3) NULL, sid, dom, name=
,
> > +				       fully_qualified_name);
> > +	}
> >        switch ((int) acc_type)
> >  	{
> >  	case SidTypeUser:
>
> Pushed.

Thank you!
Johannes
