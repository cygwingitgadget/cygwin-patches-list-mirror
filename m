Return-Path: <cygwin-patches-return-4683-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15516 invoked by alias); 13 Apr 2004 20:49:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15507 invoked from network); 13 Apr 2004 20:49:14 -0000
Date: Tue, 13 Apr 2004 20:49:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Last path.cc
Message-ID: <20040413204913.GG26558@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040410233707.00846910@incoming.verizon.net> <3.0.5.32.20040410233707.00846910@incoming.verizon.net> <3.0.5.32.20040412192958.0080cab0@incoming.verizon.net> <20040413124306.GD26558@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040413124306.GD26558@cygbert.vinschen.de>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q2/txt/msg00035.txt.bz2

On Apr 13 14:43, Corinna Vinschen wrote:
> What I'm up to is to change all the affected functionality to what's
> already working fine in case of stat/fstat:
> 
>   baz (char *posix_name)
>   {
>     Create fhandler
>     fhandler->fbaz (fd);
>   }
> 
>   fbaz (int fd)
>   {
>     Get fhandler
>     fhandler->fbaz (fd);
>   }
> 
>   fhandler::fbaz ()
>   {
>     NT_baz_equivalent (handle);
>   }

I've implemented something along these lines for fchmod so far.  Trying
to write the security attributes using NtSetSecurityObject is a dead end
though.  It requires to open the file with WRITE_DAC and WRITE_OWNER
access rights, both of which are not contained in GENERIC_READ nor in
GENERIC_WRITE.  So there's no gain in using it, unfortunately.

What I just checked in uses the open handle to read the security
attributes but still calls write_sd as before.  The interesting thing
is, that it's nevertheless faster than before, though the number of
open/close calls should be the same.

I'll try the same with chown/fchown tomorrow.

Oh, one problem left.  Currently fhandler_disk_file::fchmod calls
chmod_device which is pretty ugly.  Chris, do you have an idea how
to do that in a cleaner way?

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
