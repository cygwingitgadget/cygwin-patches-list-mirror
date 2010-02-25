Return-Path: <cygwin-patches-return-6976-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6395 invoked by alias); 25 Feb 2010 14:21:45 -0000
Received: (qmail 6371 invoked by uid 22791); 25 Feb 2010 14:21:43 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 25 Feb 2010 14:21:38 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 484346D42F5; Thu, 25 Feb 2010 15:21:35 +0100 (CET)
Date: Thu, 25 Feb 2010 14:21:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Statically initialising pthread attributes in dynamic dlls.
Message-ID: <20100225142135.GP5683@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4B82C093.7010001@gmail.com>  <4B83A727.3030101@gmail.com>  <4B841026.1000905@gmail.com>  <20100224004403.GA24591@ednor.casa.cgf.cx>  <4B848353.2010209@gmail.com>  <4B84B08C.7060302@gmail.com>  <4B84B887.6070801@gmail.com>  <4B856401.2000905@gmail.com>  <20100224214459.GA19766@ednor.casa.cgf.cx>  <4B867BBF.4010700@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B867BBF.4010700@gmail.com>
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
X-SW-Source: 2010-q1/txt/msg00092.txt.bz2

On Feb 25 13:31, Dave Korn wrote:
> On 24/02/2010 21:44, Christopher Faylor wrote:
> 
> > Hmm.  That would presumably cause the behavior that Dave Korn noted of
> > removing the handler after FreeLibrary returns.  So you'd have to put it
> > there and in dlclose.  
> 
>   The temporary handler in dll_dllcrt0_1 approach seems an awful lot simpler
> and more reliable to me than all this tedious mucking about in hyperspace...
> erm, I mean all this tedious unlinking and relinking the chain and hoping
> nothing bad happens during the window when we have no handler installed at
> all.  Why don't we just fix it this way instead?

Did you test it on Windows Server 2008?  I wrote this already in a
private email to cgf.  The really serious problem which lead to the
changes in the SEH handling was that in the original code (which worked
more or less flawlessly for ages) the exception handler chain was
changed to an endless loop, so that the replacement SEH handler for
the Cygwin handler became... the Cygwin handler.

However, this stopped working with Server 2008.  The code in Windows
2008 to check for the integrity of the SEH chain detected that and
restored the chain to the default of calling just the Windows default
exception handler.

The bottom line of this is, AFAICS, that changes to the SEH chain
handling in Cygwin should always be tested with Server 2008.  Way
back I asked in the Microsoft NG m.p.w.p.kernel about this problem
and it turned out that the integrity checking is not built into the
desktop OSes like Vista or W7.

Btw., if you don't have a Server 2008 machine, just install from here:
http://msdn.microsoft.com/en-us/evalcenter/cc137233.aspx

Works fine as a VM.  Even my Server 2008 domain controller is running in
a VM.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
