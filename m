Return-Path: <cygwin-patches-return-1848-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17408 invoked by alias); 7 Feb 2002 13:58:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17307 invoked from network); 7 Feb 2002 13:58:39 -0000
Date: Thu, 07 Feb 2002 06:04:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Tokenring support for network interfaces
Message-ID: <20020207145837.Y14241@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.LNX.4.21.0202062016350.1196-300000@lupus.ago.vpn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0202062016350.1196-300000@lupus.ago.vpn>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q1/txt/msg00205.txt.bz2

On Wed, Feb 06, 2002 at 08:18:58PM +0100, Alexander Gottwald wrote:
> Hi, the patch adds support for enumerating tokenring network interfaces.

It does so for systems with IPHelper Lib only, unfortunately.
Do you also have a way to add it for the rest of the crowd?

Corinna
> 
> bye
>     ago
> -- 
>  Alexander.Gottwald@informatik.tu-chemnitz.de 
>  http://www.gotti.org           ICQ: 126018723
>  phone: +49 3725 349 80 80	mobile: +49 172 7854017
>  4. Chemnitzer Linux-Tag http://www.tu-chemnitz.de/linux/tag/lt4

> 2002-02-06  Alexander Gottwald <Alexander.Gottwald@s1999.tuchemnitz.de>
> 
>     * net.cc (get_2k_ifconf): Create interface entries for tokenring cards.

> --- net.cc	Wed Feb  6 20:10:34 2002
> +++ net.cc.new	Wed Feb  6 20:10:22 2002
> @@ -1652,7 +1652,7 @@ static void
>  get_2k_ifconf (struct ifconf *ifc, int what)
>  {
>    int cnt = 0;
> -  char eth[2] = "/", ppp[2] = "/", slp[2] = "/", sub[2] = "0";
> +  char eth[2] = "/", ppp[2] = "/", slp[2] = "/", sub[2] = "0", tok[2] = "/";
>  
>    /* Union maps buffer to correct struct */
>    struct ifreq *ifr = ifc->ifc_req;
> @@ -1685,6 +1685,11 @@ get_2k_ifconf (struct ifconf *ifc, int w
>  		  /* Setup the interface name */
>  		  switch (ift->table[if_cnt].dwType)
>  		    {
> +		      case MIB_IF_TYPE_TOKENRING:
> +			  ++*tok;
> +			strcpy (ifr->ifr_name, "tok");
> +			strcat (ifr->ifr_name, tok);
> +			break;
>  		      case MIB_IF_TYPE_ETHERNET:
>  			if (*sub == '0')
>  			  ++*eth;


-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
