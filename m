Return-Path: <cygwin-patches-return-6564-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5857 invoked by alias); 7 Jul 2009 21:42:41 -0000
Received: (qmail 5847 invoked by uid 22791); 7 Jul 2009 21:42:41 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-fx0-f217.google.com (HELO mail-fx0-f217.google.com) (209.85.220.217)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 07 Jul 2009 21:42:33 +0000
Received: by fxm17 with SMTP id 17so3623599fxm.2         for <cygwin-patches@cygwin.com>; Tue, 07 Jul 2009 14:42:31 -0700 (PDT)
Received: by 10.103.182.1 with SMTP id j1mr3623824mup.119.1247002950906;         Tue, 07 Jul 2009 14:42:30 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id e8sm7503897muf.6.2009.07.07.14.42.30         (version=SSLv3 cipher=RC4-MD5);         Tue, 07 Jul 2009 14:42:30 -0700 (PDT)
Message-ID: <4A53C441.5090708@gmail.com>
Date: Tue, 07 Jul 2009 21:42:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Re: 1.7 winbase.h (ilockcmpexch) compile error
References: <Pine.CYG.4.58.0906241239470.2248@PC1163-8460-XP.flightsafety.com>  <4A53BC5D.7010401@gmail.com> <20090707213202.GA10393@ednor.casa.cgf.cx>
In-Reply-To: <20090707213202.GA10393@ednor.casa.cgf.cx>
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
X-SW-Source: 2009-q3/txt/msg00018.txt.bz2

Christopher Faylor wrote:
> On Tue, Jul 07, 2009 at 10:21:33PM +0100, Dave Korn wrote:

>> winsup/cygwin/ChangeLog:
>>
>> 	* winbase.h (ilockexch):  Avoid making 'ret' volatile.
>> 	(ilockcmpexch):  Likewise.
>>
>>  Ok?
> 
> Yes.  Thanks.

  Applied, and I even caught the changelog formatting in time!

    cheers,
      DaveK
