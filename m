Return-Path: <cygwin-patches-return-6740-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27242 invoked by alias); 7 Oct 2009 08:21:23 -0000
Received: (qmail 27226 invoked by uid 22791); 7 Oct 2009 08:21:21 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 07 Oct 2009 08:21:18 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id A53DD6D5598; Wed,  7 Oct 2009 10:21:07 +0200 (CEST)
Date: Wed, 07 Oct 2009 08:21:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Allow to disable root privileges with CYGWIN=noroot
Message-ID: <20091007082107.GC27186@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4A999EC2.2070801@t-online.de> <20090830090314.GB2648@calimero.vinschen.de> <4A9AD529.3060107@t-online.de> <20090901183209.GA14650@calimero.vinschen.de> <20091004123006.GF4563@calimero.vinschen.de> <20091004125455.GG4563@calimero.vinschen.de> <4AC8F299.1020303@t-online.de> <20091004195723.GH4563@calimero.vinschen.de> <20091004200843.GK4563@calimero.vinschen.de> <4ACBA568.9080608@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ACBA568.9080608@t-online.de>
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
X-SW-Source: 2009-q4/txt/msg00071.txt.bz2

On Oct  6 22:15, Christian Franke wrote:
> Corinna Vinschen wrote:
>> ...and maybe it's time to create a cygwin_internal call which replaces
>> cygwin_set_impersonation_token and deprecate cygwin_set_impersonation_token
>> in the long run.  So, instead of the above we could have this call
>> taking a HANDLE and a BOOL value:
>>
>>   cygwin_internal (CW_SET_EXTERNAL_TOKEN, token_handle, restricted?);
>>
>>   
>
> OK.
>
> I have a very first experimental version which works for me. It also 
> requires a new flag 'cygheap->user.is_restricted_token' to tell 
> spawn_guts() to use CreateProcessAsUser().
>
> I will post the patch in a few days.
>
> A question:
>
> Why does seteuid32() call 'set_cygwin_privileges ()' on 'curr_imp_token' 
> and not on 'curr_primary_token' ? The curr_primary_token is used for 
> impersonation and therefore the privileges are not set for the thread 
> itself.

Oops.  Thanks for catching.  I applied a patch.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
