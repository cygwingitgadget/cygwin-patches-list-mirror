Return-Path: <cygwin-patches-return-2959-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 15872 invoked by alias); 13 Sep 2002 04:35:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15827 invoked from network); 13 Sep 2002 04:35:57 -0000
Message-ID: <20020913043556.69746.qmail@web20009.mail.yahoo.com>
Date: Thu, 12 Sep 2002 21:35:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
Subject: Re: print_version missing newlines (for Joshua?)
To: cygwin-patches@cygwin.com
In-Reply-To: <20020913035034.GB3882@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SW-Source: 2002-q3/txt/msg00407.txt.bz2

Igor's patch looks good to me. I guess I missed that 
breaking the line != newline. 

I'll get to the other utils soon, but I may be indisposed 
for the next few days, sorry. 

--- Christopher Faylor <cgf@redhat.com> wrote:
> Joshua,
> The lack of newline seems to be a generic problem with at least a couple
> of print_versions.
> 
> You can use your new checkin powers to fix this, if you want.
> With a ChangeLog, of course.
> 
> I'll defer to your judgement on the rest of this patch, too.
> 
> cgf
> 
> ----- Forwarded message from Igor Pechtchanski <pechtcha@cs.nyu.edu> -----
> 
> From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
> To: cygwin-patches@cygwin.com
> Subject: `cygpath --version` missing a newline
> Date: Thu, 12 Sep 2002 23:39:05 -0400 (EDT)
> 
> Hi,
> `cygpath --version` is missing a trailing newline.  I'm attaching a patch.
> This probably doesn't merit a ChangeLog entry, but I'm providing one
> anyway, feel free to disregard it.  I also took the opportunity to factor
> out the short options array into a global variable.  I can split this into
> two separate patches, if necessary.
> 	Igor
> 
> 2002-09-12  Igor Pechtchanski <pechtcha@cs.nyu.edu>
> 	* cygpath.cc (options) New global variable.
> 	(main) Make short options global for easier change.
> 	(print_version) Add a missing newline.
> 
> -- 
> 				http://cs.nyu.edu/~pechtcha/
>       |\      _,,,---,,_		pechtcha@cs.nyu.edu
> ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
>      |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski
>     '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!
> 
> It took the computational power of three Commodore 64s to fly to the moon.
> It takes a 486 to run Windows 95.  Something is wrong here. -- SC sig file
> 
> Index: cygpath.cc
> ===================================================================
> RCS file: /cvs/src/src/winsup/utils/cygpath.cc,v
> retrieving revision 1.22
> diff -u -p -r1.22 cygpath.cc
> --- cygpath.cc	23 Aug 2002 15:46:00 -0000	1.22
> +++ cygpath.cc	13 Sep 2002 03:36:19 -0000
> @@ -57,6 +57,8 @@ static struct option long_options[] = {
>    {0, no_argument, 0, 0}
>  };
>  
> +static char options[] = "ac:df:hilmopst:uvwADHPSW";
> +
>  static void
>  usage (FILE * stream, int status)
>  {
> @@ -534,7 +536,8 @@ print_version ()
>  cygpath (cygwin) %.*s\n\
>  Path Conversion Utility\n\
>  Copyright 1998, 1999, 2000, 2001, 2002 Red Hat, Inc.\n\
> -Compiled on %s", len, v, __DATE__);
> +Compiled on %s\n\
> +", len, v, __DATE__);
>  }
>  
>  int
> @@ -562,7 +565,7 @@ main (int argc, char **argv)
>    options_from_file_flag = 0;
>    allusers_flag = 0;
>    output_flag = 0;
> -  while ((c = getopt_long (argc, argv, (char *) "ac:df:hilmopst:uvwADHPSW",
> +  while ((c = getopt_long (argc, argv, options,
>  			   long_options, (int *) NULL)) != EOF)
>      {
>        switch (c)
> 
> 
> ----- End forwarded message -----
> 
> 
> 


__________________________________________________
Do you Yahoo!?
Yahoo! News - Today's headlines
http://news.yahoo.com
