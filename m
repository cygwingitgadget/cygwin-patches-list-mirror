Return-Path: <cygwin-patches-return-2211-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 21576 invoked by alias); 23 May 2002 04:25:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21562 invoked from network); 23 May 2002 04:25:35 -0000
Date: Wed, 22 May 2002 21:25:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: mount --version pathc
Message-ID: <20020523042546.GA1080@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.44.0205222248400.600-200000@iocc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.44.0205222248400.600-200000@iocc.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00195.txt.bz2

On Wed, May 22, 2002 at 10:49:11PM -0500, Joshua Daniel Franklin wrote:
>Here is a --version patch for mount.  I also alphabetized longopts,
>opts, and the getopt case statement.
>
>ChangeLog:
>
>2002-05-22  Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
>	* mount.cc (version) New global variable.
>	(usage) Standardize usage output. Accomodate new version option.
>	(print_version) New function.
>	(longopts) Accomodate new version option.
>	(opts) Ditto.
>	(main) Ditto.

Committed.  Thanks.

cgf
