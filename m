Return-Path: <cygwin-patches-return-1469-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 3849 invoked by alias); 11 Nov 2001 23:30:32 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 3819 invoked from network); 11 Nov 2001 23:30:31 -0000
Date: Mon, 01 Oct 2001 15:42:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com, cygwin-apps@cygwin.com
Subject: Re: setup streams work..
Message-ID: <20011111233034.GA24210@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com, cygwin-apps@cygwin.com
References: <019d01c16a7f$ab3ee060$0200a8c0@lifelesswks>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <019d01c16a7f$ab3ee060$0200a8c0@lifelesswks>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2001-q4/txt/msg00001.txt.bz2

On Sun, Nov 11, 2001 at 06:08:29PM +1100, Robert Collins wrote:
>So given that the class layout works, and somethings are already
>becoming easier to do, I plan to commit this to HEAD.
>
>Any objections?

It looks fine to me.

It was a little hard to tell what was changing given that you seem
to have run the sources through indent and there was some whitespace
changes.

I actually think that indent is doing the wrong thing for c++ in some
cases.

I like the idea of the io_stream a lot.  I also like the "cygfile:"
"URL".

I say go for it.

cgf
