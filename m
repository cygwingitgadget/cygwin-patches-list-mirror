Return-Path: <cygwin-patches-return-4772-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17220 invoked by alias); 17 May 2004 08:57:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17208 invoked from network); 17 May 2004 08:57:11 -0000
Date: Mon, 17 May 2004 08:57:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: c:.
Message-ID: <20040517085711.GM12030@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040515234018.00804730@incoming.verizon.net> <3.0.5.32.20040515223540.00810100@incoming.verizon.net> <3.0.5.32.20040515223540.00810100@incoming.verizon.net> <3.0.5.32.20040515234018.00804730@incoming.verizon.net> <3.0.5.32.20040516182015.0081c190@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040516182015.0081c190@incoming.verizon.net>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q2/txt/msg00124.txt.bz2

On May 16 18:20, Pierre A. Humblet wrote:
> There is a bigger problem: NtCreateFile does not support the format 
> c:nodirsep (it's most likely handled by the Windows layer above NT). 

Right.  Native NT only supports absolute paths.  Relative paths are
either converted to absolute paths in the Win32 layer or you can
specify them relative to the open handle to an already opened directory.

> Thus to support it, Cygwin would have to emulate Windows and interact 
> with the odious environment variables.

Do we really want to support it?

> Things such as cd, ls, touch, .. which do not require NtCreateFile,
> still work fine in cvs, cat doesn't.
> I don't think it's acceptable to have some system calls work while
> other fail just because of the filename format.
> 
> I see two realistic possibilities on NT:
> 1) Reject filenames of the form c:nodirsep, except the naked "c:"
> or 2) Silently add a / after the :
> 
> If we decide on 2), I would apply it to Win9x and NT for uniformity.
> If we decide on 1), I would only apply it on NT only (why fail on 9X
> if we can succeed?). 

I would prefer version 2.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Co-Project Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
