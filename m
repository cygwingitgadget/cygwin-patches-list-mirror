Return-Path: <cygwin-patches-return-3689-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8192 invoked by alias); 11 Mar 2003 15:20:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8166 invoked from network); 11 Mar 2003 15:20:30 -0000
Date: Tue, 11 Mar 2003 15:20:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: fhandler_socket::dup
Message-ID: <20030311152028.GF13544@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030310200902.007f3100@mail.attbi.com> <20030311102431.GB13544@cygbert.vinschen.de> <3E6DF617.CA7DC2C0@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E6DF617.CA7DC2C0@ieee.org>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00338.txt.bz2

On Tue, Mar 11, 2003 at 09:43:35AM -0500, Pierre A. Humblet wrote:
> Corinna Vinschen wrote:
> >
> > I'm seriously concidering to remove all the fixup_before/fixup_after
> > from fhandler_socket::dup() and just call fhandler_base::dup() on
> > NT systems.
>  
> Corinna,
> 
> Isn't that just what you do now?

I created the patch after sending the mail.

> Just out of curiosity, why hasn't this always been done? I blindly thought
> it couldn't but I have just looked up MSDN and there is no mention of any 
> restriction of DuplicateHandle with sockets, on any platform. 

Using WinSock2 should workaround the problem with the order in which sockets
are closed on 9x.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
