Return-Path: <cygwin-patches-return-2292-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 11315 invoked by alias); 3 Jun 2002 03:21:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11296 invoked from network); 3 Jun 2002 03:21:13 -0000
Date: Sun, 02 Jun 2002 20:21:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: regtool help/version patch
Message-ID: <20020603032114.GA8750@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.44.0206022144260.1152-200000@iocc.com> <20020603025833.GA8225@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020603025833.GA8225@redhat.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00275.txt.bz2

On Sun, Jun 02, 2002 at 10:58:33PM -0400, Christopher Faylor wrote:
>On Sun, Jun 02, 2002 at 09:45:30PM -0500, Joshua Daniel Franklin wrote:
>>2002-06-02  Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
>>
>>	* regtool.cc (prog_name): New global variable.
>>	(longopts): Ditto.
>>	(opts): Ditto.
>>	(usage): Standardize usage output. Rearrange/add descriptions.
>>	(print_version): New function.
>>	(main): Accomodate longopts and new --help, --version options.
>>	Add check for (_argv[optind+1] == NULL).
>
>Applied.
>
>Thanks, as always.

Joshua, it just occurred to me that you don't seem to be patching the
.sgml documentation when you make a change to a utility.

Do you think you could take a run over the utils.sgml file and see
if there are missing options that could be added?  Also, if you're
adding examples to the output then utils.sgml would be a good place
for that, too.

cgf
