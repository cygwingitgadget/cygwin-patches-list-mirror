Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id BB1283896C1D
 for <cygwin-patches@cygwin.com>; Mon,  7 Dec 2020 15:30:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org BB1283896C1D
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MAPBF-1kse8P1am3-00Bq9n for <cygwin-patches@cygwin.com>; Mon, 07 Dec 2020
 16:30:26 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id CB6ECA80668; Mon,  7 Dec 2020 16:30:25 +0100 (CET)
Date: Mon, 7 Dec 2020 16:30:25 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Allow to set SO_PEERCRED zero (v2)
Message-ID: <20201207153025.GJ5295@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201207102936.1527-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201207102936.1527-1-mark@maxrnd.com>
X-Provags-ID: V03:K1:+NZ2pEYXzOCePYmGPsRyTnzajzLKpSZg/SSWCAioegXPXTPB8GP
 C1nOTh/BEIoJBz4Zj08euSNdmUI6glwFUVtazaQOotoU4l5MEYUv/za7jTRByO68DR/w8bl
 yqDb/Cg0vSbKqXYgPJgVZtlchdRYN/L687YzVLoJR2g5l4pC7uAwXT+lAm0xuhUIC/1+E/q
 PZk/fXn+5B7h7yef+l6AQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:H+2VI/QcQk8=:JQi3qIAM6z18BL3ck4Tqbl
 A4TsTnoIR71Y9QH7WxGqkU3OTCFbWFmWFeJNkVHjZ1BLB+4+WGFMGSnBX7TP2Hhqh/u7DZZwl
 DnQzyuulodGrOze6Z0Vh/JnVdzIuIvowAGOYkcGlwXq3iKoB4NmXdEWHrhLhlYKpXNm2Wl42T
 LYCcjuN/A0n2yjtgaU/As2cdEU15at+wmJL/qrHbtnXYZD+Dhl+O+44Hz9r/bndv9VBYW+qWV
 rfQjkTjnog6buaObRAbEv6vtT65p4dBeB+VOrIQaQsHQSkF5FxrdyDJYK/K4EeGCKZb+wADxj
 cL1cOemnqXdVpumym/uRXeo8OlmQ+o9whVEFaRZu3fr4DEL4k3LbOvRF/emRR1PZ3VXQxtx8n
 pNw9eJ2l0yBkPQ9OUJ6xamlqoFxFcOh8c3XhxgKZfjq67asUyYuC7lDCYLyxzg+hnuNjosKsi
 qaURDwbk3w==
X-Spam-Status: No, score=-106.5 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
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
X-List-Received-Date: Mon, 07 Dec 2020 15:30:32 -0000

On Dec  7 02:29, Mark Geisert wrote:
> The existing code errors as EINVAL any attempt to set a value for
> SO_PEERCRED via setsockopt() on an AF_UNIX/AF_LOCAL socket.  But to
> enable the workaround set_no_getpeereid behavior for Python one has
> to be able to set SO_PEERCRED to zero.  Ergo, this patch.  Python has
> no way to specify a NULL pointer for 'optval'.
> 
> This v2 of patch allows the original working (i.e., allow NULL,0 for
> optval,optlen to mean turn off SO_PEERCRED) in addition to the new
> working described above.  The sense of the 'if' stmt is reversed for
> readability.
> 
> ---
>  winsup/cygwin/fhandler_socket_local.cc | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler_socket_local.cc b/winsup/cygwin/fhandler_socket_local.cc
> index c94bf828f..964f3e819 100644
> --- a/winsup/cygwin/fhandler_socket_local.cc
> +++ b/winsup/cygwin/fhandler_socket_local.cc
> @@ -1430,10 +1430,14 @@ fhandler_socket_local::setsockopt (int level, int optname, const void *optval,
>  	     FIXME: In the long run we should find a more generic solution
>  	     which doesn't require a blocking handshake in accept/connect
>  	     to exchange SO_PEERCRED credentials. */
> -	  if (optval || optlen)
> -	    set_errno (EINVAL);
> -	  else
> +	  /* Temporary: Allow SO_PEERCRED to only be zeroed. Two ways to
> +	     accomplish this: pass NULL,0 for optval,optlen; or pass the
> +	     address,length of an '(int) 0' set up by the caller. */
> +	  if ((!optval && !optlen) ||
> +		(optlen == (socklen_t) sizeof (int) && !*(int *) optval))
>  	    ret = af_local_set_no_getpeereid ();
> +	  else
> +	    set_errno (EINVAL);
>  	  return ret;
>  
>  	case SO_REUSEADDR:
> -- 
> 2.29.2

Pushed


Thanks,
Corinna
