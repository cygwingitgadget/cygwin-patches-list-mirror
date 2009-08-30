Return-Path: <cygwin-patches-return-6608-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15781 invoked by alias); 30 Aug 2009 19:38:34 -0000
Received: (qmail 15770 invoked by uid 22791); 30 Aug 2009 19:38:34 -0000
X-SWARE-Spam-Status: No, hits=-1.5 required=5.0 	tests=AWL,BAYES_00,J_CHICKENPOX_66
X-Spam-Check-By: sourceware.org
Received: from mailout08.t-online.de (HELO mailout08.t-online.de) (194.25.134.20)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 30 Aug 2009 19:38:26 +0000
Received: from fwd06.aul.t-online.de  	by mailout08.t-online.de with smtp  	id 1MhqEJ-0008JA-03; Sun, 30 Aug 2009 21:38:23 +0200
Received: from [10.3.2.2] (TzoHCgZVghAr7UcOmb9TUFYx4r51xkdbXWl+tA2pbBWN6MwAyTcLmC0WE6-4BncZFf@[217.235.172.124]) by fwd06.aul.t-online.de 	with esmtp id 1MhqED-1r0ZDU0; Sun, 30 Aug 2009 21:38:17 +0200
Message-ID: <4A9AD529.3060107@t-online.de>
Date: Sun, 30 Aug 2009 19:38:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.21) Gecko/20090403 SeaMonkey/1.1.16
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Allow to disable root privileges with CYGWIN=noroot
References: <4A993580.4060604@t-online.de> <20090829192050.GA32405@calimero.vinschen.de> <4A999EC2.2070801@t-online.de> <20090830090314.GB2648@calimero.vinschen.de>
In-Reply-To: <20090830090314.GB2648@calimero.vinschen.de>
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
X-SW-Source: 2009-q3/txt/msg00062.txt.bz2

Corinna Vinschen wrote:
> If you plan to run a Cygwin application with restricted rights from your
> administrative account, the IMHO right way would be to start the Cygwin
> application through another application which creates a *really*
> restricted user token using the Win32 function CreateRestrictedToken and
> then call cygwin_set_impersonation_token/execv to start the restricted
> process.  A Cygwin tool which accomplishes that would be much more
> useful and much more generic than this patch, IMHO.
>
>   
I agree, let's forget the patch.

But I'm not sure how cygwin_set_impersonation_token() could be of any 
help here. This function sets user.external_token which is only used in 
seteuid32(). Setuid/seteuid() cannot be used because the restricted 
token is not related to another user id.

A quick test with native calls works for me:

  HANDLE t, rt;
  OpenProcessToken (GetCurrentProcess (), TOKEN_ALL_ACCESS, &t);
  CreateRestrictedToken (t, DISABLE_MAX_PRIVILEGE, 0, ..., 0, &rt);
  CreateProcessAsUser (rt, 0, "c:/cygwin/bin/mintty...", ...);

BTW: CreateRestrictedToken is apparently missing in 
/usr/include/w32api/*.h, but it is present in libadvapi32.a

Christian
