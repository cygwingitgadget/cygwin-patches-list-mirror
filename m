Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id CF7083852FC9; Tue, 17 Jun 2025 09:01:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CF7083852FC9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750150896;
	bh=VVqo8fMzh9OcqLKFfGMf2tiGgzlcBQsCj9eVM3rPgTM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=u4w0zorRhaYdWUc+4zNnUnCmjy4wBPkwbw/uNYzvu3zCelUc/3xA+Fplmj/CgtNmp
	 0rtvxNsHFTQUiHkbaTQutVqJekoGbO6xIFT/ZUHMMgVKI0j9EpYanAkySEOkcS8QDp
	 HDY2sI6dnK5/mrj3G8x0OJeX97MDoBHRbX8Y3xUY=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id AA48FA80961; Tue, 17 Jun 2025 11:01:34 +0200 (CEST)
Date: Tue, 17 Jun 2025 11:01:34 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Pavel Pavlov <pavlov.pavel@gmail.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: netdb.h: remove const from hostent.h_name
Message-ID: <aFEu7mYun-rDuil7@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Pavel Pavlov <pavlov.pavel@gmail.com>,
	cygwin-patches@cygwin.com
References: <CAG_s-qrP8XqJpuX4sEWOAS1xKHKBF=51325wTFE4-AmgKb-khQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG_s-qrP8XqJpuX4sEWOAS1xKHKBF=51325wTFE4-AmgKb-khQ@mail.gmail.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Pavel,

On May  5 22:28, Pavel Pavlov wrote:
> Hi,
> 
> The patch is self explanatory. This fixes errors/waring from hostent::h_name:
> 
> ```
> [6/14] Building C object CMakeFiles/http.dir/ext/c-ares/libcares.c.o
> In file included from /d/work-pps/ext/c-ares/libcares.c:26:
> /d/work-pps/ext/c-ares/src/lib/ares_free_hostent.c: In
> function ‘ares_free_hostent’:
> /d/work-pps/backtest-engine/ext/c-ares/src/lib/ares_free_hostent.c:41:17:
> warning: passing argument 1 of ‘ares_free’ discards ‘const’ qualifier
> from pointer target type [-Wdiscarded-qualifiers]
>    41 |   ares_free(host->h_name);
>       |             ~~~~^~~~~~~~
> ```
> 
> The patches to the Cygwin sources are under the 2-clause BSD license.

Thanks, but the patch is missing a fix for Cygwin itself:

winsup/cygwin/net.cc: In function ‘hostent* cygwin_gethostbyname(const char*)’:
winsup/cygwin/net.cc:841:24: error: invalid conversion from ‘const char*’ to ‘char*’ [-fpermissive]
  841 |           tmp.h_name = name;
      |                        ^~~~
      |                        |
      |                        const char*
make[4]: *** [Makefile:2123: net.o] Error 1

Would you mind to add this to your patch and also, please add a 
Signed-off-by:.


Thanks,
Corinna

