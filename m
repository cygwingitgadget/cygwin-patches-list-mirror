Return-Path: <cygwin-patches-return-1915-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28125 invoked by alias); 27 Feb 2002 16:25:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28080 invoked from network); 27 Feb 2002 16:25:31 -0000
Date: Wed, 27 Feb 2002 08:55:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: help/version patches
Message-ID: <20020227162528.GA2205@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <FC169E059D1A0442A04C40F86D9BA76008AABC@itdomain003.itdomain.net.au> <20020227045945.5521.qmail@web20009.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020227045945.5521.qmail@web20009.mail.yahoo.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q1/txt/msg00272.txt.bz2

On Tue, Feb 26, 2002 at 08:59:45PM -0800, Joshua Daniel Franklin wrote:
>Well, except that that loop does away with the whole point--eating the
>trailing '$'. Here's another go. I tested it with "$Revision$", 
>"$Revision:$", "$Revision: $ ", "$Revision: 1.22 $ ", and "$Revision: 1.2 2 $ "
>(in the unlikely event of a version number with spaces) and it does the right
>thing on each.

There's no need for a loop.  There really shouldn't be any need to
accommodate the missing colon but it doesn't hurt too much to add a test
case.

I've checked in a modified version of your patch.  I cleaned up some of
the non-GNU formatting, added a ChangeLog, and added a "print_version"
function which parses the 'version' array for version info.

I appreciate the submission very much but, next time, I would also
appreciate a ChangeLog and more attention to formatting issues.

cgf
