Return-Path: <cygwin-patches-return-7555-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32423 invoked by alias); 5 Dec 2011 19:17:31 -0000
Received: (qmail 32409 invoked by uid 22791); 5 Dec 2011 19:17:31 -0000
X-SWARE-Spam-Status: No, hits=-0.8 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from mail-ey0-f171.google.com (HELO mail-ey0-f171.google.com) (209.85.215.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 05 Dec 2011 19:17:18 +0000
Received: by eaad12 with SMTP id d12so5373655eaa.2        for <cygwin-patches@cygwin.com>; Mon, 05 Dec 2011 11:17:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.227.208.71 with SMTP id gb7mr9065265wbb.7.1323112636872; Mon, 05 Dec 2011 11:17:16 -0800 (PST)
Received: by 10.227.57.82 with HTTP; Mon, 5 Dec 2011 11:17:16 -0800 (PST)
In-Reply-To: <20111205101715.GA13067@calimero.vinschen.de>
References: <CAL-4N9uVjoqNTXPQGvsjnT+q=KJx9_QNzT-m8U_K=46+zOyheQ@mail.gmail.com>	<20111205101715.GA13067@calimero.vinschen.de>
Date: Mon, 05 Dec 2011 19:17:00 -0000
Message-ID: <CAL-4N9sx=asy0r3fcD65=WfvW0VHByv-Hn0CAJgaAFK3C8Vw_Q@mail.gmail.com>
Subject: Re: Add support for creating native windows symlinks
From: Russell Davis <russell.davis@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=ISO-8859-1
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
X-SW-Source: 2011-q4/txt/msg00045.txt.bz2

> See also http://sourceware.org/ml/cygwin/2009-10/msg00756.html

Quoting from that link:

- Due to the way they are used in the Win32 API, there's no way to
  use them with POSIX paths *and* Win32 paths for interoperability.
  So why bother?

Yeah, this is rather unfortunate. I agree, since we can't store both
the Win32 AND the POSIX path, it's not possible for native symlinks to
function correctly both inside and outside of cygwin for all possible
cases. But the point I've been making is this -- if we can make them
work within cygwin for 100% of cases, and outside of cygwin for 90% of
cases, what's the problem? It's still better than the existing cygwin
symlinks which work 100% within cygwin and 0% outside of cygwin.

If the "works within cygwin for 100% of cases" is in question, let's
discuss that. (Any path that might be problematic as a Win32 path can
just be stored as a POSIX path, and would fall into the bucket of
"works inside cygwin but not outside").


> There's also a problem with your patch.

Thanks, I figured it would need some clean up and polish. I wanted to
get it out there as a starting point.


Thanks,
Russell
