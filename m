Return-Path: <cygwin-patches-return-2355-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4068 invoked by alias); 7 Jun 2002 11:12:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4051 invoked from network); 7 Jun 2002 11:12:44 -0000
Date: Fri, 07 Jun 2002 04:12:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: regtool support for remote registry
Message-ID: <20020607131242.C23093@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <13970794877.20020606141146@logos-m.ru> <20020606152859.B22789@cygbert.vinschen.de> <47151556727.20020607123750@logos-m.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47151556727.20020607123750@logos-m.ru>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00338.txt.bz2

On Fri, Jun 07, 2002 at 12:37:50PM +0400, Egor Duda wrote:
> CV> Just a question:  Wouldn't it make sense to use a syntax as rcp/scp:
> CV>   regtool get bumba:\machine\software\microsoft\...
> CV> This together with the capability to use forward slashes looks
> CV> more unixy:
> CV>   regtool get bumba:/machine/software/microsoft/...
> CV> In this context I see for the first time, that the usage doesn't
> CV> say anything about using forward slashes.   Shouldn't we add a word
> CV> that this is possible, too?
> 
> No probs. This should support both formats.

Thanks!  Applied.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
