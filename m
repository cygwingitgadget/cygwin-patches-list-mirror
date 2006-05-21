Return-Path: <cygwin-patches-return-5858-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3372 invoked by alias); 21 May 2006 13:56:58 -0000
Received: (qmail 3362 invoked by uid 22791); 21 May 2006 13:56:57 -0000
X-Spam-Check-By: sourceware.org
Received: from py-out-1112.google.com (HELO py-out-1112.google.com) (64.233.166.181)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 21 May 2006 13:56:55 +0000
Received: by py-out-1112.google.com with SMTP id o67so1282008pye         for <cygwin-patches@cygwin.com>; Sun, 21 May 2006 06:56:53 -0700 (PDT)
Received: by 10.35.88.17 with SMTP id q17mr3248336pyl;         Sun, 21 May 2006 06:56:53 -0700 (PDT)
Received: by 10.35.30.7 with HTTP; Sun, 21 May 2006 06:56:53 -0700 (PDT)
Message-ID: <ba40711f0605210656p10c0fc86g2110a835789521d3@mail.gmail.com>
Date: Sun, 21 May 2006 13:56:00 -0000
From: "Lev Bishop" <lev.bishop@gmail.com>
To: cygwin-patches@cygwin.com
Subject: Re: Getting the pipe guard
In-Reply-To: <20060521052641.GA17087@trixie.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <ba40711f0605201843g3ed55755ue3140fd2b1b66acb@mail.gmail.com> 	 <20060521052641.GA17087@trixie.casa.cgf.cx>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00046.txt.bz2

On 5/21/06, Christopher Faylor wrote:
> The above code seems to be needed but I can't see how it could affect the
> non-blocking case since "howlong" is only set in the blocking case.

It affects the nonblocking case because it stops a blocking reader
from sneaking in between a nonblocking reader returning from
ready_for_read() and when the nonblocking reader actually does the
read.

L
