Return-Path: <cygwin-patches-return-5887-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10722 invoked by alias); 13 Jun 2006 02:59:34 -0000
Received: (qmail 10711 invoked by uid 22791); 13 Jun 2006 02:59:34 -0000
X-Spam-Check-By: sourceware.org
Received: from py-out-1112.google.com (HELO py-out-1112.google.com) (64.233.166.177)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 13 Jun 2006 02:59:31 +0000
Received: by py-out-1112.google.com with SMTP id c31so1718340pyd         for <cygwin-patches@cygwin.com>; Mon, 12 Jun 2006 19:59:30 -0700 (PDT)
Received: by 10.35.50.5 with SMTP id c5mr3178390pyk;         Mon, 12 Jun 2006 19:59:30 -0700 (PDT)
Received: by 10.35.30.7 with HTTP; Mon, 12 Jun 2006 19:59:29 -0700 (PDT)
Message-ID: <ba40711f0606121959g2a1acf17g5e6963e811676f71@mail.gmail.com>
Date: Tue, 13 Jun 2006 02:59:00 -0000
From: "Lev Bishop" <lev.bishop@gmail.com>
To: cygwin-patches@cygwin.com
Subject: Re: Open sockets non-overlapped?
In-Reply-To: <ba40711f0606121843n11ad2155g5fa37362e91c401e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <ba40711f0605190819h4dfc5870l18a1919149a4f2d9@mail.gmail.com> 	 <01cf01c67b5c$d78bd130$a501a8c0@CAM.ARTIMI.COM> 	 <20060612131046.GC2129@calimero.vinschen.de> 	 <ba40711f0606121843n11ad2155g5fa37362e91c401e@mail.gmail.com>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00075.txt.bz2

On 6/12/06, Lev Bishop wrote:
> On 6/12/06, Corinna Vinschen wrote:
> >
> > I found that using WSASocket(!OVERLAPPED) instead of socket results in
> > sshd misbehaviour (scp takes a long time to start copying files, an
> > interactive logon doesn't print the prompt until the user presses the
> > return key).  I didn't try to debug this, lazy as I am.
>
> Strange. I don't run sshd, but I've been using this patch for a while
> now and not noticed any problems. Maybe I'll try installing sshd one
> of these days and see if I see those issues you describe.

Ok. I just did setup sshd, and I do see those issues, or something
similar (pressing the return key doesn't seem to help with the
interactive logon for me). I wonder what sshd does that everything
else i was using doesn't do.

L
