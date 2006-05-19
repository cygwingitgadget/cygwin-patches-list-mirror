Return-Path: <cygwin-patches-return-5854-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2799 invoked by alias); 19 May 2006 20:18:00 -0000
Received: (qmail 2787 invoked by uid 22791); 19 May 2006 20:18:00 -0000
X-Spam-Check-By: sourceware.org
Received: from py-out-1112.google.com (HELO py-out-1112.google.com) (64.233.166.178)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 19 May 2006 20:17:57 +0000
Received: by py-out-1112.google.com with SMTP id o67so979520pye         for <cygwin-patches@cygwin.com>; Fri, 19 May 2006 13:17:56 -0700 (PDT)
Received: by 10.35.17.8 with SMTP id u8mr469751pyi;         Fri, 19 May 2006 13:17:56 -0700 (PDT)
Received: by 10.35.9.14 with HTTP; Fri, 19 May 2006 13:17:56 -0700 (PDT)
Message-ID: <ba40711f0605191317y235cf432t4588157fb26d97f0@mail.gmail.com>
Date: Fri, 19 May 2006 20:18:00 -0000
From: "Lev Bishop" <lev.bishop@gmail.com>
To: cygwin-patches@cygwin.com
Subject: Re: Open sockets non-overlapped?
In-Reply-To: <20060519153031.GB30564@trixie.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <ba40711f0605190819h4dfc5870l18a1919149a4f2d9@mail.gmail.com> 	 <20060519153031.GB30564@trixie.casa.cgf.cx>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00042.txt.bz2

On 5/19/06, Christopher Faylor wrote:
> On Fri, May 19, 2006 at 11:19:45AM -0400, Lev Bishop wrote:
> >Here's a trivial little patch for your consideration (while I wait for
> >my copyright assignment to go through).
> >
> >It makes it so that cygwin sockets can be passed usefully to windows
> >processes. Eg:
> >$ cmd /c dir > /dev/tcp/localhost/5001
>
> AFAIK, /dev/tcp/localhost is neither a linux nor a cygwin construction.

Did you try it?
(It's a bash construction).

Lev
