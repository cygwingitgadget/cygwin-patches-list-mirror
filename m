Return-Path: <cygwin-patches-return-6605-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7789 invoked by alias); 29 Aug 2009 19:21:11 -0000
Received: (qmail 7778 invoked by uid 22791); 29 Aug 2009 19:21:10 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 29 Aug 2009 19:21:02 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id A74166D55B9; Sat, 29 Aug 2009 21:20:50 +0200 (CEST)
Date: Sat, 29 Aug 2009 19:21:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Allow to disable root privileges with CYGWIN=noroot
Message-ID: <20090829192050.GA32405@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4A993580.4060604@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A993580.4060604@t-online.de>
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
X-SW-Source: 2009-q3/txt/msg00059.txt.bz2

On Aug 29 16:04, Christian Franke wrote:
> For members of administrator group, Cygwin runs with root access rights.  
> Cygwin enables the Windows backup and restore privileges which are not  
> enabled by default.
>
> This is IMO not desirable under all circumstances.
>
> This patch adds a new flag to the Cygwin environment variable.
> If 'CYGWIN=noroot' is set, the extra privileges are removed after Cygwin  
> startup.
>
> This allows to run a Cygwin shell with the same default access rights as  
> cmd or explorer.

I don't like the idea of the patch for three reasons:

- It adds a new CYGWIN setting and
- It adds a new CYGWIN setting which is redundant on all systems
  supporting UAC.  Either you're running in a default shell with
  restricted rights, which means, you don't have admin privileges
  anyway, or you're runnning in a admin shell and you very likely want
  all rights you can get as admin.
- On all older systems you shouldn't work as admin by default anyway,
  especially not on Windows XP.  And then, *if* you're running an admin
  session, you usually want admin rights.  What's the advantage of 
  faking you don't have these rights?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
