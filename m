Return-Path: <cygwin-patches-return-5317-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8635 invoked by alias); 25 Jan 2005 21:24:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8505 invoked from network); 25 Jan 2005 21:24:47 -0000
Received: from unknown (HELO cygbert.vinschen.de) (80.132.112.219)
  by sourceware.org with SMTP; 25 Jan 2005 21:24:47 -0000
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id 8D72057D73; Tue, 25 Jan 2005 22:24:45 +0100 (CET)
Date: Tue, 25 Jan 2005 21:24:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: setting errno to ENOTDIR rather than ENOENT
Message-ID: <20050125212445.GG31117@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <41F6B1F6.5207C318@phumblet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F6B1F6.5207C318@phumblet.no-ip.org>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q1/txt/msg00020.txt.bz2

Well done!  I looked into this a few hours ago and missed how easy a
solution would be.  *mumbling something about needing glasses*

I guess this is ok to check in after adding some spaces...

On Jan 25 15:54, Pierre A. Humblet wrote:
> 2005-01-25  Pierre Humblet <pierre.humblet@ieee.org>
> 
> 	* path.cc (path_conv::check): Return ENOTDIR rather than ENOENT
> 	when a component is not a directory. Remove unreachable code.
> 	(digits): Delete.
> 
> Index: path.cc
> ===================================================================
> RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
> retrieving revision 1.338
> diff -u -p -r1.338 path.cc
> --- path.cc     18 Jan 2005 13:00:18 -0000      1.338
> +++ path.cc     25 Jan 2005 20:08:53 -0000
> @@ -655,12 +655,6 @@ path_conv::check (const char *src, unsig
>               full_path[3] = '\0';
>             }
>  
> -         if ((opt & PC_SYM_IGNORE) && pcheck_case == PCHECK_RELAXED)
> -           {
> -             fileattr = GetFileAttributes (this->path);
> -             goto out;
> -           }
> -
>           symlen = sym.check (full_path, suff, opt | fs.has_ea ());
>  
>           if (sym.minor || sym.major)
> @@ -680,7 +674,7 @@ path_conv::check (const char *src, unsig
>               if (pcheck_case == PCHECK_STRICT)
>                 {
>                   case_clash = true;
> -                 error = ENOENT;
> +                 error = component?ENOTDIR:ENOENT;
                            ^^^^^^^^^^^^^^^^^^^^^^^^^

...here.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
