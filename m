Return-Path: <cygwin-patches-return-3456-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11394 invoked by alias); 23 Jan 2003 12:32:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11381 invoked from network); 23 Jan 2003 12:32:47 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Thu, 23 Jan 2003 12:32:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: Robert Collins <rbcollins@cygwin.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] a new pthread_cond implementation
In-Reply-To: <1043324936.27382.5.camel@lifelesslap>
Message-ID: <Pine.WNT.4.44.0301231330150.314-100000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q1/txt/msg00105.txt.bz2



On Thu, 23 Jan 2003, Robert Collins wrote:

> On Thu, 2003-01-23 at 23:21, Thomas Pfaff wrote:
>
>
> > 4. The spec requires that the mutex which is used with the condition
> > shall be locked by the calling thread. The current code does not check
> > this and will additionally create the mutex if it initialized with
> > PTHREAD_MUTEX_INITIALIZER. The opengroup spec suggests EPERM under that
> > condition.
>
> The spec only requires this for pthread_cond_wait, not for all
> pthread_cond_ calls. I hadn't noticed the EPERM suggestion.
>

I am sorry about being unclear. I meant this only for cond_[timed]wait.
All other calls do not contain a mutex parameter.

Thomas
