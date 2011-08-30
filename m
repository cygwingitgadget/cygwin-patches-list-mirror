Return-Path: <cygwin-patches-return-7503-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9196 invoked by alias); 30 Aug 2011 14:58:54 -0000
Received: (qmail 9185 invoked by uid 22791); 30 Aug 2011 14:58:52 -0000
X-SWARE-Spam-Status: No, hits=-1.6 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,TW_GJ,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm30.bullet.mail.sp2.yahoo.com (HELO nm30.bullet.mail.sp2.yahoo.com) (98.139.91.100)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Tue, 30 Aug 2011 14:58:37 +0000
Received: from [98.139.91.70] by nm30.bullet.mail.sp2.yahoo.com with NNFMP; 30 Aug 2011 14:58:36 -0000
Received: from [98.136.185.40] by tm10.bullet.mail.sp2.yahoo.com with NNFMP; 30 Aug 2011 14:58:36 -0000
Received: from [127.0.0.1] by smtp101.mail.gq1.yahoo.com with NNFMP; 30 Aug 2011 14:58:36 -0000
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from cgf.cx (cgf@108.20.226.16 with login)        by smtp101.mail.gq1.yahoo.com with SMTP; 30 Aug 2011 07:58:32 -0700 PDT
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id D35DD4A89BF	for <cygwin-patches@cygwin.com>; Tue, 30 Aug 2011 10:58:27 -0400 (EDT)
Date: Tue, 30 Aug 2011 14:58:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Extend faq.using to discuss fork failures
Message-ID: <20110830145827.GB2790@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4E570031.4080800@cs.utoronto.ca> <20110830090020.GE30452@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110830090020.GE30452@calimero.vinschen.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q3/txt/msg00079.txt.bz2

On Tue, Aug 30, 2011 at 11:00:20AM +0200, Corinna Vinschen wrote:
>Hi Ryan,
>
>Thanks for the FAQ entry.  I had a look now, finally.  Two nits:
>
>On Aug 25 22:08, Ryan Johnson wrote:
>> Index: winsup/doc/faq-using.xml
>> ===================================================================
>> RCS file: /cvs/src/src/winsup/doc/faq-using.xml,v
>> retrieving revision 1.35
>> diff -u -r1.35 faq-using.xml
>> --- winsup/doc/faq-using.xml	4 Aug 2011 18:25:41 -0000	1.35
>> +++ winsup/doc/faq-using.xml	26 Aug 2011 01:58:44 -0000
>> @@ -1199,3 +1199,92 @@
>>  </listitem>
>>  </itemizedlist></para>
>>  </answer></qandaentry>
>> +<qandaentry id='faq.using.fixing-fork-failures'>
>> +  <question><para>Calls to <literal>fork</literal> fail a lot. How can
>> +  I fix the problem?</para></question>

I'd prefer a simple "How do I fix fork failures?"

>> +  <answer>
>> +
>> +  <para>Unix-like applications make extensive use of
>> +  <literal>fork</literal>, a function which spawns an exact copy of
>> +  the running process. Notable fork-using applications include bash
>> +  (and bash scripts), emacs, gcc, make, perl, python, and
>> +  ruby. Unfortunately, the Windows ecosystem is quite hostile to a
>> +  reliable fork implementation, leading to error messages such as:</para>

I'd prefer just going straight to the solution without worrying about
the theory or the ecosystem.  If more discussion is needed, as Corinna
says, point elsewhere.

So, a listing of potential errors followed by a succint explanation of
how to fix them is what I'd like to see.  You can move the "Windows ecosystem"
comments to the next section.

>> +  <para><itemizedlist>
>> +    <listitem>unable to remap <emphasis>$dll</emphasis> to same address as parent</listitem>
>> +    <listitem>couldn't allocate heap </listitem>
>> +    <listitem>died waiting for dll loading </listitem>
>> +    <listitem>child -1 - died waiting for longjmp before initialization</listitem>
>> +    <listitem>STATUS_ACCESS_VIOLATION </listitem>
>> +    <listitem>resource temporarily unavailable </listitem>
>> +  </itemizedlist></para>
>> +  <para>If you find that frequent fork failures interfere with normal
>> +  use of cygwin, please try the following: </para>

Please just use something like "Potential solutions for the above errors:"

>> +  <para><itemizedlist>
>> +    <listitem>Restart whatever process is trying (and failing) to use
>> +    <literal>fork</literal>. Sometimes Windows sets up a process
>> +    environment that is even more hostile to fork than usual.</listitem>
>> +    <listitem>Ensure that you have eliminated (not just disabled) all
>> +    software on the BLODA (see <ulink
>> +    url="http://cygwin.com/faq/faq.using.html#faq.using.bloda"
>> +    />)</listitem>
>> +    <listitem>Install the 'rebase' package, read its README in
>> +    <literal>/usr/share/doc/Cygwin</literal>, and follow the
>> +    instructions there to run 'rebaseall'.</listitem>
>
>The rebase package is always installed since it's part of the Base
>category.  This entry should be rephrased accordingly.
>
>> +    </itemizedlist></para>
>> +  <para>Please note that installing new packages or updating existing
>> +  ones often undoes the effects of rebaseall and cause fork failures
>> +  to reappear. If so, just run rebaseall again.
>> +  </para></answer>
>> +</qandaentry>
>> +<qandaentry id='faq.using.why-fork-fails'>
>> +  <question><para>Why does <literal>fork</literal> fail so much,
>> +  anyway? (or: Why does <literal>fork</literal> still fail even though
>> +  I ran rebaseall?)</para></question>
>> +  <answer>
>> +  <para>The semantics of <literal>fork</literal> require that a forked
>> +  child process have <emphasis>exactly</emphasis> the same address
>> +  space layout as its parent. However, Windows provides no native
>> +  support for cloning address space between processes and several
>> +  features actively undermine a reliable <literal>fork</literal>
>> +  implementation.
>
>Everything else which follows from here is a good description of the
>inner workings, but that shouldn't go into the FAQ.  What about creating
>a link to the user's guide "Process Creation" section here.  The technical
>details could then go into the "Process Creation" section.

I agree.  I should have thought of that when I mentioned making two
sections.

cgf
