Return-Path: <cygwin-patches-return-3155-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8194 invoked by alias); 12 Nov 2002 15:55:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8185 invoked from network); 12 Nov 2002 15:55:12 -0000
Date: Tue, 12 Nov 2002 07:55:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: ntsec patch 1: uid==gid, chmod, alloc_sd, is_grp_member
Message-ID: <20021112165510.G10395@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q4/txt/msg00106.txt.bz2

Hi Pierre,

On Wed, 06 Nov 2002 11:28:30 -0500, Pierre A. Humblet wrote:
> Note that is_grp_member is expensive: a passwd scan + getting the token
> groups in a malloc'ed structure. I am wondering if the effort is
> justified, considering that it is useless when the ACL is built by
> Cygwin (because Cygwin will put an access denied ACE if needed).

basically the function has been designed to help acl_access (the
implementation of access(2) when ntsec is on, see sec_acl.cc).
I looked into that implementation and there it's called always with
the correct (own) uid.

> This raises a basic issue: What is get_attribute_from acl trying to 
> accomplish? I can see several answers:
> A) For "other" and "group", have "modes" report the true access rights
>    A1) if the ACL was built by Cygwin
>    A2) all the time.
> I believe we can easily do A2.
> 
> B) For "user", have "modes" report the true access rights
>    B1) if the ACL was built by Cygwin
>    B2) if the file uid is the current euid
>    B3) all the time
> The patch stands somewhere between B1 and B2 (we don't take all the
> group ACE in consideration, only the gid). Should we reduce to B1 
> (by removing is_grp_member completely)
> or extend to B2 (perhaps by using AccessCheck)?
> Doing B3 would require looking up the PDC etc..,  not recommended. 

I don't understand.  get_attribute_from_acl() creates a UNIX mode from
the ACL.  It gets the owner and group SID as input so it just creates
the UNIX permission bits from the ACL according to the way they are
interpreted by NT.  What is the exact problem?  Somehow I'm missing
that. 

> Although I didn't do it, I would remove is_grp_member completely.
> If it is kept, the output of stat and "ls -l" can depend on the sid 
> of the user running the command. That's undesirable.

It's just a flaw in is_grp_member() but it's still needed to get the
information about the group membership.  is_grp_member() shouldn't check
the current token if the uid isn't myself->uid but otherwise it's ok.

> If we keep is_grp_member I will optimize the call flow to remove
> the passwd scan.

The passwd scan is still needed if uid != myself->uid.

So I think this change to get_nt_{object_}attribute() and alloc_sd()
is incorrect.  It must be substituted by a refined implementation of
is_grp_member() instead.

I'm sorry but I can't apply the security.cc and (just as a result)
syscalls.cc patch as is.  I think it needs some rework or, at least,
some further discussion:

> --- security.cc.orig	2002-10-22 22:18:40.000000000 -0400
> +++ security.cc	2002-10-26 17:35:18.000000000 -0400
> @@ -449,7 +449,7 @@ get_user_primary_group (WCHAR *wlogonser
>    BOOL retval = FALSE;
>    UCHAR count = 0;
> 
> -  if (pusersid == well_known_system_sid)
> +  if (well_known_system_sid == pusersid)
>      {
>        pgrpsid = well_known_system_sid;
>        return TRUE;
> @@ -540,7 +540,7 @@ get_initgroups_sidlist (cygsidlist &amp;grp_
>  { 
>    grp_list += well_known_world_sid;
>    grp_list += well_known_authenticated_users_sid;
> -  if (usersid == well_known_system_sid)
> +  if (well_known_system_sid == usersid)
>      {
>        auth_pos = -1; 
>        grp_list += well_known_admins_sid;

Why are you turning around the order of the conditionals?  I don't see
a reason.

> @@ -1266,31 +1264,37 @@ get_attribute_from_acl (int * attribute,
>  	  if (ace->Mask & FILE_APPEND_DATA)
>  	    *flags |= S_ISUID;
>  	}
> -      else if (owner_sid && ace_sid == owner_sid)
> +      else if (ace_sid == owner_sid)
> [...]
> -      else if (group_sid && ace_sid == group_sid)
> +      else if (ace_sid == group_sid)
> [...]
>    *attribute &= ~(S_IRWXU | S_IRWXG | S_IRWXO | S_ISVTX | S_ISGID | S_ISUID);
> +  if (owner_sid && group_sid && EqualSid (owner_sid, group_sid))

Why are you checking owner_sid && group_sid for non-NULL here while
removing these checks in the lines before?

> +    {
> +      allow &= ~(S_IRGRP | S_IWGRP | S_IXGRP);

This line is essentially superfluous.  It's job has been done two lines
before.

> @@ -1347,7 +1351,7 @@ get_nt_attribute (const char *file, int 
>        return 0;
>      }
>  
> -  BOOL grp_member = is_grp_member (uid, gid);
> +  BOOL grp_member = (myself->uid == uid ) && is_grp_member (uid, gid);

As discussed above, I don't think we can drop the call.  It's is_grp_member()
which needs some tweaks instead.

> @@ -1438,7 +1442,7 @@ get_nt_object_attribute (HANDLE handle, 
>        return 0;
>      }
>  
> -  BOOL grp_member = is_grp_member (uid, gid);
> +  BOOL grp_member = (myself->uid == uid ) && is_grp_member (uid, gid);

Ditto.

> @@ -1522,52 +1526,56 @@ alloc_sd (__uid32_t uid, __gid32_t gid, 
>  {
>    BOOL dummy;
>  
> -  if (!wincap.has_security ())
> -    return NULL;
> -

Why do you remove this check?  It's still needed when called by
set_security_attribute().  Or set_security_attribute() needs that check.

> -      if (!pw)
> -	{
> -	  debug_printf ("no /etc/passwd entry for %d", uid);
> -	  set_errno (EINVAL);
> -	  return NULL;
> -	}

Why do you remove this check?  It's still an interesting info, isn't it?

> -  owner_sid.debug_print ("alloc_sd: owner SID =");

And this one?

>    /* Get SID of new group. */
>    cygsid group_sid (NO_SID);
>    /* Check for current user first */
>    if (gid == myself->gid)
>      group_sid = cygheap->user.groups.pgsid;
> +  else if (uid == ILLEGAL_GID)
              ^^^
              ???
You don't mean it, do you?

> @@ -1664,18 +1672,25 @@ alloc_sd (__uid32_t uid, __gid32_t gid, 
>        if (attribute & S_ISVTX)
>  	null_allow |= FILE_READ_DATA;
>      }
> -
> -  /* Construct deny attributes for owner and group. */
> -  DWORD owner_deny = 0;
> -  if (is_grp_member (uid, gid))
> -    owner_deny = ~owner_allow & (group_allow | other_allow);

As I said, we can't remove this.

> @@ -1729,20 +1747,22 @@ alloc_sd (__uid32_t uid, __gid32_t gid, 
>  	{
>  	  cygsid ace_sid ((PSID) &ace->SidStart);
>  	  /* Check for related ACEs. */
> -	  if ((cur_owner_sid && ace_sid == cur_owner_sid)
> -	      || (owner_sid && ace_sid == owner_sid)
> -	      || (cur_group_sid && ace_sid == cur_group_sid)
> -	      || (group_sid && ace_sid == group_sid)
> +	  if ((ace_sid == cur_owner_sid)
> +	      || (ace_sid == owner_sid)
> +	      || (ace_sid == cur_group_sid)
> +	      || (ace_sid == group_sid)
>  	      || (ace_sid == well_known_world_sid)
>  	      || (ace_sid == well_known_null_sid))
>  	    continue;
>  	  /*
> -	   * Add unrelated ACCESS_DENIED_ACE to the beginning but
> -	   * behind the owner_deny, ACCESS_ALLOWED_ACE to the end.
> +	   * Add unrelated ACCESS_DENIED_ACE to the beginning,
> +	   * preferrably before the owner_allowed ACE,
> +	   * ACCESS_ALLOWED_ACE to the end.
>  	   */
>  	  if (!AddAce (acl, ACL_REVISION,
>  		       ace->Header.AceType == ACCESS_DENIED_ACE_TYPE ?
> -		       (owner_deny ? 1 : 0) : MAXDWORD,
> +		       ace->Mask & owner_allow ? owner_off + 1 : owner_off++ 

Could you explain how that should work?  I'm not sure about that.
owner_off is the position of the owner_allow ACE.  Since the above
test already filters all related ACEs, the incoming ACE is unrelated
to the owner entry.  So why do you check the content of the ACE
against the bits set in the owner_allow mask?!?

> @@ -967,7 +946,7 @@ chmod (const char *path, mode_t mode)
>        else
>  	{
>  	  /* Correct NTFS security attributes have higher priority */
> -	  if (res == 0 || !allow_ntsec)
> +	  if (!allow_ntsec)
>  	    res = 0;
>  	}
>      }

That's actually weird.  I changed that immediately in CVS.
I checked the sec_helper.cc and security.h changes in, too.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
