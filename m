Return-Path: <cygwin-patches-return-3848-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25772 invoked by alias); 6 May 2003 13:50:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25759 invoked from network); 6 May 2003 13:50:42 -0000
Message-ID: <3EB7BDFA.8FBFE908@ieee.org>
Date: Tue, 06 May 2003 13:50:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix nanosleep
References: <Pine.WNT.4.44.0305061513150.1572-200000@algeria.intern.net> <20030506133450.GB3312@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q2/txt/msg00075.txt.bz2

Christopher Faylor wrote:

> >
> >2002-05-06 Thomas Pfaff <tpfaff@gmx.net>
> >
> >* signal.cc (nanosleep): Do not wait twice for signal arrival.
> 
> Please check this in.  Looks like an old bug.
> 
> cgf

Looking at the date above, the fix could even be older than the bug. 

Pierre
