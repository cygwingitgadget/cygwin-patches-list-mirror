Return-Path: <cygwin-patches-return-9288-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 87096 invoked by alias); 31 Mar 2019 15:48:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 86927 invoked by uid 89); 31 Mar 2019 15:48:34 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE,URIBL_BLOCKED autolearn=ham version=3.3.1 spammy=corresponding, adopted
X-HELO: conuserg-03.nifty.com
Received: from conuserg-03.nifty.com (HELO conuserg-03.nifty.com) (210.131.2.70) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 31 Mar 2019 15:48:29 +0000
Received: from localhost.localdomain (ntsitm424054.sitm.nt.ngn.ppp.infoweb.ne.jp [219.97.74.54]) (authenticated)	by conuserg-03.nifty.com with ESMTP id x2VFm0US009284;	Mon, 1 Apr 2019 00:48:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-03.nifty.com x2VFm0US009284
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1554047286;	bh=xUAhSbaCOzlg3ZYdM5/7pkmyN0rlZnpGUYjN3Hv9WsE=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=Iql0y99/Y7t33SjIWh4y/wL12CF6nHHxQHVd4WA6vbqdpB6nnBSHujsOhuj90yvhl	 dJJirnQsAep/jl5Fmcvb+ph0tuPVQ+l/tXpH9MvHVeYXu//xeUrqhFnDAbCwaCdm2+	 mDveIhqehJQazoL5yfaRd0w5S5miQUH+lEWqT7rK5E2fy0zC8rhab+D6FWJVaUGJ3a	 kE7sc5iUBqtxdMzzCoAmPImla67nCmxX9wxQNMWQ4GoVO6M6Pj/Ii7KlghD0NfFQNJ	 EzOYlgRLGxmG6WT6vuJzAhQM1H3RI7M3u/VzkCfdWrOF3Qn9UastRtZgkfnQIVbhOR	 26xQO7mr77ciA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v3 0/3] Reworks for console code
Date: Sun, 31 Mar 2019 15:48:00 -0000
Message-Id: <20190331154748.1957-1-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190331143651.GF3337@calimero.vinschen.de>
References: <20190331143651.GF3337@calimero.vinschen.de>
X-IsSubscribed: yes
X-SW-Source: 2019-q1/txt/msg00098.txt.bz2

Hi Corinna,

On Sun, 31 Mar 2019 16:36:51 +0200 Corinna Vinschen rote:
> This hunk is ok, but I wonder if the time hasn't come to simplify the
> original code.  The `static char NO_COPY' only makes marginal sense
> since it's strdup'ed anyway.
> 
> What if we just define two const char's like this
> 
>   const char cygterm[] = "TERM=cygwin";
>   const char xterm[] = "TERM=xterm-256color";
> 
> and then just strdup them conditionally:
> 
>   if (!sawTERM)
>     envp[i++] = strdup (wincap.has_con_24bit_colors () ? xterm :
> cygterm);
> 
> What do you think?

> Sorry, didn't notice this before:  Please prepend this block with
> a comment along the lines of "/* Not yet defined in Mingw-w64 */"

Adopted.

> Doesn't this belong into the select patch?

Actually, no. This makes select() recognize Ctrl-space, but
is just tentative. Patch 0002 overwrites this fix.

This is corresponding to:
> @@ -435,7 +451,8 @@ fhandler_console::read (void *pv, size_t& buflen)
>  	      toadd = tmp;
>  	    }
>  	  /* Allow Ctrl-Space to emit ^@ */
> -	  else if (input_rec.Event.KeyEvent.wVirtualKeyCode == VK_SPACE
> +	  else if (input_rec.Event.KeyEvent.wVirtualKeyCode
> +		   == (wincap.has_con_24bit_colors () ? '2' : VK_SPACE)
>  		   && (ctrl_key_state & CTRL_PRESSED)
>  		   && !(ctrl_key_state & ALT_PRESSED))
>  	    toadd = "";

Takashi Yano (3):
  Cygwin: console: support 24 bit color
  Cygwin: console: fix select() behaviour
  Cygwin: console: Make I/O functions thread-safe

 winsup/cygwin/environ.cc          |    7 +-
 winsup/cygwin/fhandler.h          |   34 +-
 winsup/cygwin/fhandler_console.cc | 1154 +++++++++++++++++++----------
 winsup/cygwin/select.cc           |   90 +--
 winsup/cygwin/wincap.cc           |   10 +
 winsup/cygwin/wincap.h            |    2 +
 6 files changed, 840 insertions(+), 457 deletions(-)

-- 
2.17.0
