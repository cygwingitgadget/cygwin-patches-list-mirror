Return-Path: <cygwin-patches-return-2317-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 22579 invoked by alias); 5 Jun 2002 16:02:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22530 invoked from network); 5 Jun 2002 16:02:49 -0000
Date: Wed, 05 Jun 2002 09:02:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] _unlink() & rmdir() on /proc/*
Message-ID: <20020605160303.GB17074@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <11415277457.20020604143720@syntrex.com> <20020604153535.GA11056@redhat.com> <9429631277.20020604183634@syntrex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9429631277.20020604183634@syntrex.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00300.txt.bz2

On Tue, Jun 04, 2002 at 06:36:34PM +0200, Pavel Tsekov wrote:
>They are very small:
>
>syscalls.cc.diff and dir.cc.diff have 8 lines added.
>path.cc.diff has line one changed.
>
>Does this require an assignment ?

I took a look at the patches.  I don't think they need an assignment so
I checked them in.  I didn't check the rmdir one in as-is, since it
seemed like the rmdir function needed some modernizing.  I gave you
credit in the ChangeLog, though.

Thanks for the patch!
cgf
