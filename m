Return-Path: <cygwin-patches-return-4840-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27238 invoked by alias); 17 Jun 2004 06:46:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27215 invoked from network); 17 Jun 2004 06:46:06 -0000
Date: Thu, 17 Jun 2004 06:46:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Unicode length
Message-ID: <20040617064607.GA31496@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040616072824.00812cf0@incoming.verizon.net> <3.0.5.32.20040616003625.0081c940@incoming.verizon.net> <3.0.5.32.20040616003625.0081c940@incoming.verizon.net> <3.0.5.32.20040616072824.00812cf0@incoming.verizon.net> <3.0.5.32.20040616225506.00810660@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040616225506.00810660@incoming.verizon.net>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q2/txt/msg00192.txt.bz2

On Jun 16 22:55, Pierre A. Humblet wrote:
> This is a full implementation of what I started yesterday, with
> more robust protection against string buffer overflows.
> 
> I also reorganized the debug_printf in fhandler_base::openX
> 
> Pierre
> 
> 2004-06-17  Pierre Humblet <pierre.humblet@ieee.org>
> 
> 	* fhandler.cc (fhandler_base::open_9x): Do not check for null name.
> 	Move debug_printf to common code line.
> 	(fhandler_base::open): Ditto. Initialize upath. Remove second argument
>  	of pc.get_nt_native_path.
> 	* path.h (path_conv::get_nt_native_path): Remove second argument.
> 	* path.cc (path_conv::get_nt_native_path): Ditto. Call str2uni_cat.
> 	* security.h (str2buf2uni_cat): Delete declaration.
> 	(str2uni_cat): New declaration.
> 	* security.cc (str2buf2uni): Get length from sys_mbstowcs call.
> 	(str2buf2uni_cat): Delete function.
> 	(str2uni_cat): New function.
> 	* miscfuncs.cc (sys_mbstowcs): Add debug_printf.

Cool with me.  Please check it in.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Co-Project Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
