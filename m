Return-Path: <cygwin-patches-return-2966-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 13630 invoked by alias); 15 Sep 2002 15:27:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13616 invoked from network); 15 Sep 2002 15:27:37 -0000
Message-ID: <20020915152737.22331.qmail@web20002.mail.yahoo.com>
Date: Sun, 15 Sep 2002 08:27:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
Subject: Re: `cygpath --version` missing a newline
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SW-Source: 2002-q3/txt/msg00414.txt.bz2

I've checked this in. I'll add the newlines to the other utils soon. 

I updated the ChangeLog and also used the ChangeLog as the CVS log... 
is that right? Or should there be no CVS log entries? (The sources.redhat.com 
guide just says to use "cvs commit".) Hmm, now that I look at what I did
with cvsweb it looks like they're sometimes descriptive ("import
winsup-2000-02-17 snapshot") and sometimes just one of the ChangeLog lines
("* cygcheck.cc: Reformat."). I'll try to do the same.

> From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
> To: cygwin-patches@cygwin.com
> Subject: `cygpath --version` missing a newline
> Date: Thu, 12 Sep 2002 23:39:05 -0400 (EDT)
> 
> Hi,
> `cygpath --version` is missing a trailing newline.  I'm attaching a patch.
> This probably doesn't merit a ChangeLog entry, but I'm providing one
> anyway, feel free to disregard it.  I also took the opportunity to factor
> out the short options array into a global variable.  I can split this into
> two separate patches, if necessary.
> 	Igor
> 
> 2002-09-12  Igor Pechtchanski <pechtcha@cs.nyu.edu>
> 	* cygpath.cc (options) New global variable.
> 	(main) Make short options global for easier change.
> 	(print_version) Add a missing newline.

__________________________________________________
Do you Yahoo!?
Yahoo! News - Today's headlines
http://news.yahoo.com
