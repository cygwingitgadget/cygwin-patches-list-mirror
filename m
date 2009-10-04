Return-Path: <cygwin-patches-return-6686-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25820 invoked by alias); 4 Oct 2009 19:08:29 -0000
Received: (qmail 25809 invoked by uid 22791); 4 Oct 2009 19:08:29 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0 	tests=AWL,BAYES_00
X-Spam-Check-By: sourceware.org
Received: from mailout11.t-online.de (HELO mailout11.t-online.de) (194.25.134.85)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 04 Oct 2009 19:08:24 +0000
Received: from fwd05.aul.t-online.de  	by mailout11.t-online.de with smtp  	id 1MuWRR-0003sV-00; Sun, 04 Oct 2009 21:08:21 +0200
Received: from [10.3.2.2] (TWP1-ZZlghuHcND04JSCqSQH5qPQdL0FN9DecTnGUpygQX+Cojyec1OHjW7DTGhw5d@[217.235.186.109]) by fwd05.aul.t-online.de 	with esmtp id 1MuWRF-01kcJk0; Sun, 4 Oct 2009 21:08:09 +0200
Message-ID: <4AC8F299.1020303@t-online.de>
Date: Sun, 04 Oct 2009 19:08:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090825 SeaMonkey/1.1.18
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Allow to disable root privileges with CYGWIN=noroot
References: <4A993580.4060604@t-online.de> <20090829192050.GA32405@calimero.vinschen.de> <4A999EC2.2070801@t-online.de> <20090830090314.GB2648@calimero.vinschen.de> <4A9AD529.3060107@t-online.de> <20090901183209.GA14650@calimero.vinschen.de> <20091004123006.GF4563@calimero.vinschen.de> <20091004125455.GG4563@calimero.vinschen.de>
In-Reply-To: <20091004125455.GG4563@calimero.vinschen.de>
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
X-SW-Source: 2009-q4/txt/msg00017.txt.bz2

Hi Corinna,

Corinna Vinschen wrote:
> New patch attached.  I made the test a bit more foolproof, hopefully.
> And a restricted token does not require to load the user's registry hive,
> nor should Cygwin try to enable the backup/restore permissions in the
> new token.  That spoils the idea of a restricted token a bit...
> ...
>
>   

Thanks!

> +  bool request_restricted_uid_switch =
> +     uid == myself->uid
> +     && (   (cygheap->user.external_token != NO_IMPERSONATION
> +	     && IsTokenRestricted (cygheap->user.external_token))
> +	 || (cygheap->user.external_token == NO_IMPERSONATION
> +	     && cygheap->user.issetuid ()
> +	     && IsTokenRestricted (cygheap->user.curr_primary_token)));
>   


Unfortunately this does not work for a typical use case: an admin 
process creates a restricted token with standard user rights. The 
function IsTokenRestricted() returns TRUE only if the token contains 
'restricted SIDs'.
(http://msdn.microsoft.com/en-us/library/aa379137(VS.85).aspx)

Test with tokens returned by SaferComputeTokenFromLevel():
(http://msdn.microsoft.com/en-us/library/ms972827.aspx)

SAFER_LEVELID_NORMALUSER:  IsTokenRestricted()=FALSE
SAFER_LEVELID_CONSTRAINED: IsTokenRestricted()=TRUE
SAFER_LEVELID_UNTRUSTED:   IsTokenRestricted()=TRUE

BTW: Only NORMALUSER is works for Cygwin. Using DropMyRights.exe to 
start of a Cygwin process with a CONTRAINED token results in:

5 [sig] true 3788 C:\cygwin-1.7\bin\true.exe:
   *** fatal error - couldn't create signal pipe, Win32 error 5


There is apparently no function to check whether a token is a result of 
CreateRestrictedToken() or SaferComputeTokenFromLevel().

Would'nt it be easier to add a new function 
'cygwin_set_restricted_token(token)' instead of the test of the token type?

Christian
