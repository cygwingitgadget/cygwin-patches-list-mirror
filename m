Return-Path: <cygwin-patches-return-6291-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8095 invoked by alias); 14 Mar 2008 02:10:55 -0000
Received: (qmail 8084 invoked by uid 22791); 14 Mar 2008 02:10:54 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 14 Mar 2008 02:10:37 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1JZzNO-0000AI-0c; Fri, 14 Mar 2008 02:10:30 +0000
Message-ID: <47D9DE98.F26BC56D@dessent.net>
Date: Fri, 14 Mar 2008 02:10:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: Eric Blake <ebb9@byu.net>
CC: cygwin-patches@cygwin.com
Subject: Re: [patch] recognise when an exec()d process terminates due to   unhandled    exception
References: <47D9D8D3.17BC1E3B@dessent.net> <47D9DB58.3090800@byu.net>
Content-Type: text/plain; charset=us-ascii
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
X-SW-Source: 2008-q1/txt/msg00065.txt.bz2

Eric Blake wrote:

> Should we also mention 'cygcheck ./dll_not_found' to find out which ones
> are missing?

It might be a good idea.  On the other hand it's kind of long already. 
I'm totally not married to what I've got for the wording though,
consider it a very rough draft.

> | missing_import.exe: an entry point for one of more symbols could not be
> | found during program initialization.  Usually this means an incorrect
> | or out of date version of one or more DLLs is being erroniously found
> | on the PATH.
> | Killed
> 
> s/erroniously/erroneously/

Drat and s/one of more/one or more/ as well.

Brian
