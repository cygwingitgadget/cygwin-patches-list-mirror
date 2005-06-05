Return-Path: <cygwin-patches-return-5511-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30927 invoked by alias); 5 Jun 2005 03:10:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30917 invoked by uid 22791); 5 Jun 2005 03:10:40 -0000
Received: from c-66-30-17-189.hsd1.ma.comcast.net (HELO cgf.cx) (66.30.17.189)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Sun, 05 Jun 2005 03:10:40 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id E468613C28E; Sat,  4 Jun 2005 23:10:38 -0400 (EDT)
Date: Sun, 05 Jun 2005 03:10:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Loading cygwin1.dll from MinGW and MSVC
Message-ID: <20050605031038.GA7230@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1117839489.5031.23.camel@fulgurite> <cb51e2e050604175349d5e698@mail.gmail.com> <20050605005955.GC2706@trixie.casa.cgf.cx> <Pine.GSO.4.61.0506042302550.15703@slinky.cs.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.61.0506042302550.15703@slinky.cs.nyu.edu>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q2/txt/msg00107.txt.bz2

On Sat, Jun 04, 2005 at 11:09:10PM -0400, Igor Pechtchanski wrote:
>On Sat, 4 Jun 2005, Christopher Faylor wrote:
>
>> On Sat, Jun 04, 2005 at 05:53:56PM -0700, Joshua Daniel Franklin wrote:
>> >On 6/3/05, Max Kaehn wrote:
>> >>This patch contains the changes to make it possible to dynamically load
>> >>cygwin1.dll from MinGW and MSVC applications.  The changes to dcrt0.cc
>> >>are minimal and only affect cygwin_dll_init().  I've also added a MinGW
>> >>test program to testsuite and a FAQ so people will be able to locate
>> >>the test program easily.
>> >
>> >Assuming the code patches are fine, instead of a new section could we
>> >just add your FAQ hint to "How do I link against `cygwin1.dll' with
>> >Visual Studio?" <http://cygwin.com/faq/faq_toc.html#TOC102> The title
>> >could be changed to something like "How do I use `cygwin1.dll' with
>> >MinGW or Visual Studio?"
>> >
>> >I'm a little torn since I'm not sure this is actually frequently asked
>> >but it's certainly good to have the info.  Ideally I can put it in the
>> >User's Guide.
>>
>> Oops.  I just applied the patch to the doc area.  This is entirely your call.
>> I should have waited for your approval.
>>
>> If you want to me to revert the patch, please let me know.  Otherwise, please
>> just massage it as you see fit.
>>
>> FWIW, I think this does qualify as both a FAQ and a user's guide addition.
>
>And is much appreciated.  This is very useful functionality, and somebody
>had to do it, so Max did.  Thanks.

Yep.  There's another gold star coming as soon as everything is in.

cgf
