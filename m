Return-Path: <cygwin-patches-return-1808-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 25469 invoked by alias); 29 Jan 2002 03:48:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25408 invoked from network); 29 Jan 2002 03:48:00 -0000
Date: Mon, 28 Jan 2002 19:48:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Cc: cygwin-developers@cygwin.com
Subject: strace -p (was Re: include/sys/strace.h)
Message-ID: <20020129034747.GA7834@redhat.com>
Reply-To: cygwin-developers@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com, cygwin-developers@cygwin.com
References: <20020128170312.GB3669@redhat.com> <Pine.NEB.4.30.0201280938420.5761-100000@cesium.clock.org> <20020128181639.GB4930@redhat.com> <117546176069.20020128213346@logos-m.ru> <20020128190330.GB5721@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020128190330.GB5721@redhat.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q1/txt/msg00165.txt.bz2

On Mon, Jan 28, 2002 at 02:03:30PM -0500, Christopher Faylor wrote:
>We also need to resurrect the "attach to running process" capabilities
>that you (Egor) submitted a patch for, IIRC.
>
>I think I'll do that now.  I'm about to go into a boring meeting.

I just added this 'strace -p<cygwin pid>' should attach to a running cygwin
process.  You need the latest cygwin DLL, though.

cgf
