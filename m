Return-Path: <cygwin-patches-return-2151-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28415 invoked by alias); 4 May 2002 15:36:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28401 invoked from network); 4 May 2002 15:36:05 -0000
Date: Sat, 04 May 2002 08:36:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Bug in ln / cygwin1.dll
Message-ID: <20020504153612.GC29229@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <011901c1f2fb$1fbf5330$0100a8c0@advent02> <20020504042742.GI32261@redhat.com> <00c801c1f36d$73d55470$0100a8c0@advent02>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00c801c1f36d$73d55470$0100a8c0@advent02>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00135.txt.bz2

On Sat, May 04, 2002 at 02:13:16PM +0100, Chris January wrote:
>> >When I run 'make -f Makefile.cvs' with QT3, I find that ln segfaults
>trying
>> >to create a symlink. I've included the output of strace showing the
>problem,
>> >output of cygcheck and also the stackdump ln produces. I can reproduce
>this,
>> >so if you need any more information, please ask. The problem occurs with
>the
>> >latest Cygwin CVS.
>> >ln is 'ln (fileutils) 4.1'.
>> >cygwin is 'CYGWIN_NT-5.0 ADVENT02 1.3.11(0.52/3/2) 2002-05-03 15:18 i686
>> >unknown'
>>
>> You're using a locally built version of cygwin.  Please run it under gdb
>> and pinpoint where the problem is occurring.  You may find the techniques
>> in how-to-debug-cygwin.txt useful.
>
>This patch fixes the problem.

Why?

cgf
