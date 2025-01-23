Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 0A0183858D3C; Thu, 23 Jan 2025 15:56:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0A0183858D3C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1737647810;
	bh=t9Eg2rQbFVwl42m9R5V3RiLdfGgy1Nm02AoTh1Yt56I=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=Mfrz0oizjWUu+In82UpGHIXNRuoHkNB1g00SL0qvvv88u0mA9SeNCWC0Ntt6H9eLq
	 Qv7RovT2Z7edOho5ZW8CZjf5x5o9OnRZdEGK4xU+YFpLcboUyrn7yFSKgS2CK3MMlq
	 psl+6NDgoafv0Zh9flBdooVpiCBPD2Tuo7ZDVuSE=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C285FA80D2A; Thu, 23 Jan 2025 16:56:47 +0100 (CET)
Date: Thu, 23 Jan 2025 16:56:47 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Add new APIs tc[gs]etwinsize()
Message-ID: <Z5Jmv6iyXHy2Rq54@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250123104441.665-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250123104441.665-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

looks good, please push.


Thanks,
Corinna


On Jan 23 19:44, Takashi Yano wrote:
> New APIs tcgetwinsize/tcsetwinsize are added, which is added in
> POSIX.1-2024.
> 
> Reviewed-by:
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/cygwin.din            |  2 ++
>  winsup/cygwin/fhandler/base.cc      |  2 ++
>  winsup/cygwin/include/sys/termios.h |  2 ++
>  winsup/cygwin/termios.cc            | 12 ++++++++++++
>  winsup/doc/new-features.xml         | 12 ++++++++++++
>  winsup/doc/posix.xml                |  2 ++
>  6 files changed, 32 insertions(+)
> 
> diff --git a/winsup/cygwin/cygwin.din b/winsup/cygwin/cygwin.din
> index efc750e83..95a21378b 100644
> --- a/winsup/cygwin/cygwin.din
> +++ b/winsup/cygwin/cygwin.din
> @@ -1530,9 +1530,11 @@ tcflush SIGFE
>  tcgetattr SIGFE
>  tcgetpgrp SIGFE
>  tcgetsid SIGFE
> +tcgetwinsize SIGFE
>  tcsendbreak SIGFE
>  tcsetattr SIGFE
>  tcsetpgrp SIGFE
> +tcsetwinsize SIGFE
>  tdelete SIGFE
>  tdestroy NOSIGFE
>  telldir SIGFE
> diff --git a/winsup/cygwin/fhandler/base.cc b/winsup/cygwin/fhandler/base.cc
> index e5e9f2325..0902bf0c2 100644
> --- a/winsup/cygwin/fhandler/base.cc
> +++ b/winsup/cygwin/fhandler/base.cc
> @@ -1333,6 +1333,8 @@ fhandler_base::ioctl (unsigned int cmd, void *buf)
>        break;
>      case FIONREAD:
>      case TIOCSCTTY:
> +    case TIOCGWINSZ:
> +    case TIOCSWINSZ:
>        set_errno (ENOTTY);
>        res = -1;
>        break;
> diff --git a/winsup/cygwin/include/sys/termios.h b/winsup/cygwin/include/sys/termios.h
> index d701e2f72..687fb92af 100644
> --- a/winsup/cygwin/include/sys/termios.h
> +++ b/winsup/cygwin/include/sys/termios.h
> @@ -301,6 +301,8 @@ speed_t cfgetospeed(const struct termios *);
>  int cfsetispeed (struct termios *, speed_t);
>  int cfsetospeed (struct termios *, speed_t);
>  int cfsetspeed (struct termios *, speed_t);
> +int tcgetwinsize(int fd, const struct winsize *winsz);
> +int tcsetwinsize(int fd, const struct winsize *winsz);
>  
>  #ifdef __cplusplus
>  }
> diff --git a/winsup/cygwin/termios.cc b/winsup/cygwin/termios.cc
> index 1dfd57079..6adf47497 100644
> --- a/winsup/cygwin/termios.cc
> +++ b/winsup/cygwin/termios.cc
> @@ -398,3 +398,15 @@ cfmakeraw(struct termios *tp)
>    tp->c_cflag &= ~(CSIZE | PARENB);
>    tp->c_cflag |= CS8;
>  }
> +
> +extern "C" int
> +tcgetwinsize (int fd, const struct winsize *winsz)
> +{
> +  return ioctl (fd, TIOCGWINSZ, winsz);
> +}
> +
> +extern "C" int
> +tcsetwinsize (int fd, const struct winsize *winsz)
> +{
> +  return ioctl (fd, TIOCSWINSZ, winsz);
> +}
> diff --git a/winsup/doc/new-features.xml b/winsup/doc/new-features.xml
> index 17c688f89..b3daabd50 100644
> --- a/winsup/doc/new-features.xml
> +++ b/winsup/doc/new-features.xml
> @@ -4,6 +4,18 @@
>  
>  <sect1 id="ov-new"><title>What's new and what changed in Cygwin</title>
>  
> +<sect2 id="ov-new3.6"><title>What's new and what changed in 3.6</title>
> +
> +<itemizedlist mark="bullet">
> +
> +<listitem><para>
> +New API calls: tcgetwinsize, tcsetwinsize.
> +</para></listitem>
> +
> +</itemizedlist>
> +
> +</sect2>
> +
>  <sect2 id="ov-new3.5"><title>What's new and what changed in 3.5</title>
>  
>  <itemizedlist mark="bullet">
> diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
> index eb5835c50..26d4fcfa4 100644
> --- a/winsup/doc/posix.xml
> +++ b/winsup/doc/posix.xml
> @@ -990,9 +990,11 @@ also IEEE Std 1003.1-2017 (POSIX.1-2017).</para>
>      tcgetattr
>      tcgetpgrp
>      tcgetsid
> +    tcgetwinsize
>      tcsendbreak
>      tcsetattr
>      tcsetpgrp
> +    tcsetwinsize
>      tdelete
>      telldir
>      tempnam
> -- 
> 2.45.1
