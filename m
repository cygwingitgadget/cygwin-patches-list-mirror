Return-Path: <cygwin-patches-return-2461-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 2742 invoked by alias); 18 Jun 2002 23:40:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2706 invoked from network); 18 Jun 2002 23:40:16 -0000
Date: Tue, 18 Jun 2002 16:40:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Error output from maint scripts
Message-ID: <20020618234054.GA12744@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <009101c21714$5615f6e0$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <009101c21714$5615f6e0$6132bc3e@BABEL>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00444.txt.bz2

Minor nit, but I suspect that this patch belongs in cygwin-apps.

These are cygwin-apps utilities.

cgf

On Tue, Jun 18, 2002 at 11:06:02PM +0100, Conrad Scott wrote:
>I've been using Robert's maint scripts now that I've been committing
>stuff into cvs and they work really well (except when I get something
>wrong: no disasters yet tho'). One minor issue is that some of the
>error messages go to stdout, which isn't too useful when some of the
>scripts are intended to be run with their output re-directed to a file
>(particular for those of us who can't ever type a command right first
>time).
>
>So, a little patch to put all the error messages on stderr.
>
>// Conrad
>
>2002-06-18  Conrad Scott  <conrad.scott@dsl.pipex.com>
>
> * cvsclosebranch: Send error messages to stderr.
> * cvsmerge: Ditto.
> * cvsmergeinit: Ditto.
> * cvsmkbranch: Ditto.
> * cvsmkpatch: Ditto.
>


>2002-06-18  Conrad Scott  <conrad.scott@dsl.pipex.com>
>
>	* cvsclosebranch: Send error messages to stderr.
>	* cvsmerge: Ditto.
>	* cvsmergeinit: Ditto.
>	* cvsmkbranch: Ditto.
>	* cvsmkpatch: Ditto.
>
