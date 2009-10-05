Return-Path: <cygwin-patches-return-6699-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29532 invoked by alias); 5 Oct 2009 19:25:04 -0000
Received: (qmail 29479 invoked by uid 22791); 5 Oct 2009 19:25:02 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f225.google.com (HELO mail-ew0-f225.google.com) (209.85.219.225)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 05 Oct 2009 19:24:57 +0000
Received: by ewy25 with SMTP id 25so3449591ewy.45         for <cygwin-patches@cygwin.com>; Mon, 05 Oct 2009 12:24:55 -0700 (PDT)
Received: by 10.211.146.5 with SMTP id y5mr451111ebn.41.1254770695107;         Mon, 05 Oct 2009 12:24:55 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 28sm38466eyg.20.2009.10.05.12.24.53         (version=SSLv3 cipher=RC4-MD5);         Mon, 05 Oct 2009 12:24:54 -0700 (PDT)
Message-ID: <4ACA4B76.5050209@gmail.com>
Date: Mon, 05 Oct 2009 19:25:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: Dave Korn <dave.korn.cygwin@googlemail.com>
CC: cygwin-patches@cygwin.com
Subject: Re: Add wrappers for ExitProcess, TerminateProcess
References: <4ACA4323.5080103@cwilson.fastmail.fm> <4ACA47AF.7070703@gmail.com>
In-Reply-To: <4ACA47AF.7070703@gmail.com>
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
X-SW-Source: 2009-q4/txt/msg00030.txt.bz2

Dave Korn wrote:

>   Heh.  I see what you did there!

  As to the actual patch itself, it looks sane (just reading it by eye, I
haven't tested it), and the design motivation seems reasonable.

> @@ -136,11 +136,19 @@ status_exit (DWORD x)
>  
>  # define self (*this)
>  void
> +pinfo::set_exit_code (DWORD x)
> +{
> +  extern int sigExeced;
> +  if (x >= 0xc0000000UL)
> +    x = status_exit (x);
> +  self->exitcode = EXITCODE_SET | (sigExeced ?: (x & 0xff) << 8);
> +}
> +
> +void
>  pinfo::maybe_set_exit_code_from_windows ()
>  {
>    DWORD x = 0xdeadbeef;
>    DWORD oexitcode = self->exitcode;
> -  extern int sigExeced;

  File-local extern declarations are pure evil, let alone function-local ones.
 Why not fix this badness while you're touching it anyway?

    cheers,
      DaveK
