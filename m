Return-Path: <cygwin-patches-return-3670-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28196 invoked by alias); 5 Mar 2003 08:01:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28182 invoked from network); 5 Mar 2003 08:01:41 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Wed, 05 Mar 2003 08:01:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: Robert Collins <rbcollins@cygwin.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] add support for PTHREAD_MUTEX_NORMAL
In-Reply-To: <1046348989.2137.22.camel@localhost>
Message-ID: <Pine.WNT.4.44.0303050901080.247-100000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q1/txt/msg00319.txt.bz2



On Thu, 27 Feb 2003, Robert Collins wrote:

> On Thu, 2003-02-27 at 23:26, Thomas Pfaff wrote:
> > This patch adds support for PTHREAD_MUTEX_NORMAL (fast and
> > deadlocking) mutexes and slightly modifies the lock counter logic.
> > The counter now start at 0.
>
>
> I'll review these this weekend - if you haven't heard anything on
> Monday, please prod me :}.
>

Ping
