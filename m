Return-Path: <cygwin-patches-return-3238-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29641 invoked by alias); 28 Nov 2002 18:19:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29629 invoked from network); 28 Nov 2002 18:19:12 -0000
Date: Thu, 28 Nov 2002 10:19:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Internal get{pw,gr}XX calls
Message-ID: <20021128191909.Y1398@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20021126000911.00833190@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20021126000911.00833190@mail.attbi.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q4/txt/msg00189.txt.bz2

Hi Pierre,

that looks fine, just some comments and a few nits we should talk about.

On Tue, Nov 26, 2002 at 12:09:11AM -0500, Pierre A. Humblet wrote:
> 	* security.h: Move declarations of internal_getgrent,
> 	internal_getpwsid and internal_getgrsid to pwdgrp.h.

Good idea.

> Index: pwdgrp.h
> ===================================================================
> [...]
>  enum pwdgrp_state {
>    uninitialized = 0,
>    initializing,
> -  emulated,
>    loaded
>  };
> 
> @@ -34,7 +44,7 @@ public:
>  	  if ((h = FindFirstFile (file_w32, &data)) != INVALID_HANDLE_VALUE)
>  	    {
>  	      if (CompareFileTime (&data.ftLastWriteTime, &last_modified) > 0)
> -		state = uninitialized;
> +		state = initializing;
>  	      FindClose (h);
>  	    }
>  	}
> @@ -44,6 +54,7 @@ public:
>      {
>        state = nstate;
>      }
> +  BOOL isuninitialized () const { return state == uninitialized; }

I don't see a need to define isuninitialized().  Or we should also
define other similar methods.  What we currently have is the operator
pwdgrp_state() so that we always use conditionals like

    passwd_state == loaded
    passwd_state <= initializing

and so on.  Now you introduce another way to ask for the state but you
don't use it always so that, with your patch, we have

    passwd_state.isuninitialized()
    passwd_state <= initializing

which looks a bit messy.  Personally I don't think it's worth to create
the new methods and you should use

    passwd_state == uninitialized

instead, as before.  But if you're more happy with using additional
methods, feel free to use them, but then define all methods needed as

    passwd_state.isuninitialized()
    passwd_state.isloaded()

> Index: passwd.cc
> ===================================================================
> [...]
> @@ -79,15 +79,11 @@ parse_pwd (struct passwd &res, char *buf
>  {
>    /* Allocate enough room for the passwd struct and all the strings
>       in it in one go */
> -  size_t len = strlen (buf);
> -  if (buf[--len] == '\r')
> -    buf[len] = '\0';
> -  if (len < 6)
> -    return 0;
> -
>    res.pw_name = grab_string (&buf);
>    res.pw_passwd = grab_string (&buf);
>    res.pw_uid = grab_int (&buf);
> +  if (!*buf)
> +    return 0;
>    res.pw_gid = grab_int (&buf);
>    res.pw_comment = 0;
>    res.pw_gecos = grab_string (&buf);
> @@ -129,28 +125,6 @@ class passwd_lock

You said that you did it in a relaxed fashion.  Hmm.  Long hmmmmmm.
Your implementation allows for passwd entries to be cut (or mutilated)
after the gid.  That should be ok.  I'm just thinking that we should
perhaps change grab_int so that we know it got a well formed uid and
gid field, isn't it?  Shouldn't we check for the stop character like this:

  static int
  grab_int (char **p)
  {
    char *src = *p, *stp;
    int val = strtol (src, &stp, 10);
    if (stp == src || !isdigit (*stp))
      while (*src)
	src++;
    else
      while (*src && *src != ':')
	src++;
    if (*src == ':')
      src++;
    *p = src;
    return val;
  }

That would p move to the trailing \0 as soon as the digit string is invalid
and so more or less immediately stop to evaluate the passwd string.  The

  if (!*buf)

in parse_pwd should then be moved behind grabbing the gid.  What do you
think?  (Same for parse_grp, btw.)

> @@ -166,12 +140,8 @@ read_etc_passwd ()
>    passwd_lock here (cygwin_finished_initializing);
> 
>    /* if we got blocked by the mutex, then etc_passwd may have been processed */
> -  if (passwd_state != uninitialized)
> -    return;
> -
> -  if (passwd_state != initializing)
> +  if (passwd_state <= initializing)
>      {
> -      passwd_state = initializing;
>        curr_lines = 0;
>        if (pr.open ("/etc/passwd"))
>  	{
> @@ -183,6 +153,7 @@ read_etc_passwd ()
>  	  pr.close ();
>  	  debug_printf ("Read /etc/passwd, %d lines", curr_lines);
>  	}
> +      passwd_state = loaded;

Uhm?  That looks incorrect.  It shouldn't enter the initializing state
if the state is already set to initializing which means another thread
is currently initializing. (Same in read_etc_group())

> Index: sec_acl.cc
> ===================================================================
> [...]
> -	      if ((pw = getpwuid32 (acls[i].a_id)) != NULL
> -		  && owner.getfrompw (pw))
> -		{
> -		  for (int gidx = 0; (gr = internal_getgrent (gidx)); ++gidx)
> -		    if (group.getfromgr (gr)
> -			&& owner == group
> -			&& is_grp_member (myself->uid, gr->gr_gid))
> -		      break;
> -		}
> -	      if (!gr)
> -		continue;
> +	      if ((pw = internal_getpwuid (acls[i].a_id)) != NULL
> +		  && owner.getfrompw (pw)
> +		  && (gr = internal_getgrsid (owner))
> +		  && is_grp_member (myself->uid, gr->gr_gid))
> +		break;
> +	      continue;
>  	    }
>  	  break;
>  	case GROUP_OBJ:

The same without internal_getgrent(), cool!

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
