Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id 3196D385783A
 for <cygwin-patches@cygwin.com>; Tue,  8 Sep 2020 19:13:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 3196D385783A
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MHX3R-1kJrnS3v9t-00DU1g for <cygwin-patches@cygwin.com>; Tue, 08 Sep 2020
 21:13:11 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 54B56A83A8D; Tue,  8 Sep 2020 21:13:11 +0200 (CEST)
Date: Tue, 8 Sep 2020 21:13:11 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Cygwin: format_process_fd: add directory check
Message-ID: <20200908191311.GR4127@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200908165048.47566-1-kbrown@cornell.edu>
 <20200908165048.47566-2-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200908165048.47566-2-kbrown@cornell.edu>
X-Provags-ID: V03:K1:B5ptuapMArz1Nk6lqCGLGZuf+bpHGuR8nG7ZFcXAd5hvDOXpz0m
 OOe7N16RGzyYO6kLjmL5K8i1qXt7SiohEMkkpWj4Gx2md6DFNouvvAve1Xg7/e6bUs9zk7S
 US/SDXxZyLJD2rx5tyZtXpmK0UJpaXM0AknbqeQNI4VQJr5Ph9qbFehyvBYYRXKH0K7vHYY
 dey7WNoEQbZxoSUYOicig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c8DTCBfhuLw=:17nSVvgproxeier6zXM7mE
 /wpCm9BPSkmY8JwduE5FE0dShSUbxRTiQvK5u/8+jTYbkwebcSUK9zxKoVrtmV5al2BuykNf1
 nIAWOKktcV3aEqpBC9x2YIQPpUqNr3+cDtQH+89J6TqXxexHID5XIJktBPOuzoo7c/JaxhWKX
 nH5AO0j6qfHF2N5tYRVQxbhd9gK5A0XrBO6l7vcCprTGAxZfCuBjJ1nhqoQpIsKyVijODx+Em
 qDa0f0N/FVKigvtkCS0IRVEtvGxvWJgP+ifAnYd/XwSeY+D3+H06Ac/h0MU0RjpQlDTOJ9LIP
 wOJRmx+MgJEvsZrlzyTdWUAPkSXplM8Jtl4cd/DBPTTLHuYSUqIbPtpTUXFfs0HX6b0xXtKEu
 EQ/HzVHCJ4DfCreLEND50sNTdXL2eJYzSXAOMLP8YFWqidE9nkth7WZWEerK2xOSb3wFFwInv
 JZ5uc93lRcLFMLFJSWirnMzIML/5+PhKSGaZLC4UnEQrsasBRiLPSXftqq7pr2xpuiRnAcBiV
 yepCy0UWLnHhsDxbqLU68G5L3ZcANq14d0ymwQi8v5Vlcmz/aGhjnftb6TYTy3qteKq332V2b
 JverdJ7nKsS0hxESDVG8I5kDKhb/70UBev++e5bKjcb609+neLpRz6s1gEzWH7OYMJ90mdroI
 J+ltkR6xpXlCAANWeLcdal+Ctpu014KSjGdy/CdjnBEtdeFiAALFLgMmmhG6bAFe1TX2gr45a
 X6ad+YJ/NLZlcAvONrInckw0ZEh0QwrAFE0kfD0UtCjr3l9gpRn6ePWr/aRh/ASmOoQx9YkM4
 EVI3UjRbK0pMXRSNqlA0j1S/SUKzz/aCOpHp+JqpW/VFJuEZHzR4cLUDGP6ylW83g+iPFTz/s
 8YuzaXrBUgr78AWOamtw==
X-Spam-Status: No, score=-105.3 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Tue, 08 Sep 2020 19:13:14 -0000

Hi Ken,

On Sep  8 12:50, Ken Brown via Cygwin-patches wrote:
> The incoming path is allowed to have the form "$PID/fd/[0-9]*/.*"
> provided the descriptor symlink points to a directory.  Check that
> this is indeed the case.
> ---
>  winsup/cygwin/fhandler_process.cc | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/winsup/cygwin/fhandler_process.cc b/winsup/cygwin/fhandler_process.cc
> index a6c358217..888604e3d 100644
> --- a/winsup/cygwin/fhandler_process.cc
> +++ b/winsup/cygwin/fhandler_process.cc
> @@ -398,6 +398,21 @@ format_process_fd (void *data, char *&destbuf)
>  	*((process_fd_t *) data)->fd_type = virt_fdsymlink;
>        else /* trailing path */
>  	{
> +	  /* Does the descriptor link point to a directory? */
> +	  bool dir;
> +	  if (*destbuf != '/')	/* e.g., "pipe:[" or "socket:[" */
> +	    dir = false;
> +	  else
> +	    {
> +	      path_conv pc (destbuf);
> +	      dir = pc.isdir ();
> +	    }
> +	  if (!dir)
> +	    {
> +	      set_errno (ENOTDIR);
> +	      cfree (destbuf);
> +	      return -1;
> +	    }
>  	  char *newbuf = (char *) cmalloc_abort (HEAP_STR, strlen (destbuf)
>  							   + strlen (e) + 1);
>  	  stpcpy (stpcpy (newbuf, destbuf), e);
> -- 
> 2.28.0

Huh, I'd never realized this check is missing.  I was just puzzeling
over your patch, searching for the directory check, but yeah, there is
none.  Please push.


Thanks,
Corinna
