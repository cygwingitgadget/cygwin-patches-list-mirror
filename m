Return-Path: <cygwin-patches-return-3856-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25787 invoked by alias); 16 May 2003 12:13:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25724 invoked from network); 16 May 2003 12:13:03 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Message-ID: <3EC4D5A0.7020005@gmx.net>
Date: Fri, 16 May 2003 12:13:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygpatches <cygwin-patches@cygwin.com>
Subject: Re: [RFA] enable dynamic (thread safe) reents
References: <Pine.WNT.4.44.0305160915170.1356-200000@algeria.intern.net>
In-Reply-To: <Pine.WNT.4.44.0305160915170.1356-200000@algeria.intern.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q2/txt/msg00083.txt.bz2

Thomas Pfaff wrote:

> While single threaded apps should keep run without problems (_impure_ptr
> is still used for the mainthread) multithreaded apps should be recompiled
> to get the full power of the thread safe reents. This is due the
> fact that _RRENT is used in some newlib headers directly. Unfortunately
> this affects also static libs, therefore this is will be a longer
> transition.
> 

TTTT,

this will only affect stdio

stdio.h:147:#define     stdin   (_REENT->_stdin)
stdio.h:148:#define     stdout  (_REENT->_stdout)
stdio.h:149:#define     stderr  (_REENT->_stderr)

and i consider this harmless.

Thomas


