Return-Path: <cygwin-patches-return-1712-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4949 invoked by alias); 16 Jan 2002 22:40:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4922 invoked from network); 16 Jan 2002 22:40:44 -0000
Date: Wed, 16 Jan 2002 14:40:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: newlib-patches@sources.redhat.com, cygwin-patches@cygwin.com
Subject: Re: strptime
Message-ID: <20020116224107.GA1804@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: newlib-patches@sources.redhat.com,
	cygwin-patches@cygwin.com
References: <177e01c19edc$88d9bf90$0200a8c0@lifelesswks>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177e01c19edc$88d9bf90$0200a8c0@lifelesswks>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q1/txt/msg00069.txt.bz2

On Thu, Jan 17, 2002 at 09:24:15AM +1100, Robert Collins wrote:
>Herewith, one patch for each list.
>
>Changelogs for quick glancing:
>Newlib:
>2002-01-17  Robert Collins  <rbtcollins@hotmail.com>
>
>        * libc/include/time.h: Add prototype for strptime for Cygwin.
>
>Cygwin:
>2002-01-17  Robert Collins  <rbtcollins@hotmail.com>
>
>        * times.cc: Run indent.
>        Add strptime function.

I'm not wild about some of the changes that indent made to times.cc.
A lot of the changes are nice but some of the formatting doesn't
seem right to me.

Can I ask where this strptime came from?  Is this a new work?  If
so maybe we want to just incorporate a strptime from FreeBSD.  An
in-use strptime would have a known track record and should have
most bugs shaken out of it.

cgf
