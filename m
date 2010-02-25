Return-Path: <cygwin-patches-return-6978-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3203 invoked by alias); 25 Feb 2010 14:48:25 -0000
Received: (qmail 3181 invoked by uid 22791); 25 Feb 2010 14:48:24 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 25 Feb 2010 14:48:20 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 80E4D6D42F5; Thu, 25 Feb 2010 15:48:18 +0100 (CET)
Date: Thu, 25 Feb 2010 14:48:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Statically initialising pthread attributes in dynamic dlls.
Message-ID: <20100225144818.GR5683@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4B841026.1000905@gmail.com>  <20100224004403.GA24591@ednor.casa.cgf.cx>  <4B848353.2010209@gmail.com>  <4B84B08C.7060302@gmail.com>  <4B84B887.6070801@gmail.com>  <4B856401.2000905@gmail.com>  <20100224214459.GA19766@ednor.casa.cgf.cx>  <4B867BBF.4010700@gmail.com>  <20100225142135.GP5683@calimero.vinschen.de>  <4B868D92.6040209@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B868D92.6040209@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q1/txt/msg00094.txt.bz2

On Feb 25 14:47, Dave Korn wrote:
> On 25/02/2010 14:21, Corinna Vinschen wrote:
> 
> > Did you test it on Windows Server 2008?  
> 
>   I'm afraid I don't have access to any of the server versions.
Heh.

> > Btw., if you don't have a Server 2008 machine, just install from here:
> > http://msdn.microsoft.com/en-us/evalcenter/cc137233.aspx
> > 
> > Works fine as a VM.  Even my Server 2008 domain controller is running in
> > a VM.
> 
>   Hey, thanks!  I'll download it and check everything out.  More later.

Btw., the evaluation period is 60 days, but you can easily push it to
a generous 240 days by re-arming the evaluation period timeout counter:
http://support.microsoft.com/kb/948472


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
