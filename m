Return-Path: <cygwin-patches-return-6939-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19217 invoked by alias); 1 Feb 2010 22:19:35 -0000
Received: (qmail 19207 invoked by uid 22791); 1 Feb 2010 22:19:34 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from ey-out-1920.google.com (HELO ey-out-1920.google.com) (74.125.78.149)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 01 Feb 2010 22:19:24 +0000
Received: by ey-out-1920.google.com with SMTP id 13so4411679eye.14         for <cygwin-patches@cygwin.com>; Mon, 01 Feb 2010 14:19:20 -0800 (PST)
Received: by 10.213.37.14 with SMTP id v14mr5222300ebd.28.1265062760239;         Mon, 01 Feb 2010 14:19:20 -0800 (PST)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 24sm11152698eyx.6.2010.02.01.14.19.17         (version=SSLv3 cipher=RC4-MD5);         Mon, 01 Feb 2010 14:19:18 -0800 (PST)
Message-ID: <4B675776.4020105@gmail.com>
Date: Mon, 01 Feb 2010 22:19:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: dlclose not calling destructors of static variables.
References: <4B62DDE6.5070106@gmail.com>  <4B62F118.8010305@gmail.com>  <20100129184514.GA9550@ednor.casa.cgf.cx>  <4B66BF2F.4060802@gmail.com>  <20100201162603.GB25374@ednor.casa.cgf.cx>  <4B6710CE.40300@gmail.com>  <20100201174611.GA26080@ednor.casa.cgf.cx>  <20100201175123.GB26080@ednor.casa.cgf.cx>  <4B672B74.4090808@gmail.com>  <4B6736C1.8030101@gmail.com> <20100201215919.GA29662@ednor.casa.cgf.cx>
In-Reply-To: <20100201215919.GA29662@ednor.casa.cgf.cx>
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
X-SW-Source: 2010-q1/txt/msg00055.txt.bz2

On 01/02/2010 21:59, Christopher Faylor wrote:

> Since the testcase (obviously?) worked for me it seems like this is pretty
>  variable.  I'd like to understand why the MEMORY_BASIC_INFORMATION method
>  doesn't work before trying other things.


  Hmm, well first off, looks like RegionSize is indeed relative to
BaseAddress, not AllocationBase after all:

http://msdn.microsoft.com/en-us/library/aa366775(VS.85).aspx

> RegionSize
> 
> The size of the region beginning at the base address in which all pages 
> have identical attributes, in bytes.

http://msdn.microsoft.com/en-us/library/aa366902(VS.85).aspx

> The function returns the attributes and the size of the region of pages
> with matching attributes, in bytes. For example, if there is a 40 megabyte
> (MB) region of free memory, and VirtualQuery is called on a page that is 10
> MB into the region, the function will obtain a state of MEM_FREE and a size
> of 30 MB.

    cheers,
      DaveK
