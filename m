Return-Path: <cygwin-patches-return-4645-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18455 invoked by alias); 30 Mar 2004 21:30:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18446 invoked from network); 30 Mar 2004 21:30:04 -0000
Date: Tue, 30 Mar 2004 21:30:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Dr.Volker.Zell@oracle.com: Re: uxterm from xterm-185-3 and xfontsel crashing when running under cygserver support]
Message-ID: <20040330213002.GA16702@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <13859.1080657571@www59.gmx.net> <20040330153307.GK17229@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040330153307.GK17229@cygbert.vinschen.de>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q1/txt/msg00135.txt.bz2

On Tue, Mar 30, 2004 at 05:33:07PM +0200, Corinna Vinschen wrote:
>On Mar 30 16:39, Thomas Pfaff wrote:
>>Corinna Vinschen wrote:
>>>Do you have an appropriate patch?
>>
>>2004-03-30  Thomas Pfaff  <tpfaff@gmx.net>
>>
>>	* thread.h (pthread::init_mainthread): Add parameter forked.
>>	Set forked default to false..
>>	* thread.cc (MTinterface::fixup_after_fork): Call
>> 	pthread::init_mainthread with forked = true.
>>	(pthread::init_mainthread): Add parameter forked. Do not change thread self
>>	pointer when forked.
>
>Looks good.  Thank you.
>
>Chris, any objections?  Otherwise I'll apply it.

It looks good.  I've applied it with a minor formatting change.

cgf
