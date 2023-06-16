Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 81EA73858431; Fri, 16 Jun 2023 08:28:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 81EA73858431
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1686904118;
	bh=YkIRqzFrkoK4HOUDsSIrDoDbK+xrdGP7sGcg7mlixUs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Zo0N3+7bU0d3uG8UAe8woOlc+P7NUQbYg2vLKyOCBeIleWnybNiaYGZBttzYtAjtI
	 CIN2RKesuVw/qIs8G9Mo1vCtpruZqx2Xa4CUIol5JqqfQgPRWnkmwt/YYwC595N1j8
	 2FuL7jylF0S4NL67kFPNNCzG0vI1Mu6Qwcdkj2kM=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id DA197A80B72; Fri, 16 Jun 2023 10:28:34 +0200 (CEST)
Date: Fri, 16 Jun 2023 10:28:34 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Brian Inglis <Brian.Inglis@shaw.ca>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 3/3] fhandler/proc.cc: use wincap.has_user_shstk
Message-ID: <ZIwdMlYULG/AHRC8@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Brian Inglis <Brian.Inglis@shaw.ca>,
	cygwin-patches@cygwin.com
References: <cover.1686095734.git.Brian.Inglis@Shaw.ca>
 <0afbace57b9ee469eb12fba773ef1347f24a8802.1686095734.git.Brian.Inglis@Shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0afbace57b9ee469eb12fba773ef1347f24a8802.1686095734.git.Brian.Inglis@Shaw.ca>
List-Id: <cygwin-patches.cygwin.com>

Hi Brain,


thanks for the patch. Sorry to hassle you again, but I forget to mention
this yesterday and I'm still only partially available.  So, here goes:

It would be really great if you could resend your patchset with three
changes in the commit message:

- For obvious reasons, the message text in your cover message won't make
  it into the git repo.  However, the commit messages in git should
  reflect why the change was made, so a future interested reader has
  a chance to understand why a change was made.

- As I already mentioned a couple of times on this list (but not
  lately), it would be great if you could always add a "Signed-off-by:"
  line.

- Also, given this patch fixes an earlier patch, it should contain
  a line

    Fixes: <12-digit-SHA1> ("commit headline")

  In this case, patch 3 of the series should contain

    Fixes: 41fdb869f998 ("fhandler/proc.cc(format_proc_cpuinfo): Add Linux 6.3 cpuinfo")


Thanks,
Corinna


On Jun 15 18:16, Brian Inglis wrote:
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
> +      if (maxf >= 0x00000007 && wincap.has_user_shstk ())
>          {
> +	  /* cpuid 0x00000007 ecx CET shadow stack */
>  	  cpuid (&unused, &unused, &features1, &unused, 0x00000007, 0);
> -	  ftcprint (features1,  7, "user_shstk");	/* "user shadow stack" */
> +	  ftcprint (features1,  7, "user_shstk");	/* user shadow stack */
>  	}
>  
>        /* cpuid 0x00000007:1 eax */
> -- 
> 2.39.0
