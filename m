Return-Path: <cygwin-patches-return-3373-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27499 invoked by alias); 10 Jan 2003 16:29:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27474 invoked from network); 10 Jan 2003 16:29:01 -0000
Date: Fri, 10 Jan 2003 16:29:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Make sleep and usleep a cancellation point
Message-ID: <20030110162936.GD25027@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.WNT.4.44.0301100943530.299-200000@algeria.intern.net> <1042189146.17813.2.camel@lifelesslap>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042189146.17813.2.camel@lifelesslap>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00022.txt.bz2

On Fri, Jan 10, 2003 at 07:59:06PM +1100, Robert Collins wrote:
>On Fri, 2003-01-10 at 19:53, Thomas Pfaff wrote:
>> This patch will make sleep and usleep a pthread cancellation point.
>
>Looks good to me. Please do a test case for them.

Btw, I *love* this test case policy.  It's great.

We should probably think about doing the same thing for every regression
we find.

Anyone interested in being a cygwin test suite czar?

cgf
