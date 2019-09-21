Return-Path: <cygwin-patches-return-9715-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 83066 invoked by alias); 21 Sep 2019 17:37:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 83056 invoked by uid 89); 21 Sep 2019 17:37:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM04-SN1-obe.outbound.protection.outlook.com
Received: from mail-eopbgr700103.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) (40.107.70.103) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 21 Sep 2019 17:37:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=A0S2rdQD0jgORsXl2F1bujclXyZTxWdm8EsEAjwGGYUDyB+B/t+PAHp7g3Ak0QxBIkaJrCKUQlRijpW1l4tHSLjJzF1QSnGijXUuWgdpicW9kq6gyCkzrAy2eDg3YRflIXDv/W9ACN9znbkz9QUQ1Vu+XN0NyjoiQgFjqZTXQ1Wo2zjy7jp3yd0FxKE8tBHQCWXWjg1XwZqm8hUTN19ggQ3t5bB5Dt+tgMXRrtgCtMorObUyxO7edjY4eOzd+hahxf1fDVpIFOlTh9zmvzy1srziVxmvWd2tSl+TpVr5o2dxGWPDk3oU/fCaNIEY+MNEeTAnTFSCQdUtP9ggWBpisQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=ihOSYE4NHqbdNQYtELZqUqZTsMgCBuy/12I5MzCQcdo=; b=aq+3hYnImqg6D15gJK+vx0VLtI3QXOVRBAuzDPGh7RTyUmJEGr57y16yjWnUBSOmcWTbCzY6mwiSGX0g2iAPJP8DoEO6gjuecLcJ5uB5iZnizyMOgMf7cVwQDyrw+GOMSJWQwqMWhEMTrYymwgJGyxzXJG0hYvXoX+a4x1Q45aZg9WI3PRuhl1ewobZwbzk5NaJIoxX+FgEr/BgN5ir26ydIVCp/ZI8PvMoa4KFvhtzfsKm+7YmcpOZZSAwB8iNlNg97KBWeGjXi38c6HDtLILQ56dh9J6TUmOmfPygvLK9VvOT2rSPETAGxrw9wEpd6u7t4Qp5tOXKZPss8T8290Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=ihOSYE4NHqbdNQYtELZqUqZTsMgCBuy/12I5MzCQcdo=; b=i7UV3LgpAA0NJQIw6El+I4dZ4RY7fLSJvjyGuR2ByMCcjG92EaY6zbM73PLDUfcLNdaytWjpxpdOF9r+FbhNkNb+8QA8ESFfkccf5i2+ZXiXFQWNIcBEZXAxaa4xdgFEaw5uFMfp60EP0l5oKuj3paunG6SV0j2UEe52TOYGa1A=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB5836.namprd04.prod.outlook.com (20.179.50.32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.25; Sat, 21 Sep 2019 17:37:02 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473%4]) with mapi id 15.20.2263.023; Sat, 21 Sep 2019 17:37:02 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: remove old cruft from path_conv::check
Date: Sat, 21 Sep 2019 17:37:00 -0000
Message-ID: <f2a8d51c-9eb7-0759-ae0b-58afd1508d40@cornell.edu>
References: <20190921173347.1527-1-kbrown@cornell.edu>
In-Reply-To: <20190921173347.1527-1-kbrown@cornell.edu>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-exchange-purlcount: 1
x-ms-oob-tlc-oobclassifiers: OLM:2089;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <1C3C03DCB1850E4591553E886D163032@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /B1kmps//j3NesQ8aady9MRz0u/ZSbRXie9aUaJriG8p9tHrtA5q5VwUbBZAwwgTjAMxsGRxRMWzDLqqFb0DAQ==
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00235.txt.bz2

On 9/21/2019 1:34 PM, Ken Brown wrote:
> Prior to commit b0717aae, path_conv::check had the following code:
>=20
>        if (strncmp (path, "\\\\.\\", 4))
>          {
>            /* Windows ignores trailing dots and spaces in the last path
>               component, and ignores exactly one trailing dot in inner
>               path components. */
>            char *tail =3D NULL;
>            [...]
>            if (!tail || tail =3D=3D path)
>              /* nothing */;
>            else if (tail[-1] !=3D '\\')
>              {
>                *tail =3D '\0';
>            [...]
>          }
>=20
> Commit b0717aae0 intended to disable this code, but it inadvertently
> disabled only part of it.  In particular, the declaration of the local
> tail variable was in the disabled code, but the following remained:
>=20
>            if (!tail || tail =3D=3D path)
>              /* nothing */;
>            else if (tail[-1] !=3D '\\')
>              {
>                *tail =3D '\0';
>            [...]
>          }
>=20
> [A later commit removed the disabled code.]
>=20
> The tail variable here points into a string different from path,
> causing that string to be truncated under some circumstances.  See
>=20
>    https://cygwin.com/ml/cygwin/2019-09/msg00001.html
>=20
> for more details.
>=20
> This commit fixes the problem by removing the leftover code
> that was intended to be removed in b0717aae.
> ---
>   winsup/cygwin/path.cc | 13 -------------
>   1 file changed, 13 deletions(-)
>=20
> diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
> index c13701aa0..2fbacd881 100644
> --- a/winsup/cygwin/path.cc
> +++ b/winsup/cygwin/path.cc
> @@ -1168,19 +1168,6 @@ path_conv::check (const char *src, unsigned opt,
>=20=20=20
>         if (dev.isfs ())
>   	{
> -	  if (strncmp (path, "\\\\.\\", 4))
> -	    {
> -	      if (!tail || tail =3D=3D path)
> -		/* nothing */;
> -	      else if (tail[-1] !=3D '\\')
> -		*tail =3D '\0';
> -	      else
> -		{
> -		  error =3D ENOENT;
> -		  return;
> -		}
> -	    }
> -
>   	  /* If FS hasn't been checked already in symlink_info::check,
>   	     do so now. */
>   	  if (fs.inited ()|| fs.update (get_nt_native_path (), NULL))

This seems pretty straightforward to me, but I'll wait a few days before=20
committing it in case I'm missing something.

Ken
