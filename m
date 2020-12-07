Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by sourceware.org (Postfix) with ESMTPS id 94A543896C21
 for <cygwin-patches@cygwin.com>; Mon,  7 Dec 2020 09:36:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 94A543896C21
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MjjKf-1kJiYR0mvT-00lGuw for <cygwin-patches@cygwin.com>; Mon, 07 Dec 2020
 10:36:04 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 8D079A806B8; Mon,  7 Dec 2020 10:36:03 +0100 (CET)
Date: Mon, 7 Dec 2020 10:36:03 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Allow to set SO_PEERCRED zero
Message-ID: <20201207093603.GF5295@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201207062850.1088-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201207062850.1088-1-mark@maxrnd.com>
X-Provags-ID: V03:K1:W2OuefPsQ2nZzMQzm0yD8SqEDbT5Q2P5+RG/1rImWDhfT9mYdDB
 CbOs6YJ1H42A8Ku/pgij7kYukz9ew+lYZLk7v63N0tV9rsQbkpx0Fw6NciklwRNmUsswNAh
 h+xeglWE93pRGNhXwgVt1fPS4ZKXZGWVNV2S/mD0low2siYPoKLbXd+uK3U+GDZMbpHOOtq
 CwZQzEIQy79rYa6abF3GA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pKw2Nv00h2g=:riVV9Jz/P5/SJ/QRXWe3Z8
 dog5A211OSzsJaydl10iknMYpgR2ENfWcnOux1m/wnXXnSGU3eOfhF6TlsAMOD2i8AgsvZA6d
 Tb2zQveHG35tyJeLmF2sDRjKyuoVTk96rzq2ylzZP56RdguWfbXFzbNVsqz+E13/GuSutzVdq
 oOEGtW6t79+20sDT4A2tQqc2EpaOkpO+fd6yTZagzMku1nQ1LnWKPZNbEpFtUTEGyXQcyNhXT
 qLNpreBnjQj5+feJ8P1VZZjXW0fWzkQY923lqwymVfGqfp1HnBjzBUYCYOnSEB6hqpTFIUYyk
 GxMedGkumOWYCrQ8DIwcOZEv3R3ZPa9j77yStJxwwbwy5X2BzfiV5lP3hzc5xNOe1HdWEietw
 hruCjkQRSu1AzBVQPfCTbqqv/qMho25uDfcAJa/Dd6fv7DQlM0rHXAZu9HZcnigcnp/vnl64i
 li8wS46ehA==
X-Spam-Status: No, score=-106.4 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Mon, 07 Dec 2020 09:36:10 -0000

Hi Mark,

On Dec  6 22:28, Mark Geisert wrote:
> The existing code errors as EINVAL any attempt to set a value for
> SO_PEERCRED via setsockopt() on an AF_UNIX/AF_LOCAL socket.  But to
> enable the workaround set_no_getpeereid behavior for Python one has
> to be able to set SO_PEERCRED to zero.  Ergo, this patch.  Python has
> no way to specify a NULL pointer for 'optval'.
> 
> ---
>  winsup/cygwin/fhandler_socket_local.cc | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/fhandler_socket_local.cc b/winsup/cygwin/fhandler_socket_local.cc
> index c94bf828f..421b8bbdb 100644
> --- a/winsup/cygwin/fhandler_socket_local.cc
> +++ b/winsup/cygwin/fhandler_socket_local.cc
> @@ -1430,7 +1430,8 @@ fhandler_socket_local::setsockopt (int level, int optname, const void *optval,
>  	     FIXME: In the long run we should find a more generic solution
>  	     which doesn't require a blocking handshake in accept/connect
>  	     to exchange SO_PEERCRED credentials. */
> -	  if (optval || optlen)
> +	  /* Temporary: Allow only '(int) 0' to be specified. */
> +	  if (optlen < (socklen_t) sizeof (int) || 0 != *(int *) optval)
>  	    set_errno (EINVAL);

That breaks existing callers calling setsockopt like this:

  setsockopt (fd, SOL_SOCKET, SO_PEERCRED, NULL, 0);

This should stay backward-compatible.  It should allow the above
as well as your int usage, otherwise postfix will stop working.

Also, please write either

  *(int *) optval != 0

or just

  !!*(int *) optval


Thanks,
Corinna
