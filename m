Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id 94F37386F455
 for <cygwin-patches@cygwin.com>; Thu, 27 Aug 2020 08:49:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 94F37386F455
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MowX2-1kyGGF18Aw-00qVNv for <cygwin-patches@cygwin.com>; Thu, 27 Aug 2020
 10:49:53 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id D7E53A83A77; Thu, 27 Aug 2020 10:49:52 +0200 (CEST)
Date: Thu, 27 Aug 2020 10:49:52 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: fhandler_fifo::delete_client_handler: improve
 efficiency
Message-ID: <20200827084952.GW3272@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200827020311.5450-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200827020311.5450-1-kbrown@cornell.edu>
X-Provags-ID: V03:K1:1+TkjgqiXogKsEgNBgBFdhfF15Zy8XgFoPHK+M3XhtDnU0mBZ89
 UT4dlRaTp9iGxpfwzwwuZtYo70VVQ5guLU+CQxYL343X/LLeCgI+1mOxu3oHAA7IAbMl57n
 VmPpX4/j3RqkJIndnM6//p46OowzhA8RW/U5zYFGjr+GYDCztT3F0iMVwNCpA7iaLevtbXi
 eEKHPrsnGRoXtt9BZds2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:a7Lf/HutsFk=:ryqhUah6C4mp+hP7DTlb1j
 Qqa7l3Y1Vw/h1y9kKAgFH6jB2mfje/029XRo0doWfcMvsPmCnJZZ9/gZrQv0+fsFq98WPsUjW
 a2+ax4TQNaQF/LUsmklQ2zYK7mZWe+QtmKDNLhFn8fUSA59gUVKOEYxb4kq+mhgxrLBJAxJQN
 VtWL9IDDPNE8KWMbR9cL+q9Td9vhww/X/iDMKK9h5fXW0qsU6doMvVaduGSwb5Uc0MMTF+s00
 5uf6fMiYjriB0MLM6qnoYfC6dDc+56APpfCVwUwu8tjf4QKHGfZrw6+rJmUVIVacu9qgFnJ0u
 b1XpmAmbJNUWAicoOFtVruM4ccax+5h2iI8UBnP8H/RRZ105BwXo4fB4hPkn4pTXYoSZGZfO4
 UrIcHiHLWljtAS1CVEVGYQmoN0HyM8MjtkRe8BVda2mQh6hNCazvtSwleUZnkaaXx+6lg4hzv
 Ksq5WftgWsot8vLU1T4Y3gJ5/skDkLUaC6cNncJB1JL3AhMhlE41cFM00XgpQssJFC9uPR9Jw
 ZQ6t2ZrbJWxHOVUVZBJc+qKRQ0rj+rRxkv48fMsqL7XNjV1iHwJgWIHqO20+n7z6Dm0uwh2We
 TdXC66z6pKru2krHq9uHQoCE//z6SFwWOxia3kXSXvWQRfM4ecL985rey3gNiLeQAP3WDX7Q2
 9hJu/U4McoffJVS8niY//qUZZH8EGla2naxsMXYKrQny+99B1SqI5RB6JK3Ogu9La0gXWb/gm
 hjCRIwcsgvMp2qNKcU2O1ZX4l4xthfnovSmL88kHzXc/V1XLeQAsGTjq4iBm+515SOS35Vpo5
 x2lhvvPSKy1rgXA+vgIug+mQPQKL2thryJ5qtCbfJ0WuZkojlfN0WCY8LT2uRN+w2uAIJEg4s
 BmKEle4FQvBZJlUj299w==
X-Spam-Status: No, score=-104.8 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 27 Aug 2020 08:49:55 -0000

On Aug 26 22:03, Ken Brown via Cygwin-patches wrote:
> Delete a client handler by swapping it with the last one in the list
> instead of calling memmove.
> ---
>  winsup/cygwin/fhandler_fifo.cc | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
> index b3c4c4a25..75c8406fe 100644
> --- a/winsup/cygwin/fhandler_fifo.cc
> +++ b/winsup/cygwin/fhandler_fifo.cc
> @@ -377,14 +377,14 @@ fhandler_fifo::add_client_handler (bool new_pipe_instance)
>    return 0;
>  }
>  
> -/* Always called with fifo_client_lock in place. */
> +/* Always called with fifo_client_lock in place.  Delete a
> +   client_handler by swapping it with the last one in the list. */
>  void
>  fhandler_fifo::delete_client_handler (int i)
>  {
>    fc_handler[i].close ();
>    if (i < --nhandlers)
> -    memmove (fc_handler + i, fc_handler + i + 1,
> -	     (nhandlers - i) * sizeof (fc_handler[i]));
> +    fc_handler[i] = fc_handler[nhandlers];
>  }
>  
>  /* Delete handlers that we will never read from.  Always called with
> -- 
> 2.28.0

Yup, please push.


Thanks,
Corinna
