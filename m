Return-Path: <cygwin-patches-return-3208-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12617 invoked by alias); 20 Nov 2002 10:40:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12554 invoked from network); 20 Nov 2002 10:40:11 -0000
Date: Wed, 20 Nov 2002 02:40:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: ntsec patch #4: passwd and group
Message-ID: <20021120114009.E24928@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20021111145612.T10395@cygbert.vinschen.de> <3DCFC6BB.570DF472@ieee.org> <20021111174720.X10395@cygbert.vinschen.de> <3DCFE314.3B5B45AB@ieee.org> <20021111183423.A10395@cygbert.vinschen.de> <3DCFF8AE.66CBD751@ieee.org> <20021112144038.F10395@cygbert.vinschen.de> <3DD13433.D618DC4F@ieee.org> <20021112181849.K10395@cygbert.vinschen.de> <3.0.5.32.20021117224418.0083ac70@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20021117224418.0083ac70@mail.attbi.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q4/txt/msg00159.txt.bz2

On Sun, Nov 17, 2002 at 10:44:18PM -0500, Pierre A. Humblet wrote:
> Corinna,
> 
> Almost same as last week, but with the diff and ChangeLog against current CVS.
> I also made a small change.
> [...]

Some questions and comments:

> 
> 	* security.h: [...]. Undeclare internal_getpwent.
                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^
			     You didn't.

> 	* passwd.cc (getpwsid): Create.
> 	(internal_getpwent): Suppress.
> 	(read_etc_passwd): Make static. Rewrite the code for the completion
> 	line. Set curr_lines to 0.
> 	(parse_pwd): Change type to static int. Return 0 for short lines.
> 	(add_pwd_line): Pay attention to the value of parse_pwd.     
> 	(search_for): Do not look for nor return the DEFAULT_UID.
> 	* grp.cc (read_etc_group): Make static. Free gr_mem and set 
> 	curr_lines to 0. Always call add_pwd_line. Rewrite the code for the 
> 	completion line.
> 	(parse_grp): If grp.gr_mem is empty, set it to &null_ptr.
> 	Never NULL gr_passwd. 
> 	(getgrgid32): Only return the default if ntsec is off and the gid is 
> 	ILLEGAL_GID.
> 	* sec_helper.cc (cygsid::get_id): Use getpwsid and getgrsid;
> 	(cygsid_getfrompw): Clean up last line.
> 	(cygsid_getfromgr): Ditto.
> 	(is_grp_member): Use getpwuid32 and getgrgid32.
> 	* uinfo.cc (internal_getlogin): Set DEFAULT_GID at start.
> 	Use getpwsid. Move the read of /etc/group after the second access 
> 	of /etc/passwd. Change some debug_printf. 

> -/* FIXME: should be static but this is called in uinfo_init outside this
> -   file */
> -void
> +static void
>  read_etc_group ()

Do I miss something?  I don't see that in this patch.

> @@ -150,76 +145,74 @@ read_etc_group ()
>    if (group_state != initializing)
>      {
>        group_state = initializing;
> +      for (int i = 0; i < curr_lines; i++)
> +	if ((group_buf + i)->gr_mem != &null_ptr)
> +	  free ((group_buf + i)->gr_mem);
> +
> +      curr_lines = 0;
>        if (gr.open ("/etc/group"))
>  	{
>  	  char *line;
>  	  while ((line = gr.gets ()) != NULL)
> -	    if (strlen (line))
> -	      add_grp_line (line);
> +            add_grp_line (line);
> 
>  	  group_state.set_last_modified (gr.get_fhandle (), gr.get_fname ());
> -	  group_state = loaded;
>  	  gr.close ();
>  	  debug_printf ("Read /etc/group, %d lines", curr_lines);
>  	}
> -      else /* /etc/group doesn't exist -- create default one in memory */
> -	{
> -	  char group_name [UNLEN + 1];
> -	  DWORD group_name_len = UNLEN + 1;
> -	  char domain_name [INTERNET_MAX_HOST_NAME_LENGTH + 1];
> -	  DWORD domain_name_len = INTERNET_MAX_HOST_NAME_LENGTH + 1;
> -	  SID_NAME_USE acType;
> +
> +      /* Complete /etc/group in memory if needed */
> +      if (!getgrgid32 (myself->gid))
         
?!? How is that supposed to work?  We're in group_state==initializing,
therefore in getgrgid32(), read_etc_group() is called.  Isn't that
somewhat dangerous?

> +	      cygheap->user.groups.pgsid.string (strbuf);
> +	      if (!(gr = getgrsid (cygheap->user.groups.pgsid)))
> +	        {
> +		  if (!LookupAccountSidA (NULL, cygheap->user.groups.pgsid,
> +					  group_name, &group_name_len,
> +					  domain_name, &domain_name_len,
> +					  &acType))
> +		    debug_printf ("Failed to get primary group name. %E");

Didn't you propose to get rid of the LookupAccountSidA() calls?

> -  return allow_ntsec ? NULL : default_grp;
> +  return (!allow_ntsec && gid == ILLEGAL_GID)?default_grp:NULL;

I'd better like

     return allow_ntsec || gid != ILLEGAL_GID ? NULL : default_grp;


>  extern "C" struct __group16 *
> @@ -482,13 +474,9 @@ setgroups32 (int ngroups, const __gid32_
>        for (int gidy = 0; gidy < gidx; gidy++)
>  	if (grouplist[gidy] == grouplist[gidx])
>  	  goto found; /* Duplicate */
> -      for (int gidy = 0; (gr = internal_getgrent (gidy)); ++gidy)
> -	if (gr->gr_gid == (__gid32_t) grouplist[gidx])
> -	  {
> -	    if (gsids.addfromgr (gr))
> -	      goto found;
> -	    break;
> -	  }
> +      if ((gr = getgrgid32 (grouplist[gidx])) &&

Ahem, I thought we agreed that we don't call external functions from
inside Cygwin?  Never mind, there are still some of them which we have
to eliminate, anyway.

> @@ -208,24 +190,17 @@ is_grp_member (__uid32_t uid, __gid32_t
>      }
> 
>    /* Otherwise try getting info from examining passwd and group files. */
> -  for (int idx = 0; (pw = internal_getpwent (idx)); ++idx)
> -    if ((__uid32_t) pw->pw_uid == uid)
> -      {
> -	/* If gid == primary group of uid, return immediately. */
> -	if ((__gid32_t) pw->pw_gid == gid)
> -	  return TRUE;
> -	/* Otherwise search for supplementary user list of this group. */
> -	for (idx = 0; (gr = internal_getgrent (idx)); ++idx)
> -	  if ((__gid32_t) gr->gr_gid == gid)
> -	    {
> -	      if (gr->gr_mem)
> -		for (idx = 0; gr->gr_mem[idx]; ++idx)
> -		  if (strcasematch (cygheap->user.name (), gr->gr_mem[idx]))
> -		    return TRUE;
> -	      return FALSE;
> -	    }
> -        return FALSE;
> -      }
> +  if ((pw = getpwuid32 (uid)))

Same here.  Somehow it's a step in the wrong direction...

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
