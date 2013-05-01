Return-Path: <cygwin-patches-return-7874-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14051 invoked by alias); 1 May 2013 01:28:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 14039 invoked by uid 89); 1 May 2013 01:28:26 -0000
X-Spam-SWARE-Status: No, score=-4.9 required=5.0 tests=AWL,BAYES_00,KHOP_THREADED,RP_MATCHES_RCVD,TW_AV autolearn=ham version=3.3.1
Received: from etr-usa.com (HELO etr-usa.com) (130.94.180.135)    by sourceware.org (qpsmtpd/0.84/v0.84-167-ge50287c) with ESMTP; Wed, 01 May 2013 01:28:25 +0000
Received: (qmail 66199 invoked by uid 13447); 1 May 2013 01:28:23 -0000
Received: from unknown (HELO [172.20.0.42]) ([107.4.26.51])          (envelope-sender <warren@etr-usa.com>)          by 130.94.180.135 (qmail-ldap-1.03) with SMTP          for <cygwin-patches@cygwin.com>; 1 May 2013 01:28:23 -0000
Message-ID: <51806FB3.5040902@etr-usa.com>
Date: Wed, 01 May 2013 01:28:00 -0000
From: Warren Young <warren@etr-usa.com>
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] DocBook XML toolchain modernization
References: <20130424185210.GE26397@calimero.vinschen.de> <51783EBC.30409@etr-usa.com> <20130425084305.GA29270@calimero.vinschen.de> <517F15AF.5080307@etr-usa.com> <20130430184703.GB6865@ednor.casa.cgf.cx> <51801469.9070606@etr-usa.com> <20130430190706.GC6865@ednor.casa.cgf.cx> <51802510.5000803@etr-usa.com> <20130430202737.GA1858@ednor.casa.cgf.cx> <51803D76.5010302@etr-usa.com> <20130501003154.GB3781@ednor.casa.cgf.cx>
In-Reply-To: <20130501003154.GB3781@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2013-q2/txt/msg00012.txt.bz2

On 4/30/2013 18:31, Christopher Faylor wrote:
>
> I don't think it's worth the
> effort and expense of duplicating Cygwin's CSS elsewhere

You might be mixing two of my proposals together.

This offer to provide a "FAQ body contents only" output would probably 
just be a ~10 line Perl script to extract the text between <body> and 
</body> in an input HTML file and store it in an output file, then tie 
the two together with a Makefile dependency.

The idea is that on your end, all you do is change the referent from 
.../winsup/doc/faq/faq.html to something like .../faq-body.html.

I have decided: the script shall be called bodysnatcher.pl. :)

Separately, I have proposed improving the styling of, e.g.:

	http://cygwin.com/cygwin-ug-net/cygwin-ug-net.html

I would prefer not to copy and hack on your CSS file.  I'd be happier if 
I could just reference it via URL.[1]  Unfortunately, while the standard 
DocBook XSL stylesheets output HTML that is easy to style with CSS (lots 
of classes, well-named divs, etc.) its names are all different from 
those you have used in your HTML.

Later, we can talk about using bodysnatcher.pl more broadly, to make a 
version of the user guide that will pour into your new navbar HTML 
files.  At that point, we'll need to talk about a way to merge our two 
CSS variants.

By the way, the top page of cygwin.com has two different FAQ links.  The 
one that points to /faq/faq-nochunks.html should probably point to 
/faq.html.

> ...new DOCTOOL tags.  I don't know who first thought that adding
> these was a good idea

*shrug*

It's a common practice[2] to have verbose comments on public interfaces, 
and to format them in a way to make reference documentation generation 
easy.  Doxygen knows one common syntax for this, and its output is 
beautiful and useful.

Here's a Doxygen based reference manual I created:

     http://tangentsoft.net/mysql++/doc/html/refman/

If you decide it's better to fully extract the API docs from the code, I 
can go with that instead.

> if Corinna
> agrees when she gets back, I'd like to just get rid of these.

I have no problem waiting on some of this stuff until then.  I'm not in 
any hurry.  I'm just asking questions as they occur to me so I don't get 
blocked later when I decide to start making changes.



[1] http://goo.gl/6U6gG
[2] https://en.wikipedia.org/wiki/Comparison_of_documentation_generators
