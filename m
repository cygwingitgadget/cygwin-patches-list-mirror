Return-Path: <cygwin-patches-return-1857-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18393 invoked by alias); 10 Feb 2002 04:37:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18349 invoked from network); 10 Feb 2002 04:37:49 -0000
Date: Sun, 10 Feb 2002 04:14:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: /proc and /proc/registry
Message-ID: <20020210043745.GA5128@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <008901c1b1be$80b36e70$0100a8c0@advent02>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <008901c1b1be$80b36e70$0100a8c0@advent02>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q1/txt/msg00214.txt.bz2

On Sat, Feb 09, 2002 at 11:07:09PM -0000, Chris January wrote:
>The attached patch (against cygwin-1.3.9-1/winsup/cygwin) adds support for a
>/proc virtual filesystem and a read-only version of /proc/registry. I've
>read http://cygwin.com/assign.txt but need to sort out the legalese before
>doing anything.
>Partically fufills Cygwin TODO item:
>2001-11-08    /proc filesystem    Nicos

Wow.  From a casual inspection, this looks pretty nice.

However, I didn't look at it too closely.  I don't want to be tainted if
you are unable to send in an assignment.  However, the selection of
methods, etc. seems fine.

The ChangeLog looked good, AFAICT.  The code formatting is not GNU
standard.  That will have to be rectified.  And, if/when the code is
incorporated into the cygwin DLL, the copyright info will have to be
changed to confirm to the rest of cygwin's source modules.

I wish I could get people to look at sending in an assigment *before*
they start doing work.  It would save a lot of time, I think.

Instead we'll now shortly be hearing from the "usual" people asking why
this isn't in cygwin already.

cgf
