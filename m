Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id 9B4BB3972C1D
 for <cygwin-patches@cygwin.com>; Thu, 28 May 2020 14:45:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 9B4BB3972C1D
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MUXYs-1jVU3m0pu4-00QVsq for <cygwin-patches@cygwin.com>; Thu, 28 May 2020
 16:45:14 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id AD1F3A81006; Thu, 28 May 2020 16:45:13 +0200 (CEST)
Date: Thu, 28 May 2020 16:45:13 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Prevent meaningless ResizePseudoConsole()
 calls.
Message-ID: <20200528144513.GO6801@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200528134926.488-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200528134926.488-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:VpK8Di3XbMt834ghlrsYL/9ZhREHQk2R2f+mRL8kQBUHYYaext+
 V3bn1eKMvG94/w1sLjLoXYTHzQsz+viyIwNYRW1KrwEik/ZtkQi0mz2alm+rDXREmDThRPe
 KxUsdotMXRMrIFOOddzWaOXbEWUrhp2Qb93afvJwOw0ZLuz4fYZLlPhYmPIYamWreM35YQu
 o6BToX234d/t1jz8xlaBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DAEv+UDPF9Y=:L/vI/yHhPjnn1pyY+s9o42
 sUtz7R7hNO2EfrEoXiVcygGamanuru040mqU2BQmv7XBfkOasE6u1GX1+d3+w4SMcqqVFaXrJ
 Afd1HaH7oQFDp9QeZv4k6CwXbk/vM5n5pdaFVjwPfe/Hddy3LTkw1SqmFsj/L3KkrsSrXx9Q3
 h5xoamjfORHki4Ar/pV8yyxGnPOyLvKow77REkkhgxRAThNpggcbeX1R29k6Y+qD5qNd045Zg
 MbJAUHMFnk9kuQIX5yCUHYuI1dIshN6elc/ykyN/10Ero8OCiiD84aLbBWolKSs4/vwW0gGlR
 dOz/2wnzh/+iTYjsuu84+WXCY/J26KPhMsTJbWJQbnx/SOGA8B5AfjBz3lYnhaKgJ+1mtvSJy
 c0J+WgWcWF1r431KhdjNMCWHfJwxbRnEhU8tOBDTkUJGNlHcigLGzS8VBYdCfFkPqdLWihw/j
 7FG4Boh1UuAfuQyb5t/TLd/H+HwauMYk7IM2HxduaA/WXIGLuDgscbwgfk+x9uguCwSic+X7V
 L4ufpi4wXw7CLnFdDRt4B9jwgBONOZqYrdn0x9z4DqBXMK0P4q8scSDQZ0M/qwq22ShetLDR5
 tB174pKvX+kc6OJ3/djrtOsCbbkE7EQeOslIPOI6orA/oJ5rrE2bgCtSRXHRTLqUvIjIQv9n+
 iNFERYe/w0VyOAG9EWQPAJDr7+yjOC1sbnzgNQn7lmV2wJ8IJAD8y1yHWpob2TYnCYRVZXq2w
 rq+SctJBQ0z6U1HXvulWgPOBkAHY9dQalnhgZ+rfUHO8xt7Ah/8jmUaOtwWVeX7tZH64UDryn
 M71SmRFSNLYHSVNkc5mlwcvDDazvaky52YxNG3F2+Z1kbqI+vqtmgd2/SFx0s80lgG9go48
X-Spam-Status: No, score=-104.0 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 28 May 2020 14:45:17 -0000

On May 28 22:49, Takashi Yano via Cygwin-patches wrote:
> - This patch prevents to call ResizePseudoConsole() unless the pty
>   is resized.
> ---
>  winsup/cygwin/fhandler_tty.cc | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index f29a2c214..b091765b3 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -2615,18 +2615,18 @@ fhandler_pty_master::ioctl (unsigned int cmd, void *arg)
>        *(struct winsize *) arg = get_ttyp ()->winsize;
>        break;
>      case TIOCSWINSZ:
> -      /* FIXME: Pseudo console can be accessed via its handle
> -	 only in the process which created it. What else can we do? */
> -      if (get_pseudo_console () && get_ttyp ()->master_pid == myself->pid)
> -	{
> -	  COORD size;
> -	  size.X = ((struct winsize *) arg)->ws_col;
> -	  size.Y = ((struct winsize *) arg)->ws_row;
> -	  ResizePseudoConsole (get_pseudo_console (), size);
> -	}
>        if (get_ttyp ()->winsize.ws_row != ((struct winsize *) arg)->ws_row
>  	  || get_ttyp ()->winsize.ws_col != ((struct winsize *) arg)->ws_col)
>  	{
> +	  /* FIXME: Pseudo console can be accessed via its handle
> +	     only in the process which created it. What else can we do? */
> +	  if (get_pseudo_console () && get_ttyp ()->master_pid == myself->pid)
> +	    {
> +	      COORD size;
> +	      size.X = ((struct winsize *) arg)->ws_col;
> +	      size.Y = ((struct winsize *) arg)->ws_row;
> +	      ResizePseudoConsole (get_pseudo_console (), size);
> +	    }
>  	  get_ttyp ()->winsize = *(struct winsize *) arg;
>  	  get_ttyp ()->kill_pgrp (SIGWINCH);
>  	}
> -- 
> 2.26.2

Pushed.


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
