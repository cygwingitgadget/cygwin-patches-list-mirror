Return-Path: <cygwin-patches-return-3655-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2894 invoked by alias); 28 Feb 2003 15:29:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2866 invoked from network); 28 Feb 2003 15:29:49 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Fri, 28 Feb 2003 15:29:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: Robert Collins <rbcollins@cygwin.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Remove wrapper functions in pthread.cc
In-Reply-To: <1046445602.29087.18.camel@localhost>
Message-ID: <Pine.WNT.4.44.0302281624360.396-100000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q1/txt/msg00304.txt.bz2



On Fri, 28 Feb 2003, Robert Collins wrote:

> On Sat, 2003-03-01 at 00:53, Thomas Pfaff wrote:
> > This patch removes all wrapper functions in pthread.cc that only add an
> > additional function call. Export the functions in thread.cc instead.
>
> Please apply.
>

Impossible until you have reviewed the other patches ;-)

Thomas
