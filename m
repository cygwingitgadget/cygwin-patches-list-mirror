Return-Path: <cygwin-patches-return-7207-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31591 invoked by alias); 15 Mar 2011 23:38:05 -0000
Received: (qmail 31475 invoked by uid 22791); 15 Mar 2011 23:38:04 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from mail-qy0-f171.google.com (HELO mail-qy0-f171.google.com) (209.85.216.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 15 Mar 2011 23:37:58 +0000
Received: by qyj19 with SMTP id 19so3098511qyj.2        for <cygwin-patches@cygwin.com>; Tue, 15 Mar 2011 16:37:56 -0700 (PDT)
Received: by 10.229.62.198 with SMTP id y6mr63927qch.290.1300232276411;        Tue, 15 Mar 2011 16:37:56 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id d21sm263829qck.28.2011.03.15.16.37.54        (version=SSLv3 cipher=OTHER);        Tue, 15 Mar 2011 16:37:55 -0700 (PDT)
Subject: Re: [PATCH] Add an additional relocation attempt pass to load_after_fork()
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
In-Reply-To: <4D7CDDC7.5060708@dronecode.org.uk>
References: <4D7CDDC7.5060708@dronecode.org.uk>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 15 Mar 2011 23:38:00 -0000
Message-ID: <1300232277.2104.3.camel@YAAKOV04>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q1/txt/msg00062.txt.bz2

On Sun, 2011-03-13 at 15:07 +0000, Jon TURNEY wrote:
> Attached is a patch which avoids a fork failure due to remap error in the
> specific circumstances described in my email [1], by adding an additional pass
> to load_after_fork() which forces the DLL to be relocated by VirtualAlloc()ing
> a block of memory at the load address as well.
> 
> Hopefully it can be seen by inspection that this code doesn't change the
> behaviour of the first two passes, and so will only be changing the behaviour
> in what was an fatal error case before.

This patch causes a warning with GCC 4.5:

cc1plus: warnings being treated as errors
dll_init.cc: In member function âvoid dll_list::load_after_fork(void*)â:
dll_init.cc:328:33: error: converting to non-pointer type âDWORDâ from
NULL


Yaakov

