From: DJ Delorie <dj@delorie.com>
To: bkeener@thesoftwaresource.com
Cc: cygwin-patches@sources.redhat.com
Subject: Re: [patch] Setup.exe choose.cc selection enhancement based on file existence
Date: Tue, 06 Feb 2001 18:27:00 -0000
Message-id: <200102070226.VAA23607@envy.delorie.com>
References: <VA.0000062c.02a8582a@thesoftwaresource.com>
X-SW-Source: 2001-q1/msg00049.html

This is big enough to require legal papers.  Chris, do we have them
from Brian?

> *************** list_click (HWND hwnd, BOOL dblclk, int 
> *** 281,284 ****
> --- 287,292 ----
>       {
>         extra[p].pick ++;
> +       while ((package[p].info[extra[p].chooser[extra[p].pick].trust].install_exists==0 && source == IDC_SOURCE_CWD) && package[p].info[extra[p].chooser[extra[p].pick].trust].install && extra[p].chooser[extra[p].pick].caption != 0)

Could you break this up into multiple lines, preferably keeping within
80 colums or so?  Use a helper macro if that makes it more readable.

> !       if (extra[p].chooser[extra[p].pick].src_avail && package[p].info[extra[p].chooser[extra[p].pick].trust].source_exists)

Ditto.

> + static int 
> + check_existance (int p, int trust, int which_file)

I suggest "check_src" instead of "which_file".  It's more intuitive
that way.

> + /*  TRUST_PREV=0, TRUST_CURR=1,TRUST_TEST=2,NTRUST=3 and TRUST_UNKNOWN =3 (deliberately left out of NTRUST */

Why is this comment here?

> +      if ( which_file == 0 && _access(concat("./",package[p].info[trust].install,0),0) == 0)

You don't need to use concat here.  Just use the file name as-is.

> +      else if ( which_file == 1 && _access(concat("./",package[p].info[trust].source,0),0) == 0 )

Or here.

> +      if (which_file == 0  && package[p].info[trust].install && _access(concat("./",package[p].info[trust].install,0),0) == 0 )
> +          return 1;
> +      else if (which_file == 1 && package[p].info[trust].source && _access(concat("./",package[p].info[trust].source,0),0) == 0 )

Wrap to 80 columns please.

> +                package[i].info[t].in_partial_list = 1-package[i].info[t].install_exists;

Use !, not 1-, for boolean inversion.  Don't rely on the value being 0 or 1.

> !     if (package[p].info[t].install && ((package[p].info[t].install_exists && source == IDC_SOURCE_CWD) || (package[p].info[t].install_exists == 0 && source == IDC_SOURCE_DOWNLOAD) || source == IDC_SOURCE_NETINST))

More wrapping.  Check them all; I won't comment on any others I find.

> - 	      /* we intentionally skip TRUST_PREV */
> - 	      if (t != TRUST_PREV || !extra[i].installed_ver)
> - 		extra[i].in_partial_list = 1;
> - 

Nearly all packages have a previous version available.  If you don't
skip TRUST_PREV (at least, in the old source), all packages end up
being listed in the partial list, because there's always something the
user can do.  This wasn't the "right thing" to do for most people.
What happens with your changes?

> +   rbset (dlg, ta,IDC_CHOOSE_CURR);

Space after the comma.

>       char *install;	/* file name to install */
>       int install_size;	/* in bytes */
> +     int install_exists; /* install file exists on disk */

You shouldn't need this.  If the install file doesn't
exist, then 'char *install' would be NULL.

> +     int source_exists;  /* source file exists on disk */

Ditto here.

> +     int in_partial_list;/* display this version in partial list */

This shouldn't be here; it's private to the chooser.  It
should go in chooser's corresponding struct.
