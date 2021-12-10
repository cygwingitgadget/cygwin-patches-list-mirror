Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
 [210.131.2.91])
 by sourceware.org (Postfix) with ESMTPS id 9CD8B3858014
 for <cygwin-patches@cygwin.com>; Fri, 10 Dec 2021 10:57:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 9CD8B3858014
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from Express5800-S70 (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id 1BAAukOl030400
 for <cygwin-patches@cygwin.com>; Fri, 10 Dec 2021 19:56:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 1BAAukOl030400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1639133806;
 bh=ZrC0fEfhYkV86aByB6mkSMHzJiwt0vhgfftxxhGJy/8=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=qHuzMQYGkaZFRanEv+j/YDcp/04V6sgva9b++zaFzmQVz786+7grP0i58U72kJ4Bw
 m7dSVIwJO5RIz1h+Q4FpQ5OO3NNFOLGe2Rl7ewib1gF7U0DpJSPuclPRVdsaQZzCyW
 2zXPrwmwPVTbsM6019YPfmkGr2juakG3Oe6NHeZg7l/u2G44FBclTCOTRHhRfwIyDd
 EYCpGYlef6R0axhbHAL8AfJ/gkaezgEusoGScHk9tB8dbC47FWKqvBBUAGi5Hxa3CR
 s9J9xdMfX+PlQP7HR1zCZ2fhbZ6CiWdcE70nWfu7jDeyDwKKBM/kOSY7oqazHvUD3U
 tSNaW3ysjf5mA==
X-Nifty-SrcIP: [110.4.221.123]
Date: Fri, 10 Dec 2021 19:56:47 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: clipboard: Make intent of the code clearer.
Message-Id: <20211210195647.d9977a915a6968de33726804@nifty.ne.jp>
In-Reply-To: <20211208122645.1278-1-takashi.yano@nifty.ne.jp>
References: <20211208122645.1278-1-takashi.yano@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Fri, 10 Dec 2021 10:57:08 -0000

On Wed,  8 Dec 2021 21:26:45 +0900
Takashi Yano wrote:
> ---
>  winsup/cygwin/fhandler_clipboard.cc   | 4 ++--
>  winsup/cygwin/include/sys/clipboard.h | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler_clipboard.cc b/winsup/cygwin/fhandler_clipboard.cc
> index 05f54ffb3..14820701c 100644
> --- a/winsup/cygwin/fhandler_clipboard.cc
> +++ b/winsup/cygwin/fhandler_clipboard.cc
> @@ -76,7 +76,7 @@ fhandler_dev_clipboard::set_clipboard (const void *buf, size_t len)
>        clipbuf->cb_sec  = clipbuf->ts.tv_sec;
>  #endif
>        clipbuf->cb_size = len;
> -      memcpy (&clipbuf[1], buf, len); // append user-supplied data
> +      memcpy (clipbuf->cb_data, buf, len); // append user-supplied data
>  
>        GlobalUnlock (hmem);
>        EmptyClipboard ();
> @@ -229,7 +229,7 @@ fhandler_dev_clipboard::read (void *ptr, size_t& len)
>        if (pos < (off_t) clipbuf->cb_size)
>  	{
>  	  ret = (len > (clipbuf->cb_size - pos)) ? clipbuf->cb_size - pos : len;
> -	  memcpy (ptr, (char *) (clipbuf + 1) + pos, ret);
> +	  memcpy (ptr, clipbuf->cb_data + pos, ret);
>  	  pos += ret;
>  	}
>      }
> diff --git a/winsup/cygwin/include/sys/clipboard.h b/winsup/cygwin/include/sys/clipboard.h
> index 4c00c8ea1..932fe98d9 100644
> --- a/winsup/cygwin/include/sys/clipboard.h
> +++ b/winsup/cygwin/include/sys/clipboard.h
> @@ -44,6 +44,7 @@ typedef struct
>      };
>    };
>    uint64_t      cb_size; // 8 bytes everywhere
> +  char          cb_data[];
>  } cygcb_t;
>  
>  #endif
> -- 
> 2.34.1

What should we do with this one?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
