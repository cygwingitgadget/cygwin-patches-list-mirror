Return-Path: <cygwin-patches-return-6607-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24203 invoked by alias); 30 Aug 2009 09:03:34 -0000
Received: (qmail 23952 invoked by uid 22791); 30 Aug 2009 09:03:33 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 30 Aug 2009 09:03:26 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 7D6D96D4476; Sun, 30 Aug 2009 11:03:14 +0200 (CEST)
Date: Sun, 30 Aug 2009 09:03:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Allow to disable root privileges with CYGWIN=noroot
Message-ID: <20090830090314.GB2648@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4A993580.4060604@t-online.de> <20090829192050.GA32405@calimero.vinschen.de> <4A999EC2.2070801@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A999EC2.2070801@t-online.de>
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
X-SW-Source: 2009-q3/txt/msg00061.txt.bz2

On Aug 29 23:33, Christian Franke wrote:
> Corinna Vinschen wrote:
>> - On all older systems you shouldn't work as admin by default anyway,
>>   especially not on Windows XP.  And then, *if* you're running an admin
>>   session, you usually want admin rights.  What's the advantage of   
>> faking you don't have these rights?
>>
>>   
>
> *If* running an admin session, I expect (Windows) admin rights:
> - Access restrictions from ACLs are effective.
> - Further rights can be obtained if desired by
> -- changing ACLs
> -- disabling ACL check via backup/restore privileges (which  
> unfortunately cannot be inherited to child processes).
>
> This is not equivalent with (Unix) root rights, which means
> - No access restrictions apply, period.
>
> Of course this makes no difference for malware.
> But it IMO makes a practical difference if an admin runs Cygwin apps.

But *why*?  What is the pratical difference, except that you take away
rights from your Cygwin app which in turn has no POSIX way to re-enable
these rights?  I don't see any real advantage.

If you plan to run a Cygwin application with restricted rights from your
administrative account, the IMHO right way would be to start the Cygwin
application through another application which creates a *really*
restricted user token using the Win32 function CreateRestrictedToken and
then call cygwin_set_impersonation_token/execv to start the restricted
process.  A Cygwin tool which accomplishes that would be much more
useful and much more generic than this patch, IMHO.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
