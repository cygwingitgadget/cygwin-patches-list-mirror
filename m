Return-Path: <cygwin-patches-return-7496-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20173 invoked by alias); 26 Aug 2011 02:10:28 -0000
Received: (qmail 20163 invoked by uid 22791); 26 Aug 2011 02:10:27 -0000
X-SWARE-Spam-Status: No, hits=-0.1 required=5.0	tests=AWL,BAYES_20,SPF_NEUTRAL
X-Spam-Check-By: sourceware.org
Received: from smtp0.epfl.ch (HELO smtp0.epfl.ch) (128.178.224.219)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Fri, 26 Aug 2011 02:10:08 +0000
Received: (qmail 7835 invoked by uid 107); 26 Aug 2011 02:10:05 -0000
Received: from 76-10-180-162.dsl.teksavvy.com (HELO discarded) (76.10.180.162) (authenticated)  by smtp0.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPA; Fri, 26 Aug 2011 04:10:06 +0200
Message-ID: <4E57007D.2040802@cs.utoronto.ca>
Date: Fri, 26 Aug 2011 02:10:00 -0000
From: Ryan Johnson <ryan.johnson@cs.utoronto.ca>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20110624 Thunderbird/5.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Extend faq.using to discuss fork failures
References: <4E570027.9050300@cs.utoronto.ca>
In-Reply-To: <4E570027.9050300@cs.utoronto.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q3/txt/msg00072.txt.bz2

Ooops. Mailer hiccup. Please ignore this one.

On 25/08/2011 10:08 PM, Ryan Johnson wrote:
> Hi all,
>
> Based on the feedback on cygwin-dev, I've put together a revised pair 
> of faq.using entries: one listing briefly the symptoms of fork 
> failures and what to do about it, and the other giving some details 
> about why fork fails (sometimes in spite of everything we do to 
> compensate).
>
>         * faq-using.xml (faq.using.fixing-fork-failures): Add.
>         (faq.using.why-fork-fails): Add.
>
> Thoughts?
> Ryan
