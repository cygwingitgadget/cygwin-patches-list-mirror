Return-Path: <cygwin-patches-return-6994-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10697 invoked by alias); 28 Feb 2010 00:56:47 -0000
Received: (qmail 10677 invoked by uid 22791); 28 Feb 2010 00:56:45 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00
X-Spam-Check-By: sourceware.org
Received: from mail-vw0-f43.google.com (HELO mail-vw0-f43.google.com) (209.85.212.43)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 28 Feb 2010 00:56:36 +0000
Received: by vws3 with SMTP id 3so1928889vws.2         for <cygwin-patches@cygwin.com>; Sat, 27 Feb 2010 16:56:34 -0800 (PST)
Received: by 10.220.123.215 with SMTP id q23mr1808027vcr.59.1267318594217;         Sat, 27 Feb 2010 16:56:34 -0800 (PST)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 40sm15446749vws.2.2010.02.27.16.56.31         (version=SSLv3 cipher=RC4-MD5);         Sat, 27 Feb 2010 16:56:32 -0800 (PST)
Message-ID: <4B89C372.4010009@gmail.com>
Date: Sun, 28 Feb 2010 00:56:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: Dave Korn <dave.korn.cygwin@googlemail.com>
CC: cygwin-patches@cygwin.com
Subject: Re: Statically initialising pthread attributes in dynamic dlls.
References: <4B82C093.7010001@gmail.com>  <4B83A727.3030101@gmail.com>  <4B841026.1000905@gmail.com>  <20100224004403.GA24591@ednor.casa.cgf.cx>  <4B848353.2010209@gmail.com>  <4B84B08C.7060302@gmail.com>  <4B84B887.6070801@gmail.com>  <4B856401.2000905@gmail.com>  <20100224214459.GA19766@ednor.casa.cgf.cx>  <4B867BBF.4010700@gmail.com> <20100225142135.GP5683@calimero.vinschen.de> <4B868D92.6040209@gmail.com>
In-Reply-To: <4B868D92.6040209@gmail.com>
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
X-SW-Source: 2010-q1/txt/msg00110.txt.bz2

On 25/02/2010 14:47, Dave Korn wrote:
> On 25/02/2010 14:21, Corinna Vinschen wrote:
> 
>> Did you test it on Windows Server 2008?  

>> Btw., if you don't have a Server 2008 machine, just install from here:
>> http://msdn.microsoft.com/en-us/evalcenter/cc137233.aspx
>>
>> Works fine as a VM.  Even my Server 2008 domain controller is running in
>> a VM.
> 
>   Hey, thanks!  I'll download it and check everything out.  More later.

  So, it all worked fine.  Pretty much what you'd expect, given that the patch
is all about not doing hairy stuff any more and just following the by-the-book
method for installing an SEH frame.

    cheers,
      DaveK
