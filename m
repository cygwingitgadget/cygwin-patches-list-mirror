From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: tiny patch for setup.exe
Date: Tue, 29 May 2001 18:39:00 -0000
Message-id: <20010529213940.A14906@redhat.com>
References: <20010526181011.5457.SOHDA@is.titech.ac.jp>
X-SW-Source: 2001-q2/msg00267.html

On Sat, May 26, 2001 at 06:20:27PM +0900, Yukihiko Sohda wrote:
>Hi,
>
>Current setup.exe can't parse `+' character in setup.ini.

Applied, thanks.

cgf

># for gtk+ ?
>
>--- inilex.l.orig       Sat May 26 18:08:33 2001
>+++ inilex.l    Fri May 25 02:09:44 2001
>@@ -36,7 +36,7 @@ static void ignore_line ();
> %option yylineno
> %option never-interactive
>
>-STR    [a-zA-Z0-9_./-]+
>+STR    [a-zA-Z0-9_./+-]+
>
> %%
>
>----
>Yukihiko Sohda <sohda@is.titech.ac.jp>
