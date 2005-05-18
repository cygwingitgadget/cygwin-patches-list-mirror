Return-Path: <cygwin-patches-return-5455-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15293 invoked by alias); 18 May 2005 01:19:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15187 invoked from network); 18 May 2005 01:19:42 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 18 May 2005 01:19:42 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id ED19D13C197; Tue, 17 May 2005 21:19:52 -0400 (EDT)
Date: Wed, 18 May 2005 01:19:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] gcc4 fixes
Message-ID: <20050518011952.GD9001@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <428A7520.7FD9925C@dessent.net> <20050517233150.GB9001@trixie.casa.cgf.cx> <428A971C.C5610F59@dessent.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428A971C.C5610F59@dessent.net>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q2/txt/msg00051.txt.bz2

On Tue, May 17, 2005 at 06:15:08PM -0700, Brian Dessent wrote:
>Christopher Faylor wrote:
>
>> Go ahead and check these in but please use GNU formatting conventions,
>> i.e., it's (char *) NULL, not (char *)NULL.  Actually, isn't just NULL
>> sufficient?
>
>I must have had C++ on the mind, thinking that the cast was necessary.
>
>> Sorry but no.  This is a workaround.  We need to fix the actual problem.
>
>Certainly.  I fully admit I have no real idea what the 'actual' problem
>is yet.

I don't either, obviously.  Nice job tracking it down, regardless.

cgf
