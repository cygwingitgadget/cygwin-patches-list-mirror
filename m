Return-Path: <cygwin-patches-return-3018-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 12595 invoked by alias); 22 Sep 2002 01:58:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12581 invoked from network); 22 Sep 2002 01:58:14 -0000
Date: Sat, 21 Sep 2002 18:58:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Cleaning up for NULL handles
Message-ID: <20020922015828.GA6730@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20020920192828.0080c640@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20020920192828.0080c640@mail.attbi.com>
User-Agent: Mutt/1.4i
X-SW-Source: 2002-q3/txt/msg00466.txt.bz2

On Fri, Sep 20, 2002 at 07:28:28PM -0400, Pierre A. Humblet wrote:
>The patch below takes care of the possibility that CreateFile might
>return a 0 handle, in the area that I touched recently.

I'm pretty sure that CreateFile does not return a NULL handle as there
are Windows API functions that interpret a NULL handle as indicating
a default parameter.

In fact, once such function is CreateFile itself.

So, although the fact that CreateFile will return INVALID_HANDLE_VALUE
on error is documented, I think we can safely assume that CreateFile
will never return a NULL handle either.

cgf
