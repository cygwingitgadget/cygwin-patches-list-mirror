Return-Path: <cygwin-patches-return-5860-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10320 invoked by alias); 21 May 2006 14:58:11 -0000
Received: (qmail 10306 invoked by uid 22791); 21 May 2006 14:58:11 -0000
X-Spam-Check-By: sourceware.org
Received: from py-out-1112.google.com (HELO py-out-1112.google.com) (64.233.166.179)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 21 May 2006 14:58:10 +0000
Received: by py-out-1112.google.com with SMTP id o67so1289754pye         for <cygwin-patches@cygwin.com>; Sun, 21 May 2006 07:56:53 -0700 (PDT)
Received: by 10.35.49.4 with SMTP id b4mr2629720pyk;         Sun, 21 May 2006 07:56:53 -0700 (PDT)
Received: by 10.35.30.7 with HTTP; Sun, 21 May 2006 07:56:53 -0700 (PDT)
Message-ID: <ba40711f0605210756l74ecdd59qc0c6eff214b54fb4@mail.gmail.com>
Date: Sun, 21 May 2006 14:58:00 -0000
From: "Lev Bishop" <lev.bishop@gmail.com>
To: cygwin-patches@cygwin.com
Subject: Re: Getting the pipe guard
In-Reply-To: <ba40711f0605210754s7a10f603k79d883f4b1b6748d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <ba40711f0605201843g3ed55755ue3140fd2b1b66acb@mail.gmail.com> 	 <20060521052641.GA17087@trixie.casa.cgf.cx> 	 <ba40711f0605210754s7a10f603k79d883f4b1b6748d@mail.gmail.com>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00048.txt.bz2

> On 5/21/06, Christopher Faylor wrote:
>
> > I've checked in a variation of the above plus some modifications to
> > pipe.cc which prevent some handle stomping and may make things work
> > better.

Did you actually check in a change to select.cc? I'm not seeing it.
(But I'm not all that good with cvs so maybe it's my fault)

L
