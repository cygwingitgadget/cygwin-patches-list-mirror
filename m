Return-Path: <cygwin-patches-return-4100-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4490 invoked by alias); 17 Aug 2003 16:44:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4468 invoked from network); 17 Aug 2003 16:44:13 -0000
Date: Sun, 17 Aug 2003 16:44:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Consider extensions for special names in managed mode
Message-ID: <20030817164413.GC9059@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030813083512.GG13155@linux_rln.harvest> <Pine.GSO.4.44.0308131014360.8046-200000@slinky.cs.nyu.edu> <20030813172801.GH3101@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030813172801.GH3101@cygbert.vinschen.de>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00116.txt.bz2

On Wed, Aug 13, 2003 at 07:28:01PM +0200, Corinna Vinschen wrote:
>On Wed, Aug 13, 2003 at 10:19:08AM -0400, Igor Pechtchanski wrote:
>> 2003-08-13  Igor Pechtchanski  <pechtcha@cs.nyu.edu>
>> 
>> 	* path.cc (special_name): Add checks for some specials
>> 	followed by a "." and a FIXME comment.
>
>Ok, I've applied it.  I guess Chris can work from that, too.

I saw the comment on the cygwin mailing list and had already written
a patch that also works with things like com1.sh.  It's checked in.

cgf
