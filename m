Return-Path: <cygwin-patches-return-9403-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 58300 invoked by alias); 5 May 2019 14:16:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 58290 invoked by uid 89); 5 May 2019 14:16:07 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=H*Ad:U*cygwin-patches, 1197, H*r:15.20.1856.10, HX-Languages-Length:1904
X-HELO: NAM01-BN3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr740091.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) (40.107.74.91) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 05 May 2019 14:16:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=BfLoSEiKI3ei/UzhYKMMmtnwrHsFyccB6IdfILA3Hpk=; b=lSFLLFbq67Zjj/BCKri/FPnvLe8oms5BvdYJP4r/votLDMHSbaqaqfq7VOQR9VZ0ebuxbXeYgePr87kZPRrwCX29coZVGh6eYuwsJn3NWicQyDcT/SYpAKDAx5/ytiMQ31qWFtLsG2vOlmXl6lZtDL1PVjLrilmfAK1jKNPEUiw=
Received: from DM6PR04MB5211.namprd04.prod.outlook.com (20.178.24.208) by DM6PR04MB4537.namprd04.prod.outlook.com (20.176.105.146) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1856.10; Sun, 5 May 2019 14:16:03 +0000
Received: from DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::8cd4:1148:6365:acf2]) by DM6PR04MB5211.namprd04.prod.outlook.com ([fe80::8cd4:1148:6365:acf2%4]) with mapi id 15.20.1856.012; Sun, 5 May 2019 14:16:03 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: dll_list: drop unused read_fbi method
Date: Sun, 05 May 2019 14:16:00 -0000
Message-ID: <8b51859f-998a-e5c1-c3e3-91cf5bc1d82f@cornell.edu>
References: <20190430163813.GU3383@calimero.vinschen.de> <94255e80-7793-00a3-d879-b2adf46bc9a6@ssi-schaefer.com>
In-Reply-To: <94255e80-7793-00a3-d879-b2adf46bc9a6@ssi-schaefer.com>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:4941;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <6ADA610BC58C37499E37327D9636F7FC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00110.txt.bz2

On 5/2/2019 4:05 AM, Michael Haubenwallner wrote:
> ---
>   winsup/cygwin/dll_init.h  |  1 -
>   winsup/cygwin/forkable.cc | 23 -----------------------
>   2 files changed, 24 deletions(-)
>=20
> diff --git a/winsup/cygwin/dll_init.h b/winsup/cygwin/dll_init.h
> index e4fbde867..3c274cf35 100644
> --- a/winsup/cygwin/dll_init.h
> +++ b/winsup/cygwin/dll_init.h
> @@ -119,7 +119,6 @@ public:
>   			    ULONG openopts =3D 0, ACCESS_MASK access =3D 0,
>   			    HANDLE rootDir =3D NULL);
>     static bool read_fii (HANDLE fh, PFILE_INTERNAL_INFORMATION pfii);
> -  static bool read_fbi (HANDLE fh, PFILE_BASIC_INFORMATION pfbi);
>     static PWCHAR form_ntname (PWCHAR ntbuf, size_t bufsize, PCWCHAR name=
);
>     static PWCHAR form_shortname (PWCHAR shortbuf, size_t bufsize, PCWCHA=
R name);
>     static PWCHAR nt_max_path_buf ()
> diff --git a/winsup/cygwin/forkable.cc b/winsup/cygwin/forkable.cc
> index e78784c2f..1dcafe5e1 100644
> --- a/winsup/cygwin/forkable.cc
> +++ b/winsup/cygwin/forkable.cc
> @@ -268,29 +268,6 @@ dll_list::read_fii (HANDLE fh, PFILE_INTERNAL_INFORM=
ATION pfii)
>     return true;
>   }
>=20=20=20
> -bool
> -dll_list::read_fbi (HANDLE fh, PFILE_BASIC_INFORMATION pfbi)
> -{
> -  pfbi->FileAttributes =3D INVALID_FILE_ATTRIBUTES;
> -  pfbi->LastWriteTime.QuadPart =3D -1LL;
> -
> -  NTSTATUS status;
> -  IO_STATUS_BLOCK iosb;
> -  status =3D NtQueryInformationFile (fh, &iosb,
> -				   pfbi, sizeof (*pfbi),
> -				   FileBasicInformation);
> -  if (!NT_SUCCESS (status))
> -    {
> -      system_printf ("WARNING: %y =3D NtQueryInformationFile (%p,"
> -		     " BasicInfo, io.Status %y)",
> -		     status, fh, iosb.Status);
> -      pfbi->FileAttributes =3D INVALID_FILE_ATTRIBUTES;
> -      pfbi->LastWriteTime.QuadPart =3D -1LL;
> -      return false;
> -    }
> -  return true;
> -}
> -
>   /* Into buf if not NULL, write the IndexNumber in pli.
>      Return the number of characters (that would be) written. */
>   static int
>=20

Pushed.

Thanks,
Ken
