Return-Path: <cygwin-patches-return-2188-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 22499 invoked by alias); 14 May 2002 05:16:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22485 invoked from network); 14 May 2002 05:16:37 -0000
Date: Mon, 13 May 2002 22:16:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: kill.cc version patch
Message-ID: <20020514051629.GA23896@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.44.0205131832330.224-200000@iocc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.44.0205131832330.224-200000@iocc.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00172.txt.bz2

On Mon, May 13, 2002 at 06:33:18PM -0500, Joshua Daniel Franklin wrote:
>Here is a version option patch against Chris' new kill.cc with signal
>listing.  It also adds a prog_name variable as a small way of helping
>prevent /bin/kill vs bash's kill confusion.
>
>ChangeLog:
>
>2002-05-13  Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
>	* kill.cc (prog_name) New global variable.
>	(usage) Standardize usage output. Add descriptions.
>	(print_version) New function.
>	(longopts) Accomodate new version option.
>	(opts) Ditto.
>	(main) Ditto.

I'd hoped that you'd finish the job with kill.  Applied.

Thanks,
cgf
