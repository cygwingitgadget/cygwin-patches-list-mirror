Return-Path: <cygwin-patches-return-6745-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13759 invoked by alias); 7 Oct 2009 18:07:21 -0000
Received: (qmail 13747 invoked by uid 22791); 7 Oct 2009 18:07:21 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS,WEIRD_PORT
X-Spam-Check-By: sourceware.org
Received: from mail-bw0-f216.google.com (HELO mail-bw0-f216.google.com) (209.85.218.216)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 07 Oct 2009 18:07:16 +0000
Received: by bwz12 with SMTP id 12so4787670bwz.44         for <cygwin-patches@cygwin.com>; Wed, 07 Oct 2009 11:07:13 -0700 (PDT)
Received: by 10.204.49.73 with SMTP id u9mr149102bkf.129.1254938833844;         Wed, 07 Oct 2009 11:07:13 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 1sm421683fkt.11.2009.10.07.11.07.12         (version=SSLv3 cipher=RC4-MD5);         Wed, 07 Oct 2009 11:07:12 -0700 (PDT)
Message-ID: <4ACCDC43.2010008@gmail.com>
Date: Wed, 07 Oct 2009 18:07:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Add wrappers for ExitProcess, TerminateProcess
References: <4ACA4323.5080103@cwilson.fastmail.fm> <20091005202722.GG12789@calimero.vinschen.de> <4ACA5BC7.6090908@cwilson.fastmail.fm> <20091006034229.GA12172@ednor.casa.cgf.cx> <4ACAC079.2020105@cwilson.fastmail.fm> <20091006074620.GA13712@calimero.vinschen.de> <4ACB56D5.4060606@cwilson.fastmail.fm> <20091006154519.GA24301@calimero.vinschen.de> <4ACB6D0A.1060307@cwilson.fastmail.fm>
In-Reply-To: <4ACB6D0A.1060307@cwilson.fastmail.fm>
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
X-SW-Source: 2009-q4/txt/msg00076.txt.bz2

Charles Wilson wrote:

> It is already marked noreturn, in the declaration at the top of the
> file.  I got an error when I marked the definition that way --
> apparently gcc4 doesn't like that:
> 
> /usr/src/devel/kernel/src/winsup/cygwin/external.cc:181: error:
> attributes are not allowed on a function-definition
> 
> I even tried to include the attribute on a (forward) declaration AND the
> definition, but I got the same error.  The only thing that works is the
> way I've already done it: apply the attribute to the (forward)
> declaration, but not the definition.

  There's been some tightening-up on the syntax of attribute specifications
recently, since they used to be ambiguous and often under-strictly parsed
and/or not/mis-diagnosed.  FYI, FTR etc.

    cheers,
      DaveK
