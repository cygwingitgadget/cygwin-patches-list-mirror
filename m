Return-Path: <cygwin-patches-return-2298-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 8476 invoked by alias); 4 Jun 2002 01:31:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8449 invoked from network); 4 Jun 2002 01:31:42 -0000
Date: Mon, 03 Jun 2002 18:31:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: umount version patch
Message-ID: <20020604013148.GE1602@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.44.0206032021080.1096-200000@iocc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.44.0206032021080.1096-200000@iocc.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00281.txt.bz2

On Mon, Jun 03, 2002 at 08:21:34PM -0500, Joshua Daniel Franklin wrote:
>2002-06-03  Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
>
>	* umount.cc (version): New global variable.
>	(longopts): Accomodate new --version option.
>	(opts): Ditto.
>	(usage): Standardize usage output.
>	(print_version): New function.
>	(main): Accomodate --help, --version options.

Applied.

Thanks.
cgf
