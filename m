Return-Path: <cygwin-patches-return-5581-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14606 invoked by alias); 21 Jul 2005 15:42:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14578 invoked by uid 22791); 21 Jul 2005 15:42:09 -0000
Received: from service.sh.cvut.cz (HELO service.sh.cvut.cz) (147.32.127.214)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Thu, 21 Jul 2005 15:42:09 +0000
Received: from localhost (localhost [127.0.0.1])
	by service.sh.cvut.cz (Postfix) with ESMTP id 53A751A3339
	for <cygwin-patches@cygwin.com>; Thu, 21 Jul 2005 17:42:07 +0200 (CEST)
Received: from service.sh.cvut.cz ([127.0.0.1])
	by localhost (service [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 22961-01; Thu, 21 Jul 2005 17:42:06 +0200 (CEST)
Received: from logout.sh.cvut.cz (logout.sh.cvut.cz [147.32.127.203])
	by service.sh.cvut.cz (Postfix) with ESMTP id 882BB1A32F0;
	Thu, 21 Jul 2005 17:42:06 +0200 (CEST)
Received: from logout (logout [147.32.127.203])
	by logout.sh.cvut.cz (Postfix) with ESMTP
	id 59B053C306; Thu, 21 Jul 2005 17:42:11 +0200 (CEST)
Date: Thu, 21 Jul 2005 15:42:00 -0000
From: Vaclav Haisman <V.Haisman@sh.cvut.cz>
To: Vaclav Haisman <V.Haisman@sh.cvut.cz>
Cc: cygwin-patches@cygwin.com
Subject: Re: Use of %E in system_printf().
In-Reply-To: <20050721172727.E38147@logout.sh.cvut.cz>
Message-ID: <20050721174147.J38147@logout.sh.cvut.cz>
References: <20050721172727.E38147@logout.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2005-q3/txt/msg00036.txt.bz2


Never mind, I found it. smallprint.c

VH




On Thu, 21 Jul 2005, Vaclav Haisman wrote:

>
> I've been looking around Cygwin again and found this:
>
> system_printf ("couldn't get memory info, %E");
>
> Now I am curious where does the %E get handled? Is it supposed to print
> GetLastError()? I looked into strace.h and strace.cc but I don't see anything
> that would handle it. Besides that, %E is afaik also format for printing
> doubles.
>
>
> VH
>
