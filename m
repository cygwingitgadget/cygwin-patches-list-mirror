Return-Path: <cygwin-patches-return-2341-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4463 invoked by alias); 6 Jun 2002 13:29:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4441 invoked from network); 6 Jun 2002 13:29:01 -0000
Date: Thu, 06 Jun 2002 06:29:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: egor duda <cygwin-patches@cygwin.com>
Subject: Re: regtool support for remote registry
Message-ID: <20020606152859.B22789@cygbert.vinschen.de>
Mail-Followup-To: egor duda <cygwin-patches@cygwin.com>
References: <13970794877.20020606141146@logos-m.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13970794877.20020606141146@logos-m.ru>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00324.txt.bz2

On Thu, Jun 06, 2002 at 02:11:46PM +0400, Egor Duda wrote:
> Hi!
> 
>   Attached patch allows regtool to access registry on remote hosts,
> e.g.:
> 
> regtool get \\bumba\machine\software\microsoft\windows\currentVersion\programFilesDir

Just a question:  Wouldn't it make sense to use a syntax as rcp/scp:

  regtool get bumba:\machine\software\microsoft\...

This together with the capability to use forward slashes looks
more unixy:

  regtool get bumba:/machine/software/microsoft/...

In this context I see for the first time, that the usage doesn't
say anything about using forward slashes.   Shouldn't we add a word
that this is possible, too?

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
