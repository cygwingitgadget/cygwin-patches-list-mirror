Return-Path: <cygwin-patches-return-4838-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2548 invoked by alias); 16 Jun 2004 12:37:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2539 invoked from network); 16 Jun 2004 12:37:43 -0000
Date: Wed, 16 Jun 2004 12:37:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Unicode length
Message-ID: <20040616123744.GA25094@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040616003625.0081c940@incoming.verizon.net> <3.0.5.32.20040616003625.0081c940@incoming.verizon.net> <3.0.5.32.20040616072824.00812cf0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040616072824.00812cf0@incoming.verizon.net>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q2/txt/msg00190.txt.bz2

On Jun 16 07:28, Pierre A. Humblet wrote:
> At 09:29 AM 6/16/2004 +0200, Corinna Vinschen wrote:
> >This change looks not quite ok.  The return value from MultiByteToWideChar
> >is the "number of wide characters" while Length and MaximumLength in a
> >UNICODE_STRING are defined to contain "the length in bytes".
> 
> Right, that's why the return value is multiplied by sizeof (WCHAR), as in
> +  tgt.MaximumLength = sys_mbstowcs (buf, srcstr, strlen (srcstr) + 1) * sizeof (WCHAR);

I missed the `* sizeof (WCHAR)' part, sorry.  Please check it in if
you think it's fine.

> After sleeping over it I see other issues. An accented string can have several
> unicode representations, e.g. with composite characters or with precomposed 
> characters. Do you know if NT prefers or insists on one or the other for filenames?

Precomposed, AFAIK.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Co-Project Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
