Return-Path: <cygwin-patches-return-2224-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 3344 invoked by alias); 26 May 2002 22:40:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3330 invoked from network); 26 May 2002 22:40:42 -0000
Date: Sun, 26 May 2002 15:40:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] improve performance of stat() operations (e.g. ls -lR)
Message-ID: <20020526224037.GA15076@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <FE045D4D9F7AED4CBFF1B3B813C85337676293@mail.sandvine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FE045D4D9F7AED4CBFF1B3B813C85337676293@mail.sandvine.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00208.txt.bz2

On Sun, May 26, 2002 at 05:50:13PM -0400, Don Bowman wrote:
>
>The attached patch adds a new CYGWIN environment variable, statquery. This
>causes stat() to use set_query_open(TRUE) all the time, which
>dramatically improves the performance on e.g. ls -lR operations or
>configure.
>For example, an ls -lR of the 'ntop' distribution goes from 34seconds
>to 2seconds on my computer on a local filesystem. The actual change
>is extremely trivial.

You should get the same effect by mounting directories or files with
either the -E or -X option.  And, the control is more pinpoint than an
environment variable.

cgf
