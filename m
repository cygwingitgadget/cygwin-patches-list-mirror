Return-Path: <cygwin-patches-return-2609-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 32424 invoked by alias); 5 Jul 2002 17:10:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32404 invoked from network); 5 Jul 2002 17:10:38 -0000
Date: Fri, 05 Jul 2002 10:10:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] pthread_key patch
Message-ID: <20020705171052.GF30783@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.WNT.4.44.0207050848100.224-100000@algeria.intern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.WNT.4.44.0207050848100.224-100000@algeria.intern.net>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00057.txt.bz2

On Fri, Jul 05, 2002 at 08:50:21AM +0200, Thomas Pfaff wrote:
>If somebody is interested why if find this patch neccessary with a posix
>threaded gcc could read
>http://cygwin.com/ml/cygwin-patches/2002-q2/msg00214.html

Can you summarize why you need to explicitly run destructors on process
detach?  It seems like this should happen automatically anyway.  I assume
that you're accessing thread-local storage on thread detach, so that's
why you need to do things then.  Process detach on the other hand...

cgf
