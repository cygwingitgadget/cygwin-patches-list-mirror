Return-Path: <cygwin-patches-return-1932-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28319 invoked by alias); 28 Feb 2002 14:53:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28277 invoked from network); 28 Feb 2002 14:53:47 -0000
Date: Thu, 28 Feb 2002 07:05:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Thread.h failure on
Message-ID: <20020228145345.GC19976@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <FC169E059D1A0442A04C40F86D9BA76008AADA@itdomain003.itdomain.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FC169E059D1A0442A04C40F86D9BA76008AADA@itdomain003.itdomain.net.au>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q1/txt/msg00289.txt.bz2

On Fri, Mar 01, 2002 at 01:37:43AM +1100, Robert Collins wrote:
>Is this patch needed to solve
>
>In file included from ../../../../../src/winsup/cygwin/dtable.h:14,
>                 from ../../../../../src/winsup/cygwin/cygheap.cc:19:
>../../../../../src/winsup/cygwin/thread.h:57: field `_grp' has incomplete type
>make: *** [cygheap.o] Error 1
>
>or is something else wrong?

Something else is wrong.

cgf
