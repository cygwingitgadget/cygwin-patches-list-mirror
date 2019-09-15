Return-Path: <cygwin-patches-return-9687-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 67196 invoked by alias); 15 Sep 2019 15:39:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 67186 invoked by uid 89); 15 Sep 2019 15:39:46 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=discover
X-HELO: NAM05-DM3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr730118.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) (40.107.73.118) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 15 Sep 2019 15:39:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=JPnLlFXv13H+Py3n7RFRcwTlGnYyKslySfXeK4k3VqXT1Tld4PaLB3kmoOuVHBaViM3a84dSQIEntHS6FePhykZzMeJ58o66ZEog2TZ+fnQhtIbkh2jIfrHkUEloGkR3DkmcfCiEQbPzZpBLUm7fCXhj4M8xvkIl0R9ghcuadDyBllnIK6h3McciT17jyShSEO7WoL55TNkQz42Pd+cZsqSjMpFso2zXESWdKbJ4AdcFBNo3cCW6OfCD7CwRz9h/5QX8H2LvFY1Rz1z6iogf80zer6TvwpTOeYYfcH0axUhuGeychXmk+TcWXyfUxWUIRi3lfGYPN/w/u36I1sDRuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=aLofUbKgypGG7q54v2Gg6gyR9d8jFSzt+BZKXYUfVJ8=; b=SQPHtfjQoMdHw9qaUBOqvgA/PZoQTtQXfX/dL/MFgbZI3nzlJ0c3ktoUMVyOTF/lssJ5RhH+1WqgJCm04xVxt1GrVTtd/BOnavkHjIz+7a+p18To5HeJYdaiwojvilSpRxIUU9kHINq8WcDCIWKPhrMt0hrQQgEyEWxS5MgxO0lPA4xZj4COt6CbewTXWURMDo1wWVtJYgyJDQ5q/9TPgxUr+eDp7ZDtCrInTpJ2sxwYlTOVuCBnXhh6iQ94xO47ZxIKdQU122lz9evHJGXfy+EcMGsg7c9L1Lr68fP9hRGjrIN10UVPLtPYyGn9J4PRlez0jHNf6BAU6HF3Mru9UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=aLofUbKgypGG7q54v2Gg6gyR9d8jFSzt+BZKXYUfVJ8=; b=JJ7o0jx0sCAwRYw+4qOSkFwBkc6IgnK7j8GkPP++3Hmy2DPLEjXxwRFt4AG+6WGpXI87RmkCX3VsNhCQyDoSB583o954tnfFAdQQKFsP+3pqY1usPaGiwQIkDF4EC1hpxsixY8e7OPgACYbOHU3eaTd/ahyUVLnq2Y2eK6rOsrc=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB5801.namprd04.prod.outlook.com (20.179.51.84) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.26; Sun, 15 Sep 2019 15:39:42 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473%4]) with mapi id 15.20.2263.023; Sun, 15 Sep 2019 15:39:42 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: pty: Use autoload feature for pseudo console system calls.
Date: Sun, 15 Sep 2019 15:39:00 -0000
Message-ID: <9eb0119b-9c47-e0f2-a7ba-7350261b6009@cornell.edu>
References: <20190915105544.1918-1-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190915105544.1918-1-takashi.yano@nifty.ne.jp>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:6430;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <6C8F620419D7A3429A05B49267470081@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VIyQ+V4PA8CJSAXmkckA42z8Wk2tPs4BTbDrHVf6zglOJVI0Iguk8rRar77Kl/JtjFgfUwIp0IqOYNSTNZsJZQ==
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00207.txt.bz2

On 9/15/2019 6:55 AM, Takashi Yano wrote:
> - The autoload feature is used rather than GetModuleHandle(),
>    GetProcAddress() for CreatePseudoConsole(), ResizePseudoConsole()
>    and ClosePseudoConsole().
> ---
>   winsup/cygwin/autoload.cc     |  3 +++
>   winsup/cygwin/fhandler_tty.cc | 36 +++++++++++++----------------------
>   2 files changed, 16 insertions(+), 23 deletions(-)
>=20
> diff --git a/winsup/cygwin/autoload.cc b/winsup/cygwin/autoload.cc
> index c4d91611e..1851ab3b6 100644
> --- a/winsup/cygwin/autoload.cc
> +++ b/winsup/cygwin/autoload.cc
> @@ -759,4 +759,7 @@ LoadDLLfunc (PdhAddEnglishCounterW, 16, pdh)
>   LoadDLLfunc (PdhCollectQueryData, 4, pdh)
>   LoadDLLfunc (PdhGetFormattedCounterValue, 16, pdh)
>   LoadDLLfunc (PdhOpenQueryW, 12, pdh)
> +LoadDLLfuncEx (CreatePseudoConsole, 20, kernel32, 1)
> +LoadDLLfuncEx (ResizePseudoConsole, 8, kernel32, 1)
> +LoadDLLfuncEx (ClosePseudoConsole, 4, kernel32, 1)
>   }
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index 5072c6243..659e7b595 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -47,6 +47,12 @@ details. */
>   extern "C" int sscanf (const char *, const char *, ...);
>   extern "C" int ttyname_r (int, char*, size_t);
>=20=20=20
> +extern "C" {
> +  HRESULT WINAPI CreatePseudoConsole (COORD, HANDLE, HANDLE, DWORD, HPCO=
N *);
> +  HRESULT WINAPI ResizePseudoConsole (HPCON, COORD);
> +  VOID WINAPI ClosePseudoConsole (HPCON);
> +}
> +
>   #define close_maybe(h) \
>     do { \
>       if (h && h !=3D INVALID_HANDLE_VALUE) \
> @@ -2157,14 +2163,8 @@ fhandler_pty_master::close ()
>   	  /* FIXME: Pseudo console can be accessed via its handle
>   	     only in the process which created it. What else can we do? */
>   	  if (master_pid_tmp =3D=3D myself->pid)
> -	    {
> -	      /* Release pseudo console */
> -	      HMODULE hModule =3D GetModuleHandle ("kernel32.dll");
> -	      FARPROC func =3D GetProcAddress (hModule, "ClosePseudoConsole");
> -	      VOID (WINAPI *ClosePseudoConsole) (HPCON) =3D NULL;
> -	      ClosePseudoConsole =3D (VOID (WINAPI *) (HPCON)) func;
> -	      ClosePseudoConsole (getPseudoConsole ());
> -	    }
> +	    /* Release pseudo console */
> +	    ClosePseudoConsole (getPseudoConsole ());
>   	  get_ttyp ()->switch_to_pcon_in =3D false;
>   	  get_ttyp ()->switch_to_pcon_out =3D false;
>   	}
> @@ -2348,10 +2348,6 @@ fhandler_pty_master::ioctl (unsigned int cmd, void=
 *arg)
>   	 only in the process which created it. What else can we do? */
>         if (getPseudoConsole () && get_ttyp ()->master_pid =3D=3D myself-=
>pid)
>   	{
> -	  HMODULE hModule =3D GetModuleHandle ("kernel32.dll");
> -	  FARPROC func =3D GetProcAddress (hModule, "ResizePseudoConsole");
> -	  HRESULT (WINAPI *ResizePseudoConsole) (HPCON, COORD) =3D NULL;
> -	  ResizePseudoConsole =3D (HRESULT (WINAPI *) (HPCON, COORD)) func;
>   	  COORD size;
>   	  size.X =3D ((struct winsize *) arg)->ws_col;
>   	  size.Y =3D ((struct winsize *) arg)->ws_row;
> @@ -3103,22 +3099,16 @@ fhandler_pty_master::setup_pseudoconsole ()
>        process in a pseudo console and get them from the helper.
>        Slave process will attach to the pseudo console in the
>        helper process using AttachConsole(). */
> -  HMODULE hModule =3D GetModuleHandle ("kernel32.dll");
> -  FARPROC func =3D GetProcAddress (hModule, "CreatePseudoConsole");
> -  HRESULT (WINAPI *CreatePseudoConsole)
> -    (COORD, HANDLE, HANDLE, DWORD, HPCON *) =3D NULL;
> -  if (!func)
> -    return false;
> -  CreatePseudoConsole =3D
> -    (HRESULT (WINAPI *) (COORD, HANDLE, HANDLE, DWORD, HPCON *)) func;
>     COORD size =3D {80, 25};
>     CreatePipe (&from_master, &to_slave, &sec_none, 0);
> +  SetLastError (ERROR_SUCCESS);
>     HRESULT res =3D CreatePseudoConsole (size, from_master, to_master,
>   				     0, &get_ttyp ()->hPseudoConsole);
> -  if (res !=3D S_OK)
> +  if (res !=3D S_OK || GetLastError () =3D=3D ERROR_PROC_NOT_FOUND)
>       {
> -      system_printf ("CreatePseudoConsole() failed. %08x\n",
> -		     GetLastError ());
> +      if (res !=3D S_OK)
> +	system_printf ("CreatePseudoConsole() failed. %08x\n",
> +		       GetLastError ());
>         CloseHandle (from_master);
>         CloseHandle (to_slave);
>         from_master =3D from_master_cyg;

Pushed.  Thanks.

Ken

P.S. I'm building a new test release now, which I'll upload in a few hours=
=20
unless you discover something else and want me to wait.
