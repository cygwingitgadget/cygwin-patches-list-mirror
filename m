Return-Path: <cygwin-patches-return-2105-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18298 invoked by alias); 25 Apr 2002 03:10:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18247 invoked from network); 25 Apr 2002 03:10:15 -0000
Date: Wed, 24 Apr 2002 20:10:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] dtors run twice on dll detach (update)
Message-ID: <20020425031002.GC3195@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <FC169E059D1A0442A04C40F86D9BA7600C5EEF@itdomain003.itdomain.net.au> <20020425030632.GB3195@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020425030632.GB3195@redhat.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00089.txt.bz2

On Wed, Apr 24, 2002 at 11:06:32PM -0400, Christopher Faylor wrote:
>On Thu, Apr 25, 2002 at 12:34:33PM +1000, Robert Collins wrote:
>>So... as this has been contentious: Chris/Corinna - any objection to my
>>recommitting it?
>
>No:

Sorry.  Make that "Yes".  I have the same objections that I did before.

I'll review the patch in the next couple of days.

cgf

>On Fri, Apr 19, 2002 at 10:42:21AM -0400, Christopher Faylor wrote:
>*>If one of the functions is obsolete, it should be deleted.  That means
>*>that the patch does *not* look good.  It needs to be reviewed.
>
>cgf
