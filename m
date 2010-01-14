Return-Path: <cygwin-patches-return-6911-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11890 invoked by alias); 14 Jan 2010 13:40:22 -0000
Received: (qmail 11869 invoked by uid 22791); 14 Jan 2010 13:40:20 -0000
X-SWARE-Spam-Status: Yes, hits=5.0 required=5.0 	tests=BAYES_50,BOTNET
X-Spam-Check-By: sourceware.org
Received: from vms173003pub.verizon.net (HELO vms173003pub.verizon.net) (206.46.173.3)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 14 Jan 2010 13:40:11 +0000
Received: from pool-68-239-42-250.bos.east.verizon.net  ([unknown] [68.239.42.250]) by vms173003.mailsrvcs.net  (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))  with ESMTPA id <0KW8000XTOMKUEK7@vms173003.mailsrvcs.net> for  cygwin-patches@cygwin.com; Thu, 14 Jan 2010 07:40:01 -0600 (CST)
Message-id: <0KW8000XUOMKUEK7@vms173003.mailsrvcs.net>
Date: Thu, 14 Jan 2010 13:40:00 -0000
To: cygwin-patches@cygwin.com,
From: "Pierre A. Humblet" <phumblet@phumblet.no-ip.org>
Subject: Re: dup3/O_CLOEXEC/F_DUPFD_CLOEXEC
In-reply-to: <20100114131744.GA26286@calimero.vinschen.de>
References: <20100113212537.GB14511@calimero.vinschen.de>  <4B4E96D3.90300@byu.net> <20100114114700.GC3428@calimero.vinschen.de>  <20100114115711.GD3428@calimero.vinschen.de> <4B4F15FB.1050309@byu.net>  <20100114131744.GA26286@calimero.vinschen.de>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
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
X-SW-Source: 2010-q1/txt/msg00027.txt.bz2

At 08:17 AM 1/14/2010, Corinna Vinschen wrote:
>On Jan 14 06:02, Eric Blake wrote:
>
> >
> > In a multi-threaded app, any fd that is opened only temporarily, such as
> > the one in mq_open, should be opened with O_CLOEXEC, so that no other
> > thread can win a race and do a fork/exec inside the window when the
> > temporary fd was open.  So even though mq_open does not leak an fd to the
> > current process, it should pass O_CLOEXEC as part of its internal open()
> > call in order to avoid leaking the fd to unrelated child processes.
>
>Uh, ok, that makes sense.
>
>I'll send a revised patch later today.  It will also include the pipe2
>implementation.

For the same reason we should also have SOCK_CLOEXEC, and 
SOCK_NONBLOCK while we are at it. I would use them in minires.

Pierre
