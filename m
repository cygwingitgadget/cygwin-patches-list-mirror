Return-Path: <cygwin-patches-return-2240-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 8348 invoked by alias); 28 May 2002 03:38:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8329 invoked from network); 28 May 2002 03:38:25 -0000
Date: Mon, 27 May 2002 20:38:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: ps help, version patch
Message-ID: <20020528033821.GA26746@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.44.0205272205260.728-200000@iocc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.44.0205272205260.728-200000@iocc.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00224.txt.bz2

On Mon, May 27, 2002 at 10:05:54PM -0500, Joshua Daniel Franklin wrote:
>Here is the --help, --version patch for ps. With, I hope, a proper
>ChangeLog.
>
>2002-05-13  Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
>
>	* ps.cc (prog_name): New global variable.
>	(longopts): Ditto.
>	(opts): Ditto.
>	(usage): New function.
>	(print_version): New function.
>	(main): Accomodate longopts and new --help, --version options.

Good formatting, wrong date == extremely minor problem.

Applied.

Thanks.

cgf
