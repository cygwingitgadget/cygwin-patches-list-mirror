Return-Path: <cygwin-patches-return-3307-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18037 invoked by alias); 11 Dec 2002 21:02:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18023 invoked from network); 11 Dec 2002 21:02:34 -0000
Date: Wed, 11 Dec 2002 13:02:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Small security patches
Message-ID: <20021211210349.GB31049@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3DF76981.86674258@ieee.org> <20021211192211.GD29798@redhat.com> <3DF7A670.E7BA1862@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DF7A670.E7BA1862@ieee.org>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00258.txt.bz2

On Wed, Dec 11, 2002 at 03:56:17PM -0500, Pierre A. Humblet wrote:
>Christopher Faylor wrote:
>
>> Shouldn't the global symbols be marked as "NO_COPY"?
>
>I am not sure why things are as they are.
>These symbols are initialized in do_global_ctors and never change.
>Are the constructors running again after a fork? If so, NO_COPY is fine.
>It would seem more efficient to copy than to rerun the constructors,
>but I probably overlook some factors.

Constructors are always run.  If you use a global constructor without a
NO_COPY then you just end up writing over the contents when the fork
completes.  So, if the constructor is setting things up correctly the
global should be NO_COPY.  Actually, if you can get away without using a
constructor that would be best.  Constructors are a noticeable part of
cygwin's startup cost.

cgf
