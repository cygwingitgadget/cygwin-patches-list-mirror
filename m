Return-Path: <cygwin-patches-return-3179-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11208 invoked by alias); 15 Nov 2002 09:50:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11085 invoked from network); 15 Nov 2002 09:50:03 -0000
Date: Fri, 15 Nov 2002 01:50:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: ntsec patch 1: uid==gid, chmod, alloc_sd, is_grp_member
Message-ID: <20021115105000.A24928@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20021113135916.Q10395@cygbert.vinschen.de> <3DD27B59.3FA8990@ieee.org> <3.0.5.32.20021113223509.0082c960@mail.attbi.com> <20021114110340.G10395@cygbert.vinschen.de> <3DD3B369.A530D7EE@ieee.org> <20021114173630.A20639@cygbert.vinschen.de> <3DD3D75C.99C07A78@ieee.org> <20021114182323.L10395@cygbert.vinschen.de> <20021114202105.N10395@cygbert.vinschen.de> <3.0.5.32.20021114220454.0082ca20@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20021114220454.0082ca20@mail.attbi.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q4/txt/msg00130.txt.bz2

On Thu, Nov 14, 2002 at 10:04:54PM -0500, Pierre A. Humblet wrote:
> Great! Here are my patches. I think they are as we agreed on.
> 
> Pierre

Sorry, I still have some problems:

>  	}
>      }
>    *attribute &= ~(S_IRWXU | S_IRWXG | S_IRWXO | S_ISVTX | S_ISGID | S_ISUID);
> +  if (owner_sid && group_sid && EqualSid (owner_sid, group_sid))
> +    {
> +      allow &= ~(S_IRGRP | S_IWGRP | S_IXGRP);
> +      allow |= (((allow & S_IRUSR) ? S_IRGRP : 0)
> +		| ((allow & S_IWUSR) ? S_IWGRP : 0)
> +		| ((allow & S_IXUSR) ? S_IXGRP : 0));
> +    }
>    *attribute |= allow;
> -  *attribute &= ~deny;
>    return;
>  }
> 

I found that this change had an unpredictable result.  sshd refused to
start:

  Bad owner or mode for /var/empty

Looking for the modes.  Before that change:

  drwxr-xr-x    2 SYSTEM   SYSTEM          0 Jul  7 11:39 /var/empty

With that patch:

  drwxrwxr-x    2 SYSTEM   SYSTEM          0 Jul  7 11:39 /var/empty

I'm not against the patch since it reflects the permissions obviously
better than the old version.  However, how many people are running
sshd now with the above /var/empty settings.  Urgh.

I only see two choices:
- Let it as it is now.
- Force all people with a running sshd installation to chmod 544
  /var/empty.

> @@ -1664,18 +1666,25 @@ alloc_sd (__uid32_t uid, __gid32_t gid,
>        if (attribute & S_ISVTX)
>  	null_allow |= FILE_READ_DATA;
>      }
> -
> -  /* Construct deny attributes for owner and group. */
> -  DWORD owner_deny = 0;
> -  if (is_grp_member (uid, gid))
> -    owner_deny = ~owner_allow & (group_allow | other_allow);

Erm... that's not exactly what we agreed upon...

> +
> +  /* Add owner and group permissions if SIDs are equal
> +     and construct deny attributes for group and owner. */
> +  DWORD group_deny;
> +  if (owner_sid == group_sid)
> +    {
> +      owner_allow |= group_allow;
> +      group_allow = group_deny = 0L;
> +    }

And this change will produce the above sshd problem for any new user
calling ssh-host-config.

>  	  if (!AddAce (acl, ACL_REVISION,
>  		       ace->Header.AceType == ACCESS_DENIED_ACE_TYPE ?
> -		       (owner_deny ? 1 : 0) : MAXDWORD,
> +		       ace->Mask & owner_allow ? owner_off + 1 : owner_off++
> +		       : MAXDWORD,
>  		       (LPVOID) ace, ace->Header.AceSize))

After applying the patch to my local sandbox I found that I'm still
having problems here.  While I see the advantage for emulating POSIX
permissions closer, I also see that the probability is pretty high
that all unrelated deny ACEs will be placed after the owner_allow
(which probably has most bits set).  This doesn't really support the
wish to produce ACLs in canonical order.  So far, only the group_deny
could possibly but unlikely be placed after the owner_allow...

Corinna


-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
