Return-Path: <cygwin-patches-return-3644-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15268 invoked by alias); 28 Feb 2003 04:59:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15259 invoked from network); 28 Feb 2003 04:59:16 -0000
Message-Id: <3.0.5.32.20030227235437.0080a480@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net
Date: Fri, 28 Feb 2003 04:59:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: access () and path.cc
In-Reply-To: <20030228043623.GC23158@redhat.com>
References: <3.0.5.32.20030227230453.007d3a60@mail.attbi.com>
 <3.0.5.32.20030227230453.007d3a60@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q1/txt/msg00293.txt.bz2

At 11:36 PM 2/27/2003 -0500, you wrote:
>Pierre,
>You and Corinna are giving me a headache.  :-)

My immediate access () problem can be fixed by replacing 
real_path by fn in the stat_worker call.

Problem #1 is a real bug, should be easy to fix, and may not
show up anywhere anyway, so not urgent.

Problems #2 & 3 can be solved by 
>For instance, wouldn't all this be alleviated just by using
>cfg->get_name() rather than cfg->get_win32_name in the stat functions?
at the expense of efficiency (most of the time).
But efficiency can be revisited after you integrate your changes.

BTW, I was looking at the path/fhandler code and came to the tentative
conclusion that it shouldn't be necessary to keep both a Windows path 
and a Unix path in the fhandler structures.
For the files understood by Windows, I think the Windows path is enough.
For the other files (most /dev, /proc), the Posix path should be OK.

Pierre
