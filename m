Return-Path: <cygwin-patches-return-1730-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7993 invoked by alias); 17 Jan 2002 15:16:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7961 invoked from network); 17 Jan 2002 15:15:57 -0000
Date: Thu, 17 Jan 2002 07:16:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Cygpath patch resend
Message-ID: <20020117161555.A8586@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <000801c19f67$87073950$b3e0290c@world9t3igycu7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000801c19f67$87073950$b3e0290c@world9t3igycu7>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q1/txt/msg00087.txt.bz2

On Thu, Jan 17, 2002 at 08:57:05AM -0600, Joshua Daniel Franklin wrote:
> Here's a changelog:
> 
> 2001-01-16 Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
> 
> * cygpath.cc (main): Added options to show Desktop and Start Menu's Programs
> directory for current user or all users
> * cygpath.cc (main): moved bulk of DPWS options outside the getopt case
> statement
>  (since their output depends on uwA switches)
> * utils.sgml: updated cygpath section for ADPWS options

The attachments look ok.  Your ChangeLog OTOH...  It should look like
this:

2001-01-16  Joshua Daniel Franklin  <joshuadfranklin@yahoo.com>

	* cygpath.cc (main): Add options to show Desktop and Start
	Menu's Programs directory for current user or all users.
	Move bulk of DPWS options outside the getopt case statement.
	* utils.sgml: Update cygpath section for ADPWS options.

Please compare carefully *all* details.

Anyway, thanks for the patch.  I'm too busy to check it today, though.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
