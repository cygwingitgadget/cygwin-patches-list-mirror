Return-Path: <cygwin-patches-return-2531-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 19553 invoked by alias); 27 Jun 2002 16:58:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19505 invoked from network); 27 Jun 2002 16:58:00 -0000
Date: Thu, 27 Jun 2002 10:18:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: A minor patch to Makefile.in
Message-ID: <20020627165803.GC28018@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3D19F55E.3070800@netscape.net> <3D19F812.70509@netscape.net> <20020627152129.GA6961@redhat.com> <3D1B3783.7030201@netscape.net> <20020627160909.GE7598@redhat.com> <3D1B4293.30707@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D1B4293.30707@netscape.net>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00514.txt.bz2

On Thu, Jun 27, 2002 at 12:51:31PM -0400, Nicholas Wourms wrote:
>I stand corrected... As it turns out, my theory doesn't work anyway. 
>So, I will have configure check for the existance of gettext > 10.40 
>and any dependancies on libiconv.  I will work up a patch but I need to 
>know if this will require a copyright assignment, as undoubtly it will 
>entail more then 10 lines of configure script changes.  So if this is 
>the way you want to go, then let me know and I'll do so.

You're right.  You'll need a copyright assignment.

>On another note, I really think having seperate configure files for 
>every directory is a tad bit redundant.  Are there any plans to migrate 
>to Automake templates and/or a single configure script for the winsup tree?

Nope.  As someone who really detests automake, you can probably guess
why that would be so.

And, since every directory underneath winsup has different configuration
requirements, it really doesn't make much sense to merge them.  I really
don't see a big deal here.  There's nothing broken that requires fixing
as far as I can tell.

cgf
