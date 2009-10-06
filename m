Return-Path: <cygwin-patches-return-6725-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14589 invoked by alias); 6 Oct 2009 20:18:44 -0000
Received: (qmail 14578 invoked by uid 22791); 6 Oct 2009 20:18:43 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0 	tests=AWL,BAYES_00
X-Spam-Check-By: sourceware.org
Received: from mailout02.t-online.de (HELO mailout02.t-online.de) (194.25.134.17)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 06 Oct 2009 20:18:38 +0000
Received: from fwd05.aul.t-online.de  	by mailout02.t-online.de with smtp  	id 1MvGRn-0005i1-01; Tue, 06 Oct 2009 22:15:47 +0200
Received: from [10.3.2.2] (rxJGbyZfwhvRVXPN9F53XMwNDX2u921b0jBua+sur-o7yFncRQTDo9E1NeRaGiDQYw@[217.235.232.40]) by fwd05.aul.t-online.de 	with esmtp id 1MvGRa-1UKrCa0; Tue, 6 Oct 2009 22:15:34 +0200
Message-ID: <4ACBA568.9080608@t-online.de>
Date: Tue, 06 Oct 2009 20:18:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090825 SeaMonkey/1.1.18
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Allow to disable root privileges with CYGWIN=noroot
References: <4A993580.4060604@t-online.de> <20090829192050.GA32405@calimero.vinschen.de> <4A999EC2.2070801@t-online.de> <20090830090314.GB2648@calimero.vinschen.de> <4A9AD529.3060107@t-online.de> <20090901183209.GA14650@calimero.vinschen.de> <20091004123006.GF4563@calimero.vinschen.de> <20091004125455.GG4563@calimero.vinschen.de> <4AC8F299.1020303@t-online.de> <20091004195723.GH4563@calimero.vinschen.de> <20091004200843.GK4563@calimero.vinschen.de>
In-Reply-To: <20091004200843.GK4563@calimero.vinschen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00056.txt.bz2

Corinna Vinschen wrote:
> ...and maybe it's time to create a cygwin_internal call which replaces
> cygwin_set_impersonation_token and deprecate cygwin_set_impersonation_token
> in the long run.  So, instead of the above we could have this call
> taking a HANDLE and a BOOL value:
>
>   cygwin_internal (CW_SET_EXTERNAL_TOKEN, token_handle, restricted?);
>
>   

OK.

I have a very first experimental version which works for me. It also 
requires a new flag 'cygheap->user.is_restricted_token' to tell 
spawn_guts() to use CreateProcessAsUser().

I will post the patch in a few days.

A question:

Why does seteuid32() call 'set_cygwin_privileges ()' on 'curr_imp_token' 
and not on 'curr_primary_token' ? The curr_primary_token is used for 
impersonation and therefore the privileges are not set for the thread 
itself.

Christian
