Return-Path: <cygwin-patches-return-1955-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17673 invoked by alias); 7 Mar 2002 01:40:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17637 invoked from network); 7 Mar 2002 01:40:53 -0000
Date: Wed, 06 Mar 2002 19:04:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch for cd .../. bug
Message-ID: <20020307014051.GA25480@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <012301c1c570$8af537e0$0100a8c0@advent02> <20020307004423.GA24387@redhat.com> <02df01c1c576$4a534af0$0200a8c0@lifelesswks>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02df01c1c576$4a534af0$0200a8c0@lifelesswks>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q1/txt/msg00312.txt.bz2

On Thu, Mar 07, 2002 at 12:20:36PM +1100, Robert Collins wrote:
>Anyway, it seems reasonable to me to use unix behaviour for cygwin with
>this.

Ok.  I guess you're right.  This is the same thing as disallowing the
windows idiocy of foo/. succeeding when foo is a file.

I just added a small patch to cause the return of ENOENT on a run of
dots.  AFAICT, Windows doesn't allow you to create such a file or
directory.

cgf
