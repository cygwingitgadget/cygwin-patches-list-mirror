Return-Path: <cygwin-patches-return-2353-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 26714 invoked by alias); 7 Jun 2002 01:37:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26679 invoked from network); 7 Jun 2002 01:37:18 -0000
Date: Thu, 06 Jun 2002 18:37:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Add new -T|--toggle option to strace
Message-ID: <20020607013734.GA22177@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <032201c20dbf$f27da3b0$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <032201c20dbf$f27da3b0$6132bc3e@BABEL>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00336.txt.bz2

On Fri, Jun 07, 2002 at 02:09:17AM +0100, Conrad Scott wrote:
>2002-06-07  Conrad Scott  <conrad.scott@dsl.pipex.com>
>
>	* strace.cc (toggle): New global variable.
>	(error): Use exit instead of ExitProcess so that stdio buffers get
>	flushed.
>	(create_child): Remove command line error checking.
>	(dostrace): Ditto.
>	(dotoggle): New function.
>	(usage): Add entry for new option -T|--toggle.  Alphabetize.
>	(longopts): Add new option -T|--toggle.
>	(opts): Ditto.
>	(main): Handle new -T|--toggle option.  Move all command line checking
>	here from other functions.
>	* utils.sgml: Update section for strace.

Applied.

Thanks,
cgf
