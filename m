Return-Path: <cygwin-patches-return-4169-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19529 invoked by alias); 6 Sep 2003 02:03:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19142 invoked from network); 6 Sep 2003 02:03:04 -0000
Date: Sat, 06 Sep 2003 02:03:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygcheck: don't fail integrity check on empty package
Message-ID: <20030906020301.GA4981@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.56.0309052041170.7348@slinky.cs.nyu.edu> <Pine.GSO.4.56.0309052046590.7348@slinky.cs.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.56.0309052046590.7348@slinky.cs.nyu.edu>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00185.txt.bz2

On Fri, Sep 05, 2003 at 08:53:54PM -0400, Igor Pechtchanski wrote:
>On Fri, 5 Sep 2003, Igor Pechtchanski wrote:
>>This patch fixes the erroneous failure of "cygcheck -c" when the
>>package is empty (and thus the file list for it is missing), e.g.,
>>XFree86-base.
>
>Sorry, I've messed up the ChangeLog entry.  The correct one is included
>below.
>
>>==============================================================================
>>ChangeLog:
>2003-09-05 Igor Pechtchanski <pechtcha@cs.nyu.edu>
>
>* dump_setup.cc (check_package_files): Don't fail on empty package.

I'll check this in but I wonder if the printfs here shouldn't be fprintf(stderr
since they are sort of an error condition.

cgf
