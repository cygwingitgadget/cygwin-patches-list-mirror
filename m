Return-Path: <cygwin-patches-return-3656-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10216 invoked by alias); 28 Feb 2003 16:46:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10207 invoked from network); 28 Feb 2003 16:46:20 -0000
Date: Fri, 28 Feb 2003 16:46:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Remove wrapper functions in pthread.cc
Message-ID: <20030228164622.GB9304@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.WNT.4.44.0302281442110.371-200000@algeria.intern.net> <1046445602.29087.18.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1046445602.29087.18.camel@localhost>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00305.txt.bz2

On Sat, Mar 01, 2003 at 02:20:03AM +1100, Robert Collins wrote:
>On Sat, 2003-03-01 at 00:53, Thomas Pfaff wrote:
>> This patch removes all wrapper functions in pthread.cc that only add an
>> additional function call. Export the functions in thread.cc instead.
>
>Please apply.

Woo hoo.  I've always wondered why these wrapper functions were necessary.

cgf
