Return-Path: <cygwin-patches-return-4334-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29913 invoked by alias); 31 Oct 2003 21:23:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29904 invoked from network); 31 Oct 2003 21:23:18 -0000
Date: Fri, 31 Oct 2003 21:23:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix debugger attach for threads
Message-ID: <20031031212316.GA8668@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3FA2D012.5060607@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FA2D012.5060607@gmx.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00053.txt.bz2

On Fri, Oct 31, 2003 at 10:11:46PM +0100, Thomas Pfaff wrote:
>This patch allows a debugger to attach when an exception occurs in a 
>thread other than the mainthread.
>
>I am not happy about the wait in handle_exceptions, but it works on my 
>machine. I think that a waitloop until the debugger is attached is 
>cleaner, but there must be a reason why the debbugging loop is 
>implemented this way.

The intent is for an attached debugger to immediately see the location
that died.  If you loop in the try_to_debug code then it is a pain to
figure out exactly where the exception occurred.

I don't understand why this code is needed.  Why do threads need to
be suspended and resumed specially?

cgf
