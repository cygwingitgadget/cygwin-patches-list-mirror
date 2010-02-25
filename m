Return-Path: <cygwin-patches-return-6977-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15429 invoked by alias); 25 Feb 2010 14:30:05 -0000
Received: (qmail 15395 invoked by uid 22791); 25 Feb 2010 14:30:04 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00
X-Spam-Check-By: sourceware.org
Received: from fg-out-1718.google.com (HELO fg-out-1718.google.com) (72.14.220.155)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 25 Feb 2010 14:29:59 +0000
Received: by fg-out-1718.google.com with SMTP id 19so155154fgg.2         for <cygwin-patches@cygwin.com>; Thu, 25 Feb 2010 06:29:56 -0800 (PST)
Received: by 10.87.44.30 with SMTP id w30mr2427549fgj.5.1267108196255;         Thu, 25 Feb 2010 06:29:56 -0800 (PST)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 14sm4413675fxm.5.2010.02.25.06.29.54         (version=SSLv3 cipher=RC4-MD5);         Thu, 25 Feb 2010 06:29:55 -0800 (PST)
Message-ID: <4B868D92.6040209@gmail.com>
Date: Thu, 25 Feb 2010 14:30:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Statically initialising pthread attributes in dynamic dlls.
References: <4B82C093.7010001@gmail.com>  <4B83A727.3030101@gmail.com>  <4B841026.1000905@gmail.com>  <20100224004403.GA24591@ednor.casa.cgf.cx>  <4B848353.2010209@gmail.com>  <4B84B08C.7060302@gmail.com>  <4B84B887.6070801@gmail.com>  <4B856401.2000905@gmail.com>  <20100224214459.GA19766@ednor.casa.cgf.cx>  <4B867BBF.4010700@gmail.com> <20100225142135.GP5683@calimero.vinschen.de>
In-Reply-To: <20100225142135.GP5683@calimero.vinschen.de>
Content-Type: text/plain; charset=ISO-8859-1
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
X-SW-Source: 2010-q1/txt/msg00093.txt.bz2

On 25/02/2010 14:21, Corinna Vinschen wrote:

> Did you test it on Windows Server 2008?  

  I'm afraid I don't have access to any of the server versions.

> I wrote this already in a
> private email to cgf.  The really serious problem which lead to the
> changes in the SEH handling was that in the original code (which worked
> more or less flawlessly for ages) the exception handler chain was
> changed to an endless loop, so that the replacement SEH handler for
> the Cygwin handler became... the Cygwin handler.
> 
> However, this stopped working with Server 2008.  The code in Windows
> 2008 to check for the integrity of the SEH chain detected that and
> restored the chain to the default of calling just the Windows default
> exception handler.

  Yeah, the improved security stuff (referred to in my comment in the patch)
means IMO that we shouldn't try playing tricky games with the SEH chain full
stop, as who knows what future validation checks might be introduced?  This
was one of my two motivations for thinking that we should just introduce a
temporary SEH frame in the dll crt routine; the other is that, thinking about
failure modes, I think it would be less harmful to accidentally run a dlopened
DllMain without EH, than it would be to lose EH altogether on returning to the
main program for the remaining (probably short, without EH!) duration of the run.

> Btw., if you don't have a Server 2008 machine, just install from here:
> http://msdn.microsoft.com/en-us/evalcenter/cc137233.aspx
> 
> Works fine as a VM.  Even my Server 2008 domain controller is running in
> a VM.

  Hey, thanks!  I'll download it and check everything out.  More later.

    cheers,
      DaveK
