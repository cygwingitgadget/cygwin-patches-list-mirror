Return-Path: <cygwin-patches-return-2180-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 12053 invoked by alias); 13 May 2002 05:24:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12039 invoked from network); 13 May 2002 05:24:11 -0000
Date: Sun, 12 May 2002 22:24:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: long-option kill patch
Message-ID: <20020513052403.GA22985@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20020513033009.77939.qmail@web20009.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020513033009.77939.qmail@web20009.mail.yahoo.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00164.txt.bz2

On Sun, May 12, 2002 at 08:30:09PM -0700, Joshua Daniel Franklin wrote:
>Is there something wrong with the patch for kill.cc?
>It's a very simple patch:
>
>http://www.cygwin.com/ml/cygwin-patches/2002-q2/msg00146.html
>
>I'd be happy to fix it if there is something wrong, but I'm
>not psycic about what...

As I'd previously indicated, I preferred if the option processing was
done via getopt.  I just checked in a patch to do that.  I also
implemented the -l and -s options.

Sorry for not providing feedback, I'd had a partial implementation
sitting in my sandbox and I just polished it off tonight.

cgf
