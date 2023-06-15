Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id C95823858C2F; Thu, 15 Jun 2023 07:11:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C95823858C2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1686813088;
	bh=Mm8Qq2MDQYGxsvi1JFE+NY0ygHfbmQsq/cvdGTyff4Q=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=oKp6eCzaY8RBRXaky7w6kKbou/JEpSzvauRw1La3c1MWPAv72yd5oJXNIfQWFJEA0
	 xIs5GxQnfCJCwUdOeINCl+jdQvtkPPxsoULVCCQp2Als4t1RxiZgEC4ldTkAYj62TH
	 KBjm5W2Ku+IExT5zwrAgqdumGAAqElt6OERdZgVw=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id BB389A80A70; Thu, 15 Jun 2023 09:11:26 +0200 (CEST)
Date: Thu, 15 Jun 2023 09:11:26 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Brian Inglis <Brian.Inglis@shaw.ca>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 3/3] fhandler/proc.cc: use wincap.has_user_shstk
Message-ID: <ZIq5ng7w4m8LDhA8@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Brian Inglis <Brian.Inglis@shaw.ca>,
	cygwin-patches@cygwin.com
References: <cover.1686095734.git.Brian.Inglis@Shaw.ca>
 <0afbace57b9ee469eb12fba773ef1347f24a8802.1686095734.git.Brian.Inglis@Shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0afbace57b9ee469eb12fba773ef1347f24a8802.1686095734.git.Brian.Inglis@Shaw.ca>
List-Id: <cygwin-patches.cygwin.com>

Hi Brian,

thanks, that looks good, except this single snippet:

On Jun  7 10:37, Brian Inglis wrote:
> ---
>  winsup/cygwin/fhandler/proc.cc | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler/proc.cc b/winsup/cygwin/fhandler/proc.cc
> index 3c79762e0fbd..2eaf436dc122 100644
> --- a/winsup/cygwin/fhandler/proc.cc
> +++ b/winsup/cygwin/fhandler/proc.cc
> @@ -1486,12 +1486,12 @@ format_proc_cpuinfo (void *, char *&destbuf)
>  
>  /*	  ftcprint (features1,  6, "split_lock_detect");*//* MSR_TEST_CTRL split lock */
>  
> -      /* cpuid 0x00000007 ecx & Windows [20]20H1/[20]2004+ */
> -      if (maxf >= 0x00000007 && wincap.osname () >= "10.0"
> -					 && wincap.build_number () >= 19041)
> +      /* Windows [20]20H1/[20]2004/19041 user shadow stack */
> +      if (maxf >= 0x00000007 && wincap.has_user_shstk)
                                   ^^^^^^^^^^^^^^^^^^^^^

wincapc::has_user_shstk is a method, accessing the wincaps::has_user_shstk
member.  The parens are missing.  Consequentially I see an error when
trying to build it:

  winsup/cygwin/fhandler/proc.cc:1490:40: error: invalid use of member ‘bool wincapc::has_user_shstk() const’ (did you forget the ‘&’ ?)
   1490 |       if (maxf >= 0x00000007 && wincap.has_user_shstk)
	|                                 ~~~~~~~^~~~~~~~~~~~~~
  make[4]: *** [Makefile:2068: fhandler/proc.o] Error 1


Thanks,
Corinna
