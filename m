Return-Path: <cygwin-patches-return-4064-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7514 invoked by alias); 10 Aug 2003 00:12:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7504 invoked from network); 10 Aug 2003 00:12:51 -0000
Date: Sun, 10 Aug 2003 00:12:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Checking integrity of installed packages in cygcheck
Message-ID: <20030810001250.GC13380@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030809161211.GB9514@redhat.com> <Pine.GSO.4.44.0308091553280.7386-100000@slinky.cs.nyu.edu> <20030810000733.GA13380@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030810000733.GA13380@redhat.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00080.txt.bz2

On Sat, Aug 09, 2003 at 08:07:33PM -0400, Christopher Faylor wrote:
>On Sat, Aug 09, 2003 at 03:59:00PM -0400, Igor Pechtchanski wrote:
>>On Sat, 9 Aug 2003, Christopher Faylor wrote:
>>
>>> [snip]
>>> Btw, have you considered some kind of rpm -f functionality?  That would
>>> allow a user to do a:
>>>
>>> cygcheck -f /usr/bin/ls.exe
>>> fileutils-4.1-2
>>>
>>> Also some kind of functionality which would allow cygcheck to query
>>> the same files as the web search would be really cool.  Something like
>>> a:
>>>
>>> cygcheck --whatprovides /usr/bin/ls.exe
>>>
>>> would be really useful.
>>
>>I'm not sure I see the difference between the two cases above.
>
>-f checks the installed database in /etc/setup/package.lst.gz (similar
>to rpm -f), --whatprovides checks the "database" on sources.redhat.com
>(similar to Red Hat's up2date?).  That's what I meant by "the same files
>as the web search".
>
>I don't see why -f wouldn't be relatively trivial to do since we know
                                                                  now
>have code in cygcheck which uncompresses and opens each of the package
>files.  --whatprovides would require a net query, of course.  That would
>be more complicated.

cgf
