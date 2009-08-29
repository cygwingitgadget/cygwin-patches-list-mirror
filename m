Return-Path: <cygwin-patches-return-6606-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24461 invoked by alias); 29 Aug 2009 21:34:05 -0000
Received: (qmail 24444 invoked by uid 22791); 29 Aug 2009 21:34:04 -0000
X-SWARE-Spam-Status: No, hits=-0.7 required=5.0 	tests=AWL,BAYES_05,J_CHICKENPOX_66
X-Spam-Check-By: sourceware.org
Received: from mailout04.t-online.de (HELO mailout04.t-online.de) (194.25.134.18)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 29 Aug 2009 21:33:59 +0000
Received: from fwd06.aul.t-online.de  	by mailout04.t-online.de with smtp  	id 1MhVYa-0007fl-03; Sat, 29 Aug 2009 23:33:56 +0200
Received: from [10.3.2.2] (Tl3vgOZDghmQQZsSX0Jq9ElRSPUzeZGcM5sFetEY0NnxjOGTFzTgFas-++9XIjpwQc@[217.235.177.230]) by fwd06.aul.t-online.de 	with esmtp id 1MhVYZ-1CJbUW0; Sat, 29 Aug 2009 23:33:55 +0200
Message-ID: <4A999EC2.2070801@t-online.de>
Date: Sat, 29 Aug 2009 21:34:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.21) Gecko/20090403 SeaMonkey/1.1.16
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Allow to disable root privileges with CYGWIN=noroot
References: <4A993580.4060604@t-online.de> <20090829192050.GA32405@calimero.vinschen.de>
In-Reply-To: <20090829192050.GA32405@calimero.vinschen.de>
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
X-SW-Source: 2009-q3/txt/msg00060.txt.bz2

Corinna Vinschen wrote:
> - On all older systems you shouldn't work as admin by default anyway,
>   especially not on Windows XP.  And then, *if* you're running an admin
>   session, you usually want admin rights.  What's the advantage of 
>   faking you don't have these rights?
>
>   

*If* running an admin session, I expect (Windows) admin rights:
- Access restrictions from ACLs are effective.
- Further rights can be obtained if desired by
-- changing ACLs
-- disabling ACL check via backup/restore privileges (which 
unfortunately cannot be inherited to child processes).

This is not equivalent with (Unix) root rights, which means
- No access restrictions apply, period.

Of course this makes no difference for malware.
But it IMO makes a practical difference if an admin runs Cygwin apps.

The patch give the user the ability to run Cygwin with the default admin 
rights. These are also effective for explorer, cmd.exe and all other 
Windows apps which do not set backup/restore privileges.

Christian
