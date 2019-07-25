Return-Path: <cygwin-patches-return-9524-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 114694 invoked by alias); 25 Jul 2019 12:15:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 114620 invoked by uid 89); 25 Jul 2019 12:15:04 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-15.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=adequate, validation, H*F:D*org.uk, UD:cygwin.com
X-HELO: rgout04.bt.lon5.cpcloud.co.uk
Received: from rgout0403.bt.lon5.cpcloud.co.uk (HELO rgout04.bt.lon5.cpcloud.co.uk) (65.20.0.216) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 25 Jul 2019 12:15:03 +0000
X-OWM-Source-IP: 86.158.32.11 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
Received: from [192.168.1.102] (86.158.32.11) by rgout04.bt.lon5.cpcloud.co.uk (9.0.019.26-1) (authenticated as jonturney@btinternet.com)        id 5C55FFA91050EBE7 for cygwin-patches@cygwin.com; Thu, 25 Jul 2019 13:15:00 +0100
Subject: Re: [PATCH] Cygwin: fhandler_termios::tcsetpgrp: check that argument is non-negative
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20190724153438.1240-1-kbrown@cornell.edu>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <9b6cb2c7-94e2-ede9-64f8-8af540626cac@dronecode.org.uk>
Date: Thu, 25 Jul 2019 12:15:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724153438.1240-1-kbrown@cornell.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2019-q3/txt/msg00044.txt.bz2

On 24/07/2019 16:34, Ken Brown wrote:
> Return -1 with EINVAL if pgid < 0.  This fixes the gdb problem
> reported here:
> 
>    https://cygwin.com/ml/cygwin/2019-07/msg00166.html

Thanks.

> ---
>   winsup/cygwin/fhandler_termios.cc | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/winsup/cygwin/fhandler_termios.cc b/winsup/cygwin/fhandler_termios.cc
> index 4ce53433a..5b0ba5603 100644
> --- a/winsup/cygwin/fhandler_termios.cc
> +++ b/winsup/cygwin/fhandler_termios.cc
> @@ -69,6 +69,11 @@ fhandler_termios::tcsetpgrp (const pid_t pgid)
>         set_errno (EPERM);
>         return -1;
>       }
> +  else if (pgid < 0)
> +    {
> +      set_errno (EINVAL);
> +      return -1;
> +    }
>     int res;
>     while (1)
>       {
> 

I guess there's some additional validation missing somewhere (that pgid 
is a valid process group id, which -1 can never be), but I think this is 
more than adequate for the moment.
