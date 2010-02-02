Return-Path: <cygwin-patches-return-6943-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14192 invoked by alias); 2 Feb 2010 01:51:06 -0000
Received: (qmail 14182 invoked by uid 22791); 2 Feb 2010 01:51:06 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from ey-out-1920.google.com (HELO ey-out-1920.google.com) (74.125.78.146)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 02 Feb 2010 01:51:01 +0000
Received: by ey-out-1920.google.com with SMTP id 13so4543674eye.14         for <cygwin-patches@cygwin.com>; Mon, 01 Feb 2010 17:50:58 -0800 (PST)
Received: by 10.213.109.219 with SMTP id k27mr51194ebp.37.1265075458465;         Mon, 01 Feb 2010 17:50:58 -0800 (PST)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 7sm11606337eyg.41.2010.02.01.17.50.56         (version=SSLv3 cipher=RC4-MD5);         Mon, 01 Feb 2010 17:50:57 -0800 (PST)
Message-ID: <4B678911.7050300@gmail.com>
Date: Tue, 02 Feb 2010 01:51:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add some notes about process startup/shutdown.
References: <4B677EAA.9050304@gmail.com> <20100202013901.GB31126@ednor.casa.cgf.cx>
In-Reply-To: <20100202013901.GB31126@ednor.casa.cgf.cx>
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
X-SW-Source: 2010-q1/txt/msg00059.txt.bz2

On 02/02/2010 01:39, Christopher Faylor wrote:

>> winsup/cygwin/ChangeLog:
>>
>> 	* how-crt-and-initfini.txt: Add new document.
>>
>>  OK?
> 
> Yes, very nice except I don't think the name is descriptive enough and
> in keeping with the other stuff in the series.
> 
> Maybe how-startup-shutdown-work.txt ?

  Okeydokey, will check it in with that name (well, modulo "-works").

  I'll also throw open the floor to any ideas for a better name for
"how-cxx-abi.txt", which is what the next one will be called in the absence of
any other suggestions...

    cheers,
      DaveK
