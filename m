From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: the order of ACEs.
Date: Wed, 25 Apr 2001 14:09:00 -0000
Message-id: <20010425230939.K30677@cygbert.vinschen.de>
References: <s1sr8ygol8l.fsf@jaist.ac.jp>
X-SW-Source: 2001-q2/msg00163.html

On Thu, Apr 26, 2001 at 04:03:22AM +0900, Kazuhiro Fujieda wrote:
> The `alloc_sd' puts inherited ACCESS_ALLOWED_ACEs in front of
> the `everyone' ACE. It always breaks the rule of the order of
> ACEs specified in the Platform SDK Document quoted below.
> 
>    To ensure that non-inherited ACEs have precedence over
>    inherited ACEs, place all non-inherited ACEs in a group
>    before any inherited ACEs.
> 
> I believe it causes no problem to put unrelated ALLOWED_ACEs
> behind the `everyone' ACE.  Because the system can try the
> `everyone' ACE even if a restricted ALLOWED_ACE doesn't allow
> an access in front of it.
> 
> If so, the following patch can decrease the cases where the
> Access Control Editor complains about the order of ACEs.

I follow your description but...

> @@ -661,13 +665,7 @@ alloc_sd (uid_t uid, gid_t gid, const ch
>  	      return NULL;
>  	    }
>  	  acl_len += ace->Header.AceSize;
> -	  ++ace_off;

...why does your patch drop the `++ace_off'? This seems to be
a mistake.

>  	}
> -
> -  /* Set allow ACE for everyone. */
> -  if (!add_access_allowed_ace (acl, ace_off++, other_allow,
> -				get_world_sid (), acl_len, inherit))
> -    return NULL;
>  
>    /* Set AclSize to computed value. */
>    acl->AclSize = acl_len;

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
