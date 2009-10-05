Return-Path: <cygwin-patches-return-6702-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8156 invoked by alias); 5 Oct 2009 19:39:42 -0000
Received: (qmail 8140 invoked by uid 22791); 5 Oct 2009 19:39:41 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from ey-out-1920.google.com (HELO ey-out-1920.google.com) (74.125.78.146)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 05 Oct 2009 19:39:37 +0000
Received: by ey-out-1920.google.com with SMTP id 13so3243696eye.14         for <cygwin-patches@cygwin.com>; Mon, 05 Oct 2009 12:39:35 -0700 (PDT)
Received: by 10.211.145.12 with SMTP id x12mr464503ebn.44.1254771575241;         Mon, 05 Oct 2009 12:39:35 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 5sm10412eyh.8.2009.10.05.12.39.34         (version=SSLv3 cipher=RC4-MD5);         Mon, 05 Oct 2009 12:39:34 -0700 (PDT)
Message-ID: <4ACA4EE6.5000303@gmail.com>
Date: Mon, 05 Oct 2009 19:39:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Add wrappers for ExitProcess, TerminateProcess
References: <4ACA4323.5080103@cwilson.fastmail.fm> <4ACA47AF.7070703@gmail.com> <4ACA4B76.5050209@gmail.com> <4ACA4ADF.6000205@cwilson.fastmail.fm>
In-Reply-To: <4ACA4ADF.6000205@cwilson.fastmail.fm>
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
X-SW-Source: 2009-q4/txt/msg00033.txt.bz2

Charles Wilson wrote:
> Dave Korn wrote:
>>   As to the actual patch itself, it looks sane (just reading it by eye, I
>> haven't tested it), and the design motivation seems reasonable.
> [snip]
>>   File-local extern declarations are pure evil, let alone function-local ones.
>>  Why not fix this badness while you're touching it anyway?
> 
> 'Cause I figured cgf did that for reasons beyond my ken.  What do you
> suggest, moving the definition to globals.cc and the declaration(s) to
> winsup.h?

  Wouldn't see any need to move the declaration any; just think that there
should be one unique extern declaration and it should be in a common header
that can be #included both where the var is declared and where it is referenced.

    cheers,
      DaveK
