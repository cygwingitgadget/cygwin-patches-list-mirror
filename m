Return-Path: <cygwin-patches-return-9689-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23779 invoked by alias); 15 Sep 2019 17:17:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 23769 invoked by uid 89); 15 Sep 2019 17:17:31 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: NAM02-BL2-obe.outbound.protection.outlook.com
Received: from mail-eopbgr750104.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) (40.107.75.104) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 15 Sep 2019 17:17:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=OLvOkEWxYNNLcJDCrPgjlfNAWWOH/w5vhSEsgDX+AqAHN1TmZQV3BPGaMxsJHulthhfloDmKVDQyPRhnkJKLe+6+mKOQO7l4AbyCj+9eRQymyAeUo98YI4e3DrZ5nEoiyvIq0CTKRc/5usbNS/nv5osABvadjXCe79NbDeZXKt1ASVXanTZEBJDFwPLCVTcW4rKh6sr01w6ajwBNTRvHM/Fk7JbT9hPxuNpfK1jI5fyelTmzqEAc0wP8x9bmGPj5f0eFnPXeDUGMx6TWlT9mjlP8IfQypNkdDtjTnMj93GhDxDF7yJjvqJ1BhgN3vUwHjy2gijj63Ye+nwhVvTIhxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=l0gDBGhoc6TNN0SUk0u/OClBh1ajsfO23JBj+ghfmOI=; b=ZEV7O8fwtrirj/kInz7qgLmJgWg8QlBYY2cKNXO9Ax8jEibJdFnxw28qctGzg9eGKpnKAUguJVn76y1ScSpm+j/U/B1zJ7dFvE+RmiLq6PQIerlB//w80TMw5M0t1xUrw2/kjUi0gW9tXkBvWHE7RqXV9Xgaj1TTPDQZ9exni2vge/T3Ryiyw3+dxTRmRxfRHnEKmvEMOmtGwUXYhsYMMZlvMxaopznBEG98Rb47u7e31hgvsezR80nHZBWs9sCD2epgGGO02+u128t/kasf94yw1yBtiCCrSBekmVgwtQ5DbfNYX1x9Zr7rY/TKtAbx6meTcYB8S8CetlI1t1RG3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=l0gDBGhoc6TNN0SUk0u/OClBh1ajsfO23JBj+ghfmOI=; b=RpcOdYwzmuALIkmeDpHe15N0Qi0jAVgvDvb5yUTcbOgcGWpfcPncCi+lr/cYB9hWVDaCDdvpDD0brz1TqnKQ+c5Rh5LEZ2NIPswHrVPvxFzcQofOUObCJXKr/gfsa0hSwt/e/tj/3/vpTttHf0/zgAiI6LDr/AV2iZanBXfk4EE=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB6458.namprd04.prod.outlook.com (10.141.162.14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.15; Sun, 15 Sep 2019 17:17:26 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473%4]) with mapi id 15.20.2263.023; Sun, 15 Sep 2019 17:17:26 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] winsup/cygwin/times.cc (times): follow Linux and allow for a NULL buf argument
Date: Sun, 15 Sep 2019 17:17:00 -0000
Message-ID: <bf75810a-3a7b-969e-d8c1-87f3e35cc9c3@cornell.edu>
References: <87pnk17cd6.fsf@Rainer.invalid>
In-Reply-To: <87pnk17cd6.fsf@Rainer.invalid>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:1417;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <A29ED38615CBD0488ED631B4745C01A7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OdQnILKcNUTNIQ8jroJ9Bo0Rqk44rL5tAFp3WP2mmwQzZ1R1eMM3A6/40xHwHfvb/Og2tYdpP/1YSq80qV0C/w==
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00209.txt.bz2

On 9/15/2019 12:28 PM, Achim Gratz wrote:
>=20
> Adresses a problem reported on the Cygwin list.
>=20
> ---
>   winsup/cygwin/times.cc | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
>=20
> diff --git a/winsup/cygwin/times.cc b/winsup/cygwin/times.cc
> index 8908d44f1..909cae1f1 100644
> --- a/winsup/cygwin/times.cc
> +++ b/winsup/cygwin/times.cc
> @@ -72,12 +72,17 @@ times (struct tms *buf)
>         /* ticks is in in 100ns, convert to clock ticks. */
>         tc =3D (clock_t) (ticks.QuadPart * CLOCKS_PER_SEC / NS100PERSEC);
>=20=20=20
> -      buf->tms_stime =3D __to_clock_t (&kut.KernelTime, 0);
> -      buf->tms_utime =3D __to_clock_t (&kut.UserTime, 0);
> -      timeval_to_filetime (&myself->rusage_children.ru_stime, &kut.Kerne=
lTime);
> -      buf->tms_cstime =3D __to_clock_t (&kut.KernelTime, 1);
> -      timeval_to_filetime (&myself->rusage_children.ru_utime, &kut.UserT=
ime);
> -      buf->tms_cutime =3D __to_clock_t (&kut.UserTime, 1);
> +      /* Linux allows a NULL buf and just returns tc in that case, so
> +	 mimic that */
> +      if (buf)
> +	{
> +	  buf->tms_stime =3D __to_clock_t (&kut.KernelTime, 0);
> +	  buf->tms_utime =3D __to_clock_t (&kut.UserTime, 0);
> +	  timeval_to_filetime (&myself->rusage_children.ru_stime, &kut.KernelTi=
me);
> +	  buf->tms_cstime =3D __to_clock_t (&kut.KernelTime, 1);
> +	  timeval_to_filetime (&myself->rusage_children.ru_utime, &kut.UserTime=
);
> +	  buf->tms_cutime =3D __to_clock_t (&kut.UserTime, 1);
> +	}
>       }
>     __except (EFAULT)
>       {

Pushed, with a slight tweak to the commit message.  Thanks.

Ken
