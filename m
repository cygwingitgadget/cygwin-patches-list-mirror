From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: Re: mkpasswd support for current user option (-c)
Date: Tue, 13 Nov 2001 02:44:00 -0000
Message-ID: <20011113114407.A19495@cygbert.vinschen.de>
References: <FB7B5F146C8CD5118E0D00306E005CDA02EA5D@AP-CAN-MAIL01>
X-SW-Source: 2001-q4/msg00213.html
Message-ID: <20011113024400.gMrZYcbr2BDocnyi5b81JQNC7J2VeRPu2pQRDh4oC5E@z>

Sorry, but your patch is not against the latest version of mkpasswd.cc
in the CVS repository.  The headline of your patch contains a 
`cygwin-1.3.3-2' directory... mkpasswd.cc has been changed a lot since
then.

Btw., you shouldn't cut-n-paste a diff into your mail client but
instead either add it as an attachment or e.g in vim use `:r filename'.
The below patch is broken (tabs/line breaks).

Corinna

On Tue, Nov 13, 2001 at 02:05:52PM +1100, Mathew Boorman wrote:
> 2001-11-13  Mathew Boorman  <mathew.boorman@au.cmg.com>
> 
> 	* mkpasswd.c (load_netapi) Add dll entry points to determine current
> user.
> 	Used explicit cast to avoid warnings.
> 	(psx_dir) Fixed const-ness of parameter.
> 	(uni2ansi) dito.
> 	(ansi2uni) New function.
>       (print_user_info) New function refactored from enum_users.
>       (enum_users) Use new function print_user_info.
> 	(print_current_user_info) New function.
> 	(usage) Add current user option.
> 	(main) Add suport for current user option.
> 
> 
> 
> --- /usr/src/cygwin-1.3.3-2/winsup/utils/mkpasswd.c	Thu Sep  6 12:38:49
> 2001
> [...]

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
