Return-Path: <cygwin-patches-return-7212-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7021 invoked by alias); 28 Mar 2011 18:47:54 -0000
Received: (qmail 7006 invoked by uid 22791); 28 Mar 2011 18:47:52 -0000
X-SWARE-Spam-Status: No, hits=-1.0 required=5.0	tests=AWL,BAYES_00,DATE_IN_PAST_03_06,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm2.bullet.mail.ne1.yahoo.com (HELO nm2.bullet.mail.ne1.yahoo.com) (98.138.90.65)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Mon, 28 Mar 2011 18:47:41 +0000
Received: from [98.138.90.49] by nm2.bullet.mail.ne1.yahoo.com with NNFMP; 28 Mar 2011 18:47:39 -0000
Received: from [98.138.84.45] by tm2.bullet.mail.ne1.yahoo.com with NNFMP; 28 Mar 2011 18:47:39 -0000
Received: from [127.0.0.1] by smtp113.mail.ne1.yahoo.com with NNFMP; 28 Mar 2011 18:47:39 -0000
Received: from cgf.cx (cgf@72.70.43.165 with login)        by smtp113.mail.ne1.yahoo.com with SMTP; 28 Mar 2011 11:47:39 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 0677313C0C4	for <cygwin-patches@cygwin.com>; Mon, 28 Mar 2011 14:47:38 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id 347512B35F; Mon, 28 Mar 2011 10:48:43 -0400 (EDT)
Date: Mon, 28 Mar 2011 18:47:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Export strchrnul (pending newlib patch)
Message-ID: <20110328144842.GA3774@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1301283496.5408.8.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1301283496.5408.8.camel@YAAKOV04>
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
X-SW-Source: 2011-q1/txt/msg00067.txt.bz2

On Sun, Mar 27, 2011 at 10:38:16PM -0500, Yaakov (Cygwin/X) wrote:
>Here's the Cygwin patch to export strchrnul(3) once accepted in newlib.

Cygwin already has an implementation of this named strechr written in
assembly language.  Maybe we should be exporting that.

cgf
