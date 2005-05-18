Return-Path: <cygwin-patches-return-5467-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23683 invoked by alias); 18 May 2005 16:48:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23411 invoked from network); 18 May 2005 16:48:43 -0000
Received: from unknown (HELO calimero.vinschen.de) (84.148.23.119)
  by sourceware.org with SMTP; 18 May 2005 16:48:43 -0000
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 8F6D66D4202; Wed, 18 May 2005 18:48:48 +0200 (CEST)
Date: Wed, 18 May 2005 16:48:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: mkdir -p and network drives
Message-ID: <20050518164848.GA11455@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20050509201636.00b4e7b8@incoming.verizon.net> <3.0.5.32.20050505225708.00b64250@incoming.verizon.net> <3.0.5.32.20050509201636.00b4e7b8@incoming.verizon.net> <3.0.5.32.20050510205301.00b4b658@incoming.verizon.net> <20050511085307.GA2805@calimero.vinschen.de> <007b01c5572b$b3925890$3e0010ac@wirelessworld.airvananet.com> <20050512200222.GD5569@trixie.casa.cgf.cx> <20050513135745.GD10577@trixie.casa.cgf.cx> <loom.20050513T164025-465@post.gmane.org> <3.0.5.32.20050518082203.00b5ea78@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20050518082203.00b5ea78@incoming.verizon.net>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q2/txt/msg00063.txt.bz2

Hi Pierre,

On May 18 08:22, Pierre A. Humblet wrote:
> Here is the implementation of mkdir and rmdir with fhandlers.

Thanks for the patch.  Chris is going to reply later today, but I have
some questions beforehand.

> +_off64_t
> +fhandler_disk_file::telldir (DIR *dir)
> +{
> +  return dir->__d_position;
> +}
> +
>  DIR *
>  fhandler_disk_file::opendir ()
>  {
> @@ -1268,12 +1376,6 @@ fhandler_disk_file::readdir (DIR *dir)
>    return res;
>  }
> 
> -_off64_t
> -fhandler_disk_file::telldir (DIR *dir)
> -{
> -  return dir->__d_position;
> -}
> -

I don't see a reason why you moved telldir just a few lines up.
Any reasoning, perhaps together with a ChangeLog entry?

> -_off64_t
> -fhandler_cygdrive::telldir (DIR *dir)
> -{
> -  return fhandler_disk_file::telldir (dir);
> -}
> -
>  void
>  fhandler_cygdrive::seekdir (DIR *dir, _off64_t loc)
>  {

Why did you remove fhandler_cygdrive::telldir but not
fhandler_cygdrive::seekdir?  Both are just calling their base class
variants.

> -  else if (isvirtual_dev (dev.devn) && fileattr == INVALID_FILE_ATTRIBUTES)
> -    {
> -      error = dev.devn == FH_NETDRIVE ? ENOSHARE : ENOENT;
> -      return;
> -    }

I don't understand this one.  What's the rational behind removing
these lines?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
