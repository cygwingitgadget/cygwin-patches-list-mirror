Return-Path: <cygwin-patches-return-1803-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 12549 invoked by alias); 28 Jan 2002 18:16:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12501 invoked from network); 28 Jan 2002 18:16:34 -0000
Date: Mon, 28 Jan 2002 10:16:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: include/sys/strace.h
Message-ID: <20020128181639.GB4930@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20020128170312.GB3669@redhat.com> <Pine.NEB.4.30.0201280938420.5761-100000@cesium.clock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.NEB.4.30.0201280938420.5761-100000@cesium.clock.org>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q1/txt/msg00160.txt.bz2

On Mon, Jan 28, 2002 at 09:43:04AM -0800, Matt wrote:
>On Mon, 28 Jan 2002, Christopher Faylor wrote:
>
>> On Sun, Jan 27, 2002 at 11:03:12PM +1100, Robert Collins wrote:
>> >Chris, I'd actually kinda like to see this included, I can see it being
>> >handy from time to time.
>>
>> I don't agree.  It seems to me that this is easy enough to do with gdb.
>> I don't see any reason for it.
>
>The use case I see is when gdb hangs/crashes or the entire cygwin DLL
>hangs/crashes. In those instances, having a non-cygwin program that can
>monitor debug output would be highly useful.

Ok.  I'll add this.

However, your example doesn't make any sense to me.  I use the techniques
in how-to-debug-cygwin.txt and I've never had any problems.  There should
never issue of a hanging cygwin if you use these techniques.

If I think that a patch is just due to someone not understanding how to
use existing tools, which could arguably be the case here, then I will
resist adding it to the sources.

However, if a few people find this useful, I'll add it.  Just to be
clear, though, I don't want to see the macro in any checked in code.

cgf
