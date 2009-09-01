Return-Path: <cygwin-patches-return-6609-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29266 invoked by alias); 1 Sep 2009 18:32:31 -0000
Received: (qmail 29251 invoked by uid 22791); 1 Sep 2009 18:32:29 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 01 Sep 2009 18:32:21 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id E59646D4476; Tue,  1 Sep 2009 20:32:09 +0200 (CEST)
Date: Tue, 01 Sep 2009 18:32:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Allow to disable root privileges with CYGWIN=noroot
Message-ID: <20090901183209.GA14650@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4A993580.4060604@t-online.de> <20090829192050.GA32405@calimero.vinschen.de> <4A999EC2.2070801@t-online.de> <20090830090314.GB2648@calimero.vinschen.de> <4A9AD529.3060107@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A9AD529.3060107@t-online.de>
User-Agent: Mutt/1.5.19 (2009-02-20)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q3/txt/msg00063.txt.bz2

On Aug 30 21:38, Christian Franke wrote:
> Corinna Vinschen wrote:
>> If you plan to run a Cygwin application with restricted rights from your
>> administrative account, the IMHO right way would be to start the Cygwin
>> application through another application which creates a *really*
>> restricted user token using the Win32 function CreateRestrictedToken and
>> then call cygwin_set_impersonation_token/execv to start the restricted
>> process.  A Cygwin tool which accomplishes that would be much more
>> useful and much more generic than this patch, IMHO.
>>
>>   
> I agree, let's forget the patch.
>
> But I'm not sure how cygwin_set_impersonation_token() could be of any  
> help here. This function sets user.external_token which is only used in  
> seteuid32(). Setuid/seteuid() cannot be used because the restricted  
> token is not related to another user id.

I had a quick look into the seteuid code and I see the problem.  I don't
see a quick way around it, unfortunately.  I'll have a deeper look into
it when I'm back from vacation.

> A quick test with native calls works for me:
>
>  HANDLE t, rt;
>  OpenProcessToken (GetCurrentProcess (), TOKEN_ALL_ACCESS, &t);
>  CreateRestrictedToken (t, DISABLE_MAX_PRIVILEGE, 0, ..., 0, &rt);
>  CreateProcessAsUser (rt, 0, "c:/cygwin/bin/mintty...", ...);

Cool.  Some stuff in the child won't work though since the entire
exec(2) magic is missing.

> BTW: CreateRestrictedToken is apparently missing in  
> /usr/include/w32api/*.h, but it is present in libadvapi32.a

PTC.  The w32api files always need a lot of work.  Microsoft adds 
stuff with every new OS release.  It's hard to stay on top.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
