Return-Path: <cygwin-patches-return-6128-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19483 invoked by alias); 18 Jul 2007 15:10:10 -0000
Received: (qmail 19472 invoked by uid 22791); 18 Jul 2007 15:10:10 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-128.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.128)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 18 Jul 2007 15:10:08 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 4A00E2B352; Wed, 18 Jul 2007 11:10:16 -0400 (EDT)
Date: Wed, 18 Jul 2007 15:10:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Doc change request
Message-ID: <20070718151016.GB16658@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20070717040309.GA29644@trixie.casa.cgf.cx> <469E2C57.3A8BD304@dessent.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <469E2C57.3A8BD304@dessent.net>
User-Agent: Mutt/1.5.15 (2007-04-06)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q3/txt/msg00003.txt.bz2

On Wed, Jul 18, 2007 at 08:05:59AM -0700, Brian Dessent wrote:
>Christopher Faylor wrote:
>> Could I ask someone to do a search and replace on the docs and
>> change all occurrences of /usr/man and /usr/doc to /usr/share/man
>> and /usr/share/doc?
>> 
>> Brian, do you have time to do this?  I think you touched the
>> documentation list so you're "it".
>
>I can only find a total of three references to either directory,
>and two of them mention it the context of "this was the old location":
>
>faq-resources.xml-15-list what man pages the package includes.)  Some older packages still keep
>faq-resources.xml:16:their documentation in <literal>/usr/doc/</literal>
>faq-resources.xml-17-instead of <literal>/usr/share/doc/</literal>.
>
>setup-net.sgml:235:Relevant documentation can be found in the <literal>/usr/doc/Cygwin/</literal> 
>setup-net.sgml-236-or <literal>/usr/share/doc/Cygwin/</literal> directory.
>
>The only remaining one is a glancing reference in the FAQ to rxvt,
>and it needs cleaning up anyway as it refers to ash.  If the attached
>fix is OK I will update the htdocs copy too.
>
>faq-using.xml-864-<para>Don't invoke as simply ``rxvt'' because that will run /bin/sh (really
>faq-using.xml-865-ash) which is not a good interactive shell.  For details see
>faq-using.xml:866:<literal>/usr/doc/Cygwin/rxvt-&lt;ver&gt;.README</literal>.
>
>Unless my grep-fu failed that's it.

Looks good to me.  Thanks for doing this.

cgf
