Return-Path: <cygwin-patches-return-1938-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 15138 invoked by alias); 28 Feb 2002 20:43:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15076 invoked from network); 28 Feb 2002 20:43:48 -0000
Message-Id: <4.3.2.7.2.20020228211428.00a976f0@pop.free.fr>
X-Sender: christian.lestrade@pop.free.fr
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Fri, 01 Mar 2002 01:22:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: Christian LESTRADE <christian.lestrade@free.fr>
Subject: Re: Terminal input processing fix
In-Reply-To: <20020225181453.A29036@cygbert.vinschen.de>
References: <4.3.2.7.2.20020118224857.00aa3720@mail.oreka.com>
 <4.3.2.7.2.20020118224857.00aa3720@mail.oreka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-SW-Source: 2002-q1/txt/msg00295.txt.bz2

At 18:14 25/02/02 +0100, you wrote:
>So we could go ahead and apply your patch but... actually I would like
>to ask you to change it.  The reason is that the _POSIX_VDISABLE
>constant is typically defined in some header file in /usr/include.  As
>is the functionality of CC_EQUAL which is called CCEQ, at least in Linux.
>
>So what I'd like you to ask is, could you tweak your patch so that these
>macros are defined in some appropriate header files, e.g. sys/termios.h?

The _POSIX_VDISABLE and CCEQ defines doesn't (yet) exist in cygwin.

1. _POSIX_VDISABLE belongs to a set of constants not included yet in 
cygwin. Should I include it alone in sys/termios.h?

2. CCEQ is only defined in Linux in a BSD context and has not quite the 
same definition as my macro. Should I also include the CCEQ macro in 
sys/termios.h and adapt my code to use it?

Christian Lestrade
