Return-Path: <cygwin-patches-return-7401-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28800 invoked by alias); 24 May 2011 17:03:23 -0000
Received: (qmail 28787 invoked by uid 22791); 24 May 2011 17:03:22 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm8.bullet.mail.bf1.yahoo.com (HELO nm8.bullet.mail.bf1.yahoo.com) (98.139.212.167)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Tue, 24 May 2011 17:03:07 +0000
Received: from [98.139.212.148] by nm8.bullet.mail.bf1.yahoo.com with NNFMP; 24 May 2011 17:03:06 -0000
Received: from [98.139.211.194] by tm5.bullet.mail.bf1.yahoo.com with NNFMP; 24 May 2011 17:03:06 -0000
Received: from [127.0.0.1] by smtp203.mail.bf1.yahoo.com with NNFMP; 24 May 2011 17:03:06 -0000
Received: from cgf.cx (cgf@173.48.46.160 with login)        by smtp203.mail.bf1.yahoo.com with SMTP; 24 May 2011 10:03:06 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 16BE642804C	for <cygwin-patches@cygwin.com>; Tue, 24 May 2011 13:03:03 -0400 (EDT)
Date: Tue, 24 May 2011 17:03:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Improvements to fork handling (2/5)
Message-ID: <20110524170302.GA16606@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4DCAD609.70106@cs.utoronto.ca> <20110522014421.GB18936@ednor.casa.cgf.cx> <4DD958FE.5060208@cs.utoronto.ca> <20110524161428.GA16774@calimero.vinschen.de> <4DDBE128.8090907@cs.utoronto.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DDBE128.8090907@cs.utoronto.ca>
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
X-SW-Source: 2011-q2/txt/msg00167.txt.bz2

On Tue, May 24, 2011 at 12:47:36PM -0400, Ryan Johnson wrote:
>The best way to improve performance of this part of fork() would be to 
>figure out how to force a dll to load in the right place on the first 
>try. Achieving this admittedly "difficult" task would eliminate multiple 
>syscalls per dll, the aggregate cost of which dominates the topsort into 
>oblivion unless I'm very mistaken.

Right.  And, if we could cure cancer no one would suffer from cancer
anymore.

cgf
