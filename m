Return-Path: <cygwin-patches-return-6545-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1886 invoked by alias); 5 Jun 2009 17:01:38 -0000
Received: (qmail 1460 invoked by uid 22791); 5 Jun 2009 17:01:36 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-fx0-f224.google.com (HELO mail-fx0-f224.google.com) (209.85.220.224)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 05 Jun 2009 17:01:30 +0000
Received: by fxm24 with SMTP id 24so1784488fxm.2         for <cygwin-patches@cygwin.com>; Fri, 05 Jun 2009 10:01:27 -0700 (PDT)
Received: by 10.103.212.2 with SMTP id o2mr1265703muq.18.1244221287181;         Fri, 05 Jun 2009 10:01:27 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id e9sm678383muf.32.2009.06.05.10.01.25         (version=SSLv3 cipher=RC4-MD5);         Fri, 05 Jun 2009 10:01:26 -0700 (PDT)
Message-ID: <4A295231.50201@gmail.com>
Date: Fri, 05 Jun 2009 17:01:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH?]  Separate pthread patches, #2 take 2.
References: <4A270656.8090704@gmail.com> <4A2716AF.9070101@gmail.com> <4A2728F8.8020907@gmail.com> <20090604151053.GX23519@calimero.vinschen.de> <4A29260B.90001@gmail.com> <20090605162647.GA5103@ednor.casa.cgf.cx>
In-Reply-To: <20090605162647.GA5103@ednor.casa.cgf.cx>
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
X-SW-Source: 2009-q2/txt/msg00087.txt.bz2

Christopher Faylor wrote:
> On Fri, Jun 05, 2009 at 03:04:59PM +0100, Dave Korn wrote:
>> winsup/cygwin/ChangeLog
>>
>> 	* winbase.h (ilockexch):  Fix asm constraints.
>> 	(ilockcmpexch):  Likewise.
> 
> Thanks for seeing this through.  It was obviously a lot of work.
> 
> cgf

  I appreciate the need to be diligent when working so deep in the bowels of
the fundaments, so no problem :)

    cheers,
      DaveK
