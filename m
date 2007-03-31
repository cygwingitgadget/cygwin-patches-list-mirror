Return-Path: <cygwin-patches-return-6053-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31705 invoked by alias); 31 Mar 2007 00:08:45 -0000
Received: (qmail 31681 invoked by uid 22791); 31 Mar 2007 00:08:44 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-87.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.87)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 31 Mar 2007 01:08:41 +0100
Received: by cgf.cx (Postfix, from userid 201) 	id AD2862B41A; Fri, 30 Mar 2007 20:08:39 -0400 (EDT)
Date: Sat, 31 Mar 2007 00:08:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: PATCH: Fix resource leak in cygpath.cc
Message-ID: <20070331000839.GA20464@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <460D91AE.8030203@codesourcery.com> <460D9252.3090708@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <460D9252.3090708@codesourcery.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q1/txt/msg00034.txt.bz2

Hi Mark,
On Fri, Mar 30, 2007 at 03:42:26PM -0700, Mark Mitchell wrote:
>Mark Mitchell wrote:
>> The cygpath utility calls FindFirstFile, but never calls FindClose.  As
>> a result, in leaks search handles.  When you're using it for just one
>> file, that's not a big deal, but if you feed it enough files, it gets
>> unhappy.  Also, if you've got a long running cygpath in one window, you
>> can't do file renames in named directories in another because cygpath
>> still has the handles open.
>> 
>> Here's a patch.  I don't claim to have tested this in any comprehensive
>> way, but I've played with it, and it fixes the problems I've been seeing.
>> 
>> Hope this helps,
>
>Bleck!  My first posting on this list, and I rudely attached the wrong
>file.  I'm very sorry.

Heh.  How dare you?  :-)

>Here's the right one.
>
>2007-03-30  Mark Mitchell  <mark@codesourcery.com>
>
>	* utils/cygpath.cc (get_long_path_name_w32impl): Close handles
>	returned by FindFirstFile.

Thanks for fixing this embarrassing bug.

I've applied the patch.

cgf
