Return-Path: <cygwin-patches-return-2358-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24173 invoked by alias); 7 Jun 2002 17:13:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24158 invoked from network); 7 Jun 2002 17:13:30 -0000
Date: Fri, 07 Jun 2002 10:13:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: sem_getvalue patch
Message-ID: <20020607171347.GC18090@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3D848382FB72E249812901444C6BDB1D0AA179@exchange.timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D848382FB72E249812901444C6BDB1D0AA179@exchange.timesys.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00341.txt.bz2

On Fri, Jun 07, 2002 at 12:35:10PM -0400, Robb, Sam wrote:
>[original message was to cygwin@cygwin.com]
>
>> With a little effort, I've managed to build a cygwin1.dll that exports
>> sem_getvalue().  The version of cygwin1.dll that I built seems subtly
>> hosed, though - while I can compile and run my test program from
>> within a Windows cmd.exe shell, trying to run bash or ls (and probably
>> a great many other things) hangs.
>
>Here's the patch... fairly straightforward, if I've understood the SUS
>spec for the function correctly :-/
>
>As for the apparent hangs in bash/ls/etc. - well, perhaps it was my
>patch, perhaps not, as I was building from latest cvs source.  Since
>I can't find any documentation that indicates if a particular method
>for adding an export to cygiwn.din needs to be followed, this patch
>simply tacks sem_getvalue to the end of the list.

Btw, if you don't already have a form on file, we'll need an assignment
form for this patch.  See http://cygwin.com/contrib.html .

cgf
