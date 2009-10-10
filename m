Return-Path: <cygwin-patches-return-6756-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11395 invoked by alias); 10 Oct 2009 10:08:48 -0000
Received: (qmail 11384 invoked by uid 22791); 10 Oct 2009 10:08:47 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 10 Oct 2009 10:08:43 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 2778A6D5598; Sat, 10 Oct 2009 12:08:31 +0200 (CEST)
Date: Sat, 10 Oct 2009 10:08:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Allow to disable root privileges with CYGWIN=noroot
Message-ID: <20091010100831.GA13581@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4A999EC2.2070801@t-online.de> <20090830090314.GB2648@calimero.vinschen.de> <4A9AD529.3060107@t-online.de> <20090901183209.GA14650@calimero.vinschen.de> <20091004123006.GF4563@calimero.vinschen.de> <20091004125455.GG4563@calimero.vinschen.de> <4AC8F299.1020303@t-online.de> <20091004195723.GH4563@calimero.vinschen.de> <20091004200843.GK4563@calimero.vinschen.de> <4ACFAE4D.90502@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ACFAE4D.90502@t-online.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00087.txt.bz2

On Oct  9 23:42, Christian Franke wrote:
> Corinna Vinschen wrote:
>> ...and maybe it's time to create a cygwin_internal call which replaces
>> cygwin_set_impersonation_token and deprecate cygwin_set_impersonation_token
>> in the long run.  So, instead of the above we could have this call
>> taking a HANDLE and a BOOL value:
>>
>>   cygwin_internal (CW_SET_EXTERNAL_TOKEN, token_handle, restricted?);
>>
>>
>>   
>
> Attached a patch (based on your patch) which works for me on XP SP3.

Thanks for the patch.  You did check that the normal setuid/seteuid
cases still work, didn't you?

> I would suggest to add another cygwin_internal() call to check if current 
> process is considered 'equivalent root'. This could be used e.g. by shells 
> to set the root prompt properly.
> http://sourceware.org/ml/cygwin/2009-09/msg00138.html

What's wrong with:

  for i in $(id -G);
  do
    [ $i -eq 544 ] && PS1='# '
  done

The patch looks pretty good.  I have a few remarks, though.

> diff --git a/winsup/cygwin/external.cc b/winsup/cygwin/external.cc
> index 38b8c71..9b030c9 100644
> --- a/winsup/cygwin/external.cc
> +++ b/winsup/cygwin/external.cc
> @@ -413,6 +413,15 @@ cygwin_internal (cygwin_getinfo_types t, ...)
>  	  int useTerminateProcess = va_arg (arg, int);
>  	  exit_process (status, !!useTerminateProcess); /* no return */
>  	}
> +      case CW_SET_EXTERNAL_TOKEN:
> +	{
> +	  HANDLE token = va_arg (arg, HANDLE);
> +	  int type = va_arg (arg, int);
> +	  cygheap->user.external_token = (token == INVALID_HANDLE_VALUE
> +	      ? NO_IMPERSONATION : token);
> +	  cygheap->user.ext_token_is_restricted = (type == CW_TOKEN_RESTRICTED);
> +	}
> +	break;

I would like it better to have the actual functionality concentrated in
a function in sec_auth.cc.  A function `set_imp_token (HANDLE, int)'
which is called from cygwin_internal and from cygwin_set_impersonation_token,
for instance.  The debug output in cygwin_set_impersonation_token should
be moved into set_imp_token, too.  What do you think?

> diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
> index 49ff2e1..5ae69c7 100644
> --- a/winsup/cygwin/fork.cc
> +++ b/winsup/cygwin/fork.cc
> @@ -188,7 +188,10 @@ frok::child (volatile char * volatile here)
>  
>    set_cygwin_privileges (hProcToken);
>    clear_procimptoken ();
> -  cygheap->user.reimpersonate ();
> +
> +  if (!cygheap->user.reimpersonate ())
> +    /* User possibly set an external token without HANDLE_FLAG_INHERIT.  */
> +    api_fatal ("reimpersonate after fork failed (%d)", (int)GetLastError());

This bugs me.  Wouldn't it be better if we call DuplicateHandleEx
on the external token to make sure it's inheritable?  This would also
require to call CloseHandle on an existing external token if
a process calls cygwin_set_impersonation_token (INVALID_HANDLE_VALUE) or
INVALID_HANDLE_VALUE (NULL), but that's not really much extra code to
worry about.  Dropping any chance that fork or exec fail sounds worth
it, IMHO.  I'm still blushing that this never occured to me before.

> @@ -2686,6 +2707,21 @@ seteuid32 (__uid32_t uid)
>    cygheap->user.deimpersonate ();
>  
>    /* Verify if the process token is suitable. */
> +  /* First of all, skip all checks if a switch to a restricted token has been
> +     requested, or if trying to switch back from it. */
> +  if (request_restricted_uid_switch)
> +    {
> +      if (cygheap->user.external_token != NO_IMPERSONATION)
> +	{
> +	  debug_printf ("Switch to restricted token");
> +	  new_token = cygheap->user.external_token;
> +	}
> +      else
> +	{
> +	  debug_printf ("Switch back from restricted token");
> +	  new_token = hProcToken;

This should make sense here:

          cygheap->user.ext_token_is_restricted = false;

That will make sure the seteui32 function will not do this twice if
seteuid is called the next time with uid == myself->uid.

> @@ -2701,7 +2737,7 @@ seteuid32 (__uid32_t uid)
>       Therefore we try this shortcut now.  When switching back to the
>       privileged user, we probably always want a correct (aka original)
>       user token for this privileged user, not only in sshd. */
> -  if ((uid == cygheap->user.saved_uid && usersid == cygheap->user.saved_sid ())
> +  else if ((uid == cygheap->user.saved_uid && usersid == cygheap->user.saved_sid ())

Please break up the line so that it's shorter than 80 chars.

> @@ -2790,6 +2829,8 @@ seteuid32 (__uid32_t uid)
>    cygheap->user.set_sid (usersid);
>    cygheap->user.curr_primary_token = new_token == hProcToken ? NO_IMPERSONATION
>  							: new_token;
> +  cygheap->user.curr_token_is_restricted = false;
> +  cygheap->user.setuid_to_restricted = false;
>    if (cygheap->user.curr_imp_token != NO_IMPERSONATION)
>      {
>        CloseHandle (cygheap->user.curr_imp_token);
> [...]
> @@ -2835,7 +2877,11 @@ setuid32 (__uid32_t uid)
>  {
>    int ret = seteuid32 (uid);
>    if (!ret)
> -    cygheap->user.real_uid = myself->uid;
> +    {
> +      cygheap->user.real_uid = myself->uid;
> +      /* If restricted token, forget original privileges on exec ().  */
> +      cygheap->user.setuid_to_restricted = cygheap->user.curr_token_is_restricted;
> +    }

Do I miss something or is the setuid_to_restricted flag equivalent to
the curr_token_is_restricted flag anyway, and as such redundant?  If so,
it would look nice to make setuid_to_restricted an inline method instead:

  bool setuid_to_restricted () const { return curr_token_is_restricted; }


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
