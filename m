Return-Path: <cygwin-patches-return-1790-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 5322 invoked by alias); 25 Jan 2002 17:24:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5259 invoked from network); 25 Jan 2002 17:24:35 -0000
Date: Fri, 25 Jan 2002 09:24:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]Package extention recognition (revision 2)
Message-ID: <20020125172432.GD27965@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <02b901c1a58d$11e86820$a100a8c0@mchasecompaq> <1011955697.18203.27.camel@lifelesswks> <000901c1a58f$58a46640$a100a8c0@mchasecompaq>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000901c1a58f$58a46640$a100a8c0@mchasecompaq>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q1/txt/msg00147.txt.bz2

On Fri, Jan 25, 2002 at 02:59:17AM -0800, Michael A Chase wrote:
>And that test is still there, I moved it into the if () so something like
>".tar.bz2" wouldn't trigger the return .... : 0;  If all the ifs fail,
>return 0; still occurs.

Hmm.  Seems like someone has "improved" this code from when I wrote it.

My version checked for a trailing component.  If it existed, it returned
the index into the string.

This version sort of does the same thing but if there is a .tar.bz2
anywhere in the string prior to trailing component, it will fail
regardless of whether the filename ends with .tar .tar.gz or .tar.bz2.

Perhaps that is an acceptable risk but it puzzles me why anyone would
move from an algorithm that was foolproof to one that wasn't.

cgf
