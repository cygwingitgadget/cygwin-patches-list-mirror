Return-Path: <cygwin-patches-return-2764-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28840 invoked by alias); 2 Aug 2002 14:48:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28818 invoked from network); 2 Aug 2002 14:48:36 -0000
Date: Fri, 02 Aug 2002 07:48:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Change mount usage, winsup/utils/mount.cc
Message-ID: <20020802144856.GA22866@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.WNT.4.44.0208020816340.968-200000@barbecueworld>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.WNT.4.44.0208020816340.968-200000@barbecueworld>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00212.txt.bz2

On Fri, Aug 02, 2002 at 08:16:47AM -0500, Michael Hoffman wrote:
>2002-08-02  Michael Hoffman  <grouse@mail.utexas.edu>
>
>* mount.cc (usage): Show usage as [<win32path>] [<posixpath>] since
>the two are not always used together, like with --change-cygdrive-prefix.

That would be misleading.  It would indicate that the common case had an
optional second argument.

I'll be changing this in the next version of cygwin anyway, so I think
I'll pass on this patch for now.  Thanks anyway, though.

cgf

>--- mount.cc-orig	2002-08-02 08:05:24.000000000 -0500
>+++ mount.cc	2002-08-02 08:06:51.000000000 -0500
>@@ -133,7 +133,7 @@ static char opts[] = "bcfhmpstuvxEX";
> static void
> usage (FILE *where = stderr)
> {
>-  fprintf (where, "Usage: %s [OPTION] [<win32path> <posixpath>]\n\
>+  fprintf (where, "Usage: %s [OPTION] [<win32path>] [<posixpath>]\n\
>   -b, --binary                  text files are equivalent to binary files\n\
> 				(newline = \\n)\n\
>   -c, --change-cygdrive-prefix  change the cygdrive path prefix to <posixpath>\n\
