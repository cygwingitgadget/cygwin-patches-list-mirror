Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by sourceware.org (Postfix) with ESMTPS id 9AF8A3857027
 for <cygwin-patches@cygwin.com>; Mon,  7 Dec 2020 09:41:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 9AF8A3857027
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N0FE1-1jylpc1Sh5-00xNhH for <cygwin-patches@cygwin.com>; Mon, 07 Dec 2020
 10:41:47 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 5D3D0A806B8; Mon,  7 Dec 2020 10:41:46 +0100 (CET)
Date: Mon, 7 Dec 2020 10:41:46 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix trace output for getdomainname()
Message-ID: <20201207094146.GH5295@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201204225801.48037-1-lavr@ncbi.nlm.nih.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201204225801.48037-1-lavr@ncbi.nlm.nih.gov>
X-Provags-ID: V03:K1:HrXFFfUCdCmBpQY55biWbAji5rZkh9SntJLCCx9oJe+UYvXKRTe
 N5BfRgzjNuUczyARKgR0+yng4repJzTQEfGxPqciVmR9rSZ1/12G7835I0OcPB9VLKGbW4m
 gzo/Et9/Ubgzew2Kl13o7RRBA8IxJ3/A8jbLY5dvaddcmSvMCeA4aNwT7S8wa4o1g/rhIdP
 1Zvhuazho60ILWFNL02sA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+cX6OEuxbMs=:/qIghC/daAMKsB82n1P0oK
 6H494P0sYgp78xAlxGsh1wwz9f7b+aJ1E+yRV/BLXvbH7Kn/dkzGJhwvUHKtnXiL1WjGvNqsZ
 PDosXVSCYtLVv6WGelXBrUYo9nU3PBv6MAr8PjTzQWi3hQ9Dx46KWOju+0A7Nqc4284gIQSZP
 8ipurzmLi6jRuxiaSI4quLJyZPfvA8jlAHH7H8hwEp7QwSis+eNvQPx03I7nVoaDuFGjd84m6
 zZPKcX1iz/Itux+QdAoK7aPaVcnFtVCQdQwsXGeo6n5JBnvDxfADWfcULsTChmwYr9Kx1g+/n
 xWYLmf3sL7Bx6pygJzK+tt1AM+z/ldAxcU925UmrPquRYaa7dDVmh2fU75rmnfZgDZejlI4kz
 jZMs+Us3V+TxVBIzq0uOQ6Y5LDJgHAfCjiSXXAJTcrzR4ulIJ4FpIwBzzaxOLNZQ9EXC5WXDZ
 3rZeQqww7Q==
X-Spam-Status: No, score=-106.7 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Mon, 07 Dec 2020 09:41:49 -0000

On Dec  4 17:58, Anton Lavrentiev via Cygwin-patches wrote:
> ---
>  winsup/cygwin/net.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/net.cc b/winsup/cygwin/net.cc
> index 724e787fe..cec0a70cc 100644
> --- a/winsup/cygwin/net.cc
> +++ b/winsup/cygwin/net.cc
> @@ -772,7 +772,7 @@ getdomainname (char *domain, size_t len)
>  	  && GetNetworkParams(info, &size) == ERROR_SUCCESS)
>  	{
>  	  strncpy(domain, info->DomainName, len);
> -	  debug_printf ("gethostname %s", domain);
> +	  debug_printf ("getdomainname %s", domain);
>  	  return 0;
>  	}
>        __seterrno ();
> -- 
> 2.29.2

Pushed

Thanks,
Corinna
