Return-Path: <cygwin-patches-return-2728-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 2063 invoked by alias); 26 Jul 2002 08:59:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2042 invoked from network); 26 Jul 2002 08:59:51 -0000
Date: Fri, 26 Jul 2002 01:59:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: setgroups
Message-ID: <20020726105948.A30785@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20020726000410.00813de0@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20020726000410.00813de0@mail.attbi.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00176.txt.bz2

On Fri, Jul 26, 2002 at 12:04:10AM -0400, Pierre A. Humblet wrote:
> Corinna,
> 
> Here is setgroups.

Why did you add a class cygsidarray while there's already a class
cygsidlist?

I'm sorry but it would really be helpful if you could add a few
words about what you did.  The patch is not that small and
contains more than just a new function setgroups()...  E. g. what
is the rational to divide get_group_sidlist into three functions?

> I still need to declare it in an .h file.
> Should it be in src/newlib/libc/include/sys/unistd.h ?

What about adding it to newlib/libc/sys/cygwin/include/unistd.h?

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
