Return-Path: <cygwin-patches-return-9686-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 65812 invoked by alias); 15 Sep 2019 15:37:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 65802 invoked by uid 89); 15 Sep 2019 15:37:41 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=H*M:aab9
X-HELO: NAM05-DM3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr730124.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) (40.107.73.124) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 15 Sep 2019 15:37:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=bu+9RlKy/KzwjLXA59yRqHMOd/0FDtFYb4tUE25xvL+NyjNsK+9Ke576e2QhkxgAPOuLS004JhIGxfQXr67dAkjOm4Bph7eTIiuPFMkgrNUC7yu6jCpOmH+iKwaegP1PkxjGk5megYSPDlFRIbWQM4CkpMriIkx0azVdaPbbItqrWUvOOG7KqIMB1o5MgAeZLU0x1VyoIddBkjZmCRPt7ei0WeNMqmsPy0H6FPSCuEOEk1WDbKFUY+uqrg5mnxEXDrr172d0VC0czA+9VVTaeMt73bdslM7ihYupi9GleplDt9eB2DzRTj0K2aMAxuCMKaja7PIempc7vw0YTkP89g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=wC5qPVQGfnMajQhlCMZzqldwgeK3SwdcCdok9DqrtDg=; b=mOpIS4Iru3MKaRrVQJMB7KMdbAtyLgciNlgypI/WR+cYviIZqwTFfZTZkgpAAJXE8pNxwbqOAQEjrIV/I8XdoKhAXg2blM0d/fATZ/7oKceFnGPtBB9odLxZKnfSuNAdW6z7Ip0ehLZWXir0mv/5xXr/j9abb7xtQFAzoA0MKFY1fKk/0ukPBCTK37H2IR3JSXSSbzJKRMTdZ4cC9Wp6CJSH7k0KXqy/r4UaQs4qssdfdMzNCWaoWVPbRCL6XMuhbbClZZn+2lmTt832DkY8DAD+XkSryjI8ukNGFSagbRe4S3OFalCARr+4VXUesG7TtU/L+igrFxK/PDwzX6R3gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=wC5qPVQGfnMajQhlCMZzqldwgeK3SwdcCdok9DqrtDg=; b=jDc9yw778pkRg21I3TKWQnMJZTFepx2MyDe9+9OWqdxASr4ChxdmBPzxkYuYlax5vzOg0b/m9PIDjlsSw/fxz/3bD+jWSS2tFoYdbpv89+xJhL0c0N/MVljXP/QmY5Nsh8wy/jcIz2cNhV6OopdjucrgxzD1dU6xCSsN8ohNGSQ=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB5801.namprd04.prod.outlook.com (20.179.51.84) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.26; Sun, 15 Sep 2019 15:37:37 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473%4]) with mapi id 15.20.2263.023; Sun, 15 Sep 2019 15:37:37 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: pty: Correct typos that do not fit the coding style.
Date: Sun, 15 Sep 2019 15:37:00 -0000
Message-ID: <617ee289-aab9-8dcf-56a8-f30e48c5290f@cornell.edu>
References: <20190915043623.916-1-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190915043623.916-1-takashi.yano@nifty.ne.jp>
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:197;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <0FC11E2E3CB0E04B9A0669010C48A92B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9PmL7vxgqhOVd13tfsmwxxARuRHZJq/koZ4GBpKs2lIhL782y+SCMcorEv0PBwbJcW0DlTTPCDssxlr1M5EkgA==
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00206.txt.bz2

On 9/15/2019 12:36 AM, Takashi Yano wrote:
> ---
>   winsup/cygwin/fhandler_tty.cc | 26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index 5c27510be..5072c6243 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -45,7 +45,7 @@ details. */
>   #endif /* ENABLE_VIRTUAL_TERMINAL_INPUT */
>=20=20=20
>   extern "C" int sscanf (const char *, const char *, ...);
> -extern "C" int ttyname_r(int, char*, size_t);
> +extern "C" int ttyname_r (int, char*, size_t);
>=20=20=20
>   #define close_maybe(h) \
>     do { \
> @@ -2147,7 +2147,7 @@ fhandler_pty_master::close ()
>     else if (obi.HandleCount =3D=3D (getPseudoConsole () ? 2 : 1))
>   			      /* Helper process has inherited one. */
>       {
> -      termios_printf("Closing last master of pty%d", get_minor ());
> +      termios_printf ("Closing last master of pty%d", get_minor ());
>         /* Close Pseudo Console */
>         if (getPseudoConsole ())
>   	{
> @@ -2446,9 +2446,9 @@ get_locale_from_env (char *locale)
>     char lang[ENCODING_LEN + 1] =3D {0, }, country[ENCODING_LEN + 1] =3D =
{0, };
>     env =3D getenv ("LC_ALL");
>     if (env =3D=3D NULL || !*env)
> -    env =3D getenv("LC_CTYPE");
> +    env =3D getenv ("LC_CTYPE");
>     if (env =3D=3D NULL || !*env)
> -    env =3D getenv("LANG");
> +    env =3D getenv ("LANG");
>     if (env =3D=3D NULL || !*env)
>       {
>         if (GetLocaleInfo (LOCALE_CUSTOM_UI_DEFAULT,
> @@ -2476,7 +2476,7 @@ get_locale_from_env (char *locale)
>   			 LOCALE_SISO3166CTRYNAME,
>   			 country, sizeof (country));
>         if (strlen (lang) && strlen (country))
> -	__small_sprintf (lang + strlen(lang), "_%s.UTF-8", country);
> +	__small_sprintf (lang + strlen (lang), "_%s.UTF-8", country);
>         else
>   	strcpy (lang , "C.UTF-8");
>         env =3D lang;
> @@ -2492,7 +2492,7 @@ get_langinfo (char *locale_out, char *charset_out)
>     get_locale_from_env (new_locale);
>=20=20=20
>     __locale_t loc;
> -  memset(&loc, 0, sizeof (loc));
> +  memset (&loc, 0, sizeof (loc));
>     const char *locale =3D __loadlocale (&loc, LC_CTYPE, new_locale);
>     if (!locale)
>       locale =3D "C";
> @@ -2565,8 +2565,8 @@ get_langinfo (char *locale_out, char *charset_out)
>       return 0;
>=20=20=20
>     /* Set results */
> -  strcpy(locale_out, new_locale);
> -  strcpy(charset_out, charset);
> +  strcpy (locale_out, new_locale);
> +  strcpy (charset_out, charset);
>     return lcid;
>   }
>=20=20=20
> @@ -2670,7 +2670,7 @@ fhandler_pty_slave::fixup_after_attach (bool native=
_maybe, int fd_set)
>   		get_ttyp ()->pcon_pid =3D myself->pid;
>   	      get_ttyp ()->switch_to_pcon_out =3D true;
>   	    }
> -	  init_console_handler(false);
> +	  init_console_handler (false);
>   	}
>         else if (fd =3D=3D 0 && native_maybe)
>   	/* Read from unattached pseudo console cause freeze,
> @@ -2754,7 +2754,7 @@ fhandler_pty_slave::fixup_after_exec ()
>   	{ \
>   	  void *api =3D hook_api (module, #name, (void *) name##_Hooked); \
>   	  name##_Orig =3D (__typeof__ (name) *) api; \
> -	  /*if (api) system_printf(#name " hooked.");*/ \
> +	  /*if (api) system_printf (#name " hooked.");*/ \
>   	}
>         DO_HOOK (NULL, WriteFile);
>         DO_HOOK (NULL, WriteConsoleA);
> @@ -3118,7 +3118,7 @@ fhandler_pty_master::setup_pseudoconsole ()
>     if (res !=3D S_OK)
>       {
>         system_printf ("CreatePseudoConsole() failed. %08x\n",
> -		     GetLastError());
> +		     GetLastError ());
>         CloseHandle (from_master);
>         CloseHandle (to_slave);
>         from_master =3D from_master_cyg;
> @@ -3230,7 +3230,7 @@ fhandler_pty_master::setup ()
>       termios_printf ("can't set output_handle(%p) to non-blocking mode",
>   		    get_output_handle ());
>=20=20=20
> -  char pipename[sizeof("ptyNNNN-to-master-cyg")];
> +  char pipename[sizeof ("ptyNNNN-to-master-cyg")];
>     __small_sprintf (pipename, "pty%d-to-master", unit);
>     res =3D fhandler_pipe::create (&sec_none, &from_slave, &to_master,
>   			       fhandler_pty_common::pipesize, pipename, 0);
> @@ -3406,7 +3406,7 @@ fhandler_pty_common::process_opost_output (HANDLE h=
, const void *ptr, ssize_t& l
>   		break;
>   	      else
>   		{
> -		  set_errno(EAGAIN);
> +		  set_errno (EAGAIN);
>   		  len =3D -1;
>   		  return TRUE;
>   		}

Pushed.  Thanks.

Ken
