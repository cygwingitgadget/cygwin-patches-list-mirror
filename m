Return-Path: <cygwin-patches-return-2062-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 31355 invoked by alias); 15 Apr 2002 15:42:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31337 invoked from network); 15 Apr 2002 15:42:01 -0000
Date: Mon, 15 Apr 2002 08:42:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Workaround patch for MS CLOSE_WAIT bug
Message-ID: <20020415154209.GG6372@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20020414152944.007ec460@mail.attbi.com> <20020415141743.N29277@cygbert.vinschen.de> <20020415150129.GA6372@redhat.com> <3CBAF313.1438CF6C@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3CBAF313.1438CF6C@ieee.org>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00046.txt.bz2

On Mon, Apr 15, 2002 at 11:34:43AM -0400, Pierre A. Humblet wrote:
>Christopher Faylor wrote:
>>It looks like the patch will do the job but I would like to be
>>convinced that there is no other way around this problem.  If I'm
>>reading this correctly, this change requires modifying any code which
>>uses cygwin.  That's something we should try to avoid at all costs.
>
>I second that 100%.  My proposal *allows* porters to avoid CLOSE_WAIT
>by making some changes in daemons, but none in the children processes.
>No change is required anywhere.  The additional Cygwin functionality
>would be invisible to applications that don't explicitly use it.

How can you second that 100% and then talk about how people have to
change ther code to accomodate cygwin?  The fact that it is server code
rather than client code really doesn't matter.

Again, I don't like adding cygwin-specific features that mean mucking
with source code that works perfectly on unix.  The goal of cygwin is to
avoid ifdef's and just allow configure/make/make install.

It may well be that your solution is the best that we can hope for but
I don't want to see it included in the source until I'm convinced of
that fact.

cgf
