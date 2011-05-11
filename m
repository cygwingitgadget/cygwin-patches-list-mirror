Return-Path: <cygwin-patches-return-7334-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23375 invoked by alias); 11 May 2011 16:39:43 -0000
Received: (qmail 22994 invoked by uid 22791); 11 May 2011 16:39:40 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm22-vm0.bullet.mail.bf1.yahoo.com (HELO nm22-vm0.bullet.mail.bf1.yahoo.com) (98.139.212.126)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Wed, 11 May 2011 16:39:24 +0000
Received: from [98.139.212.148] by nm22.bullet.mail.bf1.yahoo.com with NNFMP; 11 May 2011 16:39:23 -0000
Received: from [98.139.212.245] by tm5.bullet.mail.bf1.yahoo.com with NNFMP; 11 May 2011 16:39:23 -0000
Received: from [127.0.0.1] by omp1054.mail.bf1.yahoo.com with NNFMP; 11 May 2011 16:39:23 -0000
Received: (qmail 84784 invoked from network); 11 May 2011 16:16:24 -0000
Received: from cgf.cx (cgf@173.76.50.238 with login)        by smtp129.mail.mud.yahoo.com with SMTP; 11 May 2011 09:16:23 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 7EA6B4A801A	for <cygwin-patches@cygwin.com>; Wed, 11 May 2011 12:16:22 -0400 (EDT)
Date: Wed, 11 May 2011 16:39:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Improvements to fork handling
Message-ID: <20110511161622.GA23628@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4DCA2A48.6020208@cs.utoronto.ca> <20110511075953.GG28594@calimero.vinschen.de> <20110511141350.GA19557@ednor.casa.cgf.cx> <4DCA9B5A.4090606@cs.utoronto.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DCA9B5A.4090606@cs.utoronto.ca>
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
X-SW-Source: 2011-q2/txt/msg00100.txt.bz2

On Wed, May 11, 2011 at 10:21:14AM -0400, Ryan Johnson wrote:
>On 11/05/2011 10:13 AM, Christopher Faylor wrote:
>> On Wed, May 11, 2011 at 09:59:53AM +0200, Corinna Vinschen wrote:
>>> On May 11 02:18, Ryan Johnson wrote:
>>>> Please find attached five patches [...]
>>> Oops, wrong mailing list...
>>>
>>> Btw., it would be nice if you could create patches with the diff -p flag
>>> as well.  It's not exactly essential, but IMHO it's quite a help when
>>> trying to review patches.
>>>
>>> Another problem is this:  While you provide separate patches, you don't
>>> provide separate ChangeLogs.  That makes it kind of hard to apply them
>>> separately.  Would you mind to create one ChangeLog per change?
>> Ditto.  This really needs to be broken down into easier to review chunks.
>All right. Let's try this again with the correct mailing list.
>
>The patches have been generated with diff -p, and each includes 
>appropriate changelog entries. Hopefully the changes are split up finely 
>enough because I don't know a good way to break them down any further.
>
>For posterity's sake I'm including the original message body below.

Please: One patch per message.  One ChangeLog entry per message, not
sent as a diff.

cgf
